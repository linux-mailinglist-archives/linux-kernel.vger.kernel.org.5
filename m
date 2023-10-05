Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A877B9F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjJEOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjJEORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:17:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B19003;
        Thu,  5 Oct 2023 01:36:08 -0700 (PDT)
Date:   Thu, 05 Oct 2023 08:36:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696494964;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooaRt6cPAJOEWZihUCK19vSVmC89ZgrQXgZH5+YgVmQ=;
        b=30URau9nD9DRgr/eTus/cduE+vwu3JLLp/Rerq1dDn3yar14kx82uDrQlcN5qD5bIF9NBh
        r+jin1kgVrp8Sjd/7WgHUzdfUpYlQ5K3Zdg2esI9fHKullgPFzUI1tLNAXzuG1+ZWWOrT1
        6k+UskT63zP+aUnpJUch5hua7VISRwytAMbkleV9zVoslyJZtxEM9BGO/z7VTdJ/yQLaFG
        Ihc/dgyIbKJp7EPlDVsts+nCqaVd9bYffXYYzoWq5ygECGHz83rrr/AmbhCDjy7wu4cDvg
        Wrz31Qmsm4pgprlfisO5Ic6oFGjaw2FKq6qacP6w3cxtCo3e0DFd3nrX+B3Kog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696494964;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooaRt6cPAJOEWZihUCK19vSVmC89ZgrQXgZH5+YgVmQ=;
        b=idzLrwU6B6tL0+Cy9XTdGcVN8bSN9hQuaMNz4/d7H75I9k0+4Zzi5yEwqVqcdbgkNQ5ia/
        QHNPj3wNz62HvgCw==
From:   "tip-bot2 for Xiu Jianfeng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Rename perf_proc_update_handler() ->
 perf_event_max_sample_rate_handler(), for readability
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230721090607.172002-1-xiujianfeng@huawei.com>
References: <20230721090607.172002-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Message-ID: <169649496396.3135.9256203796815906807.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e6814ec3ba1994561db9b1c05a80227d30cc18fa
Gitweb:        https://git.kernel.org/tip/e6814ec3ba1994561db9b1c05a80227d30cc18fa
Author:        Xiu Jianfeng <xiujianfeng@huawei.com>
AuthorDate:    Fri, 21 Jul 2023 09:06:07 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 10:26:50 +02:00

perf/core: Rename perf_proc_update_handler() -> perf_event_max_sample_rate_handler(), for readability

Follow the naming pattern of the other sysctl handlers in perf.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230721090607.172002-1-xiujianfeng@huawei.com
---
 include/linux/perf_event.h | 2 +-
 kernel/events/core.c       | 4 ++--
 kernel/sysctl.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e85cd1c..f31f962 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1573,7 +1573,7 @@ extern int sysctl_perf_cpu_time_max_percent;
 
 extern void perf_sample_event_took(u64 sample_len_ns);
 
-int perf_proc_update_handler(struct ctl_table *table, int write,
+int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41..af56919 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -449,8 +449,8 @@ static void update_perf_cpu_limits(void)
 
 static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
 
-int perf_proc_update_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
+				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 	int perf_cpu = sysctl_perf_cpu_time_max_percent;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 354a2d2..2b65857 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1983,7 +1983,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_perf_event_sample_rate,
 		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
 		.mode		= 0644,
-		.proc_handler	= perf_proc_update_handler,
+		.proc_handler	= perf_event_max_sample_rate_handler,
 		.extra1		= SYSCTL_ONE,
 	},
 	{
