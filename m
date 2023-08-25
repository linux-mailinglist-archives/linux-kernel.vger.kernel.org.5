Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832C7788B64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbjHYOPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245741AbjHYOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:14:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B742684;
        Fri, 25 Aug 2023 07:14:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so218878466b.0;
        Fri, 25 Aug 2023 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692972758; x=1693577558;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihkK5NeLOZPOBD1OQ/Tzq+VAxZOB0etz/fl/JNHwlX4=;
        b=c+XJMgB55NsYFJv5WR559iqqkSrg2AqaIGmgNTNXbpszVN5XqWpCEaEGPwX+F18l+u
         ABMVpMFXD/CIFRSsUjIjhIic5NcEv4zeX8+dO8XMVGJVfk720QlS8vztg46hcH3jozGu
         nRAgx2CyWn1G9mmVdv+DhJ4Ga6DORdeF0gcRLknW4Tbc51ex6itu4kGQKliiTsAtObtc
         V5ipu/sYCru7I7tsnsU1fN2IHWtaNmHRV8ThUbGz13DadZylY7wVzdaDDJI063gO3Sz4
         v4hjSG78xZ8bi4050PVEflRXMUFVp9zlbdHC2TTkHwxcu/a5Lq5s++4AytVswRkETBcC
         ZAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972758; x=1693577558;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihkK5NeLOZPOBD1OQ/Tzq+VAxZOB0etz/fl/JNHwlX4=;
        b=QwPFiHxhmsoqQLHnO1msRaT0ikl06n33u6vzbr4RGvcb1X0pGRGW2/mvkwHki3UOop
         JYtVw73UjEQ70YNT6m/Yjvro/rpf/HFLc6c15EzcMVQZJSsN15AJBXDCvzuPUidpbaZV
         ZHXvOgxyJTOydEqIfrqV6rC8QnDBrg7Pb+TZs6C66u2uGiG3puTKiCWgw8y0NeH4Kyv9
         I6uRaIM0TyPQDH1gycqSUBEK9z6sP8uDwIX1BLa4FlpR2vI+T4EeHAgBdy5KEtoplj0E
         t1L/qUQnHJG8gF1Hjy3389xuT2Vxnio80AdHc56ZPtxLaHQFM/LaGAFO5kdJ/X/r9eoR
         6yTQ==
X-Gm-Message-State: AOJu0YyTlhzUmAQmwILLgQgU1jxwDscxbkld7G0nvjrck3b+WrFu1kQJ
        gzn4mjsdcUlscb7025R86xI=
X-Google-Smtp-Source: AGHT+IEcnwmZdInLFupKMvs7mSWhUpXTvdYvLyN0xOh+sKRS7/s4w1OumaQywBBfVhATp/3j9fWa/w==
X-Received: by 2002:a17:906:cc16:b0:99b:b398:53b6 with SMTP id ml22-20020a170906cc1600b0099bb39853b6mr19451389ejb.34.1692972757994;
        Fri, 25 Aug 2023 07:12:37 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:98c5:e120:ff1e:7709])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906940900b0099bccb03eadsm989057ejx.205.2023.08.25.07.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:12:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86: Clean up remaining references to CONFIG_MICROCODE_AMD
Date:   Fri, 25 Aug 2023 16:12:26 +0200
Message-Id: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e6bcfdd75d53 ("x86/microcode: Hide the config knob") removes config
MICROCODE_AMD, but left some references that have no effect on any kernel
build around.

Clean up those remaining config references. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/configs/i386_defconfig          | 1 -
 arch/x86/configs/x86_64_defconfig        | 1 -
 arch/x86/kernel/cpu/microcode/internal.h | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 75a343f10e58..1b411bbf3cb0 100644
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
index 0902518e9b93..409e9182bd29 100644
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
index 8ee9392e5c68..bf883aa71233 100644
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
-- 
2.17.1

