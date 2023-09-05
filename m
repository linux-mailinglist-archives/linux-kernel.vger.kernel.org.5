Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8D793036
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbjIEUph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjIEUph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:45:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AF7197;
        Tue,  5 Sep 2023 13:45:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a63b2793ecso438208266b.2;
        Tue, 05 Sep 2023 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693946730; x=1694551530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIvmYYhjKCEZ35+WkKnj/4U5JeMP4YyAQxDuZOHHeuE=;
        b=RtptjJRqP9RwjSDeBFS+tZ0IHblYpfT0+QwEhRZj8GEXt4Mi8cOoIpYr7WIrXI5be3
         XmH1frcglElbMFlHflhftvpLIc/WTqGRdh1LK7KTusXvfhHIHJTYW290M+c4Rg95Kb9J
         AzncV+LgIKNSPrlLGowJPGLIqT+HfM+WYJCEgPbDHj4lKub/MYKHdBQh+DypapuEikHh
         yk08CYZsB5X8HE173dJGbnnifDaWBKH4h39RuJaX/SP8n4Sdi0heUJfZgiqs3mVerlln
         F1HidrZkY9348F6iqfPlUZGSGPObJcHNs0yk23j5rktzPaKhn3t/Clwm5544915dAKb9
         GadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946730; x=1694551530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIvmYYhjKCEZ35+WkKnj/4U5JeMP4YyAQxDuZOHHeuE=;
        b=YMsMnh0hzdRpgm+vLImzLLTvJ2YU4AuCnhRgXcbkuLDRI+6C2j8yJAEeYq4QUeibEr
         aPvVAHFJP7KES3fVpc6M372Ir/w/KZN3ZswMikB/n7Xz49n9ErO691kGdIR3xmAjJQhm
         LDXS9KPWWIijNVQpT4Z0ZalaqEpagwxcKVQe5tseX/BX1KHljWFQwl11PR9I287o2WD0
         ZVLfi+n7gp7y173pc9yJrdKCUXMqEtP1WYtvzYwjZj3TdNez1/qIiO8fRUKsWgSoKbyo
         hDNvlnjksQ6nVPpb7ODJJdlHA/zSVLz0owk0mOQPPPepZV9KMK+mrTKCVclIvTpGoZ0U
         X78g==
X-Gm-Message-State: AOJu0Yy2jR/MRkyliojth44W8ROaDyC88l1wKIeSshHoB8XLjnOTi+/M
        Fy2Mt613pfqkwcy819Kmm+E=
X-Google-Smtp-Source: AGHT+IFrnR+K16f9BxS6PPkL5fv9YQiLc2F+KJpjxB+uXnLXRUmWC3CGIs3L9iHy65pSVYVaUg4i3A==
X-Received: by 2002:a17:906:5397:b0:9a2:1c88:b94 with SMTP id g23-20020a170906539700b009a21c880b94mr671743ejo.65.1693946730152;
        Tue, 05 Sep 2023 13:45:30 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709066d9200b0099b5a71b0bfsm8065474ejt.94.2023.09.05.13.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:45:29 -0700 (PDT)
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
Date:   Tue, 05 Sep 2023 22:45:27 +0200
Message-ID: <1909632.taCxCBeP46@archlinux>
In-Reply-To: <KSXWZR.LZT0IYKM7IPF@somainline.org>
References: <20230807145349.2220490-1-martin@biqu3d.com>
 <ZBNDZR.IENEPBA0KL4D2@somainline.org> <KSXWZR.LZT0IYKM7IPF@somainline.org>
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

On Thursday, August 24, 2023 10:48:20 PM CEST Martin Botka wrote:
> On Mon, Aug 14 2023 at 12:47:59 PM +02:00:00, Martin Botka
>=20
> <martin.botka@somainline.org> wrote:
> > On Mon, Aug 14 2023 at 12:26:07 PM +02:00:00, Jernej =C5=A0krabec
> >=20
> > <jernej.skrabec@gmail.com> wrote:
> >> Dne nedelja, 13. avgust 2023 ob 18:22:49 CEST je Martin Botka
> >>=20
> >> =7Fnapisal(a):
> >>>  On Sun, Aug 13 2023 at 05:55:35 PM +02:00:00, Jernej =C5=A0krabec
> >>> =20
> >>>  <jernej.skrabec@gmail.com> wrote:
> >>>  > Dne ponedeljek, 07. avgust 2023 ob 16:53:24 CEST je Martin Botka
> >>>  >=20
> >>>  > napisal(a):
> >>>  >>  The BigTreeTech Pi is an H616 based board based on CB1.
> >>>  >>  Just in Rpi format board.
> >>>  >> =20
> >>>  >>  It features the same internals as BTT CB1 but adds:
> >>>  >>      - Fan port
> >>>  >>      - IR receiver
> >>>  >>      - ADXL345 Accelerometer connector via SPI
> >>>  >>      - 24V DC power supply via terminal plugs
> >>>  >>      - USB to CAN module connector (The actual USB to CAN
> >>>=20
> >>> =7F=7Fhappens on
> >>>=20
> >>>  >> the
> >>>  >>=20
> >>>  >>  external module)
> >>>  >> =20
> >>>  >>  List of currently working things is same as BTT CB1 but also:
> >>>  >>      - IR receiver
> >>>  >>      - ADXL345 connector
> >>>  >> =20
> >>>  >>  Signed-off-by: Martin Botka <martin@biqu3d.com>
> >>>  >>  Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >>>  >>  ---
> >>>  >> =20
> >>>  >>  Changes in V2:
> >>>  >>      - Add UART alongside aliases and chosen for it
> >>>  >>      - Add model string
> >>>  >>      - Enable IR receiver
> >>>  >>      - Enable SPI0 for ADXL345 connector
> >>>  >> =20
> >>>  >>  Changes in V3:
> >>>  >>      - Add missing semicolons
> >>>  >>      - Add pinctrl for SPI0
> >>>  >>  =20
> >>>  >>   arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >>>  >>   .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 70
> >>>  >>=20
> >>>  >> +++++++++++++++++++
> >>>  >>=20
> >>>  >>   2 files changed, 71 insertions(+)
> >>>  >>   create mode 100644
> >>>  >> =20
> >>>  >>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> >>>  >> =20
> >>>  >>  diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> >>>  >>  b/arch/arm64/boot/dts/allwinner/Makefile index
> >>>  >>=20
> >>>  >> 7b386428510b..0b6232a7f328
> >>>  >>=20
> >>>  >>  100644
> >>>  >>  --- a/arch/arm64/boot/dts/allwinner/Makefile
> >>>  >>  +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >>>  >>  @@ -39,5 +39,6 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D
> >>>  >>=20
> >>>  >> sun50i-h6-pine-h64-model-b.dtb
> >>>  >>=20
> >>>  >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> >>>  >> =20
> >>>  >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> >>>  >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D
> >>>=20
> >>> =7F=7Fsun50i-h616-bigtreetech-cb1-manta.dtb
> >>>=20
> >>>  >>  +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> >>>  >> =20
> >>>  >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> >>>  >>   dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> >>>  >> =20
> >>>  >>  diff --git
> >>>  >>=20
> >>>  >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> >>>  >>=20
> >>>  >>  b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> >>>=20
> >>> =7F=7Fnew
> >>>=20
> >>>  >> file
> >>>  >>=20
> >>>  >>  mode 100644
> >>>  >>  index 000000000000..b0d0386e8f13
> >>>  >>  --- /dev/null
> >>>  >>  +++
> >>>=20
> >>> =7F=7Fb/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> >>>=20
> >>>  >>  @@ -0,0 +1,70 @@
> >>>  >>  +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >>>  >>  +/*
> >>>  >>  + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
> >>>  >>  + */
> >>>  >>  +
> >>>  >>  +/dts-v1/;
> >>>  >>  +
> >>>  >>  +#include "sun50i-h616-bigtreetech-cb1.dtsi"
> >>>  >>  +
> >>>  >>  +/ {
> >>>  >>  +	model =3D "BigTreeTech Pi";
> >>>  >>  +	compatible =3D "bigtreetech,pi", "allwinner,sun50i-h616";
> >>>  >>  +
> >>>  >>  +	aliases {
> >>>  >>  +		serial0 =3D &uart0;
> >>>  >>  +	};
> >>>  >>  +
> >>>  >>  +	chosen {
> >>>  >>  +		stdout-path =3D "serial0:115200n8";
> >>>  >>  +	};
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ehci0 {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ehci1 {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ehci2 {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ehci3 {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ir {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ohci0 {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ohci1 {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ohci2 {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&ohci3 {
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&spi0 {
> >>>  >>  +	/* SPI connection for onboard connector for ADXL345
> >>>=20
> >>> =7F=7Faccelerometer
> >>>=20
> >>>  > */
> >>>  >=20
> >>>  >>  +	status =3D "okay";
> >>>  >>  +	pinctrl-names =3D "default";
> >>>  >>  +	pinctrl-0 =3D <&spi0_pins>, <&spi0_cs0_pin>;
> >>>  >=20
> >>>  > Driver and compatible for ADXL345 already exists, why don't you
> >>>=20
> >>> =7F=7Fadd
> >>>=20
> >>>  > child node
> >>>  > for it?
> >>>  >=20
> >>>  > Best regards,
> >>>  > Jernej
> >>> =20
> >>>  Ah. So the ADXL345 actually wont be driven by kernel.
> >>=20
> >> DT is hardware description, it's not concerned what is done on
> >> =7Fsoftware side,
> >> either kernel or user space.
> >=20
> > Im aware. But this is not a device that is on the board. Its simply a
> > connector for the device.
> > Like Rpi has connectors for camera module :)

Actually it matters only if this other board is firmly connected with base=
=20
board. If it is not, then SPI node should be dropped and be handled with DT=
=20
overlays.

> >=20
> >>>  The SPI connection is enabled so that klipper (3d printer
> >>>=20
> >>> firmware) =7F=7Fcan
> >>>=20
> >>>  be told to look for ADXL345 at this SPI and use it on its own.
> >>> =20
> >>>  Klipper will initialize and communicate with the ADXL on its own.
> >>=20
> >> What do you mean by firmware? User space app? In this case I suppose
> >> =7Fyou'll use
> >> direct SPI commands from user space? AFAIK that's less and less
> >> =7Fsupported by
> >> kernel (in contrast to I2C).
> >=20
> > Firmware as in 3d printer firmware. Klipper runs on the board (CB1 or
> > BTT Pi) and is indeed an userspace app.
> > And indeed uses direct SPI commands to the device.
> >=20
> > The reason for this is the flexibility.
> > If Klipper read the values from kernel or well from the files the
> > ADXL driver would create
> > then it would be unable to communicate with ADXL that is on toolhead
> > board. Or would have to have
> > direct initialization either way for those. Thus it just controls the
> > ADXL itself :)
> >=20
> > I understand that this may be bit confusing. If there is still
> > something not clear im more then happy to explain in
> > full detail how the userspace and 3D printer communicate :)

As I said, DT doesn't care about implementation. DT is HW description, so=20
either if it's fixed connection (soldered wires), then describe in full,=20
otherwise it's considered addon board and thus non-essential, so it should =
be=20
handled with DT overlays.

Can be CB1 bought separately from 3D printer package and thus used without=
=20
ADXL sensor?

> >=20
> > Cheers,
> > Martin.
>=20
> Hello,
> Jernej any comments on this ?
> I would like to resolve this conversation :)
> We do have a bunch of time before the new cycle but never hurts to get
> it figured out ahead of time :)

Sorry, not enough free time over summer.

Best regards,
Jernej

>=20
> Cheers,
> Martin
>=20
> >> Best regards,
> >> Jernej
> >>=20
> >>>  >>  +};
> >>>  >>  +
> >>>  >>  +&uart0 {
> >>>  >>  +	pinctrl-names =3D "default";
> >>>  >>  +	pinctrl-0 =3D <&uart0_ph_pins>;
> >>>  >>  +	status =3D "okay";
> >>>  >>  +};




