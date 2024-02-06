Return-Path: <linux-kernel+bounces-55285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC0084BA44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E307128DB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4CF134727;
	Tue,  6 Feb 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8gjlWlR"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF54134721
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235015; cv=none; b=WmtwknYm4zwsusXi4O4cCpXjjQxVUSXy2eFFf2GlSgazCUhMq58L1nkmKI2TBGnEx1ARdkkBc1Iib84edDvR7FY0K9NkBTSvZ5P9DVIeCGbsCfkWqLp1b6l0eBeQV/hjhJjdIX6+K20YV6IvFqH9Bu/jGok8HRla1qVaW8VwDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235015; c=relaxed/simple;
	bh=hcnRWbYRwOSqHk002c9kotwOL7cYJtXPGdPu/Tyleq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7x0v4yrSQVNsZ2+gGkHLZQDvA0DTB1av5IkC/JoWR69eUTUFaMpUKIzo1uN5E+xD8ehZn15btNVQNjmKfAAp5Rk1/cMqxaINeZ6ieVWWZb2DWiBxzII/8wAKOGukW2EDMa58g9nR/xzAAV+TsDef39F2hfnfyMZC8s0UYvP1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D8gjlWlR; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6818aa07d81so34485276d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707235011; x=1707839811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teFCdIN1/38ZQJ7TM5uLrqELZ67nou7BTJ2vhyrwL+E=;
        b=D8gjlWlRcTSNskA0Phin9HG0u+5kxOd0HWNg+m8MD5EjfTcTNiQ8+BdmYQOODuF99U
         hUNoVvrOePWZgpK9czfGGnftk7retlqpsIlN1QHBQPmu2Ov1WelKQqF+ovv1gs3iHlSl
         L7DT9kzU3Q2vbcq6y1QFnzTxSTpw3KqdTHwrKVg4MJaThdcBCy+C5ySRZSooS9MgP8Sd
         jGdoS/4/54SZexccFHvADwg0/XmwfLjdbth7ElijyGP0msM9xEkMVFr6fapFvCcWydTK
         d2XU2rFoXSaQti6AOgf1BCBFtwWyV9fDtoN5HStHd5Lu8uPab4g9RQyQsM48P3DG/lfn
         HPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235011; x=1707839811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teFCdIN1/38ZQJ7TM5uLrqELZ67nou7BTJ2vhyrwL+E=;
        b=VW6xROADcLuAwkhu4AD4rhmz1isU4yaoZTSI3FLwTpnOERjx3fQ+MZ9A+7I3H6KqD9
         tkc8VU8s/jv7VaH84b6SYhYqKmFxTBj3D1+t2vOBl7PZfO0PW6AGvRJIvsqiv44n/5S7
         oogMHPhEy3cwMHQNqmQ1jYEiB7Eg7CVvMNoWoQ+RvlTinbtAcHY/D9v+5l1+g8TTC34I
         v/9939F7VLE5UoD5ZnhKku1s9AgYVgPsR0xg5db1w3GC9aOEM9LpeTGyUhXtRbgk8ZRc
         0iNKSe74OXX7Kz+tL7CevEdzwaKCMyFMdZ8l9xVmLpKAf5uOXiLasl6o9U3USP+HV/vV
         bmZg==
X-Gm-Message-State: AOJu0YyoKOPfNzqwlNcnZlhPWP4cAdNfA6c7vdia9oSWxwjfo/ngnArR
	tNHaJz+q26BrF6be9DUZZ4zNNP3V7Ec948dGcYS2buFF9TX9ib634qWd1yrL8yzz8OTkKOtrBI3
	Yoz5E2zuJVTkqCIjsyDzQTSQ9EYODPiTHUwjSrw==
X-Google-Smtp-Source: AGHT+IEAOkJygRnR2vqgPJYGvM2ij3dPkOEY1847GvMuBNjDobmrg9H7RVPXArjHM2L2VMHZcYaZ+LYEV89MzQad9KQ=
X-Received: by 2002:a0c:9c0c:0:b0:68c:b646:acf7 with SMTP id
 v12-20020a0c9c0c000000b0068cb646acf7mr1354567qve.38.1707235010662; Tue, 06
 Feb 2024 07:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202145731.4082033-1-peter.griffin@linaro.org>
 <20240202145731.4082033-2-peter.griffin@linaro.org> <CAPLW+4=Cm36Q311Y7mCGgm+3fe5NNNc5XhNSMkbigTG2BVCTpA@mail.gmail.com>
In-Reply-To: <CAPLW+4=Cm36Q311Y7mCGgm+3fe5NNNc5XhNSMkbigTG2BVCTpA@mail.gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 6 Feb 2024 15:56:39 +0000
Message-ID: <CADrjBPqT=F+MALssnWsMa1E1RcPN7Sz8s+HfEZRU3pSgPO+z6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: arnd@arndb.de, krzysztof.kozlowski@linaro.org, linux@roeck-us.net, 
	wim@linux-watchdog.org, alim.akhtar@samsung.com, jaewon02.kim@samsung.com, 
	kernel-team@android.com, alexey.klimov@linaro.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-fsd@tesla.com, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Thanks for the great review feedback.

On Fri, 2 Feb 2024 at 17:35, Sam Protsenko <semen.protsenko@linaro.org> wro=
te:
>
> On Fri, Feb 2, 2024 at 8:57=E2=80=AFAM Peter Griffin <peter.griffin@linar=
o.org> wrote:
> >
> > Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> > security hardening reasons so that they are only write accessible in el=
3
> > via an SMC call.
> >
> > As most Exynos drivers that need to write PMU registers currently obtai=
n a
> > regmap via syscon (phys, pinctrl, watchdog). Support for the above usec=
ase
> > is implemented in this driver using a custom regmap similar to syscon t=
o
> > handle the SMC call. Platforms that don't secure PMU registers, get a m=
mio
> > regmap like before. As regmaps abstract out the underlying register acc=
ess
> > changes to the leaf drivers are minimal.
> >
> > A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drive=
rs
> > that currently use syscon_regmap_lookup_by_phandle(). This also handles
> > deferred probing.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> > Changes since v2
> >  - Add select REGMAP to Kconfig
> >  - Add constant for SET/CLEAR bits
> >  - Replace kerneldoc with one line comment
> >  - Fix kerneldoc for EXPORT_SYMBOL_GPL funcs
> >  - remove superflous extern keyword
> >  - dev_err_probe() on probe error
> >  - shorten regmcfg name
> >  - no compatibles inside probe, use match data
> >  - don't mix declarations with/without initializations
> >  - tensor_sec_reg_read() use mmio to avoid access restrictions
> >  - Collect up Reviewed-by
> >  - const for regmap_config structs
> > ---
> >  drivers/soc/samsung/Kconfig            |   1 +
> >  drivers/soc/samsung/exynos-pmu.c       | 233 ++++++++++++++++++++++++-
> >  drivers/soc/samsung/exynos-pmu.h       |   1 +
> >  include/linux/soc/samsung/exynos-pmu.h |  11 +-
> >  4 files changed, 241 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> > index 27ec99af77e3..1a5dfdc978dc 100644
> > --- a/drivers/soc/samsung/Kconfig
> > +++ b/drivers/soc/samsung/Kconfig
> > @@ -42,6 +42,7 @@ config EXYNOS_PMU
> >         depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> >         select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
> >         select MFD_CORE
> > +       select REGMAP_MMIO
> >
> >  # There is no need to enable these drivers for ARMv8
> >  config EXYNOS_PMU_ARM_DRIVERS
> > diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exy=
nos-pmu.c
> > index 250537d7cfd6..adf3549370d6 100644
> > --- a/drivers/soc/samsung/exynos-pmu.c
> > +++ b/drivers/soc/samsung/exynos-pmu.c
> > @@ -5,6 +5,7 @@
> >  //
> >  // Exynos - CPU PMU(Power Management Unit) support
> >
> > +#include <linux/arm-smccc.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/mfd/core.h>
> > @@ -12,19 +13,130 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/delay.h>
> > +#include <linux/regmap.h>
> >
> >  #include <linux/soc/samsung/exynos-regs-pmu.h>
> >  #include <linux/soc/samsung/exynos-pmu.h>
> >
> >  #include "exynos-pmu.h"
> >
> > +#define PMUALIVE_MASK GENMASK(14, 0)
>
> Are you sure it's not GENMASK(13, 0)?

Yes, you're right, mask should be 0x3fff.

> Because SET_BITS has bit #14
> set, which overlaps with bit #14 from PMUALIVE_MASK, when being added
> in tensor_set_bit_atomic().
>
> This also can be aligned with below definitions.

Will update alignment
>
> > +#define SET_BITS       0xc000
> > +#define CLEAR_BITS     0x8000
>
> All 3 above values seem to be gs101 specific. At least I can't find
> any similar atomic registers in Exynos850 TRM, in PMU block. So I'd
> suggest also adding TENSOR_ prefix to those to make it clear and to
> prevent possible naming conflicts in future.

Sure, I can add a Tensor prefix. Unfortunately these atomic registers
aren't mentioned anywhere in gs101 TRM's either, so it is a bit of a
nature study :( It was implemented and used in the downstream drivers
though (and doesn't look to be implemented downstream for exynos850,
so you're likely correct it doesn't have it.). I tried to check some
other downstream product tree's, I found the hardware looks to exist
on Exynos 9820 [1]. But I think we can update the name if somebody
tries to upstream that platform in the future.

[1] https://github.com/PixelOS-Devices/kernel_samsung_exynos9820/blob/thirt=
een/drivers/soc/samsung/exynos-pmu.c#L32

>
> Also, not sure if it makes things better, but FWIW:
>
>     #define CLEAR_BITS     BIT(15)
>     #define SET_BITS       (BIT(15) | BIT(14))

I agree that would make it clearer.

>
> Just to show that those two bits don't overlap with PMUALIVE_MASK (if
> it can be fixed to 13:0), and show their relation. If I understand
> correctly what's going on anyway.

I think you've understood what's happening here perfectly

>
> > +
> > +#define TENSOR_SMC_PMU_SEC_REG         0x82000504
> > +#define TENSOR_PMUREG_READ             0
> > +#define TENSOR_PMUREG_WRITE            1
> > +#define TENSOR_PMUREG_RMW              2
> > +
> >  struct exynos_pmu_context {
> >         struct device *dev;
> >         const struct exynos_pmu_data *pmu_data;
> > +       struct regmap *pmureg;
> >  };
> >
> >  void __iomem *pmu_base_addr;
> >  static struct exynos_pmu_context *pmu_context;
> > +static struct platform_driver exynos_pmu_driver;
>
> Just an idea: maybe add a comment saying it's a forward declaration,
> and the variable is assigned below, as it might be confusing. Not sure
> if it's worth it though.
>
> > +
> > +/*
> > + * Tensor SoCs are configured so that PMU_ALIVE registers can only be =
written
> > + * from EL3, but are still read accessible. As Linux needs to write so=
me of
> > + * these registers, the following functions are provided and exposed v=
ia
> > + * regmap.
> > + *
> > + * Note: This SMC interface is known to be implemented on gs101 and de=
rivative
> > + * SoCs.
> > + */
> > +
> > +/* Write to a protected PMU register. */
> > +static int tensor_sec_reg_write(void *base, unsigned int reg, unsigned=
 int val)
> > +{
> > +       struct arm_smccc_res res;
> > +       unsigned long pmu_base =3D (unsigned long)base;
> > +
> > +       arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
> > +                     TENSOR_PMUREG_WRITE, val, 0, 0, 0, 0, &res);
> > +
> > +       /* returns -EINVAL if access isn't allowed or 0 */
> > +       if (res.a0)
> > +               pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0=
);
> > +
> > +       return (int)res.a0;
> > +}
> > +
> > +/* Read/Modify/Write a protected PMU register. */
> > +static int tensor_sec_reg_rmw(void *base, unsigned int reg,
> > +                             unsigned int mask, unsigned int val)
> > +{
> > +       struct arm_smccc_res res;
> > +       unsigned long pmu_base =3D (unsigned long)base;
> > +
> > +       arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
> > +                     TENSOR_PMUREG_RMW, mask, val, 0, 0, 0, &res);
> > +
> > +       /* returns -EINVAL if access isn't allowed or 0*/
> > +       if (res.a0)
> > +               pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0=
);
> > +
> > +       return (int)res.a0;
> > +}
> > +
> > +/*
> > + * Read a protected PMU register. All PMU registers can be read by Lin=
ux.
> > + * Note: The SMC read register is not used, as only registers that can=
 be
> > + * written are readable via SMC.
> > + */
> > +static int tensor_sec_reg_read(void *base, unsigned int reg, unsigned =
int *val)
> > +{
> > +       *val =3D pmu_raw_readl(reg);
> > +       return 0;
> > +}
> > +
> > +/*
> > + * For SoCs that have set/clear bit hardware this function can be used=
 when
> > + * the PMU register will be accessed by multiple masters.
> > + *
> > + * For example, to set bits 13:8 in PMU reg offset 0x3e80
> > + * tensor_set_bit_atomic(0x3e80, 0x3f00, 0x3f00);
> > + *
> > + * To clear bits 13:8 in PMU offset 0x3e80
> > + * tensor_set_bit_atomic(0x3e80, 0x0, 0x3f00);
> > + */
> > +static inline int tensor_set_bit_atomic(void *ctx, unsigned int offset=
,
>
> set_bit -> set_bits?

Will change

>
> > +                                       u32 val, u32 mask)
> > +{
> > +       int ret;
> > +       unsigned int i;
> > +
> > +       for (i =3D 0; i < 32; i++) {
> > +               if (mask & BIT(i)) {
>
> Maybe replace it with:
>
>     if (!(mask & BIT(i)))
>         continue;
>
> to reduce the indentation level?

Will do

>
> > +                       if (val & BIT(i))
> > +                               offset |=3D SET_BITS;
> > +                       else
> > +                               offset |=3D CLEAR_BITS;
>
> What if someone calls this functions like this:
>
>     tensor_set_bit_atomic(0x3e80, 0x100, 0x3f00);
>
> which means "set bit #8, and clear bits 13:9). But because the offset
> variable will hold SET_BITS set during bit #8 handling, bits 13:9 are
> also going to be set, effectively making that call act like
> tensor_set_bit_atomic(0x3e80, 0x3f00, 0x3f00) instead. So I'd add
> something like:
>
>     offset &=3D ~SET_BITS;
>
> before doing |=3D operations.

Good catch! Will fix in v4

>
> > +
> > +                       ret =3D tensor_sec_reg_write(ctx, offset, i);
> > +                       if (ret)
> > +                               goto out;
>
> Maybe remove "out" and just do return ret here?

Will update

>
> > +               }
> > +       }
> > +out:
> > +       return ret;
> > +}
> > +
> > +static int tensor_sec_update_bits(void *ctx, unsigned int reg,
> > +                                 unsigned int mask, unsigned int val)
> > +{
> > +       /*
> > +        * Use atomic operations for PMU_ALIVE registers (offset 0~0x3F=
FF)
> > +        * as the target registers can be accessed by multiple masters.
> > +        */
> > +       if (reg > PMUALIVE_MASK)
> > +               return tensor_sec_reg_rmw(ctx, reg, mask, val);
> > +
> > +       return tensor_set_bit_atomic(ctx, reg, val, mask);
> > +}
> >
> >  void pmu_raw_writel(u32 val, u32 offset)
> >  {
> > @@ -75,11 +187,41 @@ void exynos_sys_powerdown_conf(enum sys_powerdown =
mode)
> >  #define exynos_pmu_data_arm_ptr(data)  NULL
> >  #endif
> >
> > +static const struct regmap_config regmap_smccfg =3D {
> > +       .name =3D "pmu_regs",
> > +       .reg_bits =3D 32,
> > +       .reg_stride =3D 4,
> > +       .val_bits =3D 32,
> > +       .fast_io =3D true,
> > +       .use_single_read =3D true,
> > +       .use_single_write =3D true,
> > +       .reg_read =3D tensor_sec_reg_read,
> > +       .reg_write =3D tensor_sec_reg_write,
> > +       .reg_update_bits =3D tensor_sec_update_bits,
> > +};
> > +
> > +static const struct regmap_config regmap_mmiocfg =3D {
> > +       .name =3D "pmu_regs",
> > +       .reg_bits =3D 32,
> > +       .reg_stride =3D 4,
> > +       .val_bits =3D 32,
> > +       .fast_io =3D true,
> > +       .use_single_read =3D true,
> > +       .use_single_write =3D true,
> > +};
> > +
> > +static const struct exynos_pmu_data gs101_pmu_data =3D {
> > +       .pmu_secure =3D true
> > +};
> > +
> >  /*
> >   * PMU platform driver and devicetree bindings.
> >   */
> >  static const struct of_device_id exynos_pmu_of_device_ids[] =3D {
> >         {
> > +               .compatible =3D "google,gs101-pmu",
> > +               .data =3D &gs101_pmu_data,
> > +       }, {
> >                 .compatible =3D "samsung,exynos3250-pmu",
> >                 .data =3D exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
> >         }, {
> > @@ -113,19 +255,73 @@ static const struct mfd_cell exynos_pmu_devs[] =
=3D {
> >         { .name =3D "exynos-clkout", },
> >  };
> >
> > +/**
> > + * exynos_get_pmu_regmap() - Obtain pmureg regmap
> > + *
> > + * Find the pmureg regmap previously configured in probe() and return =
regmap
> > + * pointer.
> > + *
> > + * Return: A pointer to regmap if found or ERR_PTR error value.
> > + */
> >  struct regmap *exynos_get_pmu_regmap(void)
> >  {
> >         struct device_node *np =3D of_find_matching_node(NULL,
> >                                                       exynos_pmu_of_dev=
ice_ids);
> >         if (np)
> > -               return syscon_node_to_regmap(np);
> > +               return exynos_get_pmu_regmap_by_phandle(np, NULL);
> >         return ERR_PTR(-ENODEV);
> >  }
> >  EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
> >
> > +/**
> > + * exynos_get_pmu_regmap_by_phandle() - Obtain pmureg regmap via phand=
le
> > + * @np: Pointer to device's Device Tree node
> > + * @property: Device Tree property name which references the pmu
> > + *
> > + * Find the pmureg regmap previously configured in probe() and return =
regmap
> > + * pointer.
> > + *
> > + * Return: A pointer to regmap if found or ERR_PTR error value.
> > + */
> > +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np=
,
> > +                                               const char *property)
> > +{
> > +       struct device *dev;
> > +       struct exynos_pmu_context *ctx;
> > +       struct device_node *pmu_np;
> > +
> > +       if (property)
> > +               pmu_np =3D of_parse_phandle(np, property, 0);
> > +       else
> > +               pmu_np =3D np;
> > +
> > +       if (!pmu_np)
> > +               return ERR_PTR(-ENODEV);
> > +
> > +       /*
> > +        * Determine if exynos-pmu device has probed and therefore regm=
ap
> > +        * has been created and can be returned to the caller. Otherwis=
e we
> > +        * return -EPROBE_DEFER.
> > +        */
> > +       dev =3D driver_find_device_by_of_node(&exynos_pmu_driver.driver=
,
> > +                                           (void *)pmu_np);
> > +
> > +       of_node_put(pmu_np);
> > +       if (!dev)
> > +               return ERR_PTR(-EPROBE_DEFER);
> > +
> > +       ctx =3D dev_get_drvdata(dev);
> > +
> > +       return ctx->pmureg;
> > +}
> > +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> > +
> >  static int exynos_pmu_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev =3D &pdev->dev;
> > +       struct regmap_config pmu_regmcfg;
> > +       struct regmap *regmap;
> > +       struct resource *res;
> >         int ret;
> >
> >         pmu_base_addr =3D devm_platform_ioremap_resource(pdev, 0);
> > @@ -133,13 +329,42 @@ static int exynos_pmu_probe(struct platform_devic=
e *pdev)
> >                 return PTR_ERR(pmu_base_addr);
> >
> >         pmu_context =3D devm_kzalloc(&pdev->dev,
> > -                       sizeof(struct exynos_pmu_context),
> > -                       GFP_KERNEL);
> > +                                  sizeof(struct exynos_pmu_context),
> > +                                  GFP_KERNEL);
> >         if (!pmu_context)
> >                 return -ENOMEM;
> > -       pmu_context->dev =3D dev;
> > +
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res)
> > +               return -ENODEV;
> > +
> >         pmu_context->pmu_data =3D of_device_get_match_data(dev);
> >
> > +       /* For SoCs that secure PMU register writes use custom regmap *=
/
> > +       if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_secure)=
 {
> > +               pmu_regmcfg =3D regmap_smccfg;
> > +               pmu_regmcfg.max_register =3D resource_size(res) -
> > +                                          pmu_regmcfg.reg_stride;
> > +               /* Need physical address for SMC call */
> > +               regmap =3D devm_regmap_init(dev, NULL,
> > +                                         (void *)(uintptr_t)res->start=
,
> > +                                         &pmu_regmcfg);
> > +       } else {
> > +               /* all other SoCs use a MMIO regmap */
>
> Suggest starting with a capital letter, for consistency with previous com=
ments.

Will update

>
> > +               pmu_regmcfg =3D regmap_mmiocfg;
> > +               pmu_regmcfg.max_register =3D resource_size(res) -
> > +                                          pmu_regmcfg.reg_stride;
> > +               regmap =3D devm_regmap_init_mmio(dev, pmu_base_addr,
> > +                                              &pmu_regmcfg);
> > +       }
> > +
> > +       if (IS_ERR(regmap))
> > +               dev_err_probe(&pdev->dev, PTR_ERR(regmap),
> > +                             "regmap init failed\n");
>
> Why not "return dev_err_probe()"? Is it ok to continue with no regmap cre=
ated?

That should have been return dev_err_probe. Will fix

Peter



>
> > +
> > +       pmu_context->pmureg =3D regmap;
> > +       pmu_context->dev =3D dev;
> > +
> >         if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_init)
> >                 pmu_context->pmu_data->pmu_init();
> >
> > diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exy=
nos-pmu.h
> > index 1c652ffd79b4..0a49a2c9a08e 100644
> > --- a/drivers/soc/samsung/exynos-pmu.h
> > +++ b/drivers/soc/samsung/exynos-pmu.h
> > @@ -21,6 +21,7 @@ struct exynos_pmu_conf {
> >  struct exynos_pmu_data {
> >         const struct exynos_pmu_conf *pmu_config;
> >         const struct exynos_pmu_conf *pmu_config_extra;
> > +       bool pmu_secure;
> >
> >         void (*pmu_init)(void);
> >         void (*powerdown_conf)(enum sys_powerdown);
> > diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc=
/samsung/exynos-pmu.h
> > index a4f5516cc956..406ed73614fd 100644
> > --- a/include/linux/soc/samsung/exynos-pmu.h
> > +++ b/include/linux/soc/samsung/exynos-pmu.h
> > @@ -20,12 +20,21 @@ enum sys_powerdown {
> >
> >  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
> >  #ifdef CONFIG_EXYNOS_PMU
> > -extern struct regmap *exynos_get_pmu_regmap(void);
> > +struct regmap *exynos_get_pmu_regmap(void);
> > +
>
> Usually empty line delimeter is not needed in cases like that.
>
> > +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np=
,
> > +                                               const char *property);
> >  #else
> >  static inline struct regmap *exynos_get_pmu_regmap(void)
> >  {
> >         return ERR_PTR(-ENODEV);
> >  }
> > +
> > +static inline struct regmap *exynos_get_pmu_regmap_by_phandle(struct d=
evice_node *np,
> > +                                                             const cha=
r *property)
> > +{
> > +       return ERR_PTR(-ENODEV);
> > +}
> >  #endif
> >
> >  #endif /* __LINUX_SOC_EXYNOS_PMU_H */
> > --
> > 2.43.0.594.gd9cf4e227d-goog
> >

