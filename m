Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F47CB158
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjJPRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjJPRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:30:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC8CE6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:30:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F00C433C7;
        Mon, 16 Oct 2023 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697477418;
        bh=GpeYS7W+QOHnKL9KvaNin7WOIs87VzXBHY68R4EuxOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWi5UtGLX5OiupKPagSbadl9W/hpoMnJjLJpT39aTyFP1o6H3ZWHGfEx4sCsPYKg6
         lff/tE1oun/D/dp8UONbZWMGioqvZMxPHa6PUGvd4kp2orzQ7qPb8fdBvQp/urPnwi
         6ZrPMHAQWk4RdC2a/Nlh3y66MEgfdbXbMQr7F9Y8ep65UHJw0ff7Nv83jbqqK8XPVE
         YvPUUtIHtsrzP3zbggjAPNLQW5DE+nE7tx/ydOVsYYDZi6TW1XDcM5tCatq/YpFNfG
         +BO4kQ5ka5FCPGBWjWQ0XVU5hklssx5MfX1Qjcm90cCu+beoR+m2iFKx3lVpeHZP/9
         hSdqs3y3MIIAA==
Date:   Mon, 16 Oct 2023 18:30:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, joe@perches.com,
        peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        haibo.chen@nxp.com, ping.bai@nxp.com, xiaoning.wang@nxp.com,
        sherry.sun@nxp.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: i3c: Fix silvaco,i3c-master compatible
 string
Message-ID: <20231016-chatroom-regulator-a75f1d8be809@spud>
References: <20231016152450.2850498-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8ov1p1bhS36bcpal"
Content-Disposition: inline
In-Reply-To: <20231016152450.2850498-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8ov1p1bhS36bcpal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 11:24:49AM -0400, Frank Li wrote:
> In driver, compatible string is silvaco,i3c-master instead of
> silvaco,i3c-master-v1.

And what makes the driver right & the binding wrong? AFAICT, this is an
IP sold by silvaco & the -v1 suffix was explicitly requested during
review of the binding.

Thanks,
Conor.

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yam=
l b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> index 133855f11b4f..19e3f75eb45c 100644
> --- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> @@ -14,7 +14,7 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: silvaco,i3c-master-v1
> +    const: silvaco,i3c-master
> =20
>    reg:
>      maxItems: 1
> @@ -49,7 +49,7 @@ unevaluatedProperties: false
>  examples:
>    - |
>      i3c-master@a0000000 {
> -        compatible =3D "silvaco,i3c-master-v1";
> +        compatible =3D "silvaco,i3c-master";
>          clocks =3D <&zynqmp_clk 71>, <&fclk>, <&sclk>;
>          clock-names =3D "pclk", "fast_clk", "slow_clk";
>          interrupt-parent =3D <&gic>;
> --=20
> 2.34.1
>=20

--8ov1p1bhS36bcpal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS1zIwAKCRB4tDGHoIJi
0n52AP40LdahncQIBrlmquA9d27bYIZbq2UevD1+ijXUlaBdaAEAhYr4fgRjvJxx
Lr+TH3PlrbTOEzDsaF/mY4qqOSnkjgU=
=Nlun
-----END PGP SIGNATURE-----

--8ov1p1bhS36bcpal--
