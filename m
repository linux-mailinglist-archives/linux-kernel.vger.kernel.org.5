Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031AF812A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjLNITD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjLNITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:19:01 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C0109
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:19:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6d2350636d6so372144b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702541948; x=1703146748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NUzmmsL1ZYH26dLfyMCpbQFSCnHCb1FNohT2hgdN0Ic=;
        b=h4nsaLKJOjBrM/V7EAavCciOLQrR1T2wr1JLC6L40T+OzRHgotHDQ8Q221H0APPKC6
         2TINIkmEjkUsxCbAPrbgSMqg9MbO4ku7HF2q4kTXNYZmoYp2MFgBo9JKkPO7AlfEqCbX
         MA+hU0s5FRP+6ZMpeCpJXQMqeClKnsR673xJMuYnoOWEGhvt4WpWI0OYF0+Q2TOiZZZe
         3tn1nTxHDmrPSQ4kT83JuQ+tBmOfI/WT5ZVCAv0IMnVCB4zb9sYTHUHfghIeTk9wpsPY
         SMtwWVJ+V6y4p0lW6Y892e5XO2GZr1x9sizPiiyMUgkYNPrdS3xoi9uZMwNN31aSFEfA
         v/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541948; x=1703146748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUzmmsL1ZYH26dLfyMCpbQFSCnHCb1FNohT2hgdN0Ic=;
        b=Xg8dw0WfZFrMPW29ILIGwCFCuudt4FkVdTeiI5bfedAXG5Xp3w7n9HSpdCOjSTfXww
         xFA2hM6/sRRFLV4ShwDnk3e5R1uRL/7xuucpct+ZAU6o1OnrY206yhSd/kd+nrK+UcP6
         WLgayfo3l9q1K/QlNZW+7LUTNobH8ipVdQcEaQGRjSKJC4xh59Jftc6YiAujUZU77jNM
         0JaOlUjT7WSKyXGw54wGmus2Fyi4waTfqfenOYggFb2L9BBS9Xd0tmi/RvwC3pipBbV+
         h7y0dBuA1NymwoSRJKDFZiQrXoIyLWI0Il1l91dLT9+uixmwQkq+Cay47MOhK7+cepWm
         /t7A==
X-Gm-Message-State: AOJu0YxpiTQIRKSZwb7dxJLsCFf6K9E2KynkvJWekRoI9WeYCicEDNkm
        hhzMBEF0btF1777nAtMZVEUXNVdqXib4yzXQfoansQ==
X-Google-Smtp-Source: AGHT+IFg36rRO4Q01NMSPrW4k+oGIOCkqwVw6CJKsNMuY1Wa9C7Y6beBUgsZsNb6Lmy8+pishGPxczjnVulVmphN2ag=
X-Received: by 2002:a05:6a00:98e:b0:6ce:10ed:7754 with SMTP id
 u14-20020a056a00098e00b006ce10ed7754mr10885356pfg.31.1702541947775; Thu, 14
 Dec 2023 00:19:07 -0800 (PST)
MIME-Version: 1.0
References: <202312141319+0800-wangjinchao@xfusion.com>
In-Reply-To: <202312141319+0800-wangjinchao@xfusion.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Dec 2023 09:18:56 +0100
Message-ID: <CAKfTPtCrBvyxJzeRDARFjbU8P5BYW27So7gYE4FPWBDC0=HL3Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: remove next_buddy_marked
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 06:20, Wang Jinchao <wangjinchao@xfusion.com> wrote:
>
> Remove unused `next_buddy_marked` in `check_preempt_wakeup_fair`
>

Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")

> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..d2028bfa4e94 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8210,7 +8210,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>         struct task_struct *curr = rq->curr;
>         struct sched_entity *se = &curr->se, *pse = &p->se;
>         struct cfs_rq *cfs_rq = task_cfs_rq(curr);
> -       int next_buddy_marked = 0;
>         int cse_is_idle, pse_is_idle;
>
>         if (unlikely(se == pse))
> @@ -8227,7 +8226,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>
>         if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
>                 set_next_buddy(pse);
> -               next_buddy_marked = 1;
>         }
>
>         /*
> --
> 2.40.0
>
