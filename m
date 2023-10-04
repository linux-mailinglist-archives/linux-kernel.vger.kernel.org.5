Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1298D7B7C75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjJDJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjJDJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:42:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE5C1;
        Wed,  4 Oct 2023 02:42:06 -0700 (PDT)
Date:   Wed, 04 Oct 2023 09:42:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696412524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJiYFrvJON8gK8MTHd3O+emlPsMk3TFaqei9zpHXqGo=;
        b=fV7c0KiLnsz1pHeFI4BM0+mYXlB6FRZWfzrc6/wcOyZeKG2Ka6IoVpPEB9jyrbAdf/Z/CC
        pr9ma7Ue1Jl1DoUqvJaAcMo9k38fA5JLa5sszAsoXtiuxOnPSO/JXxts2AgBfJcg1R6Okf
        bxncTNkv+0ureqc8+7+i8QBfGlXeKJXR2TBXSS8sQ425Nq7hs3fE+sOuZpgS5Ew2agxT8W
        dGcC9w1UebR9TPmlrssUI0mAQxqpSlFR+z9UZAIuFuxykvLXO+Pm6TslYnu/vNUUH2Flb0
        Xd4kHy1+x2KI3z+f1LfkT3HOLKI6LtK5dH/4eR8W9EBumZydUBbhgA+lDq52qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696412524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJiYFrvJON8gK8MTHd3O+emlPsMk3TFaqei9zpHXqGo=;
        b=Dam5xGTfsBGdUENbBg7ocpHBDm3wzZdyfqMZ0QC6eWFGPUZf0BMBvwMxdEVCA5lnmOHKZ7
        8Q2nCfPTowyrJICw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Update stale comment in try_to_wake_up()
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230731085759.11443-1-zhangqiao22@huawei.com>
References: <20230731085759.11443-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Message-ID: <169641252378.3135.1619855657721221590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bdf85bec2b1ea852daf415cf6f1c9ef7d584c8c5
Gitweb:        https://git.kernel.org/tip/bdf85bec2b1ea852daf415cf6f1c9ef7d584c8c5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 04 Oct 2023 11:33:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Oct 2023 11:34:34 +02:00

sched/core: Update stale comment in try_to_wake_up()

The following commit:

  9b3c4ab3045e ("sched,rcu: Rework try_invoke_on_locked_down_task()")

... renamed try_invoke_on_locked_down_task() to task_call_func(),
but forgot to update the comment in try_to_wake_up().

But it turns out that the smp_rmb() doesn't live in task_call_func()
either, it was moved to __task_needs_rq_lock() in:

  91dabf33ae5d ("sched: Fix race in task_call_func()")

Fix that now.

Also fix the s/smb/smp typo while at it.

Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230731085759.11443-1-zhangqiao22@huawei.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 65e10ac..f5783cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4237,7 +4237,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 		 * __schedule().  See the comment for smp_mb__after_spinlock().
 		 *
-		 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
+		 * A similar smp_rmb() lives in __task_needs_rq_lock().
 		 */
 		smp_rmb();
 		if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
