Return-Path: <linux-kernel+bounces-97778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE2876F48
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A18281B26
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B975D31A94;
	Sat,  9 Mar 2024 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZx0C8/z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC279B656;
	Sat,  9 Mar 2024 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709961697; cv=none; b=j9lTh0CyAz5DYuxH7mG5EvTOGAN1E8l/E0Bf1/Gv3uY19ebYdsl+xELZhUCOn+cWG7etSnBXaLiT3YAQdl7eZnbcRB5SNKJCseQVK+/YE+qUFuObeL05cL+NZ6S+gK/PKRJTI9jWh+UxvjaeopWkZKkYf7OmTuGzsFm1yN3R48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709961697; c=relaxed/simple;
	bh=tqY4JVDtTjXz4kbJkAYJ+KcUDc570PmGen8k2hpbpBU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rsfeeISM9m8Z7VnXuwmUkGHUrIQjPUK1dBfwoOlvwQGwEEVIV+HUVh1EAvjyf4IDglntIN19hO1VZUoWLMRZEF5KvDxuqk0s35vNgCoLB3txC6Wj+gRy1L3oJYRcScngmJtmZl8HRStzODP/fH0UWU9Sk1kZ+9LYq5kKjSzFVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZx0C8/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F34C433C7;
	Sat,  9 Mar 2024 05:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709961697;
	bh=tqY4JVDtTjXz4kbJkAYJ+KcUDc570PmGen8k2hpbpBU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GZx0C8/zLHn49Fbe/alM0hhq763Bha3aaoB2N6cdez2gYXeDO/sdP/ZFaPqP3+nuV
	 TFl0tGNmoLp57fFvStiBZ2KqEO6lzOBI2lHFNXOJeb6DLhG7AweD99XR+04NW4OMrm
	 fLCCAx+wC31Tro+Iw9umL2ObeIIOjjSxtgFk+c0/hin+gkRjL5vtc3U1jImCud2lkk
	 EGLZeAA+ryX8oTaMW2lYmw7qLOzkPZOtKx3aYlUfpz82gONLC7QNSiOwVKccUmiizc
	 Mle405ajB6zi0AnP4rpGlqxwSuZ7ASCwFTtyOvrXwnzj1z1mHfhr206Aj4e+J/kG6t
	 xK6ml6v16AOEw==
Message-ID: <55a896bcb94af629bb58c304268ac7ec.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR20MB4953925533ACD65B32D423D9BB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com> <IA1PR20MB4953925533ACD65B32D423D9BB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Subject: Re: [PATCH v8 2/8] clk: sophgo: Add CV1800/SG2000 series clock controller driver skeleton
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
To: Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>
Date: Fri, 08 Mar 2024 21:21:34 -0800
User-Agent: alot/0.10

Quoting Inochi Amaoto (2024-02-13 00:22:34)
> diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
> new file mode 100644
> index 000000000000..d67009fa749f
> --- /dev/null
> +++ b/drivers/clk/sophgo/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# common clock support for SOPHGO SoC family.
> +
> +config CLK_SOPHGO_CV1800
> +       tristate "Support for the Sophgo CV1800 series SoCs clock control=
ler"
> +       default m

Please remove any default and set it in the defconfig instead.

> +       depends on ARCH_SOPHGO || COMPILE_TEST
> +       help
> +         This driver supports clock controller of Sophgo CV18XX series S=
oC.
> +         The driver require a 25MHz Oscillator to function generate cloc=
k.
> +         It includes PLLs, common clock function and some vendor clock f=
or
> +         IPs of CV18XX series SoC
> diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1=
800.c
> new file mode 100644
> index 000000000000..7183e67f20bf
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-cv1800.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +#include "clk-cv18xx-common.h"
> +
> +struct cv1800_clk_ctrl;
> +
> +struct cv1800_clk_desc {
> +       struct clk_hw_onecell_data      *clks_data;
> +
> +       int (*pre_init)(struct device *dev, void __iomem *base,
> +                       struct cv1800_clk_ctrl *ctrl,
> +                       const struct cv1800_clk_desc *desc);
> +};
> +
> +struct cv1800_clk_ctrl {
> +       const struct cv1800_clk_desc    *desc;
> +       spinlock_t                      lock;
> +};
> +
> +static int cv1800_clk_init_ctrl(struct device *dev, void __iomem *reg,
> +                               struct cv1800_clk_ctrl *ctrl,
> +                               const struct cv1800_clk_desc *desc)
> +{
> +       int i, ret;
> +
> +       ctrl->desc =3D desc;
> +       spin_lock_init(&ctrl->lock);
> +
> +       for (i =3D 0; i < desc->clks_data->num; i++) {
> +               struct clk_hw *hw =3D desc->clks_data->hws[i];
> +               struct cv1800_clk_common *common;
> +               const char *name;
> +
> +               if (!hw)
> +                       continue;
> +
> +               name =3D hw->init->name;
> +
> +               common =3D hw_to_cv1800_clk_common(hw);
> +               common->base =3D reg;
> +               common->lock =3D &ctrl->lock;
> +
> +               ret =3D devm_clk_hw_register(dev, hw);
> +               if (ret) {
> +                       dev_err(dev, "Couldn't register clock %d - %s\n",
> +                               i, name);
> +                       return ret;
> +               }
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                         desc->clks_data);
> +
> +       return ret;

Just return devm...

> +}
> +
> +static int cv1800_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       void __iomem *reg;
> +       int ret;
> +       const struct cv1800_clk_desc *desc;
> +       struct cv1800_clk_ctrl *ctrl;
> +
> +       reg =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(reg))
> +               return PTR_ERR(reg);
> +
> +       desc =3D device_get_match_data(dev);
> +       if (!desc) {
> +               dev_err(dev, "no match data for platform\n");
> +               return -EINVAL;
> +       }
> +
> +       ctrl =3D devm_kmalloc(dev, sizeof(*ctrl), GFP_KERNEL);

Why not devm_kzalloc?

> +       if (!ctrl)
> +               return -ENOMEM;
> +
> +       if (desc->pre_init) {
> +               ret =3D desc->pre_init(dev, reg, ctrl, desc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D cv1800_clk_init_ctrl(dev, reg, ctrl, desc);
> +
> +       return ret;

This is return cv1800_clk_init_ctrl(...

> +}
> +
> +static const struct of_device_id cv1800_clk_ids[] =3D {
> +       { }

Don't do this. Just send the whole driver as one patch.

> +};
> +MODULE_DEVICE_TABLE(of, cv1800_clk_ids);
> +
> +static struct platform_driver cv1800_clk_driver =3D {
> +       .probe  =3D cv1800_clk_probe,
> +       .driver =3D {
> +               .name                   =3D "cv1800-clk",
> +               .suppress_bind_attrs    =3D true,
> +               .of_match_table         =3D cv1800_clk_ids,
> +       },
> +};
> +module_platform_driver(cv1800_clk_driver);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/sophgo/clk-cv18xx-common.c b/drivers/clk/sophgo/=
clk-cv18xx-common.c
> new file mode 100644
> index 000000000000..cbcdd88f0e23
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-cv18xx-common.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/spinlock.h>
> +#include <linux/bug.h>
> +
> +#include "clk-cv18xx-common.h"
> +
> +int cv1800_clk_setbit(struct cv1800_clk_common *common,
> +                     struct cv1800_clk_regbit *field)
> +{
> +       u32 mask =3D BIT(field->shift);
> +       u32 value;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       value =3D readl(common->base + field->reg);
> +       writel(value | mask, common->base + field->reg);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       return 0;
> +}
> +
> +int cv1800_clk_clearbit(struct cv1800_clk_common *common,
> +                       struct cv1800_clk_regbit *field)
> +{
> +       u32 mask =3D BIT(field->shift);
> +       u32 value;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       value =3D readl(common->base + field->reg);
> +       writel(value & ~mask, common->base + field->reg);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       return 0;
> +}
> +
> +int cv1800_clk_checkbit(struct cv1800_clk_common *common,
> +                       struct cv1800_clk_regbit *field)
> +{
> +       return readl(common->base + field->reg) & BIT(field->shift);
> +}
> +
> +#define PLL_LOCK_TIMEOUT_US    (200 * 1000)
> +
> +void cv1800_clk_wait_for_lock(struct cv1800_clk_common *common,
> +                             u32 reg, u32 lock)
> +{
> +       void __iomem *addr =3D common->base + reg;
> +       u32 regval;
> +
> +       if (!lock)
> +               return;
> +
> +       WARN_ON(readl_relaxed_poll_timeout(addr, regval, regval & lock,
> +                                          100, PLL_LOCK_TIMEOUT_US));
> +}
> diff --git a/drivers/clk/sophgo/clk-cv18xx-common.h b/drivers/clk/sophgo/=
clk-cv18xx-common.h
> new file mode 100644
> index 000000000000..2bfda02b2064
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-cv18xx-common.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +#ifndef _CLK_SOPHGO_CV18XX_IP_H_
> +#define _CLK_SOPHGO_CV18XX_IP_H_
> +
> +#include <linux/compiler.h>
> +#include <linux/clk-provider.h>
> +#include <linux/bitfield.h>
> +
> +struct cv1800_clk_common {
> +       void __iomem    *base;
> +       spinlock_t      *lock;
> +       struct clk_hw   hw;
> +       unsigned long   features;
> +};
> +
> +#define CV1800_CLK_COMMON(_name, _parents, _op, _flags)                 =
       \
> +       {                                                               \
> +               .hw.init =3D CLK_HW_INIT_PARENTS_DATA(_name, _parents,   =
 \
> +                                                   _op, _flags),       \
> +       }
> +
> +static inline struct cv1800_clk_common *
> +hw_to_cv1800_clk_common(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct cv1800_clk_common, hw);
> +}
> +
> +struct cv1800_clk_regbit {
> +       u16             reg;
> +       s8              shift;
> +};
> +
> +struct cv1800_clk_regfield {
> +       u16             reg;
> +       u8              shift;
> +       u8              width;
> +       s16             initval;
> +       unsigned long   flags;
> +};
> +
> +#define CV1800_CLK_BIT(_reg, _shift)   \
> +       {                               \
> +               .reg =3D _reg,            \
> +               .shift =3D _shift,        \
> +       }
> +
> +#define CV1800_CLK_REG(_reg, _shift, _width, _initval, _flags) \
> +       {                                                       \
> +               .reg =3D _reg,                                    \
> +               .shift =3D _shift,                                \
> +               .width =3D _width,                                \
> +               .initval =3D _initval,                            \
> +               .flags =3D _flags,                                \
> +       }
> +
> +#define cv1800_clk_regfield_genmask(_reg) \
> +       GENMASK((_reg)->shift + (_reg)->width - 1, (_reg)->shift)
> +#define cv1800_clk_regfield_get(_val, _reg) \
> +       (((_val) >> (_reg)->shift) & GENMASK((_reg)->width - 1, 0))
> +#define cv1800_clk_regfield_set(_val, _new, _reg)    \
> +       (((_val) & ~cv1800_clk_regfield_genmask((_reg))) | \
> +        (((_new) & GENMASK((_reg)->width - 1, 0)) << (_reg)->shift))
> +
> +#define _CV1800_SET_FIELD(_reg, _val, _field) \
> +       (((_reg) & ~(_field)) | FIELD_PREP((_field), (_val)))
> +
> +int cv1800_clk_setbit(struct cv1800_clk_common *common,
> +                     struct cv1800_clk_regbit *field);
> +int cv1800_clk_clearbit(struct cv1800_clk_common *common,
> +                       struct cv1800_clk_regbit *field);
> +int cv1800_clk_checkbit(struct cv1800_clk_common *common,
> +                       struct cv1800_clk_regbit *field);
> +
> +void cv1800_clk_wait_for_lock(struct cv1800_clk_common *common,
> +                             u32 reg, u32 lock);
> +
> +#endif // _CLK_SOPHGO_CV18XX_IP_H_
> diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.c b/drivers/clk/sophgo/clk-=
cv18xx-ip.c
> new file mode 100644
> index 000000000000..cd397d102442
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-cv18xx-ip.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/gcd.h>
> +#include <linux/spinlock.h>
> +
> +#include "clk-cv18xx-ip.h"
> +
> +/* GATE */
> +const struct clk_ops cv1800_clk_gate_ops =3D {
> +       .disable =3D NULL,
> +       .enable =3D NULL,
> +       .is_enabled =3D NULL,
> +
> +       .recalc_rate =3D NULL,
> +       .round_rate =3D NULL,
> +       .set_rate =3D NULL,
> +};

Everything is NULL. What are you trying to do? Point out what will come
later? Please squash patches.

> +
> +/* DIV */
> +const struct clk_ops cv1800_clk_div_ops =3D {
> +       .disable =3D NULL,
> +       .enable =3D NULL,
> +       .is_enabled =3D NULL,
> +
> +       .determine_rate =3D NULL,
> +       .recalc_rate    =3D NULL,
> +       .set_rate =3D NULL,
> +};
> +
> +const struct clk_ops cv1800_clk_bypass_div_ops =3D {
> +       .disable =3D NULL,
> +       .enable =3D NULL,
> +       .is_enabled =3D NULL,
> +
> +       .determine_rate =3D NULL,

