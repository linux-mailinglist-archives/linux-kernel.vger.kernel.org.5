Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCE75DBF7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGVLmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD20269F;
        Sat, 22 Jul 2023 04:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56CBD60766;
        Sat, 22 Jul 2023 11:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F24C433C7;
        Sat, 22 Jul 2023 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690026134;
        bh=f2yHgyUaKA3l10ITzTIYa5o+ZSTULlacczfrf3CBjeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GUbm8Cn+BV+1ejDdslO+FIrdGjx5mNih14qUGX7PapjMVkxNQnyVpxwLSVTuI7J0p
         8qdX/tTHgtsRSA2k1nAxSuRjs4J7cUBnnzB/G7juyFg+qoBG6cjSdggKBmA+s+l4k1
         Z6nZQBMYZrwAg6UiHQCyi967ogugQdX1K1iXk1ayNpDgjKB7iQ0maA56Sa9OYcCwC4
         c6uekhJbp05nk54YGW4sxHr7j0mGN6Wv3FyFSCjjaXELAycT3A+ETP9NkEDe2hHBxh
         IbUSxzb+6ezZwLlzby7fLc3cmiLTXGpjAdSqZhV741co27rg0gkrW+PdIAtym+7egW
         ANs03ebYetOfQ==
Date:   Sat, 22 Jul 2023 12:42:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: add rk3588 compatible to
 rockchip,dwc3
Message-ID: <20230722-coleslaw-breeder-40827e23f717@spud>
References: <20230720173643.69553-1-sebastian.reichel@collabora.com>
 <20230720173643.69553-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tUpYr2IqJ0mUbeeo"
Content-Disposition: inline
In-Reply-To: <20230720173643.69553-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tUpYr2IqJ0mUbeeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 07:36:41PM +0200, Sebastian Reichel wrote:
> RK3588 has three DWC3 controllers. Two of them are fully functional in
> host, device and OTG mode including USB2 support. They are connected to
> dedicated PHYs, that also support USB-C's DisplayPort alternate mode.
>=20
> The third controller is connected to one of the combphy's shared
> with PCIe and SATA. It can only be used in host mode and does not
> support USB2. Compared to the other controllers this one needs
> some extra clocks.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I feel like I say it a bunch for some of these Rockchip bindings
patches, but if you're adding more clocks for some SoCs, should some
per-SoC constraints not also be added?

> ---
>  .../devicetree/bindings/usb/rockchip,dwc3.yaml        | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/D=
ocumentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> index 291844c8f3e1..cbc3e55e05e1 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> @@ -30,6 +30,7 @@ select:
>          enum:
>            - rockchip,rk3328-dwc3
>            - rockchip,rk3568-dwc3
> +          - rockchip,rk3588-dwc3
>    required:
>      - compatible
> =20
> @@ -39,6 +40,7 @@ properties:
>        - enum:
>            - rockchip,rk3328-dwc3
>            - rockchip,rk3568-dwc3
> +          - rockchip,rk3588-dwc3
>        - const: snps,dwc3
> =20
>    reg:
> @@ -58,7 +60,9 @@ properties:
>            Master/Core clock, must to be >=3D 62.5 MHz for SS
>            operation and >=3D 30MHz for HS operation
>        - description:
> -          Controller grf clock
> +          Controller grf clock OR UTMI clock
> +      - description:
> +          PIPE clock
> =20
>    clock-names:
>      minItems: 3
> @@ -66,7 +70,10 @@ properties:
>        - const: ref_clk
>        - const: suspend_clk
>        - const: bus_clk
> -      - const: grf_clk
> +      - enum:
> +          - grf_clk
> +          - utmi
> +      - const: pipe
> =20
>    power-domains:
>      maxItems: 1
> --=20
> 2.40.1
>=20

--tUpYr2IqJ0mUbeeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLvAkQAKCRB4tDGHoIJi
0kKYAQCiO80QFj97obJkn31yMX+NIi1z75tVqo+ogU5Kw2ikbgEA/CV6Gur4Ravl
AlQ9PLxs1TY8cb9aF1himnHOGQeBDwE=
=5k0e
-----END PGP SIGNATURE-----

--tUpYr2IqJ0mUbeeo--
