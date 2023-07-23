Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED46275E014
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 08:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGWGXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 02:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 02:23:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7610E7;
        Sat, 22 Jul 2023 23:23:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4052d327682so19249291cf.1;
        Sat, 22 Jul 2023 23:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690093391; x=1690698191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pgNUomoA1S4vwFAss5q0b7YSFR9OEzG22McdC65lJfs=;
        b=slKBOIsmDtcR6ZOWZyrPAEWFEeKSIhZeiXIMpODVnhkN1M/4mT7SpjYCqR7hig1VTY
         +yU/do4NtYaXThgkfqbN2D5qQv5qA380kaf+Z7RHlH2UeXshoPeckujEb/tfKAMWMu/I
         W1dXVaERD0S7mo6/gDgS2v10yFeVG+6umMP+e2QXpnDf/YWgchrl7sxeKMPTcKP7nv3S
         NPU6njcy69DMFeCuXRmyzoLqPkw0R5o7/wQeodJuPYsidppX/qIZAZRyzCOufNzXY0hq
         TJKHN6mbH3luVcqgDB6myKj3md7lK0KSi8ce3xi1hY9Pt0hlAD64p3Rcs02Ov9yKUVXb
         MFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690093391; x=1690698191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgNUomoA1S4vwFAss5q0b7YSFR9OEzG22McdC65lJfs=;
        b=PgD3iX1wkIuf9njESXMz8bX0rferUyRpCxE2WUOxyXWKbteWjjTraBrCavYEV/bJR1
         2NtFDgEyXgz8Trp5JN0d4ht6g5faa5OUUbnikcq1DGl1DQ+gQUaXViMwnt4uT1ONP1NX
         F8hkGijz9hlGKviZ5VN4BNzqtn9ejFF+DY4DcntheFDvM8CQh3PknWefGjO3G31pExHS
         d25OIhjR6HeG1LM+GFM2RqjIIyfY8o7dEjwNdko8O+Gc+3ubSO8v42uScrTgNDyeimDV
         BrTC9g10qISauE9JulOxX0GvCFI77myGQ1ojFoZibOPETIDc679vyUtPxX+E1R68o+aA
         z5jw==
X-Gm-Message-State: ABy/qLb2VtXV4PxpSq2T0BH0sxIj8W/0MnE/kBSrCoyf6KdfFcsDVan/
        wqL1jbfL5DI6VaJ74pMX4KjXdC8hr6FuiRiiVrkm7da3xzqMLw==
X-Google-Smtp-Source: APBJJlFDIShvfymNk6ueTOmxQrVX2vxSJpQDkOCqirs8jFzDQrZM1ehHuQi+7kRhveH/WtTQ1XzzxD6qJKeV9WPbb7Y=
X-Received: by 2002:ac8:7d16:0:b0:403:fdf1:e513 with SMTP id
 g22-20020ac87d16000000b00403fdf1e513mr5701726qtb.8.1690093391262; Sat, 22 Jul
 2023 23:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230721121534.44328-1-ppbuk5246@gmail.com> <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
 <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop> <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
 <31070aab-8665-44c4-8950-0631a777ef44@paulmck-laptop>
In-Reply-To: <31070aab-8665-44c4-8950-0631a777ef44@paulmck-laptop>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sun, 23 Jul 2023 07:23:00 +0100
Message-ID: <CAM7-yPSn8ietAJ8NKb0-VHDQhkHs73u--KFmO3rpTPUvcFuMvA@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on rcu_report_qs_rdp
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
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

Thanks for replying to reply Paul :)

> And try testing with CONFIG_RCU_STRICT_GRACE_PERIOD=y and CONFIG_PREEMPT=n.
> Though there might be better Kconfig options to use.  Those two come
> immediately to mind.

I've tested with this option via rcu torture.
and it doesn't report any problems.
and after commit 6d60ea03ac2d3 ("rcu: Report QS for outermost
PREEMPT=n rcu_read_unlock() for strict GPs")
it always makes cpu_no_qs.b.norm false whenever it calls
rcu_report_qs_rdp in rcu_read_unlock.

> But one critical piece is that softirq handlers, including the RCU_SOFTIRQ
> handler rcu_core_si(), can be invoked upon return from interrupts.

I think in that case, no problem because if it reports qs already,
rcu_check_quiescent_state wouldn't call rcu_report_qs_rdp again.
And if RCU_SOFTIRQ is called as soon as RCU interrupt is finished,
it seems the fastest one to notify qs to related tree.

> Another critical piece is that if a CPU is idle during any part of a
> grace period, the grace-period kthread can report a quiescent state on
> its behalf.

I think
    1) If timer interrupt is still programed,
          - when rcu_sched_clock_irq first reports qs, no problem
          - If qs is reported via grace period thread first,
note_gp_chagned in rcu interrupt
            will recognize this situation by setting core_needs_qs as false,
            it doesn't call rcu_report_qs_rdp thou cpu_no_qs.b.norm is true.

     2) If the timer interrupt isn't programmed,
          - rcu_gp_kthreaad reports its qs, no problem.

So, I think there's no problem removing
      "rdp->cpu_no_qs.b.norm" check in rcu_report_qs_rdp.
or wrap this condition check as WARN_ON_ONCE.

> Does that help?
Many thanks always :)

--------
SIncerely,
Levi.
