Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD7799EF7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjIJQ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 12:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjIJQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 12:26:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9AA1B5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 09:26:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9d6b98845so896934066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694363193; x=1694967993; darn=vger.kernel.org;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v4XtEu5dilMHWsI40O8lMqiqCI7apsftXEHGDDwuf80=;
        b=rV1y2ZZgsLvazFZS5rnWFMddUZI88GzyHpgEqK10fh6JbCUP4O6JrYJHlMRsdnEF77
         P6BmzmcGJ2Kz5nuxTJnNem2S7yH1gz478OwEvPNA/4/MTaTfT/pDOgrCOwsP/yn5hJ+A
         yaO1HkHbWy3MIjjQM1kVByOV07WOP6usOxtGEjLMPHzeJK5O2XvFsEirX2OhCGeb+gDY
         tEoxK+33PFng78NOO+HwfH9JfoEI2+LZJ3iqtEFmADUeB8FWE1llxiNZOnAjhW8xHOJ8
         AgzHUq0cj+rGpiFNlyjCKAoI+Wn2s29YUlVhxAmF8GpsK1EQG2TSOFbb91M/ztkxprlI
         A3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694363193; x=1694967993;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4XtEu5dilMHWsI40O8lMqiqCI7apsftXEHGDDwuf80=;
        b=Qrw6yPhY5vA3+m+EB6ECErYRKsLvYcKmqmTG0zp3SUmAbt5LjhAajoLFfYds7+S66f
         4yH1N1qPyO9uX+AqL3v385VRKba/9TEds9Sj0FXo2MEgnCwk3msJroLCf+RZdJXRjZU5
         Po2pgK/IXH0sSP0JcX8ECw4SKMaGYRWuh6nOG0lGivOH0Uu7skoqhA5zxSLRiJ5nNdu+
         WyB8OuplTZp7Cfz5raBaO9gU6FN8ShK+9pu9E1DUtw5s5Th+TH+pdD/buGPWfULfCdMj
         W55ahvmKfYcyGhFdc+FoTJSz3BEHKhG4lc3nPrxxVqsjRSLJzYq9/DwGXL1d/aIm0cMO
         aPYQ==
X-Gm-Message-State: AOJu0YyosD73dJBNB4C/k7LjEwyn/rirYpNuynV9PJj0BUijQQ82yl41
        IJK4jHxS5jDEGEy+li68PZU=
X-Google-Smtp-Source: AGHT+IEVIEkxbpwxnviDNyI+TBaUt4v9fmWahdxNimGQeI1oCrU7WDuyqqOmtZuUkbL+l3VxaAyWBg==
X-Received: by 2002:a17:907:2be0:b0:9a9:f042:deb9 with SMTP id gv32-20020a1709072be000b009a9f042deb9mr10518951ejc.19.1694363193129;
        Sun, 10 Sep 2023 09:26:33 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id v14-20020a170906338e00b00992b1c93279sm3966861eja.110.2023.09.10.09.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 09:26:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 10 Sep 2023 18:26:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZP3uNpupKtWeBh/d@gmail.com>
References: <ZPMNXtbIPMdjdn3o@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-10

   # HEAD: 3d7d72a34e05b23e21bafc8bfb861e73c86b31f3 x86/sgx: Break up long non-preemptible delays in sgx_vepc_release()

Fix preemption delays in the SGX code, remove unnecessarily UAPI-exported code,
fix a ld.lld linker (in)compatibility quirk and make the x86 SMP init code a bit
more conservative to fix kexec() lockups.

 Thanks,

	Ingo

------------------>
Jack Wang (1):
      x86/sgx: Break up long non-preemptible delays in sgx_vepc_release()

Song Liu (1):
      x86/build: Fix linker fill bytes quirk/incompatibility for ld.lld

Thomas Gleixner (1):
      x86/smp: Don't send INIT to non-present and non-booted CPUs

Thomas Huth (1):
      x86: Remove the arch_calc_vm_prot_bits() macro from the UAPI


 arch/x86/include/asm/mman.h      | 15 +++++++++++++++
 arch/x86/include/uapi/asm/mman.h |  8 --------
 arch/x86/kernel/cpu/sgx/virt.c   |  3 +++
 arch/x86/kernel/smpboot.c        |  2 +-
 arch/x86/kernel/vmlinux.lds.S    |  2 +-
 scripts/headers_install.sh       |  1 -
 6 files changed, 20 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/include/asm/mman.h

diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
new file mode 100644
index 000000000000..12b820259b9f
--- /dev/null
+++ b/arch/x86/include/asm/mman.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+#define arch_calc_vm_prot_bits(prot, key) (		\
+		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
+		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
+		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
+		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+#endif
+
+#include <uapi/asm/mman.h>
+
+#endif /* __ASM_MMAN_H__ */
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 8148bdddbd2c..46cdc941f958 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -5,14 +5,6 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 #define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-#define arch_calc_vm_prot_bits(prot, key) (		\
-		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
-		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
-		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
-		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
-#endif
-
 /* Flags for map_shadow_stack(2) */
 #define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
 
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index c3e37eaec8ec..7aaa3652e31d 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -204,6 +204,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			continue;
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -222,6 +223,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			list_add_tail(&epc_page->list, &secs_pages);
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -243,6 +245,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 
 		if (sgx_vepc_free_page(epc_page))
 			list_add_tail(&epc_page->list, &secs_pages);
+		cond_resched();
 	}
 
 	if (!list_empty(&secs_pages))
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d7667a29acf3..4e45ff44aa07 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1250,7 +1250,7 @@ bool smp_park_other_cpus_in_init(void)
 	if (this_cpu)
 		return false;
 
-	for_each_present_cpu(cpu) {
+	for_each_cpu_and(cpu, &cpus_booted_once_mask, cpu_present_mask) {
 		if (cpu == this_cpu)
 			continue;
 		apicid = apic->cpu_present_to_apicid(cpu);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 83d41c2601d7..f15fb71f280e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -156,7 +156,7 @@ SECTIONS
 		ALIGN_ENTRY_TEXT_END
 		*(.gnu.warning)
 
-	} :text =0xcccc
+	} :text = 0xcccccccc
 
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index afdddc82f02b..56d3c338d91d 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -81,7 +81,6 @@ arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
-arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 "
 
 for c in $configs
