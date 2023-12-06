Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F43807664
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378761AbjLFRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378608AbjLFRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:20:28 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5496D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:20:34 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EDBFA40E00C7;
        Wed,  6 Dec 2023 17:20:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FIKI1gkZHfAe; Wed,  6 Dec 2023 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701883230; bh=SEuXI2V3X/3Kx/69zzGav63YjHB73NgqtYnRloB+IFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dla+lMacDWjBuJyMsEJsWRG24Y0kGMEcbY8gFoVhi47w9IzpBkylGZyzo/3M+WxIg
         WU3FxK6VxTVdx/LORD2NVamUqrFFXn3lPOJ/2cwLhu7c2+5o+920mMglDo/17+cs7F
         rpDhDKUxhO5JEPTMKAcL130wM4FHFE8YmR2dMWTGuHfhdOL8xBvsiQPBAAp26YHcQe
         OxqiT5dnPGCDJfFfy6L+FiObOmQirp7KljlqFNT1QtzBrzqhwVkdBjzc/hGg9qwnzF
         6aT7jbSCEmPgHEuGWJAgUzUJtGAzYXUMTaDJmPBou51wfvASS4mcwZh7GNJ5GLD9xF
         TkgeOFlfEO1Asau7M8v5LHPbYcsaIng3QYo1qdyTZXNdVqVM+AkfTXq9AJoJazr2pL
         ySM7+sHX7gR5xgmXQRUv6rLhF9ZQWDE9xwZ7comppATf9bqrSFcgo9Cc2pmApWDW3I
         jRTGgGX9/S7ub+Kn7Gq0qtL6ANDHIV6DeFnFe00u03JIQur2ySTaAiQI//xOZnBK31
         58q9rka8Jt3m8vqsfbYWeCc/KLjF8S29CvPmiHucQ1dejNp1ijxH3wKh08kzBF0jiu
         YrAX4TLdWcY9yxL4m0HHdacHHkp1aK0ygo4q0g8AB7uurbhkJNDONrGHIBO0tQiutb
         pcb1aVaicsjC4UO8RKvTBUtw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A7CE40E00C6;
        Wed,  6 Dec 2023 17:20:27 +0000 (UTC)
Date:   Wed, 6 Dec 2023 18:20:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH -v2] x86/ia32: State that IA32 emulation is disabled
Message-ID: <20231206172022.GCZXCtVoZtt4t2TLpe@fat_crate.local>
References: <20231130155213.1407-1-bp@alien8.de>
 <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Thu, 30 Nov 2023 16:39:33 +0100

Issue a short message once, on the first try to load a 32-bit process to
save people time when wondering why it won't load and trying to execute
it, would say:

  -bash: ./strsep32: cannot execute binary file: Exec format error

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/elf.h  |  2 +-
 arch/x86/include/asm/ia32.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index a0234dfd1031..1e16bd5ac781 100644
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
index 5a2ae24b1204..094886a8717e 100644
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
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
