Return-Path: <linux-kernel+bounces-126348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46F89356C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F49283D58
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17B1465AC;
	Sun, 31 Mar 2024 18:33:53 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AB2AE69;
	Sun, 31 Mar 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711910017; cv=none; b=k3F8sTvHbLabkV+DnW5sFphmBbEaSImn3M3AeuwgnRD7ENjd3qweWYn7GOc1Cb54kBLMCoQ+yhC0+yu0jQ5JOsj9n+xUi15GKxmrVthTfUdYoTYlB7YVOxsZdawHHSRGGmzjSGWI21yrBpoZ2rS894USn6pHbXj/iEkz8Qf3/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711910017; c=relaxed/simple;
	bh=/RFeDBNdnNUUKLg2LeCwuOsZUhtxYcu+I1cVL0Jroyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIPfVZ7+Opq38IpgEpMAeqIKQc+vfxmyvid/TcDhJe+rZ2aqJAoA8bi6pYfnauSG80y8F03sBbuHTP/XU9R/cbDuruNtVDyDZahL0tjWULWxX//njdRA+cF1zkSor3gk6+fPI8obXRGJPQsFpD64ULZAInhGjt5nQmayI6qpl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61431e25ca5so26427947b3.2;
        Sun, 31 Mar 2024 11:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711910006; x=1712514806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bp+BhSDEmMNM8iMU1nOEFbOUAbv8Fm8M8eGW13uvuk=;
        b=cuqgr1IrcA56d0i+tPlRN/kk1MnfILw/wszTwLsXmBHGIhhIHkw9MW+6Om0kPBA1FI
         GKbq0e+uHno8dBLLw4aX1qz4b9T4Re9IMwxfCAzv/pg5uJvrJdEFlUFWH8hBdeo87Qjh
         hvuc5pkWElTh1nl/GouWI4DRSRwsy25gn8xaXcAyGFwZvbNyQBKsgbu9Rt1TQX5C+/52
         n1wMUgtgmOU3efi5yNdSZN/Tt7twVBSsL5/W3hFi42ipK1QCZbfhsAUOQoIlUW5ZPKJy
         V0RTRwcYDg5IbKYylwsJKZlDT7HGKBGzKtldl1AqnXRtDoDdCr61XzsdDA3zIp+dC4ic
         SRVw==
X-Forwarded-Encrypted: i=1; AJvYcCWfGDBwi4LWv8VZWepO1RoAGzukDsjscHNo1yEP/cqsXOy5S3/UOb6sBZKLSyPYE1ZekZH8DFD3mDhRyi4gU6OkHWc4bt5IikXmhvBVyUYGKHnIPPxs68CLH0/H92a5gozJeceD3AMROSS6ezzm7cFCL8LLgMqWxADRbgUnfbsGA93AUA==
X-Gm-Message-State: AOJu0YzItCu4p/bl9/bcSYN+ajMM/dKguDFYd+GAnk08Ng75pLnt8LzX
	+DDB8Ba+Rzx5Gwh2WdjGYfP4PHSXzgVq4ZZuAK8BhEdWe2MosbFIwdJlCfpDKjv0Pg==
X-Google-Smtp-Source: AGHT+IFU/nXrK0hW3u18MTLPAIKSni3dXCcRyxR6bYHz3O98MCntXY3d95J6fnWuqWri2rHfq+jl0Q==
X-Received: by 2002:a81:4858:0:b0:60a:4fd7:f1d4 with SMTP id v85-20020a814858000000b0060a4fd7f1d4mr6819550ywa.24.1711910004544;
        Sun, 31 Mar 2024 11:33:24 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id i189-20020a8154c6000000b0060784b3bba8sm1906643ywb.35.2024.03.31.11.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 11:33:24 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61431e25ca5so26427727b3.2;
        Sun, 31 Mar 2024 11:33:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrBkRqJ3moRviqzn6i3I1C/1NQIo/S7B6Kn2FHyUBjHVSUTcQ9DBjYj0dBgHzoqjzQ9SL5PxLExE60rB19z8dYM3UlKL1XNpt5V5hFtHDU2+jYt3MQMQhvhOmnDP9YMXDGn1LBAOg9kcv9mbMZCX1Ca8ExpjdSCVLSqDJVRJUmElAeIw==
X-Received: by 2002:a05:690c:24a:b0:611:3105:93e5 with SMTP id
 ba10-20020a05690c024a00b00611310593e5mr6994034ywb.17.1711910003457; Sun, 31
 Mar 2024 11:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318114346.112935-1-tanure@linux.com> <20240318114346.112935-2-tanure@linux.com>
 <CAJX_Q+0n3vPV58Qk9iZ0TsZ1Q75w18c35hoPvSi5-D0NA8Cv2w@mail.gmail.com>
In-Reply-To: <CAJX_Q+0n3vPV58Qk9iZ0TsZ1Q75w18c35hoPvSi5-D0NA8Cv2w@mail.gmail.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Sun, 31 Mar 2024 19:33:10 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+0V=bXNPbDO8t6U4=A__b2FM4ByF_=myJRR-HoerAnGDA@mail.gmail.com>
Message-ID: <CAJX_Q+0V=bXNPbDO8t6U4=A__b2FM4ByF_=myJRR-HoerAnGDA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] clk: meson: T7: add support for Amlogic T7 SoC
 PLL clock driver
To: Xianwei Zhao <xianwei.zhao@amlogic.com>, Yu Tu <yu.tu@amlogic.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 7:25=E2=80=AFPM Lucas Tanure <tanure@linux.com> wro=
te:
>
> On Mon, Mar 18, 2024 at 11:44=E2=80=AFAM Lucas Tanure <tanure@linux.com> =
wrote:
> >
> > Add the T7 PLL clock controller driver in the T7 SoC family.
> >
> > This is RFC patch that enables SDCard, Ethernet and Clocking
> > for Amlogic T7 soc.
> > In this current state the patch doesn't work and gives a kernel
> > panic when probing the meson-axg-mmc for the SDCard.
> > DO NOT MERGE.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  drivers/clk/meson/Kconfig                     |   25 +
> >  drivers/clk/meson/Makefile                    |    2 +
> >  drivers/clk/meson/t7-peripherals.c            | 6368 +++++++++++++++++
> >  drivers/clk/meson/t7-peripherals.h            |  131 +
> >  drivers/clk/meson/t7-pll.c                    | 1543 ++++
> >  drivers/clk/meson/t7-pll.h                    |   83 +
> >  .../clock/amlogic,t7-peripherals-clkc.h       |  410 ++
> >  .../dt-bindings/clock/amlogic,t7-pll-clkc.h   |   69 +
> >  8 files changed, 8631 insertions(+)
> >  create mode 100644 drivers/clk/meson/t7-peripherals.c
> >  create mode 100644 drivers/clk/meson/t7-peripherals.h
> >  create mode 100644 drivers/clk/meson/t7-pll.c
> >  create mode 100644 drivers/clk/meson/t7-pll.h
> >  create mode 100644 include/dt-bindings/clock/amlogic,t7-peripherals-cl=
kc.h
> >  create mode 100644 include/dt-bindings/clock/amlogic,t7-pll-clkc.h
> >
> > diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> > index 29ffd14d267b..467b4bf86572 100644
> > --- a/drivers/clk/meson/Kconfig
> > +++ b/drivers/clk/meson/Kconfig
> > @@ -169,4 +169,29 @@ config COMMON_CLK_S4_PERIPHERALS
> >         help
> >           Support for the peripherals clock controller on Amlogic S805X=
2 and S905Y4
> >           devices, AKA S4. Say Y if you want S4 peripherals clock contr=
oller to work.
> > +
> > +config COMMON_CLK_T7_PLL
> > +       tristate "T7 SoC PLL clock controllers support"
> > +       depends on ARM64
> > +       default y
> > +       select COMMON_CLK_MESON_CLKC_UTILS
> > +       select COMMON_CLK_MESON_MPLL
> > +       select COMMON_CLK_MESON_PLL
> > +       select COMMON_CLK_MESON_REGMAP
> > +       help
> > +         Support for the PLL clock controller on Amlogic A113D2 device=
,AKA T7.
> > +         Say Y if you want the board to work, because PLLs are the par=
ent of
> > +         most peripherals.
> > +
> > +config COMMON_CLK_T7_PERIPHERALS
> > +       tristate "T7 SoC peripherals clock controllers support"
> > +       depends on ARM64
> > +       default y
> > +       select COMMON_CLK_MESON_CLKC_UTILS
> > +       select COMMON_CLK_MESON_REGMAP
> > +       select COMMON_CLK_MESON_DUALDIV
> > +       select COMMON_CLK_MESON_VID_PLL_DIV
> > +       help
> > +         Support for the peripherals clock controller on Amlogic A113D=
2 device, AKA T7.
> > +         Say Y if you want T7 peripherals clock controller to work.
> >  endmenu
> > diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> > index 9ee4b954c896..9a044b70a227 100644
> > --- a/drivers/clk/meson/Makefile
> > +++ b/drivers/clk/meson/Makefile
> > @@ -24,3 +24,5 @@ obj-$(CONFIG_COMMON_CLK_G12A) +=3D g12a.o g12a-aoclk.=
o
> >  obj-$(CONFIG_COMMON_CLK_MESON8B) +=3D meson8b.o meson8-ddr.o
> >  obj-$(CONFIG_COMMON_CLK_S4_PLL) +=3D s4-pll.o
> >  obj-$(CONFIG_COMMON_CLK_S4_PERIPHERALS) +=3D s4-peripherals.o
> > +obj-$(CONFIG_COMMON_CLK_T7_PLL) +=3D t7-pll.o
> > +obj-$(CONFIG_COMMON_CLK_T7_PERIPHERALS) +=3D t7-peripherals.o
> > diff --git a/drivers/clk/meson/t7-peripherals.c b/drivers/clk/meson/t7-=
peripherals.c
> > new file mode 100644
> > index 000000000000..f88fc2ae4dad
> > --- /dev/null
> > +++ b/drivers/clk/meson/t7-peripherals.c
> > @@ -0,0 +1,6368 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Amlogic Meson-T7 Clock Controller Driver
> > + *
> > + * Copyright (c) 2018 Amlogic, inc.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "clk-regmap.h"
> > +#include "vid-pll-div.h"
> > +#include "clk-dualdiv.h"
> > +#include "t7-peripherals.h"
> > +#include "meson-clkc-utils.h"
> > +#include <dt-bindings/clock/amlogic,t7-peripherals-clkc.h>
> > +
> > +
> > +/*
> > + *rtc 32k clock
> > + *
> > + *xtal--GATE------------------GATE---------------------|\
> > + *                   |  --------                      | \
> > + *                   |  |      |                      |  \
> > + *                   ---| DUAL |----------------------|   |
> > + *                      |      |                      |   |____GATE__
> > + *                      --------                      |   |     rtc_32=
k_out
> > + *        PAD-----------------------------------------|  /
> > + *                                                    | /
> > + *        DUAL function:                              |/
> > + *        bit 28 in RTC_BY_OSCIN_CTRL0 control the dual function.
> > + *        when bit 28 =3D 0
> > + *              f =3D 24M/N0
> > + *        when bit 28 =3D 1
> > + *              output N1 and N2 in turns.
> > + *        T =3D (x*T1 + y*T2)/x+y
> > + *        f =3D (24M/(N0*M0 + N1*M1)) * (M0 + M1)
> > + *        f: the frequecy value (HZ)
> > + *            |      | |      |
> > + *            | Div1 |-| Cnt1 |
> > + *           /|______| |______|\
> > + *         -|  ______   ______  ---> Out
> > + *           \|      | |      |/
> > + *            | Div2 |-| Cnt2 |
> > + *            |______| |______|
> > + **/
> > +
> > +/*
> > + * rtc 32k clock in gate
> > + */
> > +static struct clk_regmap t7_rtc_32k_clkin =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_RTC_BY_OSCIN_CTRL0,
> > +               .bit_idx =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "rtc_32k_clkin",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static const struct meson_clk_dualdiv_param t7_32k_div_table[] =3D {
> > +       {
> > +               .dual   =3D 1,
> > +               .n1     =3D 733,
> > +               .m1     =3D 8,
> > +               .n2     =3D 732,
> > +               .m2     =3D 11,
> > +       },
> > +       {}
> > +};
> > +
> > +static struct clk_regmap t7_rtc_32k_div =3D {
> > +       .data =3D &(struct meson_clk_dualdiv_data){
> > +               .n1 =3D {
> > +                       .reg_off =3D CLKCTRL_RTC_BY_OSCIN_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 12,
> > +               },
> > +               .n2 =3D {
> > +                       .reg_off =3D CLKCTRL_RTC_BY_OSCIN_CTRL0,
> > +                       .shift   =3D 12,
> > +                       .width   =3D 12,
> > +               },
> > +               .m1 =3D {
> > +                       .reg_off =3D CLKCTRL_RTC_BY_OSCIN_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 12,
> > +               },
> > +               .m2 =3D {
> > +                       .reg_off =3D CLKCTRL_RTC_BY_OSCIN_CTRL1,
> > +                       .shift   =3D 12,
> > +                       .width   =3D 12,
> > +               },
> > +               .dual =3D {
> > +                       .reg_off =3D CLKCTRL_RTC_BY_OSCIN_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_32k_div_table,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "rtc_32k_div",
> > +               .ops =3D &meson_clk_dualdiv_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_rtc_32k_clkin.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_rtc_32k_xtal =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_RTC_BY_OSCIN_CTRL1,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "rtc_32k_xtal",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_rtc_32k_clkin.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +/*
> > + * three parent for rtc clock out
> > + * pad is from where?
> > + */
> > +static u32 rtc_32k_sel[] =3D {0, 1};
> > +static struct clk_regmap t7_rtc_32k_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_RTC_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 0,
> > +               .table =3D rtc_32k_sel,
> > +               .flags =3D CLK_MUX_ROUND_CLOSEST,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "rtc_32k_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_rtc_32k_xtal.hw,
> > +                       &t7_rtc_32k_div.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_rtc_clk =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_RTC_BY_OSCIN_CTRL0,
> > +               .bit_idx =3D 30,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "rtc_clk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_rtc_32k_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/* sys clk */
> > +static u32 mux_table_sys_ab_clk_sel[] =3D { 0, 1, 2, 3, 4, 5, 7 };
> > +static const struct clk_parent_data t7_table_sys_ab_clk_sel[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "fclk_div2", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "axi_clk_frcpu", },
> > +       { .hw =3D &t7_rtc_clk.hw }
> > +};
> > +
> > +static struct clk_regmap t7_sysclk_b_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SYS_CLK_CTRL0,
> > +               .mask =3D 0x7,
> > +               .shift =3D 26,
> > +               .table =3D mux_table_sys_ab_clk_sel,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sysclk_b_sel",
> > +               .ops =3D &clk_regmap_mux_ro_ops,
> > +               .parent_data =3D t7_table_sys_ab_clk_sel,
> > +               .num_parents =3D ARRAY_SIZE(t7_table_sys_ab_clk_sel),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sysclk_b_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SYS_CLK_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sysclk_b_div",
> > +               .ops =3D &clk_regmap_divider_ro_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sysclk_b_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sysclk_b =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SYS_CLK_CTRL0,
> > +               .bit_idx =3D 29,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sysclk_b",
> > +               .ops =3D &clk_regmap_gate_ro_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sysclk_b_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sysclk_a_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SYS_CLK_CTRL0,
> > +               .mask =3D 0x7,
> > +               .shift =3D 10,
> > +               .table =3D mux_table_sys_ab_clk_sel,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sysclk_a_sel",
> > +               .ops =3D &clk_regmap_mux_ro_ops,
> > +               .parent_data =3D t7_table_sys_ab_clk_sel,
> > +               .num_parents =3D ARRAY_SIZE(t7_table_sys_ab_clk_sel),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sysclk_a_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SYS_CLK_CTRL0,
> > +               .shift =3D 0,
> > +               .width =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sysclk_a_div",
> > +               .ops =3D &clk_regmap_divider_ro_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sysclk_a_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sysclk_a =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SYS_CLK_CTRL0,
> > +               .bit_idx =3D 13,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sysclk_a",
> > +               .ops =3D &clk_regmap_gate_ro_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sysclk_a_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sys_clk =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SYS_CLK_CTRL0,
> > +               .mask =3D 0x1,
> > +               .shift =3D 15,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sys_clk",
> > +               .ops =3D &clk_regmap_mux_ro_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sysclk_a.hw,
> > +                       &t7_sysclk_b.hw,
> > +               },
> > +               .num_parents =3D 2,
> > +       },
> > +};
> > +
> > +/*axi clk*/
> > +
> > +/*ceca_clk*/
> > +static struct clk_regmap t7_ceca_32k_clkin =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_CECA_CTRL0,
> > +               .bit_idx =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "ceca_32k_clkin",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_ceca_32k_div =3D {
> > +       .data =3D &(struct meson_clk_dualdiv_data){
> > +               .n1 =3D {
> > +                       .reg_off =3D CLKCTRL_CECA_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 12,
> > +               },
> > +               .n2 =3D {
> > +                       .reg_off =3D CLKCTRL_CECA_CTRL0,
> > +                       .shift   =3D 12,
> > +                       .width   =3D 12,
> > +               },
> > +               .m1 =3D {
> > +                       .reg_off =3D CLKCTRL_CECA_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 12,
> > +               },
> > +               .m2 =3D {
> > +                       .reg_off =3D CLKCTRL_CECA_CTRL1,
> > +                       .shift   =3D 12,
> > +                       .width   =3D 12,
> > +               },
> > +               .dual =3D {
> > +                       .reg_off =3D CLKCTRL_CECA_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_32k_div_table,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "ceca_32k_div",
> > +               .ops =3D &meson_clk_dualdiv_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_ceca_32k_clkin.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_ceca_32k_sel_pre =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_CECA_CTRL1,
> > +               .mask =3D 0x1,
> > +               .shift =3D 24,
> > +               .flags =3D CLK_MUX_ROUND_CLOSEST,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "ceca_32k_sel_pre",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_ceca_32k_div.hw,
> > +                       &t7_ceca_32k_clkin.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_ceca_32k_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_CECA_CTRL1,
> > +               .mask =3D 0x1,
> > +               .shift =3D 31,
> > +               .flags =3D CLK_MUX_ROUND_CLOSEST,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "ceca_32k_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_ceca_32k_sel_pre.hw,
> > +                       &t7_rtc_clk.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_ceca_32k_clkout =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_CECA_CTRL0,
> > +               .bit_idx =3D 30,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "ceca_32k_clkout",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_ceca_32k_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/*cecb_clk*/
> > +static struct clk_regmap t7_cecb_32k_clkin =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_CECB_CTRL0,
> > +               .bit_idx =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "cecb_32k_clkin",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cecb_32k_div =3D {
> > +       .data =3D &(struct meson_clk_dualdiv_data){
> > +               .n1 =3D {
> > +                       .reg_off =3D CLKCTRL_CECB_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 12,
> > +               },
> > +               .n2 =3D {
> > +                       .reg_off =3D CLKCTRL_CECB_CTRL0,
> > +                       .shift   =3D 12,
> > +                       .width   =3D 12,
> > +               },
> > +               .m1 =3D {
> > +                       .reg_off =3D CLKCTRL_CECB_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 12,
> > +               },
> > +               .m2 =3D {
> > +                       .reg_off =3D CLKCTRL_CECB_CTRL1,
> > +                       .shift   =3D 12,
> > +                       .width   =3D 12,
> > +               },
> > +               .dual =3D {
> > +                       .reg_off =3D CLKCTRL_CECB_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_32k_div_table,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "cecb_32k_div",
> > +               .ops =3D &meson_clk_dualdiv_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_cecb_32k_clkin.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cecb_32k_sel_pre =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_CECB_CTRL1,
> > +               .mask =3D 0x1,
> > +               .shift =3D 24,
> > +               .flags =3D CLK_MUX_ROUND_CLOSEST,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "cecb_32k_sel_pre",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_cecb_32k_div.hw,
> > +                       &t7_cecb_32k_clkin.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cecb_32k_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_CECB_CTRL1,
> > +               .mask =3D 0x1,
> > +               .shift =3D 31,
> > +               .flags =3D CLK_MUX_ROUND_CLOSEST,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "cecb_32k_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_cecb_32k_sel_pre.hw,
> > +                       &t7_rtc_clk.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cecb_32k_clkout =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_CECB_CTRL0,
> > +               .bit_idx =3D 30,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "cecb_32k_clkout",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_cecb_32k_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data t7_sc_parent_data[] =3D {
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "xtal", }
> > +};
> > +
> > +static struct clk_regmap t7_sc_clk_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SC_CLK_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sc_clk_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_sc_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_sc_parent_data),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sc_clk_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SC_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sc_clk_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sc_clk_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sc_clk_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SC_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sc_clk_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sc_clk_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/*rama_clk*/
> > +
> > +/*dspa_clk*/
> > +static const struct clk_parent_data t7_dsp_parent_hws[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "fclk_div2p5", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "hifi_pll", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div7", },
> > +       { .hw =3D &t7_rtc_clk.hw }
> > +};
> > +
> > +static struct clk_regmap t7_dspa_a_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_DSPA_CLK_CTRL0,
> > +               .mask =3D 0x7,
> > +               .shift =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspa_a_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dsp_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dsp_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspa_a_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_DSPA_CLK_CTRL0,
> > +               .shift =3D 0,
> > +               .width =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspa_a_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspa_a_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspa_a_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_DSPA_CLK_CTRL0,
> > +               .bit_idx =3D 13,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dspa_a_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspa_a_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspa_b_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_DSPA_CLK_CTRL0,
> > +               .mask =3D 0x7,
> > +               .shift =3D 26,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspa_b_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dsp_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dsp_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspa_b_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_DSPA_CLK_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspa_b_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspa_b_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspa_b_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_DSPA_CLK_CTRL0,
> > +               .bit_idx =3D 29,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dspa_b_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspa_b_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspa_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_DSPA_CLK_CTRL0,
> > +               .mask =3D 0x1,
> > +               .shift =3D 15,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspa_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspa_a_gate.hw,
> > +                       &t7_dspa_b_gate.hw,
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspb_a_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_DSPB_CLK_CTRL0,
> > +               .mask =3D 0x7,
> > +               .shift =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspb_a_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dsp_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dsp_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspb_a_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_DSPB_CLK_CTRL0,
> > +               .shift =3D 0,
> > +               .width =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspb_a_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspb_a_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspb_a_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_DSPB_CLK_CTRL0,
> > +               .bit_idx =3D 13,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dspb_a_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspb_a_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspb_b_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_DSPB_CLK_CTRL0,
> > +               .mask =3D 0x7,
> > +               .shift =3D 26,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspb_b_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dsp_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dsp_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspb_b_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_DSPB_CLK_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspb_b_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspb_b_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspb_b_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_DSPB_CLK_CTRL0,
> > +               .bit_idx =3D 29,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dspb_b_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspb_b_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dspb_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_DSPB_CLK_CTRL0,
> > +               .mask =3D 0x1,
> > +               .shift =3D 15,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dspb_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dspb_a_gate.hw,
> > +                       &t7_dspb_b_gate.hw,
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/*12_24M clk*/
> > +static struct clk_regmap t7_24M_clk_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_CLK12_24_CTRL,
> > +               .bit_idx =3D 11,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "24m",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_12M_clk_div =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "24m_div2",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_24M_clk_gate.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_12M_clk_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_CLK12_24_CTRL,
> > +               .bit_idx =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "12m",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_12M_clk_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_25M_clk_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_CLK12_24_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "25M_clk_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "fclk_div2",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_25M_clk_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_CLK12_24_CTRL,
> > +               .bit_idx =3D 12,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "25m",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_25M_clk_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/* Video Clocks */
> > +static struct clk_regmap t7_vid_pll_div =3D {
> > +       .data =3D &(struct meson_vid_pll_div_data){
> > +               .val =3D {
> > +                       .reg_off =3D CLKCTRL_VID_PLL_CLK0_DIV,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 15,
> > +               },
> > +               .sel =3D {
> > +                       .reg_off =3D CLKCTRL_VID_PLL_CLK0_DIV,
> > +                       .shift   =3D 16,
> > +                       .width   =3D 2,
> > +               },
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vid_pll_div",
> > +               .ops =3D &meson_vid_pll_div_ro_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "hdmi_pll",
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data t7_vid_pll_parent_data[] =3D {
> > +       { .hw =3D &t7_vid_pll_div.hw, },
> > +       { .fw_name =3D "hdmi_pll", },
> > +};
> > +
> > +static struct clk_regmap t7_vid_pll_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VID_PLL_CLK0_DIV,
> > +               .mask =3D 0x1,
> > +               .shift =3D 18,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vid_pll_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               /*
> > +                * bit 18 selects from 2 possible parents:
> > +                * vid_pll_div or hdmi_pll
> > +                */
> > +               .parent_data =3D t7_vid_pll_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vid_pll_parent_data),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCA=
CHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vid_pll =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_PLL_CLK0_DIV,
> > +               .bit_idx =3D 19,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vid_pll",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vid_pll_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data t7_vclk_parent_data[] =3D {
> > +       { .hw =3D &t7_vid_pll.hw },
> > +       { .fw_name =3D "gp0_pll", },
> > +       { .fw_name =3D "hifi_pll", },
> > +       { .fw_name =3D "mpll1", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7" },
> > +};
> > +
> > +static struct clk_regmap t7_vclk_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 16,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vclk_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vclk_parent_data),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCA=
CHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 16,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk2_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vclk_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vclk_parent_data),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCA=
CHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk_input =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_DIV,
> > +               .bit_idx =3D 16,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk_input",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk_se=
l.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2_input =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_DIV,
> > +               .bit_idx =3D 16,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk2_input",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk2_s=
el.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_DIV,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk_input.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_DIV,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk2_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk2_input.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_CTRL,
> > +               .bit_idx =3D 19,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk_di=
v.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_CTRL,
> > +               .bit_idx =3D 19,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk2",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk2_d=
iv.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk_div1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_CTRL,
> > +               .bit_idx =3D 0,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk_div1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk.hw=
 },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk_div2_en =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_CTRL,
> > +               .bit_idx =3D 1,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk_div2_en",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk.hw=
 },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk_div4_en =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_CTRL,
> > +               .bit_idx =3D 2,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk_div4_en",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk.hw=
 },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk_div6_en =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_CTRL,
> > +               .bit_idx =3D 3,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk_div6_en",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk.hw=
 },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk_div12_en =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_CTRL,
> > +               .bit_idx =3D 4,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk_div12_en",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk.hw=
 },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2_div1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_CTRL,
> > +               .bit_idx =3D 0,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk2_div1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk2.h=
w },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2_div2_en =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_CTRL,
> > +               .bit_idx =3D 1,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk2_div2_en",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk2.h=
w },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2_div4_en =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_CTRL,
> > +               .bit_idx =3D 2,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk2_div4_en",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk2.h=
w },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2_div6_en =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_CTRL,
> > +               .bit_idx =3D 3,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk2_div6_en",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk2.h=
w },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vclk2_div12_en =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VIID_CLK0_CTRL,
> > +               .bit_idx =3D 4,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vclk2_div12_en",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vclk2.h=
w },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_vclk_div2 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk_div2",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk_div2_en.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_vclk_div4 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 4,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk_div4",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk_div4_en.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_vclk_div6 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 6,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk_div6",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk_div6_en.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_vclk_div12 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 12,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk_div12",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk_div12_en.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_vclk2_div2 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk2_div2",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk2_div2_en.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_vclk2_div4 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 4,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk2_div4",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk2_div4_en.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_vclk2_div6 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 6,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk2_div6",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk2_div6_en.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_vclk2_div12 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 12,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vclk2_div12",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vclk2_div12_en.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static u32 mux_table_cts_sel[] =3D { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 }=
;
> > +static const struct clk_hw *t7_cts_parent_hws[] =3D {
> > +       &t7_vclk_div1.hw,
> > +       &t7_vclk_div2.hw,
> > +       &t7_vclk_div4.hw,
> > +       &t7_vclk_div6.hw,
> > +       &t7_vclk_div12.hw,
> > +       &t7_vclk2_div1.hw,
> > +       &t7_vclk2_div2.hw,
> > +       &t7_vclk2_div4.hw,
> > +       &t7_vclk2_div6.hw,
> > +       &t7_vclk2_div12.hw
> > +};
> > +
> > +static struct clk_regmap t7_cts_enci_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VID_CLK0_DIV,
> > +               .mask =3D 0xf,
> > +               .shift =3D 28,
> > +               .table =3D mux_table_cts_sel,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "cts_enci_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D t7_cts_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_cts_parent_hws),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCA=
CHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cts_encp_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VID_CLK1_DIV,
> > +               .mask =3D 0xf,
> > +               .shift =3D 20,
> > +               .table =3D mux_table_cts_sel,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "cts_encp_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D t7_cts_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_cts_parent_hws),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCA=
CHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cts_vdac_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VIID_CLK1_DIV,
> > +               .mask =3D 0xf,
> > +               .shift =3D 28,
> > +               .table =3D mux_table_cts_sel,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "cts_vdac_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D t7_cts_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_cts_parent_hws),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCA=
CHE,
> > +       },
> > +};
> > +
> > +/* TOFIX: add support for cts_tcon */
> > +static u32 mux_table_hdmi_tx_sel[] =3D { 0, 1, 2, 3, 4, 8, 9, 10, 11, =
12 };
> > +static const struct clk_hw *t7_cts_hdmi_tx_parent_hws[] =3D {
> > +       &t7_vclk_div1.hw,
> > +       &t7_vclk_div2.hw,
> > +       &t7_vclk_div4.hw,
> > +       &t7_vclk_div6.hw,
> > +       &t7_vclk_div12.hw,
> > +       &t7_vclk2_div1.hw,
> > +       &t7_vclk2_div2.hw,
> > +       &t7_vclk2_div4.hw,
> > +       &t7_vclk2_div6.hw,
> > +       &t7_vclk2_div12.hw
> > +};
> > +
> > +static struct clk_regmap t7_hdmi_tx_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HDMI_CLK_CTRL,
> > +               .mask =3D 0xf,
> > +               .shift =3D 16,
> > +               .table =3D mux_table_hdmi_tx_sel,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmi_tx_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D t7_cts_hdmi_tx_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_cts_hdmi_tx_parent_hws),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCA=
CHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cts_enci =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK2_CTRL2,
> > +               .bit_idx =3D 0,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "cts_enci",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_cts_enci_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cts_encp =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK2_CTRL2,
> > +               .bit_idx =3D 2,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "cts_encp",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_cts_encp_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_cts_vdac =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK2_CTRL2,
> > +               .bit_idx =3D 4,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "cts_vdac",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_cts_vdac_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmi_tx =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_CLK2_CTRL2,
> > +               .bit_idx =3D 5,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmi_tx",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hdmi_tx_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data t7_hdmitx_sys_parent_data[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div5", }
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_sys_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HDMI_CLK_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmitx_sys_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_sys_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HDMI_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmitx_sys_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmitx_=
sys_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_sys =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HDMI_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmitx_sys",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmitx_=
sys.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_prif_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL0,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmitx_prif_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_prif_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL0,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmitx_prif_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmitx_=
prif_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_prif =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL0,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmitx_prif",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmitx_=
prif.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_200m_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL0,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmitx_200m_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_200m_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmitx_200m_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmitx_=
200m_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_200m =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL0,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmitx_200m",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmitx_=
200m.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_aud_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL1,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmitx_aud_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_aud_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL1,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmitx_aud_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmitx_=
aud_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmitx_aud  =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HTX_CLK_CTRL1,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmitx_aud",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmitx_=
aud_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_5m_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL0,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_5m_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_5m_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL0,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_5m_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
5m_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_5m  =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL0,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmirx_5m",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
5m_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_2m_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL0,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_2m_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_2m_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_2m_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
2m_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_2m =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL0,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmirx_2m",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
2m_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_cfg_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL1,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_cfg_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_cfg_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL1,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_cfg_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
cfg_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_cfg  =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL1,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmirx_cfg",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
cfg_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_hdcp_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL1,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_hdcp_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_hdcp_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL1,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_hdcp_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
hdcp_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_hdcp =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL1,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmirx_hdcp",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
hdcp_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_aud_pll_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL2,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_aud_pll_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_aud_pll_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL2,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_aud_pll_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
aud_pll_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_aud_pll  =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL2,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmirx_aud_pll",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
aud_pll_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_acr_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL2,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_acr_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_acr_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL2,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_acr_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
acr_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_acr =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL2,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmirx_acr",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
acr_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_meter_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL3,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_meter_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_hdmitx_sys_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_hdmitx_sys_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_meter_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL3,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmirx_meter_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
meter_sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmirx_meter  =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_HRX_CLK_CTRL3,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hdmirx_meter",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_hdmirx_=
meter_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vid_lock_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VID_LOCK_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vid_lock_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vid_lock_clk  =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VID_LOCK_CLK_CTRL,
> > +               .bit_idx =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vid_lock_clk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vid_loc=
k_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_ts_clk_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_TS_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "ts_clk_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_ts_clk_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_TS_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "ts_clk_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_ts_clk_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +/*mali_clk*/
> > +/*
> > + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
> > + * muxed by a glitch-free switch on Meson8b and Meson8m2 and later.
> > + *
> > + * CLK_SET_RATE_PARENT is added for mali_0_sel clock
> > + * 1.gp0 pll only support the 846M, avoid other rate 500/400M from it
> > + * 2.hifi pll is used for other module, skip it, avoid some rate from =
it
> > + */
> > +static u32 mux_table_mali[] =3D { 0, 3, 4, 5, 6};
> > +
> > +static const struct clk_parent_data t7_mali_0_1_parent_data[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "fclk_div2p5", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +};
> > +
> > +static struct clk_regmap t7_mali_0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_MALI_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +               .table =3D mux_table_mali,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mali_0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_mali_0_1_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_mali_0_1_parent_data),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mali_0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_MALI_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mali_0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mali_0_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mali_0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_MALI_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mali_0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mali_0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mali_1_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_MALI_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +               .table =3D mux_table_mali,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mali_1_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_mali_0_1_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_mali_0_1_parent_data),
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mali_1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_MALI_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mali_1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mali_1_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mali_1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_MALI_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mali_1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mali_1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct clk_hw *t7_mali_parent_hws[] =3D {
> > +       &t7_mali_0.hw,
> > +       &t7_mali_1.hw
> > +};
> > +
> > +static struct clk_regmap t7_mali_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_MALI_CLK_CTRL,
> > +               .mask =3D 1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mali",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D t7_mali_parent_hws,
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/* cts_vdec_clk */
> > +static const struct clk_parent_data t7_dec_parent_hws[] =3D {
> > +       { .fw_name =3D "fclk_div2p5", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +       { .fw_name =3D "hifi_pll", },
> > +       { .fw_name =3D "gp0_pll", },
> > +       { .fw_name =3D "xtal", }
> > +};
> > +
> > +static struct clk_regmap t7_vdec_p0_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vdec_p0_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dec_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dec_parent_hws),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vdec_p0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDEC_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vdec_p0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vdec_p0_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vdec_p0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDEC_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vdec_p0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vdec_p0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vdec_p1_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC3_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vdec_p1_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dec_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dec_parent_hws),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vdec_p1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDEC3_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vdec_p1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vdec_p1_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vdec_p1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDEC3_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vdec_p1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vdec_p1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vdec_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC3_CLK_CTRL,
> > +               .mask =3D 0x1,
> > +               .shift =3D 15,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vdec_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vdec_p0.hw,
> > +                       &t7_vdec_p1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hcodec_p0_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hcodec_p0_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dec_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dec_parent_hws),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hcodec_p0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDEC_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hcodec_p0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hcodec_p0_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hcodec_p0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDEC_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hcodec_p0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hcodec_p0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hcodec_p1_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC3_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hcodec_p1_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dec_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dec_parent_hws),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hcodec_p1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDEC3_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hcodec_p1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hcodec_p1_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hcodec_p1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDEC3_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hcodec_p1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hcodec_p1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hcodec_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC3_CLK_CTRL,
> > +               .mask =3D 0x1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hcodec_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hcodec_p0.hw,
> > +                       &t7_hcodec_p1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static u32 mux_table_vdec[] =3D { 0, 1, 2, 3, 4};
> > +
> > +static const struct clk_parent_data t7_vdec_parent_data[] =3D {
> > +       { .fw_name =3D "fclk_div2p5", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +};
> > +
> > +static struct clk_regmap t7_hevcb_p0_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC2_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +               .flags =3D CLK_MUX_ROUND_CLOSEST,
> > +               .table =3D mux_table_vdec,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hevcb_p0_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vdec_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vdec_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcb_p0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDEC2_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +               .flags =3D CLK_DIVIDER_ROUND_CLOSEST,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hevcb_p0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcb_p0_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcb_p0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDEC2_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevcb_p0_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcb_p0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcb_p1_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC4_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevcb_p1_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vdec_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vdec_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcb_p1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDEC4_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevc_p1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcb_p1_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcb_p1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDEC4_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hevcb_p1_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcb_p1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcb_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC4_CLK_CTRL,
> > +               .mask =3D 0x1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevcb_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcb_p0.hw,
> > +                       &t7_hevcb_p1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcf_p0_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC2_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevcf_p0_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dec_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dec_parent_hws),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcf_p0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDEC2_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevcf_p0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcf_p0_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcf_p0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDEC2_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hevcf_p0_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcf_p0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcf_p1_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC4_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevcf_p1_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dec_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_dec_parent_hws),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcf_p1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDEC4_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevcf_p1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcf_p1_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcf_p1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDEC4_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hevcf_p1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcf_p1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hevcf_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDEC4_CLK_CTRL,
> > +               .mask =3D 0x1,
> > +               .shift =3D 15,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "hevcf_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hevcf_p0.hw,
> > +                       &t7_hevcf_p1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/*cts_wave420l_a/b/c_clk*/
> > +static const struct clk_parent_data t7_wave_parent_data[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +       { .fw_name =3D "mpll2", },
> > +       { .fw_name =3D "mpll3", },
> > +       { .fw_name =3D "gp1_pll", }
> > +};
> > +
> > +static struct clk_regmap t7_wave_a_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL2,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "wave_a_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_wave_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_wave_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_wave_a_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL2,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "wave_a_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_wave_a_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_wave_aclk =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL2,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "wave_aclk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_wave_a_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_wave_b_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "wave_b_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_wave_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_wave_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_wave_b_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "wave_b_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_wave_b_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_wave_bclk =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "wave_bclk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_wave_b_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_wave_c_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "wave_c_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_wave_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_wave_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_wave_c_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "wave_c_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_wave_c_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_wave_cclk =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_WAVE521_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "wave_cclk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_wave_c_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_isp_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_MIPI_ISP_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mipi_isp_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               /* Share parent with wave clk */
> > +               .parent_data =3D t7_wave_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_wave_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_isp_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_MIPI_ISP_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mipi_isp_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mipi_isp_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_isp =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_MIPI_ISP_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "mipi_isp",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mipi_isp_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data t7_mipi_csi_parent_data[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "hifi_pll", },
> > +       { .fw_name =3D "mpll1", },
> > +       { .fw_name =3D "mpll2", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", }
> > +};
> > +
> > +static struct clk_regmap t7_mipi_csi_phy_sel0 =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_MIPI_CSI_PHY_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mipi_csi_phy_sel0",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_mipi_csi_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_mipi_csi_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_csi_phy_div0 =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_MIPI_CSI_PHY_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mipi_csi_phy_div0",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mipi_csi_phy_sel0.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_csi_phy0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_MIPI_CSI_PHY_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "mipi_csi_phy0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mipi_csi_phy_div0.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_csi_phy_sel1 =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_MIPI_CSI_PHY_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mipi_csi_phy_sel1",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_mipi_csi_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_mipi_csi_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_csi_phy_div1 =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_MIPI_CSI_PHY_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mipi_csi_phy_div1",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mipi_csi_phy_sel1.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_csi_phy1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_MIPI_CSI_PHY_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "mipi_csi_phy1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mipi_csi_phy_div1.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mipi_csi_phy_clk =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_MIPI_CSI_PHY_CLK_CTRL,
> > +               .mask =3D 0x1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mipi_csi_phy_clk",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mipi_csi_phy0.hw,
> > +                       &t7_mipi_csi_phy1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data t7_vpu_parent_data[] =3D {
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VPU_CLK_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu_0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vpu_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vpu_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VPU_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu_0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vpu_0_s=
el.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VPU_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vpu_0_d=
iv.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_1_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VPU_CLK_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu_1_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vpu_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vpu_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VPU_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu_1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vpu_1_s=
el.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VPU_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vpu_1_d=
iv.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VPU_CLK_CTRL,
> > +               .mask =3D 1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               /*
> > +                * bit 31 selects from 2 possible parents:
> > +                * vpu_0 or vpu_1
> > +                */
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_0.hw,
> > +                       &t7_vpu_1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data vpu_clkb_tmp_parent_data[] =3D {
> > +       { .hw =3D &t7_vpu.hw, },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkb_tmp_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VPU_CLKB_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 20,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_clkb_tmp_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D vpu_clkb_tmp_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(vpu_clkb_tmp_parent_data),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkb_tmp_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VPU_CLKB_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 4,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_clkb_tmp_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkb_tmp_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkb_tmp =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VPU_CLKB_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu_clkb_tmp",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkb_tmp_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkb_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VPU_CLKB_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_clkb_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkb_tmp.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkb =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VPU_CLKB_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu_clkb",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkb_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data vpu_clkc_parent_data[] =3D {
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkc_p0_mux  =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VPU_CLKC_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_clkc_p0_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D vpu_clkc_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(vpu_clkc_parent_data),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkc_p0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VPU_CLKC_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_clkc_p0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkc_p0_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkc_p0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VPU_CLKC_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu_clkc_p0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkc_p0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkc_p1_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VPU_CLKC_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_clkc_p1_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D vpu_clkc_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(vpu_clkc_parent_data),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkc_p1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VPU_CLKC_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_clkc_p1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkc_p1_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkc_p1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VPU_CLKC_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vpu_clkc_p1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkc_p1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vpu_clkc_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VPU_CLKC_CTRL,
> > +               .mask =3D 0x1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vpu_clkc_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vpu_clkc_p0.hw,
> > +                       &t7_vpu_clkc_p1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static u32 t7_vapb_table[] =3D { 0, 1, 2, 3, 7};
> > +static const struct clk_parent_data t7_vapb_parent_data[] =3D {
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +       { .fw_name =3D "fclk_div2p5", },
> > +};
> > +
> > +static struct clk_regmap t7_vapb_0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VAPBCLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +               .table =3D t7_vapb_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vapb_0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vapb_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vapb_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vapb_0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VAPBCLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vapb_0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vapb_0_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vapb_0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VAPBCLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vapb_0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vapb_0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vapb_1_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VAPBCLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vapb_1_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vapb_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vapb_parent_data),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vapb_1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VAPBCLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vapb_1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vapb_1_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vapb_1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VAPBCLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vapb_1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vapb_1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vapb =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VAPBCLK_CTRL,
> > +               .mask =3D 1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vapb_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vapb_0.hw,
> > +                       &t7_vapb_1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARE=
NT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gdcclk_0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_GDC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +               .table =3D t7_vapb_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gdcclk_0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               /* Share parent with vapb clk */
> > +               .parent_data =3D t7_vapb_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vapb_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gdcclk_0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_GDC_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gdcclk_0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gdcclk_0_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gdcclk_0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_GDC_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "gdcclk_0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_gdcclk_=
0_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gdcclk_1_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_GDC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gdcclk_1_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vapb_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vapb_parent_data),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gdcclk_1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_GDC_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gdcclk_1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gdcclk_1_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gdcclk_1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_GDC_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "gdcclk_1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gdcclk_1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gdcclk =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_GDC_CLK_CTRL,
> > +               .mask =3D 1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gdcclk_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gdcclk_0.hw,
> > +                       &t7_gdcclk_1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARE=
NT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gdc_clk =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_GDC_CLK_CTRL,
> > +               .bit_idx =3D 30,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "gdc_clk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gdcclk.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dewarpclk_0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_AMLGDC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +               .table =3D t7_vapb_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dewarpclk_0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               /* Share parent with vapb clk */
> > +               .parent_data =3D t7_vapb_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vapb_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dewarpclk_0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_AMLGDC_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dewarpclk_0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dewarpclk_0_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dewarpclk_0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_AMLGDC_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dewarpclk_0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_dewarpc=
lk_0_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dewarpclk_1_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_AMLGDC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dewarpclk_1_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vapb_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_vapb_parent_data),
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dewarpclk_1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_AMLGDC_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dewarpclk_1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dewarpclk_1_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dewarpclk_1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_AMLGDC_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dewarpclk_1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dewarpclk_1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dewarpclk =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_AMLGDC_CLK_CTRL,
> > +               .mask =3D 1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dewarpclk_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dewarpclk_0.hw,
> > +                       &t7_dewarpclk_1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARE=
NT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dewarp_clk =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_AMLGDC_CLK_CTRL,
> > +               .bit_idx =3D 30,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "dewarp_clk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dewarpclk.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static u32 t7_anakin_table[] =3D { 0, 1, 2, 3, 7};
> > +static const struct clk_parent_data t7_anakin_parent_data[] =3D {
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div2", },
> > +       { .fw_name =3D "fclk_div2p5", },
> > +};
> > +
> > +static struct clk_regmap t7_anakin_0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_ANAKIN_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +               .table =3D t7_anakin_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "anakin_0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_anakin_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_anakin_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_anakin_0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_ANAKIN_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "anakin_0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_anakin_0_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_anakin_0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_ANAKIN_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "anakin_0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_anakin_=
0_div.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_anakin_1_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_ANAKIN_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "anakin_1_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_anakin_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_anakin_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_anakin_1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_ANAKIN_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "anakin_1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_anakin_1_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_anakin_1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_ANAKIN_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "anakin_1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_anakin_1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_anakin =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_ANAKIN_CLK_CTRL,
> > +               .mask =3D 1,
> > +               .shift =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "anakin_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_anakin_0.hw,
> > +                       &t7_anakin_1.hw
> > +               },
> > +               .num_parents =3D 2,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_anakin_clk =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_ANAKIN_CLK_CTRL,
> > +               .bit_idx =3D 30,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "anakin_clk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_anakin.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_ge2d_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VAPBCLK_CTRL,
> > +               .bit_idx =3D 30,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "ge2d_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_vapb.hw=
 },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +/*cts_hdcp22_esmclk*/
> > +
> > +/*cts_hdcp22_skpclk*/
> > +
> > +/* cts_vdin_meas_clk */
> > +static const struct clk_parent_data t7_vdin_parent_hws[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .hw =3D &t7_vid_pll.hw }
> > +};
> > +
> > +static struct clk_regmap t7_vdin_meas_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_VDIN_MEAS_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vdin_meas_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_vdin_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_vdin_parent_hws),
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vdin_meas_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_VDIN_MEAS_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "vdin_meas_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vdin_meas_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_vdin_meas_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_VDIN_MEAS_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "vdin_meas_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_vdin_meas_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data t7_sd_emmc_clk0_parent_data[] =3D =
{
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "fclk_div2", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "hifi_pll", },
> > +       { .fw_name =3D "fclk_div2p5", },
> > +       { .fw_name =3D "mpll2", },
> > +       { .fw_name =3D "mpll3", },
> > +       { .fw_name =3D "gp0_pll", }
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_c_clk0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_NAND_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sd_emmc_c_clk0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_sd_emmc_clk0_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_sd_emmc_clk0_parent_data=
),
> > +               .flags =3D CLK_GET_RATE_NOCACHE
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_c_clk0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_NAND_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sd_emmc_c_clk0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sd_emmc_c_clk0_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_c_clk0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_NAND_CLK_CTRL,
> > +               .bit_idx =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sd_emmc_c_clk0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sd_emmc_c_clk0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_a_clk0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SD_EMMC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sd_emmc_a_clk0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_sd_emmc_clk0_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_sd_emmc_clk0_parent_data=
),
> > +               .flags =3D CLK_GET_RATE_NOCACHE
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_a_clk0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SD_EMMC_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sd_emmc_a_clk0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sd_emmc_a_clk0_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_a_clk0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SD_EMMC_CLK_CTRL,
> > +               .bit_idx =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sd_emmc_a_clk0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sd_emmc_a_clk0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_b_clk0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SD_EMMC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sd_emmc_b_clk0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_sd_emmc_clk0_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_sd_emmc_clk0_parent_data=
),
> > +               .flags =3D CLK_GET_RATE_NOCACHE
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_b_clk0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SD_EMMC_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "sd_emmc_b_clk0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sd_emmc_b_clk0_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sd_emmc_b_clk0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SD_EMMC_CLK_CTRL,
> > +               .bit_idx =3D 23,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sd_emmc_b_clk0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sd_emmc_b_clk0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +/*cts_cdac_clk*/
> > +
> > +static const struct clk_parent_data t7_spicc_parent_hws[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .hw =3D &t7_sys_clk.hw },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div2", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +       { .fw_name =3D "hifi_pll", }
> > +};
> > +
> > +static struct clk_regmap t7_spicc0_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc0_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_spicc_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_spicc_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc0_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc0_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc0_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc0_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL,
> > +               .bit_idx =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "spicc0_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc0_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc1_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL,
> > +               .mask =3D 0x7,
> > +               .shift =3D 23,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc1_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_spicc_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_spicc_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc1_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc1_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc1_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc1_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL,
> > +               .bit_idx =3D 22,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "spicc1_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc1_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc2_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL1,
> > +               .mask =3D 0x7,
> > +               .shift =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc2_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_spicc_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_spicc_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc2_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL1,
> > +               .shift =3D 0,
> > +               .width =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc2_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc2_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc2_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL1,
> > +               .bit_idx =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "spicc2_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc2_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc3_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL1,
> > +               .mask =3D 0x7,
> > +               .shift =3D 23,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc3_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_spicc_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_spicc_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc3_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL1,
> > +               .shift =3D 16,
> > +               .width =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc3_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc3_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc3_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL1,
> > +               .bit_idx =3D 22,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "spicc3_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc3_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc4_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL2,
> > +               .mask =3D 0x7,
> > +               .shift =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc4_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_spicc_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_spicc_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc4_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL2,
> > +               .shift =3D 0,
> > +               .width =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc4_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc4_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc4_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL2,
> > +               .bit_idx =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "spicc4_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc4_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc5_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL2,
> > +               .mask =3D 0x7,
> > +               .shift =3D 23,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc5_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_spicc_parent_hws,
> > +               .num_parents =3D ARRAY_SIZE(t7_spicc_parent_hws),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc5_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL2,
> > +               .shift =3D 16,
> > +               .width =3D 6,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "spicc5_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc5_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_spicc5_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_SPICC_CLK_CTRL2,
> > +               .bit_idx =3D 22,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "spicc5_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_spicc5_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/*cts_bt656*/
> > +
> > +static const struct clk_parent_data t7_pwm_parent_data[]  =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .hw =3D &t7_vid_pll.hw },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3",  }
> > +};
> > +
> > +static struct clk_regmap t7_pwm_a_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AB_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_a_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +               .flags =3D CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_a_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AB_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_a_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_a_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_a_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AB_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_a_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_a_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_b_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AB_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_b_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +               .flags =3D CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_b_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AB_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_b_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_b_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_b_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AB_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_b_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_b_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_c_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_CD_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_c_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +               .flags =3D CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_c_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_CD_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_c_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_c_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_c_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_CD_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_c_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_c_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_d_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_CD_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_d_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +               .flags =3D CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_d_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_CD_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_d_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_d_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_d_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_CD_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_d_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_d_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_e_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_EF_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_e_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +               .flags =3D CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_e_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_EF_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_e_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_e_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_e_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_EF_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_e_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_e_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_f_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_EF_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_f_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +               .flags =3D CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_f_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_EF_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_f_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_f_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_f_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_EF_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_f_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_f_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_a_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_AB_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_a_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_a_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_AB_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_a_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_a_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_a_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_AB_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_a_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_a_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_b_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_AB_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_b_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_b_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_AB_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_b_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_b_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_b_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_AB_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_b_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_b_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_c_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_CD_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_c_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_c_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_CD_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_c_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_c_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_c_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_CD_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_c_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_c_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_d_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_CD_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_d_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_d_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_CD_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_d_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_d_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_d_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_CD_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_d_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_d_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_e_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_EF_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_e_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_e_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_EF_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_e_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_e_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_e_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_EF_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_e_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_e_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               /*The clock feeds the GPU,it should be always on*/
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_f_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_EF_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_f_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_f_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_EF_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_f_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_f_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_f_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_EF_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_f_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_f_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_g_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_GH_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_g_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_g_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_GH_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_g_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_g_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_g_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_GH_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_g_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_g_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               /*This clock feeds the DDR,it should be always on.*/
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_h_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_GH_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_h_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_pwm_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_pwm_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_h_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_GH_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_h_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_h_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pwm_ao_h_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_PWM_CLK_AO_GH_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pwm_ao_h_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pwm_ao_h_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static u32 t7_dsi_meas_table[] =3D { 0, 1, 2, 3, 6, 7};
> > +
> > +static const struct clk_parent_data t7_dsi_meas_parent_data[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div2", },
> > +       { .fw_name =3D "fclk_div7", }
> > +};
> > +
> > +static struct clk_regmap t7_dsi_a_meas_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_MIPI_DSI_MEAS_CLK_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +               .table =3D t7_dsi_meas_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi_a_meas_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dsi_meas_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_dsi_meas_parent_data)
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi_a_meas_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_MIPI_DSI_MEAS_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi_a_meas_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dsi_a_meas_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi_a_meas_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_MIPI_DSI_MEAS_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi_a_meas_clk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dsi_a_meas_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               /* config it in U-boot, ignore it to avoid display abno=
rmal */
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi_b_meas_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_MIPI_DSI_MEAS_CLK_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 21,
> > +               .table =3D t7_dsi_meas_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi_b_meas_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dsi_meas_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_dsi_meas_parent_data)
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi_b_meas_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_MIPI_DSI_MEAS_CLK_CTRL,
> > +               .shift =3D 12,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi_b_meas_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dsi_b_meas_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi_b_meas_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_MIPI_DSI_MEAS_CLK_CTRL,
> > +               .bit_idx =3D 20,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi_b_meas_clk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dsi_b_meas_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               /* config it in U-boot, ignore it to avoid display abno=
rmal */
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static u32 t7_dsi_phy_table[] =3D { 4, 5, 6, 7};
> > +static const struct clk_parent_data t7_dsi_phy_parent_data[] =3D {
> > +       { .fw_name =3D "fclk_div2", },
> > +       { .fw_name =3D "fclk_div2p5", },
> > +       { .fw_name =3D "fclk_div3",  },
> > +       { .fw_name =3D "fclk_div7", },
> > +};
> > +
> > +static struct clk_regmap t7_dsi0_phy_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_MIPIDSI_PHY_CLK_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 12,
> > +               .table =3D t7_dsi_phy_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi0_phy_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dsi_phy_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_dsi_phy_parent_data)
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi0_phy_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_MIPIDSI_PHY_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi0_phy_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dsi0_phy_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi0_phy_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_MIPIDSI_PHY_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi0_phy_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dsi0_phy_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               /* config it in U-boot, ignore it to avoid display abno=
rmal */
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi1_phy_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_MIPIDSI_PHY_CLK_CTRL,
> > +               .mask =3D 0x3,
> > +               .shift =3D 25,
> > +               .table =3D t7_dsi_phy_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi1_phy_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_dsi_phy_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_dsi_phy_parent_data)
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi1_phy_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_MIPIDSI_PHY_CLK_CTRL,
> > +               .shift =3D 16,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi1_phy_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dsi1_phy_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_dsi1_phy_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_MIPIDSI_PHY_CLK_CTRL,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "dsi1_phy_gate",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_dsi1_phy_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               /* config it in U-boot, ignore it to avoid display abno=
rmal */
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_eth_rmii_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_ETH_CLK_CTRL,
> > +               .mask =3D 0x1,
> > +               .shift =3D 9,
> > +               .table =3D t7_dsi_phy_table
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "eth_rmii_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D (const struct clk_parent_data []) {
> > +                       { .fw_name =3D "fclk_div2", },
> > +                       { .fw_name =3D "gp1_pll", }
> > +               },
> > +               .num_parents =3D 2
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_eth_rmii_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_ETH_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "eth_rmii_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_eth_rmii_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_eth_rmii =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_ETH_CLK_CTRL,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "eth_rmii",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_eth_rmii_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_eth_div8 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 8,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "eth_div8",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "fclk_div2",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_eth_125m =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_ETH_CLK_CTRL,
> > +               .bit_idx =3D 7,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "eth_125m",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_eth_div8.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_saradc_mux =3D {
> > +       .data =3D &(struct clk_regmap_mux_data) {
> > +               .offset =3D CLKCTRL_SAR_CLK_CTRL0,
> > +               .mask =3D 0x3,
> > +               .shift =3D 9,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "saradc_mux",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D (const struct clk_parent_data []) {
> > +                       { .fw_name =3D "xtal", },
> > +                       { .hw =3D &t7_sys_clk.hw },
> > +               },
> > +               .num_parents =3D 2,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_saradc_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data) {
> > +               .offset =3D CLKCTRL_SAR_CLK_CTRL0,
> > +               .shift =3D 0,
> > +               .width =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "saradc_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_saradc_mux.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_saradc_gate =3D {
> > +       .data =3D &(struct clk_regmap_gate_data) {
> > +               .offset =3D CLKCTRL_SAR_CLK_CTRL0,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "saradc_clk",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_saradc_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/* gen clk */
> > +static u32 t7_gen_clk_mux_table[] =3D { 0, 5, 6, 7, 19, 21, 22,
> > +                               23, 24, 25, 26, 27, 28 };
> > +
> > +static const struct clk_parent_data t7_gen_clk_parent_data[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .fw_name =3D "gp0_pll", },
> > +       { .fw_name =3D "gp1_pll", },
> > +       { .fw_name =3D "hifi_pll", },
> > +       { .fw_name =3D "fclk_div2", },
> > +       { .fw_name =3D "fclk_div3", },
> > +       { .fw_name =3D "fclk_div4", },
> > +       { .fw_name =3D "fclk_div5", },
> > +       { .fw_name =3D "fclk_div7", },
> > +       { .fw_name =3D "mpll0", },
> > +       { .fw_name =3D "mpll1", },
> > +       { .fw_name =3D "mpll2", },
> > +       { .fw_name =3D "mpll3", }
> > +};
> > +
> > +static struct clk_regmap t7_gen_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D CLKCTRL_GEN_CLK_CTRL,
> > +               .mask =3D 0x1f,
> > +               .shift =3D 12,
> > +               .table =3D t7_gen_clk_mux_table,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gen_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D t7_gen_clk_parent_data,
> > +               .num_parents =3D ARRAY_SIZE(t7_gen_clk_parent_data),
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gen_div =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D CLKCTRL_GEN_CLK_CTRL,
> > +               .shift =3D 0,
> > +               .width =3D 11,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gen_div",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gen_sel.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gen =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D CLKCTRL_GEN_CLK_CTRL,
> > +               .bit_idx =3D 11,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "gen",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gen_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +#define MESON_T7_SYS_GATE(_name, _reg, _bit)                          =
 \
> > +struct clk_regmap _name =3D {                                         =
   \
> > +       .data =3D &(struct clk_regmap_gate_data) {                     =
   \
> > +               .offset =3D (_reg),                                    =
   \
> > +               .bit_idx =3D (_bit),                                   =
   \
> > +       },                                                             =
 \
> > +       .hw.init =3D &(struct clk_init_data) {                         =
   \
> > +               .name =3D #_name,                                      =
   \
> > +               .ops =3D &clk_regmap_gate_ops,                         =
   \
> > +               .parent_hws =3D (const struct clk_hw *[]) {            =
   \
> > +                       &t7_sys_clk.hw                                 =
 \
> > +               },                                                     =
 \
> > +               .num_parents =3D 1,                                    =
   \
> > +               .flags =3D CLK_IGNORE_UNUSED,                          =
   \
> > +       },                                                             =
 \
> > +}
> > +
> > +/*CLKCTRL_SYS_CLK_EN0_REG0*/
> > +static MESON_T7_SYS_GATE(t7_ddr,               CLKCTRL_SYS_CLK_EN0_REG=
0, 0);
> > +static MESON_T7_SYS_GATE(t7_dos,               CLKCTRL_SYS_CLK_EN0_REG=
0, 1);
> > +static MESON_T7_SYS_GATE(t7_mipi_dsi_a,        CLKCTRL_SYS_CLK_EN0_REG=
0, 2);
> > +static MESON_T7_SYS_GATE(t7_mipi_dsi_b,        CLKCTRL_SYS_CLK_EN0_REG=
0, 3);
> > +static MESON_T7_SYS_GATE(t7_ethphy,            CLKCTRL_SYS_CLK_EN0_REG=
0, 4);
> > +static MESON_T7_SYS_GATE(t7_mali,              CLKCTRL_SYS_CLK_EN0_REG=
0, 6);
> > +static MESON_T7_SYS_GATE(t7_aocpu,             CLKCTRL_SYS_CLK_EN0_REG=
0, 13);
> > +static MESON_T7_SYS_GATE(t7_aucpu,             CLKCTRL_SYS_CLK_EN0_REG=
0, 14);
> > +static MESON_T7_SYS_GATE(t7_cec,               CLKCTRL_SYS_CLK_EN0_REG=
0, 16);
> > +static MESON_T7_SYS_GATE(t7_gdc,               CLKCTRL_SYS_CLK_EN0_REG=
0, 17);
> > +static MESON_T7_SYS_GATE(t7_deswarp,           CLKCTRL_SYS_CLK_EN0_REG=
0, 18);
> > +static MESON_T7_SYS_GATE(t7_ampipe_nand,       CLKCTRL_SYS_CLK_EN0_REG=
0, 19);
> > +static MESON_T7_SYS_GATE(t7_ampipe_eth,        CLKCTRL_SYS_CLK_EN0_REG=
0, 20);
> > +static MESON_T7_SYS_GATE(t7_am2axi0,           CLKCTRL_SYS_CLK_EN0_REG=
0, 21);
> > +static MESON_T7_SYS_GATE(t7_am2axi1,           CLKCTRL_SYS_CLK_EN0_REG=
0, 22);
> > +static MESON_T7_SYS_GATE(t7_am2axi2,           CLKCTRL_SYS_CLK_EN0_REG=
0, 23);
> > +static MESON_T7_SYS_GATE(t7_sdemmca,           CLKCTRL_SYS_CLK_EN0_REG=
0, 24);
> > +static MESON_T7_SYS_GATE(t7_sdemmcb,           CLKCTRL_SYS_CLK_EN0_REG=
0, 25);
> > +static MESON_T7_SYS_GATE(t7_sdemmcc,           CLKCTRL_SYS_CLK_EN0_REG=
0, 26);
> > +static MESON_T7_SYS_GATE(t7_smartcard,         CLKCTRL_SYS_CLK_EN0_REG=
0, 27);
> > +static MESON_T7_SYS_GATE(t7_acodec,            CLKCTRL_SYS_CLK_EN0_REG=
0, 28);
> > +static MESON_T7_SYS_GATE(t7_spifc,             CLKCTRL_SYS_CLK_EN0_REG=
0, 29);
> > +static MESON_T7_SYS_GATE(t7_msr_clk,           CLKCTRL_SYS_CLK_EN0_REG=
0, 30);
> > +static MESON_T7_SYS_GATE(t7_ir_ctrl,           CLKCTRL_SYS_CLK_EN0_REG=
0, 31);
> > +
> > +/*CLKCTRL_SYS_CLK_EN0_REG1*/
> > +static MESON_T7_SYS_GATE(t7_audio,             CLKCTRL_SYS_CLK_EN0_REG=
1, 0);
> > +static MESON_T7_SYS_GATE(t7_eth,               CLKCTRL_SYS_CLK_EN0_REG=
1, 3);
> > +static MESON_T7_SYS_GATE(t7_uart_a,            CLKCTRL_SYS_CLK_EN0_REG=
1, 5);
> > +static MESON_T7_SYS_GATE(t7_uart_b,            CLKCTRL_SYS_CLK_EN0_REG=
1, 6);
> > +static MESON_T7_SYS_GATE(t7_uart_c,            CLKCTRL_SYS_CLK_EN0_REG=
1, 7);
> > +static MESON_T7_SYS_GATE(t7_uart_d,            CLKCTRL_SYS_CLK_EN0_REG=
1, 8);
> > +static MESON_T7_SYS_GATE(t7_uart_e,            CLKCTRL_SYS_CLK_EN0_REG=
1, 9);
> > +static MESON_T7_SYS_GATE(t7_uart_f,            CLKCTRL_SYS_CLK_EN0_REG=
1, 10);
> > +static MESON_T7_SYS_GATE(t7_aififo,            CLKCTRL_SYS_CLK_EN0_REG=
1, 11);
> > +static MESON_T7_SYS_GATE(t7_spicc2,            CLKCTRL_SYS_CLK_EN0_REG=
1, 12);
> > +static MESON_T7_SYS_GATE(t7_spicc3,            CLKCTRL_SYS_CLK_EN0_REG=
1, 13);
> > +static MESON_T7_SYS_GATE(t7_spicc4,            CLKCTRL_SYS_CLK_EN0_REG=
1, 14);
> > +static MESON_T7_SYS_GATE(t7_ts_a73,            CLKCTRL_SYS_CLK_EN0_REG=
1, 15);
> > +static MESON_T7_SYS_GATE(t7_ts_a53,            CLKCTRL_SYS_CLK_EN0_REG=
1, 16);
> > +static MESON_T7_SYS_GATE(t7_spicc5,            CLKCTRL_SYS_CLK_EN0_REG=
1, 17);
> > +static MESON_T7_SYS_GATE(t7_g2d,               CLKCTRL_SYS_CLK_EN0_REG=
1, 20);
> > +static MESON_T7_SYS_GATE(t7_spicc0,            CLKCTRL_SYS_CLK_EN0_REG=
1, 21);
> > +static MESON_T7_SYS_GATE(t7_spicc1,            CLKCTRL_SYS_CLK_EN0_REG=
1, 22);
> > +static MESON_T7_SYS_GATE(t7_pcie,              CLKCTRL_SYS_CLK_EN0_REG=
1, 24);
> > +static MESON_T7_SYS_GATE(t7_usb,               CLKCTRL_SYS_CLK_EN0_REG=
1, 26);
> > +static MESON_T7_SYS_GATE(t7_pcie_phy,          CLKCTRL_SYS_CLK_EN0_REG=
1, 27);
> > +static MESON_T7_SYS_GATE(t7_i2c_ao_a,          CLKCTRL_SYS_CLK_EN0_REG=
1, 28);
> > +static MESON_T7_SYS_GATE(t7_i2c_ao_b,          CLKCTRL_SYS_CLK_EN0_REG=
1, 29);
> > +static MESON_T7_SYS_GATE(t7_i2c_m_a,           CLKCTRL_SYS_CLK_EN0_REG=
1, 30);
> > +static MESON_T7_SYS_GATE(t7_i2c_m_b,           CLKCTRL_SYS_CLK_EN0_REG=
1, 31);
> > +
> > +/*CLKCTRL_SYS_CLK_EN0_REG2*/
> > +static MESON_T7_SYS_GATE(t7_i2c_m_c,           CLKCTRL_SYS_CLK_EN0_REG=
2, 0);
> > +static MESON_T7_SYS_GATE(t7_i2c_m_d,           CLKCTRL_SYS_CLK_EN0_REG=
2, 1);
> > +static MESON_T7_SYS_GATE(t7_i2c_m_e,           CLKCTRL_SYS_CLK_EN0_REG=
2, 2);
> > +static MESON_T7_SYS_GATE(t7_i2c_m_f,           CLKCTRL_SYS_CLK_EN0_REG=
2, 3);
> > +static MESON_T7_SYS_GATE(t7_hdmitx_apb,        CLKCTRL_SYS_CLK_EN0_REG=
2, 4);
> > +static MESON_T7_SYS_GATE(t7_i2c_s_a,           CLKCTRL_SYS_CLK_EN0_REG=
2, 5);
> > +static MESON_T7_SYS_GATE(t7_hdmirx_pclk,       CLKCTRL_SYS_CLK_EN0_REG=
2, 8);
> > +static MESON_T7_SYS_GATE(t7_mmc_apb,           CLKCTRL_SYS_CLK_EN0_REG=
2, 11);
> > +static MESON_T7_SYS_GATE(t7_mipi_isp_pclk,     CLKCTRL_SYS_CLK_EN0_REG=
2, 17);
> > +static MESON_T7_SYS_GATE(t7_rsa,               CLKCTRL_SYS_CLK_EN0_REG=
2, 18);
> > +static MESON_T7_SYS_GATE(t7_pclk_sys_cpu_apb,  CLKCTRL_SYS_CLK_EN0_REG=
2, 19);
> > +static MESON_T7_SYS_GATE(t7_a73pclk_cpu_apb,   CLKCTRL_SYS_CLK_EN0_REG=
2, 20);
> > +static MESON_T7_SYS_GATE(t7_dspa,              CLKCTRL_SYS_CLK_EN0_REG=
2, 21);
> > +static MESON_T7_SYS_GATE(t7_dspb,              CLKCTRL_SYS_CLK_EN0_REG=
2, 22);
> > +static MESON_T7_SYS_GATE(t7_vpu_intr,          CLKCTRL_SYS_CLK_EN0_REG=
2, 25);
> > +static MESON_T7_SYS_GATE(t7_sar_adc,           CLKCTRL_SYS_CLK_EN0_REG=
2, 28);
> > +static MESON_T7_SYS_GATE(t7_gic,               CLKCTRL_SYS_CLK_EN0_REG=
2, 30);
> > +static MESON_T7_SYS_GATE(t7_ts_gpu,            CLKCTRL_SYS_CLK_EN0_REG=
2, 31);
> > +
> > +/*CLKCTRL_SYS_CLK_EN0_REG3*/
> > +static MESON_T7_SYS_GATE(t7_ts_nna,            CLKCTRL_SYS_CLK_EN0_REG=
3, 0);
> > +static MESON_T7_SYS_GATE(t7_ts_vpu,            CLKCTRL_SYS_CLK_EN0_REG=
3, 1);
> > +static MESON_T7_SYS_GATE(t7_ts_hevc,           CLKCTRL_SYS_CLK_EN0_REG=
3, 2);
> > +static MESON_T7_SYS_GATE(t7_pwm_ao_ab,         CLKCTRL_SYS_CLK_EN0_REG=
3, 3);
> > +static MESON_T7_SYS_GATE(t7_pwm_ao_cd,         CLKCTRL_SYS_CLK_EN0_REG=
3, 4);
> > +static MESON_T7_SYS_GATE(t7_pwm_ao_ef,         CLKCTRL_SYS_CLK_EN0_REG=
3, 5);
> > +static MESON_T7_SYS_GATE(t7_pwm_ao_gh,         CLKCTRL_SYS_CLK_EN0_REG=
3, 6);
> > +static MESON_T7_SYS_GATE(t7_pwm_ab,            CLKCTRL_SYS_CLK_EN0_REG=
3, 7);
> > +static MESON_T7_SYS_GATE(t7_pwm_cd,            CLKCTRL_SYS_CLK_EN0_REG=
3, 8);
> > +static MESON_T7_SYS_GATE(t7_pwm_ef,            CLKCTRL_SYS_CLK_EN0_REG=
3, 9);
> > +
> > +/* Array of all clocks provided by this provider */
> > +static struct clk_hw *t7_periphs_hw_clks[] =3D {
> > +       [CLKID_RTC_32K_CLKIN]           =3D &t7_rtc_32k_clkin.hw,
> > +       [CLKID_RTC_32K_DIV]             =3D &t7_rtc_32k_div.hw,
> > +       [CLKID_RTC_32K_XATL]            =3D &t7_rtc_32k_xtal.hw,
> > +       [CLKID_RTC_32K_MUX]             =3D &t7_rtc_32k_sel.hw,
> > +       [CLKID_RTC_CLK]                 =3D &t7_rtc_clk.hw,
> > +       [CLKID_SYS_CLK_B_MUX]           =3D &t7_sysclk_b_sel.hw,
> > +       [CLKID_SYS_CLK_B_DIV]           =3D &t7_sysclk_b_div.hw,
> > +       [CLKID_SYS_CLK_B_GATE]          =3D &t7_sysclk_b.hw,
> > +       [CLKID_SYS_CLK_A_MUX]           =3D &t7_sysclk_a_sel.hw,
> > +       [CLKID_SYS_CLK_A_DIV]           =3D &t7_sysclk_a_div.hw,
> > +       [CLKID_SYS_CLK_A_GATE]          =3D &t7_sysclk_a.hw,
> > +       [CLKID_SYS_CLK]                 =3D &t7_sys_clk.hw,
> > +       [CLKID_CECA_32K_CLKIN]          =3D &t7_ceca_32k_clkin.hw,
> > +       [CLKID_CECA_32K_DIV]            =3D &t7_ceca_32k_div.hw,
> > +       [CLKID_CECA_32K_MUX_PRE]        =3D &t7_ceca_32k_sel_pre.hw,
> > +       [CLKID_CECA_32K_MUX]            =3D &t7_ceca_32k_sel.hw,
> > +       [CLKID_CECA_32K_CLKOUT]         =3D &t7_ceca_32k_clkout.hw,
> > +       [CLKID_CECB_32K_CLKIN]          =3D &t7_cecb_32k_clkin.hw,
> > +       [CLKID_CECB_32K_DIV]            =3D &t7_cecb_32k_div.hw,
> > +       [CLKID_CECB_32K_MUX_PRE]        =3D &t7_cecb_32k_sel_pre.hw,
> > +       [CLKID_CECB_32K_MUX]            =3D &t7_cecb_32k_sel.hw,
> > +       [CLKID_CECB_32K_CLKOUT]         =3D &t7_cecb_32k_clkout.hw,
> > +       [CLKID_SC_CLK_MUX]              =3D &t7_sc_clk_mux.hw,
> > +       [CLKID_SC_CLK_DIV]              =3D &t7_sc_clk_div.hw,
> > +       [CLKID_SC_CLK_GATE]             =3D &t7_sc_clk_gate.hw,
> > +       [CLKID_DSPA_CLK_B_MUX]          =3D &t7_dspa_b_mux.hw,
> > +       [CLKID_DSPA_CLK_B_DIV]          =3D &t7_dspa_b_div.hw,
> > +       [CLKID_DSPA_CLK_B_GATE]         =3D &t7_dspa_b_gate.hw,
> > +       [CLKID_DSPA_CLK_A_MUX]          =3D &t7_dspa_a_mux.hw,
> > +       [CLKID_DSPA_CLK_A_DIV]          =3D &t7_dspa_a_div.hw,
> > +       [CLKID_DSPA_CLK_A_GATE]         =3D &t7_dspa_a_gate.hw,
> > +       [CLKID_DSPA_CLK]                =3D &t7_dspa_mux.hw,
> > +       [CLKID_DSPB_CLK_B_MUX]          =3D &t7_dspb_b_mux.hw,
> > +       [CLKID_DSPB_CLK_B_DIV]          =3D &t7_dspb_b_div.hw,
> > +       [CLKID_DSPB_CLK_B_GATE]         =3D &t7_dspb_b_gate.hw,
> > +       [CLKID_DSPB_CLK_A_MUX]          =3D &t7_dspb_a_mux.hw,
> > +       [CLKID_DSPB_CLK_A_DIV]          =3D &t7_dspb_a_div.hw,
> > +       [CLKID_DSPB_CLK_A_GATE]         =3D &t7_dspb_a_gate.hw,
> > +       [CLKID_DSPB_CLK]                =3D &t7_dspb_mux.hw,
> > +       [CLKID_24M_CLK_GATE]            =3D &t7_24M_clk_gate.hw,
> > +       [CLKID_12M_CLK_DIV]             =3D &t7_12M_clk_div.hw,
> > +       [CLKID_12M_CLK_GATE]            =3D &t7_12M_clk_gate.hw,
> > +       [CLKID_25M_CLK_DIV]             =3D &t7_25M_clk_div.hw,
> > +       [CLKID_25M_CLK_GATE]            =3D &t7_25M_clk_gate.hw,
> > +       [CLKID_VID_PLL]                 =3D &t7_vid_pll_div.hw,
> > +       [CLKID_VID_PLL_MUX]             =3D &t7_vid_pll_sel.hw,
> > +       [CLKID_VID_PLL]                 =3D &t7_vid_pll.hw,
> > +       [CLKID_VCLK_MUX]                =3D &t7_vclk_sel.hw,
> > +       [CLKID_VCLK2_MUX]               =3D &t7_vclk2_sel.hw,
> > +       [CLKID_VCLK_INPUT]              =3D &t7_vclk_input.hw,
> > +       [CLKID_VCLK2_INPUT]             =3D &t7_vclk2_input.hw,
> > +       [CLKID_VCLK_DIV]                =3D &t7_vclk_div.hw,
> > +       [CLKID_VCLK2_DIV]               =3D &t7_vclk2_div.hw,
> > +       [CLKID_VCLK]                    =3D &t7_vclk.hw,
> > +       [CLKID_VCLK2]                   =3D &t7_vclk2.hw,
> > +       [CLKID_VCLK_DIV1]               =3D &t7_vclk_div1.hw,
> > +       [CLKID_VCLK_DIV2_EN]            =3D &t7_vclk_div2_en.hw,
> > +       [CLKID_VCLK_DIV4_EN]            =3D &t7_vclk_div4_en.hw,
> > +       [CLKID_VCLK_DIV6_EN]            =3D &t7_vclk_div6_en.hw,
> > +       [CLKID_VCLK_DIV12_EN]           =3D &t7_vclk_div12_en.hw,
> > +       [CLKID_VCLK2_DIV1]              =3D &t7_vclk2_div1.hw,
> > +       [CLKID_VCLK2_DIV2_EN]           =3D &t7_vclk2_div2_en.hw,
> > +       [CLKID_VCLK2_DIV4_EN]           =3D &t7_vclk2_div4_en.hw,
> > +       [CLKID_VCLK2_DIV6_EN]           =3D &t7_vclk2_div6_en.hw,
> > +       [CLKID_VCLK2_DIV12_EN]          =3D &t7_vclk2_div12_en.hw,
> > +       [CLKID_VCLK_DIV2]               =3D &t7_vclk_div2.hw,
> > +       [CLKID_VCLK_DIV4]               =3D &t7_vclk_div4.hw,
> > +       [CLKID_VCLK_DIV6]               =3D &t7_vclk_div6.hw,
> > +       [CLKID_VCLK_DIV12]              =3D &t7_vclk_div12.hw,
> > +       [CLKID_VCLK2_DIV2]              =3D &t7_vclk2_div2.hw,
> > +       [CLKID_VCLK2_DIV4]              =3D &t7_vclk2_div4.hw,
> > +       [CLKID_VCLK2_DIV6]              =3D &t7_vclk2_div6.hw,
> > +       [CLKID_VCLK2_DIV12]             =3D &t7_vclk2_div12.hw,
> > +       [CLKID_CTS_ENCI_MUX]            =3D &t7_cts_enci_sel.hw,
> > +       [CLKID_CTS_ENCP_MUX]            =3D &t7_cts_encp_sel.hw,
> > +       [CLKID_CTS_VDAC_MUX]            =3D &t7_cts_vdac_sel.hw,
> > +       [CLKID_HDMI_TX_MUX]             =3D &t7_hdmi_tx_sel.hw,
> > +       [CLKID_CTS_ENCI]                =3D &t7_cts_enci.hw,
> > +       [CLKID_CTS_ENCP]                =3D &t7_cts_encp.hw,
> > +       [CLKID_CTS_VDAC]                =3D &t7_cts_vdac.hw,
> > +       [CLKID_HDMI_TX]                 =3D &t7_hdmi_tx.hw,
> > +       [CLKID_HDMITX_SYS_MUX]          =3D &t7_hdmitx_sys_sel.hw,
> > +       [CLKID_HDMITX_SYS_DIV]          =3D &t7_hdmitx_sys_div.hw,
> > +       [CLKID_HDMITX_SYS]              =3D &t7_hdmitx_sys.hw,
> > +       [CLKID_HDMITX_PRIF_MUX]         =3D &t7_hdmitx_prif_sel.hw,
> > +       [CLKID_HDMITX_PRIF_DIV]         =3D &t7_hdmitx_prif_div.hw,
> > +       [CLKID_HDMITX_PRIF]             =3D &t7_hdmitx_prif.hw,
> > +       [CLKID_HDMITX_200M_MUX]         =3D &t7_hdmitx_200m_sel.hw,
> > +       [CLKID_HDMITX_200M_DIV]         =3D &t7_hdmitx_200m_div.hw,
> > +       [CLKID_HDMITX_200M]             =3D &t7_hdmitx_200m.hw,
> > +       [CLKID_HDMITX_AUD_MUX]          =3D &t7_hdmitx_aud_sel.hw,
> > +       [CLKID_HDMITX_AUD_DIV]          =3D &t7_hdmitx_aud_div.hw,
> > +       [CLKID_HDMITX_AUD]              =3D &t7_hdmitx_aud.hw,
> > +       [CLKID_HDMIRX_5M_MUX]           =3D &t7_hdmirx_5m_sel.hw,
> > +       [CLKID_HDMIRX_5M_DIV]           =3D &t7_hdmirx_5m_div.hw,
> > +       [CLKID_HDMIRX_5M]               =3D &t7_hdmirx_5m.hw,
> > +       [CLKID_HDMIRX_2M_MUX]           =3D &t7_hdmirx_2m_sel.hw,
> > +       [CLKID_HDMIRX_2M_DIV]           =3D &t7_hdmirx_2m_div.hw,
> > +       [CLKID_HDMIRX_2M]               =3D &t7_hdmirx_2m.hw,
> > +       [CLKID_HDMIRX_CFG_MUX]          =3D &t7_hdmirx_cfg_sel.hw,
> > +       [CLKID_HDMIRX_CFG_DIV]          =3D &t7_hdmirx_cfg_div.hw,
> > +       [CLKID_HDMIRX_CFG]              =3D &t7_hdmirx_cfg.hw,
> > +       [CLKID_HDMIRX_HDCP_MUX]         =3D &t7_hdmirx_hdcp_sel.hw,
> > +       [CLKID_HDMIRX_HDCP_DIV]         =3D &t7_hdmirx_hdcp_div.hw,
> > +       [CLKID_HDMIRX_HDCP]             =3D &t7_hdmirx_hdcp.hw,
> > +       [CLKID_HDMIRX_AUD_PLL_MUX]      =3D &t7_hdmirx_aud_pll_sel.hw,
> > +       [CLKID_HDMIRX_AUD_PLL_DIV]      =3D &t7_hdmirx_aud_pll_div.hw,
> > +       [CLKID_HDMIRX_AUD_PLL]          =3D &t7_hdmirx_aud_pll.hw,
> > +       [CLKID_HDMIRX_ACR_MUX]          =3D &t7_hdmirx_acr_sel.hw,
> > +       [CLKID_HDMIRX_ACR_DIV]          =3D &t7_hdmirx_acr_div.hw,
> > +       [CLKID_HDMIRX_ACR]              =3D &t7_hdmirx_acr.hw,
> > +       [CLKID_HDMIRX_METER_MUX]        =3D &t7_hdmirx_meter_sel.hw,
> > +       [CLKID_HDMIRX_METER_DIV]        =3D &t7_hdmirx_meter_div.hw,
> > +       [CLKID_HDMIRX_METER]            =3D &t7_hdmirx_meter.hw,
> > +       [CLKID_TS_CLK_DIV]              =3D &t7_ts_clk_div.hw,
> > +       [CLKID_TS_CLK_GATE]             =3D &t7_ts_clk_gate.hw,
> > +       [CLKID_MALI_0_SEL]              =3D &t7_mali_0_sel.hw,
> > +       [CLKID_MALI_0_DIV]              =3D &t7_mali_0_div.hw,
> > +       [CLKID_MALI_0]                  =3D &t7_mali_0.hw,
> > +       [CLKID_MALI_1_SEL]              =3D &t7_mali_1_sel.hw,
> > +       [CLKID_MALI_1_DIV]              =3D &t7_mali_1_div.hw,
> > +       [CLKID_MALI_1]                  =3D &t7_mali_1.hw,
> > +       [CLKID_MALI_MUX]                =3D &t7_mali_mux.hw,
> > +       [CLKID_VDEC_P0_MUX]             =3D &t7_vdec_p0_mux.hw,
> > +       [CLKID_VDEC_P0_DIV]             =3D &t7_vdec_p0_div.hw,
> > +       [CLKID_VDEC_P0]                 =3D &t7_vdec_p0.hw,
> > +       [CLKID_VDEC_P1_MUX]             =3D &t7_vdec_p1_mux.hw,
> > +       [CLKID_VDEC_P1_DIV]             =3D &t7_vdec_p1_div.hw,
> > +       [CLKID_VDEC_P1]                 =3D &t7_vdec_p1.hw,
> > +       [CLKID_VDEC_MUX]                =3D &t7_vdec_mux.hw,
> > +       [CLKID_HCODEC_P0_MUX]           =3D &t7_hcodec_p0_mux.hw,
> > +       [CLKID_HCODEC_P0_DIV]           =3D &t7_hcodec_p0_div.hw,
> > +       [CLKID_HCODEC_P0]               =3D &t7_hcodec_p0.hw,
> > +       [CLKID_HCODEC_P1_MUX]           =3D &t7_hcodec_p1_mux.hw,
> > +       [CLKID_HCODEC_P1_DIV]           =3D &t7_hcodec_p1_div.hw,
> > +       [CLKID_HCODEC_P1]               =3D &t7_hcodec_p1.hw,
> > +       [CLKID_HCODEC_MUX]              =3D &t7_hcodec_mux.hw,
> > +       [CLKID_HEVCB_P0_MUX]            =3D &t7_hevcb_p0_mux.hw,
> > +       [CLKID_HEVCB_P0_DIV]            =3D &t7_hevcb_p0_div.hw,
> > +       [CLKID_HEVCB_P0]                =3D &t7_hevcb_p0.hw,
> > +       [CLKID_HEVCB_P1_MUX]            =3D &t7_hevcb_p1_mux.hw,
> > +       [CLKID_HEVCB_P1_DIV]            =3D &t7_hevcb_p1_div.hw,
> > +       [CLKID_HEVCB_P1]                =3D &t7_hevcb_p1.hw,
> > +       [CLKID_HEVCB_MUX]               =3D &t7_hevcb_mux.hw,
> > +       [CLKID_HEVCF_P0_MUX]            =3D &t7_hevcf_p0_mux.hw,
> > +       [CLKID_HEVCF_P0_DIV]            =3D &t7_hevcf_p0_div.hw,
> > +       [CLKID_HEVCF_P0]                =3D &t7_hevcf_p0.hw,
> > +       [CLKID_HEVCF_P1_MUX]            =3D &t7_hevcf_p1_mux.hw,
> > +       [CLKID_HEVCF_P1_DIV]            =3D &t7_hevcf_p1_div.hw,
> > +       [CLKID_HEVCF_P1]                =3D &t7_hevcf_p1.hw,
> > +       [CLKID_HEVCF_MUX]               =3D &t7_hevcf_mux.hw,
> > +       [CLKID_WAVE_A_MUX]              =3D &t7_wave_a_sel.hw,
> > +       [CLKID_WAVE_A_DIV]              =3D &t7_wave_a_div.hw,
> > +       [CLKID_WAVE_A_GATE]             =3D &t7_wave_aclk.hw,
> > +       [CLKID_WAVE_B_MUX]              =3D &t7_wave_b_sel.hw,
> > +       [CLKID_WAVE_B_DIV]              =3D &t7_wave_b_div.hw,
> > +       [CLKID_WAVE_B_GATE]             =3D &t7_wave_bclk.hw,
> > +       [CLKID_WAVE_C_MUX]              =3D &t7_wave_c_sel.hw,
> > +       [CLKID_WAVE_C_DIV]              =3D &t7_wave_c_div.hw,
> > +       [CLKID_WAVE_C_GATE]             =3D &t7_wave_cclk.hw,
> > +       [CLKID_MIPI_ISP_MUX]            =3D &t7_mipi_isp_sel.hw,
> > +       [CLKID_MIPI_ISP_DIV]            =3D &t7_mipi_isp_div.hw,
> > +       [CLKID_MIPI_ISP]                =3D &t7_mipi_isp.hw,
> > +       [CLKID_MIPI_CSI_PHY_SEL0]       =3D &t7_mipi_csi_phy_sel0.hw,
> > +       [CLKID_MIPI_CSI_PHY_DIV0]       =3D &t7_mipi_csi_phy_div0.hw,
> > +       [CLKID_MIPI_CSI_PHY0]           =3D &t7_mipi_csi_phy0.hw,
> > +       [CLKID_MIPI_CSI_PHY_SEL1]       =3D &t7_mipi_csi_phy_sel1.hw,
> > +       [CLKID_MIPI_CSI_PHY_DIV1]       =3D &t7_mipi_csi_phy_div1.hw,
> > +       [CLKID_MIPI_CSI_PHY1]           =3D &t7_mipi_csi_phy1.hw,
> > +       [CLKID_MIPI_CSI_PHY_CLK]        =3D &t7_mipi_csi_phy_clk.hw,
> > +       [CLKID_VPU_0_MUX]               =3D &t7_vpu_0_sel.hw,
> > +       [CLKID_VPU_0_DIV]               =3D &t7_vpu_0_div.hw,
> > +       [CLKID_VPU_0]                   =3D &t7_vpu_0.hw,
> > +       [CLKID_VPU_1_MUX]               =3D &t7_vpu_1_sel.hw,
> > +       [CLKID_VPU_1_DIV]               =3D &t7_vpu_1_div.hw,
> > +       [CLKID_VPU_1]                   =3D &t7_vpu_1.hw,
> > +       [CLKID_VPU]                     =3D &t7_vpu.hw,
> > +       [CLKID_VPU_CLKB_TMP_MUX]        =3D &t7_vpu_clkb_tmp_mux.hw,
> > +       [CLKID_VPU_CLKB_TMP_DIV]        =3D &t7_vpu_clkb_tmp_div.hw,
> > +       [CLKID_VPU_CLKB_TMP]            =3D &t7_vpu_clkb_tmp.hw,
> > +       [CLKID_VPU_CLKB_DIV]            =3D &t7_vpu_clkb_div.hw,
> > +       [CLKID_VPU_CLKB]                =3D &t7_vpu_clkb.hw,
> > +       [CLKID_VPU_CLKC_P0_MUX]         =3D &t7_vpu_clkc_p0_mux.hw,
> > +       [CLKID_VPU_CLKC_P0_DIV]         =3D &t7_vpu_clkc_p0_div.hw,
> > +       [CLKID_VPU_CLKC_P0]             =3D &t7_vpu_clkc_p0.hw,
> > +       [CLKID_VPU_CLKC_P1_MUX]         =3D &t7_vpu_clkc_p1_mux.hw,
> > +       [CLKID_VPU_CLKC_P1_DIV]         =3D &t7_vpu_clkc_p1_div.hw,
> > +       [CLKID_VPU_CLKC_P1]             =3D &t7_vpu_clkc_p1.hw,
> > +       [CLKID_VPU_CLKC_MUX]            =3D &t7_vpu_clkc_mux.hw,
> > +       [CLKID_VAPB_0_MUX]              =3D &t7_vapb_0_sel.hw,
> > +       [CLKID_VAPB_0_DIV]              =3D &t7_vapb_0_div.hw,
> > +       [CLKID_VAPB_0]                  =3D &t7_vapb_0.hw,
> > +       [CLKID_VAPB_1_MUX]              =3D &t7_vapb_1_sel.hw,
> > +       [CLKID_VAPB_1_DIV]              =3D &t7_vapb_1_div.hw,
> > +       [CLKID_VAPB_1]                  =3D &t7_vapb_1.hw,
> > +       [CLKID_VAPB]                    =3D &t7_vapb.hw,
> > +       [CLKID_GDCCLK_0_MUX]            =3D &t7_gdcclk_0_sel.hw,
> > +       [CLKID_GDCCLK_0_DIV]            =3D &t7_gdcclk_0_div.hw,
> > +       [CLKID_GDCCLK_0]                =3D &t7_gdcclk_0.hw,
> > +       [CLKID_GDCCLK_1_MUX]            =3D &t7_gdcclk_1_sel.hw,
> > +       [CLKID_GDCCLK_1_DIV]            =3D &t7_gdcclk_1_div.hw,
> > +       [CLKID_GDCCLK_1]                =3D &t7_gdcclk_1.hw,
> > +       [CLKID_GDCCLK]                  =3D &t7_gdcclk.hw,
> > +       [CLKID_GDC_CLK]                 =3D &t7_gdc_clk.hw,
> > +       [CLKID_DEWARPCLK_0_MUX]         =3D &t7_dewarpclk_0_sel.hw,
> > +       [CLKID_DEWARPCLK_0_DIV]         =3D &t7_dewarpclk_0_div.hw,
> > +       [CLKID_DEWARPCLK_0]             =3D &t7_dewarpclk_0.hw,
> > +       [CLKID_DEWARPCLK_1_MUX]         =3D &t7_dewarpclk_1_sel.hw,
> > +       [CLKID_DEWARPCLK_1_DIV]         =3D &t7_dewarpclk_1_div.hw,
> > +       [CLKID_DEWARPCLK_1]             =3D &t7_dewarpclk_1.hw,
> > +       [CLKID_DEWARPCLK]               =3D &t7_dewarpclk.hw,
> > +       [CLKID_DEWARP_CLK]              =3D &t7_dewarp_clk.hw,
> > +       [CLKID_ANAKIN_0_MUX]            =3D &t7_anakin_0_sel.hw,
> > +       [CLKID_ANAKIN_0_DIV]            =3D &t7_anakin_0_div.hw,
> > +       [CLKID_ANAKIN_0]                =3D &t7_anakin_0.hw,
> > +       [CLKID_ANAKIN_1_MUX]            =3D &t7_anakin_1_sel.hw,
> > +       [CLKID_ANAKIN_1_DIV]            =3D &t7_anakin_1_div.hw,
> > +       [CLKID_ANAKIN_1]                =3D &t7_anakin_1.hw,
> > +       [CLKID_ANAKIN]                  =3D &t7_anakin.hw,
> > +       [CLKID_ANAKIN_CLK]              =3D &t7_anakin_clk.hw,
> > +       [CLKID_GE2D]                    =3D &t7_ge2d_gate.hw,
> > +       [CLKID_VDIN_MEAS_MUX]           =3D &t7_vdin_meas_mux.hw,
> > +       [CLKID_VDIN_MEAS_DIV]           =3D &t7_vdin_meas_div.hw,
> > +       [CLKID_VDIN_MEAS_GATE]          =3D &t7_vdin_meas_gate.hw,
> > +       [CLKID_VID_LOCK_DIV]            =3D &t7_vid_lock_div.hw,
> > +       [CLKID_VID_LOCK]                =3D &t7_vid_lock_clk.hw,
> > +       [CLKID_PWM_A_MUX]               =3D &t7_pwm_a_mux.hw,
> > +       [CLKID_PWM_A_DIV]               =3D &t7_pwm_a_div.hw,
> > +       [CLKID_PWM_A_GATE]              =3D &t7_pwm_a_gate.hw,
> > +       [CLKID_PWM_B_MUX]               =3D &t7_pwm_b_mux.hw,
> > +       [CLKID_PWM_B_DIV]               =3D &t7_pwm_b_div.hw,
> > +       [CLKID_PWM_B_GATE]              =3D &t7_pwm_b_gate.hw,
> > +       [CLKID_PWM_C_MUX]               =3D &t7_pwm_c_mux.hw,
> > +       [CLKID_PWM_C_DIV]               =3D &t7_pwm_c_div.hw,
> > +       [CLKID_PWM_C_GATE]              =3D &t7_pwm_c_gate.hw,
> > +       [CLKID_PWM_D_MUX]               =3D &t7_pwm_d_mux.hw,
> > +       [CLKID_PWM_D_DIV]               =3D &t7_pwm_d_div.hw,
> > +       [CLKID_PWM_D_GATE]              =3D &t7_pwm_d_gate.hw,
> > +       [CLKID_PWM_E_MUX]               =3D &t7_pwm_e_mux.hw,
> > +       [CLKID_PWM_E_DIV]               =3D &t7_pwm_e_div.hw,
> > +       [CLKID_PWM_E_GATE]              =3D &t7_pwm_e_gate.hw,
> > +       [CLKID_PWM_F_MUX]               =3D &t7_pwm_f_mux.hw,
> > +       [CLKID_PWM_F_DIV]               =3D &t7_pwm_f_div.hw,
> > +       [CLKID_PWM_F_GATE]              =3D &t7_pwm_f_gate.hw,
> > +       [CLKID_PWM_AO_A_MUX]            =3D &t7_pwm_ao_a_mux.hw,
> > +       [CLKID_PWM_AO_A_DIV]            =3D &t7_pwm_ao_a_div.hw,
> > +       [CLKID_PWM_AO_A_GATE]           =3D &t7_pwm_ao_a_gate.hw,
> > +       [CLKID_PWM_AO_B_MUX]            =3D &t7_pwm_ao_b_mux.hw,
> > +       [CLKID_PWM_AO_B_DIV]            =3D &t7_pwm_ao_b_div.hw,
> > +       [CLKID_PWM_AO_B_GATE]           =3D &t7_pwm_ao_b_gate.hw,
> > +       [CLKID_PWM_AO_C_MUX]            =3D &t7_pwm_ao_c_mux.hw,
> > +       [CLKID_PWM_AO_C_DIV]            =3D &t7_pwm_ao_c_div.hw,
> > +       [CLKID_PWM_AO_C_GATE]           =3D &t7_pwm_ao_c_gate.hw,
> > +       [CLKID_PWM_AO_D_MUX]            =3D &t7_pwm_ao_d_mux.hw,
> > +       [CLKID_PWM_AO_D_DIV]            =3D &t7_pwm_ao_d_div.hw,
> > +       [CLKID_PWM_AO_D_GATE]           =3D &t7_pwm_ao_d_gate.hw,
> > +       [CLKID_PWM_AO_E_MUX]            =3D &t7_pwm_ao_e_mux.hw,
> > +       [CLKID_PWM_AO_E_DIV]            =3D &t7_pwm_ao_e_div.hw,
> > +       [CLKID_PWM_AO_E_GATE]           =3D &t7_pwm_ao_e_gate.hw,
> > +       [CLKID_PWM_AO_F_MUX]            =3D &t7_pwm_ao_f_mux.hw,
> > +       [CLKID_PWM_AO_F_DIV]            =3D &t7_pwm_ao_f_div.hw,
> > +       [CLKID_PWM_AO_F_GATE]           =3D &t7_pwm_ao_f_gate.hw,
> > +       [CLKID_PWM_AO_G_MUX]            =3D &t7_pwm_ao_g_mux.hw,
> > +       [CLKID_PWM_AO_G_DIV]            =3D &t7_pwm_ao_g_div.hw,
> > +       [CLKID_PWM_AO_G_GATE]           =3D &t7_pwm_ao_g_gate.hw,
> > +       [CLKID_PWM_AO_H_MUX]            =3D &t7_pwm_ao_h_mux.hw,
> > +       [CLKID_PWM_AO_H_DIV]            =3D &t7_pwm_ao_h_div.hw,
> > +       [CLKID_PWM_AO_H_GATE]           =3D &t7_pwm_ao_h_gate.hw,
> > +       [CLKID_SPICC0_MUX]              =3D &t7_spicc0_mux.hw,
> > +       [CLKID_SPICC0_DIV]              =3D &t7_spicc0_div.hw,
> > +       [CLKID_SPICC0_GATE]             =3D &t7_spicc0_gate.hw,
> > +       [CLKID_SPICC1_MUX]              =3D &t7_spicc1_mux.hw,
> > +       [CLKID_SPICC1_DIV]              =3D &t7_spicc1_div.hw,
> > +       [CLKID_SPICC1_GATE]             =3D &t7_spicc1_gate.hw,
> > +       [CLKID_SPICC2_MUX]              =3D &t7_spicc2_mux.hw,
> > +       [CLKID_SPICC2_DIV]              =3D &t7_spicc2_div.hw,
> > +       [CLKID_SPICC2_GATE]             =3D &t7_spicc2_gate.hw,
> > +       [CLKID_SPICC3_MUX]              =3D &t7_spicc3_mux.hw,
> > +       [CLKID_SPICC3_DIV]              =3D &t7_spicc3_div.hw,
> > +       [CLKID_SPICC3_GATE]             =3D &t7_spicc3_gate.hw,
> > +       [CLKID_SPICC4_MUX]              =3D &t7_spicc4_mux.hw,
> > +       [CLKID_SPICC4_DIV]              =3D &t7_spicc4_div.hw,
> > +       [CLKID_SPICC4_GATE]             =3D &t7_spicc4_gate.hw,
> > +       [CLKID_SPICC5_MUX]              =3D &t7_spicc5_mux.hw,
> > +       [CLKID_SPICC5_DIV]              =3D &t7_spicc5_div.hw,
> > +       [CLKID_SPICC5_GATE]             =3D &t7_spicc5_gate.hw,
> > +       [CLKID_SD_EMMC_C_CLK_MUX]       =3D &t7_sd_emmc_c_clk0_sel.hw,
> > +       [CLKID_SD_EMMC_C_CLK_DIV]       =3D &t7_sd_emmc_c_clk0_div.hw,
> > +       [CLKID_SD_EMMC_C_CLK]           =3D &t7_sd_emmc_c_clk0.hw,
> > +       [CLKID_SD_EMMC_A_CLK_MUX]       =3D &t7_sd_emmc_a_clk0_sel.hw,
> > +       [CLKID_SD_EMMC_A_CLK_DIV]       =3D &t7_sd_emmc_a_clk0_div.hw,
> > +       [CLKID_SD_EMMC_A_CLK]           =3D &t7_sd_emmc_a_clk0.hw,
> > +       [CLKID_SD_EMMC_B_CLK_MUX]       =3D &t7_sd_emmc_b_clk0_sel.hw,
> > +       [CLKID_SD_EMMC_B_CLK_DIV]       =3D &t7_sd_emmc_b_clk0_div.hw,
> > +       [CLKID_SD_EMMC_B_CLK]           =3D &t7_sd_emmc_b_clk0.hw,
> > +       [CLKID_DSI_A_MEAS_MUX]          =3D &t7_dsi_a_meas_mux.hw,
> > +       [CLKID_DSI_A_MEAS_DIV]          =3D &t7_dsi_a_meas_div.hw,
> > +       [CLKID_DSI_A_MEAS_GATE]         =3D &t7_dsi_a_meas_gate.hw,
> > +       [CLKID_DSI_B_MEAS_MUX]          =3D &t7_dsi_b_meas_mux.hw,
> > +       [CLKID_DSI_B_MEAS_DIV]          =3D &t7_dsi_b_meas_div.hw,
> > +       [CLKID_DSI_B_MEAS_GATE]         =3D &t7_dsi_b_meas_gate.hw,
> > +       [CLKID_DSI0_PHY_MUX]            =3D &t7_dsi0_phy_mux.hw,
> > +       [CLKID_DSI0_PHY_DIV]            =3D &t7_dsi0_phy_div.hw,
> > +       [CLKID_DSI0_PHY_GATE]           =3D &t7_dsi0_phy_gate.hw,
> > +       [CLKID_DSI1_PHY_MUX]            =3D &t7_dsi1_phy_mux.hw,
> > +       [CLKID_DSI1_PHY_DIV]            =3D &t7_dsi1_phy_div.hw,
> > +       [CLKID_DSI1_PHY_GATE]           =3D &t7_dsi1_phy_gate.hw,
> > +       [CLKID_ETH_RMII_SEL]            =3D &t7_eth_rmii_sel.hw,
> > +       [CLKID_ETH_RMII_DIV]            =3D &t7_eth_rmii_div.hw,
> > +       [CLKID_ETH_RMII]                =3D &t7_eth_rmii.hw,
> > +       [CLKID_ETH_DIV8]                =3D &t7_eth_div8.hw,
> > +       [CLKID_ETH_125M]                =3D &t7_eth_125m.hw,
> > +       [CLKID_SARADC_MUX]              =3D &t7_saradc_mux.hw,
> > +       [CLKID_SARADC_DIV]              =3D &t7_saradc_div.hw,
> > +       [CLKID_SARADC_GATE]             =3D &t7_saradc_gate.hw,
> > +       [CLKID_GEN_MUX]                 =3D &t7_gen_sel.hw,
> > +       [CLKID_GEN_DIV]                 =3D &t7_gen_div.hw,
> > +       [CLKID_GEN_GATE]                =3D &t7_gen.hw,
> > +       [CLKID_DDR]                     =3D &t7_ddr.hw,
> > +       [CLKID_DOS]                     =3D &t7_dos.hw,
> > +       [CLKID_MIPI_DSI_A]              =3D &t7_mipi_dsi_a.hw,
> > +       [CLKID_MIPI_DSI_B]              =3D &t7_mipi_dsi_b.hw,
> > +       [CLKID_ETHPHY]                  =3D &t7_ethphy.hw,
> > +       [CLKID_MALI]                    =3D &t7_mali.hw,
> > +       [CLKID_AOCPU]                   =3D &t7_aocpu.hw,
> > +       [CLKID_AUCPU]                   =3D &t7_aucpu.hw,
> > +       [CLKID_CEC]                     =3D &t7_cec.hw,
> > +       [CLKID_GDC]                     =3D &t7_gdc.hw,
> > +       [CLKID_DESWARP]                 =3D &t7_deswarp.hw,
> > +       [CLKID_AMPIPE_NAND]             =3D &t7_ampipe_nand.hw,
> > +       [CLKID_AMPIPE_ETH]              =3D &t7_ampipe_eth.hw,
> > +       [CLKID_AM2AXI0]                 =3D &t7_am2axi0.hw,
> > +       [CLKID_AM2AXI1]                 =3D &t7_am2axi1.hw,
> > +       [CLKID_AM2AXI2]                 =3D &t7_am2axi2.hw,
> > +       [CLKID_SD_EMMC_A]               =3D &t7_sdemmca.hw,
> > +       [CLKID_SD_EMMC_B]               =3D &t7_sdemmcb.hw,
> > +       [CLKID_SD_EMMC_C]               =3D &t7_sdemmcc.hw,
> > +       [CLKID_SMARTCARD]               =3D &t7_smartcard.hw,
> > +       [CLKID_ACODEC]                  =3D &t7_acodec.hw,
> > +       [CLKID_SPIFC]                   =3D &t7_spifc.hw,
> > +       [CLKID_MSR_CLK]                 =3D &t7_msr_clk.hw,
> > +       [CLKID_IR_CTRL]                 =3D &t7_ir_ctrl.hw,
> > +       [CLKID_AUDIO]                   =3D &t7_audio.hw,
> > +       [CLKID_ETH]                     =3D &t7_eth.hw,
> > +       [CLKID_UART_A]                  =3D &t7_uart_a.hw,
> > +       [CLKID_UART_B]                  =3D &t7_uart_b.hw,
> > +       [CLKID_UART_C]                  =3D &t7_uart_c.hw,
> > +       [CLKID_UART_D]                  =3D &t7_uart_d.hw,
> > +       [CLKID_UART_E]                  =3D &t7_uart_e.hw,
> > +       [CLKID_UART_F]                  =3D &t7_uart_f.hw,
> > +       [CLKID_AIFIFO]                  =3D &t7_aififo.hw,
> > +       [CLKID_SPICC2]                  =3D &t7_spicc2.hw,
> > +       [CLKID_SPICC3]                  =3D &t7_spicc3.hw,
> > +       [CLKID_SPICC4]                  =3D &t7_spicc4.hw,
> > +       [CLKID_TS_A73]                  =3D &t7_ts_a73.hw,
> > +       [CLKID_TS_A53]                  =3D &t7_ts_a53.hw,
> > +       [CLKID_SPICC5]                  =3D &t7_spicc5.hw,
> > +       [CLKID_G2D]                     =3D &t7_g2d.hw,
> > +       [CLKID_SPICC0]                  =3D &t7_spicc0.hw,
> > +       [CLKID_SPICC1]                  =3D &t7_spicc1.hw,
> > +       [CLKID_PCIE]                    =3D &t7_pcie.hw,
> > +       [CLKID_USB]                     =3D &t7_usb.hw,
> > +       [CLKID_PCIE_PHY]                =3D &t7_pcie_phy.hw,
> > +       [CLKID_I2C_AO_A]                =3D &t7_i2c_ao_a.hw,
> > +       [CLKID_I2C_AO_B]                =3D &t7_i2c_ao_b.hw,
> > +       [CLKID_I2C_M_A]                 =3D &t7_i2c_m_a.hw,
> > +       [CLKID_I2C_M_B]                 =3D &t7_i2c_m_b.hw,
> > +       [CLKID_I2C_M_C]                 =3D &t7_i2c_m_c.hw,
> > +       [CLKID_I2C_M_D]                 =3D &t7_i2c_m_d.hw,
> > +       [CLKID_I2C_M_E]                 =3D &t7_i2c_m_e.hw,
> > +       [CLKID_I2C_M_F]                 =3D &t7_i2c_m_f.hw,
> > +       [CLKID_HDMITX_APB]              =3D &t7_hdmitx_apb.hw,
> > +       [CLKID_I2C_S_A]                 =3D &t7_i2c_s_a.hw,
> > +       [CLKID_HDMIRX_PCLK]             =3D &t7_hdmirx_pclk.hw,
> > +       [CLKID_MMC_APB]                 =3D &t7_mmc_apb.hw,
> > +       [CLKID_MIPI_ISP_PCLK]           =3D &t7_mipi_isp_pclk.hw,
> > +       [CLKID_RSA]                     =3D &t7_rsa.hw,
> > +       [CLKID_PCLK_SYS_CPU_APB]        =3D &t7_pclk_sys_cpu_apb.hw,
> > +       [CLKID_A73PCLK_CPU_APB]         =3D &t7_a73pclk_cpu_apb.hw,
> > +       [CLKID_DSPA]                    =3D &t7_dspa.hw,
> > +       [CLKID_DSPB]                    =3D &t7_dspb.hw,
> > +       [CLKID_VPU_INTR]                =3D &t7_vpu_intr.hw,
> > +       [CLKID_SAR_ADC]                 =3D &t7_sar_adc.hw,
> > +       [CLKID_GIC]                     =3D &t7_gic.hw,
> > +       [CLKID_TS_GPU]                  =3D &t7_ts_gpu.hw,
> > +       [CLKID_TS_NNA]                  =3D &t7_ts_nna.hw,
> > +       [CLKID_TS_VPU]                  =3D &t7_ts_vpu.hw,
> > +       [CLKID_TS_HEVC]                 =3D &t7_ts_hevc.hw,
> > +       [CLKID_PWM_AB]                  =3D &t7_pwm_ab.hw,
> > +       [CLKID_PWM_CD]                  =3D &t7_pwm_cd.hw,
> > +       [CLKID_PWM_EF]                  =3D &t7_pwm_ef.hw,
> > +       [CLKID_PWM_AO_AB]               =3D &t7_pwm_ao_ab.hw,
> > +       [CLKID_PWM_AO_CD]               =3D &t7_pwm_ao_cd.hw,
> > +       [CLKID_PWM_AO_EF]               =3D &t7_pwm_ao_ef.hw,
> > +       [CLKID_PWM_AO_GH]               =3D &t7_pwm_ao_gh.hw,
> > +};
> > +
> > +/* Convenience table to populate regmap in .probe */
> > +static struct clk_regmap *const t7_clk_regmaps[] =3D {
> > +       &t7_rtc_32k_clkin,
> > +       &t7_rtc_32k_div,
> > +       &t7_rtc_32k_xtal,
> > +       &t7_rtc_32k_sel,
> > +       &t7_rtc_clk,
> > +       &t7_sysclk_b_sel,
> > +       &t7_sysclk_b_div,
> > +       &t7_sysclk_b,
> > +       &t7_sysclk_a_sel,
> > +       &t7_sysclk_a_div,
> > +       &t7_sysclk_a,
> > +       &t7_sys_clk,
> > +       &t7_ceca_32k_clkin,
> > +       &t7_ceca_32k_div,
> > +       &t7_ceca_32k_sel_pre,
> > +       &t7_ceca_32k_sel,
> > +       &t7_ceca_32k_clkout,
> > +       &t7_cecb_32k_clkin,
> > +       &t7_cecb_32k_div,
> > +       &t7_cecb_32k_sel_pre,
> > +       &t7_cecb_32k_sel,
> > +       &t7_cecb_32k_clkout,
> > +       &t7_sc_clk_mux,
> > +       &t7_sc_clk_div,
> > +       &t7_sc_clk_gate,
> > +       &t7_dspa_a_mux,
> > +       &t7_dspa_a_div,
> > +       &t7_dspa_a_gate,
> > +       &t7_dspa_b_mux,
> > +       &t7_dspa_b_div,
> > +       &t7_dspa_b_gate,
> > +       &t7_dspa_mux,
> > +       &t7_dspb_a_mux,
> > +       &t7_dspb_a_div,
> > +       &t7_dspb_a_gate,
> > +       &t7_dspb_b_mux,
> > +       &t7_dspb_b_div,
> > +       &t7_dspb_b_gate,
> > +       &t7_dspb_mux,
> > +       &t7_24M_clk_gate,
> > +       &t7_12M_clk_gate,
> > +       &t7_25M_clk_div,
> > +       &t7_25M_clk_gate,
> > +       &t7_vid_pll_div,
> > +       &t7_vid_pll_sel,
> > +       &t7_vid_pll,
> > +       &t7_vclk_sel,
> > +       &t7_vclk2_sel,
> > +       &t7_vclk_input,
> > +       &t7_vclk2_input,
> > +       &t7_vclk_div,
> > +       &t7_vclk2_div,
> > +       &t7_vclk,
> > +       &t7_vclk2,
> > +       &t7_vclk_div1,
> > +       &t7_vclk_div2_en,
> > +       &t7_vclk_div4_en,
> > +       &t7_vclk_div6_en,
> > +       &t7_vclk_div12_en,
> > +       &t7_vclk2_div1,
> > +       &t7_vclk2_div2_en,
> > +       &t7_vclk2_div4_en,
> > +       &t7_vclk2_div6_en,
> > +       &t7_vclk2_div12_en,
> > +       &t7_cts_enci_sel,
> > +       &t7_cts_encp_sel,
> > +       &t7_cts_vdac_sel,
> > +       &t7_hdmi_tx_sel,
> > +       &t7_cts_enci,
> > +       &t7_cts_encp,
> > +       &t7_cts_vdac,
> > +       &t7_hdmi_tx,
> > +       &t7_hdmitx_sys_sel,
> > +       &t7_hdmitx_sys_div,
> > +       &t7_hdmitx_sys,
> > +       &t7_hdmitx_prif_sel,
> > +       &t7_hdmitx_prif_div,
> > +       &t7_hdmitx_prif,
> > +       &t7_hdmitx_200m_sel,
> > +       &t7_hdmitx_200m_div,
> > +       &t7_hdmitx_200m,
> > +       &t7_hdmitx_aud_sel,
> > +       &t7_hdmitx_aud_div,
> > +       &t7_hdmitx_aud,
> > +       &t7_hdmirx_5m_sel,
> > +       &t7_hdmirx_5m_div,
> > +       &t7_hdmirx_5m,
> > +       &t7_hdmirx_2m_sel,
> > +       &t7_hdmirx_2m_div,
> > +       &t7_hdmirx_2m,
> > +       &t7_hdmirx_cfg_sel,
> > +       &t7_hdmirx_cfg_div,
> > +       &t7_hdmirx_cfg,
> > +       &t7_hdmirx_hdcp_sel,
> > +       &t7_hdmirx_hdcp_div,
> > +       &t7_hdmirx_hdcp,
> > +       &t7_hdmirx_aud_pll_sel,
> > +       &t7_hdmirx_aud_pll_div,
> > +       &t7_hdmirx_aud_pll,
> > +       &t7_hdmirx_acr_sel,
> > +       &t7_hdmirx_acr_div,
> > +       &t7_hdmirx_acr,
> > +       &t7_hdmirx_meter_sel,
> > +       &t7_hdmirx_meter_div,
> > +       &t7_hdmirx_meter,
> > +       &t7_ts_clk_div,
> > +       &t7_ts_clk_gate,
> > +       &t7_mali_0_sel,
> > +       &t7_mali_0_div,
> > +       &t7_mali_0,
> > +       &t7_mali_1_sel,
> > +       &t7_mali_1_div,
> > +       &t7_mali_1,
> > +       &t7_mali_mux,
> > +       &t7_vdec_p0_mux,
> > +       &t7_vdec_p0_div,
> > +       &t7_vdec_p0,
> > +       &t7_vdec_p1_mux,
> > +       &t7_vdec_p1_div,
> > +       &t7_vdec_p1,
> > +       &t7_vdec_mux,
> > +       &t7_hcodec_p0_mux,
> > +       &t7_hcodec_p0_div,
> > +       &t7_hcodec_p0,
> > +       &t7_hcodec_p1_mux,
> > +       &t7_hcodec_p1_div,
> > +       &t7_hcodec_p1,
> > +       &t7_hcodec_mux,
> > +       &t7_hevcb_p0_mux,
> > +       &t7_hevcb_p0_div,
> > +       &t7_hevcb_p0,
> > +       &t7_hevcb_p1_mux,
> > +       &t7_hevcb_p1_div,
> > +       &t7_hevcb_p1,
> > +       &t7_hevcb_mux,
> > +       &t7_hevcf_p0_mux,
> > +       &t7_hevcf_p0_div,
> > +       &t7_hevcf_p0,
> > +       &t7_hevcf_p1_mux,
> > +       &t7_hevcf_p1_div,
> > +       &t7_hevcf_p1,
> > +       &t7_hevcf_mux,
> > +       &t7_wave_a_sel,
> > +       &t7_wave_a_div,
> > +       &t7_wave_aclk,
> > +       &t7_wave_b_sel,
> > +       &t7_wave_b_div,
> > +       &t7_wave_bclk,
> > +       &t7_wave_c_sel,
> > +       &t7_wave_c_div,
> > +       &t7_wave_cclk,
> > +       &t7_mipi_isp_sel,
> > +       &t7_mipi_isp_div,
> > +       &t7_mipi_isp,
> > +       &t7_mipi_csi_phy_sel0,
> > +       &t7_mipi_csi_phy_div0,
> > +       &t7_mipi_csi_phy0,
> > +       &t7_mipi_csi_phy_sel1,
> > +       &t7_mipi_csi_phy_div1,
> > +       &t7_mipi_csi_phy1,
> > +       &t7_mipi_csi_phy_clk,
> > +       &t7_vpu_0_sel,
> > +       &t7_vpu_0_div,
> > +       &t7_vpu_0,
> > +       &t7_vpu_1_sel,
> > +       &t7_vpu_1_div,
> > +       &t7_vpu_1,
> > +       &t7_vpu,
> > +       &t7_vpu_clkb_tmp_mux,
> > +       &t7_vpu_clkb_tmp_div,
> > +       &t7_vpu_clkb_tmp,
> > +       &t7_vpu_clkb_div,
> > +       &t7_vpu_clkb,
> > +       &t7_vpu_clkc_p0_mux,
> > +       &t7_vpu_clkc_p0_div,
> > +       &t7_vpu_clkc_p0,
> > +       &t7_vpu_clkc_p1_mux,
> > +       &t7_vpu_clkc_p1_div,
> > +       &t7_vpu_clkc_p1,
> > +       &t7_vpu_clkc_mux,
> > +       &t7_vapb_0_sel,
> > +       &t7_vapb_0_div,
> > +       &t7_vapb_0,
> > +       &t7_vapb_1_sel,
> > +       &t7_vapb_1_div,
> > +       &t7_vapb_1,
> > +       &t7_vapb,
> > +       &t7_gdcclk_0_sel,
> > +       &t7_gdcclk_0_div,
> > +       &t7_gdcclk_0,
> > +       &t7_gdcclk_1_sel,
> > +       &t7_gdcclk_1_div,
> > +       &t7_gdcclk_1,
> > +       &t7_gdcclk,
> > +       &t7_gdc_clk,
> > +       &t7_dewarpclk_0_sel,
> > +       &t7_dewarpclk_0_div,
> > +       &t7_dewarpclk_0,
> > +       &t7_dewarpclk_1_sel,
> > +       &t7_dewarpclk_1_div,
> > +       &t7_dewarpclk_1,
> > +       &t7_dewarpclk,
> > +       &t7_dewarp_clk,
> > +       &t7_anakin_0_sel,
> > +       &t7_anakin_0_div,
> > +       &t7_anakin_0,
> > +       &t7_anakin_1_sel,
> > +       &t7_anakin_1_div,
> > +       &t7_anakin_1,
> > +       &t7_anakin,
> > +       &t7_anakin_clk,
> > +       &t7_ge2d_gate,
> > +       &t7_vdin_meas_mux,
> > +       &t7_vdin_meas_div,
> > +       &t7_vdin_meas_gate,
> > +       &t7_vid_lock_div,
> > +       &t7_vid_lock_clk,
> > +       &t7_pwm_a_mux,
> > +       &t7_pwm_a_div,
> > +       &t7_pwm_a_gate,
> > +       &t7_pwm_b_mux,
> > +       &t7_pwm_b_div,
> > +       &t7_pwm_b_gate,
> > +       &t7_pwm_c_mux,
> > +       &t7_pwm_c_div,
> > +       &t7_pwm_c_gate,
> > +       &t7_pwm_d_mux,
> > +       &t7_pwm_d_div,
> > +       &t7_pwm_d_gate,
> > +       &t7_pwm_e_mux,
> > +       &t7_pwm_e_div,
> > +       &t7_pwm_e_gate,
> > +       &t7_pwm_f_mux,
> > +       &t7_pwm_f_div,
> > +       &t7_pwm_f_gate,
> > +       &t7_pwm_ao_a_mux,
> > +       &t7_pwm_ao_a_div,
> > +       &t7_pwm_ao_a_gate,
> > +       &t7_pwm_ao_b_mux,
> > +       &t7_pwm_ao_b_div,
> > +       &t7_pwm_ao_b_gate,
> > +       &t7_pwm_ao_c_mux,
> > +       &t7_pwm_ao_c_div,
> > +       &t7_pwm_ao_c_gate,
> > +       &t7_pwm_ao_d_mux,
> > +       &t7_pwm_ao_d_div,
> > +       &t7_pwm_ao_d_gate,
> > +       &t7_pwm_ao_e_mux,
> > +       &t7_pwm_ao_e_div,
> > +       &t7_pwm_ao_e_gate,
> > +       &t7_pwm_ao_f_mux,
> > +       &t7_pwm_ao_f_div,
> > +       &t7_pwm_ao_f_gate,
> > +       &t7_pwm_ao_g_mux,
> > +       &t7_pwm_ao_g_div,
> > +       &t7_pwm_ao_g_gate,
> > +       &t7_pwm_ao_h_mux,
> > +       &t7_pwm_ao_h_div,
> > +       &t7_pwm_ao_h_gate,
> > +       &t7_spicc0_mux,
> > +       &t7_spicc0_div,
> > +       &t7_spicc0_gate,
> > +       &t7_spicc1_mux,
> > +       &t7_spicc1_div,
> > +       &t7_spicc1_gate,
> > +       &t7_spicc2_mux,
> > +       &t7_spicc2_div,
> > +       &t7_spicc2_gate,
> > +       &t7_spicc3_mux,
> > +       &t7_spicc3_div,
> > +       &t7_spicc3_gate,
> > +       &t7_spicc4_mux,
> > +       &t7_spicc4_div,
> > +       &t7_spicc4_gate,
> > +       &t7_spicc5_mux,
> > +       &t7_spicc5_div,
> > +       &t7_spicc5_gate,
> > +       &t7_sd_emmc_c_clk0_sel,
> > +       &t7_sd_emmc_c_clk0_div,
> > +       &t7_sd_emmc_c_clk0,
> > +       &t7_sd_emmc_a_clk0_sel,
> > +       &t7_sd_emmc_a_clk0_div,
> > +       &t7_sd_emmc_a_clk0,
> > +       &t7_sd_emmc_b_clk0_sel,
> > +       &t7_sd_emmc_b_clk0_div,
> > +       &t7_sd_emmc_b_clk0,
> > +       &t7_eth_rmii_sel,
> > +       &t7_eth_rmii_div,
> > +       &t7_eth_rmii,
> > +       &t7_eth_125m,
> > +       &t7_dsi_a_meas_mux,
> > +       &t7_dsi_a_meas_div,
> > +       &t7_dsi_a_meas_gate,
> > +       &t7_dsi_b_meas_mux,
> > +       &t7_dsi_b_meas_div,
> > +       &t7_dsi_b_meas_gate,
> > +       &t7_dsi0_phy_mux,
> > +       &t7_dsi0_phy_div,
> > +       &t7_dsi0_phy_gate,
> > +       &t7_dsi1_phy_mux,
> > +       &t7_dsi1_phy_div,
> > +       &t7_dsi1_phy_gate,
> > +       &t7_saradc_mux,
> > +       &t7_saradc_div,
> > +       &t7_saradc_gate,
> > +       &t7_gen_sel,
> > +       &t7_gen_div,
> > +       &t7_gen,
> > +
> > +       &t7_ddr,
> > +       &t7_dos,
> > +       &t7_mipi_dsi_a,
> > +       &t7_mipi_dsi_b,
> > +       &t7_ethphy,
> > +       &t7_mali,
> > +       &t7_aocpu,
> > +       &t7_aucpu,
> > +       &t7_cec,
> > +       &t7_gdc,
> > +       &t7_deswarp,
> > +       &t7_ampipe_nand,
> > +       &t7_ampipe_eth,
> > +       &t7_am2axi0,
> > +       &t7_am2axi1,
> > +       &t7_am2axi2,
> > +       &t7_sdemmca,
> > +       &t7_sdemmcb,
> > +       &t7_sdemmcc,
> > +       &t7_smartcard,
> > +       &t7_acodec,
> > +       &t7_spifc,
> > +       &t7_msr_clk,
> > +       &t7_ir_ctrl,
> > +       &t7_audio,
> > +       &t7_eth,
> > +       &t7_uart_a,
> > +       &t7_uart_b,
> > +       &t7_uart_c,
> > +       &t7_uart_d,
> > +       &t7_uart_e,
> > +       &t7_uart_f,
> > +       &t7_aififo,
> > +       &t7_spicc2,
> > +       &t7_spicc3,
> > +       &t7_spicc4,
> > +       &t7_ts_a73,
> > +       &t7_ts_a53,
> > +       &t7_spicc5,
> > +       &t7_g2d,
> > +       &t7_spicc0,
> > +       &t7_spicc1,
> > +       &t7_pcie,
> > +       &t7_usb,
> > +       &t7_pcie_phy,
> > +       &t7_i2c_ao_a,
> > +       &t7_i2c_ao_b,
> > +       &t7_i2c_m_a,
> > +       &t7_i2c_m_b,
> > +       &t7_i2c_m_c,
> > +       &t7_i2c_m_d,
> > +       &t7_i2c_m_e,
> > +       &t7_i2c_m_f,
> > +       &t7_hdmitx_apb,
> > +       &t7_i2c_s_a,
> > +       &t7_hdmirx_pclk,
> > +       &t7_mmc_apb,
> > +       &t7_mipi_isp_pclk,
> > +       &t7_rsa,
> > +       &t7_pclk_sys_cpu_apb,
> > +       &t7_a73pclk_cpu_apb,
> > +       &t7_dspa,
> > +       &t7_dspb,
> > +       &t7_vpu_intr,
> > +       &t7_sar_adc,
> > +       &t7_gic,
> > +       &t7_ts_gpu,
> > +       &t7_ts_nna,
> > +       &t7_ts_vpu,
> > +       &t7_ts_hevc,
> > +       &t7_pwm_ab,
> > +       &t7_pwm_cd,
> > +       &t7_pwm_ef,
> > +       &t7_pwm_ao_ab,
> > +       &t7_pwm_ao_cd,
> > +       &t7_pwm_ao_ef,
> > +       &t7_pwm_ao_gh,
> > +};
> > +
> > +static struct regmap_config clkc_regmap_config =3D {
> > +       .reg_bits       =3D 32,
> > +       .val_bits       =3D 32,
> > +       .reg_stride     =3D 4,
> > +};
> > +
> > +static struct meson_clk_hw_data t7_periphs_clks =3D {
> > +       .hws =3D t7_periphs_hw_clks,
> > +       .num =3D ARRAY_SIZE(t7_periphs_hw_clks),
> > +};
> > +
> > +static int amlogic_a1_periphs_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct regmap *regmap;
> > +       void __iomem *base;
> > +       int ret, i;
> > +
> > +       base =3D devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(base))
> > +               return dev_err_probe(dev, PTR_ERR(base), "can't ioremap=
 resource\n");
> > +
> > +       regmap =3D devm_regmap_init_mmio(dev, base, &clkc_regmap_config=
);
> > +       if (IS_ERR(regmap))
> > +               return dev_err_probe(dev, PTR_ERR(regmap), "can't init =
regmap mmio region\n");
> > +
> > +       /* Populate regmap for the regmap backed clocks */
> > +       for (i =3D 0; i < ARRAY_SIZE(t7_clk_regmaps); i++)
> > +               t7_clk_regmaps[i]->map =3D regmap;
> > +
> > +       for (i =3D 0; i < t7_periphs_clks.num; i++) {
> > +               /* array might be sparse */
> > +               if (!t7_periphs_clks.hws[i])
> > +                       continue;
> > +
> > +               ret =3D devm_clk_hw_register(dev, t7_periphs_clks.hws[i=
]);
> > +               if (ret)
> > +                       return dev_err_probe(dev, ret, "clock[%d] regis=
tration failed\n", i);
> > +       }
> > +
> > +       return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, &t7_p=
eriphs_clks);
> > +}
> > +
> > +static const struct of_device_id t7_periphs_clkc_match_table[] =3D {
> > +       { .compatible =3D "amlogic,t7-peripherals-clkc", },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, t7_periphs_clkc_match_table);
> > +
> > +static struct platform_driver t7_periphs_clkc_driver =3D {
> > +       .probe          =3D amlogic_a1_periphs_probe,
> > +       .driver         =3D {
> > +               .name   =3D "t7-periphs-clkc",
> > +               .of_match_table =3D t7_periphs_clkc_match_table,
> > +       },
> > +};
> > +
> > +module_platform_driver(t7_periphs_clkc_driver);
> > +MODULE_AUTHOR("Yu Tu <yu.tu@amlogic.com>");
> > +MODULE_AUTHOR("Lucas Tanure <tanure@linux.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/clk/meson/t7-peripherals.h b/drivers/clk/meson/t7-=
peripherals.h
> > new file mode 100644
> > index 000000000000..0ac5e0919b5e
> > --- /dev/null
> > +++ b/drivers/clk/meson/t7-peripherals.h
> > @@ -0,0 +1,131 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > +/*
> > + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> > + */
> > +
> > +#ifndef __T7_PERIPHERALS_H
> > +#define __T7_PERIPHERALS_H
> > +
> > +/* basic clk: 0xfe000000 */
> > +#define CLKCTRL_OSCIN_CTRL             (0x0001  << 2)
> > +#define CLKCTRL_RTC_BY_OSCIN_CTRL0     (0x0002  << 2)
> > +#define CLKCTRL_RTC_BY_OSCIN_CTRL1     (0x0003  << 2)
> > +#define CLKCTRL_RTC_CTRL               (0x0004  << 2)
> > +#define CLKCTRL_CHECK_CLK_RESULT       (0x0005  << 2)
> > +#define CLKCTRL_MBIST_ATSPEED_CTRL     (0x0006  << 2)
> > +#define CLKCTRL_LOCK_BIT_REG0          (0x0008  << 2)
> > +#define CLKCTRL_LOCK_BIT_REG1          (0x0009  << 2)
> > +#define CLKCTRL_LOCK_BIT_REG2          (0x000a  << 2)
> > +#define CLKCTRL_LOCK_BIT_REG3          (0x000b  << 2)
> > +#define CLKCTRL_PROT_BIT_REG0          (0x000c  << 2)
> > +#define CLKCTRL_PROT_BIT_REG1          (0x000d  << 2)
> > +#define CLKCTRL_PROT_BIT_REG2          (0x000e  << 2)
> > +#define CLKCTRL_PROT_BIT_REG3          (0x000f  << 2)
> > +#define CLKCTRL_SYS_CLK_CTRL0          (0x0010  << 2)
> > +#define CLKCTRL_SYS_CLK_EN0_REG0       (0x0011  << 2)
> > +#define CLKCTRL_SYS_CLK_EN0_REG1       (0x0012  << 2)
> > +#define CLKCTRL_SYS_CLK_EN0_REG2       (0x0013  << 2)
> > +#define CLKCTRL_SYS_CLK_EN0_REG3       (0x0014  << 2)
> > +#define CLKCTRL_SYS_CLK_EN1_REG0       (0x0015  << 2)
> > +#define CLKCTRL_SYS_CLK_EN1_REG1       (0x0016  << 2)
> > +#define CLKCTRL_SYS_CLK_EN1_REG2       (0x0017  << 2)
> > +#define CLKCTRL_SYS_CLK_EN1_REG3       (0x0018  << 2)
> > +#define CLKCTRL_SYS_CLK_VPU_EN0                (0x0019  << 2)
> > +#define CLKCTRL_SYS_CLK_VPU_EN1                (0x001a  << 2)
> > +#define CLKCTRL_AXI_CLK_CTRL0          (0x001b  << 2)
> > +#define CLKCTRL_TST_CTRL0              (0x0020  << 2)
> > +#define CLKCTRL_TST_CTRL1              (0x0021  << 2)
> > +#define CLKCTRL_CECA_CTRL0             (0x0022  << 2)
> > +#define CLKCTRL_CECA_CTRL1             (0x0023  << 2)
> > +#define CLKCTRL_CECB_CTRL0             (0x0024  << 2)
> > +#define CLKCTRL_CECB_CTRL1             (0x0025  << 2)
> > +#define CLKCTRL_SC_CLK_CTRL            (0x0026  << 2)
> > +#define CLKCTRL_DSPA_CLK_CTRL0         (0x0027  << 2)
> > +#define CLKCTRL_DSPB_CLK_CTRL0         (0x0028  << 2)
> > +#define CLKCTRL_CLK12_24_CTRL          (0x002a  << 2)
> > +#define CLKCTRL_ANAKIN_CLK_CTRL                (0x002b  << 2)
> > +#define CLKCTRL_GDC_CLK_CTRL           (0x002c  << 2)
> > +#define CLKCTRL_AMLGDC_CLK_CTRL                (0x002d  << 2)
> > +#define CLKCTRL_VID_CLK0_CTRL          (0x0030  << 2)
> > +#define CLKCTRL_VID_CLK0_CTRL2         (0x0031  << 2)
> > +#define CLKCTRL_VID_CLK0_DIV           (0x0032  << 2)
> > +#define CLKCTRL_VIID_CLK0_DIV          (0x0033  << 2)
> > +#define CLKCTRL_VIID_CLK0_CTRL         (0x0034  << 2)
> > +#define CLKCTRL_ENC0_HDMI_CLK_CTRL     (0x0035  << 2)
> > +#define CLKCTRL_ENC2_HDMI_CLK_CTRL     (0x0036  << 2)
> > +#define CLKCTRL_ENC_HDMI_CLK_CTRL      (0x0037  << 2)
> > +#define CLKCTRL_HDMI_CLK_CTRL          (0x0038  << 2)
> > +#define CLKCTRL_VID_PLL_CLK0_DIV       (0x0039  << 2)
> > +#define CLKCTRL_VPU_CLK_CTRL           (0x003a  << 2)
> > +#define CLKCTRL_VPU_CLKB_CTRL          (0x003b  << 2)
> > +#define CLKCTRL_VPU_CLKC_CTRL          (0x003c  << 2)
> > +#define CLKCTRL_VID_LOCK_CLK_CTRL      (0x003d  << 2)
> > +#define CLKCTRL_VDIN_MEAS_CLK_CTRL     (0x003e  << 2)
> > +#define CLKCTRL_VAPBCLK_CTRL           (0x003f  << 2)
> > +#define CLKCTRL_MIPIDSI_PHY_CLK_CTRL   (0x0041  << 2)
> > +#define CLKCTRL_MIPI_CSI_PHY_CLK_CTRL  (0x0043  << 2)
> > +#define CLKCTRL_MIPI_ISP_CLK_CTRL      (0x0044  << 2)
> > +#define CLKCTRL_WAVE420L_CLK_CTRL      (0x0045  << 2)
> > +#define CLKCTRL_WAVE420L_CLK_CTRL2     (0x0046  << 2)
> > +#define CLKCTRL_HTX_CLK_CTRL0          (0x0047  << 2)
> > +#define CLKCTRL_HTX_CLK_CTRL1          (0x0048  << 2)
> > +#define CLKCTRL_HRX_CLK_CTRL0          (0x004a  << 2)
> > +#define CLKCTRL_HRX_CLK_CTRL1          (0x004b  << 2)
> > +#define CLKCTRL_HRX_CLK_CTRL2          (0x004c  << 2)
> > +#define CLKCTRL_HRX_CLK_CTRL3          (0x004d  << 2)
> > +#define CLKCTRL_VDEC_CLK_CTRL          (0x0050  << 2)
> > +#define CLKCTRL_VDEC2_CLK_CTRL         (0x0051  << 2)
> > +#define CLKCTRL_VDEC3_CLK_CTRL         (0x0052  << 2)
> > +#define CLKCTRL_VDEC4_CLK_CTRL         (0x0053  << 2)
> > +#define CLKCTRL_WAVE521_CLK_CTRL       (0x0054  << 2)
> > +#define CLKCTRL_WAVE521_CLK_CTRL2      (0x0055  << 2)
> > +#define CLKCTRL_TS_CLK_CTRL            (0x0056  << 2)
> > +#define CLKCTRL_MALI_CLK_CTRL          (0x0057  << 2)
> > +#define CLKCTRL_VIPNANOQ_CLK_CTRL      (0x0058  << 2)
> > +#define CLKCTRL_ETH_CLK_CTRL           (0x0059  << 2)
> > +#define CLKCTRL_NAND_CLK_CTRL          (0x005a  << 2)
> > +#define CLKCTRL_SD_EMMC_CLK_CTRL       (0x005b  << 2)
> > +#define CLKCTRL_BT656_CLK_CTRL         (0x005c  << 2)
> > +#define CLKCTRL_SPICC_CLK_CTRL         (0x005d  << 2)
> > +#define CLKCTRL_GEN_CLK_CTRL           (0x005e  << 2)
> > +#define CLKCTRL_SAR_CLK_CTRL0          (0x005f  << 2)
> > +#define CLKCTRL_PWM_CLK_AB_CTRL                (0x0060  << 2)
> > +#define CLKCTRL_PWM_CLK_CD_CTRL                (0x0061  << 2)
> > +#define CLKCTRL_PWM_CLK_EF_CTRL                (0x0062  << 2)
> > +#define CLKCTRL_PWM_CLK_AO_AB_CTRL     (0x0068  << 2)
> > +#define CLKCTRL_PWM_CLK_AO_CD_CTRL     (0x0069  << 2)
> > +#define CLKCTRL_PWM_CLK_AO_EF_CTRL     (0x006a  << 2)
> > +#define CLKCTRL_PWM_CLK_AO_GH_CTRL     (0x006b  << 2)
> > +#define CLKCTRL_SPICC_CLK_CTRL1                (0x0070  << 2)
> > +#define CLKCTRL_SPICC_CLK_CTRL2                (0x0071  << 2)
> > +#define CLKCTRL_VID_CLK1_CTRL          (0x0073  << 2)
> > +#define CLKCTRL_VID_CLK1_CTRL2         (0x0074  << 2)
> > +#define CLKCTRL_VID_CLK1_DIV           (0x0075  << 2)
> > +#define CLKCTRL_VIID_CLK1_DIV          (0x0076  << 2)
> > +#define CLKCTRL_VIID_CLK1_CTRL         (0x0077  << 2)
> > +#define CLKCTRL_VID_CLK2_CTRL          (0x0078  << 2)
> > +#define CLKCTRL_VID_CLK2_CTRL2         (0x0079  << 2)
> > +#define CLKCTRL_VID_CLK2_DIV           (0x007a  << 2)
> > +#define CLKCTRL_VIID_CLK2_DIV          (0x007b  << 2)
> > +#define CLKCTRL_VIID_CLK2_CTRL         (0x007c  << 2)
> > +#define CLKCTRL_VID_PLL_CLK1_DIV       (0x007d  << 2)
> > +#define CLKCTRL_VID_PLL_CLK2_DIV       (0x007e  << 2)
> > +#define CLKCTRL_MIPI_DSI_MEAS_CLK_CTRL (0x0080  << 2)
> > +#define CLKCTRL_TIMESTAMP_CTRL         (0x0100  << 2)
> > +#define CLKCTRL_TIMESTAMP_CTRL1                (0x0101  << 2)
> > +#define CLKCTRL_TIMESTAMP_CTRL2                (0x0103  << 2)
> > +#define CLKCTRL_TIMESTAMP_RD0          (0x0104  << 2)
> > +#define CLKCTRL_TIMESTAMP_RD1          (0x0105  << 2)
> > +#define CLKCTRL_TIMEBASE_CTRL0         (0x0106  << 2)
> > +#define CLKCTRL_TIMEBASE_CTRL1         (0x0107  << 2)
> > +#define CLKCTRL_EFUSE_CPU_CFG01                (0x0120  << 2)
> > +#define CLKCTRL_EFUSE_CPU_CFG2         (0x0121  << 2)
> > +#define CLKCTRL_EFUSE_ENCP_CFG0                (0x0122  << 2)
> > +#define CLKCTRL_EFUSE_MALI_CFG01       (0x0123  << 2)
> > +#define CLKCTRL_EFUSE_HEVCB_CFG01      (0x0124  << 2)
> > +#define CLKCTRL_EFUSE_HEVCB_CFG2       (0x0125  << 2)
> > +#define CLKCTRL_EFUSE_LOCK             (0x0126  << 2)
> > +#define CLKCTRL_EFUSE_A73_CFG01                (0x0127  << 2)
> > +#define CLKCTRL_EFUSE_A73_CFG2         (0x0128  << 2)
> > +
> > +#endif /* __T7_PERIPHERALS_H */
> > diff --git a/drivers/clk/meson/t7-pll.c b/drivers/clk/meson/t7-pll.c
> > new file mode 100644
> > index 000000000000..bd18df5e965a
> > --- /dev/null
> > +++ b/drivers/clk/meson/t7-pll.c
> > @@ -0,0 +1,1543 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> > +/*
> > + * Amlogic T7 PLL Clock Controller Driver
> > + *
> > + * Copyright (c) 2022-2023 Amlogic, inc. All rights reserved
> > + * Author: Yu Tu <yu.tu@amlogic.com>
> > + */
> > +#include <linux/clk-provider.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "clk-mpll.h"
> > +#include "clk-pll.h"
> > +#include "clk-regmap.h"
> > +#include "t7-pll.h"
> > +#include "meson-clkc-utils.h"
> > +#include <dt-bindings/clock/amlogic,t7-pll-clkc.h>
> > +
> > +static DEFINE_SPINLOCK(meson_clk_lock);
> > +
> > +static struct clk_regmap t7_fixed_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_FIXPLL_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_FIXPLL_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_FIXPLL_CTRL0,
> > +                       .shift   =3D 10,
> > +                       .width   =3D 5,
> > +               },
> > +               .frac =3D {
> > +                       .reg_off =3D ANACTRL_FIXPLL_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 19,
> > +               },
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_FIXPLL_CTRL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_FIXPLL_CTRL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fixed_pll_dco",
> > +               .ops =3D &meson_clk_pll_ro_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_fixed_pll =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_FIXPLL_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 2,
> > +               .flags =3D CLK_DIVIDER_POWER_OF_TWO,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fixed_pll",
> > +               .ops =3D &clk_regmap_divider_ro_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fixed_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               /*
> > +                * This clock won't ever change at runtime so
> > +                * CLK_SET_RATE_PARENT is not required
> > +                */
> > +               .flags =3D CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static const struct clk_ops meson_pll_clk_no_ops =3D {};
> > +
> > +/*
> > + * the sys pll DCO value should be 3G~6G,
> > + * otherwise the sys pll can not lock.
> > + * od is for 32 bit.
> > + */
> > +
> > +static const struct pll_params_table t7_sys_pll_params_table[] =3D {
> > +       PLL_PARAMS(67, 1), /*DCO=3D1608M OD=3D1608MM*/
> > +       PLL_PARAMS(71, 1), /*DCO=3D1704MM OD=3D1704M*/
> > +       PLL_PARAMS(75, 1), /*DCO=3D1800M OD=3D1800M*/
> > +       PLL_PARAMS(126, 1), /*DCO=3D3024 OD=3D1512M*/
> > +       PLL_PARAMS(116, 1), /*DCO=3D2784 OD=3D1392M*/
> > +       PLL_PARAMS(118, 1), /*DCO=3D2832M OD=3D1416M*/
> > +       PLL_PARAMS(100, 1), /*DCO=3D2400M OD=3D1200M*/
> > +       PLL_PARAMS(79, 1), /*DCO=3D1896M OD=3D1896M*/
> > +       PLL_PARAMS(80, 1), /*DCO=3D1920M OD=3D1920M*/
> > +       PLL_PARAMS(84, 1), /*DCO=3D2016M OD=3D2016M*/
> > +       PLL_PARAMS(92, 1), /*DCO=3D2208M OD=3D2208M*/
> > +       {0, 0},
> > +};
> > +
> > +static struct clk_regmap t7_sys_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_SYS0PLL_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_SYS0PLL_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_SYS0PLL_CTRL0,
> > +                       .shift   =3D 16,
> > +                       .width   =3D 5,
> > +               },
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_SYS0PLL_CTRL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_SYS0PLL_CTRL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_sys_pll_params_table,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sys_pll_dco",
> > +               .ops =3D &meson_clk_pll_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +               /* This clock feeds the CPU, avoid disabling it */
> > +               .flags =3D CLK_IS_CRITICAL,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sys1_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_SYS1PLL_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_SYS1PLL_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_SYS1PLL_CTRL0,
> > +                       .shift   =3D 16,
> > +                       .width   =3D 5,
> > +               },
> > +               .table =3D t7_sys_pll_params_table,
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_SYS1PLL_CTRL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_SYS1PLL_CTRL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sys1_pll_dco",
> > +               .ops =3D &meson_clk_pll_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +               /* This clock feeds the CPU, avoid disabling it */
> > +               .flags =3D CLK_IS_CRITICAL,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sys_pll =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_SYS0PLL_CTRL0,
> > +               .shift =3D 12,
> > +               .width =3D 3,
> > +               .flags =3D CLK_DIVIDER_POWER_OF_TWO,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sys_pll",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sys_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_sys1_pll =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_SYS1PLL_CTRL0,
> > +               .shift =3D 12,
> > +               .width =3D 3,
> > +               .flags =3D CLK_DIVIDER_POWER_OF_TWO,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "sys1_pll",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_sys1_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_fclk_div2_div =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div2_div",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_fixed_p=
ll.hw },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_fclk_div2 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_FIXPLL_CTRL1,
> > +               .bit_idx =3D 24,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div2",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fclk_div2_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_IS_CRITICAL,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_fclk_div3_div =3D {
> > +       .mult =3D 1,
> > +       .div =3D 3,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div3_div",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_fixed_p=
ll.hw },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_fclk_div3 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_FIXPLL_CTRL1,
> > +               .bit_idx =3D 20,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div3",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fclk_div3_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               /*
> > +                * This clock is used by the resident firmware and is r=
equired
> > +                * by the platform to operate correctly.
> > +                * Until the following condition are met, we need this =
clock to
> > +                * be marked as critical:
> > +                * a) Mark the clock used by a firmware resource, if po=
ssible
> > +                * b) CCF has a clock hand-off mechanism to make the su=
re the
> > +                *    clock stays on until the proper driver comes alon=
g
> > +                */
> > +               .flags =3D CLK_IS_CRITICAL,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_fclk_div4_div =3D {
> > +       .mult =3D 1,
> > +       .div =3D 4,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div4_div",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_fixed_p=
ll.hw },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_fclk_div4 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_FIXPLL_CTRL1,
> > +               .bit_idx =3D 21,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div4",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fclk_div4_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_IS_CRITICAL,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_fclk_div5_div =3D {
> > +       .mult =3D 1,
> > +       .div =3D 5,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div5_div",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_fixed_p=
ll.hw },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_fclk_div5 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_FIXPLL_CTRL1,
> > +               .bit_idx =3D 22,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div5",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fclk_div5_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_IS_CRITICAL,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_fclk_div7_div =3D {
> > +       .mult =3D 1,
> > +       .div =3D 7,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div7_div",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_fixed_p=
ll.hw },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_fclk_div7 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_FIXPLL_CTRL1,
> > +               .bit_idx =3D 23,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div7",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fclk_div7_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_IS_CRITICAL,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_fclk_div2p5_div =3D {
> > +       .mult =3D 2,
> > +       .div =3D 5,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div2p5_div",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fixed_pll.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_fclk_div2p5 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_FIXPLL_CTRL1,
> > +               .bit_idx =3D 25,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "fclk_div2p5",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fclk_div2p5_div.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_IS_CRITICAL,
> > +       },
> > +};
> > +
> > +static const struct pll_params_table t7_gp0_pll_table[] =3D {
> > +       PLL_PARAMS(141, 1), /* DCO =3D 3384M OD =3D 2 PLL =3D 846M */
> > +       PLL_PARAMS(132, 1), /* DCO =3D 3168M OD =3D 2 PLL =3D 792M */
> > +       PLL_PARAMS(248, 1), /* DCO =3D 5952M OD =3D 3 PLL =3D 744M */
> > +       PLL_PARAMS(96, 1), /* DCO =3D 2304M OD =3D 1 PLL =3D 1152M */
> > +       { /* sentinel */  }
> > +};
> > +
> > +/*
> > + * Internal gp0 pll emulation configuration parameters
> > + */
> > +static const struct reg_sequence t7_gp0_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_GP0PLL_CTRL1,  .def =3D 0x00000000 },
> > +       { .reg =3D ANACTRL_GP0PLL_CTRL2,  .def =3D 0x00000000 },
> > +       { .reg =3D ANACTRL_GP0PLL_CTRL3,  .def =3D 0x48681c00 },
> > +       { .reg =3D ANACTRL_GP0PLL_CTRL4,  .def =3D 0x88770290 },
> > +       { .reg =3D ANACTRL_GP0PLL_CTRL5,  .def =3D 0x3927200a },
> > +       { .reg =3D ANACTRL_GP0PLL_CTRL6,  .def =3D 0x56540000 }
> > +};
> > +
> > +static struct clk_regmap t7_gp0_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_GP0PLL_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_GP0PLL_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_GP0PLL_CTRL0,
> > +                       .shift   =3D 10,
> > +                       .width   =3D 5,
> > +               },
> > +               .frac =3D {
> > +                       .reg_off =3D ANACTRL_GP0PLL_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 19,
> > +               },
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_GP0PLL_CTRL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_GP0PLL_CTRL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_gp0_pll_table,
> > +               .init_regs =3D t7_gp0_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_gp0_init_regs),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gp0_pll_dco",
> > +               .ops =3D &meson_clk_pll_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gp0_pll =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_GP0PLL_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 3,
> > +               .flags =3D (CLK_DIVIDER_POWER_OF_TWO |
> > +                         CLK_DIVIDER_ROUND_CLOSEST),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gp0_pll",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gp0_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static const struct pll_params_table t7_gp1_pll_table[] =3D {
> > +       PLL_PARAMS(100, 1), /*DCO=3D4800M OD=3D1200M*/
> > +       PLL_PARAMS(125, 1), /*DCO=3D3000M OD=3D1500M*/
> > +       { /* sentinel */  }
> > +};
> > +
> > +static const struct reg_sequence t7_gp1_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_GP1PLL_CTRL1,  .def =3D 0x1420500f },
> > +       { .reg =3D ANACTRL_GP1PLL_CTRL2,  .def =3D 0x00023001 },
> > +       { .reg =3D ANACTRL_GP1PLL_CTRL3,  .def =3D 0x0, .delay_us =3D 2=
0 },
> > +};
> > +
> > +static struct clk_regmap t7_gp1_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_GP1PLL_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_GP1PLL_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_GP1PLL_CTRL0,
> > +                       .shift   =3D 16,
> > +                       .width   =3D 5,
> > +               },
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_GP1PLL_CTRL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_GP1PLL_CTRL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_gp1_pll_table,
> > +               .init_regs =3D t7_gp1_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_gp1_init_regs)
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gp1_pll_dco",
> > +               .ops =3D &meson_clk_pll_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +               /* This clock feeds the DSU, avoid disabling it */
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_gp1_pll =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_GP1PLL_CTRL0,
> > +               .shift =3D 12,
> > +               .width =3D 3,
> > +               .flags =3D (CLK_DIVIDER_POWER_OF_TWO |
> > +                         CLK_DIVIDER_ROUND_CLOSEST),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "gp1_pll",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_gp1_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct pll_params_table t7_mclk_pll_table[] =3D {
> > +       PLL_PARAMS(99, 1), /* DCO =3D 2376M OD =3D 1 PLL =3D 1152M */
> > +       PLL_PARAMS(100, 1), /* DCO =3D 2400M */
> > +       { /* sentinel */  }
> > +};
> > +
> > +static const struct reg_sequence t7_mclk_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_MCLK_PLL_CNTL0, .def =3D 0x20011064, .delay_=
us =3D 20 },
> > +       { .reg =3D ANACTRL_MCLK_PLL_CNTL0, .def =3D 0x30011064 },
> > +       { .reg =3D ANACTRL_MCLK_PLL_CNTL1, .def =3D 0x1470500f },
> > +       { .reg =3D ANACTRL_MCLK_PLL_CNTL2, .def =3D 0x00023041 },
> > +       { .reg =3D ANACTRL_MCLK_PLL_CNTL3, .def =3D 0x18180000 },
> > +       { .reg =3D ANACTRL_MCLK_PLL_CNTL4, .def =3D 0x00180303 },
> > +       { .reg =3D ANACTRL_MCLK_PLL_CNTL0, .def =3D 0x10011064, .delay_=
us =3D 20 },
> > +       { .reg =3D ANACTRL_MCLK_PLL_CNTL2, .def =3D 0x00023001, .delay_=
us =3D 20 }
> > +};
> > +
> > +static struct clk_regmap t7_mclk_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_MCLK_PLL_CNTL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_MCLK_PLL_CNTL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_MCLK_PLL_CNTL0,
> > +                       .shift   =3D 16,
> > +                       .width   =3D 5,
> > +               },
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_MCLK_PLL_CNTL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_MCLK_PLL_CNTL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_mclk_pll_table,
> > +               .init_regs =3D t7_mclk_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_mclk_init_regs),
> > +               //.ignore_init =3D false
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mclk_pll_dco",
> > +               .ops =3D &meson_clk_pll_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_IGNORE_UNUSED
> > +       },
> > +};
> > +
> > +/* max div is 16 */
> > +static const struct clk_div_table mclk_div[] =3D {
> > +       { .val =3D 0, .div =3D 1 },
> > +       { .val =3D 1, .div =3D 2 },
> > +       { .val =3D 2, .div =3D 4 },
> > +       { .val =3D 3, .div =3D 8 },
> > +       { .val =3D 4, .div =3D 16 },
> > +       { /* sentinel */ }
> > +};
> > +
> > +static struct clk_regmap t7_mclk_pre_od =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_MCLK_PLL_CNTL0,
> > +               .shift =3D 12,
> > +               .width =3D 3,
> > +               .table =3D mclk_div,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mclk_pre_od",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mclk_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mclk_pll =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_MCLK_PLL_CNTL4,
> > +               .shift =3D 16,
> > +               .width =3D 5,
> > +               .flags =3D CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CL=
OSEST |
> > +                        CLK_DIVIDER_ALLOW_ZERO,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mclk_pll",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mclk_pre_od.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct pll_params_table t7_hifi_pll_table[] =3D {
> > +       PLL_PARAMS(163, 1), /* DCO =3D 3932.16M */
> > +       { /* sentinel */  }
> > +};
> > +
> > +/*
> > + * Internal hifi pll emulation configuration parameters
> > + */
> > +static const struct reg_sequence t7_hifi_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_HIFIPLL_CTRL1, .def =3D 0x00014820 }, /*frac=
 =3D 20.16M */
> > +       { .reg =3D ANACTRL_HIFIPLL_CTRL2, .def =3D 0x00000000 },
> > +       { .reg =3D ANACTRL_HIFIPLL_CTRL3, .def =3D 0x6a285c00 },
> > +       { .reg =3D ANACTRL_HIFIPLL_CTRL4, .def =3D 0x65771290 },
> > +       { .reg =3D ANACTRL_HIFIPLL_CTRL5, .def =3D 0x3927200a },
> > +       { .reg =3D ANACTRL_HIFIPLL_CTRL6, .def =3D 0x56540000 }
> > +};
> > +
> > +static struct clk_regmap t7_hifi_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
> > +                       .shift   =3D 10,
> > +                       .width   =3D 5,
> > +               },
> > +               .frac =3D {
> > +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 19,
> > +               },
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_HIFIPLL_CTRL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_hifi_pll_table,
> > +               .init_regs =3D t7_hifi_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_hifi_init_regs),
> > +               .flags =3D CLK_MESON_PLL_ROUND_CLOSEST,
> > +               //.new_frac =3D 1,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hifi_pll_dco",
> > +               .ops =3D &meson_clk_pll_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hifi_pll =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_HIFIPLL_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 2,
> > +               .flags =3D (CLK_DIVIDER_POWER_OF_TWO |
> > +                         CLK_DIVIDER_ROUND_CLOSEST),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hifi_pll",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hifi_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +/*
> > + * The Meson t7 PCIE PLL is fined tuned to deliver a very precise
> > + * 100MHz reference clock for the PCIe Analog PHY, and thus requires
> > + * a strict register sequence to enable the PLL.
> > + */
> > +static const struct reg_sequence t7_pcie_pll_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL0, .def =3D 0x200c04c8 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL0, .def =3D 0x300c04c8 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL1, .def =3D 0x30000000 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL2, .def =3D 0x00001100 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL3, .def =3D 0x10058e00 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL4, .def =3D 0x000100c0 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL5, .def =3D 0x68000040 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL5, .def =3D 0x68000060, .delay_u=
s =3D 20 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL4, .def =3D 0x008100c0, .delay_u=
s =3D 10 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL0, .def =3D 0x340c04c8 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL0, .def =3D 0x140c04c8, .delay_u=
s =3D 10 },
> > +       { .reg =3D ANACTRL_PCIEPLL_CTRL2, .def =3D 0x00001000 }
> > +};
> > +
> > +/* Keep a single entry table for recalc/round_rate() ops */
> > +static const struct pll_params_table t7_pcie_pll_table[] =3D {
> > +       PLL_PARAMS(150, 1),
> > +       {0, 0}
> > +};
> > +
> > +static struct clk_regmap t7_pcie_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_PCIEPLL_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_PCIEPLL_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_PCIEPLL_CTRL0,
> > +                       .shift   =3D 10,
> > +                       .width   =3D 5,
> > +               },
> > +               .frac =3D {
> > +                       .reg_off =3D ANACTRL_PCIEPLL_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 12,
> > +               },
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_PCIEPLL_CTRL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_PCIEPLL_CTRL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .table =3D t7_pcie_pll_table,
> > +               .init_regs =3D t7_pcie_pll_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_pcie_pll_init_regs),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pcie_pll_dco",
> > +               .ops =3D &meson_clk_pcie_pll_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_pcie_pll_dco_div2 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pcie_pll_dco_div2",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pcie_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pcie_pll_od =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_PCIEPLL_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 5,
> > +               .flags =3D CLK_DIVIDER_ROUND_CLOSEST |
> > +                        CLK_DIVIDER_ONE_BASED |
> > +                        CLK_DIVIDER_ALLOW_ZERO,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pcie_pll_od",
> > +               .ops =3D &clk_regmap_divider_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pcie_pll_dco_div2.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_pcie_pll =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pcie_pll",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_pcie_pll_od.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pcie_bgp =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_PCIEPLL_CTRL5,
> > +               .bit_idx =3D 27,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pcie_bgp",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_pcie_pl=
l.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_IGNORE_UNUSED,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_pcie_hcsl =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_PCIEPLL_CTRL5,
> > +               .bit_idx =3D 3,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "pcie_hcsl",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_pcie_bg=
p.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmi_pll_dco =3D {
> > +       .data =3D &(struct meson_clk_pll_data){
> > +               .en =3D {
> > +                       .reg_off =3D ANACTRL_HDMIPLL_CTRL0,
> > +                       .shift   =3D 28,
> > +                       .width   =3D 1,
> > +               },
> > +               .m =3D {
> > +                       .reg_off =3D ANACTRL_HDMIPLL_CTRL0,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 8,
> > +               },
> > +               .n =3D {
> > +                       .reg_off =3D ANACTRL_HDMIPLL_CTRL0,
> > +                       .shift   =3D 10,
> > +                       .width   =3D 5,
> > +               },
> > +               .frac =3D {
> > +                       .reg_off =3D ANACTRL_HDMIPLL_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 19,
> > +               },
> > +               .l =3D {
> > +                       .reg_off =3D ANACTRL_HDMIPLL_CTRL0,
> > +                       .shift   =3D 31,
> > +                       .width   =3D 1,
> > +               },
> > +               .rst =3D {
> > +                       .reg_off =3D ANACTRL_HDMIPLL_CTRL0,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmi_pll_dco",
> > +               .ops =3D &meson_clk_pll_ro_ops,
> > +               .parent_data =3D &(const struct clk_parent_data) {
> > +                       .fw_name =3D "xtal",
> > +               },
> > +               .num_parents =3D 1,
> > +               /*
> > +                * Display directly handle hdmi pll registers ATM, we n=
eed
> > +                * NOCACHE to keep our view of the clock as accurate as
> > +                * possible
> > +                */
> > +               .flags =3D CLK_GET_RATE_NOCACHE,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmi_pll_od =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_HDMIPLL_CTRL0,
> > +               .shift =3D 16,
> > +               .width =3D 4,
> > +               .flags =3D CLK_DIVIDER_POWER_OF_TWO,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmi_pll_od",
> > +               .ops =3D &clk_regmap_divider_ro_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hdmi_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_hdmi_pll =3D {
> > +       .data =3D &(struct clk_regmap_div_data){
> > +               .offset =3D ANACTRL_HDMIPLL_CTRL0,
> > +               .shift =3D 20,
> > +               .width =3D 2,
> > +               .flags =3D CLK_DIVIDER_POWER_OF_TWO,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "hdmi_pll",
> > +               .ops =3D &clk_regmap_divider_ro_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_hdmi_pll_od.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_mpll_50m_div =3D {
> > +       .mult =3D 1,
> > +       .div =3D 80,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll_50m_div",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fixed_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static const struct clk_parent_data t7_mpll_50m_sel[] =3D {
> > +       { .fw_name =3D "xtal", },
> > +       { .hw =3D &t7_mpll_50m_div.hw },
> > +};
> > +
> > +static struct clk_regmap t7_mpll_50m =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D ANACTRL_FIXPLL_CTRL3,
> > +               .mask =3D 0x1,
> > +               .shift =3D 5,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll_50m",
> > +               .ops =3D &clk_regmap_mux_ro_ops,
> > +               .parent_data =3D t7_mpll_50m_sel,
> > +               .num_parents =3D ARRAY_SIZE(t7_mpll_50m_sel),
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_mpll_prediv =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll_prediv",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_fixed_pll_dco.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static const struct reg_sequence t7_mpll0_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_MPLL_CTRL2, .def =3D 0x40000033 }
> > +};
> > +
> > +static struct clk_regmap t7_mpll0_div =3D {
> > +       .data =3D &(struct meson_clk_mpll_data){
> > +               .sdm =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL1,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 14,
> > +               },
> > +               .sdm_en =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL1,
> > +                       .shift   =3D 30,
> > +                       .width   =3D 1,
> > +               },
> > +               .n2 =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL1,
> > +                       .shift   =3D 20,
> > +                       .width   =3D 9,
> > +               },
> > +               .ssen =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL1,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .lock =3D &meson_clk_lock,
> > +               .init_regs =3D t7_mpll0_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_mpll0_init_regs),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll0_div",
> > +               .ops =3D &meson_clk_mpll_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mpll_prediv.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mpll0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_MPLL_CTRL1,
> > +               .bit_idx =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_mpll0_d=
iv.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct reg_sequence t7_mpll1_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_MPLL_CTRL4,    .def =3D 0x40000033 }
> > +};
> > +
> > +static struct clk_regmap t7_mpll1_div =3D {
> > +       .data =3D &(struct meson_clk_mpll_data){
> > +               .sdm =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL3,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 14,
> > +               },
> > +               .sdm_en =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL3,
> > +                       .shift   =3D 30,
> > +                       .width   =3D 1,
> > +               },
> > +               .n2 =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL3,
> > +                       .shift   =3D 20,
> > +                       .width   =3D 9,
> > +               },
> > +               .ssen =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL3,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .lock =3D &meson_clk_lock,
> > +               .init_regs =3D t7_mpll1_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_mpll1_init_regs),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll1_div",
> > +               .ops =3D &meson_clk_mpll_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mpll_prediv.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mpll1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_MPLL_CTRL3,
> > +               .bit_idx =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_mpll1_d=
iv.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct reg_sequence t7_mpll2_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_MPLL_CTRL6, .def =3D 0x40000033 }
> > +};
> > +
> > +static struct clk_regmap t7_mpll2_div =3D {
> > +       .data =3D &(struct meson_clk_mpll_data){
> > +               .sdm =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL5,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 14,
> > +               },
> > +               .sdm_en =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL5,
> > +                       .shift   =3D 30,
> > +                       .width   =3D 1,
> > +               },
> > +               .n2 =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL5,
> > +                       .shift   =3D 20,
> > +                       .width   =3D 9,
> > +               },
> > +               .ssen =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL5,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .lock =3D &meson_clk_lock,
> > +               .init_regs =3D t7_mpll2_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_mpll2_init_regs),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll2_div",
> > +               .ops =3D &meson_clk_mpll_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mpll_prediv.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mpll2 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_MPLL_CTRL5,
> > +               .bit_idx =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll2",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_mpll2_d=
iv.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static const struct reg_sequence t7_mpll3_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_MPLL_CTRL8, .def =3D 0x40000033 }
> > +};
> > +
> > +static struct clk_regmap t7_mpll3_div =3D {
> > +       .data =3D &(struct meson_clk_mpll_data){
> > +               .sdm =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL7,
> > +                       .shift   =3D 0,
> > +                       .width   =3D 14,
> > +               },
> > +               .sdm_en =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL7,
> > +                       .shift   =3D 30,
> > +                       .width   =3D 1,
> > +               },
> > +               .n2 =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL7,
> > +                       .shift   =3D 20,
> > +                       .width   =3D 9,
> > +               },
> > +               .ssen =3D {
> > +                       .reg_off =3D ANACTRL_MPLL_CTRL7,
> > +                       .shift   =3D 29,
> > +                       .width   =3D 1,
> > +               },
> > +               .lock =3D &meson_clk_lock,
> > +               .init_regs =3D t7_mpll3_init_regs,
> > +               .init_count =3D ARRAY_SIZE(t7_mpll3_init_regs),
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll3_div",
> > +               .ops =3D &meson_clk_mpll_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mpll_prediv.hw
> > +               },
> > +               .num_parents =3D 1,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mpll3 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_MPLL_CTRL7,
> > +               .bit_idx =3D 31,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mpll3",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_mpll3_d=
iv.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mclk_0_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D ANACTRL_MCLK_PLL_CNTL4,
> > +               .mask =3D 0x3,
> > +               .shift =3D 4,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mclk_0_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D (const struct clk_parent_data []) {
> > +                       { .hw =3D &t7_mclk_pll.hw },
> > +                       { .fw_name =3D "xtal", },
> > +                       { .hw =3D &t7_mpll_50m.hw },
> > +               },
> > +               .num_parents =3D 3,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_mclk_0_div2 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mclk_0_div2",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_mclk_0_=
sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mclk_0_pre =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_MCLK_PLL_CNTL4,
> > +               .bit_idx =3D 2,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "mclk_0_pre",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mclk_0_div2.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mclk_0 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_MCLK_PLL_CNTL4,
> > +               .bit_idx =3D 0,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "mclk_0",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mclk_0_pre.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mclk_1_sel =3D {
> > +       .data =3D &(struct clk_regmap_mux_data){
> > +               .offset =3D ANACTRL_MCLK_PLL_CNTL4,
> > +               .mask =3D 0x3,
> > +               .shift =3D 12,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mclk_1_sel",
> > +               .ops =3D &clk_regmap_mux_ops,
> > +               .parent_data =3D (const struct clk_parent_data []) {
> > +                       { .hw =3D &t7_mclk_pll.hw },
> > +                       { .fw_name =3D "xtal", },
> > +                       { .hw =3D &t7_mpll_50m.hw },
> > +               },
> > +               .num_parents =3D 3,
> > +       },
> > +};
> > +
> > +static struct clk_fixed_factor t7_mclk_1_div2 =3D {
> > +       .mult =3D 1,
> > +       .div =3D 2,
> > +       .hw.init =3D &(struct clk_init_data){
> > +               .name =3D "mclk_1_div2",
> > +               .ops =3D &clk_fixed_factor_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) { &t7_mclk_1_=
sel.hw },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mclk_1_pre =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_MCLK_PLL_CNTL4,
> > +               .bit_idx =3D 10,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "mclk_1_pre",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mclk_1_div2.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +static struct clk_regmap t7_mclk_1 =3D {
> > +       .data =3D &(struct clk_regmap_gate_data){
> > +               .offset =3D ANACTRL_MCLK_PLL_CNTL4,
> > +               .bit_idx =3D 8,
> > +       },
> > +       .hw.init =3D &(struct clk_init_data) {
> > +               .name =3D "mclk_1",
> > +               .ops =3D &clk_regmap_gate_ops,
> > +               .parent_hws =3D (const struct clk_hw *[]) {
> > +                       &t7_mclk_1_pre.hw
> > +               },
> > +               .num_parents =3D 1,
> > +               .flags =3D CLK_SET_RATE_PARENT,
> > +       },
> > +};
> > +
> > +/* Array of all clocks provided by this provider */
> > +static struct clk_hw *t7_pll_hw_clks[] =3D {
> > +       [CLKID_FIXED_PLL_DCO]           =3D &t7_fixed_pll_dco.hw,
> > +       [CLKID_FIXED_PLL]               =3D &t7_fixed_pll.hw,
> > +       [CLKID_SYS_PLL_DCO]             =3D &t7_sys_pll_dco.hw,
> > +       [CLKID_SYS_PLL]                 =3D &t7_sys_pll.hw,
> > +       [CLKID_SYS1_PLL_DCO]            =3D &t7_sys1_pll_dco.hw,
> > +       [CLKID_SYS1_PLL]                =3D &t7_sys1_pll.hw,
> > +       [CLKID_FCLK_DIV2_DIV]           =3D &t7_fclk_div2_div.hw,
> > +       [CLKID_FCLK_DIV2]               =3D &t7_fclk_div2.hw,
> > +       [CLKID_FCLK_DIV3_DIV]           =3D &t7_fclk_div3_div.hw,
> > +       [CLKID_FCLK_DIV3]               =3D &t7_fclk_div3.hw,
> > +       [CLKID_FCLK_DIV4_DIV]           =3D &t7_fclk_div4_div.hw,
> > +       [CLKID_FCLK_DIV4]               =3D &t7_fclk_div4.hw,
> > +       [CLKID_FCLK_DIV5_DIV]           =3D &t7_fclk_div5_div.hw,
> > +       [CLKID_FCLK_DIV5]               =3D &t7_fclk_div5.hw,
> > +       [CLKID_FCLK_DIV7_DIV]           =3D &t7_fclk_div7_div.hw,
> > +       [CLKID_FCLK_DIV7]               =3D &t7_fclk_div7.hw,
> > +       [CLKID_FCLK_DIV2P5_DIV]         =3D &t7_fclk_div2p5_div.hw,
> > +       [CLKID_FCLK_DIV2P5]             =3D &t7_fclk_div2p5.hw,
> > +       [CLKID_GP0_PLL_DCO]             =3D &t7_gp0_pll_dco.hw,
> > +       [CLKID_GP0_PLL]                 =3D &t7_gp0_pll.hw,
> > +       [CLKID_GP1_PLL_DCO]             =3D &t7_gp1_pll_dco.hw,
> > +       [CLKID_GP1_PLL]                 =3D &t7_gp1_pll.hw,
> > +       [CLKID_MCLK_PLL_DCO]            =3D &t7_mclk_pll_dco.hw,
> > +       [CLKID_MCLK_PRE]                =3D &t7_mclk_pre_od.hw,
> > +       [CLKID_MCLK_PLL]                =3D &t7_mclk_pll.hw,
> > +       [CLKID_HIFI_PLL_DCO]            =3D &t7_hifi_pll_dco.hw,
> > +       [CLKID_HIFI_PLL]                =3D &t7_hifi_pll.hw,
> > +       [CLKID_PCIE_PLL_DCO]            =3D &t7_pcie_pll_dco.hw,
> > +       [CLKID_PCIE_PLL_DCO_DIV2]       =3D &t7_pcie_pll_dco_div2.hw,
> > +       [CLKID_PCIE_PLL_OD]             =3D &t7_pcie_pll_od.hw,
> > +       [CLKID_PCIE_PLL]                =3D &t7_pcie_pll.hw,
> > +       [CLKID_PCIE_BGP]                =3D &t7_pcie_bgp.hw,
> > +       [CLKID_PCIE_HCSL]               =3D &t7_pcie_hcsl.hw,
> > +       [CLKID_HDMI_PLL_DCO]            =3D &t7_hdmi_pll_dco.hw,
> > +       [CLKID_HDMI_PLL_OD]             =3D &t7_hdmi_pll_od.hw,
> > +       [CLKID_HDMI_PLL]                =3D &t7_hdmi_pll.hw,
> > +       [CLKID_MPLL_50M_DIV]            =3D &t7_mpll_50m_div.hw,
> > +       [CLKID_MPLL_50M]                =3D &t7_mpll_50m.hw,
> > +       [CLKID_MPLL_PREDIV]             =3D &t7_mpll_prediv.hw,
> > +       [CLKID_MPLL0_DIV]               =3D &t7_mpll0_div.hw,
> > +       [CLKID_MPLL0]                   =3D &t7_mpll0.hw,
> > +       [CLKID_MPLL1_DIV]               =3D &t7_mpll1_div.hw,
> > +       [CLKID_MPLL1]                   =3D &t7_mpll1.hw,
> > +       [CLKID_MPLL2_DIV]               =3D &t7_mpll2_div.hw,
> > +       [CLKID_MPLL2]                   =3D &t7_mpll2.hw,
> > +       [CLKID_MPLL3_DIV]               =3D &t7_mpll3_div.hw,
> > +       [CLKID_MPLL3]                   =3D &t7_mpll3.hw,
> > +       [CLKID_MCLK_0_SEL]              =3D &t7_mclk_0_sel.hw,
> > +       [CLKID_MCLK_0_DIV2]             =3D &t7_mclk_0_div2.hw,
> > +       [CLKID_MCLK_0_PRE]              =3D &t7_mclk_0_pre.hw,
> > +       [CLKID_MCLK_0]                  =3D &t7_mclk_0.hw,
> > +       [CLKID_MCLK_1_SEL]              =3D &t7_mclk_1_sel.hw,
> > +       [CLKID_MCLK_1_DIV2]             =3D &t7_mclk_1_div2.hw,
> > +       [CLKID_MCLK_1_PRE]              =3D &t7_mclk_1_pre.hw,
> > +       [CLKID_MCLK_1]                  =3D &t7_mclk_1.hw,
> > +};
> > +
> > +static struct clk_regmap *const t7_pll_clk_regmaps[] =3D {
> > +       &t7_fixed_pll_dco,
> > +       &t7_fixed_pll,
> > +       &t7_sys_pll_dco,
> > +       &t7_sys_pll,
> > +       &t7_sys1_pll_dco,
> > +       &t7_sys1_pll,
> > +       &t7_fclk_div2,
> > +       &t7_fclk_div3,
> > +       &t7_fclk_div4,
> > +       &t7_fclk_div5,
> > +       &t7_fclk_div7,
> > +       &t7_fclk_div2p5,
> > +       &t7_gp0_pll_dco,
> > +       &t7_gp0_pll,
> > +       &t7_gp1_pll_dco,
> > +       &t7_gp1_pll,
> > +       &t7_mclk_pll_dco,
> > +       &t7_mclk_pre_od,
> > +       &t7_mclk_pll,
> > +       &t7_hifi_pll_dco,
> > +       &t7_hifi_pll,
> > +       &t7_pcie_pll_dco,
> > +       &t7_pcie_pll_od,
> > +       &t7_pcie_bgp,
> > +       &t7_pcie_hcsl,
> > +       &t7_hdmi_pll_dco,
> > +       &t7_hdmi_pll_od,
> > +       &t7_hdmi_pll,
> > +       &t7_mpll_50m,
> > +       &t7_mpll0_div,
> > +       &t7_mpll0,
> > +       &t7_mpll1_div,
> > +       &t7_mpll1,
> > +       &t7_mpll2_div,
> > +       &t7_mpll2,
> > +       &t7_mpll3_div,
> > +       &t7_mpll3,
> > +       &t7_mclk_0_sel,
> > +       &t7_mclk_0_pre,
> > +       &t7_mclk_0,
> > +       &t7_mclk_1_sel,
> > +       &t7_mclk_1_pre,
> > +       &t7_mclk_1
> > +};
> > +
> > +static const struct reg_sequence t7_init_regs[] =3D {
> > +       { .reg =3D ANACTRL_MPLL_CTRL0,    .def =3D 0x00000543 },
> > +};
> > +
> > +static struct regmap_config clkc_regmap_config =3D {
> > +       .reg_bits       =3D 32,
> > +       .val_bits       =3D 32,
> > +       .reg_stride     =3D 4,
> > +};
> > +
> > +static struct meson_clk_hw_data t7_pll_clks =3D {
> > +       .hws =3D t7_pll_hw_clks,
> > +       .num =3D ARRAY_SIZE(t7_pll_hw_clks),
> > +};
> > +
> > +static int amlogic_t7_pll_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct regmap *regmap;
> > +       void __iomem *base;
> > +       int ret, i;
> > +
> > +       base =3D devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(base))
> > +               return dev_err_probe(dev, PTR_ERR(base), "can't ioremap=
 resource\n");
> > +
> > +       regmap =3D devm_regmap_init_mmio(dev, base, &clkc_regmap_config=
);
> > +       if (IS_ERR(regmap))
> > +               return dev_err_probe(dev, PTR_ERR(regmap), "can't init =
regmap mmio region\n");
> > +
> > +       ret =3D regmap_multi_reg_write(regmap, t7_init_regs, ARRAY_SIZE=
(t7_init_regs));
> > +       if (ret)
> > +               return dev_err_probe(dev, ret, "Failed to init register=
s\n");
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(t7_pll_clk_regmaps); i++)
> > +               t7_pll_clk_regmaps[i]->map =3D regmap;
> > +
> > +       /* Register clocks */
> > +       for (i =3D 0; i < t7_pll_clks.num; i++) {
> > +               /* array might be sparse */
> > +               if (!t7_pll_clks.hws[i])
> > +                       continue;
> > +
> > +               ret =3D devm_clk_hw_register(dev, t7_pll_clks.hws[i]);
> > +               if (ret)
> > +                       return dev_err_probe(dev, ret, "clock[%d] regis=
tration failed\n", i);
> > +       }
> > +
> > +       return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, &t7_p=
ll_clks);
> > +}
> > +
> > +static const struct of_device_id t7_pll_clkc_match_table[] =3D {
> > +       { .compatible =3D "amlogic,t7-pll-clkc", },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, t7_pll_clkc_match_table);
> > +
> > +static struct platform_driver t7_pll_clkc_driver =3D {
> > +       .probe          =3D amlogic_t7_pll_probe,
> > +       .driver         =3D {
> > +               .name   =3D "t7-pll-clkc",
> > +               .of_match_table =3D t7_pll_clkc_match_table,
> > +       },
> > +};
> > +
> > +module_platform_driver(t7_pll_clkc_driver);
> > +MODULE_AUTHOR("Yu Tu <yu.tu@amlogic.com>");
> > +MODULE_AUTHOR("Lucas Tanure <tanure@linux.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/clk/meson/t7-pll.h b/drivers/clk/meson/t7-pll.h
> > new file mode 100644
> > index 000000000000..bb0d66198780
> > --- /dev/null
> > +++ b/drivers/clk/meson/t7-pll.h
> > @@ -0,0 +1,83 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > +/*
> > + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> > + */
> > +
> > +#ifndef __MESON_T7_PLL_H__
> > +#define __MESON_T7_PLL_H__
> > +
> > +/* ANA_CTRL - Registers
> > + * REG_BASE:  REGISTER_BASE_ADDR =3D 0xfe008000
> > + */
> > +#define ANACTRL_SYS0PLL_CTRL0          (0x0000  << 2)
> > +#define ANACTRL_SYS0PLL_CTRL1          (0x0001  << 2)
> > +#define ANACTRL_SYS0PLL_CTRL2          (0x0002  << 2)
> > +#define ANACTRL_SYS0PLL_CTRL3          (0x0003  << 2)
> > +#define ANACTRL_SYS0PLL_STS            (0x0004  << 2)
> > +#define ANACTRL_SYS1PLL_CTRL0          (0x0008  << 2)
> > +#define ANACTRL_SYS1PLL_CTRL1          (0x0009  << 2)
> > +#define ANACTRL_SYS1PLL_CTRL2          (0x000a  << 2)
> > +#define ANACTRL_SYS1PLL_CTRL3          (0x000b  << 2)
> > +#define ANACTRL_SYS1PLL_STS            (0x000c  << 2)
> > +#define ANACTRL_FIXPLL_CTRL0           (0x0010  << 2)
> > +#define ANACTRL_FIXPLL_CTRL1           (0x0011  << 2)
> > +#define ANACTRL_FIXPLL_CTRL2           (0x0012  << 2)
> > +#define ANACTRL_FIXPLL_CTRL3           (0x0013  << 2)
> > +#define ANACTRL_FIXPLL_CTRL4           (0x0014  << 2)
> > +#define ANACTRL_FIXPLL_CTRL5           (0x0015  << 2)
> > +#define ANACTRL_FIXPLL_CTRL6           (0x0016  << 2)
> > +#define ANACTRL_FIXPLL_STS             (0x0017  << 2)
> > +#define ANACTRL_GP0PLL_CTRL0           (0x0020  << 2)
> > +#define ANACTRL_GP0PLL_CTRL1           (0x0021  << 2)
> > +#define ANACTRL_GP0PLL_CTRL2           (0x0022  << 2)
> > +#define ANACTRL_GP0PLL_CTRL3           (0x0023  << 2)
> > +#define ANACTRL_GP0PLL_CTRL4           (0x0024  << 2)
> > +#define ANACTRL_GP0PLL_CTRL5           (0x0025  << 2)
> > +#define ANACTRL_GP0PLL_CTRL6           (0x0026  << 2)
> > +#define ANACTRL_GP0PLL_STS             (0x0027  << 2)
> > +#define ANACTRL_GP1PLL_CTRL0           (0x0030  << 2)
> > +#define ANACTRL_GP1PLL_CTRL1           (0x0031  << 2)
> > +#define ANACTRL_GP1PLL_CTRL2           (0x0032  << 2)
> > +#define ANACTRL_GP1PLL_CTRL3           (0x0033  << 2)
> > +#define ANACTRL_GP1PLL_STS             (0x0037  << 2)
> > +#define ANACTRL_HIFIPLL_CTRL0          (0x0040  << 2)
> > +#define ANACTRL_HIFIPLL_CTRL1          (0x0041  << 2)
> > +#define ANACTRL_HIFIPLL_CTRL2          (0x0042  << 2)
> > +#define ANACTRL_HIFIPLL_CTRL3          (0x0043  << 2)
> > +#define ANACTRL_HIFIPLL_CTRL4          (0x0044  << 2)
> > +#define ANACTRL_HIFIPLL_CTRL5          (0x0045  << 2)
> > +#define ANACTRL_HIFIPLL_CTRL6          (0x0046  << 2)
> > +#define ANACTRL_HIFIPLL_STS            (0x0047  << 2)
> > +#define ANACTRL_PCIEPLL_CTRL0          (0x0050  << 2)
> > +#define ANACTRL_PCIEPLL_CTRL1          (0x0051  << 2)
> > +#define ANACTRL_PCIEPLL_CTRL2          (0x0052  << 2)
> > +#define ANACTRL_PCIEPLL_CTRL3          (0x0053  << 2)
> > +#define ANACTRL_PCIEPLL_CTRL4          (0x0054  << 2)
> > +#define ANACTRL_PCIEPLL_CTRL5          (0x0055  << 2)
> > +#define ANACTRL_PCIEPLL_STS            (0x0056  << 2)
> > +#define ANACTRL_MPLL_CTRL0             (0x0060  << 2)
> > +#define ANACTRL_MPLL_CTRL1             (0x0061  << 2)
> > +#define ANACTRL_MPLL_CTRL2             (0x0062  << 2)
> > +#define ANACTRL_MPLL_CTRL3             (0x0063  << 2)
> > +#define ANACTRL_MPLL_CTRL4             (0x0064  << 2)
> > +#define ANACTRL_MPLL_CTRL5             (0x0065  << 2)
> > +#define ANACTRL_MPLL_CTRL6             (0x0066  << 2)
> > +#define ANACTRL_MPLL_CTRL7             (0x0067  << 2)
> > +#define ANACTRL_MPLL_CTRL8             (0x0068  << 2)
> > +#define ANACTRL_MPLL_STS               (0x0069  << 2)
> > +#define ANACTRL_HDMIPLL_CTRL0          (0x0070  << 2)
> > +#define ANACTRL_HDMIPLL_CTRL1          (0x0071  << 2)
> > +#define ANACTRL_HDMIPLL_CTRL2          (0x0072  << 2)
> > +#define ANACTRL_HDMIPLL_CTRL3          (0x0073  << 2)
> > +#define ANACTRL_HDMIPLL_CTRL4          (0x0074  << 2)
> > +#define ANACTRL_HDMIPLL_CTRL5          (0x0075  << 2)
> > +#define ANACTRL_HDMIPLL_CTRL6          (0x0076  << 2)
> > +#define ANACTRL_HDMIPLL_STS            (0x0077  << 2)
> > +#define ANACTRL_MCLK_PLL_CNTL0         (0x00c0  << 2)
> > +#define ANACTRL_MCLK_PLL_CNTL1         (0x00c1  << 2)
> > +#define ANACTRL_MCLK_PLL_CNTL2         (0x00c2  << 2)
> > +#define ANACTRL_MCLK_PLL_CNTL3         (0x00c3  << 2)
> > +#define ANACTRL_MCLK_PLL_CNTL4         (0x00c4  << 2)
> > +#define ANACTRL_MCLK_PLL_STS           (0x00c5  << 2)
> > +
> > +#endif /* __MESON_T7_PLL_H__ */
> > diff --git a/include/dt-bindings/clock/amlogic,t7-peripherals-clkc.h b/=
include/dt-bindings/clock/amlogic,t7-peripherals-clkc.h
> > new file mode 100644
> > index 000000000000..64731385c64b
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/amlogic,t7-peripherals-clkc.h
> > @@ -0,0 +1,410 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> > +/*
> > + * Copyright (c) 2022-2023 Amlogic, Inc. All rights reserved.
> > + * Author: Yu Tu <yu.tu@amlogic.com>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_T7_PERIPHERALS_CLKC_H
> > +#define _DT_BINDINGS_CLOCK_AMLOGIC_T7_PERIPHERALS_CLKC_H
> > +
> > +#define CLKID_RTC_32K_CLKIN            0
> > +#define CLKID_RTC_32K_DIV              1
> > +#define CLKID_RTC_32K_XATL             2
> > +#define CLKID_RTC_32K_MUX              3
> > +#define CLKID_RTC_CLK                  4
> > +#define CLKID_SYS_CLK_B_MUX            5
> > +#define CLKID_SYS_CLK_B_DIV            6
> > +#define CLKID_SYS_CLK_B_GATE           7
> > +#define CLKID_SYS_CLK_A_MUX            8
> > +#define CLKID_SYS_CLK_A_DIV            9
> > +#define CLKID_SYS_CLK_A_GATE           10
> > +#define CLKID_SYS_CLK                  11
> > +#define CLKID_CECA_32K_CLKIN           12
> > +#define CLKID_CECA_32K_DIV             13
> > +#define CLKID_CECA_32K_MUX_PRE         14
> > +#define CLKID_CECA_32K_MUX             15
> > +#define CLKID_CECA_32K_CLKOUT          16
> > +#define CLKID_CECB_32K_CLKIN           17
> > +#define CLKID_CECB_32K_DIV             18
> > +#define CLKID_CECB_32K_MUX_PRE         19
> > +#define CLKID_CECB_32K_MUX             20
> > +#define CLKID_CECB_32K_CLKOUT          21
> > +#define CLKID_SC_CLK_MUX               22
> > +#define CLKID_SC_CLK_DIV               23
> > +#define CLKID_SC_CLK_GATE              24
> > +#define CLKID_DSPA_CLK_B_MUX           25
> > +#define CLKID_DSPA_CLK_B_DIV           26
> > +#define CLKID_DSPA_CLK_B_GATE          27
> > +#define CLKID_DSPA_CLK_A_MUX           28
> > +#define CLKID_DSPA_CLK_A_DIV           29
> > +#define CLKID_DSPA_CLK_A_GATE          30
> > +#define CLKID_DSPA_CLK                 31
> > +#define CLKID_24M_CLK_GATE             32
> > +#define CLKID_12M_CLK_DIV              33
> > +#define CLKID_12M_CLK_GATE             34
> > +#define CLKID_25M_CLK_DIV              35
> > +#define CLKID_25M_CLK_GATE             36
> > +#define CLKID_VID_PLL_DIV              37
> > +#define CLKID_VID_PLL_MUX              38
> > +#define CLKID_VID_PLL                  39
> > +#define CLKID_VCLK_MUX                 40
> > +#define CLKID_VCLK2_MUX                        41
> > +#define CLKID_VCLK_INPUT               42
> > +#define CLKID_VCLK2_INPUT              43
> > +#define CLKID_VCLK_DIV                 44
> > +#define CLKID_VCLK2_DIV                        45
> > +#define CLKID_VCLK                     46
> > +#define CLKID_VCLK2                    47
> > +#define CLKID_VCLK_DIV1                        48
> > +#define CLKID_VCLK_DIV2_EN             49
> > +#define CLKID_VCLK_DIV4_EN             50
> > +#define CLKID_VCLK_DIV6_EN             51
> > +#define CLKID_VCLK_DIV12_EN            52
> > +#define CLKID_VCLK2_DIV1               53
> > +#define CLKID_VCLK2_DIV2_EN            54
> > +#define CLKID_VCLK2_DIV4_EN            55
> > +#define CLKID_VCLK2_DIV6_EN            56
> > +#define CLKID_VCLK2_DIV12_EN           57
> > +#define CLKID_VCLK_DIV2                        58
> > +#define CLKID_VCLK_DIV4                        59
> > +#define CLKID_VCLK_DIV6                        60
> > +#define CLKID_VCLK_DIV12               61
> > +#define CLKID_VCLK2_DIV2               62
> > +#define CLKID_VCLK2_DIV4               63
> > +#define CLKID_VCLK2_DIV6               64
> > +#define CLKID_VCLK2_DIV12              65
> > +#define CLKID_CTS_ENCI_MUX             66
> > +#define CLKID_CTS_ENCP_MUX             67
> > +#define CLKID_CTS_VDAC_MUX             68
> > +#define CLKID_HDMI_TX_MUX              69
> > +#define CLKID_CTS_ENCI                 70
> > +#define CLKID_CTS_ENCP                 71
> > +#define CLKID_CTS_VDAC                 72
> > +#define CLKID_HDMI_TX                  73
> > +#define CLKID_HDMITX_SYS_MUX           74
> > +#define CLKID_HDMITX_SYS_DIV           75
> > +#define CLKID_HDMITX_SYS               76
> > +#define CLKID_TS_CLK_DIV               77
> > +#define CLKID_TS_CLK_GATE              78
> > +#define CLKID_MALI_0_SEL               79
> > +#define CLKID_MALI_0_DIV               80
> > +#define CLKID_MALI_0                   81
> > +#define CLKID_MALI_1_SEL               82
> > +#define CLKID_MALI_1_DIV               83
> > +#define CLKID_MALI_1                   84
> > +#define CLKID_MALI_MUX                 85
> > +#define CLKID_VDEC_P0_MUX              86
> > +#define CLKID_VDEC_P0_DIV              87
> > +#define CLKID_VDEC_P0                  88
> > +#define CLKID_VDEC_P1_MUX              89
> > +#define CLKID_VDEC_P1_DIV              90
> > +#define CLKID_VDEC_P1                  91
> > +#define CLKID_VDEC_MUX                 92
> > +#define CLKID_HCODEC_P0_MUX            93
> > +#define CLKID_HCODEC_P0_DIV            94
> > +#define CLKID_HCODEC_P0                        95
> > +#define CLKID_HCODEC_P1_MUX            96
> > +#define CLKID_HCODEC_P1_DIV            97
> > +#define CLKID_HCODEC_P1                        98
> > +#define CLKID_HCODEC_MUX               99
> > +#define CLKID_HEVCB_P0_MUX             100
> > +#define CLKID_HEVCB_P0_DIV             101
> > +#define CLKID_HEVCB_P0                 102
> > +#define CLKID_HEVCB_P1_MUX             103
> > +#define CLKID_HEVCB_P1_DIV             104
> > +#define CLKID_HEVCB_P1                 105
> > +#define CLKID_HEVCB_MUX                        106
> > +#define CLKID_HEVCF_P0_MUX             107
> > +#define CLKID_HEVCF_P0_DIV             108
> > +#define CLKID_HEVCF_P0                 109
> > +#define CLKID_HEVCF_P1_MUX             110
> > +#define CLKID_HEVCF_P1_DIV             111
> > +#define CLKID_HEVCF_P1                 112
> > +#define CLKID_HEVCF_MUX                        113
> > +#define CLKID_WAVE_A_MUX               114
> > +#define CLKID_WAVE_A_DIV               115
> > +#define CLKID_WAVE_A_GATE              116
> > +#define CLKID_WAVE_B_MUX               117
> > +#define CLKID_WAVE_B_DIV               118
> > +#define CLKID_WAVE_B_GATE              119
> > +#define CLKID_WAVE_C_MUX               120
> > +#define CLKID_WAVE_C_DIV               121
> > +#define CLKID_WAVE_C_GATE              122
> > +#define CLKID_VPU_0_MUX                        123
> > +#define CLKID_VPU_0_DIV                        124
> > +#define CLKID_VPU_0                    125
> > +#define CLKID_VPU_1_MUX                        126
> > +#define CLKID_VPU_1_DIV                        127
> > +#define CLKID_VPU_1                    128
> > +#define CLKID_VPU                      129
> > +#define CLKID_VPU_CLKB_TMP_MUX         130
> > +#define CLKID_VPU_CLKB_TMP_DIV         131
> > +#define CLKID_VPU_CLKB_TMP             132
> > +#define CLKID_VPU_CLKB_DIV             133
> > +#define CLKID_VPU_CLKB                 134
> > +#define CLKID_VPU_CLKC_P0_MUX          135
> > +#define CLKID_VPU_CLKC_P0_DIV          136
> > +#define CLKID_VPU_CLKC_P0              137
> > +#define CLKID_VPU_CLKC_P1_MUX          138
> > +#define CLKID_VPU_CLKC_P1_DIV          139
> > +#define CLKID_VPU_CLKC_P1              140
> > +#define CLKID_VPU_CLKC_MUX             141
> > +#define CLKID_VAPB_0_MUX               142
> > +#define CLKID_VAPB_0_DIV               143
> > +#define CLKID_VAPB_0                   144
> > +#define CLKID_VAPB_1_MUX               145
> > +#define CLKID_VAPB_1_DIV               146
> > +#define CLKID_VAPB_1                   147
> > +#define CLKID_VAPB                     148
> > +#define CLKID_GE2D                     149
> > +#define CLKID_VDIN_MEAS_MUX            150
> > +#define CLKID_VDIN_MEAS_DIV            151
> > +#define CLKID_VDIN_MEAS_GATE           152
> > +#define CLKID_DSI_A_MEAS_MUX           153
> > +#define CLKID_DSI_A_MEAS_DIV           154
> > +#define CLKID_DSI_A_MEAS_GATE          155
> > +#define CLKID_DSI_B_MEAS_MUX           156
> > +#define CLKID_DSI_B_MEAS_DIV           157
> > +#define CLKID_DSI_B_MEAS_GATE          158
> > +#define CLKID_DSI0_PHY_MUX             159
> > +#define CLKID_DSI0_PHY_DIV             160
> > +#define CLKID_DSI0_PHY_GATE            161
> > +#define CLKID_DSI1_PHY_MUX             162
> > +#define CLKID_DSI1_PHY_DIV             163
> > +#define CLKID_DSI1_PHY_GATE            164
> > +#define CLKID_VID_LOCK_DIV             165
> > +#define CLKID_VID_LOCK                 166
> > +#define CLKID_PWM_A_MUX                        167
> > +#define CLKID_PWM_A_DIV                        168
> > +#define CLKID_PWM_A_GATE               169
> > +#define CLKID_PWM_B_MUX                        170
> > +#define CLKID_PWM_B_DIV                        171
> > +#define CLKID_PWM_B_GATE               172
> > +#define CLKID_PWM_C_MUX                        173
> > +#define CLKID_PWM_C_DIV                        174
> > +#define CLKID_PWM_C_GATE               175
> > +#define CLKID_PWM_D_MUX                        176
> > +#define CLKID_PWM_D_DIV                        177
> > +#define CLKID_PWM_D_GATE               178
> > +#define CLKID_PWM_E_MUX                        179
> > +#define CLKID_PWM_E_DIV                        180
> > +#define CLKID_PWM_E_GATE               181
> > +#define CLKID_PWM_F_MUX                        182
> > +#define CLKID_PWM_F_DIV                        183
> > +#define CLKID_PWM_F_GATE               184
> > +#define CLKID_PWM_AO_A_MUX             185
> > +#define CLKID_PWM_AO_A_DIV             186
> > +#define CLKID_PWM_AO_A_GATE            187
> > +#define CLKID_PWM_AO_B_MUX             188
> > +#define CLKID_PWM_AO_B_DIV             189
> > +#define CLKID_PWM_AO_B_GATE            190
> > +#define CLKID_PWM_AO_C_MUX             191
> > +#define CLKID_PWM_AO_C_DIV             192
> > +#define CLKID_PWM_AO_C_GATE            193
> > +#define CLKID_PWM_AO_D_MUX             194
> > +#define CLKID_PWM_AO_D_DIV             195
> > +#define CLKID_PWM_AO_D_GATE            196
> > +#define CLKID_PWM_AO_E_MUX             197
> > +#define CLKID_PWM_AO_E_DIV             198
> > +#define CLKID_PWM_AO_E_GATE            199
> > +#define CLKID_PWM_AO_F_MUX             200
> > +#define CLKID_PWM_AO_F_DIV             201
> > +#define CLKID_PWM_AO_F_GATE            202
> > +#define CLKID_PWM_AO_G_MUX             203
> > +#define CLKID_PWM_AO_G_DIV             204
> > +#define CLKID_PWM_AO_G_GATE            205
> > +#define CLKID_PWM_AO_H_MUX             206
> > +#define CLKID_PWM_AO_H_DIV             207
> > +#define CLKID_PWM_AO_H_GATE            208
> > +#define CLKID_SPICC0_MUX               209
> > +#define CLKID_SPICC0_DIV               210
> > +#define CLKID_SPICC0_GATE              211
> > +#define CLKID_SPICC1_MUX               212
> > +#define CLKID_SPICC1_DIV               213
> > +#define CLKID_SPICC1_GATE              214
> > +#define CLKID_SPICC2_MUX               215
> > +#define CLKID_SPICC2_DIV               216
> > +#define CLKID_SPICC2_GATE              217
> > +#define CLKID_SPICC3_MUX               218
> > +#define CLKID_SPICC3_DIV               219
> > +#define CLKID_SPICC3_GATE              220
> > +#define CLKID_SPICC4_MUX               221
> > +#define CLKID_SPICC4_DIV               222
> > +#define CLKID_SPICC4_GATE              223
> > +#define CLKID_SPICC5_MUX               224
> > +#define CLKID_SPICC5_DIV               225
> > +#define CLKID_SPICC5_GATE              226
> > +#define CLKID_SD_EMMC_C_CLK_MUX                227
> > +#define CLKID_SD_EMMC_C_CLK_DIV                228
> > +#define CLKID_SD_EMMC_C_CLK            229
> > +#define CLKID_SD_EMMC_A_CLK_MUX                230
> > +#define CLKID_SD_EMMC_A_CLK_DIV                231
> > +#define CLKID_SD_EMMC_A_CLK            232
> > +#define CLKID_SD_EMMC_B_CLK_MUX                233
> > +#define CLKID_SD_EMMC_B_CLK_DIV                234
> > +#define CLKID_SD_EMMC_B_CLK            235
> > +#define CLKID_ETH_RMII_SEL             236
> > +#define CLKID_ETH_RMII_DIV             237
> > +#define CLKID_ETH_RMII                 238
> > +#define CLKID_ETH_DIV8                 239
> > +#define CLKID_ETH_125M                 240
> > +#define CLKID_SARADC_MUX               241
> > +#define CLKID_SARADC_DIV               242
> > +#define CLKID_SARADC_GATE              243
> > +#define CLKID_GEN_MUX                  244
> > +#define CLKID_GEN_DIV                  245
> > +#define CLKID_GEN_GATE                 246
> > +#define CLKID_DSPB_CLK_B_MUX           247
> > +#define CLKID_DSPB_CLK_B_DIV           248
> > +#define CLKID_DSPB_CLK_B_GATE          249
> > +#define CLKID_DSPB_CLK_A_MUX           250
> > +#define CLKID_DSPB_CLK_A_DIV           251
> > +#define CLKID_DSPB_CLK_A_GATE          252
> > +#define CLKID_DSPB_CLK                 253
> > +#define CLKID_MIPI_ISP_MUX             254
> > +#define CLKID_MIPI_ISP_DIV             255
> > +#define CLKID_MIPI_ISP                 256
> > +#define CLKID_MIPI_CSI_PHY_SEL0                257
> > +#define CLKID_MIPI_CSI_PHY_DIV0                258
> > +#define CLKID_MIPI_CSI_PHY0            259
> > +#define CLKID_MIPI_CSI_PHY_SEL1                260
> > +#define CLKID_MIPI_CSI_PHY_DIV1                261
> > +#define CLKID_MIPI_CSI_PHY1            262
> > +#define CLKID_MIPI_CSI_PHY_CLK         263
> > +#define CLKID_GDCCLK_0_MUX             264
> > +#define CLKID_GDCCLK_0_DIV             265
> > +#define CLKID_GDCCLK_0                 266
> > +#define CLKID_GDCCLK_1_MUX             267
> > +#define CLKID_GDCCLK_1_DIV             268
> > +#define CLKID_GDCCLK_1                 269
> > +#define CLKID_GDCCLK                   270
> > +#define CLKID_GDC_CLK                  271
> > +#define CLKID_DEWARPCLK_0_MUX          272
> > +#define CLKID_DEWARPCLK_0_DIV          273
> > +#define CLKID_DEWARPCLK_0              274
> > +#define CLKID_DEWARPCLK_1_MUX          275
> > +#define CLKID_DEWARPCLK_1_DIV          276
> > +#define CLKID_DEWARPCLK_1              277
> > +#define CLKID_DEWARPCLK                        278
> > +#define CLKID_DEWARP_CLK               279
> > +#define CLKID_ANAKIN_0_MUX             280
> > +#define CLKID_ANAKIN_0_DIV             281
> > +#define CLKID_ANAKIN_0                 282
> > +#define CLKID_ANAKIN_1_MUX             283
> > +#define CLKID_ANAKIN_1_DIV             284
> > +#define CLKID_ANAKIN_1                 285
> > +#define CLKID_ANAKIN                   286
> > +#define CLKID_ANAKIN_CLK               287
> > +#define CLKID_HDMITX_PRIF_MUX          288
> > +#define CLKID_HDMITX_PRIF_DIV          289
> > +#define CLKID_HDMITX_PRIF              290
> > +#define CLKID_HDMITX_200M_MUX          291
> > +#define CLKID_HDMITX_200M_DIV          292
> > +#define CLKID_HDMITX_200M              293
> > +#define CLKID_HDMITX_AUD_MUX           294
> > +#define CLKID_HDMITX_AUD_DIV           295
> > +#define CLKID_HDMITX_AUD               296
> > +#define CLKID_HDMIRX_2M_MUX            297
> > +#define CLKID_HDMIRX_2M_DIV            298
> > +#define CLKID_HDMIRX_2M                        299
> > +#define CLKID_HDMIRX_5M_MUX            300
> > +#define CLKID_HDMIRX_5M_DIV            301
> > +#define CLKID_HDMIRX_5M                        302
> > +#define CLKID_HDMIRX_CFG_MUX           303
> > +#define CLKID_HDMIRX_CFG_DIV           304
> > +#define CLKID_HDMIRX_CFG               305
> > +#define CLKID_HDMIRX_HDCP_MUX          306
> > +#define CLKID_HDMIRX_HDCP_DIV          307
> > +#define CLKID_HDMIRX_HDCP              308
> > +#define CLKID_HDMIRX_AUD_PLL_MUX       309
> > +#define CLKID_HDMIRX_AUD_PLL_DIV       310
> > +#define CLKID_HDMIRX_AUD_PLL           311
> > +#define CLKID_HDMIRX_ACR_MUX           312
> > +#define CLKID_HDMIRX_ACR_DIV           313
> > +#define CLKID_HDMIRX_ACR               314
> > +#define CLKID_HDMIRX_METER_MUX         315
> > +#define CLKID_HDMIRX_METER_DIV         316
> > +#define CLKID_HDMIRX_METER             317
> > +#define CLKID_DDR                      318
> > +#define CLKID_DOS                      319
> > +#define CLKID_ETHPHY                   320
> > +#define CLKID_MALI                     321
> > +#define CLKID_TS_A53                   322
> > +#define CLKID_TS_A73                   323
> > +#define CLKID_CEC                      324
> > +#define CLKID_SD_EMMC_A                        325
> > +#define CLKID_SD_EMMC_B                        326
> > +#define CLKID_SD_EMMC_C                        327
> > +#define CLKID_SMARTCARD                        328
> > +#define CLKID_ACODEC                   329
> > +#define CLKID_SPIFC                    330
> > +#define CLKID_MSR_CLK                  331
> > +#define CLKID_IR_CTRL                  332
> > +#define CLKID_AUDIO                    333
> > +#define CLKID_ETH                      334
> > +#define CLKID_UART_A                   335
> > +#define CLKID_UART_B                   336
> > +#define CLKID_UART_C                   337
> > +#define CLKID_UART_D                   338
> > +#define CLKID_UART_E                   339
> > +#define CLKID_AIFIFO                   340
> > +#define CLKID_TS_DDR                   341
> > +#define CLKID_TS_PLL                   342
> > +#define CLKID_G2D                      343
> > +#define CLKID_SPICC0                   344
> > +#define CLKID_SPICC1                   345
> > +#define CLKID_PCIE                     346
> > +#define CLKID_USB                      347
> > +#define CLKID_PCIE_PHY                 348
> > +#define CLKID_I2C_M_A                  349
> > +#define CLKID_I2C_M_B                  350
> > +#define CLKID_I2C_M_C                  351
> > +#define CLKID_I2C_M_D                  352
> > +#define CLKID_I2C_M_E                  353
> > +#define CLKID_I2C_M_F                  354
> > +#define CLKID_HDMITX_APB               355
> > +#define CLKID_I2C_S_A                  356
> > +#define CLKID_USB1_TO_DDR              357
> > +#define CLKID_AOCPU                    358
> > +#define CLKID_MMC_APB                  359
> > +#define CLKID_RSA                      360
> > +#define CLKID_AUCPU                    361
> > +#define CLKID_DSPA                     362
> > +#define CLKID_VPU_INTR                 363
> > +#define CLKID_SAR_ADC                  364
> > +#define CLKID_GIC                      365
> > +#define CLKID_PWM_AB                   366
> > +#define CLKID_PWM_CD                   367
> > +#define CLKID_PWM_EF                   368
> > +#define CLKID_PWM_GH                   369
> > +#define CLKID_PWM_AO_AB                        370
> > +#define CLKID_MIPI_DSI_A               371
> > +#define CLKID_MIPI_DSI_B               372
> > +#define CLKID_GDC                      373
> > +#define CLKID_DESWARP                  374
> > +#define CLKID_AMPIPE_NAND              375
> > +#define CLKID_AMPIPE_ETH               376
> > +#define CLKID_AM2AXI0                  377
> > +#define CLKID_AM2AXI1                  378
> > +#define CLKID_AM2AXI2                  379
> > +#define CLKID_PWM_AO_CD                        380
> > +#define CLKID_PWM_AO_EF                        381
> > +#define CLKID_PWM_AO_GH                        382
> > +#define CLKID_TS_NNA                   383
> > +#define CLKID_TS_GPU                   384
> > +#define CLKID_TS_HEVC                  385
> > +#define CLKID_DSPB                     386
> > +#define CLKID_SPICC2                   387
> > +#define CLKID_SPICC3                   388
> > +#define CLKID_SPICC4                   389
> > +#define CLKID_SPICC5                   390
> > +#define CLKID_I2C_AO_A                 391
> > +#define CLKID_I2C_AO_B                 392
> > +#define CLKID_UART_F                   393
> > +#define CLKID_MIPI_ISP_PCLK            394
> > +#define CLKID_HDMIRX_PCLK              395
> > +#define CLKID_PCLK_SYS_CPU_APB         396
> > +#define CLKID_A73PCLK_CPU_APB          397
> > +#define CLKID_TS_VPU                   398
> > +
> > +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_T7_PERIPHERALS_CLKC_H */
> > diff --git a/include/dt-bindings/clock/amlogic,t7-pll-clkc.h b/include/=
dt-bindings/clock/amlogic,t7-pll-clkc.h
> > new file mode 100644
> > index 000000000000..89ee62069772
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/amlogic,t7-pll-clkc.h
> > @@ -0,0 +1,69 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > +/*
> > + * Copyright (c) 2019 Amlogic Inc. All rights reserved.
> > + */
> > +
> > +#ifndef __T7_CLKC_H
> > +#define __T7_CLKC_H
> > +
> > +/*
> > + * CLKID index values
> > + */
> > +
> > +#define CLKID_FIXED_PLL_DCO            0
> > +#define CLKID_FIXED_PLL                        1
> > +#define CLKID_SYS_PLL_DCO              2
> > +#define CLKID_SYS_PLL                  3
> > +#define CLKID_FCLK_DIV2_DIV            4
> > +#define CLKID_FCLK_DIV2                        5
> > +#define CLKID_FCLK_DIV3_DIV            6
> > +#define CLKID_FCLK_DIV3                        7
> > +#define CLKID_FCLK_DIV4_DIV            8
> > +#define CLKID_FCLK_DIV4                        9
> > +#define CLKID_FCLK_DIV5_DIV            10
> > +#define CLKID_FCLK_DIV5                        11
> > +#define CLKID_FCLK_DIV7_DIV            12
> > +#define CLKID_FCLK_DIV7                        13
> > +#define CLKID_FCLK_DIV2P5_DIV          14
> > +#define CLKID_FCLK_DIV2P5              15
> > +#define CLKID_GP0_PLL_DCO              16
> > +#define CLKID_GP0_PLL                  17
> > +#define CLKID_GP1_PLL_DCO              18
> > +#define CLKID_GP1_PLL                  19
> > +#define CLKID_SYS1_PLL_DCO             20
> > +#define CLKID_SYS1_PLL                 21
> > +#define CLKID_MCLK_PLL_DCO             22
> > +#define CLKID_MCLK_PRE                 23
> > +#define CLKID_MCLK_PLL                 24
> > +#define CLKID_HIFI_PLL_DCO             25
> > +#define CLKID_HIFI_PLL                 26
> > +#define CLKID_PCIE_PLL_DCO             27
> > +#define CLKID_PCIE_PLL_DCO_DIV2                28
> > +#define CLKID_PCIE_PLL_OD              29
> > +#define CLKID_PCIE_PLL                 30
> > +#define CLKID_HDMI_PLL_DCO             31
> > +#define CLKID_HDMI_PLL_OD              32
> > +#define CLKID_HDMI_PLL                 33
> > +#define CLKID_MPLL_50M_DIV             34
> > +#define CLKID_MPLL_50M                 35
> > +#define CLKID_MPLL_PREDIV              36
> > +#define CLKID_MPLL0_DIV                        37
> > +#define CLKID_MPLL0                    38
> > +#define CLKID_MPLL1_DIV                        39
> > +#define CLKID_MPLL1                    40
> > +#define CLKID_MPLL2_DIV                        41
> > +#define CLKID_MPLL2                    42
> > +#define CLKID_MPLL3_DIV                        43
> > +#define CLKID_MPLL3                    44
> > +#define CLKID_PCIE_BGP                 45
> > +#define CLKID_PCIE_HCSL                        46
> > +#define CLKID_MCLK_0_SEL               47
> > +#define CLKID_MCLK_0_DIV2              48
> > +#define CLKID_MCLK_0_PRE               49
> > +#define CLKID_MCLK_0                   50
> > +#define CLKID_MCLK_1_SEL               51
> > +#define CLKID_MCLK_1_DIV2              52
> > +#define CLKID_MCLK_1_PRE               53
> > +#define CLKID_MCLK_1                   54
> > +
> > +#endif /* __T7_CLKC_H */
> > --
> > 2.44.0
> >
Hi,

I have been trying to port the MMC driver to the mainline, but this
kernel panic is occurring frequently.
It doesn't seem to be from my driver. Can anybody help?

    0.355428] meson-gx-mmc fe08a000.sd: host probe success!
[    0.355850] clk: Disabling unused clocks
[    0.356032] PM: genpd: Disabling unused power domains
[    0.356554] ALSA device list:
[    0.356894]   No soundcards found.
[    0.359563] SError Interrupt on CPU1, code 0x00000000bf000002 -- SError
[    0.359575] CPU: 1 PID: 76 Comm: kworker/1:1 Not tainted
6.8.0-09794-g261238a64e1f-dirty #38
[    0.359585] Hardware name: Khadas vim4 (DT)
[    0.359590] Workqueue: events_freezable mmc_rescan
[    0.359611] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    0.359620] pc : meson_mmc_request+0x1d0/0x624
[    0.359630] lr : __mmc_start_request+0x68/0x13c
[    0.359641] sp : ffff800082ff3b70
[    0.359644] x29: ffff800082ff3b70 x28: 0000000000000000 x27: ffff8000823=
27000
[    0.359655] x26: ffff0001011d3040 x25: 0000000000000000 x24: ffff0001000=
30405
[    0.359666] x23: ffff800082ff3d20 x22: ffff0001031b8000 x21: 00000000884=
0a800
[    0.359677] x20: 0000000000000000 x19: ffff0001031b8580 x18: 00000000000=
00020
[    0.359688] x17: 0000000000000080 x16: fffffdffc378e008 x15: 00000000000=
00000
[    0.359698] x14: ffff0001003ca280 x13: 0000000000000000 x12: ffff8000823=
29dc8
[    0.359709] x11: ffff000100cc3500 x10: 0000000000000a70 x9 : ffff800082f=
f3b70
[    0.359719] x8 : ffff0001003cacd0 x7 : ffff00021ef51d40 x6 : ffff80019d3=
c6000
[    0.359730] x5 : 0000000000000008 x4 : 0000000000500000 x3 : 00000000884=
00000
[    0.359741] x2 : 0000000000000008 x1 : ffff80008287d000 x0 : ffff8000828=
7d000
[    0.359753] Kernel panic - not syncing: Asynchronous SError Interrupt
[    0.359757] CPU: 1 PID: 76 Comm: kworker/1:1 Not tainted
6.8.0-09794-g261238a64e1f-dirty #38
[    0.359765] Hardware name: Khadas vim4 (DT)
[    0.359769] Workqueue: events_freezable mmc_rescan
[    0.359780] Call trace:
[    0.359784]  dump_backtrace+0x94/0xec
[    0.359798]  show_stack+0x18/0x24
[    0.359809]  dump_stack_lvl+0x38/0x90
[    0.359818]  dump_stack+0x18/0x24
[    0.359824]  panic+0x388/0x3c8
[    0.359834]  nmi_panic+0x48/0x94
[    0.359846]  arm64_serror_panic+0x6c/0x78
[    0.359853]  do_serror+0x3c/0x78
[    0.359860]  el1h_64_error_handler+0x30/0x48
[    0.359870]  el1h_64_error+0x64/0x68
[    0.359878]  meson_mmc_request+0x1d0/0x624
[    0.359886]  __mmc_start_request+0x68/0x13c
[    0.359897]  mmc_start_request+0x84/0xac
[    0.359906]  mmc_wait_for_req+0x70/0x100
[    0.359916]  mmc_wait_for_cmd+0x64/0x9c
[    0.359925]  mmc_send_if_cond_pcie+0x88/0x120
[    0.359936]  mmc_rescan+0x22c/0x31c
[    0.359946]  process_one_work+0x150/0x294
[    0.359957]  worker_thread+0x304/0x408
[    0.359968]  kthread+0x118/0x11c
[    0.359977]  ret_from_fork+0x10/0x20
[    0.359987] SMP: stopping secondary CPUs
[    0.360066] Kernel Offset: disabled
[    0.360068] CPU features: 0x0,00000060,d0080000,0200421b
[    0.360074] Memory Limit: none
[    0.388534] ---[ end Kernel panic - not syncing: Asynchronous
SError Interrupt ]---

