Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724537C8D01
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjJMSVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMSVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:21:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6CB91;
        Fri, 13 Oct 2023 11:21:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40776b200e5so3793015e9.2;
        Fri, 13 Oct 2023 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697221262; x=1697826062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gv9tvIF0FJcUZfx9a5PjRlvRxUAHlFbHKhq9rtR1+SM=;
        b=Jx0M6m4FSS6T6LnRxoh7pGwl3UyGqF11seGtQwCcXkE/Yi6kaplUL2aAtq81TRQ0gy
         3qy/hoEwmz27s4LC7+yVlArPXbsMI5NYNavhhrJ3diqxriiwp3uU+yATPk2TpgqlCUmt
         Z4pvV6LAGFbxhnTCHKhfa00nHTTZpZ5L61Y4BuGV7E2lKe48tukZOfTsVP30UHa7D0Vm
         lb3/j3xS8Y4rV/50V4IHZW6AXvGeErbA0g6dd8VTRnSDH0q6hTXUJDHUiJghG6Ty0+8U
         CGxihbDbPI0KFMQ57vtzPZ9YEdTWeOiuNDCek977noqfx+8s7dwhfAUeq8TX+AF1+Vtq
         myLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697221262; x=1697826062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv9tvIF0FJcUZfx9a5PjRlvRxUAHlFbHKhq9rtR1+SM=;
        b=mQjihCPy/AO5Q0TUZ6irRxLHoWgYtc0LNEoJPJL7lGUJj20OYG/8bOGGS3tysY97p+
         JiAbgs69SmR5sXbNOksq0I2dOk229l1fFgV1NC8TclJ5eeMGwG7QT5V45Zl6wSXk5DTt
         1H+R9JvnKgOHttxSxa51zspOxivx3Q/0iLnW2oBZ2F9TsLuCgbhTTIogN1X9tR34Okaz
         efNJiJ9goSIfGJZPPJzjzC5FNIVVXVLvfx0VZ8EJxgBET5aAtNKekM+gSPi/lGk8Ryil
         LVBkTrZe81pXHaz3LK4+vUBwuqB0hvtMhKsStmVw7jnkaUC0rm7D+djQRbNxgQoNrtlT
         X7qQ==
X-Gm-Message-State: AOJu0YxMgG2uIhlsQGyPQTfHKoUkvgdPuMfbvzUj4DEkor66djtZQ++k
        /Q9R8j46LqbPl7y7JTlO8GI=
X-Google-Smtp-Source: AGHT+IG0o6aMR2CPAIeUL7MdgJKlaB6hjSmfXfd3uql46yTPYWc65TiCib6s5bX0SPcUYuph/4qgyQ==
X-Received: by 2002:a05:600c:3781:b0:405:1bfb:ff14 with SMTP id o1-20020a05600c378100b004051bfbff14mr22984089wmr.9.1697221261269;
        Fri, 13 Oct 2023 11:21:01 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id ew14-20020a05600c808e00b004064ac107cfsm788824wmb.39.2023.10.13.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 11:21:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Oct 2023 20:20:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 1/2] sched/schedutil: rework performance estimation
Message-ID: <ZSmKiquvV6clE1ux@gmail.com>
References: <20231013151450.257891-1-vincent.guittot@linaro.org>
 <20231013151450.257891-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151450.257891-2-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> +
> +	/* The minimum utilization returns the highest level between:
> +	 * - the computed DL bandwidth needed with the irq pressure which
> +	 *   steals time to the deadline task.
> +	 * - The minimum bandwidth requirement for CFS.
> +	 */

Nit: please use the standard multi-line Linux kernel comment style.

> +	/* The maximum hint is a soft bandwidth requirement which can be lower
> +	 * than the actual utilization because of max uclamp requirments
>  	 */

Ditto.

> +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> +				 unsigned long min,
> +				 unsigned long max)
> +{
> +	unsigned long target;
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	if (rt_rq_is_runnable(&rq->rt))
> +		return max;
> +
> +	/* Provide at least enough capacity for DL + irq */
> +	target =  min;

s/  / /
s/irq/IRQ/

Thanks,

	Ingo
