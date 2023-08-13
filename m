Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8666B77A83E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHMP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjHMP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:58:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED06B171B;
        Sun, 13 Aug 2023 08:58:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso36401585e9.1;
        Sun, 13 Aug 2023 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691942247; x=1692547047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn7gMff7cBc8vwjr+mRkZTxZ0UWBi7mj7eOrxULVAp4=;
        b=Zw4Mwl6EoywD2kG1Utz6eqBuv9V1bNBp880eWoiKTA7C2bqT2RrnEZA8npzuLhtJIn
         A5XZ847fJY7emhM8iox+3VR8fUemfeTjrceu8xPVBqh8ZYFjYUrp1ug+AZCqEhWfo4Nj
         rQ3C03qiwhuYXCd5d2qzl3PrcpqHzXdvuYLgM45eHRvoPAdQS7OoSVVnAHo7VpY2X1jg
         7DwQaRt6IZB+kYVzVZLZBnFDlfsoSZirj85DD9X3djK7qInCWv9D2kQmMTGLDhHIedcp
         HDhWapNPgx6zIZGpuR4Mckad5v/aBE2hn+PDF7gQ333vsS//7KWm7/ju20TPkOekndJs
         msBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691942247; x=1692547047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn7gMff7cBc8vwjr+mRkZTxZ0UWBi7mj7eOrxULVAp4=;
        b=C/Qa19R0gxNrjsLzWOab/dTn3Vs/huirtQQA9gQ+5nKHk9tlvXFO1u71PEZusvF10X
         mf98z2+S0HaalBDfAYBRiZWDaOKbzLo45Yq6W8d4TbMlqzbh3T87xuAubYnfefsEVfJ5
         Qty/j+EBRdZ1K2TEkLt8oIlmovFZ7RZ5Iu0hlmroX23H0eZDhuAIWrp3SGg7VCFkHKz8
         RjRjqwjnHy3ISKWZlIALLXaZsSUhszqHyiWx+F5gQChidXzZV5Tv/SO/H6qYSwqqveJ4
         nrG6i7DA5IYU2wwjmm/naFVTLWCt0upPDaYJX/Vg/XLb13nnp17CBhZCr4EQXyVHxs5U
         di8w==
X-Gm-Message-State: AOJu0YwP78d/1Z1FeHfDSYbioc53vheaqOgR1XGf0y/CvfPpD5vwOG+B
        1yiGA+oEWc3fLQPU2+2lts0=
X-Google-Smtp-Source: AGHT+IGLoydpAgCmV0wMdsK81MaItLO3jdoO6Jo6UV9MrEb5x/r4Gxn9QNYd6ok9v05SXh1Nu6dwFA==
X-Received: by 2002:a05:600c:20b:b0:3fe:22a9:910 with SMTP id 11-20020a05600c020b00b003fe22a90910mr5696003wmi.14.1691942246575;
        Sun, 13 Aug 2023 08:57:26 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id z21-20020a1c4c15000000b003fbfef555d2sm14369386wmf.23.2023.08.13.08.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 08:57:26 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Botka <martin@biqu3d.com>,
        Martin Botka <martin.botka1@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>
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
Subject: Re: [PATCH v4 4/4] arm64: dts: allwinner: h616: Add BigTreeTech Pi support
Date:   Sun, 13 Aug 2023 17:57:24 +0200
Message-ID: <1937906.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <200cfafd7ba034d7620740c510c703f3acbeb721.camel@icenowy.me>
References: <20230807145349.2220490-1-martin@biqu3d.com>
 <09BFA974F83AB0E8+20230807145349.2220490-5-martin@biqu3d.com>
 <200cfafd7ba034d7620740c510c703f3acbeb721.camel@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 13. avgust 2023 ob 17:42:10 CEST je Icenowy Zheng napisal(a):
> =E5=9C=A8 2023-08-07=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 16:53 +0200=EF=
=BC=8CMartin Botka=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > The BigTreeTech Pi is an H616 based board based on CB1.
> > Just in Rpi format board.
> >=20
> > It features the same internals as BTT CB1 but adds:
> >     - Fan port
> >     - IR receiver
> >     - ADXL345 Accelerometer connector via SPI
> >     - 24V DC power supply via terminal plugs
> >     - USB to CAN module connector (The actual USB to CAN happens on
> > the external module)
> >=20
> > List of currently working things is same as BTT CB1 but also:
> >     - IR receiver
> >     - ADXL345 connector
> >=20
> > Signed-off-by: Martin Botka <martin@biqu3d.com>
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> > Changes in V2:
> >     - Add UART alongside aliases and chosen for it
> >     - Add model string
> >     - Enable IR receiver
> >     - Enable SPI0 for ADXL345 connector
> > Changes in V3:
> >     - Add missing semicolons
> >     - Add pinctrl for SPI0
> >=20
> >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >  .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 70
> > +++++++++++++++++++
> >  2 files changed, 71 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-
> > bigtreetech-pi.dts
> >=20
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> > b/arch/arm64/boot/dts/allwinner/Makefile
> > index 7b386428510b..0b6232a7f328 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-
> > model-b.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-
> > pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> > new file mode 100644
> > index 000000000000..b0d0386e8f13
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> > +
> > +/ {
> > +       model =3D "BigTreeTech Pi";
> > +       compatible =3D "bigtreetech,pi", "allwinner,sun50i-h616";
>=20
> As you say it's based on CB1 too, why no CB1 compatible here? (although
> the manta compatible won't apply)

Because it doesn't contain module per se.

Best regards,
Jernej

>=20
> > +
> > +       aliases {
> > +               serial0 =3D &uart0;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path =3D "serial0:115200n8";
> > +       };
> > +};
> > +
> > +&ehci0 {
> > +       status =3D "okay";
> > +};
> > +
> > +&ehci1 {
> > +       status =3D "okay";
> > +};
> > +
> > +&ehci2 {
> > +       status =3D "okay";
> > +};
> > +
> > +&ehci3 {
> > +       status =3D "okay";
> > +};
> > +
> > +&ir {
> > +       status =3D "okay";
> > +};
> > +
> > +&ohci0 {
> > +       status =3D "okay";
> > +};
> > +
> > +&ohci1 {
> > +       status =3D "okay";
> > +};
> > +
> > +&ohci2 {
> > +       status =3D "okay";
> > +};
> > +
> > +&ohci3 {
> > +       status =3D "okay";
> > +};
> > +
> > +&spi0 {
> > +       /* SPI connection for onboard connector for ADXL345
> > accelerometer */
> > +       status =3D "okay";
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&spi0_pins>, <&spi0_cs0_pin>;
> > +};
> > +
> > +&uart0 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&uart0_ph_pins>;
> > +       status =3D "okay";
> > +};




