Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5973F76DF10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHCDiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjHCDhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:37:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12134272C;
        Wed,  2 Aug 2023 20:37:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc411e9d17so1910045ad.0;
        Wed, 02 Aug 2023 20:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691033872; x=1691638672;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mdGCKhX+XxMeJU2vDp/nc8nHyYwKB/o47/pfafRdZ7o=;
        b=qLC1Q8ChVAecnF24Av1CKhQB8tDTuhq+scLQ7RuvORD3uKskatIYq/U5Q/g+aWmetp
         46q3/2dh19Z3e2wiM1963uYCP8okQ476gOSMvhbaSin5hFO7Z0XQv8wXlLRzonCHcKpR
         gtaimbuPNlsYiFbv4Op7XgbLU4/VNDHwYL6xXj/gPkFeB2Z8EvARM/yfbJrkU4CSFBU+
         ugEVJZrwzrpULxveUyf5L6GFPN0z0+573L22HFx358fi2JZt2I00q+QA0m9bs2U+bMyO
         tPT9W4+D9j3YyDifguW9lORrX4oHFYYVspNgsbBeWAyZm2HqN3/MaBhlAhCIVDXos4aB
         sJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033872; x=1691638672;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdGCKhX+XxMeJU2vDp/nc8nHyYwKB/o47/pfafRdZ7o=;
        b=C8bghAoSBv3/LShJdXaIUG6w+er7MpJBb6Yii33IN3ZjTQVVW7uGA4S3sqrlv9QWJO
         5JQA3y8bmS5WtU99757uSqpNGmzpsd7GYSfmfoLaiW0l0zZpIdYq44T1GFaTniCQXbDO
         gNJVyD/mN/vgzCn4L1OKa2U7LE/bT8ARAhtzqdGfAUceGzu875cMu2BQp9aSqNDae1NZ
         +cqKdmgdDlJYb/HHbLuw/KtZKEQh84bKYWBcBVRdXa4PpKEQCaGhn+oQ1MPL8y7t+LDH
         DCROEqoW9ytSCPGp3dijG7qkY1RC2kCRkibFmlCOD4wR/sKS9kgBpaVUq01VTPC2eFRB
         Oq/A==
X-Gm-Message-State: ABy/qLZFRrH8xYD/8GW97Fp3+xHqzpqnnyp/V28dWrC5+sDCbpHO8z1a
        Eh2NEq3w4yUHDIt1A/ysyf8=
X-Google-Smtp-Source: APBJJlF9s4cprP58kx0tCJ9xoadHh0CXxfseI7+zn6sUOgp3TMvMXQdI6ZtkFpnZZHWoS6FzrzefPQ==
X-Received: by 2002:a17:902:b60a:b0:1a6:74f6:fa92 with SMTP id b10-20020a170902b60a00b001a674f6fa92mr15942742pls.19.1691033872227;
        Wed, 02 Aug 2023 20:37:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001bba1188c8esm13125570plb.271.2023.08.02.20.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 20:37:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3676c868-3987-f424-5b37-636d8a347a55@roeck-us.net>
Date:   Wed, 2 Aug 2023 20:37:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2 v11] Watchdog: Add marvell GTI watchdog driver
Content-Language: en-US
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com
References: <20230803032523.6242-1-bbhushan2@marvell.com>
 <20230803032523.6242-2-bbhushan2@marvell.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230803032523.6242-2-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 20:25, Bharat Bhushan wrote:
> This patch add support for Marvell GTI watchdog.  Global timer
> unit (GTI) support hardware watchdog timer. Software programs
> watchdog timer to generate interrupt on first timeout, second
> timeout is configured to be ignored and system reboots on
> third timeout.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v11:
>   - Kconfig: help text indentation to have two spaces
>              One minor correction in help description
> 
> v10:
>   - Added MODULE_LICENSE
> 
> v9:
>   - include header files is alphabetic order
>   - using BIT_ULL for bit shifts in macros
>   - using devm_clk_get_enabled() rather than
>     devm_clk_get() and clk_prepare_enable()
>   - compatibles as per dt-binding changes
> 
> v8:
>    - Compatible names as per soc names
>    - This driver run on ARM64 based architecture, Added 64BIT config
>      dependency to avoid compilation error related to readq/writeq on
>      32 as platform (Hexagon)
> 
>   drivers/watchdog/Kconfig           |  13 ++
>   drivers/watchdog/Makefile          |   1 +
>   drivers/watchdog/marvell_gti_wdt.c | 340 +++++++++++++++++++++++++++++
>   3 files changed, 354 insertions(+)
>   create mode 100644 drivers/watchdog/marvell_gti_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ee97d89dfc11..a23f7a0168e0 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1797,6 +1797,19 @@ config OCTEON_WDT
>   	  from the first interrupt, it is then only poked when the
>   	  device is written.
>   
> +config MARVELL_GTI_WDT
> +	tristate "Marvell GTI Watchdog driver"
> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> +	default y
> +	select WATCHDOG_CORE
> +	help
> +	  Marvell GTI hardware supports watchdog timer. First timeout
> +	  works as watchdog pretimeout and installed interrupt handler
> +	  will be called on first timeout. Hardware can generate interrupt
> +	  to SCP on second timeout but it is not enabled, so second
> +	  timeout is ignored. If device poke does not happen then system
> +	  will reboot on third timeout.
> +
>   config BCM2835_WDT
>   	tristate "Broadcom BCM2835 hardware watchdog"
>   	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 3633f5b98236..7eab9de311cb 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>   obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
>   obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
>   obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
> +obj-$(CONFIG_MARVELL_GTI_WDT) += marvell_gti_wdt.o
>   
>   # X86 (i386 + ia64 + x86_64) Architecture
>   obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
> diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
> new file mode 100644
> index 000000000000..a6ed7d8db791
> --- /dev/null
> +++ b/drivers/watchdog/marvell_gti_wdt.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell GTI Watchdog driver
> + *
> + * Copyright (C) 2023 Marvell.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +/*
> + * Hardware supports following mode of operation:
> + * 1) Interrupt Only:
> + *    This will generate the interrupt to arm core whenever timeout happens.
> + *
> + * 2) Interrupt + del3t (Interrupt to firmware (SCP processor)).
> + *    This will generate interrupt to arm core on 1st timeout happens
> + *    This will generate interrupt to SCP processor on 2nd timeout happens
> + *
> + * 3) Interrupt + Interrupt to SCP processor (called delt3t) + reboot.
> + *    This will generate interrupt to arm core on 1st timeout happens
> + *    Will generate interrupt to SCP processor on 2nd timeout happens,
> + *    if interrupt is configured.
> + *    Reboot on 3rd timeout.
> + *
> + * Driver will use hardware in mode-3 above so that system can reboot in case
> + * a hardware hang. Also h/w is configured not to generate SCP interrupt, so
> + * effectively 2nd timeout is ignored within hardware.
> + *
> + * First timeout is effectively watchdog pretimeout.
> + */
> +
> +/* GTI CWD Watchdog (GTI_CWD_WDOG) Register */
> +#define GTI_CWD_WDOG(reg_offset)	(0x8 * (reg_offset))
> +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
> +#define GTI_CWD_WDOG_MODE_MASK		GENMASK_ULL(1, 0)
> +#define GTI_CWD_WDOG_LEN_SHIFT		4
> +#define GTI_CWD_WDOG_LEN_MASK		GENMASK_ULL(19, 4)
> +#define GTI_CWD_WDOG_CNT_SHIFT		20
> +#define GTI_CWD_WDOG_CNT_MASK		GENMASK_ULL(43, 20)
> +
> +/* GTI CWD Watchdog Interrupt (GTI_CWD_INT) Register */
> +#define GTI_CWD_INT			0x200
> +#define GTI_CWD_INT_PENDING_STATUS(bit)	BIT_ULL(bit)
> +
> +/* GTI CWD Watchdog Interrupt Enable Clear (GTI_CWD_INT_ENA_CLR) Register */
> +#define GTI_CWD_INT_ENA_CLR		0x210
> +#define GTI_CWD_INT_ENA_CLR_VAL(bit)	BIT_ULL(bit)
> +
> +/* GTI CWD Watchdog Interrupt Enable Set (GTI_CWD_INT_ENA_SET) Register */
> +#define GTI_CWD_INT_ENA_SET		0x218
> +#define GTI_CWD_INT_ENA_SET_VAL(bit)	BIT_ULL(bit)
> +
> +/* GTI CWD Watchdog Poke (GTI_CWD_POKE) Registers */
> +#define GTI_CWD_POKE(reg_offset)	(0x10000 + 0x8 * (reg_offset))
> +#define GTI_CWD_POKE_VAL		1
> +
> +struct gti_match_data {
> +	u32 gti_num_timers;
> +};
> +
> +static const struct gti_match_data match_data_octeontx2 = {
> +	.gti_num_timers = 54,
> +};
> +
> +static const struct gti_match_data match_data_cn10k = {
> +	.gti_num_timers = 64,
> +};
> +
> +struct gti_wdt_priv {
> +	struct watchdog_device wdev;
> +	void __iomem *base;
> +	u32 clock_freq;
> +	struct clk *sclk;
> +	/* wdt_timer_idx used for timer to be used for system watchdog */
> +	u32 wdt_timer_idx;
> +	const struct gti_match_data *data;
> +};
> +
> +static irqreturn_t gti_wdt_interrupt(int irq, void *data)
> +{
> +	struct watchdog_device *wdev = data;
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	/* Clear Interrupt Pending Status */
> +	writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
> +	       priv->base + GTI_CWD_INT);
> +
> +	watchdog_notify_pretimeout(wdev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gti_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	writeq(GTI_CWD_POKE_VAL,
> +	       priv->base + GTI_CWD_POKE(priv->wdt_timer_idx));
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	if (!wdev->pretimeout)
> +		return -EINVAL;
> +
> +	set_bit(WDOG_HW_RUNNING, &wdev->status);
> +
> +	/* Clear any pending interrupt */
> +	writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
> +	       priv->base + GTI_CWD_INT);
> +
> +	/* Enable Interrupt */
> +	writeq(GTI_CWD_INT_ENA_SET_VAL(priv->wdt_timer_idx),
> +	       priv->base + GTI_CWD_INT_ENA_SET);
> +
> +	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
> +	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
> +	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	/* Disable Interrupt */
> +	writeq(GTI_CWD_INT_ENA_CLR_VAL(priv->wdt_timer_idx),
> +	       priv->base + GTI_CWD_INT_ENA_CLR);
> +
> +	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
> +	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +	regval &= ~GTI_CWD_WDOG_MODE_MASK;
> +	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_settimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 timeout_wdog, regval;
> +
> +	/* Update new timeout */
> +	wdev->timeout = timeout;
> +
> +	/* Pretimeout is 1/3 of timeout */
> +	wdev->pretimeout = timeout / 3;
> +
> +	/* Get clock cycles from pretimeout */
> +	timeout_wdog = (u64)priv->clock_freq * wdev->pretimeout;
> +
> +	/* Watchdog counts in 1024 cycle steps */
> +	timeout_wdog = timeout_wdog >> 10;
> +
> +	/* GTI_CWD_WDOG.CNT: reload counter is 16-bit */
> +	timeout_wdog = (timeout_wdog + 0xff) >> 8;
> +	if (timeout_wdog >= 0x10000)
> +		timeout_wdog = 0xffff;
> +
> +	/*
> +	 * GTI_CWD_WDOG.LEN is 24bit, lower 8-bits should be zero and
> +	 * upper 16-bits are same as GTI_CWD_WDOG.CNT
> +	 */
> +	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +	regval &= GTI_CWD_WDOG_MODE_MASK;
> +	regval |= (timeout_wdog << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
> +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
> +	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_set_pretimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	struct watchdog_device *wdog_dev = &priv->wdev;
> +
> +	/* pretimeout should 1/3 of max_timeout */
> +	if (timeout * 3 <= wdog_dev->max_timeout)
> +		return gti_wdt_settimeout(wdev, timeout * 3);
> +
> +	return -EINVAL;
> +}
> +
> +static void gti_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static int gti_wdt_get_cntfrq(struct platform_device *pdev,
> +			      struct gti_wdt_priv *priv)
> +{
> +	int err;
> +
> +	priv->sclk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(priv->sclk))
> +		return PTR_ERR(priv->sclk);
> +
> +	err = devm_add_action_or_reset(&pdev->dev,
> +				       gti_clk_disable_unprepare, priv->sclk);
> +	if (err)
> +		return err;
> +
> +	priv->clock_freq = clk_get_rate(priv->sclk);
> +	if (!priv->clock_freq)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info gti_wdt_ident = {
> +	.identity = "Marvell GTI watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_PRETIMEOUT | WDIOF_KEEPALIVEPING |
> +		   WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
> +};
> +
> +static const struct watchdog_ops gti_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = gti_wdt_start,
> +	.stop = gti_wdt_stop,
> +	.ping = gti_wdt_ping,
> +	.set_timeout = gti_wdt_settimeout,
> +	.set_pretimeout = gti_wdt_set_pretimeout,
> +};
> +
> +static int gti_wdt_probe(struct platform_device *pdev)
> +{
> +	struct gti_wdt_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdog_dev;
> +	u64 max_pretimeout;
> +	u32 wdt_idx;
> +	int irq;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
> +			      "reg property not valid/found\n");
> +
> +	err = gti_wdt_get_cntfrq(pdev, priv);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "GTI clock frequency not valid/found");
> +
> +	priv->data = of_device_get_match_data(dev);
> +
> +	/* default use last timer for watchdog */
> +	priv->wdt_timer_idx = priv->data->gti_num_timers - 1;
> +
> +	err = of_property_read_u32(dev->of_node, "marvell,wdt-timer-index",
> +				   &wdt_idx);
> +	if (!err) {
> +		if (wdt_idx >= priv->data->gti_num_timers)
> +			return dev_err_probe(&pdev->dev, err,
> +				"GTI wdog timer index not valid");
> +
> +		priv->wdt_timer_idx = wdt_idx;
> +	}
> +
> +	wdog_dev = &priv->wdev;
> +	wdog_dev->info = &gti_wdt_ident,
> +	wdog_dev->ops = &gti_wdt_ops,
> +	wdog_dev->parent = dev;
> +	/*
> +	 * Watchdog counter is 24 bit where lower 8 bits are zeros
> +	 * This counter decrements every 1024 clock cycles.
> +	 */
> +	max_pretimeout = (GTI_CWD_WDOG_CNT_MASK >> GTI_CWD_WDOG_CNT_SHIFT);
> +	max_pretimeout &= ~0xFFUL;
> +	max_pretimeout = (max_pretimeout * 1024) / priv->clock_freq;
> +	wdog_dev->pretimeout = max_pretimeout;
> +
> +	/* Maximum timeout is 3 times the pretimeout */
> +	wdog_dev->max_timeout = max_pretimeout * 3;
> +	/* Minimum first timeout (pretimeout) is 1, so min_timeout as 3 */
> +	wdog_dev->min_timeout = 3;
> +	wdog_dev->timeout = wdog_dev->pretimeout;
> +
> +	watchdog_set_drvdata(wdog_dev, priv);
> +	platform_set_drvdata(pdev, priv);
> +	gti_wdt_settimeout(wdog_dev, wdog_dev->timeout);
> +	watchdog_stop_on_reboot(wdog_dev);
> +	watchdog_stop_on_unregister(wdog_dev);
> +
> +	err = devm_watchdog_register_device(dev, wdog_dev);
> +	if (err)
> +		return err;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq, "IRQ resource not found\n");
> +
> +	err = devm_request_irq(dev, irq, gti_wdt_interrupt, 0,
> +			       pdev->name, &priv->wdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to register interrupt handler\n");
> +
> +	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
> +	return 0;
> +}
> +
> +static const struct of_device_id gti_wdt_of_match[] = {
> +	{ .compatible = "marvell,cn9670-wdt", .data = &match_data_octeontx2},
> +	{ .compatible = "marvell,cn10624-wdt", .data = &match_data_cn10k},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, gti_wdt_of_match);
> +
> +static struct platform_driver gti_wdt_driver = {
> +	.driver = {
> +		.name = "gti-wdt",
> +		.of_match_table = gti_wdt_of_match,
> +	},
> +	.probe = gti_wdt_probe,
> +};
> +module_platform_driver(gti_wdt_driver);
> +
> +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> +MODULE_DESCRIPTION("Marvell GTI watchdog driver");
> +MODULE_LICENSE("GPL v2");

