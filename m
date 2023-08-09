Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA96776852
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjHITOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHITNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CF30E9;
        Wed,  9 Aug 2023 12:12:53 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=x5XCJnY1rrpq6ehSxamA971kpUww8ISxLLlpIRugkIU=;
        b=jkNDq8NFfWjf/AxRpfYOGhZ5fJet2KAH1tPXtEEQ2j/pHyRMK1/hc7HbPpBHTG+DpYsKAd
        jh9HIzH73s5HMvvgoRqU3gwDNBgeC/t9/5Y22BfSe8rb1IwtE/qyFsOZR1H4VSnEX/sBNB
        UddhsswdKAeDipY3hTD3NFLghUdhAphFvuXxLgqh6Jx4IgzvQhsV6GCVuvGtUeRvzyh5bn
        DkmJ1T7d+S1z9gUMmQLZfQt9o0IULiVFH+y6Jz9LXv1xz9dKns7hyNdP2NXv72jpwvs5/9
        4bytJdCxpkzDqZtl5kQCkCEZjqSu3+BPMFs5rJ1njGewRt9PKfuoaLsBxRpWRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=x5XCJnY1rrpq6ehSxamA971kpUww8ISxLLlpIRugkIU=;
        b=/qaw/eykOVgRwHgdR/lnS9z2ncaDzHUHHTafEG04tkt+NdZE3DF1ZToxfXxXH0hJhSwMAw
        MUL249ZTU2874FCg==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove mpparse 'apicid' variable
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834565.27769.5763058021367629941.tip-bot2@tip-bot2>
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

Commit-ID:     004671e5c9335736ef808482bfc69cccd93cccc5
Gitweb:        https://git.kernel.org/tip/004671e5c9335736ef808482bfc69cccd93cccc5
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 08 Aug 2023 15:03:47 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:19 -07:00

x86/apic: Remove mpparse 'apicid' variable

From: Dave Hansen <dave.hansen@linux.intel.com>

Some truly ancient code had different ways of calculating the 'apicid'
but it is long gone.  Zap the unnecssary local variablee

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/mpparse.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 82518c1..333dee2 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -48,7 +48,6 @@ static int __init mpf_checksum(unsigned char *mp, int len)
 
 static void __init MP_processor_info(struct mpc_cpu *m)
 {
-	int apicid;
 	char *bootup_cpu = "";
 
 	if (!(m->cpuflag & CPU_ENABLED)) {
@@ -56,13 +55,11 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 		return;
 	}
 
-	apicid = m->apicid;
-
 	if (m->cpuflag & CPU_BOOTPROCESSOR)
 		bootup_cpu = " (Bootup-CPU)";
 
 	pr_info("Processor #%d%s\n", m->apicid, bootup_cpu);
-	generic_processor_info(apicid);
+	generic_processor_info(m->apicid);
 }
 
 #ifdef CONFIG_X86_IO_APIC
