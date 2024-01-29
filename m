Return-Path: <linux-kernel+bounces-43601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353AD84166B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947B9B20E81
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92651C34;
	Mon, 29 Jan 2024 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnfHkxTg"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6651C29
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569303; cv=none; b=e9o6tb3FaT7yr4nccatHY3ASN3eOiIJNFeBJAvjfTerlqBhc1w8LcSKDRms/I+S9dKuN4r7bzyfTY2E7ze4899lHMyuEFTcAtcVWDuKAMaCeh8CpyttBtBdrgu6UR6Ti2qxLDvuU0eTWY5rFwl6CMyNE5CO0s3ilzcpAUc0ReWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569303; c=relaxed/simple;
	bh=OmAVMp2X1RthAAvISK2+j0m3laGJcjJ+/yyg+B1fWCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXP9NauRw74KqfjhKf5z5XVfqHKb2zBZIC8v/4QA/nhww7EfghAs+P6CD1xyScD3ZyO0UVDIGU1UxZXXHQ4/6tlxFBjO6o2weeuESz3BXapN00GKPCE4juJYex4bzK5lRSzfTH35zzEJxZ2pZMBOwtauhSTkyjIBzHr8Q1bSLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnfHkxTg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6de287449f1so862370b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706569300; x=1707174100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXjWkKWAlux3q5C7RCesZVPuybEOOZ8jc9mNSC13fyo=;
        b=YnfHkxTgWI+q7KgRg1LrMVh8Rz2CYghRt1Jzzcns1h80Ym8pODgtVq9VTW4SWLclpp
         miRlTxHXRgLWVVRweH85vYJ9RsjPN7MChzdwUrR4yIBiDZdmdQuQmjvJCFlNArpDSJlK
         ZZDyyDFm69QuTIl6z5cJjDpTMg4yVk9VVp7BP/6x+EgQgXTJocrvJtjGo1jHNTROlEHq
         wGQJuntBtmu4fIvxC9agrdNOjDDVGA1Qm5zgQXME+uovqip5wU9MB6GZqVZItVGg4oWy
         J1J6GXRgsCFfBxOXqB0eynFrsic8tlFfKkL9hcxqBWbWDk81IuVNbpjjYrSOAcjF6kLP
         O1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706569300; x=1707174100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXjWkKWAlux3q5C7RCesZVPuybEOOZ8jc9mNSC13fyo=;
        b=Eza2Mk4b6BZf67kRX2FVUFLVnMznJpoGs1lPMMOMCOK7eXE1bu/4a9EtmnI0mllH+e
         US4bh9UtsFRKmSatSooSK/2O/4ZwwoGuDnAxyQAo0+Xx4PPlpPSfRARzvNQHe3qTkUbN
         N9KxJB/xMytqjghisX/hkkPSEJ/X5awaqoZ7j5uZN7f5/L7RV0FikfZ0RLd64TxBTOGg
         M/5dDyA5z61k6dh8fPoWnpXKqXI/c2yfTYz5rkuB8lfmKylo3Lv9X4yXHU42gH9rTqVk
         P4TAi7LgIwyJzPxa0/huyVTGYEl6vHlsZreUcltYK+65HwNQvBwa/45A+0acbg/1C0Ia
         ej0g==
X-Gm-Message-State: AOJu0YyxIki3A72+y+dcpwwR5m96DuIDi3+FMU2ExB0nD8/Ub1pGgb3I
	BjkMHsI8uuZWjgLnH5VIr0WkqlHusZIrMsvQO+DRVfgyZ9RqrR4Uu4TGPzB7oHB143tGeoFsgrJ
	5YnS82bnIKNa+D6Q/KgEzqyyNE37G8Hil+bzFAw==
X-Google-Smtp-Source: AGHT+IEGEwHNtpcxjOWH5AU8ins5S4Jj6fn9t798DO7OHZbDU2hXsCgKWC1+G0J5mBCTH5SmLJjUpis27+ETbchGjyU=
X-Received: by 2002:a05:6a00:1b51:b0:6db:9e9f:6a55 with SMTP id
 o17-20020a056a001b5100b006db9e9f6a55mr2864975pfv.25.1706569300424; Mon, 29
 Jan 2024 15:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129211912.3068411-1-peter.griffin@linaro.org> <20240129211912.3068411-2-peter.griffin@linaro.org>
In-Reply-To: <20240129211912.3068411-2-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 29 Jan 2024 17:01:28 -0600
Message-ID: <CAPLW+4kd4-8X_E5xGWkvPR11Ou2O=4EaM9-jiMpDbb09xH364g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Peter Griffin <peter.griffin@linaro.org>
Cc: arnd@arndb.de, krzysztof.kozlowski@linaro.org, linux@roeck-us.net, 
	wim@linux-watchdog.org, alim.akhtar@samsung.com, jaewon02.kim@samsung.com, 
	kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:19=E2=80=AFPM Peter Griffin <peter.griffin@linaro=
org> wrote:
>
> Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> security hardening reasons so that they are only accessible in el3 via an
> SMC call.
>
> As most Exynos drivers that need to write PMU registers currently obtain =
a
> regmap via syscon (phys, pinctrl, watchdog). Support for the above usecas=
e
> is implemented in this driver using a custom regmap similar to syscon to
> handle the SMC call. Platforms that don't secure PMU registers, get a mmi=
o
> regmap like before. As regmaps abstract out the underlying register acces=
s
> changes to the leaf drivers are minimal.
>
> A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> that currently use syscon_regmap_lookup_by_phandle(). This also handles
> deferred probing.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/soc/samsung/exynos-pmu.c       | 227 ++++++++++++++++++++++++-
>  include/linux/soc/samsung/exynos-pmu.h |  10 ++
>  2 files changed, 236 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exyno=
s-pmu.c
> index 250537d7cfd6..7bcc144e53a2 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -5,6 +5,7 @@
>  //
>  // Exynos - CPU PMU(Power Management Unit) support
>
> +#include <linux/arm-smccc.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/mfd/core.h>
> @@ -12,20 +13,159 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
> +#include <linux/regmap.h>
>
>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>  #include <linux/soc/samsung/exynos-pmu.h>
>
>  #include "exynos-pmu.h"
>
> +static struct platform_driver exynos_pmu_driver;
> +
> +#define PMUALIVE_MASK GENMASK(14, 0)

I'd advice to keep all #define's right after #include's block.

> +
>  struct exynos_pmu_context {
>         struct device *dev;
>         const struct exynos_pmu_data *pmu_data;
> +       struct regmap *pmureg;
>  };
>
>  void __iomem *pmu_base_addr;
>  static struct exynos_pmu_context *pmu_context;
>
> +/*
> + * Tensor SoCs are configured so that PMU_ALIVE registers can only be wr=
itten
> + * from el3. As Linux needs to write some of these registers, the follow=
ing

Suggest changing el3 to EL3.

> + * SMC register read/write/read,write,modify interface is used.

Frankly, I don't really get what does this line mean.

> + *
> + * Note: This SMC interface is known to be implemented on gs101 and deri=
vative
> + * SoCs.
> + */
> +#define TENSOR_SMC_PMU_SEC_REG                 (0x82000504)

Braces are probably not needed here.

> +#define TENSOR_PMUREG_READ                     0
> +#define TENSOR_PMUREG_WRITE                    1
> +#define TENSOR_PMUREG_RMW                      2

I'd advice to keep all #define's right after #include's block.

> +
> +/**
> + * tensor_sec_reg_write

That doesn't look like a commonly used kernel-doc style. Please check
[1] and re-format accordingly. I'd also add that this function's
signature is quite self-explanatory, and it's also static, so I'm not
sure if it deserves kernel-doc comment or if it just makes things more
cluttered in this case. Maybe one-line regular comment will do here?
If you still thinks kernel-doc works better, please also check it with

    $ scripts/kernel-doc -v -none drivers/soc/samsung/exynos-pmu.c
    $ scripts/kernel-doc -v drivers/soc/samsung/exynos-pmu.c

The same comment goes for below kernel-doc functions.

[1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#writin=
g-kernel-doc-comments

> + * Write to a protected SMC register.
> + * @base: Base address of PMU
> + * @reg:  Address offset of register
> + * @val:  Value to write

AFAIR, alignment with spaces is discouraged by kernel coding style.

> + * Return: (0) on success

Not sure if braces are needed around 0 here. Also, is it only 0 value,
or some other values can be returned?

> + *

This line is not needed.

> + */
> +static int tensor_sec_reg_write(void *base, unsigned int reg, unsigned i=
nt val)
> +{
> +       struct arm_smccc_res res;
> +       unsigned long pmu_base =3D (unsigned long)base;
> +
> +       arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> +                     pmu_base + reg,
> +                     TENSOR_PMUREG_WRITE,
> +                     val, 0, 0, 0, 0, &res);

It can be 2 lines instead 4.

> +
> +       if (res.a0)
> +               pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
> +
> +       return (int)res.a0;

res.a0 are positive numbers, but in kernel the error codes are usually
negative numbers. I'm not sure if it's ok to use positive numbers for
regmap ops, but at least error codes should be documented.

> +}
> +
> +/**
> + * tensor_sec_reg_rmw
> + * Read/Modify/Write to a protected SMC register.
> + * @base: Base address of PMU
> + * @reg:  Address offset of register

@mask is missing? Guess "make W=3Dn" should complain, and kernel-doc too.

> + * @val:  Value to write
> + * Return: (0) on success
> + *
> + */
> +static int tensor_sec_reg_rmw(void *base, unsigned int reg,
> +                             unsigned int mask, unsigned int val)
> +{
> +       struct arm_smccc_res res;
> +       unsigned long pmu_base =3D (unsigned long)base;
> +
> +       arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> +                     pmu_base + reg,
> +                     TENSOR_PMUREG_RMW,
> +                     mask, val, 0, 0, 0, &res);
> +
> +       if (res.a0)
> +               pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
> +
> +       return (int)res.a0;
> +}
> +
> +/**
> + * tensor_sec_reg_read
> + * Read a protected SMC register.
> + * @base: Base address of PMU
> + * @reg:  Address offset of register
> + * @val:  Value read
> + * Return: (0) on success
> + */
> +static int tensor_sec_reg_read(void *base, unsigned int reg, unsigned in=
t *val)
> +{
> +       struct arm_smccc_res res;
> +       unsigned long pmu_base =3D (unsigned long)base;
> +
> +       arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
> +                     pmu_base + reg,
> +                     TENSOR_PMUREG_READ,
> +                     0, 0, 0, 0, 0, &res);
> +
> +       *val =3D (unsigned int)res.a0;
> +
> +       return 0;
> +}
> +
> +

Double empty line.

> +/*
> + * For SoCs that have set/clear bit hardware this function
> + * can be used when the PMU register will be accessed by
> + * multiple masters.
> + *
> + * For example, to set bits 13:8 in PMU reg offset 0x3e80
> + * tensor_set_bit_atomic(0x3e80, 0x3f00, 0x3f00);
> + *
> + * To clear bits 13:8 in PMU offset 0x3e80
> + * tensor_set_bit_atomic(0x3e80, 0x0, 0x3f00);
> + */
> +static inline void tensor_set_bit_atomic(void *ctx, unsigned int offset,
> +                                        u32 val, u32 mask)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < 32; i++) {
> +               if (mask & BIT(i)) {

Maybe use for_each_set_bit() or something like that?

> +                       if (val & BIT(i)) {
> +                               offset |=3D 0xc000;
> +                               tensor_sec_reg_write(ctx, offset, i);
> +                       } else {
> +                               offset |=3D 0x8000;

Magic number? Maybe makes sense to replace it with a named constant.

> +                               tensor_sec_reg_write(ctx, offset, i);

Common line, can be extracted out of if/else block.

> +                       }
> +               }
> +       }
> +}
> +
> +int tensor_sec_update_bits(void *ctx, unsigned int reg, unsigned int mas=
k, unsigned int val)

Unnecessary exceeds 80 characters-per-line limit.

> +{
> +       int ret =3D 0;

Why is this needed at all?

> +
> +       /*
> +        * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF=
)
> +        * as the target registers can be accessed by multiple masters.
> +        */
> +       if (reg > PMUALIVE_MASK)
> +               return tensor_sec_reg_rmw(ctx, reg, mask, val);
> +
> +       tensor_set_bit_atomic(ctx, reg, val, mask);
> +
> +       return ret;
> +}
> +
>  void pmu_raw_writel(u32 val, u32 offset)
>  {
>         writel_relaxed(val, pmu_base_addr + offset);
> @@ -80,6 +220,8 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode=
)
>   */
>  static const struct of_device_id exynos_pmu_of_device_ids[] =3D {
>         {
> +               .compatible =3D "google,gs101-pmu",
> +       }, {
>                 .compatible =3D "samsung,exynos3250-pmu",
>                 .data =3D exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
>         }, {
> @@ -113,19 +255,73 @@ static const struct mfd_cell exynos_pmu_devs[] =3D =
{
>         { .name =3D "exynos-clkout", },
>  };
>
> +/**
> + * exynos_get_pmu_regmap
> + * Find the pmureg previously configured in probe() and return regmap pr=
operty.
> + * Return: regmap if found or error if not found.
> + */
>  struct regmap *exynos_get_pmu_regmap(void)
>  {
>         struct device_node *np =3D of_find_matching_node(NULL,
>                                                       exynos_pmu_of_devic=
e_ids);
>         if (np)
> -               return syscon_node_to_regmap(np);
> +               return exynos_get_pmu_regmap_by_phandle(np, NULL);

Maybe move !np case handling into exynos_get_pmu_regmap_by_phandle()?

>         return ERR_PTR(-ENODEV);
>  }
>  EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
>
> +/**
> + * exynos_get_pmu_regmap_by_phandle
> + * Find the pmureg previously configured in probe() and return regmap pr=
operty.
> + * Return: regmap if found or error if not found.
> + *
> + * @np: Pointer to device's Device Tree node
> + * @property: Device Tree property name which references the pmu
> + */
> +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> +                                               const char *property)
> +{
> +       struct device *dev;
> +       struct exynos_pmu_context *ctx;
> +       struct device_node *pmu_np;
> +
> +       if (property)
> +               pmu_np =3D of_parse_phandle(np, property, 0);
> +       else
> +               pmu_np =3D np;
> +
> +       if (!pmu_np)
> +               return ERR_PTR(-ENODEV);
> +
> +       dev =3D driver_find_device_by_of_node(&exynos_pmu_driver.driver,
> +                                           (void *)pmu_np);
> +       of_node_put(pmu_np);
> +       if (!dev)
> +               return ERR_PTR(-EPROBE_DEFER);
> +
> +       ctx =3D dev_get_drvdata(dev);
> +
> +       return ctx->pmureg;
> +}
> +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> +
> +static struct regmap_config pmu_regs_regmap_cfg =3D {
> +       .name =3D "pmu_regs",
> +       .reg_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .val_bits =3D 32,
> +       .fast_io =3D true,
> +       .use_single_read =3D true,
> +       .use_single_write =3D true,
> +};
> +
>  static int exynos_pmu_probe(struct platform_device *pdev)
>  {
> +       struct resource *res;
> +       struct regmap *regmap;
> +       struct regmap_config pmuregmap_config =3D pmu_regs_regmap_cfg;

Why copy that struct? IMHO, either use it as is, or if you want to
copy it for some particular reason, maybe make pmu_regs_regmap_cfg a
const?

Also, suggest reducing the variable name length. Maybe regmap_cfg would do?

>         struct device *dev =3D &pdev->dev;
> +       struct device_node *np =3D dev->of_node;
>         int ret;
>
>         pmu_base_addr =3D devm_platform_ioremap_resource(pdev, 0);
> @@ -137,6 +333,35 @@ static int exynos_pmu_probe(struct platform_device *=
pdev)
>                         GFP_KERNEL);
>         if (!pmu_context)
>                 return -ENOMEM;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENODEV;
> +
> +       pmuregmap_config.max_register =3D resource_size(res) -
> +                                    pmuregmap_config.reg_stride;
> +
> +       if (of_device_is_compatible(np, "google,gs101-pmu")) {
> +               pmuregmap_config.reg_read =3D tensor_sec_reg_read;
> +               pmuregmap_config.reg_write =3D tensor_sec_reg_write;
> +               pmuregmap_config.reg_update_bits =3D tensor_sec_update_bi=
ts;
> +
> +               /* Need physical address for SMC call */
> +               regmap =3D devm_regmap_init(dev, NULL,
> +                                         (void *)(uintptr_t)res->start,
> +                                         &pmuregmap_config);
> +       } else {
> +               pmuregmap_config.max_register =3D resource_size(res) - 4;
> +               regmap =3D devm_regmap_init_mmio(dev, pmu_base_addr,
> +                                              &pmuregmap_config);
> +       }
> +
> +       if (IS_ERR(regmap)) {
> +               pr_err("regmap init failed\n");

dev_err()? Or even better, return dev_err_probe()?

> +               return PTR_ERR(regmap);
> +       }
> +
> +       pmu_context->pmureg =3D regmap;
>         pmu_context->dev =3D dev;
>         pmu_context->pmu_data =3D of_device_get_match_data(dev);
>
> diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/s=
amsung/exynos-pmu.h
> index a4f5516cc956..68fb01ba6bef 100644
> --- a/include/linux/soc/samsung/exynos-pmu.h
> +++ b/include/linux/soc/samsung/exynos-pmu.h
> @@ -21,11 +21,21 @@ enum sys_powerdown {
>  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
>  #ifdef CONFIG_EXYNOS_PMU
>  extern struct regmap *exynos_get_pmu_regmap(void);
> +
> +extern struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_nod=
e *np,
> +                                                      const char *proper=
ty);

Why use "extern" here, it's just a function declaration.

> +

Either remove this empty line, or add more empty lines around all
parts of #ifdef block for consistency.

>  #else
>  static inline struct regmap *exynos_get_pmu_regmap(void)
>  {
>         return ERR_PTR(-ENODEV);
>  }
> +
> +static inline struct regmap *exynos_get_pmu_regmap_by_phandle(struct dev=
ice_node *np,
> +                                                             const char =
*property)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
>  #endif
>
>  #endif /* __LINUX_SOC_EXYNOS_PMU_H */
> --
> 2.43.0.429.g432eaa2c6b-goog
>

