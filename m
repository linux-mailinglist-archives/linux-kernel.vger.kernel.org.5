Return-Path: <linux-kernel+bounces-128324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B7895956
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDC71F2411A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2B514AD21;
	Tue,  2 Apr 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="peQ26tH4"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD52E40D;
	Tue,  2 Apr 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074279; cv=none; b=ChALJ1694VBJiLqPkNXTkdyZovG9bmbPH2TQqEAkQdeA4GpYgpPGL3hXRHWuVm9ntBTQ4D2SfUEo1jM6XhSDSAYUPS/m3/Z/95rdWhonfxyfeThhPlqWay4NlsOZhcL3xuT2JuJKr+U95gnnfj8pmbiOBCZUh2ySNnU4eRUj0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074279; c=relaxed/simple;
	bh=gahXxeGESnokTM2+tqb+7F4QbyAKMUVBm+abqieLgnU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUPduZGKo/cvTyir6NB8NACS8LXkkkoWRBPIt/LA8T0JoSJQUyM1Yav0yWmjA08wGRibcpkPc/E6jjjm4qeim9ClazDDBZEDBbg1Owi0BYaKyzgXfwD4smpxGk+i/RqrP2g/uZqHMy+qNFEXSmEoY36ZC6cw90xOetsJYX2Q+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=peQ26tH4; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A8E03100008;
	Tue,  2 Apr 2024 19:11:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A8E03100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712074271;
	bh=YdyVIhUO0t2h9Ns2CKOTU3sGOrHS0wxMPkmDQ04CQkQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=peQ26tH4BDIR3EKPgvzja4jmcct8PyglkihG7371MdwkLozMFDT+Y44CP9Pjsvo3t
	 vSDh8MCBaaO9tFKJ/VUBow9cJFCRfaScXlaOqCbbpvvP10fWo5ppdbNFHTKorRt3oV
	 HuIQ6F8My6BABhecW1cZ+hiUQQ2c0PEchZqbEhRQKGgqLuDvFeG3pN+kHO3Ji4y0Bn
	 YMsxFiwR8tUNwP/ScQt9OvqR9AIu3t4WSgnLeWDzyfvv5Q5pAnNLq1Jgw55nXdgVkL
	 a8pcho9mho3nZJgc4PTFM281YxJWy18ezuJ25y0d1VZuGi8CtLQruCB4v97bGhL4//
	 OJ3Ey5ybkWUfA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  2 Apr 2024 19:11:11 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Apr
 2024 19:11:11 +0300
Date: Tue, 2 Apr 2024 19:11:10 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <kernel@salutedevices.com>,
	<rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 6/6] clk: meson: a1: add Amlogic A1 CPU clock
 controller driver
Message-ID: <20240402161110.v7t72s6t7m3bzifi@CAB-WSD-L081021>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-7-ddrokosov@salutedevices.com>
 <1jv850hyvm.fsf@starbuckisacylon.baylibre.com>
 <20240402110538.ayectwxnhlu6o65d@CAB-WSD-L081021>
 <1jr0fnj11b.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jr0fnj11b.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184540 [Apr 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;elixir.bootlin.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/02 13:04:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/02 14:35:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/02 07:07:00 #24571916
X-KSMG-AntiVirus-Status: Clean, skipped

On Tue, Apr 02, 2024 at 04:11:12PM +0200, Jerome Brunet wrote:
> 
> On Tue 02 Apr 2024 at 14:05, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > Hello Jerome,
> >
> > On Tue, Apr 02, 2024 at 11:35:49AM +0200, Jerome Brunet wrote:
> >> 
> >> On Fri 29 Mar 2024 at 23:58, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> >> 
> >> > The CPU clock controller plays a general role in the Amlogic A1 SoC
> >> > family by generating CPU clocks. As an APB slave module, it offers the
> >> > capability to inherit the CPU clock from two sources: the internal fixed
> >> > clock known as 'cpu fixed clock' and the external input provided by the
> >> > A1 PLL clock controller, referred to as 'syspll'.
> >> >
> >> > It is important for the driver to handle cpu_clk rate switching
> >> > effectively by transitioning to the CPU fixed clock to avoid any
> >> > potential execution freezes.
> >> >
> >> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> >> > ---
> >> >  drivers/clk/meson/Kconfig  |  10 ++
> >> >  drivers/clk/meson/Makefile |   1 +
> >> >  drivers/clk/meson/a1-cpu.c | 324 +++++++++++++++++++++++++++++++++++++
> >> >  drivers/clk/meson/a1-cpu.h |  16 ++
> >> >  4 files changed, 351 insertions(+)
> >> >  create mode 100644 drivers/clk/meson/a1-cpu.c
> >> >  create mode 100644 drivers/clk/meson/a1-cpu.h
> >> >
> >> > diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> >> > index 80c4a18c83d2..148d4495eee3 100644
> >> > --- a/drivers/clk/meson/Kconfig
> >> > +++ b/drivers/clk/meson/Kconfig
> >> > @@ -111,6 +111,16 @@ config COMMON_CLK_AXG_AUDIO
> >> >  	  Support for the audio clock controller on AmLogic A113D devices,
> >> >  	  aka axg, Say Y if you want audio subsystem to work.
> >> >  
> >> > +config COMMON_CLK_A1_CPU
> >> > +	tristate "Amlogic A1 SoC CPU controller support"
> >> > +	depends on ARM64
> >> > +	select COMMON_CLK_MESON_REGMAP
> >> > +	select COMMON_CLK_MESON_CLKC_UTILS
> >> > +	help
> >> > +	  Support for the CPU clock controller on Amlogic A113L based
> >> > +	  device, A1 SoC Family. Say Y if you want A1 CPU clock controller
> >> > +	  to work.
> >> > +
> >> >  config COMMON_CLK_A1_PLL
> >> >  	tristate "Amlogic A1 SoC PLL controller support"
> >> >  	depends on ARM64
> >> > diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> >> > index 4968fc7ad555..2a06eb0303d6 100644
> >> > --- a/drivers/clk/meson/Makefile
> >> > +++ b/drivers/clk/meson/Makefile
> >> > @@ -18,6 +18,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_AUDIO_RSTC) += meson-audio-rstc.o
> >> >  
> >> >  obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
> >> >  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
> >> > +obj-$(CONFIG_COMMON_CLK_A1_CPU) += a1-cpu.o
> >> >  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
> >> >  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
> >> >  obj-$(CONFIG_COMMON_CLK_A1_AUDIO) += a1-audio.o
> >> > diff --git a/drivers/clk/meson/a1-cpu.c b/drivers/clk/meson/a1-cpu.c
> >> > new file mode 100644
> >> > index 000000000000..5f5d8ae112e5
> >> > --- /dev/null
> >> > +++ b/drivers/clk/meson/a1-cpu.c
> >> > @@ -0,0 +1,324 @@
> >> > +// SPDX-License-Identifier: GPL-2.0+
> >> > +/*
> >> > + * Amlogic A1 SoC family CPU Clock Controller driver.
> >> > + *
> >> > + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> >> > + * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
> >> > + */
> >> > +
> >> > +#include <linux/clk.h>
> >> > +#include <linux/clk-provider.h>
> >> > +#include <linux/mod_devicetable.h>
> >> > +#include <linux/platform_device.h>
> >> > +#include "a1-cpu.h"
> >> > +#include "clk-regmap.h"
> >> > +#include "meson-clkc-utils.h"
> >> > +
> >> > +#include <dt-bindings/clock/amlogic,a1-cpu-clkc.h>
> >> > +
> >> > +static u32 cpu_fsource_sel_table[] = { 0, 1, 2 };
> >> > +static const struct clk_parent_data cpu_fsource_sel_parents[] = {
> >> > +	{ .fw_name = "xtal" },
> >> > +	{ .fw_name = "fclk_div2" },
> >> > +	{ .fw_name = "fclk_div3" },
> >> > +};
> >> > +
> >> > +static struct clk_regmap cpu_fsource_sel0 = {
> >> > +	.data = &(struct clk_regmap_mux_data) {
> >> > +		.offset = CPUCTRL_CLK_CTRL0,
> >> > +		.mask = 0x3,
> >> > +		.shift = 0,
> >> > +		.table = cpu_fsource_sel_table,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "cpu_fsource_sel0",
> >> > +		.ops = &clk_regmap_mux_ops,
> >> > +		.parent_data = cpu_fsource_sel_parents,
> >> > +		.num_parents = ARRAY_SIZE(cpu_fsource_sel_parents),
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap cpu_fsource_div0 = {
> >> > +	.data = &(struct clk_regmap_div_data) {
> >> > +		.offset = CPUCTRL_CLK_CTRL0,
> >> > +		.shift = 4,
> >> > +		.width = 6,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "cpu_fsource_div0",
> >> > +		.ops = &clk_regmap_divider_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&cpu_fsource_sel0.hw
> >> > +		},
> >> > +		.num_parents = 1,
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap cpu_fsel0 = {
> >> > +	.data = &(struct clk_regmap_mux_data) {
> >> > +		.offset = CPUCTRL_CLK_CTRL0,
> >> > +		.mask = 0x1,
> >> > +		.shift = 2,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "cpu_fsel0",
> >> > +		.ops = &clk_regmap_mux_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&cpu_fsource_sel0.hw,
> >> > +			&cpu_fsource_div0.hw,
> >> > +		},
> >> > +		.num_parents = 2,
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap cpu_fsource_sel1 = {
> >> > +	.data = &(struct clk_regmap_mux_data) {
> >> > +		.offset = CPUCTRL_CLK_CTRL0,
> >> > +		.mask = 0x3,
> >> > +		.shift = 16,
> >> > +		.table = cpu_fsource_sel_table,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "cpu_fsource_sel1",
> >> > +		.ops = &clk_regmap_mux_ops,
> >> > +		.parent_data = cpu_fsource_sel_parents,
> >> > +		.num_parents = ARRAY_SIZE(cpu_fsource_sel_parents),
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap cpu_fsource_div1 = {
> >> > +	.data = &(struct clk_regmap_div_data) {
> >> > +		.offset = CPUCTRL_CLK_CTRL0,
> >> > +		.shift = 20,
> >> > +		.width = 6,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "cpu_fsource_div1",
> >> > +		.ops = &clk_regmap_divider_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&cpu_fsource_sel1.hw
> >> > +		},
> >> > +		.num_parents = 1,
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap cpu_fsel1 = {
> >> > +	.data = &(struct clk_regmap_mux_data) {
> >> > +		.offset = CPUCTRL_CLK_CTRL0,
> >> > +		.mask = 0x1,
> >> > +		.shift = 18,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "cpu_fsel1",
> >> > +		.ops = &clk_regmap_mux_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&cpu_fsource_sel1.hw,
> >> > +			&cpu_fsource_div1.hw,
> >> > +		},
> >> > +		.num_parents = 2,
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap cpu_fclk = {
> >> > +	.data = &(struct clk_regmap_mux_data) {
> >> > +		.offset = CPUCTRL_CLK_CTRL0,
> >> > +		.mask = 0x1,
> >> > +		.shift = 10,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "cpu_fclk",
> >> > +		.ops = &clk_regmap_mux_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&cpu_fsel0.hw,
> >> > +			&cpu_fsel1.hw,
> >> > +		},
> >> > +		.num_parents = 2,
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap cpu_clk = {
> >> > +	.data = &(struct clk_regmap_mux_data) {
> >> > +		.offset = CPUCTRL_CLK_CTRL0,
> >> > +		.mask = 0x1,
> >> > +		.shift = 11,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "cpu_clk",
> >> > +		.ops = &clk_regmap_mux_ops,
> >> > +		.parent_data = (const struct clk_parent_data []) {
> >> > +			{ .hw = &cpu_fclk.hw },
> >> > +			{ .fw_name = "sys_pll", },
> >> > +		},
> >> > +		.num_parents = 2,
> >> > +		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> >> > +	},
> >> > +};
> >> > +
> >> > +/* Array of all clocks registered by this provider */
> >> > +static struct clk_hw *a1_cpu_hw_clks[] = {
> >> > +	[CLKID_CPU_FSOURCE_SEL0]	= &cpu_fsource_sel0.hw,
> >> > +	[CLKID_CPU_FSOURCE_DIV0]	= &cpu_fsource_div0.hw,
> >> > +	[CLKID_CPU_FSEL0]		= &cpu_fsel0.hw,
> >> > +	[CLKID_CPU_FSOURCE_SEL1]	= &cpu_fsource_sel1.hw,
> >> > +	[CLKID_CPU_FSOURCE_DIV1]	= &cpu_fsource_div1.hw,
> >> > +	[CLKID_CPU_FSEL1]		= &cpu_fsel1.hw,
> >> > +	[CLKID_CPU_FCLK]		= &cpu_fclk.hw,
> >> > +	[CLKID_CPU_CLK]			= &cpu_clk.hw,
> >> > +};
> >> > +
> >> > +static struct clk_regmap *const a1_cpu_regmaps[] = {
> >> > +	&cpu_fsource_sel0,
> >> > +	&cpu_fsource_div0,
> >> > +	&cpu_fsel0,
> >> > +	&cpu_fsource_sel1,
> >> > +	&cpu_fsource_div1,
> >> > +	&cpu_fsel1,
> >> > +	&cpu_fclk,
> >> > +	&cpu_clk,
> >> > +};
> >> > +
> >> > +static struct regmap_config a1_cpu_regmap_cfg = {
> >> > +	.reg_bits   = 32,
> >> > +	.val_bits   = 32,
> >> > +	.reg_stride = 4,
> >> > +	.max_register = CPUCTRL_CLK_CTRL1,
> >> > +};
> >> > +
> >> > +static struct meson_clk_hw_data a1_cpu_clks = {
> >> > +	.hws = a1_cpu_hw_clks,
> >> > +	.num = ARRAY_SIZE(a1_cpu_hw_clks),
> >> > +};
> >> > +
> >> > +struct a1_cpu_clk_nb_data {
> >> > +	const struct clk_ops *mux_ops;
> >> 
> >> That's fishy ...
> >> 
> >> > +	struct clk_hw *cpu_clk;
> >> > +	struct notifier_block nb;
> >> > +	u8 parent;
> >> > +};
> >> > +
> >> > +#define MESON_A1_CPU_CLK_GET_PARENT(nbd) \
> >> > +	((nbd)->mux_ops->get_parent((nbd)->cpu_clk))
> >> > +#define MESON_A1_CPU_CLK_SET_PARENT(nbd, index) \
> >> > +	((nbd)->mux_ops->set_parent((nbd)->cpu_clk, index))
> >> 
> >> ... Directly going for the mux ops ??!?? No way !
> >> 
> >> We have a framework to handle the clocks, the whole point is to use it,
> >> not bypass it ! 
> >> 
> >
> > I suppose you understand my approach, which is quite similar to what is
> > happening in the Mediatek driver:
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/clk/mediatek/clk-mux.c#L295
> >
> > Initially, I attempted to set the parent using the clk_set_parent() API.
> > However, I encountered a problem with recursive calling of the
> > notifier_block. This issue arises because the parent triggers
> > notifications for its children, leading to repeated calls to the
> > notifier_block.
> >
> > I find it puzzling why I cannot call an internal function or callback
> > within the internal driver context. After all, the notifier block is
> > just a part of the set_rate() flow. From a global Clock Control
> > Framework perspective, the context should not change.
> 
> I don't care what MTK is doing TBH. Forcefully calling ops on a clock,
> hoping they are going to match with the clock type is wrong.
> 
> There is a clk_hw API. Please it.
> 

Yes, if sys_pll has a notifier_block instead of cpu_clk, there will be
no problem with the clk_hw API.

I will rework that point.

> >
> >> > +
> >> > +static int meson_a1_cpu_clk_notifier_cb(struct notifier_block *nb,
> >> > +					unsigned long event, void *data)
> >> > +{
> >> > +	struct a1_cpu_clk_nb_data *nbd;
> >> > +	int ret = 0;
> >> > +
> >> > +	nbd = container_of(nb, struct a1_cpu_clk_nb_data, nb);
> >> > +
> >> > +	switch (event) {
> >> > +	case PRE_RATE_CHANGE:
> >> > +		nbd->parent = MESON_A1_CPU_CLK_GET_PARENT(nbd);
> >> > +		/* Fallback to the CPU fixed clock */
> >> > +		ret = MESON_A1_CPU_CLK_SET_PARENT(nbd, 0);
> >> > +		/* Wait for clock propagation */
> >> > +		udelay(100);
> >> > +		break;
> >> > +
> >> > +	case POST_RATE_CHANGE:
> >> > +	case ABORT_RATE_CHANGE:
> >> > +		/* Back to the original parent clock */
> >> > +		ret = MESON_A1_CPU_CLK_SET_PARENT(nbd, nbd->parent);
> >> > +		/* Wait for clock propagation */
> >> > +		udelay(100);
> >> > +		break;
> >> > +
> >> > +	default:
> >> > +		pr_warn("Unknown event %lu for %s notifier block\n",
> >> > +			event, clk_hw_get_name(nbd->cpu_clk));
> >> > +		break;
> >> > +	}
> >> > +
> >> > +	return notifier_from_errno(ret);
> >> > +}
> >> > +
> >> > +static struct a1_cpu_clk_nb_data a1_cpu_clk_nb_data = {
> >> > +	.mux_ops = &clk_regmap_mux_ops,
> >> > +	.cpu_clk = &cpu_clk.hw,
> >> > +	.nb.notifier_call = meson_a1_cpu_clk_notifier_cb,
> >> > +};
> >> > +
> >> > +static int meson_a1_dvfs_setup(struct platform_device *pdev)
> >> > +{
> >> > +	struct device *dev = &pdev->dev;
> >> > +	struct clk *notifier_clk;
> >> > +	int ret;
> >> > +
> >> > +	/* Setup clock notifier for cpu_clk */
> >> > +	notifier_clk = devm_clk_hw_get_clk(dev, &cpu_clk.hw, "dvfs");
> >> > +	if (IS_ERR(notifier_clk))
> >> > +		return dev_err_probe(dev, PTR_ERR(notifier_clk),
> >> > +				     "can't get cpu_clk as notifier clock\n");
> >> > +
> >> > +	ret = devm_clk_notifier_register(dev, notifier_clk,
> >> > +					 &a1_cpu_clk_nb_data.nb);
> >> > +	if (ret)
> >> > +		return dev_err_probe(dev, ret,
> >> > +				     "can't register cpu_clk notifier\n");
> >> > +
> >> > +	return ret;
> >> > +}
> >> > +
> >> > +static int meson_a1_cpu_probe(struct platform_device *pdev)
> >> > +{
> >> > +	struct device *dev = &pdev->dev;
> >> > +	void __iomem *base;
> >> > +	struct regmap *map;
> >> > +	int clkid, i, err;
> >> > +
> >> > +	base = devm_platform_ioremap_resource(pdev, 0);
> >> > +	if (IS_ERR(base))
> >> > +		return dev_err_probe(dev, PTR_ERR(base),
> >> > +				     "can't ioremap resource\n");
> >> > +
> >> > +	map = devm_regmap_init_mmio(dev, base, &a1_cpu_regmap_cfg);
> >> > +	if (IS_ERR(map))
> >> > +		return dev_err_probe(dev, PTR_ERR(map),
> >> > +				     "can't init regmap mmio region\n");
> >> > +
> >> > +	/* Populate regmap for the regmap backed clocks */
> >> > +	for (i = 0; i < ARRAY_SIZE(a1_cpu_regmaps); i++)
> >> > +		a1_cpu_regmaps[i]->map = map;
> >> > +
> >> > +	for (clkid = 0; clkid < a1_cpu_clks.num; clkid++) {
> >> > +		err = devm_clk_hw_register(dev, a1_cpu_clks.hws[clkid]);
> >> > +		if (err)
> >> > +			return dev_err_probe(dev, err,
> >> > +					     "clock[%d] registration failed\n",
> >> > +					     clkid);
> >> > +	}
> >> > +
> >> > +	err = devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, &a1_cpu_clks);
> >> > +	if (err)
> >> > +		return dev_err_probe(dev, err, "can't add clk hw provider\n");
> >> 
> >> I wonder if there is a window of opportunity to poke the syspll without
> >> your notifier here. That being said, the situation would be similar on g12.
> >> 
> >
> > Yes, I have taken into account what you did in the G12A CPU clock
> > relations. My thoughts were that it might not be applicable for the A1
> > case. This is because the sys_pll should be located in a different
> > driver from a logical perspective. Consequently, we cannot configure the
> > sys_pll notifier block to manage the cpu_clk from a different driver.
> > However, if I were to move the sys_pll clock object to the A1 CPU clock
> > controller, I believe the g12a sys_pll notifier approach would work.
> >
> 
> I fail to see the connection between the number of device and the
> approach you took.
> 
> 
> >> > +
> >> > +	return meson_a1_dvfs_setup(pdev);
> >> 
> >> 
> >> 
> >> > +}
> >> > +
> >> > +static const struct of_device_id a1_cpu_clkc_match_table[] = {
> >> > +	{ .compatible = "amlogic,a1-cpu-clkc", },
> >> > +	{}
> >> > +};
> >> > +MODULE_DEVICE_TABLE(of, a1_cpu_clkc_match_table);
> >> > +
> >> > +static struct platform_driver a1_cpu_clkc_driver = {
> >> > +	.probe = meson_a1_cpu_probe,
> >> > +	.driver = {
> >> > +		.name = "a1-cpu-clkc",
> >> > +		.of_match_table = a1_cpu_clkc_match_table,
> >> > +	},
> >> > +};
> >> > +
> >> > +module_platform_driver(a1_cpu_clkc_driver);
> >> > +MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@salutedevices.com>");
> >> > +MODULE_LICENSE("GPL");
> >> > diff --git a/drivers/clk/meson/a1-cpu.h b/drivers/clk/meson/a1-cpu.h
> >> > new file mode 100644
> >> > index 000000000000..e9af4117e26f
> >> > --- /dev/null
> >> > +++ b/drivers/clk/meson/a1-cpu.h
> >> 
> >> There is not point putting the definition here in a header
> >> These are clearly not going to be shared with another driver.
> >> 
> >> Please drop this file
> >> 
> >
> > The same approach was applied to the Peripherals and PLL A1 drivers.
> > Honestly, I am not a fan of having different file organization within a
> > single logical code folder.
> >
> > Please refer to:
> >
> > drivers/clk/meson/a1-peripherals.h
> > drivers/clk/meson/a1-pll.h
> 
> I understand. There was a time where it made sense, some definition
> could have been shared back then. This is no longer the case and it
> would probably welcome a rework.
> 
> ... and again, just pointing to another code does really invalidate my
>  point.
> 
> >
> >> > @@ -0,0 +1,16 @@
> >> > +/* SPDX-License-Identifier: GPL-2.0+ */
> >> > +/*
> >> > + * Amlogic A1 CPU Clock Controller internals
> >> > + *
> >> > + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> >> > + * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
> >> > + */
> >> > +
> >> > +#ifndef __A1_CPU_H
> >> > +#define __A1_CPU_H
> >> > +
> >> > +/* cpu clock controller register offset */
> >> > +#define CPUCTRL_CLK_CTRL0	0x80
> >> > +#define CPUCTRL_CLK_CTRL1	0x84
> >> 
> >> You are claiming the registers from 0x00 to 0x84 (included), but only
> >> using these 2 registers ? What is the rest ? Are you sure there is only
> >> clocks in there ?
> >> 
> >
> > Yes, unfortunately, the register map for this IP is not described in the
> > A1 Datasheet. The only available information about it can be found in
> > the vendor clock driver, which provides details for only two registers
> > used to configure the CPU clock.
> >
> > From vendor kernel dtsi:
> >
> > 	clkc: clock-controller {
> > 		compatible = "amlogic,a1-clkc";
> > 		#clock-cells = <1>;
> > 		reg = <0x0 0xfe000800 0x0 0x100>,
> > 		      <0x0 0xfe007c00 0x0 0x21c>,
> > 		      <0x0 0xfd000000 0x0 0x88>; <==== CPU clock regmap
> > 		reg-names = "basic", "pll",
> > 			    "cpu_clk";
> > 		clocks = <&xtal>;
> > 		clock-names = "core";
> > 		status = "okay";
> > 	};
> >
> > From vendor clkc driver:
> >
> > 	/*
> > 	 * CPU clok register offset
> > 	 * APB_BASE:  APB1_BASE_ADDR = 0xfd000000
> > 	 */
> >
> > 	#define CPUCTRL_CLK_CTRL0		0x80
> > 	#define CPUCTRL_CLK_CTRL1		0x84
> 
> If you had clock in 0x0 and 0x80, then I would agree claiming 0x0-0x88
> is reasonable, even if you don't really know what is in between. It
> would be a fair assumption.
> 
> It is not the case here.
> For all we know it could resets, power domains, etc ...
> 

However, we do not have any information indicating that the gap from
0x00-0x80 contains additional registers. It is possible that there are
internal registers, but they are not mentioned in the vendor datasheet
or driver. Therefore, in this case, I personally prefer to rely on the
vendor mapping.

-- 
Thank you,
Dmitry

