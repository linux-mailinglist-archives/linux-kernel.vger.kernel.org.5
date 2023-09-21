Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBEB7AA21A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjIUVMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjIUVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:11:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307576591;
        Thu, 21 Sep 2023 10:10:10 -0700 (PDT)
Date:   Thu, 21 Sep 2023 06:33:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695278002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21/sHHhPFb02fGPHa3KkXtpaGJfqAhmJb2ONZ+dfxgE=;
        b=kffYTUpmFWZ8SevQMW1o5EKjL8NYywiYYUhOD/lM0/tB3zQO7AVIZWg/K0kojaWiLhsMY+
        7ejXUxlBYLo3s3Dsqyz5pwrHQ7a3H674l1gFWUxTSm7mD1m4rLsH09rda1KPfHhb6aokY4
        9/QdVf9vcu1zKuX3rD+BzltP5xG2xoJ8AfuktAMg2/dFXfRf411XuMZWxfRu7bs5a1AT8n
        RBIJfpdy9p530vG/fCouWlIw4D7RfyCfpGvy3jLefaVjMjyXGVHosDuYnzifBk5RWn7YYU
        45qn/KuRToMm3sdZOy3qvy77bg3fJg2j2d/N04R79fyIH8IHGo1NmHXlLq7RyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695278002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21/sHHhPFb02fGPHa3KkXtpaGJfqAhmJb2ONZ+dfxgE=;
        b=pzqETBwGfDKW9QSDK3fXbAcdLk26ZXNGuOWJ4duXVU89tF7AXXrfG8NIELLf23n8JaO83D
        tvD0MTdpzMfq83Ag==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Update stale reference to sched_debug.c
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230920130025.412071-3-bigeasy@linutronix.de>
References: <20230920130025.412071-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169527800193.27769.18165184060342435320.tip-bot2@tip-bot2>
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

Commit-ID:     622f0a1d544fa88dda10d27727835e825c84ae0f
Gitweb:        https://git.kernel.org/tip/622f0a1d544fa88dda10d27727835e825c84ae0f
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 20 Sep 2023 15:00:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Sep 2023 08:30:19 +02:00

sched/debug: Update stale reference to sched_debug.c

Since commit:

   8a99b6833c884 ("sched: Move SCHED_DEBUG sysctl to debugfs")

The sched_debug interface moved from /proc to debugfs. The comment
mentions still the outdated proc interfaces.

Update the comment, point to the current location of the interface.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230920130025.412071-3-bigeasy@linutronix.de
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 132dfd1..5e34a8c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -8,7 +8,7 @@
  */
 
 /*
- * This allows printing both to /proc/sched_debug and
+ * This allows printing both to /sys/kernel/debug/sched/debug and
  * to the console
  */
 #define SEQ_printf(m, x...)			\
