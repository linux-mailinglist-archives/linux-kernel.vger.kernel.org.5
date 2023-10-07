Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF77BC943
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbjJGRLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344125AbjJGRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:11:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32FE9C;
        Sat,  7 Oct 2023 10:11:02 -0700 (PDT)
Date:   Sat, 07 Oct 2023 17:11:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696698661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9W/7mWQnFitwcgGCOFt9OQeTwMOTrM02iphTm3u8Js=;
        b=wF2y3Wx9FxXBlE40ZtTSCnGfounNNZhP5vV0Y2ukhKcEdXfxTA2gIQTDFEucq54juvtVBT
        GvsFldzS+4WRYHmByNHE+rovj2xl7CYw1hzz6XlWmdGSQIzCPBN83YS4SIRxNlW/ORYE2z
        /lV2NyrgRH8LxtuUDFSVrqHJCjcC7VHCSBX12LIrSW8/v68O/nZUC3eJAjkYEECAw9xkRS
        1j3kT2k12zgY/G6eeTacEVsJD5Qq+C1D9uxMOZYinos6ehqoUqhZ3x8TYqNiYZz80vnCjv
        irjeXKPcXN1ihQiB3GBg2RG50ENIZyDR+IVYfhGUd4GcFWDke87i0PK/1FENEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696698661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9W/7mWQnFitwcgGCOFt9OQeTwMOTrM02iphTm3u8Js=;
        b=yvHkATSqm6EhzEwhZ9doHqir7/mb/lQLdYLda8yGF2YqcIUbNshW2sUdzYuPdXCueYOeWU
        wWPveov1dxrdxSCA==
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
Message-ID: <169669866063.3135.14858424410402561741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ea41bb514fe286bf50498b3c6d7f7a5dc2b6c5e0
Gitweb:        https://git.kernel.org/tip/ea41bb514fe286bf50498b3c6d7f7a5dc2b6c5e0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 04 Oct 2023 11:33:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Oct 2023 11:33:28 +02:00

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
