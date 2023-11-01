Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10887DE37F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjKAPRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjKAPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:17:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30A1A3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:16:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BB8C433C9;
        Wed,  1 Nov 2023 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851815;
        bh=Ti93Sl0y1+/KdodBJQqgUAuD2hxTp2zRLxiqbtXZpvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeZKcxjO0b0GDkMbx2qZx+3MVRDq4xOrqUdQKYFFkHPefdKlzlci6l/Ti3lJpRr9L
         29ZVJcDuNVvqEefrtFQtBkDWvmE5/lDle21Pm2ReRzJoDJX+90aoSU5QOwbJI/j8Om
         TT2Tnd029bdTAEXiSA3uqoKZKaF7ddNBqdzrRPcOvrv8HxPeuJGzs2BuXsbDhxi32T
         hHQjra5LD0nyBg4zTh2ZHsYCSghoaYcpgkcV5bB30Oum/vbZzjTbl1I1ZgnMzw3GIZ
         /2oDHwsqPLYX0rACfCcOiTOZDXnaOE7tDyXKywFQg+RqTmX2IX05ZU67h264+TYzg0
         LQi4jpzZM7nuw==
Date:   Wed, 1 Nov 2023 15:16:50 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: imx8mn-rve-gateway: add support for RVE
 gateway board
Message-ID: <20231101-nebulizer-lasso-a901cd564dd1@spud>
References: <20231101144303.2653464-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FsR/i9tL1//uke2c"
Content-Disposition: inline
In-Reply-To: <20231101144303.2653464-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FsR/i9tL1//uke2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 10:43:02AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> The RVE gateway board is based on a Variscite VAR-SOM-NANO,
> with a NXP MX8MN nano CPU.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mn-rve-gateway.dts | 296 ++++++++++++++++++
>  4 files changed, 305 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 9450b2c8a678..a1028fe8ed02 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1007,6 +1007,7 @@ properties:
>                - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
>                - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
>                - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
> +              - rve,rve-gateway           # i.MX8MN RVE Gateway Board
>            - const: fsl,imx8mn

Changes to dt-bindings should be in their own patch. Did checkpatch not
whinge about this?

Cheers,
Conor.

--FsR/i9tL1//uke2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJr4gAKCRB4tDGHoIJi
0hJeAP4yPfhlHJ215vgRPFBYt2Fcr+zuyZOTHrBzdkh5b4+ciQD+N/YqfkXZ9SKj
0l+NSpkEgvh+kgVCZGIlWdx21zA7rQ0=
=iwUT
-----END PGP SIGNATURE-----

--FsR/i9tL1//uke2c--
