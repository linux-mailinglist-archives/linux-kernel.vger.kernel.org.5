Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3A78968E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjHZMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjHZMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:10:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58CE58;
        Sat, 26 Aug 2023 05:10:31 -0700 (PDT)
Date:   Sat, 26 Aug 2023 12:10:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693051818;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Msth3dkf8X2kA7WZxZWOV6C1fFS+oM8EFs6QwZc88Fw=;
        b=t0wnYIoDZ4rkcji6FOkdnULS5Eb+KUFEb0xppxmUqeKrhJCPyZsQbSyBQgT7I7aXHg6LXx
        4O1/dFujonzNThiAD01TzOfFWhFgFkY7zsTVR0XwlubmlKq0BAoj5QuK//dJsnWChY3Epe
        M8WIFv7c1kqzXUymannfUHP/8EPe/rOL2XWGs+MsBaRIia/iCovv8YtcqRl1e0VBqTnl/Z
        aajTYZwCuT9D6opAopZsjpji+VPuOGDz994XciO5q4WSc7N5hmmwXY9UilsEUAB10bmI7T
        da/vwxE+m+hqI3QI/BMdqEXkrTnWHvyg+rnFqoGpPjIlsDuDEgdRib0NSVVFpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693051818;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Msth3dkf8X2kA7WZxZWOV6C1fFS+oM8EFs6QwZc88Fw=;
        b=EGm6rA+JfMmSBQTypf4IRraKsAM7C6s6XjFtwc3XvEd4hTKWRKtohCTGoQx9aDs2h8OH+Y
        kv0YS+p3FA7OHfAA==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Remove remaining references to
 CONFIG_MICROCODE_AMD
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <169305181746.27769.8171958719830211744.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     4d2b748305e96fb76202a0d1072a285b1500bff3
Gitweb:        https://git.kernel.org/tip/4d2b748305e96fb76202a0d1072a285b1500bff3
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Fri, 25 Aug 2023 16:12:26 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 26 Aug 2023 13:37:55 +02:00

x86/microcode: Remove remaining references to CONFIG_MICROCODE_AMD

Commit e6bcfdd75d53 ("x86/microcode: Hide the config knob") removed the
MICROCODE_AMD config, but left some references in defconfigs and comments,
that have no effect on any kernel build around.

Clean up those remaining config references. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230825141226.13566-1-lukas.bulwahn@gmail.com
---
 arch/x86/configs/i386_defconfig          | 1 -
 arch/x86/configs/x86_64_defconfig        | 1 -
 arch/x86/kernel/cpu/microcode/internal.h | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 3cf3491..c33250f 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -33,7 +33,6 @@ CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
 CONFIG_NR_CPUS=8
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
-CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
 CONFIG_X86_CPUID=y
 CONFIG_X86_CHECK_BIOS_CORRUPTION=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 2775923..2aae0c0 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -31,7 +31,6 @@ CONFIG_SMP=y
 CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
-CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
 CONFIG_X86_CPUID=y
 CONFIG_NUMA=y
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 8ee9392..bf883aa 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -104,7 +104,7 @@ int save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 struct microcode_ops *init_amd_microcode(void);
 void exit_amd_microcode(void);
-#else /* CONFIG_MICROCODE_AMD */
+#else /* CONFIG_CPU_SUP_AMD */
 static inline void load_ucode_amd_bsp(unsigned int family) { }
 static inline void load_ucode_amd_ap(unsigned int family) { }
 static inline void load_ucode_amd_early(unsigned int family) { }
@@ -112,7 +112,7 @@ static inline int save_microcode_in_initrd_amd(unsigned int family) { return -EI
 static inline void reload_ucode_amd(unsigned int cpu) { }
 static inline struct microcode_ops *init_amd_microcode(void) { return NULL; }
 static inline void exit_amd_microcode(void) { }
-#endif /* !CONFIG_MICROCODE_AMD */
+#endif /* !CONFIG_CPU_SUP_AMD */
 
 #ifdef CONFIG_CPU_SUP_INTEL
 void load_ucode_intel_bsp(void);
