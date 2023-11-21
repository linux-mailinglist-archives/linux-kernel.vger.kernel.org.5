Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B97F3598
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjKUSFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjKUSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:04:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D4D1729;
        Tue, 21 Nov 2023 10:04:25 -0800 (PST)
Date:   Tue, 21 Nov 2023 18:04:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700589863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hN0UEf57JGoD6zK/4Z0zQNAZ8Yx8VZ7dVmNgHd8JsTc=;
        b=F7xLCQYGXK1JrKcGkkxH0w7NyoQTQWUdq8GdYnskzPjMsH7rqbC08uSkQEtsWGvijlkuW0
        PMWWgnWyLV5+sQZZsn1RPUquMqwGpenPu48G5wLgzkjZO+HUspmEMuaha3Q1fKSPkaidfG
        OOmV9zr6rU1l4hjGJvHSFGprpKKl8cpU6rxchdZwpYnW9GWFLgK0ZNbxa32/enYijNumRy
        DoezLNQWyIggQ82O9EBe1ubmap9c1z1y88YCSh88abxGokPx0he7bnLLwy9fkWbpv/Noy9
        mwivmLrOIgvkoQeaF80kxwy+kvvfsd02/JWb22W+m4Bpnmy+6w0JULmX0sG6+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700589863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hN0UEf57JGoD6zK/4Z0zQNAZ8Yx8VZ7dVmNgHd8JsTc=;
        b=4xCSlEnmB9DQvDMiKx7lK6GGL9tZ16s+Xf7Dl8aysaWRPRlDcOjtLdRRpXh/JSoZeqFoDk
        tTySFYf3oE+PAwBA==
From:   "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Drop struct local_apic
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231102-x86-apic-v1-3-bf049a2a0ed6@citrix.com>
References: <20231102-x86-apic-v1-3-bf049a2a0ed6@citrix.com>
MIME-Version: 1.0
Message-ID: <170058986268.398.13295770391611969582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5a7d6d26af7714718b673e40bdc97f9f207e265a
Gitweb:        https://git.kernel.org/tip/5a7d6d26af7714718b673e40bdc97f9f207e265a
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Thu, 02 Nov 2023 12:26:21 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Nov 2023 17:23:35 +01:00

x86/apic: Drop struct local_apic

This type predates recorded history in tglx/history.git, making it older
than Feb 5th 2002.

This structure is literally old enough to drink in most juristictions in
the world, and has not been used once in that time.

Lay it to rest in /dev/null.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20231102-x86-apic-v1-3-bf049a2a0ed6@citrix.com
---
 arch/x86/include/asm/apicdef.h | 260 +--------------------------------
 1 file changed, 260 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index ddcbf00..094106b 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -172,270 +172,10 @@
 #define APIC_CPUID(apicid)	((apicid) & XAPIC_DEST_CPUS_MASK)
 #define NUM_APIC_CLUSTERS	((BAD_APICID + 1) >> XAPIC_DEST_CPUS_SHIFT)
 
-#ifndef __ASSEMBLY__
-/*
- * the local APIC register structure, memory mapped. Not terribly well
- * tested, but we might eventually use this one in the future - the
- * problem why we cannot use it right now is the P5 APIC, it has an
- * errata which cannot take 8-bit reads and writes, only 32-bit ones ...
- */
-#define u32 unsigned int
-
-struct local_apic {
-
-/*000*/	struct { u32 __reserved[4]; } __reserved_01;
-
-/*010*/	struct { u32 __reserved[4]; } __reserved_02;
-
-/*020*/	struct { /* APIC ID Register */
-		u32   __reserved_1	: 24,
-			phys_apic_id	:  4,
-			__reserved_2	:  4;
-		u32 __reserved[3];
-	} id;
-
-/*030*/	const
-	struct { /* APIC Version Register */
-		u32   version		:  8,
-			__reserved_1	:  8,
-			max_lvt		:  8,
-			__reserved_2	:  8;
-		u32 __reserved[3];
-	} version;
-
-/*040*/	struct { u32 __reserved[4]; } __reserved_03;
-
-/*050*/	struct { u32 __reserved[4]; } __reserved_04;
-
-/*060*/	struct { u32 __reserved[4]; } __reserved_05;
-
-/*070*/	struct { u32 __reserved[4]; } __reserved_06;
-
-/*080*/	struct { /* Task Priority Register */
-		u32   priority	:  8,
-			__reserved_1	: 24;
-		u32 __reserved_2[3];
-	} tpr;
-
-/*090*/	const
-	struct { /* Arbitration Priority Register */
-		u32   priority	:  8,
-			__reserved_1	: 24;
-		u32 __reserved_2[3];
-	} apr;
-
-/*0A0*/	const
-	struct { /* Processor Priority Register */
-		u32   priority	:  8,
-			__reserved_1	: 24;
-		u32 __reserved_2[3];
-	} ppr;
-
-/*0B0*/	struct { /* End Of Interrupt Register */
-		u32   eoi;
-		u32 __reserved[3];
-	} eoi;
-
-/*0C0*/	struct { u32 __reserved[4]; } __reserved_07;
-
-/*0D0*/	struct { /* Logical Destination Register */
-		u32   __reserved_1	: 24,
-			logical_dest	:  8;
-		u32 __reserved_2[3];
-	} ldr;
-
-/*0E0*/	struct { /* Destination Format Register */
-		u32   __reserved_1	: 28,
-			model		:  4;
-		u32 __reserved_2[3];
-	} dfr;
-
-/*0F0*/	struct { /* Spurious Interrupt Vector Register */
-		u32	spurious_vector	:  8,
-			apic_enabled	:  1,
-			focus_cpu	:  1,
-			__reserved_2	: 22;
-		u32 __reserved_3[3];
-	} svr;
-
-/*100*/	struct { /* In Service Register */
-/*170*/		u32 bitfield;
-		u32 __reserved[3];
-	} isr [8];
-
-/*180*/	struct { /* Trigger Mode Register */
-/*1F0*/		u32 bitfield;
-		u32 __reserved[3];
-	} tmr [8];
-
-/*200*/	struct { /* Interrupt Request Register */
-/*270*/		u32 bitfield;
-		u32 __reserved[3];
-	} irr [8];
-
-/*280*/	union { /* Error Status Register */
-		struct {
-			u32   send_cs_error			:  1,
-				receive_cs_error		:  1,
-				send_accept_error		:  1,
-				receive_accept_error		:  1,
-				__reserved_1			:  1,
-				send_illegal_vector		:  1,
-				receive_illegal_vector		:  1,
-				illegal_register_address	:  1,
-				__reserved_2			: 24;
-			u32 __reserved_3[3];
-		} error_bits;
-		struct {
-			u32 errors;
-			u32 __reserved_3[3];
-		} all_errors;
-	} esr;
-
-/*290*/	struct { u32 __reserved[4]; } __reserved_08;
-
-/*2A0*/	struct { u32 __reserved[4]; } __reserved_09;
-
-/*2B0*/	struct { u32 __reserved[4]; } __reserved_10;
-
-/*2C0*/	struct { u32 __reserved[4]; } __reserved_11;
-
-/*2D0*/	struct { u32 __reserved[4]; } __reserved_12;
-
-/*2E0*/	struct { u32 __reserved[4]; } __reserved_13;
-
-/*2F0*/	struct { u32 __reserved[4]; } __reserved_14;
-
-/*300*/	struct { /* Interrupt Command Register 1 */
-		u32   vector			:  8,
-			delivery_mode		:  3,
-			destination_mode	:  1,
-			delivery_status		:  1,
-			__reserved_1		:  1,
-			level			:  1,
-			trigger			:  1,
-			__reserved_2		:  2,
-			shorthand		:  2,
-			__reserved_3		:  12;
-		u32 __reserved_4[3];
-	} icr1;
-
-/*310*/	struct { /* Interrupt Command Register 2 */
-		union {
-			u32   __reserved_1	: 24,
-				phys_dest	:  4,
-				__reserved_2	:  4;
-			u32   __reserved_3	: 24,
-				logical_dest	:  8;
-		} dest;
-		u32 __reserved_4[3];
-	} icr2;
-
-/*320*/	struct { /* LVT - Timer */
-		u32   vector		:  8,
-			__reserved_1	:  4,
-			delivery_status	:  1,
-			__reserved_2	:  3,
-			mask		:  1,
-			timer_mode	:  1,
-			__reserved_3	: 14;
-		u32 __reserved_4[3];
-	} lvt_timer;
-
-/*330*/	struct { /* LVT - Thermal Sensor */
-		u32  vector		:  8,
-			delivery_mode	:  3,
-			__reserved_1	:  1,
-			delivery_status	:  1,
-			__reserved_2	:  3,
-			mask		:  1,
-			__reserved_3	: 15;
-		u32 __reserved_4[3];
-	} lvt_thermal;
-
-/*340*/	struct { /* LVT - Performance Counter */
-		u32   vector		:  8,
-			delivery_mode	:  3,
-			__reserved_1	:  1,
-			delivery_status	:  1,
-			__reserved_2	:  3,
-			mask		:  1,
-			__reserved_3	: 15;
-		u32 __reserved_4[3];
-	} lvt_pc;
-
-/*350*/	struct { /* LVT - LINT0 */
-		u32   vector		:  8,
-			delivery_mode	:  3,
-			__reserved_1	:  1,
-			delivery_status	:  1,
-			polarity	:  1,
-			remote_irr	:  1,
-			trigger		:  1,
-			mask		:  1,
-			__reserved_2	: 15;
-		u32 __reserved_3[3];
-	} lvt_lint0;
-
-/*360*/	struct { /* LVT - LINT1 */
-		u32   vector		:  8,
-			delivery_mode	:  3,
-			__reserved_1	:  1,
-			delivery_status	:  1,
-			polarity	:  1,
-			remote_irr	:  1,
-			trigger		:  1,
-			mask		:  1,
-			__reserved_2	: 15;
-		u32 __reserved_3[3];
-	} lvt_lint1;
-
-/*370*/	struct { /* LVT - Error */
-		u32   vector		:  8,
-			__reserved_1	:  4,
-			delivery_status	:  1,
-			__reserved_2	:  3,
-			mask		:  1,
-			__reserved_3	: 15;
-		u32 __reserved_4[3];
-	} lvt_error;
-
-/*380*/	struct { /* Timer Initial Count Register */
-		u32   initial_count;
-		u32 __reserved_2[3];
-	} timer_icr;
-
-/*390*/	const
-	struct { /* Timer Current Count Register */
-		u32   curr_count;
-		u32 __reserved_2[3];
-	} timer_ccr;
-
-/*3A0*/	struct { u32 __reserved[4]; } __reserved_16;
-
-/*3B0*/	struct { u32 __reserved[4]; } __reserved_17;
-
-/*3C0*/	struct { u32 __reserved[4]; } __reserved_18;
-
-/*3D0*/	struct { u32 __reserved[4]; } __reserved_19;
-
-/*3E0*/	struct { /* Timer Divide Configuration Register */
-		u32   divisor		:  4,
-			__reserved_1	: 28;
-		u32 __reserved_2[3];
-	} timer_dcr;
-
-/*3F0*/	struct { u32 __reserved[4]; } __reserved_20;
-
-} __attribute__ ((packed));
-
-#undef u32
-
 #ifdef CONFIG_X86_32
  #define BAD_APICID 0xFFu
 #else
  #define BAD_APICID 0xFFFFu
 #endif
 
-#endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_APICDEF_H */
