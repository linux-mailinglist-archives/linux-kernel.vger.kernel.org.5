Return-Path: <linux-kernel+bounces-142132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B038A27EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619001F21B86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59BF4C624;
	Fri, 12 Apr 2024 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH3Q5Lnc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87E2C683;
	Fri, 12 Apr 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906708; cv=none; b=Rdb+wGu6URIHJw/xwdl9HtsS2o4k+LwNJG/9X0AQrkbwLjosb2KWGVy4J3RW0ImNtix3O4GsTwr77r1NKXONztQ95dGIG8rpqfTJ8s83rb8mi7QubYnWaz0ElzRpL4z0XxiJvejE4QxguPsssBAacbI8mz0v7CZl1Lhwox6n838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906708; c=relaxed/simple;
	bh=1kX9kfzHzhrxx38AopTffWG2kYPAhrnomHNnphARmp8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lOb2DEgG6W2JLqI9WSEVl6DBNPg7ow1bxp0MK72sdUkgDpcldbaHSP3GLInHMrwfIDmsNrVVLPf27cxy0RfBsVjjR/jVZLOBu4JHsG80LIKqfkkVMLyQR9OBvqF5e9Ga9Ud4fNdUXC3s5eFYk0QiJkoLiTA7siWjW69zLzd5q8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH3Q5Lnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED614C113CC;
	Fri, 12 Apr 2024 07:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712906708;
	bh=1kX9kfzHzhrxx38AopTffWG2kYPAhrnomHNnphARmp8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=PH3Q5Lnc1/dyrDs7XafAWFsC4e9SKfVWIecn+kI7jaBT27bEfiFtdA0uHmPVH5J8c
	 9zHCfa84p3D1trAOIsnNiRi2IrN9qyCN+jtVbqwdjkKfMWppvw0lEVhdLmTapBNjFE
	 rvDW8Bh6PFK/legh5nAd4uYCYoU/zH0xqH3HT8hdEdXDgTxJIp+nOl1ztSTmQUfUCn
	 gjTKu+ceV1jgF5L3ssNdSDwGG5izOj/yNTE8nZFJXsucVcMxw8IX87zJS9LHlOEd6+
	 CcuDo4gtH0wPsrQvNqfxxjCc90PoSfLzkdcB+jPGcf8kxMFQ2VAlTuIr8MBIofSurI
	 k13csdn57iP2g==
Message-ID: <9be144291cda6d9714252c9cd83649c2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240401-wpcm-clk-v11-3-379472961244@gmx.net>
References: <20240401-wpcm-clk-v11-0-379472961244@gmx.net> <20240401-wpcm-clk-v11-3-379472961244@gmx.net>
Subject: Re: [PATCH v11 3/4] clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Date: Fri, 12 Apr 2024 00:25:05 -0700
User-Agent: alot/0.10

Quoting Jonathan Neusch=C3=A4fer (2024-04-01 07:06:32)
> This driver implements the following features w.r.t. the clock and reset
> controller in the WPCM450 SoC:
>=20
> - It calculates the rates for all clocks managed by the clock controller
> - It leaves the clock tree mostly unchanged, except that it enables/
>   disables clock gates based on usage.
> - It exposes the reset lines managed by the controller using the
>   Generic Reset Controller subsystem
>=20
> NOTE: If the driver and the corresponding devicetree node are present,
>       the driver will disable "unused" clocks. This is problem until
>       the clock relations are properly declared in the devicetree (in a
>       later patch). Until then, the clk_ignore_unused kernel parameter
>       can be used as a workaround.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>=20
> I have considered converting this driver to a platform driver instead of
> using CLK_OF_DECLARE, because platform drivers are generally the way
> forward. However, the timer-npcm7xx driver used on the same platform
> requires is initialized with TIMER_OF_DECLARE and thus requires the
> clocks to be available earlier than a platform driver can provide them.

In that case you can use CLK_OF_DECLARE_DRIVER(), register the clks
needed for the timer driver to probe, and then put the rest of the clk
registration in a normal platform driver.

> diff --git a/drivers/clk/nuvoton/clk-wpcm450.c b/drivers/clk/nuvoton/clk-=
wpcm450.c
> new file mode 100644
> index 00000000000000..9100c4b8a56483
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-wpcm450.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Nuvoton WPCM450 clock and reset controller driver.
> + *
> + * Copyright (C) 2022 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Isn't KBUILD_MODNAME an option already for dynamic debug?

> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/reset-controller.h>
> +#include <linux/reset/reset-simple.h>
> +#include <linux/slab.h>
> +
[...]
> +
> +static const struct clk_parent_data default_parents[] =3D {
> +       { .name =3D "pll0" },
> +       { .name =3D "pll1" },
> +       { .name =3D "ref" },
> +};
> +
> +static const struct clk_parent_data huart_parents[] =3D {
> +       { .fw_name =3D "ref" },
> +       { .name =3D "refdiv2" },

Please remove all .name elements and use indexes or direct pointers.

> +};
> +
> +static const struct wpcm450_clksel_data clksel_data[] =3D {
> +       { "cpusel", default_parents, ARRAY_SIZE(default_parents),
> +               parent_table, 0, 2, -1, CLK_IS_CRITICAL },
> +       { "clkout", default_parents, ARRAY_SIZE(default_parents),
> +               parent_table, 2, 2, -1, 0 },
> +       { "usbphy", default_parents, ARRAY_SIZE(default_parents),
> +               parent_table, 6, 2, -1, 0 },
> +       { "uartsel", default_parents, ARRAY_SIZE(default_parents),
> +               parent_table, 8, 2, WPCM450_CLK_USBPHY, 0 },
> +       { "huartsel", huart_parents, ARRAY_SIZE(huart_parents),
> +               parent_table, 10, 1, -1, 0 },
> +};
> +
> +static const struct clk_div_table div_fixed2[] =3D {
> +       { .val =3D 0, .div =3D 2 },
> +       { }
> +};
> +
> +struct wpcm450_clkdiv_data {
> +       const char *name;
> +       struct clk_parent_data parent;
> +       int div_flags;
> +       const struct clk_div_table *table;
> +       int shift;
> +       int width;
> +       unsigned long flags;
> +};
> +
> +static struct wpcm450_clkdiv_data clkdiv_data_early[] =3D {
> +       { "refdiv2", { .name =3D "ref" }, 0, div_fixed2, 0, 0 },
> +};
> +
> +static const struct wpcm450_clkdiv_data clkdiv_data[] =3D {
> +       { "cpu", { .name =3D "cpusel" }, 0, div_fixed2, 0, 0, CLK_IS_CRIT=
ICAL },
> +       { "adcdiv", { .name =3D "ref" }, CLK_DIVIDER_POWER_OF_TWO, NULL, =
28, 2, 0 },
> +       { "apb", { .name =3D "ahb" }, CLK_DIVIDER_POWER_OF_TWO, NULL, 26,=
 2, 0 },
> +       { "ahb", { .name =3D "cpu" }, CLK_DIVIDER_POWER_OF_TWO, NULL, 24,=
 2, 0 },
> +       { "uart", { .name =3D "uartsel" }, 0, NULL, 16, 4, 0 },
> +       { "ahb3", { .name =3D "ahb" }, CLK_DIVIDER_POWER_OF_TWO, NULL, 8,=
 2, 0 },
> +};
> +
> +struct wpcm450_clken_data {
> +       const char *name;
> +       struct clk_parent_data parent;
> +       int bitnum;
> +       unsigned long flags;
> +};
> +
> +static const struct wpcm450_clken_data clken_data[] =3D {
> +       { "fiu", { .name =3D "ahb3" }, WPCM450_CLK_FIU, 0 },

This actually is  { .index =3D 0, .name =3D "ahb3" } and that is a bad
combination. struct clk_parent_data should only have .name as a fallback
when there's an old binding out there that doesn't have the 'clocks'
property for the clk provider node. There shouldn't be any .name
property because this is new code and a new binding.

> +       { "xbus", { .name =3D "ahb3" }, WPCM450_CLK_XBUS, 0 },
> +       { "kcs", { .name =3D "apb" }, WPCM450_CLK_KCS, 0 },
> +       { "shm", { .name =3D "ahb3" }, WPCM450_CLK_SHM, 0 },
> +       { "usb1", { .name =3D "ahb" }, WPCM450_CLK_USB1, 0 },
> +       { "emc0", { .name =3D "ahb" }, WPCM450_CLK_EMC0, 0 },
> +       { "emc1", { .name =3D "ahb" }, WPCM450_CLK_EMC1, 0 },
> +       { "usb0", { .name =3D "ahb" }, WPCM450_CLK_USB0, 0 },
> +       { "peci", { .name =3D "apb" }, WPCM450_CLK_PECI, 0 },
> +       { "aes", { .name =3D "apb" }, WPCM450_CLK_AES, 0 },
> +       { "uart0", { .name =3D "uart" }, WPCM450_CLK_UART0, 0 },
> +       { "uart1", { .name =3D "uart" }, WPCM450_CLK_UART1, 0 },
> +       { "smb2", { .name =3D "apb" }, WPCM450_CLK_SMB2, 0 },
> +       { "smb3", { .name =3D "apb" }, WPCM450_CLK_SMB3, 0 },
> +       { "smb4", { .name =3D "apb" }, WPCM450_CLK_SMB4, 0 },
> +       { "smb5", { .name =3D "apb" }, WPCM450_CLK_SMB5, 0 },
> +       { "huart", { .name =3D "huartsel" }, WPCM450_CLK_HUART, 0 },
> +       { "pwm", { .name =3D "apb" }, WPCM450_CLK_PWM, 0 },
> +       { "timer0", { .name =3D "refdiv2" }, WPCM450_CLK_TIMER0, 0 },
> +       { "timer1", { .name =3D "refdiv2" }, WPCM450_CLK_TIMER1, 0 },
> +       { "timer2", { .name =3D "refdiv2" }, WPCM450_CLK_TIMER2, 0 },
> +       { "timer3", { .name =3D "refdiv2" }, WPCM450_CLK_TIMER3, 0 },
> +       { "timer4", { .name =3D "refdiv2" }, WPCM450_CLK_TIMER4, 0 },
> +       { "mft0", { .name =3D "apb" }, WPCM450_CLK_MFT0, 0 },
> +       { "mft1", { .name =3D "apb" }, WPCM450_CLK_MFT1, 0 },
> +       { "wdt", { .name =3D "refdiv2" }, WPCM450_CLK_WDT, 0 },
> +       { "adc", { .name =3D "adcdiv" }, WPCM450_CLK_ADC, 0 },
> +       { "sdio", { .name =3D "ahb" }, WPCM450_CLK_SDIO, 0 },
> +       { "sspi", { .name =3D "apb" }, WPCM450_CLK_SSPI, 0 },
> +       { "smb0", { .name =3D "apb" }, WPCM450_CLK_SMB0, 0 },
> +       { "smb1", { .name =3D "apb" }, WPCM450_CLK_SMB1, 0 },
> +};
> +
> +static DEFINE_SPINLOCK(wpcm450_clk_lock);
> +
> +/*
> + * NOTE: Error handling is very rudimentary here. If the clock driver in=
itial-
> + * ization fails, the system is probably in bigger trouble than what is =
caused

Don't break words across lines with hyphens.

> + * by a few leaked resources.
> + */
> +
> +static void __init wpcm450_clk_init(struct device_node *np)
> +{
> +       struct clk_hw_onecell_data *clk_data;
> +       static struct clk_hw **hws;
> +       static struct clk_hw *hw;
> +       void __iomem *clk_base;
> +       int i, ret;
> +       struct reset_simple_data *reset;
> +
> +       clk_base =3D of_iomap(np, 0);
> +       if (!clk_base) {
> +               pr_err("%pOFP: failed to map registers\n", np);
> +               of_node_put(np);
> +               return;
> +       }
> +       of_node_put(np);

The 'np' is used later when registering PLLs. You can only put the node
after it's no longer used. Also, you never got the node with
of_node_get(), so putting it here actually causes an underflow on the
refcount. Just remove all the get/puts instead.

> +
> +       clk_data =3D kzalloc(struct_size(clk_data, hws, WPCM450_NUM_CLKS)=
, GFP_KERNEL);
> +       if (!clk_data)
> +               return;
> +
> +       clk_data->num =3D WPCM450_NUM_CLKS;
[...]
> +       /* Reset controller */
> +       reset =3D kzalloc(sizeof(*reset), GFP_KERNEL);
> +       if (!reset)
> +               return;
> +       reset->rcdev.owner =3D THIS_MODULE;
> +       reset->rcdev.nr_resets =3D WPCM450_NUM_RESETS;
> +       reset->rcdev.ops =3D &reset_simple_ops;
> +       reset->rcdev.of_node =3D np;
> +       reset->membase =3D clk_base + REG_IPSRST;
> +       ret =3D reset_controller_register(&reset->rcdev);
> +       if (ret)
> +               pr_err("Failed to register reset controller: %pe\n", ERR_=
PTR(ret));

It would be nicer to register this device as an auxiliary device with a
single API call and then have all the resets exist in that file
instead of this file. The driver would be put in drivers/reset/ as well.

> +
> +       of_node_put(np);

Drop this of_node_put()

