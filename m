Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4918B7F3872
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjKUVjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:39:42 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523ABB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:39:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6be0277c05bso5459319b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700602779; x=1701207579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGLCUVDuNtxWVmydf8Y4yiFiZ2xJ6VoxgSulj+ZJDp4=;
        b=Dzw9o8G9C6786YxrwE6mmX5m4M/1lJg/jMK/OVHTDZfT9gFLuCJPtiJ3OucYKbvkEv
         XjiJQfAtF1HDniOkezSjLGnjnGeDFFLibQPw2oPQn7B367r4oO+wH7AyuSo7lc2yN1E9
         NSUE6dhJ+oIWqMLIpzKeqyO5CRifWNXG5i1mM/Bew5JEY9V5aDfHV+nVNXAB+ne0RJ9w
         kbJynUmZz1il3UHf0+fGPXDzEEMsojd9dWFjYSlcOWl68dSnPkddjkC6pt/OJ4fTOi5p
         nrHgbBDGN2UgtkHbkr+LUqo1o9BBvL1+LDsjmFOYwyDMNk0wQqeZ6Ei+GJwZavYpsUDT
         AB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602779; x=1701207579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGLCUVDuNtxWVmydf8Y4yiFiZ2xJ6VoxgSulj+ZJDp4=;
        b=tvl8uCZZQolldyuiMogPNR5qmzISrFTxRURDbuUOi5I4JDlPjyb78VqksjrRA9HNQc
         yS7U8b463zM7isQGMfhmhmj+uqKGhVSwkqjrWjv+Mdxprs+Rrt8SidmnXqm+0F7oAX0K
         dfl9VoGLTW6Y3xGnQGo2lTDIhk1mtedrOh73lguWmaY8y6yazPkpNDkDbayWtMU/+kXT
         BnA4l3awAO0EUh0TxNwSw2l84c+jsQjF3aPsMbs7pqs2CA1wi1MB5LismpJG72M7ny3D
         vYD1qrXjRZEvijD4E7pp+5X+KaRIr4RdaoZv3KVGMBp208H91fvTznLpuTdmslg0Dfor
         Qdig==
X-Gm-Message-State: AOJu0Yz5RAqlMJUuJM4nF7bsH2RRP4qUi9UqyDmSZfyyZ9hxfzWPMldd
        RJro1H7gFTf5dg9VIWlQ3StXT/Bc1XxJvQ==
X-Google-Smtp-Source: AGHT+IHiKcXGReso5iga9bRity172uSu8G+KnPkCku9tNcuCoEJVTBvH9YLqNJqLMq1FP3ijlvUaew==
X-Received: by 2002:a05:6a20:2585:b0:188:c44:5e5 with SMTP id k5-20020a056a20258500b001880c4405e5mr369268pzd.30.1700602778400;
        Tue, 21 Nov 2023 13:39:38 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id h10-20020a63df4a000000b0059d219cb359sm8424240pgj.9.2023.11.21.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:39:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 21 Nov 2023 11:39:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     zhuangel570 <zhuangel570@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] workqueue: Make sure that wq_unbound_cpumask is never empty
Message-ID: <ZV0jmGSismObVncD@slm.duckdns.org>
References: <20231120121623.119780-1-alexyonghe@tencent.com>
 <ZVuudtAtDqHqYJr8@slm.duckdns.org>
 <CANZk6aTS9BODJiqtDSHxwhz2dV3RmaxRautR8WZfH5aYYhcQJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANZk6aTS9BODJiqtDSHxwhz2dV3RmaxRautR8WZfH5aYYhcQJw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot, depending on how the housekeeping and workqueue.unbound_cpus
masks are set, wq_unbound_cpumask can end up empty. Since 8639ecebc9b1
("workqueue: Implement non-strict affinity scope for unbound workqueues"),
this may end up feeding -1 as a CPU number into scheduler leading to oopses.

  BUG: unable to handle page fault for address: ffffffff8305e9c0
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  ...
  Call Trace:
   <TASK>
   select_idle_sibling+0x79/0xaf0
   select_task_rq_fair+0x1cb/0x7b0
   try_to_wake_up+0x29c/0x5c0
   wake_up_process+0x19/0x20
   kick_pool+0x5e/0xb0
   __queue_work+0x119/0x430
   queue_work_on+0x29/0x30
  ...

An empty wq_unbound_cpumask is a clear misconfiguration and already
disallowed once system is booted up. Let's warn on and ignore
unbound_cpumask restrictions which lead to no unbound cpus. While at it,
also remove now unncessary empty check on wq_unbound_cpumask in
wq_select_unbound_cpu().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Yong He <alexyonghe@tencent.com>
Link: http://lkml.kernel.org/r/20231120121623.119780-1-alexyonghe@tencent.com
Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for unbound workqueues")
Cc: stable@vger.kernel.org # v6.6+
---
Hello,

Yong He, zhuangel570, can you please verify that this patch makes the oops
go away? Waiman, this touches code that you've recently worked on. AFAICS,
they shouldn't interact or cause conflicts. cc'ing just in case.

Thanks.

 kernel/workqueue.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6e578f576a6f..0295291d54bc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1684,9 +1684,6 @@ static int wq_select_unbound_cpu(int cpu)
 		pr_warn_once("workqueue: round-robin CPU selection forced, expect performance impact\n");
 	}
 
-	if (cpumask_empty(wq_unbound_cpumask))
-		return cpu;
-
 	new_cpu = __this_cpu_read(wq_rr_cpu_last);
 	new_cpu = cpumask_next_and(new_cpu, wq_unbound_cpumask, cpu_online_mask);
 	if (unlikely(new_cpu >= nr_cpu_ids)) {
@@ -6515,6 +6512,17 @@ static inline void wq_watchdog_init(void) { }
 
 #endif	/* CONFIG_WQ_WATCHDOG */
 
+static void __init restrict_unbound_cpumask(const char *name, const struct cpumask *mask)
+{
+	if (!cpumask_intersects(wq_unbound_cpumask, mask)) {
+		pr_warn("workqueue: Restricting unbound_cpumask (%*pb) with %s (%*pb) leaves no CPU, ignoring\n",
+			cpumask_pr_args(wq_unbound_cpumask), name, cpumask_pr_args(mask));
+		return;
+	}
+
+	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, mask);
+}
+
 /**
  * workqueue_init_early - early init for workqueue subsystem
  *
@@ -6534,11 +6542,11 @@ void __init workqueue_init_early(void)
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
-	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
-	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
-
+	cpumask_copy(wq_unbound_cpumask, cpu_possible_mask);
+	restrict_unbound_cpumask("HK_TYPE_WQ", housekeeping_cpumask(HK_TYPE_WQ));
+	restrict_unbound_cpumask("HK_TYPE_DOMAIN", housekeeping_cpumask(HK_TYPE_DOMAIN));
 	if (!cpumask_empty(&wq_cmdline_cpumask))
-		cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, &wq_cmdline_cpumask);
+		restrict_unbound_cpumask("workqueue.unbound_cpus", &wq_cmdline_cpumask);
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
