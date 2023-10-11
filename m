Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631E7C5573
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjJKNaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjJKNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:30:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22838A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:30:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so64170745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697031015; x=1697635815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1urhZ5RDTm2OqBfglj/5x3b4f12CS3JZB3zU5fzBLvY=;
        b=D0Q2dG1wz3iVLbMo7d+SLPKDSvW5Ik5V+xkg9A/Q5n7LUPCDeo6BNhY899cn4q13H7
         5ERQ782PUkiD+dHq7Z8VWNA03xq8GaJbKQ0QJhzVz3gUmaPuUMj41jIyPUPtUP2OD53k
         X6WRcKOkwJNZOjs5QWAb4Pifu3/Hndmaj7AufFX7xjrUhaCfufo7n0Ze6ztYzlJDsG15
         p0Gt1c/+Ql9J9zF67EHBd+V1eboS2TxIo9EIspyadfrJJRea1bUeY8SSmhTI6IBFVi+4
         QzOeiWGfIOOwKTUsXY7IYdt9BubB9bfjV9DbxgtBdDnhczHvqYGr6doejL2Q9PW65zIi
         pRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697031015; x=1697635815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1urhZ5RDTm2OqBfglj/5x3b4f12CS3JZB3zU5fzBLvY=;
        b=M/raYEigjAtDKhZfSzn4UXQU3CraM9bZFUacyDpgqTMsbjgFTH2GKvP5nCIDgByeY+
         HJ8Cxd/XJsXdG107+5klRfp55v9JY/krh2C0eij+hSEbxL9x+6zW1ml6frGEymktQcB3
         It3HOuCwRNxkiUj4oLwnnkfi+SKo7v7WGnUE+60UY25YgTBZDJ99ZzhDEyzZjwlYDysb
         Djr4aw+GEC80xv4E5ObKKHFKr/Dx8MfCXQSfBNWwdAoh8aTk9LnOJjYMJxqB8djMrcxs
         pGFjwG+rKVg1G0D3x98dcs4FQCyCoNPuEJKXK1ezxOAZlVNzqWXDSQ+0JEZQWTW3yWav
         ALqg==
X-Gm-Message-State: AOJu0YwejzYoRQVcNaNNIoDLtY9HrNxc0I+WV5/NrlxRAW4GsTtFeW1N
        6J2Hen2/Akqm8FtrAR/3VN4CHtl0Ae6ACLNWHdw=
X-Google-Smtp-Source: AGHT+IEEo+3BImoF+EB1kBFw8p7dPv/CpnMTOm9m2a76Gxg5K0O8HBU/lIpwgpq4jOTgBfZurh8K/g==
X-Received: by 2002:a05:600c:ad0:b0:406:7029:7cc3 with SMTP id c16-20020a05600c0ad000b0040670297cc3mr17762637wmr.28.1697031015334;
        Wed, 11 Oct 2023 06:30:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de95:eca9:6b1e:b330? ([2a05:6e02:1041:c10:de95:eca9:6b1e:b330])
        by smtp.googlemail.com with ESMTPSA id n26-20020a05600c3b9a00b004068def185asm17186014wms.28.2023.10.11.06.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 06:30:14 -0700 (PDT)
Message-ID: <d72a893a-a473-4399-8e87-5fedffe3ca40@linaro.org>
Date:   Wed, 11 Oct 2023 15:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/42] clocksource: ep93xx: Add driver for Cirrus Logic
 EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-12-a1d779dcec10@maquefel.me>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-12-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:10, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Rewrite EP93xx timer driver located in arch/arm/mach-ep93xx/timer-ep93xx.c
> trying to do everything the device tree way:
> 
> - Make every IO-access relative to a base address and dynamic
>    so we can do a dynamic ioremap and get going.
> - Find register range and interrupt from the device tree.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>   drivers/clocksource/Kconfig        |  11 +++
>   drivers/clocksource/Makefile       |   1 +
>   drivers/clocksource/timer-ep93xx.c | 190 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 202 insertions(+)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index c4d671a5a13d..f1b84b05b281 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -739,4 +739,15 @@ config GOLDFISH_TIMER
>   	help
>   	  Support for the timer/counter of goldfish-rtc
>   
> +config EP93XX_TIMER
> +	bool "Cirrus Logic ep93xx timer driver" if COMPILE_TEST
> +	depends on ARCH_EP93XX

Remove this dependency so it would be possible to compile-test on other 
platforms.

> +	depends on GENERIC_CLOCKEVENTS

This dependency is explicit for all the drivers belonging to this 
Kconfig. No need to add it.

> +	depends on HAS_IOMEM
> +	select CLKSRC_MMIO
> +	select TIMER_OF
> +	help
> +	  Enables support for the Cirrus Logic timer block
> +	  EP93XX.
> +
>   endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 5d93c9e3fc55..b6a3cf1f5b9d 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -90,3 +90,4 @@ obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
>   obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
>   obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
>   obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+= timer-loongson1-pwm.o
> +obj-$(CONFIG_EP93XX_TIMER)		+= timer-ep93xx.o
> diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
> new file mode 100644
> index 000000000000..bc0ca6e12334
> --- /dev/null
> +++ b/drivers/clocksource/timer-ep93xx.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cirrus Logic EP93xx timer driver.
> + * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/timer.c:
> + */
> +
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +
> +#include <asm/mach/time.h>

This head should not be needed.

> +
> +/*************************************************************************
> + * Timer handling for EP93xx
> + *************************************************************************
> + * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
> + * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
> + * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
> + * is free-running, and can't generate interrupts.
> + *
> + * The 508 kHz timers are ideal for use for the timer interrupt, as the
> + * most common values of HZ divide 508 kHz nicely.  We pick the 32 bit
> + * timer (timer 3) to get as long sleep intervals as possible when using
> + * CONFIG_NO_HZ.
> + *
> + * The higher clock rate of timer 4 makes it a better choice than the
> + * other timers for use as clock source and for sched_clock(), providing
> + * a stable 40 bit time base.
> + *************************************************************************
> + */
> +
> +#define EP93XX_TIMER1_LOAD		0x00
> +#define EP93XX_TIMER1_VALUE		0x04
> +#define EP93XX_TIMER1_CONTROL		0x08
> +#define EP93XX_TIMER123_CONTROL_ENABLE	BIT(7)
> +#define EP93XX_TIMER123_CONTROL_MODE	BIT(6)
> +#define EP93XX_TIMER123_CONTROL_CLKSEL	BIT(3)
> +#define EP93XX_TIMER1_CLEAR		0x0c
> +#define EP93XX_TIMER2_LOAD		0x20
> +#define EP93XX_TIMER2_VALUE		0x24
> +#define EP93XX_TIMER2_CONTROL		0x28
> +#define EP93XX_TIMER2_CLEAR		0x2c
> +/*
> + * This read-only register contains the low word of the time stamp debug timer
> + * ( Timer4). When this register is read, the high byte of the Timer4 counter is
> + * saved in the Timer4ValueHigh register.
> + */
> +#define EP93XX_TIMER4_VALUE_LOW		0x60
> +#define EP93XX_TIMER4_VALUE_HIGH	0x64
> +#define EP93XX_TIMER4_VALUE_HIGH_ENABLE	BIT(8)
> +#define EP93XX_TIMER3_LOAD		0x80
> +#define EP93XX_TIMER3_VALUE		0x84
> +#define EP93XX_TIMER3_CONTROL		0x88
> +#define EP93XX_TIMER3_CLEAR		0x8c
> +
> +#define EP93XX_TIMER123_RATE		508469
> +#define EP93XX_TIMER4_RATE		983040
> +
> +struct ep93xx_tcu {
> +	void __iomem *base;
> +};
> +
> +static struct ep93xx_tcu *ep93xx_tcu;

Usually what is done is:

struct ep93xx_tcu {
	void __iomem *base;
	struct clock_event_device evt;
};

And with container_of and all timer API passing the *evt as parameter, 
we can retrieve this data.

So we should have:

struct ep93xx_tcu timer = {
	.evt = {
		.name			= "timer1",
		.features		= CLOCK_EVT_FEAT_ONESHOT,
		.set_state_shutdown	= ep93xx_clkevt_shutdown,
		.set_state_oneshot	= ep93xx_clkevt_shutdown,
		.tick_resume		= ep93xx_clkevt_shutdown,
		.set_next_event		= ep93xx_clkevt_set_next_event,
		.rating			= 300,
	};
	/* No need to compute every time  */
	void __iomem *clksrc_base; /* base + timer4_val_low */
	void __iomem *clkevt_base;
};

And no need to allocate in the init function.


> +static u64 ep93xx_clocksource_read(struct clocksource *c)

Perhaps add __may_be_unused annotation

> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +
> +	return lo_hi_readq(tcu->base + EP93XX_TIMER4_VALUE_LOW) & GENMASK_ULL(39, 0);
> +}
> +
> +static u64 notrace ep93xx_read_sched_clock(void)
> +{
> +	return ep93xx_clocksource_read(NULL);
> +}
> +static int ep93xx_clkevt_set_next_event(unsigned long next,
> +					struct clock_event_device *evt)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	/* Default mode: periodic, off, 508 kHz */
> +	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
> +	EP93XX_TIMER123_CONTROL_CLKSEL;
> +
> +	/* Clear timer */
> +	writel(tmode, tcu->base + EP93XX_TIMER3_CONTROL);
> +
> +	/* Set next event */
> +	writel(next, tcu->base + EP93XX_TIMER3_LOAD);
> +	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
> +	       tcu->base + EP93XX_TIMER3_CONTROL);
> +	return 0;
> +}
> +
> +static int ep93xx_clkevt_shutdown(struct clock_event_device *evt)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	/* Disable timer */
> +	writel(0, tcu->base + EP93XX_TIMER3_CONTROL);
> +
> +	return 0;
> +}
> +
> +static struct clock_event_device ep93xx_clockevent = {
> +	.name			= "timer1",
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
> +	.set_state_shutdown	= ep93xx_clkevt_shutdown,
> +	.set_state_oneshot	= ep93xx_clkevt_shutdown,
> +	.tick_resume		= ep93xx_clkevt_shutdown,
> +	.set_next_event		= ep93xx_clkevt_set_next_event,
> +	.rating			= 300,
> +};
> +
> +static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct ep93xx_tcu *tcu = ep93xx_tcu;
> +	struct clock_event_device *evt = dev_id;
> +
> +	/* Writing any value clears the timer interrupt */
> +	writel(1, tcu->base + EP93XX_TIMER3_CLEAR);
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init ep93xx_timer_of_init(struct device_node *np)
> +{
> +	int irq;
> +	unsigned long flags = IRQF_TIMER | IRQF_IRQPOLL;
> +	struct ep93xx_tcu *tcu;
> +	int ret;
> +
> +	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
> +	if (!tcu)
> +		return -ENOMEM;
> +
> +	tcu->base = of_iomap(np, 0);
> +	if (!tcu->base) {
> +		pr_err("Can't remap registers\n");
> +		ret = -ENXIO;
> +		goto out_free;
> +	}
> +
> +	ep93xx_tcu = tcu;
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq == 0)
> +		irq = -EINVAL;
> +	if (irq < 0) {
> +		pr_err("EP93XX Timer Can't parse IRQ %d", irq);
> +		goto out_free;
> +	}
> +
> +	/* Enable and register clocksource and sched_clock on timer 4 */
> +	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
> +	       tcu->base + EP93XX_TIMER4_VALUE_HIGH);



> +	clocksource_mmio_init(NULL, "timer4",
> +				EP93XX_TIMER4_RATE, 200, 40,
> +				ep93xx_clocksource_read);

return code check

> +	sched_clock_register(ep93xx_read_sched_clock, 40,
> +			     EP93XX_TIMER4_RATE);
> +
> +	/* Set up clockevent on timer 3 */
> +	if (request_irq(irq, ep93xx_timer_interrupt, flags, "ep93xx timer",
> +		&ep93xx_clockevent))
> +		pr_err("Failed to request irq %d (ep93xx timer)\n", irq);

return error

> +	clockevents_config_and_register(&ep93xx_clockevent,
> +				EP93XX_TIMER123_RATE,
> +				1,
> +				UINT_MAX);
> +
> +	return 0;
> +
> +out_free:
> +	kfree(tcu);
> +	return ret;
> +}
> +TIMER_OF_DECLARE(ep93xx_timer, "cirrus,ep9301-timer", ep93xx_timer_of_init);
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

