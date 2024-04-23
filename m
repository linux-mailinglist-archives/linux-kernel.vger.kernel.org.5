Return-Path: <linux-kernel+bounces-154366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40E8ADB46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35840B22275
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA777E574;
	Tue, 23 Apr 2024 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ3SiHyu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D1802;
	Tue, 23 Apr 2024 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833259; cv=none; b=av2/fr4LqitAezw9DGqYK9W6qp6jo0zFfI5yRIYBHZP3cTP/DmY206FI4v8ijCIvfBpd/1SudIJT0hOCT0BALzeVEgj3wMtq+tOA5Qohvv95fdOLiNOw0YXrDlLbm0Of7kP/IMhWhsPJsf2mOZlHcnRkaKcROMjD+2A0GIv7Epw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833259; c=relaxed/simple;
	bh=LPMHQme1V8vDzMirJlOpLb0vftLJDLrVwcaPBuEO5Fo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=jEegyCr7MmzbXKQjXNMFpFDTPdUFrnxBeINC17acnofXbEcJb43QQHqQCvI/luygp7DNQHOQAhEtmrrq6UvZL/mXCgpXai26oJXcCEXEbBQ94KdGKWGyXOOySrFk7lSRzLyjVUpXecQjfkeE/80ihCRI4KnbUKT2JZvfMTCxLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ3SiHyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675CBC113CC;
	Tue, 23 Apr 2024 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713833258;
	bh=LPMHQme1V8vDzMirJlOpLb0vftLJDLrVwcaPBuEO5Fo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SZ3SiHyuarYWB1F6tUkkzJzyu22t8hnVHWFlNGoRPoXlF7pH8kOwJUhYRe4QUK/8+
	 JsVMSN0pt92WDOrwRouIEgBC9KwME4SGtqhrz3urJK3N0yH+pQdAeRAS2Jdajax+fv
	 ezTpMm4VrCIa6YsUJnLeTUga7IcLYyWcviRWnb2VI17XAq46Kwm9W1olCg+vpLMe+k
	 1WU/H0WoJ7QhZdXeFQt3NVyQ+LrE3aSdDJ4TI1fWoreR6UoiVw5PCMKZJnyV6AOcNn
	 RvvxLGSH9+jyEU2G3HwSyJEFpRcVwJRb3i2Ebn7eZhQj/xS7col3kvATKlx7w/RcEw
	 z93aSoFkhQYeg==
Message-ID: <eca85d9094538b8713b556979e811b39.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <06f26e2f49a8423cb0122a08fb2d868484e2e0a4.1713164546.git.unicorn_wang@outlook.com>
References: <cover.1713164546.git.unicorn_wang@outlook.com> <06f26e2f49a8423cb0122a08fb2d868484e2e0a4.1713164546.git.unicorn_wang@outlook.com>
Subject: Re: [PATCH v14 4/5] clk: sophgo: Add SG2042 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com, inochiama@outlook.com, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com, xiaoguang.xing@sophgo.com
Date: Mon, 22 Apr 2024 17:47:36 -0700
User-Agent: alot/0.10

Quoting Chen Wang (2024-04-15 00:23:27)
> diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.c b/drivers/clk/sophgo/=
clk-sophgo-sg2042.c
> new file mode 100644
> index 000000000000..0bcfaab52f51
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-sophgo-sg2042.c
> @@ -0,0 +1,1645 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo SG2042 Clock Generator Driver
> + *
> + * Copyright (C) 2024 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#include <asm/div64.h>

asm goes after linux includes...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/platform_device.h>

here.

> +
> +/*
> + * The clock of SG2042 is composed of three parts.
> + * The registers of these three parts of the clock are scattered in three
> + * different memory address spaces:
> + * - pll clocks
> + * - gate clocks for RP subsystem
> + * - div/mux, and gate clocks working for other subsystem than RP subsys=
tem
> + */
> +#include <dt-bindings/clock/sophgo,sg2042-pll.h>
> +#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
> +#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
> +
> +/* Registers defined in SYS_CTRL */
> +#define R_PLL_BEGIN            0xC0
[...]
> +
> +#define SG2042_PLL(_id, _name, _parent_name, _r_stat, _r_enable, _r_ctrl=
, _shift) \
> +       {                                                               \
> +               .hw.init =3D CLK_HW_INIT(                                =
 \
> +                               _name,                                  \
> +                               _parent_name,                           \

This still uses a string. Please convert all parents described by
strings to use clk_parent_data or clk_hw directly.

> +                               &sg2042_clk_pll_ops,                    \
> +                               CLK_GET_RATE_NOCACHE | CLK_GET_ACCURACY_N=
OCACHE),\
> +               .id =3D _id,                                             =
 \
> +               .offset_ctrl =3D _r_ctrl,                                =
 \
> +               .offset_status =3D _r_stat,                              =
 \
> +               .offset_enable =3D _r_enable,                            =
 \
> +               .shift_status_lock =3D 8 + (_shift),                     =
 \
> +               .shift_status_updating =3D _shift,                       =
 \
[...]
> + * "clk_div_ddr01_1" is the name of Clock divider 1 control of DDR01, and
> + * "clk_gate_ddr01_div1" is the gate clock in front of the "clk_div_ddr0=
1_1",
> + * they are both controlled by register CLKDIVREG28;
> + * While for register value of mux selection, use Clock Select for DDR01=
=E2=80=99s clock
> + * as example, see CLKSELREG0, bit[2].
> + * 1: Select in_dpll0_clk as clock source, correspondng to the parent in=
put
> + *    source from "clk_div_ddr01_0".
> + * 0: Select in_fpll_clk as clock source, corresponding to the parent in=
put
> + *    source from "clk_div_ddr01_1".
> + * So we need a table to define the array of register values correspondi=
ng to
> + * the parent index and tell CCF about this when registering mux clock.
> + */
> +static const u32 sg2042_mux_table[] =3D {1, 0};
> +
> +static const struct clk_parent_data clk_mux_ddr01_p[] =3D {
> +       { .hw =3D &sg2042_div_clks[0].hw },
> +       { .hw =3D &sg2042_div_clks[1].hw },

Just use struct clk_init_data::parent_hws for this if you only have a
clk_hw pointer for every element of the parent array.

> +};
> +
> +static const struct clk_parent_data clk_mux_ddr23_p[] =3D {
> +       { .hw =3D &sg2042_div_clks[2].hw },
> +       { .hw =3D &sg2042_div_clks[3].hw },
> +};
> +
[...]
> +
> +static int sg2042_pll_probe(struct platform_device *pdev)
> +{
> +       struct sg2042_clk_data *clk_data =3D NULL;
> +       int i, ret =3D 0;
> +       int num_clks =3D 0;
> +
> +       num_clks =3D ARRAY_SIZE(sg2042_pll_clks);
> +
> +       ret =3D sg2042_init_clkdata(pdev, num_clks, &clk_data);
> +       if (ret < 0)
> +               goto error_out;
> +
> +       ret =3D sg2042_clk_register_plls(&pdev->dev, clk_data, sg2042_pll=
_clks,
> +                                      num_clks);
> +       if (ret)
> +               goto cleanup;
> +
> +       return devm_of_clk_add_hw_provider(&pdev->dev,
> +                                          of_clk_hw_onecell_get,
> +                                          &clk_data->onecell_data);
> +
> +cleanup:
> +       for (i =3D 0; i < num_clks; i++) {
> +               if (clk_data->onecell_data.hws[i])
> +                       clk_hw_unregister(clk_data->onecell_data.hws[i]);

This should be unnecessary if devm is used throughout.

> +       }
> +
> +error_out:
> +       pr_err("%s failed error number %d\n", __func__, ret);
> +       return ret;

Just do this part in the one place the goto is. These two comments apply
to all probes.

