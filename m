Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9A7A5D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjISJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjISJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:02:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F79114;
        Tue, 19 Sep 2023 02:02:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-404732a0700so54871915e9.0;
        Tue, 19 Sep 2023 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695114150; x=1695718950; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Di6TRREwMzSjvB1+KKc4g0hZUhvaDrJZsqeA8sG/pyY=;
        b=LtXkZSSZQ+SX9xljUeMlDFIOvIqTyS2UUdAIxEqIaAMXH3aJ6Qd19B0UETGKcdWuTo
         QoiwDcIiapHNUlkGmY2mMC3Ee2bDqCoPfzbMtBcEhJPIiRV7Ejc/uo463sWSrDRcJvVv
         K81AbTkEyY57PbgGQc24tVmKC0smKU0pJINlhW+fggtn3u/N4UCpIj31llLMFghzKlRl
         KvweSX7xaqMQXVBG/cfIQlgIE3QfhM2dpXQNgiIFng0tgQ1oEWrOR58GA0x5W0qd1j4g
         IVaVUp/5c+swRdEa6t/ddPJzVayFeVA90oT93O+DWFjq4OrJD+fbmpFTeUTO9PT2pIKS
         ob0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114150; x=1695718950;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Di6TRREwMzSjvB1+KKc4g0hZUhvaDrJZsqeA8sG/pyY=;
        b=OXJIAurDxwJWRfZAQercWiEYeUdEx1pUV7QY2+eLqay63rWKjnO9Sp/sGsuwfjyD2m
         ZZM42C3SMPMBlz/iLpgWbucrt/OlRaUrF8sOSzU3LPfkif0WCnEJXo1jPnpSRTgQs+gy
         ceINQ2dtiWpEXqv3G2ij06OLb0Id4AFPEiwoCt8g+/MfT6s/BoZYhTYjS7ZpU5SIB5hl
         ejPcqPjkox3+4yVxYdlhOylRnJfeQHPojKXQl7pqXpOT6ksGB9jpyFuOtI8oklAi44Vm
         j9rPBRNSESpi06JhlB8hZQVsb4E3WYxHXdjj7u9Uw30fiw3cGvaV2C/lJ/Cmgv+u7Mm0
         +XFA==
X-Gm-Message-State: AOJu0Ywn4DQb9RIJxfRHGAtktJui4DnlK9keec/OoTPl9GZLpwezKDvn
        a+z6L6Sdo574xcaZb4o3bms=
X-Google-Smtp-Source: AGHT+IGVS+SOCaFQHpBTm0l9mfm/G4B92f3jUACVF/viIy/IXxr3Gcshb8lJaFqVvI+WXjnBJOmSWg==
X-Received: by 2002:a05:600c:114f:b0:402:f503:6d1b with SMTP id z15-20020a05600c114f00b00402f5036d1bmr10052608wmz.0.1695114149341;
        Tue, 19 Sep 2023 02:02:29 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id o4-20020a1c7504000000b00401d8810c8bsm17298895wmc.15.2023.09.19.02.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:02:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 19 Sep 2023 11:02:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: [PATCH] sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks
Message-ID: <ZQljoiSBhZLEFI/G@gmail.com>
References: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
 <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
 <21f3d376-17d6-8fb6-5f35-507ea931c0d3@amd.com>
 <02f6a15f094adb3c8d9957b031941d6bd10c2e43.camel@gmx.de>
 <f0859f35-39ec-e5dc-b77a-79162516de31@amd.com>
 <0e153dd25900af70f91e4a73f960320e6daf3c6a.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e153dd25900af70f91e4a73f960320e6daf3c6a.camel@gmx.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2023-08-22 at 08:33 +0530, K Prateek Nayak wrote:
> > Hello Mike,
> 
> Greetings!
> 
> > > FWIW, there are more tbench shards lying behind EEVDF than in front.
> > >
> > > tbench 8 on old i7-4790 box
> > > 4.4.302      4024
> > > 6.4.11       3668
> > > 6.4.11-eevdf 3522
> > >
> >
> > I agree, but on servers, tbench has been useful to identify a variety of
> > issues [1][2][3] and I believe it is better to pick some shards up than
> > leave them lying around for others to step on :)
> 
> Absolutely, but in this case it isn't due to various overheads wiggling
> about and/or bitrot, everything's identical except the scheduler, and
> its overhead essentially is too.
> 
> taskset -c 3 pipe-test
> 6.4.11       1.420033 usecs/loop -- avg 1.420033 1408.4 KHz
> 6.4.11-eevdf 1.413024 usecs/loop -- avg 1.413024 1415.4 KHz
> 
> Methinks these shards are due to tbench simply being one of those
> things that happens to like the CFS notion of short term fairness a bit
> better than the EEVDF notion, ie are inevitable fallout tied to the
> very thing that makes EEVDF service less spiky that CFS, and thus will
> be difficult to sweep up.
> 
> Too bad I didn't save Peter's test hack to make EEVDF use the same
> notion of fair (not a keeper) as I think that would likely prove it.

BTW., if overscheduling is still an issue, I'm wondering whether we
could go so far as to turn off wakeup preemption for same-prio
SCHED_OTHER tasks altogether, as per the attached patch?

What does this do to your various tests? Test booted only.

Thanks,

	Ingo

=============>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 19 Sep 2023 10:49:51 +0200
Subject: [PATCH] sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks

Reduce overscheduling some more: do not wakeup-preempt same-priority
SCHED_OTHER tasks.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a502e3255392..98efe01c8e4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8042,7 +8042,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
 	 * is driven by the tick):
 	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (unlikely(p->policy != SCHED_NORMAL) || likely(p->prio == curr->prio) || !sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);

