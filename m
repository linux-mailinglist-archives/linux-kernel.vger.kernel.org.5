Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A17A1E11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjIOMGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjIOMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:06:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA492D68;
        Fri, 15 Sep 2023 05:03:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694779407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n91F6OwJCEQx/AxwlimYmmS9ThSoGKd78npqs+cy3MU=;
        b=xnKujZeRswTQjFHSGYwpZOpNdumo2jCw3MXaxc82wIAZVyMbZukdWeo/7jI57PKlGgOHcO
        u3f+mTZJYioffDuVw62URgYGH43wFeL4zaqK9JiC/pwyjT6x5wam7/2bDWjiaNCYuWxX0f
        1tzTMMMQNUjJLIhaSDc4T9aHY3luvhatvRTnSGItlzvKmtRx+1R8vkMc2iPHXk89r2euNh
        F5TavRTJEHmAT8jq/1RAmGJkGUDk257C3RoZjbcv+waUFdAQ6Z0kt9P5X0FvXkY19HrjGK
        T7CtoGzssFpPNrfAVit2DM+sTxHJ0TvjBTQcNIOut1+W8vtR4DXT72Z37Sunvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694779407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n91F6OwJCEQx/AxwlimYmmS9ThSoGKd78npqs+cy3MU=;
        b=1sG/SWopaK+p8X7dtqKUk29q9DNDAg/LsABEQaS0yAdfNm1SV9ZSkDV9dXEsyP0XejyGdJ
        G2BpDEpX+76WQ3Bw==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Fix sched_numa_find_nth_cpu() comment
Cc:     Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230819141239.287290-7-yury.norov@gmail.com>
References: <20230819141239.287290-7-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <169477940678.27769.11961724945556415025.tip-bot2@tip-bot2>
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

Commit-ID:     6d08ad2166f7770341ea56afad45fa41cd16ae62
Gitweb:        https://git.kernel.org/tip/6d08ad2166f7770341ea56afad45fa41cd16ae62
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Sat, 19 Aug 2023 07:12:38 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 13:48:11 +02:00

sched/topology: Fix sched_numa_find_nth_cpu() comment

Reword sched_numa_find_nth_cpu() comment and make it kernel-doc compatible.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20230819141239.287290-7-yury.norov@gmail.com
---
 kernel/sched/topology.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a60ecf4..a7b50bb 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2112,13 +2112,15 @@ static int hop_cmp(const void *a, const void *b)
 	return -1;
 }
 
-/*
- * sched_numa_find_nth_cpu() - given the NUMA topology, find the Nth next cpu
- *                             closest to @cpu from @cpumask.
- * cpumask: cpumask to find a cpu from
- * cpu: Nth cpu to find
- *
- * returns: cpu, or nr_cpu_ids when nothing found.
+/**
+ * sched_numa_find_nth_cpu() - given the NUMA topology, find the Nth closest CPU
+ *                             from @cpus to @cpu, taking into account distance
+ *                             from a given @node.
+ * @cpus: cpumask to find a cpu from
+ * @cpu: CPU to start searching
+ * @node: NUMA node to order CPUs by distance
+ *
+ * Return: cpu, or nr_cpu_ids when nothing found.
  */
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
