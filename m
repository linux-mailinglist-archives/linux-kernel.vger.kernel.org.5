Return-Path: <linux-kernel+bounces-1499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A6814F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDBC9B23436
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D75B30137;
	Fri, 15 Dec 2023 18:01:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215830123;
	Fri, 15 Dec 2023 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9fdbcec6eso759135a34.1;
        Fri, 15 Dec 2023 10:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702663289; x=1703268089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwhfhLoea/LkKgoi0mLBe9P7KahaQu7FDHdJKf8LJgU=;
        b=SIGvPVDDSczR85hhSWYilY9erlx4VI5L0sPbdczmU2vhTjFXxjo80QVj5MYU8MqWDM
         Ggztts14DLriQFxUnTyArQHdxj/hcavTKRwK1CGje/DKLbojx9nNurw/JoacoSO3BWLw
         SyOhLWIYE26Wm3NlNTrA1xvKOIeUmH8TSzKWMHF7l7Mtxh83CSgOpJikTHu/4ut2Hr5A
         cAcdqD2RBVG8wz87Lw7vBdBmKFZZINIS3yWCQChFqkvL3qWlieOMDj0cbNQbBN6iF6Z7
         9//RX4JdgieU64xEa7Ng2tsE6A43pDGx/NM//mQwmUkbFkjw4nx0nk3NWpOlhhhY8Np6
         CmjQ==
X-Gm-Message-State: AOJu0YyLoOBDLvseVZMuVy8hxCZGemnXOMJacQAJoy5ehCCGrjxmajPa
	F1Ae0wFxuxnKvf1R7un6kSsi/ex/0A==
X-Google-Smtp-Source: AGHT+IFBVtSlNj4mEdxRUTvAkzNHT26WzYQ91wVxCFvuBV9Wksc+Fbs0T/BWPQFC8ecIzZAV0zpmkw==
X-Received: by 2002:a9d:7a94:0:b0:6d8:74e2:6f32 with SMTP id l20-20020a9d7a94000000b006d874e26f32mr9226013otn.46.1702663289382;
        Fri, 15 Dec 2023 10:01:29 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y7-20020a056830108700b006d811e1d91dsm3628236oto.72.2023.12.15.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 10:01:28 -0800 (PST)
Received: (nullmailer pid 74784 invoked by uid 1000);
	Fri, 15 Dec 2023 18:01:27 -0000
Date: Fri, 15 Dec 2023 12:01:27 -0600
From: Rob Herring <robh@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, gregory.clement@bootlin.com, chris.packham@alliedtelesis.co.nz, andrew@lunn.ch, fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, al.stone@linaro.org, timur@codeaurora.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cyuval@marvell.com
Subject: Re: [PATCH 3/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Message-ID: <20231215180127.GB52386-robh@kernel.org>
References: <20231214150414.1849058-1-enachman@marvell.com>
 <20231214150414.1849058-4-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214150414.1849058-4-enachman@marvell.com>

On Thu, Dec 14, 2023 at 05:04:14PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add support for Marvell ac5/x variant of the ARM
> sbsa global watchdog. This watchdog deviates from
> the standard driver by the following items:
> 
> 1. Registers reside in secure register section.
>    hence access is only possible via SMC calls to ATF.
> 
> 2. There are couple more registers which reside in
>    other register areas, which needs to be configured
>    in order for the watchdog to properly generate
>    reset through the SOC.
> 
> The new Marvell compatibility string differentiates between
> the original sbsa mode of operation and the Marvell mode of
> operation.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/watchdog/sbsa_gwdt.c | 247 ++++++++++++++++++++++++++++++++---

That's more than half the existing driver...

>  1 file changed, 226 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 5f23913ce3b4..0bc6f53f0968 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -46,10 +46,13 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/uaccess.h>
>  #include <linux/watchdog.h>
>  #include <asm/arch_timer.h>
> +#include <linux/arm-smccc.h>
>  
>  #define DRV_NAME		"sbsa-gwdt"
>  #define WATCHDOG_NAME		"SBSA Generic Watchdog"
> @@ -75,6 +78,68 @@
>  #define SBSA_GWDT_VERSION_MASK  0xF
>  #define SBSA_GWDT_VERSION_SHIFT 16
>  
> +/* Marvell AC5/X SMCs, taken from arm trusted firmware */
> +#define SMC_FID_READ_REG	0x80007FFE
> +#define SMC_FID_WRITE_REG	0x80007FFD
> +
> +/* Marvell registers offsets: */
> +#define SBSA_GWDT_MARVELL_CPU_WD_RST_EN_REG	0x30
> +#define SBSA_GWDT_MARVELL_MNG_ID_REG		0x4C
> +#define SBSA_GWDT_MARVELL_RST_CTRL_REG		0x0C
> +
> +#define SBSA_GWDT_MARVELL_ID_MASK	GENMASK(19, 12)
> +#define SBSA_GWDT_MARVELL_AC5_ID	0xB4000
> +#define SBSA_GWDT_MARVELL_AC5X_ID	0x98000
> +#define SBSA_GWDT_MARVELL_IML_ID	0xA0000
> +#define SBSA_GWDT_MARVELL_IMM_ID	0xA2000
> +
> +#define SBSA_GWDT_MARVELL_AC5_RST_UNIT_WD_BIT		BIT(6)
> +/* The following applies to AC5X, IronMan L and M: */
> +#define SBSA_GWDT_MARVELL_IRONMAN_RST_UNIT_WD_BIT	BIT(7)
> +
> +/*
> + * Action to perform after watchdog gets WS1 (watchdog signal 1) interrupt
> + * PWD = Private Watchdog, GWD - Global Watchdog, mpp - multi purpose pin
> + *
> + * 0 = Enable  1 = Disable (Default)
> + *
> + * BIT  0: CPU 0 reset by PWD 0
> + * BIT  1: CPU 1 reset by PWD 1
> + * BIT  2: CPU 0 reset by GWD
> + * BIT  3: CPU 1 reset by GWD
> + * BIT  4: PWD 0 sys reset out
> + * BIT  5: PWD 1 sys reset out
> + * BIT  6: GWD sys reset out
> + * BIT  7: Reserved
> + * BIT  8: PWD 0 mpp reset out
> + * BIT  9: PWD 1 mpp reset out
> + * BIT 10: GWD mpp reset out
> + *
> + */
> +#define SBSA_GWDT_MARVELL_RST_CPU0_BY_PWD0	BIT(0)
> +#define SBSA_GWDT_MARVELL_RST_CPU1_BY_PWD1	BIT(1)
> +#define SBSA_GWDT_MARVELL_RST_CPU0_BY_GWD	BIT(2)
> +#define SBSA_GWDT_MARVELL_RST_CPU1_BY_GWD	BIT(3)
> +#define SBSA_GWDT_MARVELL_RST_SYSRST_BY_PWD0	BIT(4)
> +#define SBSA_GWDT_MARVELL_RST_SYSRST_BY_PWD1	BIT(5)
> +#define SBSA_GWDT_MARVELL_RST_SYSRST_BY_GWD	BIT(6)
> +#define SBSA_GWDT_MARVELL_RST_RESERVED		BIT(7)
> +#define SBSA_GWDT_MARVELL_RST_MPP_BY_PWD0	BIT(8)
> +#define SBSA_GWDT_MARVELL_RST_MPP_BY_PWD1	BIT(9)
> +#define SBSA_GWDT_MARVELL_RST_MPP_BY_GWD	BIT(10)
> +
> +/**
> + * struct sbsa_gwdt_regs_ops - ops for register read/write, depending on SOC
> + * @reg_read:			register read ops function
> + * @read_write:			register write ops function
> + */
> +struct sbsa_gwdt_regs_ops {
> +	u32 (*reg_read32)(void __iomem *ptr);
> +	__u64 (*reg_read64)(void __iomem *ptr);
> +	void (*reg_write32)(u32 val, void __iomem *ptr);
> +	void (*reg_write64)(__u64 val, void __iomem *ptr);
> +};
> +
>  /**
>   * struct sbsa_gwdt - Internal representation of the SBSA GWDT
>   * @wdd:		kernel watchdog_device structure
> @@ -89,6 +154,7 @@ struct sbsa_gwdt {
>  	int			version;
>  	void __iomem		*refresh_base;
>  	void __iomem		*control_base;
> +	const struct sbsa_gwdt_regs_ops *soc_reg_ops;
>  };
>  
>  #define DEFAULT_TIMEOUT		10 /* seconds */
> @@ -116,6 +182,91 @@ MODULE_PARM_DESC(nowayout,
>  		 "Watchdog cannot be stopped once started (default="
>  		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +/*
> + * By default, have the Global watchdog cause System Reset:
> + */
> +static unsigned int reset = 0xFFFFFFFF ^ SBSA_GWDT_MARVELL_RST_SYSRST_BY_GWD;
> +module_param(reset, uint, 0);
> +MODULE_PARM_DESC(reset, "Action to perform after watchdog gets WS1 interrupt");
> +
> +/*
> + * Marvell AC5/X use SMC, while others use direct register access
> + */
> +static u32 sbsa_gwdt_smc_readl(void __iomem *addr)
> +{
> +	struct arm_smccc_res smc_res;
> +
> +	arm_smccc_smc(SMC_FID_READ_REG, (unsigned long)addr,
> +		      0, 0, 0, 0, 0, 0, &smc_res);
> +	return (u32)smc_res.a0;
> +}
> +
> +static void sbsa_gwdt_smc_writel(u32 val, void __iomem *addr)
> +{
> +	struct arm_smccc_res smc_res;
> +
> +	arm_smccc_smc(SMC_FID_WRITE_REG, (unsigned long)addr,
> +		      (unsigned long)val, 0, 0, 0, 0, 0, &smc_res);
> +}
> +
> +static inline u64 sbsa_gwdt_lo_hi_smc_readq(void __iomem *addr)
> +{
> +	u32 low, high;
> +
> +	low = sbsa_gwdt_smc_readl(addr);
> +	high = sbsa_gwdt_smc_readl(addr + 4);
> +	/* read twice, as a workaround to HW limitation */
> +	low = sbsa_gwdt_smc_readl(addr);
> +
> +	return low + ((u64)high << 32);
> +}
> +
> +static inline void sbsa_gwdt_lo_hi_smc_writeq(__u64 val, void __iomem *addr)
> +{
> +	u32 low, high;
> +
> +	low = val & 0xffffffff;
> +	high = val >> 32;
> +	sbsa_gwdt_smc_writel(low, addr);
> +	sbsa_gwdt_smc_writel(high, addr + 4);
> +	/* write twice, as a workaround to HW limitation */
> +	sbsa_gwdt_smc_writel(low, addr);
> +}
> +
> +static u32 sbsa_gwdt_direct_reg_readl(void __iomem *addr)
> +{
> +	return readl(addr);
> +}
> +
> +static void sbsa_gwdt_direct_reg_writel(u32 val, void __iomem *addr)
> +{
> +	writel(val, addr);
> +}
> +
> +static inline u64 sbsa_gwdt_lo_hi_direct_readq(void __iomem *addr)
> +{
> +	return lo_hi_readq(addr);
> +}
> +
> +static inline void sbsa_gwdt_lo_hi_direct_writeq(__u64 val, void __iomem *addr)
> +{
> +	lo_hi_writeq(val, addr);
> +}
> +
> +static const struct sbsa_gwdt_regs_ops smc_reg_ops = {
> +	.reg_read32 = sbsa_gwdt_smc_readl,
> +	.reg_read64 = sbsa_gwdt_lo_hi_smc_readq,
> +	.reg_write32 = sbsa_gwdt_smc_writel,
> +	.reg_write64 = sbsa_gwdt_lo_hi_smc_writeq
> +};
> +
> +static const struct sbsa_gwdt_regs_ops direct_reg_ops = {
> +	.reg_read32 = sbsa_gwdt_direct_reg_readl,
> +	.reg_read64 = sbsa_gwdt_lo_hi_direct_readq,
> +	.reg_write32 = sbsa_gwdt_direct_reg_writel,
> +	.reg_write64 = sbsa_gwdt_lo_hi_smc_writeq
> +};

The watchdog_ops are already practically not much more than a register 
read or write. Do we really need 2 levels of ops here?

> +
>  /*
>   * Arm Base System Architecture 1.0 introduces watchdog v1 which
>   * increases the length watchdog offset register to 48 bits.
> @@ -127,17 +278,17 @@ MODULE_PARM_DESC(nowayout,
>  static u64 sbsa_gwdt_reg_read(struct sbsa_gwdt *gwdt)
>  {
>  	if (gwdt->version == 0)
> -		return readl(gwdt->control_base + SBSA_GWDT_WOR);
> +		return gwdt->soc_reg_ops->reg_read32(gwdt->control_base + SBSA_GWDT_WOR);
>  	else
> -		return lo_hi_readq(gwdt->control_base + SBSA_GWDT_WOR);
> +		return gwdt->soc_reg_ops->reg_read64(gwdt->control_base + SBSA_GWDT_WOR);
>  }

Here we already have a different way to abstract register accesses. 
Probably should have something that works for all 3 cases...

Rob

