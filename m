Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8615A77B6A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHNK02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjHNK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:26:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5B794;
        Mon, 14 Aug 2023 03:26:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c3c8adb27so566179466b.1;
        Mon, 14 Aug 2023 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692008771; x=1692613571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4zjyeRMuBKgoq3hmDr9Mo+DcQOEM3UuViZKKoModSY=;
        b=Bguv/UE2Sfx3jvCanC8euGtc1kvHTgMM4jZ/lvr+5dTVV8LD48+m9MrvXS3uG2z+77
         UFKBf6eiLerUjeeqcEjahL+Kq9o7iwJVdlvZYoZw/VpGqoYBf8TsDAiUYe5o3sfgpQRs
         qseBdNOi2oybPotapBsgsCsGftulUmzJ/qVg8q93KnKsWlaKfQ6G3QhznDsTjAkb+ppG
         3AsdXvxaNCvPnxWZcEXlsM5nHRmRGyn6xMGf8ERpd4lb6wlYHzyJ8sZIDOmOtGv2Ffff
         k13UzTVv0ez7aqdiwa15ESDfedo4gFLbDJ7/DW8bkC2LszdR5++pcZ29XAE2bFRQlw/f
         EnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008771; x=1692613571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4zjyeRMuBKgoq3hmDr9Mo+DcQOEM3UuViZKKoModSY=;
        b=ZSq/J2wWC43uN5LsB3ThvGdXNYaU5icczUsgXHeSjegkNYqSxRq3c0V3vGggZIhIWp
         m+poCVud7zv0CtL+C8Tz+KY2np2O9UB83d8QyK61PEHYP7LpXvCNbgJukm1Lq2f737f1
         e7LPSwhjw4hghUhMPZylmaZioqIDbRFoD36B3IQvbgV8DSlHfwnxEyr1iAeMzB8XskoE
         Wj3Fqrwz5EmNw1JRV3/KsxeEGoGHvYJ+aTuCZ+wzwF9TBHcDsLibYhuKCHDmACMmtvIz
         OO3lDu1AjniiUkh+yNOKOjFVohDLS5bw2XhALwDW+YWDEgg9OmblJHFRQCmdqlwwHwiT
         +hkw==
X-Gm-Message-State: AOJu0YzsoX9w9sL3bFZme92Tan2FZOGpabsRyuWSqqHMlwUGDEtFLLI0
        Jh9Ik9ZQ//BZe5YruUdA3Bk=
X-Google-Smtp-Source: AGHT+IFhHceTnKnUf+I8/zas6a7NbC69cC8vBbAuFWmrToAEQRR+VMbGF0PMZmTdaa5BBo7GLcql6g==
X-Received: by 2002:a17:907:1dce:b0:99b:d098:1ffd with SMTP id og14-20020a1709071dce00b0099bd0981ffdmr7273943ejc.62.1692008770779;
        Mon, 14 Aug 2023 03:26:10 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id jo5-20020a170906f6c500b009786c8249d6sm5566641ejb.175.2023.08.14.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:26:10 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Martin Botka <martin.botka1@gmail.com>,
        Martin Botka <martin@biqu3d.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Martin Botka <martin@biqu3d.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi support
Date:   Mon, 14 Aug 2023 12:26:07 +0200
Message-ID: <9148039.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <168CZR.KVQVUV8KXJ5Y1@somainline.org>
References: <20230807145349.2220490-1-martin@biqu3d.com>
 <10318766.nUPlyArG6x@jernej-laptop> <168CZR.KVQVUV8KXJ5Y1@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 13. avgust 2023 ob 18:22:49 CEST je Martin Botka napisal(a):
> On Sun, Aug 13 2023 at 05:55:35 PM +02:00:00, Jernej =C5=A0krabec
>=20
> <jernej.skrabec@gmail.com> wrote:
> > Dne ponedeljek, 07. avgust 2023 ob 16:53:24 CEST je Martin Botka
> >=20
> > napisal(a):
> >>  The BigTreeTech Pi is an H616 based board based on CB1.
> >>  Just in Rpi format board.
> >> =20
> >>  It features the same internals as BTT CB1 but adds:
> >>      - Fan port
> >>      - IR receiver
> >>      - ADXL345 Accelerometer connector via SPI
> >>      - 24V DC power supply via terminal plugs
> >>      - USB to CAN module connector (The actual USB to CAN happens on
> >>=20
> >> the
> >>=20
> >>  external module)
> >> =20
> >>  List of currently working things is same as BTT CB1 but also:
> >>      - IR receiver
> >>      - ADXL345 connector
> >> =20
> >>  Signed-off-by: Martin Botka <martin@biqu3d.com>
> >>  Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >>  ---
> >> =20
> >>  Changes in V2:
> >>      - Add UART alongside aliases and chosen for it
> >>      - Add model string
> >>      - Enable IR receiver
> >>      - Enable SPI0 for ADXL345 connector
> >> =20
> >>  Changes in V3:
> >>      - Add missing semicolons
> >>      - Add pinctrl for SPI0
> >>  =20
> >>   arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >>   .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 70
> >>=20
> >> +++++++++++++++++++
> >>=20
> >>   2 files changed, 71 insertions(+)
> >>   create mode 100644
> >> =20
> >>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> >> =20
> >>  diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> >>  b/arch/arm64/boot/dts/allwinner/Makefile index
> >>=20
> >> 7b386428510b..0b6232a7f328
> >>=20
> >>  100644
> >>  --- a/arch/arm64/boot/dts/allwinner/Makefile
> >>  +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >>  @@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D
> >>=20
> >> sun50i-h6-pine-h64-model-b.dtb
> >>=20
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> >> =20
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
> >> =20
> >>  +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> >> =20
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> >> =20
> >>  diff --git
> >>=20
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> >>=20
> >>  b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts new
> >>=20
> >> file
> >>=20
> >>  mode 100644
> >>  index 000000000000..b0d0386e8f13
> >>  --- /dev/null
> >>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> >>  @@ -0,0 +1,70 @@
> >>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >>  +/*
> >>  + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> >>  + */
> >>  +
> >>  +/dts-v1/;
> >>  +
> >>  +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> >>  +
> >>  +/ {
> >>  +	model =3D "BigTreeTech Pi";
> >>  +	compatible =3D "bigtreetech,pi", "allwinner,sun50i-h616";
> >>  +
> >>  +	aliases {
> >>  +		serial0 =3D &uart0;
> >>  +	};
> >>  +
> >>  +	chosen {
> >>  +		stdout-path =3D "serial0:115200n8";
> >>  +	};
> >>  +};
> >>  +
> >>  +&ehci0 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ehci1 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ehci2 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ehci3 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ir {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ohci0 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ohci1 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ohci2 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&ohci3 {
> >>  +	status =3D "okay";
> >>  +};
> >>  +
> >>  +&spi0 {
> >>  +	/* SPI connection for onboard connector for ADXL345 accelerometer
> >=20
> > */
> >=20
> >>  +	status =3D "okay";
> >>  +	pinctrl-names =3D "default";
> >>  +	pinctrl-0 =3D <&spi0_pins>, <&spi0_cs0_pin>;
> >=20
> > Driver and compatible for ADXL345 already exists, why don't you add
> > child node
> > for it?
> >=20
> > Best regards,
> > Jernej
>=20
> Ah. So the ADXL345 actually wont be driven by kernel.

DT is hardware description, it's not concerned what is done on software sid=
e,=20
either kernel or user space.

> The SPI connection is enabled so that klipper (3d printer firmware) can
> be told to look for ADXL345 at this SPI and use it on its own.
>=20
> Klipper will initialize and communicate with the ADXL on its own.

What do you mean by firmware? User space app? In this case I suppose you'll=
 use=20
direct SPI commands from user space? AFAIK that's less and less supported b=
y=20
kernel (in contrast to I2C).

Best regards,
Jernej

>=20
> >>  +};
> >>  +
> >>  +&uart0 {
> >>  +	pinctrl-names =3D "default";
> >>  +	pinctrl-0 =3D <&uart0_ph_pins>;
> >>  +	status =3D "okay";
> >>  +};




