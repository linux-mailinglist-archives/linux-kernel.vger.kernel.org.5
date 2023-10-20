Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7311F7D113D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377531AbjJTOLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377495AbjJTOK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:10:59 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7306193;
        Fri, 20 Oct 2023 07:10:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7E31240009;
        Fri, 20 Oct 2023 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697811055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=52lH+GkBwc41ljxBF1Kw4WZBdBsZqH5YByG4eJJ9tVk=;
        b=VGyxoBcacZ+ZUyB68YjKdlo3eeT+/vshs1EhL1OmNxtrAVdkR+8mNSbmJ+DeV8N0Cycf34
        3pKohd7EgfyKwdyB04xBx+kJwaCEVRurOWCyBq4lSHc2XE0DT1w5A5pRW5rnnpMaQKlAxs
        h8OFGJ7MHBtNQhcTO4UU9/jspVnRn+GORYZQ5JTT4PDm8U9bwFnbnn+E9inXg/2WlB96ZN
        Hn25HWYlilZZHkHW3rZUpYFPnsftBj2wY7fyUfxRXaNx/zR2GDiVrwBz5SGOk/auRYdeQJ
        8Zhd4KsSjs4mOB7DHB68hm+4qy6/NkhonywrIIZ2YzM9QEwpvA5SFsRDdqco3Q==
Date:   Fri, 20 Oct 2023 16:10:53 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v8 3/3] arm64: dts: rockchip: Add the camera interface
Message-ID: <ZTKKbckxeQda07rP@aptenodytes>
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <936393d5f2d4b583efbb1ac81f21e8d41fb452cb.1697446303.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cEW6dqGFLbs7lmqa"
Content-Disposition: inline
In-Reply-To: <936393d5f2d4b583efbb1ac81f21e8d41fb452cb.1697446303.git.mehdi.djait@bootlin.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cEW6dqGFLbs7lmqa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,

On Mon 16 Oct 23, 11:00, Mehdi Djait wrote:
> The PX30 has a camera interface, supporting CSI2 and BT656
> modes. Add a DT description for this interface.

The "vip" node name is not very standard but the generic names recommendati=
on
doesn't have anything that really fits video capture:
https://devicetree-specification.readthedocs.io/en/v0.3/devicetree-basics.h=
tml#generic-names-recommendation

You might want to call it "video-capture" or "camera-controller" which seems
like a good middle-ground that could be included in the list.

Please keep the name (vip/cif) as label though.

Other than that, please rename vip to cif and this will be:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts=
/rockchip/px30.dtsi
> index 42ce78beb413..7aaa88a15d07 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -1281,6 +1281,18 @@ isp_mmu: iommu@ff4a8000 {
>  		#iommu-cells =3D <0>;
>  	};
> =20
> +	vip: vip@ff490000 {
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

--cEW6dqGFLbs7lmqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmUyim0ACgkQ3cLmz3+f
v9G2twf/SeumhpY637dwLFwp9ThP8+5B/p+8/pUDkYTjoRWYc9+f2h4x+Q+DxV5A
XroPIep0qSAaEcSElIY+xmQrGxT6aOvG75J+RvzL4NZEqmNIGshYjkijsZ/xIn0Q
4CggUE46UhTw1rkHkW8rMl9eHFEQYd2Fpv2rz5D6pUBpHPhVZ1Tfx7e4sNdgl7kQ
T7fLi0ldX6Q4AppmqAeIsi3M6V5BbZSDGYb9eVAv2kvEWEUwLHC3l71VBz2LnNCJ
sHbSSfIa5Yk/9GZgiVPjvM3cUzc4neV2V/vx4a83NJ0yf/lgE74qDpUG5ZLkvyk5
A7rBvnl9zGXA1SZulOQyJK1A7Fm/Aw==
=+ix9
-----END PGP SIGNATURE-----

--cEW6dqGFLbs7lmqa--
