Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43FB776851
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjHITOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjHITNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517BA2708;
        Wed,  9 Aug 2023 12:12:49 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Tia1jqYKGlgf3olcWvywz3xugSQljuggPOwjvrMj3ek=;
        b=nxL4++3amwjsSC++y/EZ9BuGXSX4fKBKS9NydleGTKZIV3y9v7IEW+M5O3hR9BAAblbBOu
        lAojGIinK2jCXjoPt4lh1uDGQmXpsDL2lScze62o/8Z4FgX6hi6Hc6khtnMm42x8yd5LOW
        0BsT32LJi1axJtZG1QnGNc0YcbKtN7ui+QnbVIPSo4rfJO3PMSj55KdO3zUjcAKA2be7jg
        SomeSeB1a7LFLwTyR+1pAN/9n9KhewgZBv4PnJycloZYtBMOMsLkX099/B11J00ar4Tm4J
        RDxk74PugX4X1YAJxUjOKNfjVpcgPZ/qagz2UI4zm5xWkfBZEYF9lgRAHp/kCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Tia1jqYKGlgf3olcWvywz3xugSQljuggPOwjvrMj3ek=;
        b=Q3j14lidQU8hK244BQ1lPqsEaFhdAG3eheCrIp53KTNZZJX1i84Bja4h8axX9MkIH/fubj
        +QCQSKXJYFp8rQAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Remove unused physid_*() nonsense
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834995.27769.9685465864706751781.tip-bot2@tip-bot2>
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

Commit-ID:     13d88dcb1a1cdeaaea8362e1a9d9540e2b37ef76
Gitweb:        https://git.kernel.org/tip/13d88dcb1a1cdeaaea8362e1a9d9540e2b37ef76
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:39 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:15 -07:00

x86/cpu: Remove unused physid_*() nonsense

Tons of silly unused bitmap wrappers...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/mpspec.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index e90ac7e..fa5e24a 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -87,13 +87,7 @@ struct physid_mask {
 typedef struct physid_mask physid_mask_t;
 
 #define physid_set(physid, map)			set_bit(physid, (map).mask)
-#define physid_clear(physid, map)		clear_bit(physid, (map).mask)
 #define physid_isset(physid, map)		test_bit(physid, (map).mask)
-#define physid_test_and_set(physid, map)			\
-	test_and_set_bit(physid, (map).mask)
-
-#define physids_and(dst, src1, src2)					\
-	bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_LOCAL_APIC)
 
 #define physids_or(dst, src1, src2)					\
 	bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_LOCAL_APIC)
@@ -101,29 +95,9 @@ typedef struct physid_mask physid_mask_t;
 #define physids_clear(map)					\
 	bitmap_zero((map).mask, MAX_LOCAL_APIC)
 
-#define physids_complement(dst, src)				\
-	bitmap_complement((dst).mask, (src).mask, MAX_LOCAL_APIC)
-
 #define physids_empty(map)					\
 	bitmap_empty((map).mask, MAX_LOCAL_APIC)
 
-#define physids_equal(map1, map2)				\
-	bitmap_equal((map1).mask, (map2).mask, MAX_LOCAL_APIC)
-
-#define physids_weight(map)					\
-	bitmap_weight((map).mask, MAX_LOCAL_APIC)
-
-#define physids_shift_right(d, s, n)				\
-	bitmap_shift_right((d).mask, (s).mask, n, MAX_LOCAL_APIC)
-
-#define physids_shift_left(d, s, n)				\
-	bitmap_shift_left((d).mask, (s).mask, n, MAX_LOCAL_APIC)
-
-static inline unsigned long physids_coerce(physid_mask_t *map)
-{
-	return map->mask[0];
-}
-
 static inline void physids_promote(unsigned long physids, physid_mask_t *map)
 {
 	physids_clear(*map);
