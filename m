Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5ED771591
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHFOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 10:19:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F91B3;
        Sun,  6 Aug 2023 07:19:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbc87ded50so24350685ad.1;
        Sun, 06 Aug 2023 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691331564; x=1691936364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMrHwhbdYHGzF5f4FRST3mgNtv9aM+wyBhJFzSQJn7k=;
        b=You7tRiDq3HIYF8el3bAjZHn5hthzGmN9r/zgD11DK1Z5IyRXNqu9tLT28s0yqwKDu
         3M8nMYMAOEpDkhuQ5h/+USpObBh2Z+WlzhRyDkTX1adFo5CEZSRuWKEITxsdacJaUdjg
         iW+BtwJl5WeiOC/SPpTVIDM7TI+rqUmObGXNQCQQcjqAGYJiZLZ7VlPcd2G36GqiFNXa
         Fm9+IEpFV/5LQAFwh/7YdVGUrrYeeDybBrXzHJ5hJssXLMjXL/WajxrKDW9G/N/A8S74
         vkjgbZL/XhxCTRLLlAoe7yNuGdX4ebDetx/DtdorneTVXC6s3z8ybZUaRjNIIs0ixjxn
         GT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691331564; x=1691936364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMrHwhbdYHGzF5f4FRST3mgNtv9aM+wyBhJFzSQJn7k=;
        b=OZZbo4Rbmj+Bvy6GJR/GCVJmJAIjZ5O24GwIDvkATy/Tn0LLokDBEb6E1W+Y+fgD6U
         sEt39KlMJFO850MAzROvmO8CIgjwojyMIoAyUOWS6EePTpYWqSySZIx7OlwW1mqgVo2/
         wrwFa9CSEJNG2WlxyVO5gUnmmBfl7RXtxhSsindepKPYC7L10YPfG7tmNmlZwzEt8fMQ
         q82ZnxPlMvM/6wnuvI4VH5GepGqk7Ldqj6HuX6kFseO+C+7+5yGzoTBE5Ld+aobzO1IT
         +amA1oqIFUslIIJe/JAHgJhLJsdn20aZ6a/vUrcXEo3K2BukzmePCzo/7Xj1K3ZOScTq
         eRYw==
X-Gm-Message-State: AOJu0YyA6GLeG4zL/6RcFFvatV7n6Dx0vH52YtJnV5CQX6UmsYxGHIA2
        ys+4DcdoKhthUBUedqHPEwMBJUqpkUo=
X-Google-Smtp-Source: AGHT+IHpzDA3To08YqkkqT3hDuY0GEdLocwERyC8TQTBy07pjaQp/IcAvurfgtYfL+1pfjQ1+o79Iw==
X-Received: by 2002:a17:903:32d1:b0:1bc:56c3:ebb7 with SMTP id i17-20020a17090332d100b001bc56c3ebb7mr6168085plr.20.1691331563717;
        Sun, 06 Aug 2023 07:19:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p21-20020a1709028a9500b001bb0b1a93dfsm4947709plo.126.2023.08.06.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 07:19:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Aug 2023 07:19:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: stm32_iwdg: Add pretimeout support
Message-ID: <ba596dd5-e9b9-4972-a768-e42e69897fea@roeck-us.net>
References: <20230517194349.105745-1-marex@denx.de>
 <20230517194349.105745-2-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517194349.105745-2-marex@denx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 09:43:48PM +0200, Marek Vasut wrote:
> The STM32MP15xx IWDG adds registers which permit this IP to generate
> pretimeout interrupt. This interrupt can also be used to wake the CPU
> from suspend. Implement support for generating this interrupt and let
> userspace configure the pretimeout. In case the pretimeout is not
> configured by user, set pretimeout to half of the WDT timeout cycle.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Antonio Borneo <antonio.borneo@foss.st.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-watchdog@vger.kernel.org
> ---
> V2: - Subtract the pretimeout value from timeout value before writing it
>       into the IWDG pretimeout register, because the watchdog counter
>       register is counting down, and the pretimeout interrupt triggers
>       when watchdog counter register matches the pretimeout register
>       content.
>     - Set default pretimeout to 3/4 of timeout .
> ---
>  drivers/watchdog/stm32_iwdg.c | 94 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index 570a71509d2a9..4c69d4026dd9c 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/watchdog.h>
>  
>  /* IWDG registers */
> @@ -27,6 +28,7 @@
>  #define IWDG_RLR	0x08 /* ReLoad Register */
>  #define IWDG_SR		0x0C /* Status Register */
>  #define IWDG_WINR	0x10 /* Windows Register */
> +#define IWDG_EWCR	0x14 /* Early Wake-up Register */
>  
>  /* IWDG_KR register bit mask */
>  #define KR_KEY_RELOAD	0xAAAA /* reload counter enable */
> @@ -46,22 +48,29 @@
>  #define SR_PVU	BIT(0) /* Watchdog prescaler value update */
>  #define SR_RVU	BIT(1) /* Watchdog counter reload value update */
>  
> +#define EWCR_EWIT	GENMASK(11, 0) /* Watchdog counter window value */
> +#define EWCR_EWIC	BIT(14) /* Watchdog early interrupt acknowledge */
> +#define EWCR_EWIE	BIT(15) /* Watchdog early interrupt enable */
> +
>  /* set timeout to 100000 us */
>  #define TIMEOUT_US	100000
>  #define SLEEP_US	1000
>  
>  struct stm32_iwdg_data {
>  	bool has_pclk;
> +	bool has_early_wakeup;
>  	u32 max_prescaler;
>  };
>  
>  static const struct stm32_iwdg_data stm32_iwdg_data = {
>  	.has_pclk = false,
> +	.has_early_wakeup = false,
>  	.max_prescaler = 256,
>  };
>  
>  static const struct stm32_iwdg_data stm32mp1_iwdg_data = {
>  	.has_pclk = true,
> +	.has_early_wakeup = true,
>  	.max_prescaler = 1024,
>  };
>  
> @@ -87,13 +96,18 @@ static inline void reg_write(void __iomem *base, u32 reg, u32 val)
>  static int stm32_iwdg_start(struct watchdog_device *wdd)
>  {
>  	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
> -	u32 tout, presc, iwdg_rlr, iwdg_pr, iwdg_sr;
> +	u32 tout, ptot, presc, iwdg_rlr, iwdg_ewcr, iwdg_pr, iwdg_sr;
>  	int ret;
>  
>  	dev_dbg(wdd->parent, "%s\n", __func__);
>  
> +	if (!wdd->pretimeout)
> +		wdd->pretimeout = 3 * wdd->timeout / 4;
> +
>  	tout = clamp_t(unsigned int, wdd->timeout,
>  		       wdd->min_timeout, wdd->max_hw_heartbeat_ms / 1000);
> +	ptot = clamp_t(unsigned int, tout - wdd->pretimeout,
> +		       wdd->min_timeout, tout);
>  
>  	presc = DIV_ROUND_UP(tout * wdt->rate, RLR_MAX + 1);
>  
> @@ -101,6 +115,7 @@ static int stm32_iwdg_start(struct watchdog_device *wdd)
>  	presc = roundup_pow_of_two(presc);
>  	iwdg_pr = presc <= 1 << PR_SHIFT ? 0 : ilog2(presc) - PR_SHIFT;
>  	iwdg_rlr = ((tout * wdt->rate) / presc) - 1;
> +	iwdg_ewcr = ((ptot * wdt->rate) / presc) - 1;
>  
>  	/* enable write access */
>  	reg_write(wdt->regs, IWDG_KR, KR_KEY_EWA);
> @@ -108,6 +123,8 @@ static int stm32_iwdg_start(struct watchdog_device *wdd)
>  	/* set prescaler & reload registers */
>  	reg_write(wdt->regs, IWDG_PR, iwdg_pr);
>  	reg_write(wdt->regs, IWDG_RLR, iwdg_rlr);
> +	if (wdt->data->has_early_wakeup)
> +		reg_write(wdt->regs, IWDG_EWCR, iwdg_ewcr | EWCR_EWIE);
>  	reg_write(wdt->regs, IWDG_KR, KR_KEY_ENABLE);
>  
>  	/* wait for the registers to be updated (max 100ms) */
> @@ -150,6 +167,34 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
>  	return 0;
>  }
>  
> +static int stm32_iwdg_set_pretimeout(struct watchdog_device *wdd,
> +				     unsigned int pretimeout)
> +{
> +	dev_dbg(wdd->parent, "%s pretimeout: %d sec\n", __func__, pretimeout);
> +
> +	wdd->pretimeout = pretimeout;
> +
> +	if (watchdog_active(wdd))
> +		return stm32_iwdg_start(wdd);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t stm32_iwdg_isr(int irq, void *wdog_arg)
> +{
> +	struct watchdog_device *wdd = wdog_arg;
> +	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
> +	u32 reg;
> +
> +	reg = reg_read(wdt->regs, IWDG_EWCR);
> +	reg |= EWCR_EWIC;
> +	reg_write(wdt->regs, IWDG_EWCR, reg);
> +
> +	watchdog_notify_pretimeout(wdd);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void stm32_clk_disable_unprepare(void *data)
>  {
>  	clk_disable_unprepare(data);
> @@ -206,11 +251,20 @@ static const struct watchdog_info stm32_iwdg_info = {
>  	.identity	= "STM32 Independent Watchdog",
>  };
>  
> +static const struct watchdog_info stm32_iwdg_preinfo = {
> +	.options	= WDIOF_SETTIMEOUT |
> +			  WDIOF_MAGICCLOSE |
> +			  WDIOF_KEEPALIVEPING |
> +			  WDIOF_PRETIMEOUT,
> +	.identity	= "STM32 Independent Watchdog",
> +};
> +
>  static const struct watchdog_ops stm32_iwdg_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= stm32_iwdg_start,
>  	.ping		= stm32_iwdg_ping,
>  	.set_timeout	= stm32_iwdg_set_timeout,
> +	.set_pretimeout	= stm32_iwdg_set_pretimeout,
>  };
>  
>  static const struct of_device_id stm32_iwdg_of_match[] = {
> @@ -220,6 +274,39 @@ static const struct of_device_id stm32_iwdg_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
>  
> +static int stm32_iwdg_irq_init(struct platform_device *pdev,
> +			       struct stm32_iwdg *wdt)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct watchdog_device *wdd = &wdt->wdd;
> +	struct device *dev = &pdev->dev;
> +	int irq, ret;
> +
> +	if (!wdt->data->has_early_wakeup)
> +		return 0;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return 0;
> +
> +	if (of_property_read_bool(np, "wakeup-source")) {
> +		ret = device_init_wakeup(&pdev->dev, true);

use dev

> +		if (ret)
> +			return ret;
> +
> +		ret = dev_pm_set_wake_irq(&pdev->dev, irq);

use dev

> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, stm32_iwdg_isr, 0,
> +			       dev_name(dev), wdd);
> +	if (!ret)
> +		wdd->info = &stm32_iwdg_preinfo;

	if (ret)
		return ret;

	wdd->info = &stm32_iwdg_preinfo;
	return 0;

> +
> +	return ret;
> +}
> +
>  static int stm32_iwdg_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -253,6 +340,11 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>  	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
>  				    1000) / wdt->rate;
>  
> +	/* Initialize IRQ, this might override wdd->info, hence it is here. */
> +	ret = stm32_iwdg_irq_init(pdev, wdt);
> +	if (ret)
> +		return ret;
> +

What if the interrupt fires for whatever reason and the watchdog
isn't registered yet and the driver data is not set and the
watchdog core doesn't know about the watchdog ?

Guenter

>  	watchdog_set_drvdata(wdd, wdt);
>  	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
>  	watchdog_init_timeout(wdd, 0, dev);
