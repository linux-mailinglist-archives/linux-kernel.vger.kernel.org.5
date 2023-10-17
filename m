Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE77CC3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbjJQNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjJQNDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:03:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F283;
        Tue, 17 Oct 2023 06:03:53 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:03:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697547832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ur0pleNbPVSpL3C6zvCe1LDhu7aAMmrcgKf1Wg1xeZQ=;
        b=CZaMLbgbJeWUKM3XEnVT0+M7XAQZmQ6e5LUiTdA3mOM5gUtmsKpQcq95YtpoZPJvN2FyOq
        KVnrfVa0K3bQUYfqiH/vGyZ1QpIFohgKeGUaaRB7FKbegAu/7vbG6qiek+8GlaNwLSY5fZ
        CiVLIc9fXWNOMoKOTI7eEHQ9yEoOEHR8XjFcnGhwv+sDamRX8Yc+o+XhCsuUomJjd7mCZq
        c9f0RnfAzzu3/YqjfJ8utR5N0Ndvl8/cBvJlQ3CBzlijaxee5/4qI3nESUZj42tmHWSFpC
        NIs3t7CyRHjNDFCKu3rJlAfwNSx/EJvOdRitbrZVh8MRpGU6A2E71cpVWsHQTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697547832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ur0pleNbPVSpL3C6zvCe1LDhu7aAMmrcgKf1Wg1xeZQ=;
        b=eLEYs+CZjIc5hwPuN12vOfUp6LVpq4Jc3wKLhSOgauQbabQ/X0vesrjZVWyd2ZNqhuH7gC
        UpYB95S5DiuoJCBQ==
From:   "tip-bot2 for Hou Wenlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/head/64: Move the __head definition to <asm/init.h>
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C0583f57977be184689c373fe540cbd7d85ca2047=2E16975?=
 =?utf-8?q?25407=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
References: =?utf-8?q?=3C0583f57977be184689c373fe540cbd7d85ca2047=2E169752?=
 =?utf-8?q?5407=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169754783149.3135.16164318910465112906.tip-bot2@tip-bot2>
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

Commit-ID:     d2a285d65bfde3218fd0c3b88794d0135ced680b
Gitweb:        https://git.kernel.org/tip/d2a285d65bfde3218fd0c3b88794d0135ced680b
Author:        Hou Wenlong <houwenlong.hwl@antgroup.com>
AuthorDate:    Tue, 17 Oct 2023 15:08:06 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Oct 2023 14:51:14 +02:00

x86/head/64: Move the __head definition to <asm/init.h>

Move the __head section definition to a header to widen its use.

An upcoming patch will mark the code as __head in mem_encrypt_identity.c too.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/0583f57977be184689c373fe540cbd7d85ca2047.1697525407.git.houwenlong.hwl@antgroup.com
---
 arch/x86/include/asm/init.h | 2 ++
 arch/x86/kernel/head64.c    | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 5f1d3c4..cc9ccf6 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
+#define __head	__section(".head.text")
+
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
 	void *context;			 /* context for alloc_pgt_page */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index f0efc22..05a110c 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -41,6 +41,7 @@
 #include <asm/trapnr.h>
 #include <asm/sev.h>
 #include <asm/tdx.h>
+#include <asm/init.h>
 
 /*
  * Manage page tables very early on.
@@ -84,8 +85,6 @@ static struct desc_ptr startup_gdt_descr __initdata = {
 	.address = 0,
 };
 
-#define __head	__section(".head.text")
-
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
