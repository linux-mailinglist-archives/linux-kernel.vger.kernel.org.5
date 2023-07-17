Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D565756380
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGQM5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjGQM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:56:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4161E4C;
        Mon, 17 Jul 2023 05:56:25 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92lmhT+dG1fCEpnWggpmb+mUFZZLK3m7F1sDk2Mftws=;
        b=gZ6Njn7LnURylnWOaU2VeHroM653SLxO3yN6EWUsFQBPmiLDKtTtLQT4BAWNms4IJtyWnU
        zo2Q3P45yk9blok0V3b3HS0jA/SecZCFgmBgPk8zUgLK0UZBDgWeGRaHGL2ncjiQwLqbB3
        KI7yvBUCmzf+Oiahul1JtyDJ4nkMcZkIQVDcZW0grt/rD3FWSa2S6R9XtpDUMwEAbRdjIx
        pq8yB2aK9f0At4Vf+IIawa/w147xOU750UoHBs9/vO1MVCMWyPIND9Q+BdX7BE7wfyvPwW
        n5JDQ4fvDCYZjPNgMvmVaWCjAZlkdmfhZzq8Xf7O4++cvX6tO26PRPh4yMf9bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92lmhT+dG1fCEpnWggpmb+mUFZZLK3m7F1sDk2Mftws=;
        b=jQTEvnVFj+xwLlzw6DGCeyAuGArw5R62G7j8AdwKORPLWcsD98IthrXGly4rBPa+RIy/i9
        fFMsDNkEZZrm05DA==
From:   "tip-bot2 for Chin Yik Ming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Rename task_struct::state to
 task_strate::__state in the comments too
Cc:     Chin Yik Ming <yikming2222@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230717064952.2804-1-yikming2222@gmail.com>
References: <20230717064952.2804-1-yikming2222@gmail.com>
MIME-Version: 1.0
Message-ID: <168959857012.28540.15629776654291437591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2ae2fb98b77339277a2c2f18dfec605dfd8dd321
Gitweb:        https://git.kernel.org/tip/2ae2fb98b77339277a2c2f18dfec605dfd8dd321
Author:        Chin Yik Ming <yikming2222@gmail.com>
AuthorDate:    Mon, 17 Jul 2023 14:49:52 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 17 Jul 2023 11:03:55 +02:00

sched/headers: Rename task_struct::state to task_strate::__state in the comments too

The rename in 2f064a59a11f ("sched: Change task_struct::state") missed the
comments.

[ mingo: Improved the changelog. ]

Signed-off-by: Chin Yik Ming <yikming2222@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Link: https://lore.kernel.org/r/20230717064952.2804-1-yikming2222@gmail.com
---
 include/linux/sched.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index efc9f4b..2aab7be 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -75,14 +75,14 @@ struct user_event_mm;
  * Task state bitmask. NOTE! These bits are also
  * encoded in fs/proc/array.c: get_task_state().
  *
- * We have two separate sets of flags: task->state
+ * We have two separate sets of flags: task->__state
  * is about runnability, while task->exit_state are
  * about the task exiting. Confusing, but this way
  * modifying one set can't modify the other one by
  * mistake.
  */
 
-/* Used in tsk->state: */
+/* Used in tsk->__state: */
 #define TASK_RUNNING			0x00000000
 #define TASK_INTERRUPTIBLE		0x00000001
 #define TASK_UNINTERRUPTIBLE		0x00000002
@@ -92,7 +92,7 @@ struct user_event_mm;
 #define EXIT_DEAD			0x00000010
 #define EXIT_ZOMBIE			0x00000020
 #define EXIT_TRACE			(EXIT_ZOMBIE | EXIT_DEAD)
-/* Used in tsk->state again: */
+/* Used in tsk->__state again: */
 #define TASK_PARKED			0x00000040
 #define TASK_DEAD			0x00000080
 #define TASK_WAKEKILL			0x00000100
@@ -173,7 +173,7 @@ struct user_event_mm;
 #endif
 
 /*
- * set_current_state() includes a barrier so that the write of current->state
+ * set_current_state() includes a barrier so that the write of current->__state
  * is correctly serialised wrt the caller's subsequent test of whether to
  * actually sleep:
  *
@@ -196,9 +196,9 @@ struct user_event_mm;
  *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
  * where wake_up_state()/try_to_wake_up() executes a full memory barrier before
- * accessing p->state.
+ * accessing p->__state.
  *
- * Wakeup will do: if (@state & p->state) p->state = TASK_RUNNING, that is,
+ * Wakeup will do: if (@state & p->__state) p->__state = TASK_RUNNING, that is,
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
  * TASK_RUNNING store which can collide with __set_current_state(TASK_RUNNING).
  *
