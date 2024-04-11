Return-Path: <linux-kernel+bounces-140169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87F8A0C54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12FB1C22648
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1051448F2;
	Thu, 11 Apr 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8q9P1uK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3170144D0D;
	Thu, 11 Apr 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827594; cv=none; b=UveygUUd2WR5Yw0WRHe/oOEjHMc83oqJVUiBg4ExX307KbVEdcNzXUWpHLKYeRPDwYPlquuGZltRoRWDQ9RKNKOpspspflBeBxMAZiX9ube5gTca2f4T97+foiCkR223qk08VbqKMtDVk81UsAFCsGBfDBz+jVM/SvX3o0DF++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827594; c=relaxed/simple;
	bh=6G71jNSKEd/jZfLMuwnapQpj2Fg6LgOvi0ZpKZsJ1vg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MtKiAcbbf5yR3Zgkco26P27z4aOAE+d+wQTXYrY/r0qzbiOgOagCj/ClzFWKcKTkiRSbOQQXgLgPRUX9X7j5v2rvPZVTTiPhXSu8cjYYBQA249y+89KHPFfpstsVw2gG5YfmHS5q+94q4HhJdsj7xhEibxokDwJcX0q4M/7h9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8q9P1uK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76494C43399;
	Thu, 11 Apr 2024 09:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827593;
	bh=6G71jNSKEd/jZfLMuwnapQpj2Fg6LgOvi0ZpKZsJ1vg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=I8q9P1uKGzMtgzzn1YZcwmD8uDci8yHRj+FVaxeLTCg0+Z2OJMxXndW66wVewn0A5
	 oPw6fKfI33WPLlGZPuToEPbSWdrwdNL4J2fsKXMeUi/a5lqbBdukfYP2GoSgS8U6gg
	 Jpcedy/K6FH/bxbAeXXgID8AfRnK/nVvonW3fA9UlKcgMR81CZujxKoTHx6/JSq8/2
	 FuADMCf9bA0vtY4LtlFBlv2VMgGX+AcJuTtEg0bOlsWXXql1Er3J8dPKrEmeP/FutX
	 WoXC4SrlJa2BwvRDgcCpbGc8+w7a5eJnt963c6BWW026by6LZ95SauCfnRDM5JlBGL
	 Nhty9hJh2mtYg==
Message-ID: <11055a03e605f9134f91af3e3f3a6c58.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240408-ep93xx-clk-v1-4-1d0f4c324647@maquefel.me>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me> <20240408-ep93xx-clk-v1-4-1d0f4c324647@maquefel.me>
Subject: Re: [PATCH 4/4] soc: Add SoC driver for Cirrus ep93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, Rob Herring <robh@kernel.org>, nikita.shubin@maquefel.me
Date: Thu, 11 Apr 2024 02:26:31 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2024-04-08 01:09:56)
> diff --git a/drivers/soc/cirrus/soc-ep93xx.c b/drivers/soc/cirrus/soc-ep9=
3xx.c
> new file mode 100644
> index 000000000000..044f17f9ba55
> --- /dev/null
> +++ b/drivers/soc/cirrus/soc-ep93xx.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SoC driver for Cirrus EP93xx chips.
> + * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/core.c
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> + *
> + * Thanks go to Michael Burian and Ray Lehtiniemi for their key
> + * role in the ep93xx Linux community.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/init.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>

Are these of includes used?

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/sys_soc.h>
> +
> +#include <linux/soc/cirrus/ep93xx.h>
> +
> +#define EP93XX_SYSCON_DEVCFG           0x80
> +
> +#define EP93XX_SWLOCK_MAGICK           0xaa
> +#define EP93XX_SYSCON_SWLOCK           0xc0
> +#define EP93XX_SYSCON_SYSCFG           0x9c
> +#define EP93XX_SYSCON_SYSCFG_REV_MASK  GENMASK(31, 28)
> +#define EP93XX_SYSCON_SYSCFG_REV_SHIFT 28
> +
[...]
> +
> +static void ep93xx_unregister_adev(void *_adev)
> +{
> +       struct auxiliary_device *adev =3D _adev;
> +
> +       auxiliary_device_delete(adev);
> +       auxiliary_device_uninit(adev);
> +}

It really seems like auxiliary bus code should expose a
simple_unregister_adev() function that does this two line function once
instead of every driver repeating it.

> +
> +static void ep93xx_adev_release(struct device *dev)
> +{
> +       struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +       struct ep93xx_regmap_adev *rdev =3D to_ep93xx_regmap_adev(adev);
> +
> +       kfree(rdev);
> +}
> +
> +static struct auxiliary_device *ep93xx_adev_alloc(struct device *parent,=
 const char *name,

__init?

> +                                                 struct ep93xx_map_info =
*info)
> +{
> +       struct ep93xx_regmap_adev *rdev __free(kfree) =3D NULL;
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +       if (!rdev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       rdev->map =3D info->map;
> +       rdev->base =3D info->base;
> +       rdev->lock =3D &info->lock;
> +       rdev->write =3D ep93xx_regmap_write;
> +       rdev->update_bits =3D ep93xx_regmap_update_bits;
> +
> +       adev =3D &rdev->adev;
> +       adev->name =3D name;
> +       adev->dev.parent =3D parent;
> +       adev->dev.release =3D ep93xx_adev_release;
> +
> +       ret =3D auxiliary_device_init(adev);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &no_free_ptr(rdev)->adev;
> +}
> +
> +static int ep93xx_controller_register(struct device *parent, const char =
*name,

__init?

> +                                     struct ep93xx_map_info *info)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev =3D ep93xx_adev_alloc(parent, name, info);
> +       if (IS_ERR(adev))
> +               return PTR_ERR(adev);
> +
> +       ret =3D auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(parent, ep93xx_unregister_adev, a=
dev);
> +}
> +
[...]
> +
> +static const char __init *ep93xx_get_soc_rev(struct regmap *map)
> +{
> +       switch (ep93xx_soc_revision(map)) {
> +       case EP93XX_CHIP_REV_D0:
> +               return "D0";
> +       case EP93XX_CHIP_REV_D1:
> +               return "D1";
> +       case EP93XX_CHIP_REV_E0:
> +               return "E0";
> +       case EP93XX_CHIP_REV_E1:
> +               return "E1";
> +       case EP93XX_CHIP_REV_E2:
> +               return "E2";
> +       default:
> +               return "unknown";
> +       }
> +}
> +
> +const char *pinctrl_names[] =3D {

static? Can also be __initconst? or moved into probe scope and placed on
the stack?

> +       "pinctrl-ep9301",       /* EP93XX_9301_SOC */
> +       "pinctrl-ep9307",       /* EP93XX_9307_SOC */
> +       "pinctrl-ep9312",       /* EP93XX_9312_SOC */
> +};

