Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62378EE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346351AbjHaNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346334AbjHaNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:12:46 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE0E45
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 06:12:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso266381cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693487562; x=1694092362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/huV5o30ehyBDkZTLAeL6fF4iNyMfdkbrHpT0k6p7w=;
        b=JEEGdW7Df4+eZS9q9mioz6hTbBnhFF5+hnHvlo71vwmhpxksSXInE3keIGmjrWY+nE
         ubrkQdXYSu9v2UP2S6H0WF07JnrASkJwgcky9bibSb7OH6lHCXRlNezqZUlpEHSceW0k
         ebJ0fzZixK5Z80T6mcq0nykOodLliLYOArDqkL0Bv8pg3/QBgTYup1bw+3DlgX4pvHD1
         uuQcvHYhaGo+286BA9yWWsHx2miI/Yajb/XmtEIbe70L1G6i0I1Dg8b3Cn52lTzd5i2s
         8Ad8a3nfXbtbA5alABNejlvwlUu9iRM5M/LIwru1GNlmFogjNj/xwgtIN40HZsyemLPH
         Ea5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487562; x=1694092362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/huV5o30ehyBDkZTLAeL6fF4iNyMfdkbrHpT0k6p7w=;
        b=LwAiN8ZbQEjUwaUj5uLcgDuJWfiOj+o4Tr9dzOHHEVZLUnj3FHzU5ngrrHo764hOpY
         PdCDscWm0YgDtFRXF+iqPq0EwJJCmRY2dw4SwXFh5pyBf9CgrXAFsdy1XlyIxqoxaAKO
         4dEPlFXzExExtSCFpm0SubLZ3ZEH9vuiKUGQOx8j3VLZpW7E+7hDn3HfVEKs/jsAKnhZ
         Kct70fcW0qWEaJAn9qOVTO7kHadrjGxqqDqomTDfvDSHn+3GXvCcA+TJPxTsWIqIxbD/
         OE/Fl3qxxnemlgEShSgDYnMdijwZwXIQseCynmokzrvlrxuf2zQNxGf+OunJExaNQQx7
         2P5A==
X-Gm-Message-State: AOJu0YxktvuC4f60Q8C+Asss+lSH2NzE2ncJv+W0bWAGFTX00g65Hlal
        0PGnYVa7YoY2vsJ9jIcXxrAbjOHuUj6v2BXKf+THJw==
X-Google-Smtp-Source: AGHT+IH2mkhQfIcjyTWUqv498TnaRV47GCJhQNbYRwFZwHLARHlgpCh8NdEpndJYLzEfOEy2RNlPQC1YpcWg7JoGIYA=
X-Received: by 2002:ac8:7e83:0:b0:403:ac9c:ac2f with SMTP id
 w3-20020ac87e83000000b00403ac9cac2fmr189216qtj.17.1693487561914; Thu, 31 Aug
 2023 06:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
 <20230831114108.4744-1-hdanton@sina.com>
In-Reply-To: <20230831114108.4744-1-hdanton@sina.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 31 Aug 2023 15:12:30 +0200
Message-ID: <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To:     Hillf Danton <hdanton@sina.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Netdev <netdev@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 2:17=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Wed, 30 Aug 2023 21:44:57 +0900 Tetsuo Handa <penguin-kernel@I-love.SA=
KURA.ne.jp>
> >On 2023/08/30 20:26, Hillf Danton wrote:
> >>> <4>[  399.014716] Call trace:
> >>> <4>[  399.015702]  percpu_counter_add_batch+0x28/0xd0
> >>> <4>[  399.016399]  dst_destroy+0x44/0x1e4
> >>> <4>[  399.016681]  dst_destroy_rcu+0x14/0x20
> >>> <4>[  399.017009]  rcu_core+0x2d0/0x5e0
> >>> <4>[  399.017311]  rcu_core_si+0x10/0x1c
> >>> <4>[  399.017609]  __do_softirq+0xd4/0x23c
> >>> <4>[  399.017991]  ____do_softirq+0x10/0x1c
> >>> <4>[  399.018320]  call_on_irq_stack+0x24/0x4c
> >>> <4>[  399.018723]  do_softirq_own_stack+0x1c/0x28
> >>> <4>[  399.022639]  __irq_exit_rcu+0x6c/0xcc
> >>> <4>[  399.023434]  irq_exit_rcu+0x10/0x1c
> >>> <4>[  399.023962]  el1_interrupt+0x8c/0xc0
> >>> <4>[  399.024810]  el1h_64_irq_handler+0x18/0x24
> >>> <4>[  399.025324]  el1h_64_irq+0x64/0x68
> >>> <4>[  399.025612]  _raw_spin_lock_bh+0x0/0x6c
> >>> <4>[  399.026102]  cleanup_net+0x280/0x45c
> >>> <4>[  399.026403]  process_one_work+0x1d4/0x310
> >>> <4>[  399.027140]  worker_thread+0x248/0x470
> >>> <4>[  399.027621]  kthread+0xfc/0x184
> >>> <4>[  399.028068]  ret_from_fork+0x10/0x20
> >>
> >> static void cleanup_net(struct work_struct *work)
> >> {
> >>      ...
> >>
> >>      synchronize_rcu();
> >>
> >>      /* Run all of the network namespace exit methods */
> >>      list_for_each_entry_reverse(ops, &pernet_list, list)
> >>              ops_exit_list(ops, &net_exit_list);
> >>      ...
> >>
> >> Why did the RCU sync above fail to work in this report, Eric?
> >
> > Why do you assume that synchronize_rcu() failed to work?
>
> In the ipv6 pernet_operations [1] for instance, dst_entries_destroy() is
> invoked after RCU sync to ensure that nobody is using the exiting net,
> but this report shows that protection falls apart.

Because synchronize_rcu() is not the same than rcu_barrier()

The dst_entries_add()/ percpu_counter_add_batch() call should not
happen after an rcu grace period.

Something like this (untested) patch

diff --git a/net/core/dst.c b/net/core/dst.c
index 980e2fd2f013b3e50cc47ed0666ee5f24f50444b..f02fdd1da6066a4d56c2a0aa803=
8eca76d62f8bd
100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);

 void dst_release(struct dst_entry *dst)
 {
-       if (dst && rcuref_put(&dst->__rcuref))
+       if (dst && rcuref_put(&dst->__rcuref)) {
+               if (!(dst->flags & DST_NOCOUNT)) {
+                       dst->flags |=3D DST_NOCOUNT;
+                       dst_entries_add(dst->ops, -1);
+               }
                call_rcu_hurry(&dst->rcu_head, dst_destroy_rcu);
+       }
 }
 EXPORT_SYMBOL(dst_release);

It is not even clear why we are still counting dst these days.
We removed the ipv4 route cache a long time ago, and ipv6 got a
similar treatment.
