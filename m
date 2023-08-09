Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554AC776585
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHIQuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjHIQtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2389F2107;
        Wed,  9 Aug 2023 09:49:38 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pjkPxCXxC7cnhpbrSelSZLex9foeLCjttg+yEiQhkGw=;
        b=lNS9IneinDICl16JJKu2nkMDMB/U1bib/SDOwjKgBqoeyQpUfu473aqUgW4I97deiiusEj
        8HKxYbr4EKgwpiudb6JN2IWGXdw2p0495cPUy0rJgBEqPHPLRxpzQbuOtCd4RloCfuK+3W
        UBZe9odkWIz6YQqG3OI/2gqsIQobdvAZNTqn0pcgS7r3KNOzOZ4aP2L/sEvyZ5vAnfYckv
        DlvGkxCjxWHFUStgCmoJH3ZLRdwy7MQM9v4jZOMc01vAJrfStylmbxwFJasvjCm19FZC5Z
        qDBoIugXcNVhMPbmpdzGMBbWnErvI0dSmxxKs5ojxthewWb7KlUbOBm66FIAhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pjkPxCXxC7cnhpbrSelSZLex9foeLCjttg+yEiQhkGw=;
        b=Cf0NAaWpL5Ok8bWqkjXAfok2tNAAqtGL0X+yj+dpHtoKhNFcEJZgC8GHYT2u8ZLbh9FHZt
        iPzQJv7xqc25vbCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/ipi: Code cleanup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159977624.27769.2948671363642567492.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     be11417918c18b73113eb27741906f88f8427d51
Gitweb:        https://git.kernel.org/tip/be11417918c18b73113eb27741906f88f8427d51
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/apic/ipi: Code cleanup

Remove completely useless and mindlessly copied comments and tidy up the
code which causes eye bleed when looking at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/ipi.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index aa51e16..2ff9cf9 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -184,18 +184,13 @@ void default_send_IPI_single_phys(int cpu, int vector)
 
 void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector)
 {
-	unsigned long query_cpu;
 	unsigned long flags;
+	unsigned long cpu;
 
-	/*
-	 * Hack. The clustered APIC addressing mode doesn't allow us to send
-	 * to an arbitrary mask, so I do a unicast to each CPU instead.
-	 * - mbligh
-	 */
 	local_irq_save(flags);
-	for_each_cpu(query_cpu, mask) {
+	for_each_cpu(cpu, mask) {
 		__default_send_IPI_dest_field(per_cpu(x86_cpu_to_apicid,
-				query_cpu), vector, APIC_DEST_PHYSICAL);
+				cpu), vector, APIC_DEST_PHYSICAL);
 	}
 	local_irq_restore(flags);
 }
@@ -203,18 +198,15 @@ void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector)
 void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
 						 int vector)
 {
-	unsigned int this_cpu = smp_processor_id();
-	unsigned int query_cpu;
+	unsigned int cpu, this_cpu = smp_processor_id();
 	unsigned long flags;
 
-	/* See Hack comment above */
-
 	local_irq_save(flags);
-	for_each_cpu(query_cpu, mask) {
-		if (query_cpu == this_cpu)
+	for_each_cpu(cpu, mask) {
+		if (cpu == this_cpu)
 			continue;
 		__default_send_IPI_dest_field(per_cpu(x86_cpu_to_apicid,
-				 query_cpu), vector, APIC_DEST_PHYSICAL);
+				 cpu), vector, APIC_DEST_PHYSICAL);
 	}
 	local_irq_restore(flags);
 }
@@ -283,7 +275,6 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	local_irq_restore(flags);
 }
 
-/* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
 	int i;
