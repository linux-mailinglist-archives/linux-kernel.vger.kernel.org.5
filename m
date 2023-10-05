Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A77B9DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjJENzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbjJENtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:49:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B29493F4;
        Thu,  5 Oct 2023 01:59:37 -0700 (PDT)
Date:   Thu, 05 Oct 2023 08:59:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696496375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hu3OvSqomvkKVlCsfwO3LVPRLmGAEPlXBoztNRh1qEA=;
        b=MzVk7DzNqSImBI9Ofjs8/zWEaaWJybOv5o4GaL8cQzRnRWvBVVqQW9se/aUy7Kvw38VqSi
        Zd5YSKl5vC48W0aCNSXSwLZhAvHP8h6mtkuJ8onm4fpuXlmdmKCxrLFoZmQL9jXQ15VQet
        I/KsXuWPuhtKWw0HL0jUtDWpsPxDZXoYWJa0Jrk5eB4iF3b9MzS4zOFa3F0hRlW49Gvv23
        h90NIe2GGSVxI2/ASZ3UdiowCOBH89FaiPaP3yihvS6saB99e9DJQfG47HaX7vpVy9LWDQ
        uv3d9do2eB8RyAzJhtdEx+hzpFsThDzQN3xl/YFJT4XKMKoA+RtOBRLwatOq9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696496375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hu3OvSqomvkKVlCsfwO3LVPRLmGAEPlXBoztNRh1qEA=;
        b=s8C4xUiqeSGkNtR+Wl2Gu/AbpE4YaMITvR8IXO4RPPv2Se7/hL5hNSG8XvMV1ZdRqdX/Ci
        +ZCx21UHYnDhHBCg==
From:   "tip-bot2 for Yajun Deng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Print 'tgid' in sched_show_task()
Cc:     Yajun Deng <yajun.deng@linux.dev>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230720080516.1515297-1-yajun.deng@linux.dev>
References: <20230720080516.1515297-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Message-ID: <169649637489.3135.8306333869717553667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9b46f1abc6d4e855ebd91b011aa3b49042bad7e4
Gitweb:        https://git.kernel.org/tip/9b46f1abc6d4e855ebd91b011aa3b49042bad7e4
Author:        Yajun Deng <yajun.deng@linux.dev>
AuthorDate:    Thu, 20 Jul 2023 16:05:16 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 10:49:56 +02:00

sched/debug: Print 'tgid' in sched_show_task()

Multiple blocked tasks are printed when the system hangs. They may have
the same parent pid, but belong to different task groups.

Printing tgid lets users better know whether these tasks are from the same
task group or not.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230720080516.1515297-1-yajun.deng@linux.dev
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5783cb..cf6d3fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9089,9 +9089,9 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
-		free, task_pid_nr(p), ppid,
-		read_task_thread_flags(p));
+	pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d flags:0x%08lx\n",
+		free, task_pid_nr(p), task_tgid_nr(p),
+		ppid, read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
