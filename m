Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0747277A794
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjHMPnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHMPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:43:14 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D918E60;
        Sun, 13 Aug 2023 08:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691941341; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=GLYiWXgJUhEyoT+jjCbLCK9slf4xaJ7xtMTWn5gUpFBFM+eA6a7j3bZ1eaHrWRW9FyxaOZPOWCSxqe13UuWszYDLX0Y4XrE431HXoBMSG3Rg+igIZaJ9pK1OyVjFzHFQPXahLMzVC+ZsxJJz3CTnV4ZtWhfQMeQcaklUZg1nJjc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1691941341; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Xr4+S0vpdbjaiNNF/llD4Sx8PfSNTyDvnpd6CmUya5w=; 
        b=G4+Wt4/Iv9lTdi/n6PPF375aXPJA6hHi2jvh5xpoLQrPy3an49bdDSRhXpJWYN59GrY17QkKYnEbYjJuIi/0EbNNsycxrzx6jPg6DjTsfYsgPZxpvb9gchehVwQkrE0jT09irJSk16iHZsUOv7m4TajgHPjKRUl0JhH1hWuz8OI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1691941341;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=Xr4+S0vpdbjaiNNF/llD4Sx8PfSNTyDvnpd6CmUya5w=;
        b=IAmvP4o3HLSyxr6TAhTszlBUsNFSbqY4YcI1LJffcojrGxCFZIvgReCKDYFW0OZd
        xEXM8fnn7qF85Sai3EJHhFKJl90nPvrubmvvInHN2rRRifntjh5Co+dpyBSLq4MxluI
        bbOisnPiR52F20aTxn4gaTbNUgz7EeiStafhH7V4URFhA80OVYmrkasFloDI55Ndf9s
        gZccyWkkUxJ0lgJdACb0uGBOcrd1io3+NmsYTZBQ2N1AheSOf8Byq5Z8DnwEhy+w63D
        wvKqZwJix8q+66MqVUqMHfY9QW1w4VLlCY+wFBsRtEiPODJo+haQ88piYGncMMtnTv4
        rb9hCNrhGg==
Received: from edelgard.fodlan.icenowy.me (120.85.97.224 [120.85.97.224]) by mx.zohomail.com
        with SMTPS id 1691941339762761.0310215430785; Sun, 13 Aug 2023 08:42:19 -0700 (PDT)
Message-ID: <200cfafd7ba034d7620740c510c703f3acbeb721.camel@icenowy.me>
Subject: Re: [PATCH v4 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi
 support
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka1@gmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Sun, 13 Aug 2023 23:42:10 +0800
In-Reply-To: <09BFA974F83AB0E8+20230807145349.2220490-5-martin@biqu3d.com>
References: <20230807145349.2220490-1-martin@biqu3d.com>
         <09BFA974F83AB0E8+20230807145349.2220490-5-martin@biqu3d.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-08-07=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 16:53 +0200=EF=BC=
=8CMartin Botka=E5=86=99=E9=81=93=EF=BC=9A
> The BigTreeTech Pi is an H616 based board based on CB1.
> Just in Rpi format board.
>=20
> It features the same internals as BTT CB1 but adds:
> =C2=A0=C2=A0=C2=A0 - Fan port
> =C2=A0=C2=A0=C2=A0 - IR receiver
> =C2=A0=C2=A0=C2=A0 - ADXL345 Accelerometer connector via SPI
> =C2=A0=C2=A0=C2=A0 - 24V DC power supply via terminal plugs
> =C2=A0=C2=A0=C2=A0 - USB to CAN module connector (The actual USB to CAN h=
appens on
> the external module)
>=20
> List of currently working things is same as BTT CB1 but also:
> =C2=A0=C2=A0=C2=A0 - IR receiver
> =C2=A0=C2=A0=C2=A0 - ADXL345 connector
>=20
> Signed-off-by: Martin Botka <martin@biqu3d.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changes in V2:
> =C2=A0=C2=A0=C2=A0 - Add UART alongside aliases and chosen for it
> =C2=A0=C2=A0=C2=A0 - Add model string
> =C2=A0=C2=A0=C2=A0 - Enable IR receiver
> =C2=A0=C2=A0=C2=A0 - Enable SPI0 for ADXL345 connector
> Changes in V3:
> =C2=A0=C2=A0=C2=A0 - Add missing semicolons
> =C2=A0=C2=A0=C2=A0 - Add pinctrl for SPI0
>=20
> =C2=A0arch/arm64/boot/dts/allwinner/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0.../allwinner/sun50i-h616-bigtreetech-pi.dts=C2=A0 | 70
> +++++++++++++++++++
> =C2=A02 files changed, 71 insertions(+)
> =C2=A0create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-
> bigtreetech-pi.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile
> index 7b386428510b..0b6232a7f328 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-
> model-b.dtb
> =C2=A0dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> =C2=A0dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> =C2=A0dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> =C2=A0dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> =C2=A0dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-
> pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> new file mode 100644
> index 000000000000..b0d0386e8f13
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> +
> +/ {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "BigTreeTech Pi";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "bigtreetech,pi=
", "allwinner,sun50i-h616";

As you say it's based on CB1 too, why no CB1 compatible here? (although
the manta compatible won't apply)

> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aliases {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0serial0 =3D &uart0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chosen {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0stdout-path =3D "serial0:115200n8";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +};
> +
> +&ehci0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&ehci1 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&ehci2 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&ehci3 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&ir {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&ohci0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&ohci1 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&ohci2 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&ohci3 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};
> +
> +&spi0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* SPI connection for onboard =
connector for ADXL345
> accelerometer */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-names =3D "default";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-0 =3D <&spi0_pins>, <&=
spi0_cs0_pin>;
> +};
> +
> +&uart0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-names =3D "default";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-0 =3D <&uart0_ph_pins>=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> +};

