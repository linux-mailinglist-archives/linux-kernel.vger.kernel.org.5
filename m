Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97B80C489
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjLKJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjLKJ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:28:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B21FF3;
        Mon, 11 Dec 2023 01:28:11 -0800 (PST)
Date:   Mon, 11 Dec 2023 09:28:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702286887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUnc38wqNzJtCDmoCJjliKfhEmieVjL/tDIDenaAD9c=;
        b=LbDYXTz9XrqPK0id7GTb72EfrKR/fabeIfrzE3VFDWdP3OCKHQtv4beNdiRWm+f6PFtTqE
        TmGrqJZyTsU9KmV2N/DGTcB4WCw8LiN2X2SChdthD9gWqXnY6lkSFKIvATcdzQk1XGPV6I
        c9CK5DcbGsVUo1mBBD/TfjrzVViNuoQPQzkC8d8rS8wqnVolyDAOzOC7fuQwi8C1EROS7E
        gdcnKYz7JFXrXR+QOwFNWJjYHGLNqVrkM1DeKpma0Nlc7nS693vZcBUJp/l5O0AdaMFHEw
        RkIXwwqk5JANXDkCkMzsF8QCE1WjOkB6YojZGxIx4yfybDyh2bOVlqwesUIrCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702286887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUnc38wqNzJtCDmoCJjliKfhEmieVjL/tDIDenaAD9c=;
        b=geoHrtc7AzqC6QqJxv19wl4hwq11/+p/KP6YmMQou9eSzQWg9XNawRSYgVwb4mfdPmGj/K
        6gmFtAuQu5uDwoBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/ia32: State that IA32 emulation is disabled
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231130155213.1407-1-bp@alien8.de>
References: <20231130155213.1407-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170228688659.398.10301092120327382196.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f789383fa34a266d0c1a76f272043a15a8edf733
Gitweb:        https://git.kernel.org/tip/f789383fa34a266d0c1a76f272043a15a8edf733
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 30 Nov 2023 16:39:33 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 11 Dec 2023 10:14:28 +01:00

x86/ia32: State that IA32 emulation is disabled

Issue a short message once, on the first try to load a 32-bit process to
save people time when wondering why it won't load and trying to execute
it, would say:

  -bash: ./strsep32: cannot execute binary file: Exec format error

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20231130155213.1407-1-bp@alien8.de
---
 arch/x86/include/asm/elf.h  |  2 +-
 arch/x86/include/asm/ia32.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index a0234df..1e16bd5 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -150,7 +150,7 @@ do {						\
 	((x)->e_machine == EM_X86_64)
 
 #define compat_elf_check_arch(x)					\
-	((elf_check_arch_ia32(x) && ia32_enabled()) ||			\
+	((elf_check_arch_ia32(x) && ia32_enabled_verbose()) ||		\
 	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
 
 static inline void elf_common_init(struct thread_struct *t,
diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index 5a2ae24..094886a 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_IA32_H
 #define _ASM_X86_IA32_H
 
-
 #ifdef CONFIG_IA32_EMULATION
 
 #include <linux/compat.h>
@@ -84,4 +83,14 @@ static inline bool ia32_enabled(void)
 
 #endif
 
+static inline bool ia32_enabled_verbose(void)
+{
+	bool enabled = ia32_enabled();
+
+	if (IS_ENABLED(CONFIG_IA32_EMULATION) && !enabled)
+		pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");
+
+	return enabled;
+}
+
 #endif /* _ASM_X86_IA32_H */
