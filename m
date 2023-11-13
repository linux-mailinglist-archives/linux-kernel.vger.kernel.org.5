Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F258A7E9F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjKMOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:54:48 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C91A5;
        Mon, 13 Nov 2023 06:54:43 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f084cb8b54so2838861fac.1;
        Mon, 13 Nov 2023 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699887282; x=1700492082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/cdXZ51UOpBcHr+K7BDEzqx93FDXiho8JciU1Wgacso=;
        b=UMv59hATd9lBqx7Xx5kKvSLG2BPIWdgO2guhQpCER16fHTRLFZX7tRuYSUfxlnq2lo
         FdIgtOnl0JbqQvtkKYEiTKkSrBcoUdfO+TpCbzhh980ziGM1rm0OyO37GazcjON0H1Nl
         gKkPMJklrOfpIoz0yo1wcE82n6L4FRMHmHKbRO1F7mvrmfssFz8Ap0f2gFgJ35A/YOdE
         sBX9fsZW00rbT8nZ0pyn7mYhH16be73mXli2F1JBoS+diotYqieCjAEALgIRrxO+9R0S
         79cGLP3rqToXOX5xyQYB7CxPBhJBFy3hDk+X22UMmsh5lUJ0u3wDtK7V5pYl2X3Ky2oD
         0VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887282; x=1700492082;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cdXZ51UOpBcHr+K7BDEzqx93FDXiho8JciU1Wgacso=;
        b=Oxck1hSMzoj5f5NHTn9ZpPsmUUdGo51sEnqJit+NtfcwAlugpknMfylbf5M1scwZtD
         8yc3CKRx8RCAZjPuAiIFHrLDPcoFMqHbU1rHPpoU1zVgWSqMFahUmNBI2IMP32ZPVwT0
         0BGadMWaP6ySMdWX6ZeNahJXB57/RCSdl4Fi+U03zkWsEFQdoxGcjHpjKeLDcu4hRLp7
         3+dFkw+WZoRSZl5K07jMqRimk8lNnDwzmSuPvCCVz/lGlv3TR+F0Nmg3m6T9m+xT00t1
         /nuLuH9hCb70wDrmbFKuocbNpiLM4wNAFE4j3Z8p2K3HBdkro9r8KMXD1EYMzo09cXy8
         biNw==
X-Gm-Message-State: AOJu0Yzh0Z2Q+eb2YnIw6pwWHV6UhUcRr/aeDG7tsmhMh0UAMiW5Jh4l
        J7QdGAw2YGV1Tic8ariF+nfSsY4Eu7M=
X-Google-Smtp-Source: AGHT+IGT0W5k2Q+NZAVZZ6YDDOcy5mJD33vZUMb9jV6OEkM92NHIZCc+ytJa15R18MSKrfUTtaHsVg==
X-Received: by 2002:a05:6870:a9a8:b0:1e9:ba42:76bb with SMTP id ep40-20020a056870a9a800b001e9ba4276bbmr7969709oab.39.1699887282252;
        Mon, 13 Nov 2023 06:54:42 -0800 (PST)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id ps6-20020a0568709e0600b001efca9337c7sm1068852oab.5.2023.11.13.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:54:42 -0800 (PST)
Message-ID: <655238b2.050a0220.209e.4ad5@mx.google.com>
X-Google-Original-Message-ID: <ZVI4r8TKT0hWxL90@neuromancer.>
Date:   Mon, 13 Nov 2023 08:54:39 -0600
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Benjamin Bara <bbara93@gmail.com>, Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee@kernel.org>, rafael.j.wysocki@intel.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        peterz@infradead.org, jonathanh@nvidia.com,
        richard.leitner@linux.dev, treding@nvidia.com,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        stable@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        heiko@sntech.de, max.schwarz@online.de
Subject: Re: [PATCH v7 2/5] i2c: core: run atomic i2c xfer when !preemptible
References: <20230327-tegra-pmic-reboot-v7-0-18699d5dcd76@skidata.com>
 <20230327-tegra-pmic-reboot-v7-2-18699d5dcd76@skidata.com>
 <655177f4.050a0220.d85c9.3ba0@mx.google.com>
 <69941f8e-de1f-0319-6729-58625b362b8e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69941f8e-de1f-0319-6729-58625b362b8e@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 06:46:30AM +0300, Dmitry Osipenko wrote:
> On 11/13/23 04:12, Chris Morgan wrote:
> > On Sat, Jul 15, 2023 at 09:53:24AM +0200, Benjamin Bara wrote:
> >> From: Benjamin Bara <benjamin.bara@skidata.com>
> >>
> >> Since bae1d3a05a8b, i2c transfers are non-atomic if preemption is
> >> disabled. However, non-atomic i2c transfers require preemption (e.g. in
> >> wait_for_completion() while waiting for the DMA).
> >>
> >> panic() calls preempt_disable_notrace() before calling
> >> emergency_restart(). Therefore, if an i2c device is used for the
> >> restart, the xfer should be atomic. This avoids warnings like:
> >>
> >> [   12.667612] WARNING: CPU: 1 PID: 1 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x33c/0x6b0
> >> [   12.676926] Voluntary context switch within RCU read-side critical section!
> >> ...
> >> [   12.742376]  schedule_timeout from wait_for_completion_timeout+0x90/0x114
> >> [   12.749179]  wait_for_completion_timeout from tegra_i2c_wait_completion+0x40/0x70
> >> ...
> >> [   12.994527]  atomic_notifier_call_chain from machine_restart+0x34/0x58
> >> [   13.001050]  machine_restart from panic+0x2a8/0x32c
> >>
> >> Use !preemptible() instead, which is basically the same check as
> >> pre-v5.2.
> >>
> >> Fixes: bae1d3a05a8b ("i2c: core: remove use of in_atomic()")
> >> Cc: stable@vger.kernel.org # v5.2+
> >> Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> Acked-by: Wolfram Sang <wsa@kernel.org>
> >> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> Tested-by: Nishanth Menon <nm@ti.com>
> >> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > 
> > For kernel 6.7 I'm having an issue when I shutdown or reboot my
> > Rockchip RK3326 or Rockchip RK3566 based devices, and I've bisected
> > the issue down to this specific commit.
> > 
> > When I shutdown or restart the device, I receive messages in the kernel
> > log like the following:
> > 
> > [   37.121148] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
> > [   37.122178] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
> > [   37.123212] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
> > [   37.124226] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
> > [   37.125242] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x3
> > [   37.126133] rk3x-i2c fdd40000.i2c: irq in STATE_IDLE, ipd = 0x1
> > 
> > The device will also occasionally freeze instead of rebooting or
> > shutting down. The i2c errors are consistent, but the freezing
> > behavior is not.
> 
> I couldn't reproduce your issue with v6.7-rc1 and RK3399 that also uses rk3x-i2c. Though, the rk3x-i2c driver looks suspicious. Please try this patch:
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index a044ca0c35a1..aad00e9909cc 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -219,6 +219,8 @@ struct rk3x_i2c {
>  	enum rk3x_i2c_state state;
>  	unsigned int processed;
>  	int error;
> +
> +	int irq;
>  };
>  
>  static inline void i2c_writel(struct rk3x_i2c *i2c, u32 value,
> @@ -1090,8 +1092,10 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
>  		rk3x_i2c_start(i2c);
>  
>  		if (!polling) {
> +			enable_irq(i2c->irq);
>  			timeout = wait_event_timeout(i2c->wait, !i2c->busy,
>  						     msecs_to_jiffies(WAIT_TIMEOUT));
> +			disable_irq(i2c->irq);
>  		} else {
>  			timeout = rk3x_i2c_wait_xfer_poll(i2c);
>  		}
> @@ -1236,7 +1240,6 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>  	int ret = 0;
>  	int bus_nr;
>  	u32 value;
> -	int irq;
>  	unsigned long clk_rate;
>  
>  	i2c = devm_kzalloc(&pdev->dev, sizeof(struct rk3x_i2c), GFP_KERNEL);
> @@ -1299,11 +1302,14 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>  	}
>  
>  	/* IRQ setup */
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> +	i2c->irq = platform_get_irq(pdev, 0);
> +	if (i2c->irq < 0)
> +		return i2c->irq;
> +
> +	/* interrupt will be enabled during of transfer time */
> +	irq_set_status_flags(i2c->irq, IRQ_NOAUTOEN);
>  
> -	ret = devm_request_irq(&pdev->dev, irq, rk3x_i2c_irq,
> +	ret = devm_request_irq(&pdev->dev, i2c->irq, rk3x_i2c_irq,
>  			       0, dev_name(&pdev->dev), i2c);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "cannot request IRQ\n");
> 

I can confirm I no longer get any of the errors with this patch. Tested
on both an Anbernic RG353P (RK3566 with an RK817 PMIC) and an Odroid
Go Advance (RK3326 with an RK817 PMIC). The device appears to shut
down consistently again and I no longer see these messages in my dmesg
log when I shut down.

Thank you.

> 
> -- 
> Best regards,
> Dmitry
> 
