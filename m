Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760137B6592
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbjJCJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjJCJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:34:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA83B90;
        Tue,  3 Oct 2023 02:33:56 -0700 (PDT)
Date:   Tue, 03 Oct 2023 09:33:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696325634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFjy5OAkqj+RcMJ8GorPj2rGPTj6R6wFhYpPtVDM/ig=;
        b=MB1c/FrRYTpoNm8LHOYN1vTZN/22oh39zopdQ3MTBWz8FnZsB6L3ZejKDoQKnhoRty7VIG
        AqHgTHIyxgKEqSYGueCa81vqG0SNWok27V7qaF/vHfMAZ3TXxWMbeQ68nCoNTjAFAG0K2U
        GNPuyaMyDF8zVMrI0vfpKZHy6qthSgeE5nkYzEcnrQzWyZXWFA6tl3gFR1f1YNU3G+jQWC
        4WhN9qvcflRon5CfuSpNO8JF8y2+huhZivTKSsRjCLnmkCfcG6UTxj3nZLVkCEyDkkiP9c
        6e5Rr2TKqaw7LUcdCI5znNs1/GKZE2HMZsgDM9K1znCsyV/KeD+dFHNDeNYjBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696325634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFjy5OAkqj+RcMJ8GorPj2rGPTj6R6wFhYpPtVDM/ig=;
        b=sqow5UEuSw/w4wIXtAU6L8kmNMQ5QI2JvftOhHeRyVgTXZH4yI2dPSCW+lP0wkdkKwv5QV
        7xwczprWLX4vcTCA==
From:   "tip-bot2 for Wang Jinchao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Harmonize the style of array-type parameter
 for fixup_pointer() calls
Cc:     Wang Jinchao <wangjinchao@xfusion.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZMt24BGEX9IhPSY6@fedora>
References: <ZMt24BGEX9IhPSY6@fedora>
MIME-Version: 1.0
Message-ID: <169632563389.3135.2507712498774997414.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     9f76d606269be7bd1ee5942b7c9c21bb0b43825f
Gitweb:        https://git.kernel.org/tip/9f76d606269be7bd1ee5942b7c9c21bb0b43825f
Author:        Wang Jinchao <wangjinchao@xfusion.com>
AuthorDate:    Thu, 03 Aug 2023 17:44:00 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 11:28:38 +02:00

x86/boot: Harmonize the style of array-type parameter for fixup_pointer() calls

The usage of '&' before the array parameter is redundant because '&array'
is equivalent to 'array'. Therefore, there is no need to include '&'
before the array parameter. In fact, using '&' can cause more confusion,
especially for individuals who are not familiar with the address-of
operation for arrays. They might mistakenly believe that one is different
from the other and spend additional time realizing that they are actually
the same.

Harmonizing the style by removing the unnecessary '&' would save time for
those individuals.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/ZMt24BGEX9IhPSY6@fedora
---
 arch/x86/kernel/head64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index bbc2179..d6ca9c5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -211,7 +211,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* Fixup the physical addresses in the page table */
 
-	pgd = fixup_pointer(&early_top_pgt, physaddr);
+	pgd = fixup_pointer(early_top_pgt, physaddr);
 	p = pgd + pgd_index(__START_KERNEL_map);
 	if (la57)
 		*p = (unsigned long)level4_kernel_pgt;
@@ -220,11 +220,11 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
 
 	if (la57) {
-		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
+		p4d = fixup_pointer(level4_kernel_pgt, physaddr);
 		p4d[511] += load_delta;
 	}
 
-	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
+	pud = fixup_pointer(level3_kernel_pgt, physaddr);
 	pud[510] += load_delta;
 	pud[511] += load_delta;
 
