Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6617BD87B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbjJIK0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjJIK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:26:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC8B9C;
        Mon,  9 Oct 2023 03:26:13 -0700 (PDT)
Date:   Mon, 09 Oct 2023 10:26:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696847171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyXDB2RjMjnG7l+WBXSVkSVvXeO5Nmgyz2NOdWFwmKY=;
        b=MW5I7ICzN+/9QF82r4z5i3uxlGEUJV8TKtkNbHdaz8ktv2mXggdRVC8nQ0OTa7pSJtCJmD
        qnKzhvX4kcPpNhXFHMWRxM3HRdvzTDgl2bOpwSSRnPyTkTJQkdID+xiIyFvt+80mfqV6+T
        cpUQDDSj3ZMcz4OFag5dsMCvIRvLauuP+4q4qN1vopKMMsUPggJX1v1UCVuNR59Wog2PCX
        nA8i79ZopR5tQjuywPyVhnTNpQMDm+5zo+2I+OlCcX6hMU7GNLCFFJ6EhmcfXtG7lpL9bP
        IUDtuBvvi8bZhw2ErBv7R9+nhzBSug6sHjDoLQ+d+hEZyF/35eJqUZv+h5/WtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696847171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyXDB2RjMjnG7l+WBXSVkSVvXeO5Nmgyz2NOdWFwmKY=;
        b=y5a7OYLeGt27fEG1i6abYiHZpRvdS79xIc6DWQ5q080az9RhU2pt8vJIGQZkeK8J+EXfZD
        MAbCxyT+7E3aRnAQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/nohz: Use consistent variable names in
 find_new_ilb() and kick_ilb()
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231006102518.2452758-3-mingo@kernel.org>
References: <20231006102518.2452758-3-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <169684717095.3135.11399115758656470787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b6dd6984832a2868f78879fce30d6965ae899d02
Gitweb:        https://git.kernel.org/tip/b6dd6984832a2868f78879fce30d6965ae899d02
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 06 Oct 2023 12:25:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 12:21:23 +02:00

sched/nohz: Use consistent variable names in find_new_ilb() and kick_ilb()

Use 'ilb_cpu' consistently in both functions.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20231006102518.2452758-3-mingo@kernel.org
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2b63a14..f82b301 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11514,18 +11514,18 @@ static inline int on_null_domain(struct rq *rq)
  */
 static inline int find_new_ilb(void)
 {
-	int ilb;
 	const struct cpumask *hk_mask;
+	int ilb_cpu;
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
 
-	for_each_cpu_and(ilb, nohz.idle_cpus_mask, hk_mask) {
+	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
 
-		if (ilb == smp_processor_id())
+		if (ilb_cpu == smp_processor_id())
 			continue;
 
-		if (idle_cpu(ilb))
-			return ilb;
+		if (idle_cpu(ilb_cpu))
+			return ilb_cpu;
 	}
 
 	return nr_cpu_ids;
