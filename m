Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69417BAEBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjJEWSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjJEWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:17:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FAFE8;
        Thu,  5 Oct 2023 15:17:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406609df1a6so13967025e9.3;
        Thu, 05 Oct 2023 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696544275; x=1697149075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnCgi4qLiUMCR3TjGbpFsPLMSHS2+T4Oo/jTNlZnQ3o=;
        b=IiZ5F4yo2z3Fh6jvxYpilk873aBPoRUtdqMEMfHpGtjCYgSbHJlKmfD7PDFGY7uWCc
         K38JG7IgGcCeqrqYQVuUJW0J0t6jxwV/yZqHybgJeAGlPgzJHuaOUxWhCcv97dRHTl+B
         Gdzr6mFcap4C/dIlPVjn/8IIC58DSb2vZDRzvXggFXcDkdhu6G8EQn0ErWE1uzp2tYGc
         0RFqWQYeQPFDicm8k/IQv3jR7CpHY5u+LQ1zUjpAYedd1cQIc/lrzYrAq/K1gdMWy1XH
         YJbfYceABnND7zAP4odDsqfxeWLO5rMoSN7IUxYlPlk8Cq/KBdLJCltrfTptfVRA1NWk
         tGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544275; x=1697149075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnCgi4qLiUMCR3TjGbpFsPLMSHS2+T4Oo/jTNlZnQ3o=;
        b=SsxklInutjqCxUN7K1y7cnNrG8v3XJ1FS3gGbNCn9/AAvUr5+JqLwJjBCzv/1Y0PBp
         YZxxrdwjsYG5ZYwfpI4yvS49sA+d5N0dtZH4c8eC4Tjp/oOkyh3KSP9KlX6XHWQWmfQi
         Uz48UdJbzllVMhvBlxlQD4AXObPMCUSp1fcbqApiWaAKWQhn7cBgOenkKtJkGQ8LGbLp
         KIRD35AEXu7Ja0WcSLZs+1ru7OnQoxyV+sLcYqULXjKGwbBQHp1PaxSHL1kGRyGoaBe3
         Ig2+DMzCEZLD5+5Jxd0Biq4F0v20focxaQ3RR7nLdHEOcjGbbTaeMrpFb2m8hjbf2VD6
         S6VA==
X-Gm-Message-State: AOJu0Yw/JZQpd57MItdrIIdzLT9Wdg6junRYRQLitN0llbHwSW9Vrvtl
        LqoR5gIDD72x0lA3KGFhE4Q=
X-Google-Smtp-Source: AGHT+IGBx5rlXW6W+35yPghs2VVFXgZXdCydIfRdjyz9k3L7yMv2hwxYikmEIoYfSynO91QKJAq4RA==
X-Received: by 2002:a05:600c:3657:b0:406:3f62:e583 with SMTP id y23-20020a05600c365700b004063f62e583mr5901565wmq.40.1696544274501;
        Thu, 05 Oct 2023 15:17:54 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bce07000000b003fc16ee2864sm2421978wmc.48.2023.10.05.15.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 15:17:54 -0700 (PDT)
Message-ID: <83830504-770b-4781-868b-333a52044cea@gmail.com>
Date:   Fri, 6 Oct 2023 00:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: core: Fix checks for tx runtime PM state
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231005075644.25936-1-tony@atomide.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231005075644.25936-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 09:56, Tony Lindgren wrote:
> Maximilian reported that surface_serial_hub serdev tx does not work during
> system suspend. During system suspend, runtime PM gets disabled in
> __device_suspend_late(), and tx is unable to wake-up the serial core port
> device that we use to check if tx is safe to start. Johan summarized the
> regression noting that serdev tx no longer always works as earlier when the
> serdev device is runtime PM active.
> 
> The serdev device and the serial core controller devices are siblings of
> the serial port hardware device. The runtime PM usage count from serdev
> device does not propagate to the serial core device siblings, it only
> propagates to the parent.
> 
> In addition to the tx issue for suspend, testing for the serial core port
> device can cause an unnecessary delay in enabling tx while waiting for the
> serial core port device to wake-up. The serial core port device wake-up is
> only needed to flush pending tx when the serial port hardware device was
> in runtime PM suspended state.
> 
> To fix the regression, we need to check the runtime PM state of the parent
> serial port hardware device for tx instead of the serial core port device.
> 
> As the serial port device drivers may or may not implement runtime PM, we
> need to also add a check for pm_runtime_enabled().
> 
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks!

Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/tty/serial/serial_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
>   	 * enabled, serial_port_runtime_resume() calls start_tx() again
>   	 * after enabling the device.
>   	 */
> -	if (pm_runtime_active(&port_dev->dev))
> +	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
>   		port->ops->start_tx(port);
>   	pm_runtime_mark_last_busy(&port_dev->dev);
>   	pm_runtime_put_autosuspend(&port_dev->dev);
