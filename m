Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9007A736D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjITG5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjITG52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:57:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D767CFF;
        Tue, 19 Sep 2023 23:57:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40434d284f7so67830735e9.3;
        Tue, 19 Sep 2023 23:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695193024; x=1695797824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hE/qji03TiPOurpi0HFY5M63jtvMquNZMVPwBMMf8zQ=;
        b=ZKOV0RK/C8+qi0nfpvQKKOyOdGL1WGGRoDxCzyWQ3tBwArMR/xON0Pk58QaWqivoY2
         iuhhoHpVuaVmvcNjNtZlOxNatc7hm0HJ9XtD9QeiShmEu+IrS2TNd+0bOl8oDkBWTpCE
         Vbr9h/qb8eE35RC1wjttIh/FaNOLI9mOmkxKIQxEOhhPSpyA2scOZSp5yoK8yO9EAPYK
         SCyU6cAroWF7yvx/PV2OU7Oc7yre5NtpvBcTLJvlFS4YYkTxjo3d+ypzXgXY0F5y14Hi
         4bgVAOJRWypDTfedTTuiNH+Ol29J5y0VsLiZYEJPzLYV+ndj+N0ZPrMGVkwxhzxhE6de
         rPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695193024; x=1695797824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hE/qji03TiPOurpi0HFY5M63jtvMquNZMVPwBMMf8zQ=;
        b=RxzI9b4VGSW1EEdXuUG8sJiGGl7UG2SogXyCRuZWtT9V4EQOqmhj+AN7g6hUryKpjE
         +Y6Fm9Xk0ez8tXMDXLWFCR40Zl76P1G3CBOe8o1CtnNkFlKlwe3zrpqvEYPdOWSfTFOK
         EJozVlopl3lzdL3GiorjmEtsWBi6umvSTDiM6f4/60R1zMATmHURe1jaXDqUGdqsWRmi
         OoKorCEvOdtGogFyVX8DOXC59k/2I2siEBVN7gqaRjpYfhDYpI7I1hk3ZyRjUp0uMP8W
         vwALNagyJiux0s8YTWlK9Dq5LmNrAp7RAUs0AC/WUbsDkCAcBvdNjUdi2hUdvD6no/QH
         YG4Q==
X-Gm-Message-State: AOJu0YzbC06jOibjFC25Viz+hHVOWEVgOBTGd7xnZxaRXsYuACCrXq/E
        5rmR6b8olGsCatxlrX4w5DHdG4sDXdU=
X-Google-Smtp-Source: AGHT+IHNr2ppsdCmN31UqIvpmf3PDSw2u9f6Hx229YYvRJ3IFDDZXomJdKbTLY/FqoQp2cH4YYpOVw==
X-Received: by 2002:a7b:c388:0:b0:405:a30:151e with SMTP id s8-20020a7bc388000000b004050a30151emr1681092wmj.12.1695193023602;
        Tue, 19 Sep 2023 23:57:03 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c089400b003fbe791a0e8sm1096397wmp.0.2023.09.19.23.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:57:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 20 Sep 2023 08:57:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org
Subject: Re: [tip: core/core] signal: Add a proper comment about
 preempt_disable() in ptrace_stop()
Message-ID: <ZQqXvPhesRmAtjvR@gmail.com>
References: <20230803100932.325870-2-bigeasy@linutronix.de>
 <169515461116.27769.12932058744920773528.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169515461116.27769.12932058744920773528.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Sebastian Andrzej Siewior <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the core/core branch of tip:
> 
> Commit-ID:     a20d6f63dbfc176697886d7709312ad0a795648e
> Gitweb:        https://git.kernel.org/tip/a20d6f63dbfc176697886d7709312ad0a795648e
> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate:    Thu, 03 Aug 2023 12:09:31 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Tue, 19 Sep 2023 22:08:29 +02:00
> 
> signal: Add a proper comment about preempt_disable() in ptrace_stop()
> 
> Commit 53da1d9456fe7 ("fix ptrace slowness") added a preempt-disable section
> between read_unlock() and the following schedule() invocation without
> explaining why it is needed.
> 
> Replace the existing contentless comment with a proper explanation to
> clarify that it is not needed for correctness but for performance reasons.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Link: https://lore.kernel.org/r/20230803100932.325870-2-bigeasy@linutronix.de
> 
> ---
>  kernel/signal.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 0901901..3035beb 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2329,10 +2329,22 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
>  		do_notify_parent_cldstop(current, false, why);
>  

Minor speling nits:

>  	/*
> -	 * Don't want to allow preemption here, because
> -	 * sys_ptrace() needs this task to be inactive.
> +	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
> +	 * One a PREEMPTION kernel this can result in preemption requirement

s/One
 /On

> +	 * which will be fulfilled after read_unlock() and the ptracer will be
> +	 * put on the CPU.
> +	 * The ptracer is in wait_task_inactive(, __TASK_TRACED) waiting for
> +	 * this task wait in schedule(). If this task gets preempted then it
> +	 * remains enqueued on the runqueue. The ptracer will observe this and
> +	 * then sleep for a delay of one HZ tick. In the meantime this task
> +	 * gets scheduled, enters schedule() and will wait for the ptracer.
>  	 *
> -	 * XXX: implement read_unlock_no_resched().
> +	 * This preemption point is not bad from a correctness point of
> +	 * view but extends the runtime by one HZ tick time due to the
> +	 * ptracer's sleep.  The preempt-disable section ensures that there
> +	 * will be no preemption between unlock and schedule() and so
> +	 * improving the performance since the ptracer will observe that

s/improving the performance
 /improving performance

> +	 * the tracee is scheduled out once it gets on the CPU.
>  	 */
>  	preempt_disable();
>  	read_unlock(&tasklist_lock);

Thanks,

	Ingo
