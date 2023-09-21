Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0A7AA242
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjIUVOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjIUVOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:14:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FCC98A48;
        Thu, 21 Sep 2023 10:56:48 -0700 (PDT)
Date:   Thu, 21 Sep 2023 09:37:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695289078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9DqqpjIGMHyHy/VaF4Px7Z0FpX6SJe/VZzavxUHdqEQ=;
        b=ytu5/lAnOUXLyXi4yi8dcSkxJH7XGqV0qmciNlPdBZI2drSXkgiY3+X+rUa+cGddXETJED
        QX4Pl4aAl1eBkHfx5m3lS+h5E66P2zd7dquX3crgOQOcKTDWsoO2JRpnwjXx4aUTbvS8LT
        ChhpvRanrxyFCVFjP+tMOVneG01kAJ2dZccLG/M4E+ElDXCtLNXJ7d1kY5EPV80Xfnoape
        iLKUz5l+jNMcbc2PwUIBbnSTpDLYmEO+R2tZjiUdTO96ZOOZ40nof/8+nojUmIEqhnJ0sI
        MPISnelTOLfJkXlWwsQkdXGu1zCeC9Q+wuFPFDqM+YSWnOb5WvBuNQ1U+grMQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695289078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9DqqpjIGMHyHy/VaF4Px7Z0FpX6SJe/VZzavxUHdqEQ=;
        b=5SKUGGLseQVY+q2uZrc4h4txZ0CcnXF4qJdT7jPWetfr2d+LsaaGsjjcBaZ6+2wYnSW6jk
        EXRC5V3igbYEDWDA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Add header guard to <linux/sched/deadline.h>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169528907782.27769.18247303468859725307.tip-bot2@tip-bot2>
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

Commit-ID:     3ba78da711940ce07c39c4cdd1f4ad284067a42d
Gitweb:        https://git.kernel.org/tip/3ba78da711940ce07c39c4cdd1f4ad284067a42d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 06 Jun 2021 13:27:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 11:22:35 +02:00

sched/headers: Add header guard to <linux/sched/deadline.h>

It's the only non-trivial header in include/linux/sched/ missing a header guard.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/deadline.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 7c83d4d..df3aca8 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_DEADLINE_H
+#define _LINUX_SCHED_DEADLINE_H
 
 /*
  * SCHED_DEADLINE tasks has negative priorities, reflecting
@@ -34,3 +36,5 @@ extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
 
 #endif /* CONFIG_SMP */
+
+#endif /* _LINUX_SCHED_DEADLINE_H */
