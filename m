Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0C7EF3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbjKQNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKQNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:19:45 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF5E0;
        Fri, 17 Nov 2023 05:19:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99FF4E0003;
        Fri, 17 Nov 2023 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700227179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FoBJqFPZps/IfTWChc3pHLcKO0nSjgo4MRL5iaSeOk0=;
        b=PjQ2pSJdu9x5ihXwMQAH4DLve4Tq7tBDAn/SBjaOXh+lKzC1L0Gi7wEMV113BVBWXN89UT
        VuqQ2p9jKeGm0lNWjmCwz8AdmfozHIOGZa2yo6iPNuKhP5vRU18squYOBVZKjux2WM0izA
        xeGzy3J8mwq8OQ6oHTGIFIgnut/z8z1DSbiTzJi6fmYogiM2GpYqHtWmroebymlEjBn1NO
        d45wq6H8ND0urpxOnyU7c/aIKyGq11Sg6xKS8hL1ypvc5h4QvJaQdtZMqkCpX5I+KDGzSs
        59a5zRN3swyuAx/p0+IaFNnu/bDpfAw/FE0+Ih2HvJBdSu5IlBnAu4qrIlv2MQ==
Date:   Fri, 17 Nov 2023 14:19:38 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, michael.riesch@wolfvision.net
Subject: Re: [PATCH v11 3/3] arm64: dts: rockchip: Add the camera interface
Message-ID: <ZVdoaqgS7Fy8fC1y@aptenodytes>
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <3566c176d1ef5ae93aa54587a14ccfa80974e872.1700132457.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TFD2HmYut63ln2GZ"
Content-Disposition: inline
In-Reply-To: <3566c176d1ef5ae93aa54587a14ccfa80974e872.1700132457.git.mehdi.djait@bootlin.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TFD2HmYut63ln2GZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,

On Thu 16 Nov 23, 12:04, Mehdi Djait wrote:
> The PX30 has a video capture component, supporting the BT.656
> parallel interface. Add a DT description for it.

One thing I missed: you need the commit title to mention the PX30, otherwise
we cannot see which chip you are adding camera support for.

> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts=
/rockchip/px30.dtsi
> index 42ce78beb413..3a4e859e5a49 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -1281,6 +1281,18 @@ isp_mmu: iommu@ff4a8000 {
>  		#iommu-cells =3D <0>;
>  	};
> =20
> +	cif: video-capture@ff490000 {
> +		compatible =3D "rockchip,px30-vip";
> +		reg =3D <0x0 0xff490000 0x0 0x200>;
> +		interrupts =3D <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
> +		clock-names =3D "aclk", "hclk", "pclk";
> +		power-domains =3D <&power PX30_PD_VI>;
> +		resets =3D <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN=
>;
> +		reset-names =3D "axi", "ahb", "pclkin";
> +		status =3D "disabled";
> +	};
> +
>  	qos_gmac: qos@ff518000 {
>  		compatible =3D "rockchip,px30-qos", "syscon";
>  		reg =3D <0x0 0xff518000 0x0 0x20>;
> --=20
> 2.41.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--TFD2HmYut63ln2GZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVXaGoACgkQ3cLmz3+f
v9FIRAf8CSuN94tBIxlWPN+Yhiy8dbHRhZ9rV2bkQ2+eJ/8f7y5OFlsXVoeTk3Bd
sFsN74KvBzgsxB8z6Lfon1xz44Dd+d8gR588ZFhTgk4h8Dllj5JtN6Qr/CCTXI9X
YqrA6vRba93rUuuy/2AWtTHFZizD0sU43n9mMOuzxCSrZrY6OlE4UG7ctvsNMTf5
pl4s1LUP2Dn7ZXmxFnlYCe9/1Y3YXH3bUnbNU/bXFUsUIg6mwyJbdvFFn9aSe/BH
JxCbu44eS/T/0yG2Rbk7qqhKT+P8CDVblmRRv0Exve2AhizkVK32Tiv0+6WVIOzQ
QTDVBDCRScDZbTVyk2d408rCJgC57w==
=iLKP
-----END PGP SIGNATURE-----

--TFD2HmYut63ln2GZ--
