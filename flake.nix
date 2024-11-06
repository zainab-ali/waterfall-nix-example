{
  inputs = {
    nixpkgs.url = "github:zainab-ali/nixpkgs/fix-opencascade-hs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowBroken = true;
        };
        example = import ./default.nix { inherit pkgs; };
      in {
        devShell = pkgs.mkShell { buildInputs = [ pkgs.nixfmt ]; };
        packages.default = example;
        formatter = pkgs.nixfmt;
      });
}
