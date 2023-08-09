Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0DA776A26
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjHIUgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjHIUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCECB4;
        Wed,  9 Aug 2023 13:36:07 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=21BnrJemQ5ShwvF1DpadbMtcAI7G0bRuOodYTBsfLZU=;
        b=M04qBt/gu0UBjeKbFEgCzbrFBpiCev3smzs5yckPvpACKWf9VyFe2FvL34bzAaMQ4ilKWz
        dCliGyskeD4qIzJQe+OC+wZ2a3Am/re3UkMmeeQE+H02B9rMk/8fV07FedSenoc1qC2tW3
        Ln6gil9wW5iZI/ABV7VF3kHZ+rVL4GOpt0Z0R6MCY1TWGaGMaw77jTy20V+8ldjtxT3QlC
        YGf+P03e1LD2vF8bWG0Hv/f5RMFuFiKvG8TNahW0AbWlV+3wnnuJIYOST4O58WU3jlS4JE
        hFkdzlIuuViqO+BQChko18mXDqPkKBl15qS9K9g1feA5RZ3ONpxzsk+aVUHl6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=21BnrJemQ5ShwvF1DpadbMtcAI7G0bRuOodYTBsfLZU=;
        b=c7MbXL05YJGim0k1BpQS14HLVvET6jBLPZ4SOEMcanm2h14iGvVdH79MCjUAU6BMd6vZxY
        MKL/+Et0aXjPmMDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Mark all hotpath APIC callback wrappers
 __always_inline
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336448.27769.4347654295175166611.tip-bot2@tip-bot2>
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

Commit-ID:     54271fb0b78511048aa7910d593994f2ca055e68
Gitweb:        https://git.kernel.org/tip/54271fb0b78511048aa7910d593994f2ca055e68
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:21 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:55 -07:00

x86/apic: Mark all hotpath APIC callback wrappers __always_inline

There is no value for instrumentation to look at those wrappers and with the
upcoming conversion to static calls even less so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 1742f97..28192a2 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -371,48 +371,48 @@ void __init apic_install_driver(struct apic *driver);
 		pr_info("APIC: %s() replaced with %ps()\n", #_callback, _fn);	\
 }
 
-static inline u32 apic_read(u32 reg)
+static __always_inline u32 apic_read(u32 reg)
 {
 	return apic->read(reg);
 }
 
-static inline void apic_write(u32 reg, u32 val)
+static __always_inline void apic_write(u32 reg, u32 val)
 {
 	apic->write(reg, val);
 }
 
-static inline void apic_eoi(void)
+static __always_inline void apic_eoi(void)
 {
 	apic->eoi();
 }
 
-static inline void apic_native_eoi(void)
+static __always_inline void apic_native_eoi(void)
 {
 	apic->native_eoi();
 }
 
-static inline u64 apic_icr_read(void)
+static __always_inline u64 apic_icr_read(void)
 {
 	return apic->icr_read();
 }
 
-static inline void apic_icr_write(u32 low, u32 high)
+static __always_inline void apic_icr_write(u32 low, u32 high)
 {
 	apic->icr_write(low, high);
 }
 
-static inline void apic_wait_icr_idle(void)
+static __always_inline void apic_wait_icr_idle(void)
 {
 	if (apic->wait_icr_idle)
 		apic->wait_icr_idle();
 }
 
-static inline u32 safe_apic_wait_icr_idle(void)
+static __always_inline u32 safe_apic_wait_icr_idle(void)
 {
 	return apic->safe_wait_icr_idle ? apic->safe_wait_icr_idle() : 0;
 }
 
-static inline bool apic_id_valid(u32 apic_id)
+static __always_inline bool apic_id_valid(u32 apic_id)
 {
 	return apic_id <= apic->max_apic_id;
 }
