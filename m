Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A902E757C29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjGRMs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGRMsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:48:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92E194
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:48:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so42373985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689684502; x=1692276502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uX+Tm1S/tnom3XGxR87d/YDaIyrI7WNCyv7dHeUgar8=;
        b=rPtLlpfCY5uRfKv4WLFlgxHGk0E/X0NxAHcgtaCfIhmyjZi3CKWW+FVV2O9ab0KXxI
         FsW3dphdwFZsZatIr+4GufrKqr5lmzixo5CHukaefQdJJMhW47D6OuFyAXsMxxgA+9cc
         tyqg11FFi+lPHCuaRFXO2K2VKEZ41ApXnIGbDvyUQ6zCZA14RgYUJ0c16LLQiKQVvqog
         OAjKhfX8KxPGB2Kw7SkFstCWJJagSQtLZihPGbKYh3ro0vj6ArUuhOGAu7qYs2Ikf25X
         71D01yIy+4env9FFQWD6OuzgVjNDUPx9kixCk59M79p0ODiMMonsO5Pc/YtVydfrvkV5
         H3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684502; x=1692276502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX+Tm1S/tnom3XGxR87d/YDaIyrI7WNCyv7dHeUgar8=;
        b=UrOTe2isF90EdZlqtHEuxII0fRqUEpH2LMUkGLfLR0653HHBJfB121IqZhEiU10TZJ
         MF2m/xCYGRjWj1h3ToxO6DYP54M5Qb/4Xa43Yh2bC/EHjkY1hXxrPV0WAJ4BXE0oDQKF
         9RVjVY/nHwg0jrt2KZSdMglroAWgN1wIBRz0czTve9yp+fjsCx30cdyulrk1j5hFCT1o
         ncfNTFy6O3HDMFrgScdYw5HJ4QHJav5YG/+72YkKwclqqu0sRmcx6hZqRr31dnvONVED
         qBLF8Rc7kwh175ra2IAd2scfaSsbrOruUWg+k0Psrz+AfL3P2ThcZpf5Vm8iQwTb3UQa
         ZblA==
X-Gm-Message-State: ABy/qLYnELPrZJChz9diIlIAZS7Tv2fCEMAz+TQTDa9/8dWqkz/tDeUe
        nwzwTyLDlmb6eJm5w5pPc+mDAKnsqBt2c75bpDQ=
X-Google-Smtp-Source: APBJJlEbAsiaG+QahUEcokUaw3+g0S17as4Ee/SE8xEjC15PlGXPAyGOMONkZsVbGypYLt4SV+hJHw==
X-Received: by 2002:a05:6000:7:b0:314:914:66cc with SMTP id h7-20020a056000000700b00314091466ccmr10612523wrx.8.1689684502388;
        Tue, 18 Jul 2023 05:48:22 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:48e9:698d:5e54:4632])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d4fca000000b00314172ba213sm2269823wrw.108.2023.07.18.05.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:48:21 -0700 (PDT)
Date:   Tue, 18 Jul 2023 14:48:20 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Message-ID: <ZLaKFFjY6NWaJdOq@vingu-book>
References: <20230716014125.139577-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230716014125.139577-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 16 juil. 2023 à 02:41:25 (+0100), Qais Yousef a écrit :
> We've seen cases while running geekbench that an idle little core never
> pulls a task from a bigger overloaded cluster for 100s of ms and
> sometimes over a second.
> 
> It turned out that the load balance identifies this as a migrate_util
> type since the local group (little cluster) has a spare capacity and
> will try to pull a task. But the little cluster capacity is very small
> nowadays (around 200 or less) and if two busy tasks are stuck on a mid
> core which has a capacity of over 700, this means the util of each tasks
> will be around 350+ range. Which is always bigger than the spare
> capacity of the little group with a single idle core.
> 
> When trying to detach_tasks() we bail out then because of the comparison
> of:
> 
> 	if (util > env->imbalance)
> 		goto next;
> 
> In calculate_imbalance() we convert a migrate_util into migrate_task
> type if the CPU trying to do the pull is idle. But we only do this if
> env->imbalance is 0; which I can't understand. AFAICT env->imbalance
> contains the local group's spare capacity. If it is 0, this means it's
> fully busy.
> 
> Removing this condition fixes the problem, but since I can't fully
> understand why it checks for 0, sending this as RFC. It could be a typo
> and meant to check for
> 
> 	env->imbalance != 0
> 
> instead?
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..682d9d6a8691 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10288,7 +10288,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			 * waiting task in this overloaded busiest group. Let's
>  			 * try to pull it.
>  			 */
> -			if (env->idle != CPU_NOT_IDLE && env->imbalance == 0) {
> +			if (env->idle != CPU_NOT_IDLE) {

With this change you completely skip migrate_util for idle and newly idle case
and this would be too aggressive.

We can do something similar to migrate_load in detach_tasks():

---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d3df5b1642a6..64111ac7e137 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8834,7 +8834,13 @@ static int detach_tasks(struct lb_env *env)
 		case migrate_util:
 			util = task_util_est(p);

-			if (util > env->imbalance)
+			/*
+			 * Make sure that we don't migrate too much utilization.
+			 * Nevertheless, let relax the constraint if
+			 * scheduler fails to find a good waiting task to
+			 * migrate.
+			 */
+			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;

 			env->imbalance -= util;
--



>  				env->migration_type = migrate_task;
>  				env->imbalance = 1;
>  			}
> -- 
> 2.25.1
> 
