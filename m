Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5677CAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjHOJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjHOJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC240BF;
        Tue, 15 Aug 2023 02:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6038861760;
        Tue, 15 Aug 2023 09:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256ACC433C8;
        Tue, 15 Aug 2023 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692092485;
        bh=whzHuwDSvMP0wPp8LOQHBWqUHBv5rjif4ltJhn5pelo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m3Uh6ScHM+zqNA8OJuDtj5SxeR/Lvv3PZIxgUmG8+MFTgZslWYMvat2RKHRrWO4Hc
         g0ZGsXQzruNpltlx/KgIXHaBFf1cm4YgC/v/5DYtZoeatDmymRQxxT2dsbYa8pQoiG
         JJD96CCWvZKD1Yx/IawYpTQ8W4EqPKVzPLzhH+8VWKVA36PlzC5BV4C1kJV5UudMMU
         6SUVgxTkPdehnn65amzpyFRYl0Yjr6JVT850o35dM6qog5rmzbg1jjzzzu/GeMqTur
         aIGwAVHxExPNIN94HRLeKtftHxXK8Sr6jwVxtEBctL+afUDT7K99CRE1sBT5EFHVez
         A7+RWaEesf4JQ==
Message-ID: <a626c351-2c9b-1136-c31c-63cd695d9499@kernel.org>
Date:   Tue, 15 Aug 2023 12:41:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/5] net: ti: icss-iep: Add IEP driver
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230814100847.3531480-1-danishanwar@ti.com>
 <20230814100847.3531480-4-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230814100847.3531480-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danish,

On 14/08/2023 13:08, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ethernet ports.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/Kconfig          |  11 +
>  drivers/net/ethernet/ti/Makefile         |   1 +
>  drivers/net/ethernet/ti/icssg/icss_iep.c | 921 +++++++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icss_iep.h |  38 +
>  4 files changed, 971 insertions(+)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 63e510b6860f..1af5a90720ec 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -196,4 +196,15 @@ config TI_ICSSG_PRUETH
>  	  to support the Ethernet operation. Currently, it supports Ethernet
>  	  with 1G and 100M link speed.
>  
> +config TI_ICSS_IEP
> +	tristate "TI PRU ICSS IEP driver"
> +	depends on TI_PRUSS
> +	default TI_PRUSS
> +	help
> +	  This driver enables support for the PRU-ICSS Industrial Ethernet
> +	  Peripheral within a PRU-ICSS subsystem present on various TI SoCs.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called icss_iep.
> +
>  endif # NET_VENDOR_TI
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 9176d79c36e1..34fd7a716ba6 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -38,3 +38,4 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
>  		  icssg/icssg_mii_cfg.o \
>  		  icssg/icssg_stats.o \
>  		  icssg/icssg_ethtool.o
> +obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> new file mode 100644
> index 000000000000..d123b8ba3f31
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -0,0 +1,921 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Texas Instruments ICSSG Industrial Ethernet Peripheral (IEP) Driver
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com
> + *
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/timekeeping.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
> +
> +#include "icss_iep.h"
> +
> +#define IEP_MAX_DEF_INC		0xf
> +#define IEP_MAX_COMPEN_INC		0xfff
> +#define IEP_MAX_COMPEN_COUNT	0xffffff
> +
> +#define IEP_GLOBAL_CFG_CNT_ENABLE	BIT(0)
> +#define IEP_GLOBAL_CFG_DEFAULT_INC_MASK		GENMASK(7, 4)
> +#define IEP_GLOBAL_CFG_DEFAULT_INC_SHIFT	4
> +#define IEP_GLOBAL_CFG_COMPEN_INC_MASK		GENMASK(19, 8)
> +#define IEP_GLOBAL_CFG_COMPEN_INC_SHIFT		8
> +
> +#define IEP_GLOBAL_STATUS_CNT_OVF	BIT(0)
> +
> +#define IEP_CMP_CFG_SHADOW_EN		BIT(17)
> +#define IEP_CMP_CFG_CMP0_RST_CNT_EN	BIT(0)
> +#define IEP_CMP_CFG_CMP_EN(cmp)		(GENMASK(16, 1) & (1 << ((cmp) + 1)))
> +
> +#define IEP_CMP_STATUS(cmp)		(1 << (cmp))
> +
> +#define IEP_SYNC_CTRL_SYNC_EN		BIT(0)
> +#define IEP_SYNC_CTRL_SYNC_N_EN(n)	(GENMASK(2, 1) & (BIT(1) << (n)))
> +
> +#define IEP_MIN_CMP	0
> +#define IEP_MAX_CMP	15
> +
> +#define ICSS_IEP_64BIT_COUNTER_SUPPORT		BIT(0)
> +#define ICSS_IEP_SLOW_COMPEN_REG_SUPPORT	BIT(1)
> +#define ICSS_IEP_SHADOW_MODE_SUPPORT		BIT(2)
> +
> +#define LATCH_INDEX(ts_index)			((ts_index) + 6)
> +#define IEP_CAP_CFG_CAPNR_1ST_EVENT_EN(n)	BIT(LATCH_INDEX(n))
> +#define IEP_CAP_CFG_CAP_ASYNC_EN(n)		BIT(LATCH_INDEX(n) + 10)
> +
> +enum {
> +	ICSS_IEP_GLOBAL_CFG_REG,
> +	ICSS_IEP_GLOBAL_STATUS_REG,
> +	ICSS_IEP_COMPEN_REG,
> +	ICSS_IEP_SLOW_COMPEN_REG,
> +	ICSS_IEP_COUNT_REG0,
> +	ICSS_IEP_COUNT_REG1,
> +	ICSS_IEP_CAPTURE_CFG_REG,
> +	ICSS_IEP_CAPTURE_STAT_REG,
> +
> +	ICSS_IEP_CAP6_RISE_REG0,
> +	ICSS_IEP_CAP6_RISE_REG1,
> +
> +	ICSS_IEP_CAP7_RISE_REG0,
> +	ICSS_IEP_CAP7_RISE_REG1,
> +
> +	ICSS_IEP_CMP_CFG_REG,
> +	ICSS_IEP_CMP_STAT_REG,
> +	ICSS_IEP_CMP0_REG0,
> +	ICSS_IEP_CMP0_REG1,
> +	ICSS_IEP_CMP1_REG0,
> +	ICSS_IEP_CMP1_REG1,
> +
> +	ICSS_IEP_CMP8_REG0,
> +	ICSS_IEP_CMP8_REG1,
> +	ICSS_IEP_SYNC_CTRL_REG,
> +	ICSS_IEP_SYNC0_STAT_REG,
> +	ICSS_IEP_SYNC1_STAT_REG,
> +	ICSS_IEP_SYNC_PWIDTH_REG,
> +	ICSS_IEP_SYNC0_PERIOD_REG,
> +	ICSS_IEP_SYNC1_DELAY_REG,
> +	ICSS_IEP_SYNC_START_REG,
> +	ICSS_IEP_MAX_REGS,
> +};
> +
> +/**
> + * struct icss_iep_plat_data - Plat data to handle SoC variants
> + * @config: Regmap configuration data
> + * @reg_offs: register offsets to capture offset differences across SoCs
> + * @flags: Flags to represent IEP properties
> + */
> +struct icss_iep_plat_data {
> +	struct regmap_config *config;
> +	u32 reg_offs[ICSS_IEP_MAX_REGS];
> +	u32 flags;
> +};
> +
> +struct icss_iep {
> +	struct device *dev;
> +	void __iomem *base;
> +	const struct icss_iep_plat_data *plat_data;
> +	struct regmap *map;
> +	struct device_node *client_np;
> +	unsigned long refclk_freq;
> +	int clk_tick_time;	/* one refclk tick time in ns */
> +	struct ptp_clock_info ptp_info;
> +	struct ptp_clock *ptp_clock;
> +	struct mutex ptp_clk_mutex;	/* PHC access serializer */
> +	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
> +	u32 def_inc;
> +	s16 slow_cmp_inc;
> +	u32 slow_cmp_count;
> +	const struct icss_iep_clockops *ops;
> +	void *clockops_data;
> +	u32 cycle_time_ns;
> +	u32 perout_enabled;
> +	bool pps_enabled;
> +	int cap_cmp_irq;
> +	u64 period;
> +	u32 latch_enable;
> +};
> +

Where is the comment you agreed to add on why we are using readl/writel
instead of regmap in certain areas?

> +/**
> + * icss_iep_get_count_hi() - Get the upper 32 bit IEP counter
> + * @iep: Pointer to structure representing IEP.
> + *
> + * Return: upper 32 bit IEP counter
> + */
> +int icss_iep_get_count_hi(struct icss_iep *iep)
> +{
> +	u32 val = 0;
> +
> +	if (iep && (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT))
> +		val = readl(iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG1]);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(icss_iep_get_count_hi);
> +
> +/**
> + * icss_iep_get_count_low() - Get the lower 32 bit IEP counter
> + * @iep: Pointer to structure representing IEP.
> + *
> + * Return: lower 32 bit IEP counter
> + */
> +int icss_iep_get_count_low(struct icss_iep *iep)
> +{
> +	u32 val = 0;
> +
> +	if (iep)
> +		val = readl(iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(icss_iep_get_count_low);
> +
> +/**
> + * icss_iep_get_ptp_clock_idx() - Get PTP clock index using IEP driver
> + * @iep: Pointer to structure representing IEP.
> + *
> + * Return: PTP clock index, -1 if not registered
> + */
> +int icss_iep_get_ptp_clock_idx(struct icss_iep *iep)
> +{
> +	if (!iep || !iep->ptp_clock)
> +		return -1;
> +	return ptp_clock_index(iep->ptp_clock);
> +}
> +EXPORT_SYMBOL_GPL(icss_iep_get_ptp_clock_idx);
> +
> +static void icss_iep_set_counter(struct icss_iep *iep, u64 ns)
> +{
> +	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
> +		writel(upper_32_bits(ns), iep->base +
> +		       iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG1]);
> +	writel(upper_32_bits(ns), iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
> +}
> +
> +static void icss_iep_update_to_next_boundary(struct icss_iep *iep, u64 start_ns);
> +
> +static void icss_iep_settime(struct icss_iep *iep, u64 ns)
> +{
> +	unsigned long flags;
> +
> +	if (iep->ops && iep->ops->settime) {
> +		iep->ops->settime(iep->clockops_data, ns);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&iep->irq_lock, flags);
> +	if (iep->pps_enabled || iep->perout_enabled)
> +		writel(0, iep->base + iep->plat_data->reg_offs[ICSS_IEP_SYNC_CTRL_REG]);
> +
> +	icss_iep_set_counter(iep, ns);
> +
> +	if (iep->pps_enabled || iep->perout_enabled) {
> +		icss_iep_update_to_next_boundary(iep, ns);
> +		writel(IEP_SYNC_CTRL_SYNC_N_EN(0) | IEP_SYNC_CTRL_SYNC_EN,
> +		       iep->base + iep->plat_data->reg_offs[ICSS_IEP_SYNC_CTRL_REG]);
> +	}
> +	spin_unlock_irqrestore(&iep->irq_lock, flags);
> +}
> +
> +static u64 icss_iep_gettime(struct icss_iep *iep,
> +			    struct ptp_system_timestamp *sts)
> +{
> +	u32 ts_hi = 0, ts_lo;
> +	unsigned long flags;
> +
> +	if (iep->ops && iep->ops->gettime)
> +		return iep->ops->gettime(iep->clockops_data, sts);
> +
> +	/* use local_irq_x() to make it work for both RT/non-RT */
> +	local_irq_save(flags);
> +
> +	/* no need to play with hi-lo, hi is latched when lo is read */
> +	ptp_read_system_prets(sts);
> +	ts_lo = readl(iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
> +	ptp_read_system_postts(sts);
> +	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
> +		ts_hi = readl(iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG1]);
> +
> +	local_irq_restore(flags);
> +
> +	return (u64)ts_lo | (u64)ts_hi << 32;
> +}
> +
> +static void icss_iep_enable(struct icss_iep *iep)
> +{
> +	regmap_update_bits(iep->map, ICSS_IEP_GLOBAL_CFG_REG,
> +			   IEP_GLOBAL_CFG_CNT_ENABLE,
> +			   IEP_GLOBAL_CFG_CNT_ENABLE);
> +}
> +
<snip>

-- 
cheers,
-roger
