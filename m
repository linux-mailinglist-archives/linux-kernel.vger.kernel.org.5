Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7C7BF7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjJJJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjJJJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:43:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A593;
        Tue, 10 Oct 2023 02:43:52 -0700 (PDT)
Date:   Tue, 10 Oct 2023 09:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696931030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ccIF8fKpEQO34BOIIS10VJwSID43r//NiX5MeYyT5o=;
        b=eyZzuK+bnNZiBmhc4wbqwy0sKgQgYxoB3OojWTwzmPY1i0NtpOPezSP9952SsAzpXN5JGT
        L31JVtHxwOnb+631pC2gH4j+ELMcgCuwOsizA+JO1MUcULga+g8aFSL6qIZKC5ZnTjb2V0
        WlorHSFzdzZnnJz/BTxwukh+K9ZB6uMk7R1Kkzr92tvQJN+07JoE7V5yCFdduRewbQPv4+
        AZjO5gyg6PrLFmNdyMY91l3uUvBpER0dPJ9Mh8AnWA/w3MQAi/+B9qeOnEqaOnlHB5w0LR
        M08ykiehhYjFtp7zKtr5XtjU/hS6v+9Vv/LDZkVioDP3Th6LSzWiUtxB07vrQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696931030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ccIF8fKpEQO34BOIIS10VJwSID43r//NiX5MeYyT5o=;
        b=gDdSVtEQPelg+y8RE/3C3/PXw6ybTufAmM4L93NgP1okkdRGhWAarX1xv6otdhrCNPniUZ
        hms5e9yVbLXh15Bg==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Document vma_numab_state fields
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010083143.19593-2-mgorman@techsingularity.net>
References: <20231010083143.19593-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <169693102968.3135.4439690793475045331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9ae5c00ea2e600a8b823f9b95606dd244f3096bf
Gitweb:        https://git.kernel.org/tip/9ae5c00ea2e600a8b823f9b95606dd244f3096bf
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 10 Oct 2023 09:31:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 11:10:00 +02:00

sched/numa: Document vma_numab_state fields

Document the intended usage of the fields.

[ mingo: Reformatted to take less vertical space & tidied it up. ]

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231010083143.19593-2-mgorman@techsingularity.net
---
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43..d7f042e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -551,8 +551,29 @@ struct vma_lock {
 };
 
 struct vma_numab_state {
+	/*
+	 * Initialised as time in 'jiffies' after which VMA
+	 * should be scanned.  Delays first scan of new VMA by at
+	 * least sysctl_numa_balancing_scan_delay:
+	 */
 	unsigned long next_scan;
+
+	/*
+	 * Time in jiffies when access_pids[] is reset to
+	 * detect phase change behaviour:
+	 */
 	unsigned long next_pid_reset;
+
+	/*
+	 * Approximate tracking of PIDs that trapped a NUMA hinting
+	 * fault. May produce false positives due to hash collisions.
+	 *
+	 *   [0] Previous PID tracking
+	 *   [1] Current PID tracking
+	 *
+	 * Window moves after next_pid_reset has expired approximately
+	 * every VMA_PID_RESET_PERIOD jiffies:
+	 */
 	unsigned long access_pids[2];
 };
 
