Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6378CD09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbjH2Tcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbjH2Tcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:32:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF9BE54;
        Tue, 29 Aug 2023 12:32:11 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:32:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693337527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZva0Go0t2/1BE1TycCSjFj8uIFzc5CbzN9FzaGttv0=;
        b=HISyNREZOcb5SdHK6QMlsOgclmchFC5FVCY5ksOx0wu2YWrtY+iRY+aRGO1ZAxgFaRVxRx
        16vzNt1EvEM/y1PHQB6n7RxIFQjmZLrgDQZ8MpkPYe7CN0dbcOnOWMqLo247CDPZUs58Mx
        MEFKcvFr13f4U5GpNfKHTXCuRqhgBdxMvytQeJz+G2HWifhg5QHmBiqfxIKjrFpIteT9LP
        HORr76nYWJUxjJ9dKGfhOz0ZR23I+SF5lJJm3uGo2xhjlGdWAx2B/koPmhag1ENpB/u7yn
        b9o5e621WrpGFmOgSMJj5+9A1rXtDe00N6i/4GgamXBxRkQM5G6Q5ebk6GN4lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693337527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZva0Go0t2/1BE1TycCSjFj8uIFzc5CbzN9FzaGttv0=;
        b=x9lb+9hxAnxJFlzNoitR/hhBiA9RABqKdbyzWlLiyQrzF5/KgBR//o2+iRKOX3y/JUef/J
        DQevIJcsyL1X94Ag==
From:   "tip-bot2 for Costa Shulyupin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Add kernel-doc for set_cpus_allowed_ptr()
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230829082551.2661290-1-costa.shul@redhat.com>
References: <20230829082551.2661290-1-costa.shul@redhat.com>
MIME-Version: 1.0
Message-ID: <169333752669.27769.1783695190968974030.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ae89408341f59e39d3b7d9e0d58905722136a176
Gitweb:        https://git.kernel.org/tip/ae89408341f59e39d3b7d9e0d58905722136a176
Author:        Costa Shulyupin <costa.shul@redhat.com>
AuthorDate:    Tue, 29 Aug 2023 11:25:51 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Aug 2023 21:02:58 +02:00

sched/core: Add kernel-doc for set_cpus_allowed_ptr()

This is an exported symbol, so it should have kernel-doc.
Add a note to very similar function do_set_cpus_allowed()
to avoid confusion and misuse.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230829082551.2661290-1-costa.shul@redhat.com
---
 include/linux/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3..ae6fd76 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1858,7 +1858,17 @@ extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
+
+/* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() instead */
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
+
+/**
+ * set_cpus_allowed_ptr - set CPU affinity mask of a task
+ * @p: the task
+ * @new_mask: CPU affinity mask
+ *
+ * Return: zero if successful, or a negative error code
+ */
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
 extern void release_user_cpus_ptr(struct task_struct *p);
