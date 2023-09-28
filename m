Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662947B2797
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjI1VfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1Ve6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:34:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D7DF3;
        Thu, 28 Sep 2023 14:34:57 -0700 (PDT)
Date:   Thu, 28 Sep 2023 21:34:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695936896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXcf9j5duowdCJmXyGkOIvtZ8RYMFnwjC9B4CpJMimQ=;
        b=QOFiEDIhrjXJoupgnvXj5owFU+2LDhzVV0iQLm6R6M9cV8e8wvV6DL1+emi8PmRrTQ6n8Y
        uM4l7Er9m0yccvKOKGA2KgjI9nEGxNGcsxi7Qj+G2xXC6B2LC2h1CCKzbamCEEif3wB0oj
        TOwYnzQg4FjAVkidbsMW12KvhjaBTrb3w+lowf0WzeY//XF/E7eHywWLV+euGCaUubG15j
        tOWmfocgf7rCzk+aQGlY70X5Z42Dv48BCiebprfsCpfn2zjKjpCDyf7ijPPx7eEeeKKwv5
        qkbUKBPxJYF40yYJc5SsfHEeieG+ZjJF9EZJvCJiaQ5pkCzSENSjSYP3fszP+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695936896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXcf9j5duowdCJmXyGkOIvtZ8RYMFnwjC9B4CpJMimQ=;
        b=gLR4ovGG04dQjR3ZxJfmSSAhqXDMq7h/mVKO6RVuG75ywnwvy7xBTOiBe5F3e4A4pDVw35
        rtwa/j3pjck9KoBQ==
From:   "tip-bot2 for Yang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Remove unnecessary semicolon
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230810010550.25733-1-yang.lee@linux.alibaba.com>
References: <20230810010550.25733-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <169593689515.27769.18026785773995918589.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     5c44836dd1451c754c58cea5179d2fa5cbd9fc85
Gitweb:        https://git.kernel.org/tip/5c44836dd1451c754c58cea5179d2fa5cbd9fc85
Author:        Yang Li <yang.lee@linux.alibaba.com>
AuthorDate:    Thu, 10 Aug 2023 09:05:50 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Sep 2023 23:28:21 +02:00

x86/srso: Remove unnecessary semicolon

scripts/coccinelle/misc/semicolon.cocci reports:

  arch/x86/kernel/cpu/bugs.c:713:2-3: Unneeded semicolon

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230810010550.25733-1-yang.lee@linux.alibaba.com
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 016a326..bb0ab84 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -717,7 +717,7 @@ void update_gds_msr(void)
 	case GDS_MITIGATION_UCODE_NEEDED:
 	case GDS_MITIGATION_HYPERVISOR:
 		return;
-	};
+	}
 
 	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
