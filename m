Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1E76869E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjG3RLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3RLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:11:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96610CC;
        Sun, 30 Jul 2023 10:11:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso5229607a12.2;
        Sun, 30 Jul 2023 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690737073; x=1691341873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rINeYgAe2vWhDTqaE4dNqaz5whR3/rodCQD83wYGPSA=;
        b=hpv/S4CN6eOm6FJZ35c2VwAJgs4Pe25/en1e7BCtSlW0+Qb8MdnDp5/F6vVoF19arz
         FbKIL3dq25ni+8wRTzOwOSW9CY106Yg067ngdUmoBU002DvJoQhgOw3cW9UGKFx4Q50r
         S8QE1X1ZRE/B2UAinA3avVFZXRZxXFnkzOe8WCmxRG/l7iFIE0l2efquhhoZkvMbC2eC
         yz5sq9VzDm56QHNErPAUvpZdiLmMzi1JEiRO2Kx2YW44FpWiURgbkLVGgyGQccyh1P9c
         fmNa7BuYxBnbSE5zAbqC+tsN15Ds+GTv4IKEIkJjPWiS8M4BLjNpXOXU3qk+bhw6cbuq
         FE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690737073; x=1691341873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rINeYgAe2vWhDTqaE4dNqaz5whR3/rodCQD83wYGPSA=;
        b=g52UT0QV8W2uFivnQ8je67guLr33CTrZzJSIPCTjgwTkR27e3f12Tw2w44H/eMXwM7
         OIw66XgMUxdKbtu/2btWkwdLRXX1qh0bhIHmlKYbvDZLew9C0dnrcuuNVPjT37PswzMl
         ZS8usW+OQcQ+3S4ocPd9cWX97ebnrn6oubUOw0P4F45Nms80pxiOkhxTa54zK1t4oFfL
         GcDngrw+QPuloFqdtlTUJPQDSea/G2RKuIIxxHH9tGYvvvcoRorxSRoJZ8WLH1e2ZYKK
         4bPzAuXkQGRADKO6QRhORZALusdpW9mlscY++TweXQIXz9EKj/o6IwnOa2FVX2Ck2iAQ
         2l/w==
X-Gm-Message-State: ABy/qLYrjtBYFKMW3+NMzh47CFpCjeqdnvOLTt9oT29eIL9Cl9qwOu98
        RuK08pVNhV8kzRUeUTJSnslpigrRSXSNUOz/ODweW4R2GlBLsg==
X-Google-Smtp-Source: APBJJlH9Zt3gdvhmq1i8yEj+qg/u7Gs2dp8bd7HOb1u6g1X4ipRKMAQiiY8sjrPfNi5rESjl0vsCdRs1VByyoS6gVg8=
X-Received: by 2002:aa7:d452:0:b0:522:c877:5690 with SMTP id
 q18-20020aa7d452000000b00522c8775690mr984265edr.17.1690737072488; Sun, 30 Jul
 2023 10:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230729134318.1694467-1-keguang.zhang@gmail.com> <20230729134318.1694467-4-keguang.zhang@gmail.com>
In-Reply-To: <20230729134318.1694467-4-keguang.zhang@gmail.com>
From:   Du Huanpeng <u74147@gmail.com>
Date:   Mon, 31 Jul 2023 01:11:00 +0800
Message-ID: <CANvTkNbss+ovB_nXYvAXT9dZt4H1KsF41EQ4f3zHf1dEnpdreA@mail.gmail.com>
Subject: Re: [PATCH 03/17] MIPS: dts: Add basic DT support for Loongson-1 boards
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keguang Zhang <keguang.zhang@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8829=
=E6=97=A5=E5=91=A8=E5=85=AD 21:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Add initial devicetree for Loongson-1 boards, including
> LSGZ_1B_DEV and SMARTLOONG_1C board.
> These basic DTs contain CPU, clock and core INTC.
>
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  arch/mips/boot/dts/Makefile                   |  1 +
>  arch/mips/boot/dts/loongson/Makefile          |  3 +
>  arch/mips/boot/dts/loongson/loongson1.dtsi    | 22 ++++++
>  arch/mips/boot/dts/loongson/loongson1b.dtsi   | 75 +++++++++++++++++++
>  arch/mips/boot/dts/loongson/loongson1c.dtsi   | 29 +++++++
>  arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   | 25 +++++++
>  arch/mips/boot/dts/loongson/smartloong_1c.dts | 25 +++++++
>  7 files changed, 180 insertions(+)
>  create mode 100644 arch/mips/boot/dts/loongson/loongson1.dtsi
>  create mode 100644 arch/mips/boot/dts/loongson/loongson1b.dtsi
>  create mode 100644 arch/mips/boot/dts/loongson/loongson1c.dtsi
>  create mode 100644 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
>  create mode 100644 arch/mips/boot/dts/loongson/smartloong_1c.dts
>
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index 928f38a79dff..2e040b1ba97b 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -6,6 +6,7 @@ subdir-$(CONFIG_FIT_IMAGE_FDT_BOSTON)   +=3D img
>  subdir-$(CONFIG_MACH_INGENIC)          +=3D ingenic
>  subdir-$(CONFIG_LANTIQ)                        +=3D lantiq
>  subdir-$(CONFIG_MACH_LOONGSON64)       +=3D loongson
> +subdir-$(CONFIG_MACH_LOONGSON32)       +=3D loongson
>  subdir-$(CONFIG_SOC_VCOREIII)          +=3D mscc
>  subdir-$(CONFIG_MIPS_MALTA)            +=3D mti
>  subdir-$(CONFIG_LEGACY_BOARD_SEAD3)    +=3D mti
> diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/lo=
ongson/Makefile
> index 5c6433e441ee..9d95f1351d5f 100644
> --- a/arch/mips/boot/dts/loongson/Makefile
> +++ b/arch/mips/boot/dts/loongson/Makefile
> @@ -6,4 +6,7 @@ dtb-$(CONFIG_MACH_LOONGSON64)   +=3D loongson64c_8core_rs=
780e.dtb
>  dtb-$(CONFIG_MACH_LOONGSON64)  +=3D loongson64g_4core_ls7a.dtb
>  dtb-$(CONFIG_MACH_LOONGSON64)  +=3D loongson64v_4core_virtio.dtb
>
> +dtb-$(CONFIG_LOONGSON1B_LSGZ_DEV)      +=3D lsgz_1b_dev.dtb
> +dtb-$(CONFIG_LOONGSON1C_SMARTLOONG)    +=3D smartloong_1c.dtb
> +
>  obj-$(CONFIG_BUILTIN_DTB)      +=3D $(addsuffix .o, $(dtb-y))
> diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boot/=
dts/loongson/loongson1.dtsi
> new file mode 100644
> index 000000000000..a2b5c828bbbd
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/loongson,ls1x-clk.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       cpu_intc: interrupt-controller {
> +               compatible =3D "mti,cpu-interrupt-controller";
> +               #address-cells =3D <0>;
> +
> +               interrupt-controller;
> +               #interrupt-cells =3D <1>;
> +       };
> +};
> diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot=
/dts/loongson/loongson1b.dtsi
> new file mode 100644
> index 000000000000..784ae9b6572d
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "loongson1.dtsi"
> +
> +/ {
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               cpu@0 {
> +                       device_type =3D "cpu";
> +                       reg =3D <0>;
> +                       #clock-cells =3D <1>;
> +                       clocks =3D <&clkc LS1X_CLKID_CPU>;
> +                       operating-points-v2 =3D <&cpu_opp_table>;
> +               };
> +       };
> +
> +       cpu_opp_table: opp-table {
> +               compatible =3D "operating-points-v2";
> +               opp-shared;
> +
> +               opp-44000000 {
> +                       opp-hz =3D /bits/ 64 <44000000>;
> +               };
> +               opp-47142000 {
> +                       opp-hz =3D /bits/ 64 <47142000>;
> +               };
> +               opp-50769000 {
> +                       opp-hz =3D /bits/ 64 <50769000>;
> +               };
> +               opp-55000000 {
> +                       opp-hz =3D /bits/ 64 <55000000>;
> +               };
> +               opp-60000000 {
> +                       opp-hz =3D /bits/ 64 <60000000>;
> +               };
> +               opp-66000000 {
> +                       opp-hz =3D /bits/ 64 <66000000>;
> +               };
> +               opp-73333000 {
> +                       opp-hz =3D /bits/ 64 <73333000>;
> +               };
> +               opp-82500000 {
> +                       opp-hz =3D /bits/ 64 <82500000>;
> +               };
> +               opp-94285000 {
> +                       opp-hz =3D /bits/ 64 <94285000>;
> +               };
> +               opp-110000000 {
> +                       opp-hz =3D /bits/ 64 <110000000>;
> +               };
> +               opp-132000000 {
> +                       opp-hz =3D /bits/ 64 <132000000>;
> +               };
> +               opp-165000000 {
> +                       opp-hz =3D /bits/ 64 <165000000>;
> +               };
> +               opp-220000000 {
> +                       opp-hz =3D /bits/ 64 <220000000>;
> +               };
> +       };
> +
> +       clkc: clock-controller@1fe78030 {
> +               compatible =3D "loongson,ls1b-clk";
> +               reg =3D <0x1fe78030 0x8>;
> +
> +               clocks =3D <&xtal>;
> +               #clock-cells =3D <1>;
> +       };
> +};
> diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot=
/dts/loongson/loongson1c.dtsi
> new file mode 100644
> index 000000000000..d552e1668984
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "loongson1.dtsi"
> +
> +/ {
> +       cpus {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               cpu@0 {
> +                       device_type =3D "cpu";
> +                       reg =3D <0>;
> +                       #clock-cells =3D <1>;
> +                       clocks =3D <&clkc LS1X_CLKID_CPU>;
> +               };
> +       };
> +
> +       clkc: clock-controller@1fe78030 {
> +               compatible =3D "loongson,ls1c-clk";
> +               reg =3D <0x1fe78030 0x8>;
> +
> +               clocks =3D <&xtal>;
> +               #clock-cells =3D <1>;
> +       };
> +};
> diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot=
/dts/loongson/lsgz_1b_dev.dts
> new file mode 100644
> index 000000000000..d12c723b0a2b
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "loongson1b.dtsi"
> +
> +/ {
> +       compatible =3D "loongson,lsgz-1b-dev", "loongson,ls1b";
> +       model =3D "LSGZ_1B_DEV Board";
> +
> +       memory@0 {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x4000000>;
> +       };
> +
> +       xtal: xtal {
for your information, hope it helps:
in <devicetree-specification-v0.4.pdf> Page: 8
The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model. If appropriate,
 the name should be one of the following choices:
... clock ...

> +               compatible =3D "fixed-clock";
> +               clock-frequency =3D <33000000>;
> +               clock-output-names =3D "xtal";
> +               #clock-cells =3D <0>;
> +       };
> +};
> diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/bo=
ot/dts/loongson/smartloong_1c.dts
> new file mode 100644
> index 000000000000..64e869acfd86
> --- /dev/null
> +++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "loongson1c.dtsi"
> +
> +/ {
> +       compatible =3D "loongmasses,smartloong-1c", "loongson,ls1c";
> +       model =3D "Smartloong_1C Board";
> +
> +       memory@0 {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x2000000>;
> +       };
> +
> +       xtal: xtal {
> +               compatible =3D "fixed-clock";
> +               clock-frequency =3D <24000000>;
> +               clock-output-names =3D "xtal";
> +               #clock-cells =3D <0>;
> +       };
> +};
> --
> 2.39.2
>

---
Du Huanpeng
