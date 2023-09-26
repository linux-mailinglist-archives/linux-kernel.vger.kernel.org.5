Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED01F7AE74F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjIZIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjIZIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:04:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F202710E;
        Tue, 26 Sep 2023 01:04:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B023EC433C8;
        Tue, 26 Sep 2023 08:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695715444;
        bh=Gk8UPv85NpIAuRUm/g1FxXwc/A9EC198ra1ZI3l3y+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2CxJOqPE3nULReRB6ueRzPUzLpG0HduGqLQMB0peveb97gyS0glSpsfF/OfzpYSK
         FtKFoAboDI/Wl31DYCEJNH6MJwo2lSENM8wLT/hEf+bzbwDajk7F3Z+/7afgxKP8+t
         8HLSDlYyxmyfYmjUleCNSg0SjLRSaSqubaqV49fJbCMBU6tTD8GTdpTLQuY+18SkcS
         FiaXCSorr5u2AEdAs1yXGjOyqL98yQX0TOORNHULtuuEU8by8vwSNCZY9y1qW5kfYo
         DDRKhdJuUgvkNI7oHJFs2R9ba4ixOaxRbcHRAVaJAygr3p8ohvuh/wgFRbxq57jtZA
         hW71Nb5MESBuA==
Date:   Tue, 26 Sep 2023 09:03:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm64: dts: Add watchdog node for Amlogic C3 SoCs
Message-ID: <20230926-output-musket-a43dd5abd0b5@spud>
References: <20230926055512.2355390-1-huqiang.qin@amlogic.com>
 <20230926055512.2355390-3-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/h6xUWSBVS6sbE34"
Content-Disposition: inline
In-Reply-To: <20230926055512.2355390-3-huqiang.qin@amlogic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/h6xUWSBVS6sbE34
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 01:55:12PM +0800, Huqiang Qin wrote:
> Add watchdog device.
>=20
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>=20
> V1 -> V2: Increase compatibles of C3 watchdog.
>=20
>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boo=
t/dts/amlogic/amlogic-c3.dtsi
> index 998f5050795c..2ad1f8eef199 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -81,6 +81,12 @@ apb4: bus@fe000000 {
>  			#size-cells =3D <2>;
>  			ranges =3D <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> =20
> +			watchdog@2100 {
> +				compatible =3D "amlogic,c3-wdt", "amlogic,t7-wdt";

Does this pass dtbs_check?
The binding patch doesn't seem to permit this combo..

> +				reg =3D <0x0 0x2100 0x0 0x10>;
> +				clocks =3D <&xtal>;
> +			};
> +
>  			periphs_pinctrl: pinctrl@4000 {
>  				compatible =3D "amlogic,c3-periphs-pinctrl";
>  				#address-cells =3D <2>;
> --=20
> 2.42.0
>=20

--/h6xUWSBVS6sbE34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRKQbwAKCRB4tDGHoIJi
0inUAPwLNBh3Grd1kaNeXqiBtQPj8KCHNGRCyoENBGkom8ZsewEApURp1rXmTzcy
YTPySsifKx2BM9nMc5YyQIuMhDpgGg0=
=mVVI
-----END PGP SIGNATURE-----

--/h6xUWSBVS6sbE34--
