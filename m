Return-Path: <linux-kernel+bounces-140017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E598A0A65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FB61C21265
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C5313FD8C;
	Thu, 11 Apr 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG/lFgCu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A713E8B9;
	Thu, 11 Apr 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821546; cv=none; b=D/dMnEBHrh2da4zBznv5r/lj1iHNVrXKnmlp0+vf/PF1VbzVlZQ3SXMcqoFmBZ2nBaiys1WDlHzAZb3XXoVuIxef48OmHDTkMBI/NQHHcYbpkcd0/Zf7hjfhBuCyKjH+Utfx38H+plzaTUXEHTs1f90U45ZMWfy39uDAqZOZbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821546; c=relaxed/simple;
	bh=bIJYJVzqanaZpwzfS5AEQO7u84UA48mefo7TJ6Lffno=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=SrIveMa1ElwBrtLOSSIgaDH9eAdK59dwMvVK2EQ1U3bwgtrBGN9DyJWTfoKmy96AMXqwQM0+tBRVllp+1R9WOsoap0f2gAgSMXfnBG4t30StZqx73TPfEw8JkKc3oskOCmcru/SEExTBF9S4uUN5OZOg+q88oV025K9teR79GgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG/lFgCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B73C433F1;
	Thu, 11 Apr 2024 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712821546;
	bh=bIJYJVzqanaZpwzfS5AEQO7u84UA48mefo7TJ6Lffno=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tG/lFgCur7g9BOwGLDPzXN5cSqy9ewWid7Mh0o4YCsdccnNmtKYDatti9HQ6V2FeY
	 KNSoDo/Wqe3RsMPhSIouPSrXHQ5+1/AqjC0QW2sDlU3z5RW3e6y6zhmZobwDcYlSJS
	 kw+Kekd3JK5Kz0IIgwkI4CtMbYlWs9zbtaoI1aR9hXpJFCSzoR10y3WQNwFFhpe6x2
	 b30i3G6oDWPxmbv9D7Pae6AUQqso6INKBRJC2Vh5GqSnAHxB88Cf8uJkAOEU9Wmkhg
	 ZmBzpLnDCIpumupVEiZ7KmI1owJ/pQlPUekASduGLkIAZlVYeHnR8KkzHKfDZBjTZ4
	 1sbajJFOa/UFA==
Message-ID: <deb23094f40df7df9e7330e95af4e64d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240110133128.286657-7-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com> <20240110133128.286657-7-jeeheng.sia@starfivetech.com>
Subject: Re: [RFC v3 06/16] clk: starfive: Add JH8100 System clock generator driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>, aou@eecs.berkeley.edu, conor@kernel.org, emil.renner.berthing@canonical.com, hal.feng@starfivetech.com, kernel@esmil.dk, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org, xingyu.wu@starfivetech.com
Date: Thu, 11 Apr 2024 00:45:43 -0700
User-Agent: alot/0.10

Quoting Sia Jee Heng (2024-01-10 05:31:18)
> diff --git a/drivers/clk/starfive/clk-starfive-jh8100-sys.c b/drivers/clk=
/starfive/clk-starfive-jh8100-sys.c
> new file mode 100644
> index 000000000000..6d7e750dce82
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh8100-sys.c
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH8100 System Clock Driver
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + *
> + */
> +
> +#include <linux/clk.h>

Drop this unused include.

> +#include <linux/auxiliary_bus.h>
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/io.h>

Is this include used in this file?

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <soc/starfive/reset-starfive-common.h>
> +
> +#include <dt-bindings/clock/starfive,jh8100-crg.h>
> +
> +#include "clk-starfive-jh8100.h"
> +
> +#define JH8100_SYSCLK_NUM_CLKS                 (JH8100_SYSCLK_NNE_ICG_EN=
 + 1)
> +
[...]
> +
> +static void jh8100_reset_adev_release(struct device *dev)
> +{
> +       struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +       struct starfive_reset_adev *rdev =3D to_starfive_reset_adev(adev);
> +
> +       kfree(rdev);
> +}
> +
> +int jh8100_reset_controller_register(struct starfive_clk_priv *priv,

Just pass 'dev' and 'base' instead.

> +                                    const char *adev_name,
> +                                    u32 adev_id)
> +{
> +       struct starfive_reset_adev *rdev;
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +       if (!rdev)
> +               return -ENOMEM;
> +
> +       rdev->base =3D priv->base;
> +
> +       adev =3D &rdev->adev;
> +       adev->name =3D adev_name;
> +       adev->dev.parent =3D priv->dev;
> +       adev->dev.release =3D jh8100_reset_adev_release;
> +       adev->id =3D adev_id;
> +
> +       ret =3D auxiliary_device_init(adev);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(priv->dev,
> +                                       jh8100_reset_unregister_adev, ade=
v);
> +}
> +EXPORT_SYMBOL_GPL(jh8100_reset_controller_register);

Move this to drivers/reset/ please.

> +
> +static int __init jh8100_syscrg_probe(struct platform_device *pdev)
> +{
> +       struct starfive_clk_priv *priv;
> +       unsigned int idx;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(&pdev->dev,
> +                           struct_size(priv, reg, JH8100_SYSCLK_NUM_CLKS=
),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&priv->rmw_lock);
> +       priv->dev =3D &pdev->dev;
> +       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
[...]
> +
> +       ret =3D devm_of_clk_add_hw_provider(&pdev->dev, jh8100_sysclk_get=
, priv);
> +       if (ret)
> +               return ret;
> +
> +       return jh8100_reset_controller_register(priv, "rst-sys", 0);
> +}
> +
> +static const struct of_device_id jh8100_syscrg_match[] =3D {
> +       { .compatible =3D "starfive,jh8100-syscrg" },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver jh8100_syscrg_driver =3D {
> +       .driver =3D {
> +               .name =3D "clk-starfive-jh8100-sys",
> +               .of_match_table =3D jh8100_syscrg_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +builtin_platform_driver_probe(jh8100_syscrg_driver, jh8100_syscrg_probe);
> diff --git a/drivers/clk/starfive/clk-starfive-jh8100.h b/drivers/clk/sta=
rfive/clk-starfive-jh8100.h
> new file mode 100644
> index 000000000000..9b69a56fe5fc
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh8100.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __CLK_STARFIVE_JH8100_H
> +#define __CLK_STARFIVE_JH8100_H
> +
> +#include "clk-starfive-common.h"

Drop this include.

> +
> +int jh8100_reset_controller_register(struct starfive_clk_priv *priv,

Forward declare starfive_clk_priv instead.

> +                                    const char *adev_name,
> +                                    u32 adev_id);

Why is this header here at all?

