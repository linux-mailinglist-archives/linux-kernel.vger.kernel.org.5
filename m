Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA8787F30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjHYFGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjHYFG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:06:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65B31FF0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:06:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf0b24d925so4934295ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692939985; x=1693544785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3zT7KyiHlbPGOkcR8/QPNmqoCabKbCC6GI5E//7oIA=;
        b=VbMguP7wXH8hcUkMyI3z8jNJVqts4Ti6Fc3IrmUWPcfA3fBiMcwd7OhZpTAbWymnLR
         I8wcXHai+2fBaNySku9/kD5jtqxS1bwmzCi01dA4hj5SrOhrWImSgZt/LeXOXCMeLekt
         bN010oULR70MWAJzwrWUvLzbprayplUycmSns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692939985; x=1693544785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3zT7KyiHlbPGOkcR8/QPNmqoCabKbCC6GI5E//7oIA=;
        b=cg1FAAsBbJcs2Byer/l6L1eQCOiWw3AvwnqTt3A51gfau+BoOIb4SiIayr2ZQLTK+x
         Zdr+Hxw0tUfVvDNhHpDc8On72rfQTzUStsyOp4zRyjTSgyJaLKBqixdYZhAHu0DB2FQ1
         f/3JmUScQx/u12nmIspPAYUkctcBQH+0Dqjc6B/a8ryAFsv8W7bwZXawkCjgZQXtNFPr
         HLCmV/IX36+lYdwtTehNzR26MkQx84u+B1nkKJTqztFj6u8BtRW5gEC1jWSepqPFrAel
         nMVfck3A5L1iSXg7EQLBUWDIrmZ9pmmvFYA0IXSsX/V4DI9nifXcDtj6w3su7VQsmVQ3
         2aBQ==
X-Gm-Message-State: AOJu0Yzg+/Rei908CL2MMVU2OT96EZsSRQTED6xl0eTEP1NYVrv3RSoN
        M5YmVVltaSr2Q/rmBJ/YWM9SBA==
X-Google-Smtp-Source: AGHT+IH6t3JzhPvDoxwMCbWGkRetaj8kRjjlY68CofkEKwVynUZOnb29p1p1g7bVUKgsqI05bIhSHA==
X-Received: by 2002:a17:903:234e:b0:1b9:f7f4:5687 with SMTP id c14-20020a170903234e00b001b9f7f45687mr14274579plh.24.1692939985261;
        Thu, 24 Aug 2023 22:06:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bd10-20020a170902830a00b001bc56c1a384sm604488plb.277.2023.08.24.22.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 22:06:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] hardening: Provide Kconfig fragments for basic options
Date:   Thu, 24 Aug 2023 22:06:22 -0700
Message-Id: <20230825050618.never.197-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7615; i=keescook@chromium.org;
 h=from:subject:message-id; bh=2e7nTx+drvmh685ztXp5pQSAg2+x4Sh+eUEYxk3J+Uo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk6DbOKInN3FBBYpvVk+qT9ymT1xR4RqGelWIeH
 MPC+KDzmcGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZOg2zgAKCRCJcvTf3G3A
 JiigEACvsvKy5NaiIL4d5QD+amZfb3dM3d8KuI4mohEpuMLt2izjJ6o/E3LiohpmR4epiubwr3V
 AfA7mZ9+sR99uZsdXTS9Go6rn+Xih2jAQh1XM3lcsJL3nes36WRpvmwJWG9fLND2iC1BL4FfgwR
 SI1FA3km3QIavkV/tI4p4EL++xG/mZnIAnAuLLlKQiZCLSUPAhSTG2YBIVzBRiZOYCJyCknUZgm
 sh0HrmnUK84Vv7JSUQxVVYcqXI9iUwQm01+YZoN03lIroCSFsTyBrKacsbktaHYmgSTW8VM/Dy8
 xSMKm8fDYTRLSttr430No8k/xRm7X6i7PVUOvTP5i6Bvxo6+1crHU1f6Z4HECM0ecxhShffsQT+
 nkwhNXLN1/rorItXt1kdDXAPe+TfXoz+h3O8sONcjtImF1UqBYqrCoZZd5feP0ghf/7PGK7L6QC
 JoPW4dEzoWvBJ659+2xPsmpU51m2Rk34Nxvolx7QfjXhY8KPCD0Kqkg0+d5msnVJhdTK3uRJqPy
 9KzbQAYQLLpF3WeN4/AehfYRNkPEGOc6ykRiSaydewyzuFZt+5jkLe3GHhBGv38EJd3LtyOw0Gw
 45Wxq5GgAxKdMdiPmLvpYIl+Y6AoUYxFe1QMVZ+AiII67Vc+jCLm8lMg7uWB/QZR2UIDS+nudB3
 1O1uhF/ 30tXLVLQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by Salvatore Mesoraca's earlier[1] efforts to provide some
in-tree guidance for kernel hardening Kconfig options, add a new fragment
named "hardening-basic.config" (along with some arch-specific fragments)
that enable a basic set of kernel hardening options that have the least
(or no) performance impact and remove a reasonable set of legacy APIs.

Using this fragment is as simple as running "make hardening.config".

More extreme fragments can be added[2] in the future to cover all the
recognized hardening options, and more per-architecture files can be
added too.

For now, document the fragments directly via comments. Perhaps .rst
documentation can be generated from them in the future (rather than the
other way around).

[1] https://lore.kernel.org/kernel-hardening/1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com/
[2] https://github.com/KSPP/linux/issues/14

Cc: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS                         |  2 +
 arch/arm/configs/hardening.config   |  7 ++
 arch/arm64/configs/hardening.config | 22 +++++++
 arch/x86/configs/hardening.config   | 15 +++++
 kernel/configs/hardening.config     | 99 +++++++++++++++++++++++++++++
 5 files changed, 145 insertions(+)
 create mode 100644 arch/arm/configs/hardening.config
 create mode 100644 arch/arm64/configs/hardening.config
 create mode 100644 arch/x86/configs/hardening.config
 create mode 100644 kernel/configs/hardening.config

diff --git a/MAINTAINERS b/MAINTAINERS
index 48abe1a281f2..36a28c132133 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11304,8 +11304,10 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/ABI/testing/sysfs-kernel-oops_count
 F:	Documentation/ABI/testing/sysfs-kernel-warn_count
+F:	arch/*/configs/hardening.config
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
+F:	kernel/configs/hardening.config
 F:	mm/usercopy.c
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
diff --git a/arch/arm/configs/hardening.config b/arch/arm/configs/hardening.config
new file mode 100644
index 000000000000..327349ce6377
--- /dev/null
+++ b/arch/arm/configs/hardening.config
@@ -0,0 +1,7 @@
+# Basic kernel hardening options (specific to arm)
+
+# Make sure PXN/PAN emulation is enabled.
+CONFIG_CPU_SW_DOMAIN_PAN=y
+
+# Dangerous; old interfaces and needless additional attack surface.
+# CONFIG_OABI_COMPAT is not set
diff --git a/arch/arm64/configs/hardening.config b/arch/arm64/configs/hardening.config
new file mode 100644
index 000000000000..b0e795208998
--- /dev/null
+++ b/arch/arm64/configs/hardening.config
@@ -0,0 +1,22 @@
+# Basic kernel hardening options (specific to arm64)
+
+# Make sure PAN emulation is enabled.
+CONFIG_ARM64_SW_TTBR0_PAN=y
+
+# Software Shadow Stack or PAC
+CONFIG_SHADOW_CALL_STACK=y
+
+# Pointer authentication (ARMv8.3 and later). If hardware actually supports
+# it, one can turn off CONFIG_STACKPROTECTOR_STRONG with this enabled.
+CONFIG_ARM64_PTR_AUTH=y
+CONFIG_ARM64_PTR_AUTH_KERNEL=y
+
+# Available in ARMv8.5 and later.
+CONFIG_ARM64_BTI=y
+CONFIG_ARM64_BTI_KERNEL=y
+CONFIG_ARM64_MTE=y
+CONFIG_KASAN_HW_TAGS=y
+CONFIG_ARM64_E0PD=y
+
+# Available in ARMv8.7 and later.
+CONFIG_ARM64_EPAN=y
diff --git a/arch/x86/configs/hardening.config b/arch/x86/configs/hardening.config
new file mode 100644
index 000000000000..19bb0c7a7669
--- /dev/null
+++ b/arch/x86/configs/hardening.config
@@ -0,0 +1,15 @@
+# Basic kernel hardening options (specific to x86)
+
+# Modern libc no longer needs a fixed-position mapping in userspace, remove
+# it as a possible target.
+CONFIG_LEGACY_VSYSCALL_NONE=y
+
+# Enable chip-specific IOMMU support.
+CONFIG_INTEL_IOMMU=y
+CONFIG_INTEL_IOMMU_DEFAULT_ON=y
+CONFIG_INTEL_IOMMU_SVM=y
+CONFIG_AMD_IOMMU=y
+CONFIG_AMD_IOMMU_V2=y
+
+# Enable CET Shadow Stack for userspace.
+CONFIG_X86_USER_SHADOW_STACK=y
diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
new file mode 100644
index 000000000000..dbeecdfca917
--- /dev/null
+++ b/kernel/configs/hardening.config
@@ -0,0 +1,99 @@
+# Basic kernel hardening options
+#
+# These are considered the basic kernel hardening, self-protection, and
+# attack surface reduction options. They are expected to have low (or
+# no) performance impact on most workloads, and have a reasonable level
+# of legacy API removals.
+
+# Make sure reporting of various hardening actions is possible.
+CONFIG_BUG=y
+
+# Basic kernel memory permission enforcement.
+CONFIG_STRICT_KERNEL_RWX=y
+CONFIG_STRICT_MODULE_RWX=y
+CONFIG_VMAP_STACK=y
+
+# Kernel image and memory ASLR.
+CONFIG_RANDOMIZE_BASE=y
+CONFIG_RANDOMIZE_MEMORY=y
+
+# Randomize allocator freelists, harden metadata.
+CONFIG_SLAB_FREELIST_RANDOM=y
+CONFIG_SLAB_FREELIST_HARDENED=y
+CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
+CONFIG_RANDOM_KMALLOC_CACHES=y
+
+# Randomize kernel stack offset on syscall entry.
+CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
+
+# Basic stack frame overflow protection.
+CONFIG_STACKPROTECTOR=y
+CONFIG_STACKPROTECTOR_STRONG=y
+
+# Basic buffer length bounds checking.
+CONFIG_HARDENED_USERCOPY=y
+CONFIG_FORTIFY_SOURCE=y
+
+# Basic array index bounds checking.
+CONFIG_UBSAN=y
+CONFIG_UBSAN_TRAP=y
+CONFIG_UBSAN_BOUNDS=y
+# CONFIG_UBSAN_SHIFT is not set
+# CONFIG_UBSAN_DIV_ZERO
+# CONFIG_UBSAN_UNREACHABLE
+# CONFIG_UBSAN_BOOL
+# CONFIG_UBSAN_ENUM
+# CONFIG_UBSAN_ALIGNMENT
+CONFIG_UBSAN_SANITIZE_ALL=y
+
+# Linked list integrity checking.
+CONFIG_LIST_HARDENED=y
+
+# Initialize all heap variables to zero on allocation.
+CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
+
+# Initialize all stack variables to zero on function entry.
+CONFIG_INIT_STACK_ALL_ZERO=y
+
+# Wipe all caller-used registers on exit from functions: reduces available
+# ROP gadgets and minimizes stale data in registers usable in side channels.
+CONFIG_ZERO_CALL_USED_REGS=y
+
+# Wipe RAM at reboot via EFI. For more details, see:
+# https://trustedcomputinggroup.org/resource/pc-client-work-group-platform-reset-attack-mitigation-specification/
+# https://bugzilla.redhat.com/show_bug.cgi?id=1532058
+CONFIG_RESET_ATTACK_MITIGATION=y
+
+# Disable DMA between EFI hand-off and the kernel's IOMMU setup.
+CONFIG_EFI_DISABLE_PCI_DMA=y
+
+# Force IOMMU TLB invalidation so devices will never be able to access stale
+# data content.
+CONFIG_IOMMU_SUPPORT=y
+CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
+
+# Do not allow direct physical memory access to non-device memory.
+CONFIG_STRICT_DEVMEM=y
+CONFIG_IO_STRICT_DEVMEM=y
+
+# Provide userspace with seccomp BPF API for syscall attack surface reduction.
+CONFIG_SECCOMP=y
+CONFIG_SECCOMP_FILTER=y
+
+# Provides some protections against SYN flooding.
+CONFIG_SYN_COOKIES=y
+
+# Attack surface reduction: do not autoload TTY line disciplines.
+# CONFIG_LDISC_AUTOLOAD is not set
+
+# Dangerous; enabling this disables userspace brk ASLR.
+# CONFIG_COMPAT_BRK is not set
+
+# Dangerous; exposes kernel text image layout.
+# CONFIG_PROC_KCORE is not set
+
+# Dangerous; enabling this disables userspace VDSO ASLR.
+# CONFIG_COMPAT_VDSO is not set
+
+# Attack surface reduction: Use the modern PTY interface (devpts) only.
+# CONFIG_LEGACY_PTYS is not set
-- 
2.34.1

