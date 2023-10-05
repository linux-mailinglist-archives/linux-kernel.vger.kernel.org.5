Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D57BA34D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjJEPx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJEPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9116A78;
        Thu,  5 Oct 2023 08:12:13 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-024.ewe-ip-backbone.de [91.248.132.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD63F660732E;
        Thu,  5 Oct 2023 16:12:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696518732;
        bh=7HcjV56Wdx2jVQo6+tXHe5Jd8Cre7FRGtAeizbopYJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYndyPL+Ng1u7wjEJau3B+Q4BS0YIB3UgoXrE5AEDcaSWWziEOoC2H2ZUN3wKBV+a
         yUYI3bBjgk+9ZypyfVsm/zj3SEdxWIMTtvbkusSi88kQpyCF+84XYvAJat5tvLWRfT
         dr3tt0WEeK/QQeWtoVLudG13HPG/7CJrOgOTpP4VRJsp9KW/z2WuYO3pco49iNa4aP
         8G3uT7IPDRTeNhAnTEuEqa+06TGlcuzb1rnhLwgeEhXwjpdC0cTUtwsNuqClqfAFII
         xUKw2kb81rjuoFD0arxMkxF2OXev/l6rUG/km44eS6Scn1bE3hnX65wClseBSV9rGe
         yen69inaH2wzQ==
Received: by mercury (Postfix, from userid 1000)
        id 7B5F6106045C; Thu,  5 Oct 2023 17:12:10 +0200 (CEST)
Date:   Thu, 5 Oct 2023 17:12:10 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: rk3588is: Add AV1 decoder node
Message-ID: <20231005151210.nqdx2uoixqjhrtrx@mercury.elektranox.org>
References: <20231005145420.169594-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ceanalih5k4ck3c7"
Content-Disposition: inline
In-Reply-To: <20231005145420.169594-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ceanalih5k4ck3c7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 05, 2023 at 04:54:20PM +0200, Benjamin Gaignard wrote:
> Add node for AV1 video decoder.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

No need for my SoB. Instead have this one:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Also worth mentioning, that this Patch needs one small fix in the DT
binding (adding "resets") and one small fix in the driver for out of
the box AV1 support:

https://lore.kernel.org/all/20231005144934.169356-1-benjamin.gaignard@colla=
bora.com/
https://lore.kernel.org/all/20231005145116.169411-1-benjamin.gaignard@colla=
bora.com/

Greetings,

-- Sebastian

> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/=
dts/rockchip/rk3588s.dtsi
> index 5544f66c6ff4..835e66d85d5f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -2304,6 +2304,20 @@ gpio4: gpio@fec50000 {
>  			#interrupt-cells =3D <2>;
>  		};
>  	};
> +
> +	av1d: av1d@fdc70000 {
> +		compatible =3D "rockchip,rk3588-av1-vpu";
> +		reg =3D <0x0 0xfdc70000 0x0 0x800>;
> +		interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names =3D "vdpu";
> +		clocks =3D <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> +		clock-names =3D "aclk", "hclk";
> +		assigned-clocks =3D <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> +		assigned-clock-rates =3D <400000000>, <400000000>;
> +		resets =3D <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>=
, <&cru SRST_P_AV1_BIU>;
> +		power-domains =3D <&power RK3588_PD_AV1>;
> +		status =3D "okay";
> +	};
>  };
> =20
>  #include "rk3588s-pinctrl.dtsi"
> --=20
> 2.39.2
>=20

--ceanalih5k4ck3c7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUe0j0ACgkQ2O7X88g7
+po6gA//Wb0enkCVGQ9jtP43nB3ooBioMqf6NhopmzyPxzdF59vsIcVnW3Qh/jsP
5UQq2N9Kx+xXWbGnqpsOxIRqkQi3I6D4LavSPkU1PhO97VIX6VucCR6rRQ9ZyTEo
/MhIOziVQ3Nb71q9EIN7t+1losh4WwT3aP48oXq/igPgpYnYfeCPPkGF3W61McqK
U4ifjucb0EZ9wF6nLTpCBqrODSpzJxdAjc15wFQGM2srZTsVTLQGq/xVfkXe/fH8
s8WFgwi9DwM1Kv2tZe4QuW80rmklW85f9HVf1aPTS9yOX8RqvxMbKih7GcJYe+v/
SnlCpxfZl8b+74+9yHAs6ZwT6yD25vY8IArtKyuyw6gRexJHcqkRiGGX6JRbimT3
P35OfmAO41PjZTm+Xiwtj/DJ/8LQvXp0TWIWSYq4lPc0yNvT8XlgDwJt5GFgZyZI
gQjNx4z2F4airWowri0EUPzkiW+BdSRIvZ53/n4qmR0HpfZGtM1wYlkHnTJYE2yA
Qhyfp+bujHDcMnSicFZyUwB7Y+774XdGJrcKiaY5E5mrboBDwiQJpMvnpcWn+CkJ
6/Gv+5Q18CLj3JB1xyexvVNr8nWRbhbtVZOPkgxILGfoyLZ1h9FnqfDXT+bCIEqP
5HiVa3OCcD5e+uVaVga71Vdc0LIk0D14XRXxEtqkHIASZtx0NnI=
=Kfpg
-----END PGP SIGNATURE-----

--ceanalih5k4ck3c7--
