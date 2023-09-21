Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0497A9B28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjIUSyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjIUSyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:54:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802FC90A4E;
        Thu, 21 Sep 2023 10:55:12 -0700 (PDT)
Date:   Thu, 21 Sep 2023 09:37:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695289077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JyCE/Iv8cwQothVX0X8BnhrJ4OlthMKGpUC6QAJsTuE=;
        b=nMv/CC3rOxywKJqhOWQzb66JRp11BeHmESX1CFMrITjJNGtHqU+yfGVn65ziTh3HYdmueq
        i4MkAqqG0e6FiQgqgZzPD0VKvOHSxWw9MpdRKMTjqwvStUPZB1Tjg2xfXLtyMM2ED02+pl
        gqpVlKxjlSpX2QaYZ+L2qm7IkUJ5TI5GRIORwegOomAMcSmqA0ARlwRhQW4xj8e4TrF1i+
        4MzlGPqWCric3UiqeJV4IWCZXJchPkyErYIqUmysRcaA7sHaOdq3aRt7yIxB+LQ7pmT4+N
        TCksFbfeCdqGMlJ/sgaezBwXEJgszkcZWz/rPpwezFKHERIchAZuODD0TQyEcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695289077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JyCE/Iv8cwQothVX0X8BnhrJ4OlthMKGpUC6QAJsTuE=;
        b=lF3FWFezJLatewfcVpy2fu2A+PlGYaJhSzuXFwdxbWLoC9XFODT96LjxU9XI/0s7kt8WQo
        MkJSv++576IVAkAg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Standardize the
 <linux/sched/vhost_task.h> header guard name
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169528907726.27769.17347276414076634078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6eddb116dd830436afbd922568292867de6c8b9e
Gitweb:        https://git.kernel.org/tip/6eddb116dd830436afbd922568292867de6c8b9e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 21 Sep 2023 11:24:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 11:25:51 +02:00

sched/headers: Standardize the <linux/sched/vhost_task.h> header guard name

Use the same _LINUX_SCHED_ prefix nomenclature as the other 29 header guards
in include/linux/sched/ do.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/vhost_task.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
index 837a236..bc60243 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_VHOST_TASK_H
-#define _LINUX_VHOST_TASK_H
-
+#ifndef _LINUX_SCHED_VHOST_TASK_H
+#define _LINUX_SCHED_VHOST_TASK_H
 
 struct vhost_task;
 
@@ -11,4 +10,4 @@ void vhost_task_start(struct vhost_task *vtsk);
 void vhost_task_stop(struct vhost_task *vtsk);
 void vhost_task_wake(struct vhost_task *vtsk);
 
-#endif
+#endif /* _LINUX_SCHED_VHOST_TASK_H */
