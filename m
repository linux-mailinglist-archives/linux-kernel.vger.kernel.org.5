Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8867F7F3596
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjKUSFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjKUSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:04:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB7172E;
        Tue, 21 Nov 2023 10:04:25 -0800 (PST)
Date:   Tue, 21 Nov 2023 18:04:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700589864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/LxqX571fefzJvxDQtYiOwLG0wY6p4kB4B/l95UJkw=;
        b=qZzaJbPwkZiKq+Eiqyz9naVTX8WEkcw5sWLmu0+mXZmx8YbF6zCdKxo+AxyejHSh+JvQFr
        u71eOpgtrlQ6mVafzSNrz7ctoxb0GP2BvEf86egPD5m9Y6V5pOnLonhRsfoRk9c8o5wbBM
        2SSbipmBm66qfrgAnWnD/zZfW22TZNuA+59XbhEvUQaxRJcWj0uSgD8pT97FIXNvFwjjTR
        6hk3xpuYeQyXuVN7JgvQeHN8EgauEYgIFwMTP+kheKFSDynwbvQhOjcZ6xXVSS2hJCJi/j
        1O8gjHwlFn+WD+XV7hN2RA7fDBCNqtiEqIdhyltO//ciieFakd6WGweYRf9ibg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700589864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/LxqX571fefzJvxDQtYiOwLG0wY6p4kB4B/l95UJkw=;
        b=IWTvOBJcOvruNwk4b4kfE5hOGf+MYW5eabLK+bDsEtFmvZdLEgvjSVHARAqxS0+XYBBCus
        x0tQDdRg1kayKMCA==
From:   "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Drop enum apic_delivery_modes
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231102-x86-apic-v1-2-bf049a2a0ed6@citrix.com>
References: <20231102-x86-apic-v1-2-bf049a2a0ed6@citrix.com>
MIME-Version: 1.0
Message-ID: <170058986344.398.13944817922448407011.tip-bot2@tip-bot2>
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

Commit-ID:     855da7cdf974f3902397e5bf9423c7442bdfd75f
Gitweb:        https://git.kernel.org/tip/855da7cdf974f3902397e5bf9423c7442bdfd75f
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Thu, 02 Nov 2023 12:26:20 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Nov 2023 17:05:06 +01:00

x86/apic: Drop enum apic_delivery_modes

The type is not used any more.

Replace the constants with plain defines so they can live outside of an
__ASSEMBLY__ block, allowing for more cleanup in subsequent changes.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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
