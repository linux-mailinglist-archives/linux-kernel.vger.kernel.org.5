Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D77F27C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjKUInW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKUInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:43:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF6EAC;
        Tue, 21 Nov 2023 00:43:16 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:43:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700556193;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQQaceoHAxtmKdnMRuCtP57MdrImWR4O7cyjfd4snZo=;
        b=wfgQeK43WNeZirdINalDW87tmwdMhudNQJGoHT8Rf185mLFGanYCDU456oBr5rkC/dV5hE
        9IKXqIaRWuaIzFXgXy2cln+IF9VGcfR0qy+utEnu5nLbR6uNq5pb7rqjdDln/ZIhYo8yFF
        xhz+lcakyROU/TUFppm1kDJI/c6bCWT7H389BS0MEM8c95rPhvWSlvSn8a6DYGYrlFM7yR
        gU9ebd4zEWhEQyTl0CkwMMUefqnMX531bPA1ymW7vjM46i876tESwZmJeFd0YSwZ52QFDx
        OB7Y82vDmu6KqG3wQtqIh12NGFI6DXGxYM3Vd84ad/uxJbhRm40XQnFZ3PHFlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700556193;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQQaceoHAxtmKdnMRuCtP57MdrImWR4O7cyjfd4snZo=;
        b=YMKB5GR+f3Zcy1acmp3N4j/uo2az+5X6dSqqCynuA71Cls5cPHe0rkNW0M0mqcNjBV3vAp
        W5u/LhCSYMrHNzBg==
From:   "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Drop enum apic_delivery_modes
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231102-x86-apic-v1-2-bf049a2a0ed6@citrix.com>
References: <20231102-x86-apic-v1-2-bf049a2a0ed6@citrix.com>
MIME-Version: 1.0
Message-ID: <170055619305.398.15160547341395358366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     7c9158231f42e574f8290e15ea56d108ca49e583
Gitweb:        https://git.kernel.org/tip/7c9158231f42e574f8290e15ea56d108ca49e583
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Thu, 02 Nov 2023 12:26:20 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 21 Nov 2023 09:37:30 +01:00

x86/apic: Drop enum apic_delivery_modes

The type is not used any more.

Replace the constants with plain defines so they can live outside of an
__ASSEMBLY__ block, allowing for more cleanup in subsequent changes.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20231102-x86-apic-v1-2-bf049a2a0ed6@citrix.com


---
 arch/x86/include/asm/apicdef.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 4b125e5..ddcbf00 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -20,6 +20,13 @@
  */
 #define IO_APIC_SLOT_SIZE		1024
 
+#define APIC_DELIVERY_MODE_FIXED	0
+#define APIC_DELIVERY_MODE_LOWESTPRIO	1
+#define APIC_DELIVERY_MODE_SMI		2
+#define APIC_DELIVERY_MODE_NMI		4
+#define APIC_DELIVERY_MODE_INIT		5
+#define APIC_DELIVERY_MODE_EXTINT	7
+
 #define	APIC_ID		0x20
 
 #define	APIC_LVR	0x30
@@ -430,14 +437,5 @@ struct local_apic {
  #define BAD_APICID 0xFFFFu
 #endif
 
-enum apic_delivery_modes {
-	APIC_DELIVERY_MODE_FIXED	= 0,
-	APIC_DELIVERY_MODE_LOWESTPRIO   = 1,
-	APIC_DELIVERY_MODE_SMI		= 2,
-	APIC_DELIVERY_MODE_NMI		= 4,
-	APIC_DELIVERY_MODE_INIT		= 5,
-	APIC_DELIVERY_MODE_EXTINT	= 7,
-};
-
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_APICDEF_H */
