Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB01D768A37
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGaDGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaDGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:06:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2DE78;
        Sun, 30 Jul 2023 20:06:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bed101b70so458783866b.3;
        Sun, 30 Jul 2023 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690772776; x=1691377576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D606U3uDf6w3bbhM/rK79vcRAhDwXEDhhPdXtqS0M5Q=;
        b=cea8lGBegRT1HxwWNcESWead++JoVzkcXrXWN0bjGQ1mYXU45vgHNRYjPGDd4GQWI3
         DWmxKZcKsQIqpFcXzz33AnJYzk5pEwqXzVQORC9b0PXBoXDBNHVZzsZ77YD5hnf2Dmw/
         NZ1TaE1Xovog70pshC/xuGj67eAZytlp/78k+Kug8fsuwlHPZpN3eJmzkMmnbN+O7MyC
         O5f0FDtThW2hVpNYBeQnAOzTHeS/O0A+cGMPzX1jrmzk5cPrsv4cBR4RRL4hQYviwlCu
         XerNF/c8T3WznvzFAfKLva2Rp/vgsNY+nIwW9hHVwHvdpY8dMLE0jZ5hn98JFObI8kM5
         EEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690772776; x=1691377576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D606U3uDf6w3bbhM/rK79vcRAhDwXEDhhPdXtqS0M5Q=;
        b=Zv/YuqYkoayWURY5OQzCVufXPiPxxQRjUae0yhoasGTka5iWzymFgTSQY18N7gno5k
         VwEm9uIQG/5b/VT3DRiMsu5R0LcoCzdeaDjnW5dTgDhLiqMT9pTHMilbQgHOJj4FaEJf
         1uTmBR3rYMoojBzTjEtsNts/wt0CVud9cuN5y19QqfmtrzuEMEwkjO6F/JAN4JKDwVob
         hLJYSCKb18MpXvIBXtsXn+tjxMkQbOVmHOVtuj7oc3t9e4AsnvtTsHOjkiZcPbarfExw
         G8mX6tJQn93hcit7sISXr90rNve29FjhquiiqfsFwfysvH15m8JXWseEub1MbSuofTze
         O8vA==
X-Gm-Message-State: ABy/qLZhZU7XOi2VMH6lRPb4NRv/JRvDv5Ztl7Or+4LTlyPGKKJjaiEi
        Fo7Zz/65nE1Q/Jdx8bz4uKUwy1ymJ8fwNjR30IpKQoplR9o=
X-Google-Smtp-Source: APBJJlFGRBZ+ZNhS108diq25FC+VPPxGLi+EWF0rjz6HdcGpWjHclqGmirUV/unhV/vANsVk2+wPxcbbHPIPMlK2BTA=
X-Received: by 2002:a17:906:cc50:b0:99b:bc51:8ca3 with SMTP id
 mm16-20020a170906cc5000b0099bbc518ca3mr6730182ejb.1.1690772776324; Sun, 30
 Jul 2023 20:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-4-keguang.zhang@gmail.com> <CANvTkNbss+ovB_nXYvAXT9dZt4H1KsF41EQ4f3zHf1dEnpdreA@mail.gmail.com>
In-Reply-To: <CANvTkNbss+ovB_nXYvAXT9dZt4H1KsF41EQ4f3zHf1dEnpdreA@mail.gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 31 Jul 2023 11:06:00 +0800
Message-ID: <CAJhJPsUVXGxEjWU5eWK-cZz39BU9u+9Kxm8N2ONxOgRk6ts83w@mail.gmail.com>
Subject: Re: [PATCH 03/17] MIPS: dts: Add basic DT support for Loongson-1 boards
To:     Du Huanpeng <u74147@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 1:11=E2=80=AFAM Du Huanpeng <u74147@gmail.com> wrot=
e:
>
> Keguang Zhang <keguang.zhang@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=882=
9=E6=97=A5=E5=91=A8=E5=85=AD 21:45=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Add initial devicetree for Loongson-1 boards, including
> > LSGZ_1B_DEV and SMARTLOONG_1C board.
> > These basic DTs contain CPU, clock and core INTC.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  arch/mips/boot/dts/Makefile                   |  1 +
> >  arch/mips/boot/dts/loongson/Makefile          |  3 +
> >  arch/mips/boot/dts/loongson/loongson1.dtsi    | 22 ++++++
> >  arch/mips/boot/dts/loongson/loongson1b.dtsi   | 75 +++++++++++++++++++
> >  arch/mips/boot/dts/loongson/loongson1c.dtsi   | 29 +++++++
> >  arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   | 25 +++++++
> >  arch/mips/boot/dts/loongson/smartloong_1c.dts | 25 +++++++
> >  7 files changed, 180 insertions(+)
> >  create mode 100644 arch/mips/boot/dts/loongson/loongson1.dtsi
> >  create mode 100644 arch/mips/boot/dts/loongson/loongson1b.dtsi
> >  create mode 100644 arch/mips/boot/dts/loongson/loongson1c.dtsi
> >  create mode 100644 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> >  create mode 100644 arch/mips/boot/dts/loongson/smartloong_1c.dts
> >
> > diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> > index 928f38a79dff..2e040b1ba97b 100644
> > --- a/arch/mips/boot/dts/Makefile
> > +++ b/arch/mips/boot/dts/Makefile
> > @@ -6,6 +6,7 @@ subdir-$(CONFIG_FIT_IMAGE_FDT_BOSTON)   +=3D img
> >  subdir-$(CONFIG_MACH_INGENIC)          +=3D ingenic
> >  subdir-$(CONFIG_LANTIQ)                        +=3D lantiq
> >  subdir-$(CONFIG_MACH_LOONGSON64)       +=3D loongson
> > +subdir-$(CONFIG_MACH_LOONGSON32)       +=3D loongson
> >  subdir-$(CONFIG_SOC_VCOREIII)          +=3D mscc
> >  subdir-$(CONFIG_MIPS_MALTA)            +=3D mti
> >  subdir-$(CONFIG_LEGACY_BOARD_SEAD3)    +=3D mti
> > diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/=
loongson/Makefile
> > index 5c6433e441ee..9d95f1351d5f 100644
> > --- a/arch/mips/boot/dts/loongson/Makefile
> > +++ b/arch/mips/boot/dts/loongson/Makefile
> > @@ -6,4 +6,7 @@ dtb-$(CONFIG_MACH_LOONGSON64)   +=3D loongson64c_8core_=
rs780e.dtb
> >  dtb-$(CONFIG_MACH_LOONGSON64)  +=3D loongson64g_4core_ls7a.dtb
> >  dtb-$(CONFIG_MACH_LOONGSON64)  +=3D loongson64v_4core_virtio.dtb
> >
> > +dtb-$(CONFIG_LOONGSON1B_LSGZ_DEV)      +=3D lsgz_1b_dev.dtb
> > +dtb-$(CONFIG_LOONGSON1C_SMARTLOONG)    +=3D smartloong_1c.dtb
> > +
> >  obj-$(CONFIG_BUILTIN_DTB)      +=3D $(addsuffix .o, $(dtb-y))
> > diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boo=
t/dts/loongson/loongson1.dtsi
> > new file mode 100644
> > index 000000000000..a2b5c828bbbd
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/clock/loongson,ls1x-clk.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +       #address-cells =3D <1>;
> > +       #size-cells =3D <1>;
> > +
> > +       cpu_intc: interrupt-controller {
> > +               compatible =3D "mti,cpu-interrupt-controller";
> > +               #address-cells =3D <0>;
> > +
> > +               interrupt-controller;
> > +               #interrupt-cells =3D <1>;
> > +       };
> > +};
> > diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/bo=
ot/dts/loongson/loongson1b.dtsi
> > new file mode 100644
> > index 000000000000..784ae9b6572d
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > @@ -0,0 +1,75 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include "loongson1.dtsi"
> > +
> > +/ {
> > +       cpus {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +
> > +               cpu@0 {
> > +                       device_type =3D "cpu";
> > +                       reg =3D <0>;
> > +                       #clock-cells =3D <1>;
> > +                       clocks =3D <&clkc LS1X_CLKID_CPU>;
> > +                       operating-points-v2 =3D <&cpu_opp_table>;
> > +               };
> > +       };
> > +
> > +       cpu_opp_table: opp-table {
> > +               compatible =3D "operating-points-v2";
> > +               opp-shared;
> > +
> > +               opp-44000000 {
> > +                       opp-hz =3D /bits/ 64 <44000000>;
> > +               };
> > +               opp-47142000 {
> > +                       opp-hz =3D /bits/ 64 <47142000>;
> > +               };
> > +               opp-50769000 {
> > +                       opp-hz =3D /bits/ 64 <50769000>;
> > +               };
> > +               opp-55000000 {
> > +                       opp-hz =3D /bits/ 64 <55000000>;
> > +               };
> > +               opp-60000000 {
> > +                       opp-hz =3D /bits/ 64 <60000000>;
> > +               };
> > +               opp-66000000 {
> > +                       opp-hz =3D /bits/ 64 <66000000>;
> > +               };
> > +               opp-73333000 {
> > +                       opp-hz =3D /bits/ 64 <73333000>;
> > +               };
> > +               opp-82500000 {
> > +                       opp-hz =3D /bits/ 64 <82500000>;
> > +               };
> > +               opp-94285000 {
> > +                       opp-hz =3D /bits/ 64 <94285000>;
> > +               };
> > +               opp-110000000 {
> > +                       opp-hz =3D /bits/ 64 <110000000>;
> > +               };
> > +               opp-132000000 {
> > +                       opp-hz =3D /bits/ 64 <132000000>;
> > +               };
> > +               opp-165000000 {
> > +                       opp-hz =3D /bits/ 64 <165000000>;
> > +               };
> > +               opp-220000000 {
> > +                       opp-hz =3D /bits/ 64 <220000000>;
> > +               };
> > +       };
> > +
> > +       clkc: clock-controller@1fe78030 {
> > +               compatible =3D "loongson,ls1b-clk";
> > +               reg =3D <0x1fe78030 0x8>;
> > +
> > +               clocks =3D <&xtal>;
> > +               #clock-cells =3D <1>;
> > +       };
> > +};
> > diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/bo=
ot/dts/loongson/loongson1c.dtsi
> > new file mode 100644
> > index 000000000000..d552e1668984
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include "loongson1.dtsi"
> > +
> > +/ {
> > +       cpus {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +
> > +               cpu@0 {
> > +                       device_type =3D "cpu";
> > +                       reg =3D <0>;
> > +                       #clock-cells =3D <1>;
> > +                       clocks =3D <&clkc LS1X_CLKID_CPU>;
> > +               };
> > +       };
> > +
> > +       clkc: clock-controller@1fe78030 {
> > +               compatible =3D "loongson,ls1c-clk";
> > +               reg =3D <0x1fe78030 0x8>;
> > +
> > +               clocks =3D <&xtal>;
> > +               #clock-cells =3D <1>;
> > +       };
> > +};
> > diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/bo=
ot/dts/loongson/lsgz_1b_dev.dts
> > new file mode 100644
> > index 000000000000..d12c723b0a2b
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "loongson1b.dtsi"
> > +
> > +/ {
> > +       compatible =3D "loongson,lsgz-1b-dev", "loongson,ls1b";
> > +       model =3D "LSGZ_1B_DEV Board";
> > +
> > +       memory@0 {
> > +               device_type =3D "memory";
> > +               reg =3D <0x0 0x4000000>;
> > +       };
> > +
> > +       xtal: xtal {
> for your information, hope it helps:
> in <devicetree-specification-v0.4.pdf> Page: 8
> The name of a node should be somewhat generic, reflecting the function
> of the device and not its precise programming model. If appropriate,
>  the name should be one of the following choices:
> ... clock ...
>
Will fix this.
Thanks!

> > +               compatible =3D "fixed-clock";
> > +               clock-frequency =3D <33000000>;
> > +               clock-output-names =3D "xtal";
> > +               #clock-cells =3D <0>;
> > +       };
> > +};
> > diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/=
boot/dts/loongson/smartloong_1c.dts
> > new file mode 100644
> > index 000000000000..64e869acfd86
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "loongson1c.dtsi"
> > +
> > +/ {
> > +       compatible =3D "loongmasses,smartloong-1c", "loongson,ls1c";
> > +       model =3D "Smartloong_1C Board";
> > +
> > +       memory@0 {
> > +               device_type =3D "memory";
> > +               reg =3D <0x0 0x2000000>;
> > +       };
> > +
> > +       xtal: xtal {
> > +               compatible =3D "fixed-clock";
> > +               clock-frequency =3D <24000000>;
> > +               clock-output-names =3D "xtal";
> > +               #clock-cells =3D <0>;
> > +       };
> > +};
> > --
> > 2.39.2
> >
>
> ---
> Du Huanpeng



--=20
Best regards,

Keguang Zhang
