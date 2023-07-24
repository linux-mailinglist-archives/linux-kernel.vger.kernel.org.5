Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056575EA05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGXDVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:21:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C57313D;
        Sun, 23 Jul 2023 20:21:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262d33fa37cso1907953a91.3;
        Sun, 23 Jul 2023 20:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690168876; x=1690773676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/vh+lK1Kh/jWqDSpT68Nj187KVXpeHhtW55C4KVCYTk=;
        b=iA/Ir/yGS0vqXQZi4NOyNhedqIeJhPp3btHk7G1v9ThEQtt7OtrG8tJURqt+Li4WyW
         Qauzg9aBt5YDzl+qInTFWzgjGTB8sSeSQgVEIePQugCQtTANxP1ilXT2APH3niscwpxY
         D0JxS8xqEHc9HUCPWdqUQ95Zb72o3v+T/oj/y6YB1hmANQE9IEQriSnAsFQ7GiraGy+1
         6tMA+020gpkM47AAsrglLQQgS5bz5iKGUOMCE2cFT3DqqxBJB0/dlSg+PGzMDz95P2+H
         Jq23+GTpr4fDuOGHOpxaF7XLez72wPqEK4s+M7w36g81E8Vo339tixNgPo8S9bzekE6d
         JRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690168876; x=1690773676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vh+lK1Kh/jWqDSpT68Nj187KVXpeHhtW55C4KVCYTk=;
        b=OK2SzRUFogeH9rZKxNhc+KS6tOGklJTKvPVZn/KQJNdCO4cwAjfijZQC1OXXNUNZHJ
         h3ou+4W+jY2EspX5sNdit0DfvOjv2ilh3NEPa9V8C3pmx1XqB1e/YoVUG8M6Mx8zEi+g
         MbawDfHU1axQU/bXw06Xevw/XCYcqNgbUjy4t0Fuxosrauaf/dGGv6iVe5NkXLmGHbkG
         5/P3cabEOX5Tp1N33TdBy0TUMkvVXU24GG5/4TUcJW8JDH0nWleBQhHrTzxBg8rWzrot
         kmjC0DleunX+s86dBo6kZSdr5zCR2KzIuyxzVNZX98qXy8Ptsabdx6Mmst47Xf3/7fZ+
         2PwQ==
X-Gm-Message-State: ABy/qLa+jR6AqXxPt/7PNuwDNU03iw7E3IGirXC7eX55A8/MWMbPFRTh
        u7PolZ/S+q3+PDwafd8c3SAy4aTWF7dzGbinyMtY3nnSEck=
X-Google-Smtp-Source: APBJJlHGLB6OIEJJMDDXEPw9cpQLWZTCMVrlutdyPmJ2m/b+yBTr5E0zMBA2SgaqhVDIldRwS3ig/mQxDwoHAbjC+PI=
X-Received: by 2002:a17:90a:f2d3:b0:267:ce35:2f10 with SMTP id
 gt19-20020a17090af2d300b00267ce352f10mr7398282pjb.4.1690168876417; Sun, 23
 Jul 2023 20:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230721121534.44328-1-ppbuk5246@gmail.com> <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
 <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop> <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
 <31070aab-8665-44c4-8950-0631a777ef44@paulmck-laptop> <CAM7-yPSn8ietAJ8NKb0-VHDQhkHs73u--KFmO3rpTPUvcFuMvA@mail.gmail.com>
In-Reply-To: <CAM7-yPSn8ietAJ8NKb0-VHDQhkHs73u--KFmO3rpTPUvcFuMvA@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Mon, 24 Jul 2023 11:21:04 +0800
Message-ID: <CALm+0cWeZnMUk8Lj_nF3Htd14czGcT_Yt71nVwJdGhTECQOAWg@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on rcu_report_qs_rdp
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Thanks for replying to reply Paul :)
>
> > And try testing with CONFIG_RCU_STRICT_GRACE_PERIOD=y and CONFIG_PREEMPT=n.
> > Though there might be better Kconfig options to use.  Those two come
> > immediately to mind.
>
> I've tested with this option via rcu torture.
> and it doesn't report any problems.
> and after commit 6d60ea03ac2d3 ("rcu: Report QS for outermost
> PREEMPT=n rcu_read_unlock() for strict GPs")
> it always makes cpu_no_qs.b.norm false whenever it calls
> rcu_report_qs_rdp in rcu_read_unlock.
>
> > But one critical piece is that softirq handlers, including the RCU_SOFTIRQ
> > handler rcu_core_si(), can be invoked upon return from interrupts.
>
> I think in that case, no problem because if it reports qs already,
> rcu_check_quiescent_state wouldn't call rcu_report_qs_rdp again.
> And if RCU_SOFTIRQ is called as soon as RCU interrupt is finished,
> it seems the fastest one to notify qs to related tree.
>
> > Another critical piece is that if a CPU is idle during any part of a
> > grace period, the grace-period kthread can report a quiescent state on
> > its behalf.
>
> I think
>     1) If timer interrupt is still programed,
>           - when rcu_sched_clock_irq first reports qs, no problem
>           - If qs is reported via grace period thread first,
> note_gp_chagned in rcu interrupt
>             will recognize this situation by setting core_needs_qs as false,
>             it doesn't call rcu_report_qs_rdp thou cpu_no_qs.b.norm is true.
>
>      2) If the timer interrupt isn't programmed,
>           - rcu_gp_kthreaad reports its qs, no problem.
>
> So, I think there's no problem removing
>       "rdp->cpu_no_qs.b.norm" check in rcu_report_qs_rdp.
> or wrap this condition check as WARN_ON_ONCE.
>
> > Does that help?
> Many thanks always :)
>


Hi Levi

For built with CONFIG_RCU_STRICT_GRACE_PERIOD=y and CONFIG_PREEMPT=n kernels
Consider the following scenario:

__rcu_read_unlock()
   -> rcu_read_unlock_strict()
        ->rdp = this_cpu_ptr(&rcu_data);
        ->rdp->cpu_no_qs.b.norm = false;

                 by interrupt and return invoke rcu_core():
                 ->rcu_check_quiescent_state()
                      ->rdp = raw_cpu_ptr(&rcu_data);
                      -> rcu_check_quiescent_state(rdp);
                            ->note_gp_changes(rdp);
                                -> __note_gp_changes(rnp, rdp)
                                start new gp
                                ->rdp->cpu_no_qs.b.norm = true;

        ->rcu_report_qs_rdp(rdp);
           ->if (rdp->cpu_no_qs.b.norm || ...)


Thanks
Zqiang


>
> --------
> SIncerely,
> Levi.
