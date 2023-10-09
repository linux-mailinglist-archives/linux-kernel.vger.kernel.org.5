Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA27BE54E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376954AbjJIPsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376463AbjJIPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:48:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B519F;
        Mon,  9 Oct 2023 08:48:07 -0700 (PDT)
Date:   Mon, 09 Oct 2023 15:48:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696866485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j8RY9/oqlZ5AQToIicqBzl+juLEi2EMX3EhjVM/TL2c=;
        b=4RddHo4x0ftAHJuclLAbluzoUNGJ+/LOEB3EfLg5hFv3z5WHmo+KdMmQSsXTWWoXXsT9Yv
        WeO1deGCYU9e2+ryJIkICbCwRWAWlFnpszN6IiFQ1B+Sark6dhhPC9IFgLN3hAKMKl++XG
        73EZtipg5QKOXlFSDWBekmwfkA4aMrvnDImkpDJdOS9r/TCBrxt+Hz0q3/lA6bAsZdqjRH
        C9TVRvm/fVU8uRdhYzBgGjo5Zs9tMdjAsX98uTOwb2XiVpQyhnfh7PjmveKiC1cAhcqE1+
        eu/+5dMbOXQLOjsE/2UvJB9Bm0XsJBVK29unHf9DuZf2nFg+kJRJj5e/20pTMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696866485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j8RY9/oqlZ5AQToIicqBzl+juLEi2EMX3EhjVM/TL2c=;
        b=wCSzn3A6JTASoogVgThL/BIY/JFD05Oq2mM9eji4Thmnj8q3aIXUdzyv1NAGY7D76k/p5m
        8OIhmDub2mDasdCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Move the declaration of
 'schedutil_gov' to kernel/sched/sched.h
Cc:     Ingo Molnar <mingo@kernel.org>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231009060037.170765-3-sshegde@linux.vnet.ibm.com>
References: <20231009060037.170765-3-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <169686648472.3135.10235202976466091036.tip-bot2@tip-bot2>
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

Commit-ID:     f2273f4e19e29f7d0be6a2393f18369cd1b496c8
Gitweb:        https://git.kernel.org/tip/f2273f4e19e29f7d0be6a2393f18369cd1b496c8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 09 Oct 2023 17:31:26 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 17:33:10 +02:00

sched/topology: Move the declaration of 'schedutil_gov' to kernel/sched/sched.h

Move it out of the .c file into the shared scheduler-internal header file,
to gain type-checking.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20231009060037.170765-3-sshegde@linux.vnet.ibm.com
---
 kernel/sched/sched.h    | 2 ++
 kernel/sched/topology.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7e7fedc..faf9031 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3203,6 +3203,8 @@ static inline bool sched_energy_enabled(void)
 	return static_branch_unlikely(&sched_energy_present);
 }
 
+extern struct cpufreq_governor schedutil_gov;
+
 #else /* ! (CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
 #define perf_domain_span(pd) NULL
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4cbbdac..d950861 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -212,7 +212,6 @@ static unsigned int sysctl_sched_energy_aware = 1;
 static DEFINE_MUTEX(sched_energy_mutex);
 static bool sched_energy_update;
 
-extern struct cpufreq_governor schedutil_gov;
 static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 {
 	bool any_asym_capacity = false;
