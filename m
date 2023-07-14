Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120C75428A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjGNS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjGNS2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:28:22 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F0C6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:28:21 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-440ad406bc8so660953137.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689359300; x=1691951300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEwh3jWpcS4Rr9/xa0HOrqWoe7wb9dJDR+SiTAkE0+w=;
        b=GJB6wy00ho4cgQgXPNrW8Vi88apS61JH+hMIrk21zgvJ7QtBfaGWZFt0PmM503sWrN
         4M+p7P9OaJPbgHHRkqEGUzGUaGL9IpKWXnEXT7IH8x2onT/EZeuepOF+QCabiWZeYe7J
         djmtI1p5stNcz0bPDFeE9VMSIiGA5jzHSd3yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359300; x=1691951300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEwh3jWpcS4Rr9/xa0HOrqWoe7wb9dJDR+SiTAkE0+w=;
        b=dXjhiOV1BhR9XtEfRnM4D60hN6bpA1dI+nOyR3EgWUpnt8gYUbmeQXpkgiaKob3PJx
         a165Ip5ceEsxPvFftA1I662rkAtJy82gTjUZ8wVk0H18IfPRlGXOwhfb0uWXJ6qDLnDU
         6FwHGNNQqsjDHbYH1aPIocnc6zJ1EhtqyDanRXvvN3i+fUtIMINy0Qk4mpRbwwLmuYaw
         E0850ZyBOOSYTm1HH3ZaseQvX0yyxpRvTHt3iMlXHygzhHkaPDyzv1UgabmPoUc06zNY
         jnVr+AUe9oTtyqsBc0GTUbOO33bFBLgWPd4O8lNJ0OPBNnlzUZjXyiqE1iugCZUA5ff7
         qxLg==
X-Gm-Message-State: ABy/qLZhMTSETKyjIG/s6AMLYBBj6hHX7K2N7cuqHPKAStkDRKTwZAOb
        kh6vIOPMyQeZaboVykpxmqBtimis/IZ+71iVtTI=
X-Google-Smtp-Source: APBJJlGtD9qXoeR5fHzlSeVWUzWN3w255qGeCaqVr8loJq6nkwqDxbR7oD6lizCs2R1szFh1Ou4dPA==
X-Received: by 2002:a67:eb96:0:b0:445:20ba:fb16 with SMTP id e22-20020a67eb96000000b0044520bafb16mr2074462vso.25.1689359300197;
        Fri, 14 Jul 2023 11:28:20 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id i13-20020a05620a150d00b00767660afed5sm3980568qkk.99.2023.07.14.11.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:28:19 -0700 (PDT)
Message-ID: <f61fa0cc-eca7-c04a-abf6-5ca5318bd2b8@joelfernandes.org>
Date:   Fri, 14 Jul 2023 14:28:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] tick/nohz: Rename the tick handlers to more
 self-explanatory names
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230714120852.23573-1-frederic@kernel.org>
 <20230714120852.23573-2-frederic@kernel.org>
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230714120852.23573-2-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 08:08, Frederic Weisbecker wrote:
> The current name of the tick handlers don't tell much about what differ
> between them. Use names that better reflect their role and resolution.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/time/tick-sched.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 89055050d1ac..a7b5960258f2 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1355,7 +1355,7 @@ void tick_nohz_idle_exit(void)
>   /*
>    * The nohz low res interrupt handler
>    */
> -static void tick_nohz_handler(struct clock_event_device *dev)
> +static void tick_lowres_handler(struct clock_event_device *dev)

Maybe tick_nohz_lowres_handler() is better?

You also have tick_periodic which is also 'lowres'.

That would also keep the "tick_nohz" prefix which is prevalent in this code.

>   {
>   	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
>   	struct pt_regs *regs = get_irq_regs();
> @@ -1401,7 +1401,7 @@ static void tick_nohz_switch_to_nohz(void)
>   	if (!tick_nohz_enabled)
>   		return;
>   
> -	if (tick_switch_to_oneshot(tick_nohz_handler))
> +	if (tick_switch_to_oneshot(tick_lowres_handler))
>   		return;
>   
>   	/*
> @@ -1464,7 +1464,7 @@ void tick_irq_enter(void)
>    * We rearm the timer until we get disabled by the idle code.
>    * Called with interrupts disabled.
>    */
> -static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
> +static enum hrtimer_restart tick_highres_handler(struct hrtimer *timer)

This one looks good.

thanks,

  - Joel


>   {
>   	struct tick_sched *ts =
>   		container_of(timer, struct tick_sched, sched_timer);
> @@ -1513,7 +1513,7 @@ void tick_setup_sched_timer(void)
>   	 * Emulate tick processing via per-CPU hrtimers:
>   	 */
>   	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
> -	ts->sched_timer.function = tick_sched_timer;
> +	ts->sched_timer.function = tick_highres_handler;
>   
>   	/* Get the next period (per-CPU) */
>   	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());

