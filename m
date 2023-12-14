Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0378131D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjLNNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjLNNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:41:18 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF9C1AA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:41:19 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-59082c4aadaso4389532eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561279; x=1703166079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HWTMFVmMbEpF8wfZqrkwEarPOGCkepSoyaCCDNsAZ2M=;
        b=b2NqE3H6GM3cAA/h1JNyAZhAW+hK6UkteiZNI+8h5ld5AQwf+rOUSg5ZEmaxv7v6JE
         LeMzjwaSbAdxzTHNH3DAmxKU+8UPx1VEbahsGpnDKBWjZ+GYN4rw7NVMD2d7zqrsUWiZ
         WVe2dT1ItGOKIRfloYn8o8KpevLHrXJMnM6qUfioyacuw2ZeDg0k5xH2fqfA0yv4u8Re
         YWB34kqP/SZSQMncAsRUDUPNBqpujQ/z6aSWFLyCqTXZkZwXs8dUwT+QsRQr9AceOUur
         l2dp4Tg9EwD8XyaIdxDL68BamBZyAOBSMyaBssDXT9AlA/fdfZWdYpH8Khf7WhtC8m5Y
         3guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561279; x=1703166079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWTMFVmMbEpF8wfZqrkwEarPOGCkepSoyaCCDNsAZ2M=;
        b=vbe6U0XFXGq6UX3iSeWvnxR6tq8xbLaGHuSrvIt7V+RAqWNc3BRz4Usv26oVsDfkQk
         SU/W7+ms+Scz0IQv1dNfZJqionQIEt98AdMJFH0UFavcT33zxWKOVEaaEWrxaydUaLrf
         DzHvKZlcTwOzpFgZdDgAGE6DEkFcyIiOS15ABfXtUI+AbDZtlPyEu8/yv1PX4Bs63gvc
         9rUibxEggGDFluTbvmXI/RNMy81QRIcMEaHVIUdIkjl6eUVgYu5YMOTvOga0aHMPgEkN
         6Kso7VDziEpJ8jVGZXB3HdWsYtPPZyPkNnAVj/5zlx1VashggrffoI/0YxFV57rN6tq5
         Q8sQ==
X-Gm-Message-State: AOJu0YyQSYwqJZqvcwTCDYY3zAF4EuaE8XGo0qwZ4y2yzudvWQysYYbr
        2P5aHL+NogozKpKNI3ELNYvEPjjlJHQ7Wlo9xAcFMw==
X-Google-Smtp-Source: AGHT+IEyHp5eLITSx6QCy8DQE5NqnWr5BfXGWZV7OFrd5p7AjyQp66km8gcUq9Cha9Z9DH/jma5XTGFWRdkl9mWwtYU=
X-Received: by 2002:a05:6358:722:b0:170:c2d0:7225 with SMTP id
 e34-20020a056358072200b00170c2d07225mr7561558rwj.7.1702561279072; Thu, 14 Dec
 2023 05:41:19 -0800 (PST)
MIME-Version: 1.0
References: <202312141319+0800-wangjinchao@xfusion.com> <CAKfTPtCrBvyxJzeRDARFjbU8P5BYW27So7gYE4FPWBDC0=HL3Q@mail.gmail.com>
 <83099016-f609-4ac0-94ab-909ac9c96582@bytedance.com>
In-Reply-To: <83099016-f609-4ac0-94ab-909ac9c96582@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Dec 2023 14:41:07 +0100
Message-ID: <CAKfTPtCUUk_QEJkZSQZL6q-42bTmqnRPXMtHME==ZCA53bg5rg@mail.gmail.com>
Subject: Re: Re: [PATCH] sched/fair: remove next_buddy_marked
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Wang Jinchao <wangjinchao@xfusion.com>,
        Ingo Molnar <mingo@redhat.com>,
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

On Thu, 14 Dec 2023 at 13:23, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> On 12/14/23 4:18 PM, Vincent Guittot Wrote:
> > On Thu, 14 Dec 2023 at 06:20, Wang Jinchao <wangjinchao@xfusion.com> wrote:
> >>
> >> Remove unused `next_buddy_marked` in `check_preempt_wakeup_fair`
> >>
> >
> > Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")
>
> After this commit @pse preempts curr without being the NEXT_BUDDY, but
> IMHO it should be, so how about this?
>
> @@ -8259,8 +8259,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>          /*
>           * XXX pick_eevdf(cfs_rq) != se ?
>           */
> -       if (pick_eevdf(cfs_rq) == pse)
> +       if (pick_eevdf(cfs_rq) == pse) {
> +               if (!next_buddy_marked)
> +                       set_next_buddy(pse);

I don't think this is needed because :
- NEXT_BUDDY is false by default so pick_next_entity() will not take
care of this
- pick_next_entity() will call pick_eevdf() which should return pse
unless another se that want to run 1st, wakes up in the meantime and
we should probably not take into account next buddy in this case

>                  goto preempt;
> +       }
>
>          return;
>
> which will align with before.
