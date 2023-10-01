Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51567B47F1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjJAORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjJAORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:17:37 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6CA6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 07:17:34 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49d0ae5ec2fso1188139e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696169854; x=1696774654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVgAs7re9Hyt3K4pY5kD4vBjxhm5e+zVLHHYX5/SfNM=;
        b=anBPOhocNk3yIB6BlOf2M+9LvfxZKTPUHov1BEYr0xVtLAWQiHYuN6iaq06N9RKdeN
         l3L2ufZhdtQhcJyMDm5ZB2M51QI57ZYHUJYs+Hcrj6EMzO4ZiD3rgDt9ca2VgmntiAL1
         qQBvImiuEFnctuy2vPA7tfByr5EY/9OwgnfZ8tGDkgadqkqyD+TO3CkBOU+7miXdRTvp
         DALsjG+80hkF6f8gbTOARK5upT6HUAK9B83wugaKmYHrhqBAfgL0MEdTpFUHyDmn65BS
         4weeHZu1HMQbMgcM+L8FReoBCxJ1fJKs5z9n+9/2ZwiaMrfagQ/k2J3kGiScpNYEZzgC
         FYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696169854; x=1696774654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVgAs7re9Hyt3K4pY5kD4vBjxhm5e+zVLHHYX5/SfNM=;
        b=QwVZHODluWWOEhb+sEbXO2JFQeGuejUkqvi94XahuaXczZFXOFhK4IHkR5gbGHTwoJ
         yXoYNr1THzDH+tki8kcvWG8UVnfIzWMv5eZxQL3brrKd6lt6Vcarcp6FC1lHByDqovDv
         PwrDOsXKWoacLqq3SNOnempASHwkrsD2gweDsbDvcYdN+6M6uUegQp6LBZ7LWRDzX95K
         27cNTQ2Zo7kQU59DGkhDYLRvr3NqLlpisIxczVyU21uFdYUwihneIs+bS6BF4dMSfmAU
         NnK92gEu3mD2ShsTXvDE9fiVtDi4RouwQ5+cwKEGg4ZrifjnvxKl3fwb8jbLDjfFUytp
         aNeA==
X-Gm-Message-State: AOJu0Yyxvt1P2eVbgu+WhBw9HEm7mTSpzdC4xjFSbFWnCCBOSgEkAHrG
        kL7pS5FDxL3wleJpOKA48oInSY6tvUbUuJRKaK2mHARbwkiOHg==
X-Google-Smtp-Source: AGHT+IF99LA2xFuzh/e1S1KZo7choSy6KtrXNrV2glQVOGBz0cblYxAHW2DM7nRAsZnLbGP/I2AL1jdykYlEqtaskPY=
X-Received: by 2002:a05:6122:916:b0:49b:289a:cc47 with SMTP id
 j22-20020a056122091600b0049b289acc47mr8330142vka.7.1696169853678; Sun, 01 Oct
 2023 07:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora>
In-Reply-To: <ZRhKq6e5nF/4ZIV1@fedora>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 1 Oct 2023 23:17:21 +0900
Message-ID: <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 1:26=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com> =
wrote:
>
> On Sun, Sep 24, 2023 at 02:36:21PM -0700, Linus Torvalds wrote:
> > Another week, another -rc.
> >
> > As usual, rc3 is a bit larger than rc2, as people have started finding
> > more issues.
> >
> > Unusually, we have a large chunk of changes in filesystems. Part of it
> > is the vfs-level revert of some of the timestamp handling that needs
> > to soak a bit more, and part of it is some xfs fixes. With a few other
> > filesystem fixes too.
> >
> > But drivers and architecture updates are also up there, so it's not
> > like the fs stuff dominates. It's just more noticeable than it usually
> > is.
> >
> > Anyway, please do go test. None of this looks scary,
> >
> >                  Linus
> >
> > ---
>
> [...]
>
> > Peter Zijlstra (1):
> >       x86,static_call: Fix static-call vs return-thunk
>
> Hello, the commit above caused a crash on x86 kernel with
> CONFIG_DEBUG_VIRTUAL=3Dy.
>
> The compiler version is gcc (GCC) 13.2.1 20230728 (Red Hat 13.2.1-1),
> and below are dmesg (raw), dmesg (decoded), git bisect log,
> and the configuration used.
>
> I'm not sure if it would lead to an unwelcome surprise, because
> vmalloc_to_page(any valid kernel address) should work anyway.
> But it seems that by some reason, while updating kernel code,
> the kernel confuses kernel text area with vmalloc/module area.

OK, I looked into this a little bit, and it turns out that the problematic
address here is from cleanup_trusted() in
security/keys/trusted-keys/trusted_core.c.
(and it's builtin due to CONFIG_TRUSTED_KEYS=3Dy)

The function is marked as __exit, so it does not fall within the
'core kernel text address range,' which is between _stext and _etext
(or between _sinittext and _einittext). and thus __text_poke() thinks that
it's vmalloc/module area.

I think __text_poke() should be taught that functions marked as __exit
also belong to kernel code just like __init.

I did a quick hack below and the crash now disappeared.
Any thoughts?

In case someone wants to pick this up,
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

diff --git a/arch/Kconfig b/arch/Kconfig
index 12d51495caec..85b2fcfa0b36 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1479,6 +1479,12 @@ config ARCH_HAS_NONLEAF_PMD_YOUNG
    address translations. Page table walkers that clear the accessed bit
    may use this capability to reduce their search space.

+config ARCH_RUNTIME_DISCARD_EXIT
+ bool
+ help
+   Architectures that do not discard .exit.text and .text.exit sections
+   at link time, but discard at runtime should select this option.
+
 source "kernel/gcov/Kconfig"

 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..ef3e7d24c0a5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -107,6 +107,7 @@ config ARM64
  select ARCH_WANTS_NO_INSTR
  select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
  select ARCH_HAS_UBSAN_SANITIZE_ALL
+ select ARCH_RUNTIME_DISCARD_EXIT
  select ARM_AMBA
  select ARM_ARCH_TIMER
  select ARM_GIC
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.ld=
s.S
index 3cd7e76cc562..59bc3d70136d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -58,7 +58,6 @@
 #endif

 #define RO_EXCEPTION_TABLE_ALIGN 4
-#define RUNTIME_DISCARD_EXIT

 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8421859006..7e80aaf60ece 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -26,6 +26,7 @@ config MIPS
  select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
  select ARCH_WANT_IPC_PARSE_VERSION
  select ARCH_WANT_LD_ORPHAN_WARN
+ select ARCH_RUNTIME_DISCARD_EXIT
  select BUILDTIME_TABLE_SORT
  select CLONE_BACKWARDS
  select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.=
S
index 9ff55cb80a64..52cbde60edf5 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -15,8 +15,6 @@
 #define EMITS_PT_NOTE
 #endif

-#define RUNTIME_DISCARD_EXIT
-
 #include <asm-generic/vmlinux.lds.h>

 #undef mips
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 54b9387c3691..1449c008fc49 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -162,6 +162,7 @@ config PPC
  select ARCH_MIGHT_HAVE_PC_SERIO
  select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
  select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
+ select ARCH_RUNTIME_DISCARD_EXIT
  select ARCH_SPLIT_ARG64 if PPC32
  select ARCH_STACKWALK
  select ARCH_SUPPORTS_ATOMIC_RMW
diff --git a/arch/powerpc/kernel/vmlinux.lds.S
b/arch/powerpc/kernel/vmlinux.lds.S
index 1c5970df3233..cd584d93b567 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -8,7 +8,6 @@
 #define BSS_FIRST_SECTIONS *(.bss.prominit)
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN 0
-#define RUNTIME_DISCARD_EXIT

 #define SOFT_MASK_TABLE(align) \
  . =3D ALIGN(align); \
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..28a0f3191f55 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -41,6 +41,7 @@ config RISCV
  select ARCH_HAS_VDSO_DATA
  select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
  select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
+ select ARCH_RUNTIME_DISCARD_EXIT
  select ARCH_STACKWALK
  select ARCH_SUPPORTS_ATOMIC_RMW
  select ARCH_SUPPORTS_CFI_CLANG
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.ld=
s.S
index 492dd4b8f3d6..bfea7d216995 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -5,7 +5,6 @@
  */

 #define RO_EXCEPTION_TABLE_ALIGN 4
-#define RUNTIME_DISCARD_EXIT

 #ifdef CONFIG_XIP_KERNEL
 #include "vmlinux-xip.lds.S"
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ae29e4392664..5bc250613b45 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -113,6 +113,7 @@ config S390
  select ARCH_INLINE_WRITE_UNLOCK_BH
  select ARCH_INLINE_WRITE_UNLOCK_IRQ
  select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
+ select ARCH_RUNTIME_DISCARD_EXIT
  select ARCH_STACKWALK
  select ARCH_SUPPORTS_ATOMIC_RMW
  select ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.=
S
index 2ae201ebf90b..897dd3fcfaf2 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -19,8 +19,6 @@
 /* Handle ro_after_init data on our own. */
 #define RO_AFTER_INIT_DATA

-#define RUNTIME_DISCARD_EXIT
-
 #define EMITS_PT_NOTE

 #include <asm-generic/vmlinux.lds.h>
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 33530b044953..6574b3d69668 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -14,6 +14,7 @@ config SUPERH
  select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
  select ARCH_HIBERNATION_POSSIBLE if MMU
  select ARCH_MIGHT_HAVE_PC_PARPORT
+ select ARCH_RUNTIME_DISCARD_EXIT
  select ARCH_WANT_IPC_PARSE_VERSION
  select CPU_NO_EFFICIENT_FFS
  select DMA_DECLARE_COHERENT
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index 9644fe187a3f..947e2e213ff9 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -4,7 +4,6 @@
  * Written by Niibe Yutaka and Paul Mundt
  */
 OUTPUT_ARCH(sh)
-#define RUNTIME_DISCARD_EXIT
 #include <asm/thread_info.h>
 #include <asm/cache.h>
 #include <asm/vmlinux.lds.h>
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index b5e179360534..0dd76a2ca44a 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,6 +11,7 @@ config UML
  select ARCH_HAS_KCOV
  select ARCH_HAS_STRNCPY_FROM_USER
  select ARCH_HAS_STRNLEN_USER
+ select ARCH_RUNTIME_DISCARD_EXIT
  select ARCH_NO_PREEMPT
  select HAVE_ARCH_AUDITSYSCALL
  select HAVE_ARCH_KASAN if X86_64
diff --git a/arch/um/kernel/vmlinux.lds.S b/arch/um/kernel/vmlinux.lds.S
index 53d719c04ba9..38fb9d1c67b7 100644
--- a/arch/um/kernel/vmlinux.lds.S
+++ b/arch/um/kernel/vmlinux.lds.S
@@ -1,4 +1,3 @@
-#define RUNTIME_DISCARD_EXIT
 KERNEL_STACK_SIZE =3D 4096 * (1 << CONFIG_KERNEL_STACK_ORDER);

 #ifdef CONFIG_LD_SCRIPT_STATIC
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..1c704bcc950d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -106,6 +106,7 @@ config X86
  select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
  select ARCH_MIGHT_HAVE_PC_PARPORT
  select ARCH_MIGHT_HAVE_PC_SERIO
+ select ARCH_RUNTIME_DISCARD_EXIT
  select ARCH_STACKWALK
  select ARCH_SUPPORTS_ACPI
  select ARCH_SUPPORTS_ATOMIC_RMW
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f15fb71f280e..3ac30568b818 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -21,7 +21,6 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif

-#define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN 16

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.=
h
index db13bb620f52..72243f849f95 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -20,6 +20,7 @@
  * [__init_begin, __init_end]: contains .init.* sections, but .init.text.*
  *                   may be out of this range on some architectures.
  * [_sinittext, _einittext]: contains .init.text.* sections
+ * [_sexittext, _eexittext]: contains .exit.text or .text.exit sections
  * [__bss_start, __bss_stop]: contains BSS sections
  *
  * Following global variables are optional and may be unavailable on some
@@ -37,6 +38,9 @@ extern char _data[], _sdata[], _edata[];
 extern char __bss_start[], __bss_stop[];
 extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
+#ifdef CONFIG_ARCH_RUNTIME_DISCARD_EXIT
+extern char _sexittext[], _eexittext[];
+#endif
 extern char __start_ro_after_init[], __end_ro_after_init[];
 extern char _end[];
 extern char __per_cpu_load[], __per_cpu_start[], __per_cpu_end[];
@@ -194,6 +198,25 @@ static inline bool is_kernel_inittext(unsigned long ad=
dr)
         addr < (unsigned long)_einittext;
 }

+/**
+ * is_kernel_exittext - checks if the pointer address is located in the
+ *                      .text.exit or .exit.text section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .text.exit or .exit.text,
+ * false otherwise.
+ */
+static inline bool is_kernel_exittext(unsigned long addr)
+{
+#ifdef CONFIG_ARCH_RUNTIME_DISCARD_EXIT
+ return addr >=3D (unsigned long)_sexittext &&
+        addr < (unsigned long)_eexittext;
+#else
+ return false;
+#endif
+}
+
 /**
  * __is_kernel_text - checks if the pointer address is located in the
  *                    .text section
diff --git a/include/asm-generic/vmlinux.lds.h
b/include/asm-generic/vmlinux.lds.h
index 9c59409104f6..f9dc2bf3781e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -724,10 +724,19 @@
  MEM_DISCARD(exit.data*) \
  MEM_DISCARD(exit.rodata*)

+#ifdef CONFIG_ARCH_RUNTIME_DISCARD_EXIT
 #define EXIT_TEXT \
+ _sexittext =3D .; \
  *(.exit.text) \
  *(.text.exit) \
+ _eexittext =3D .; \
  MEM_DISCARD(exit.text)
+#else
+#define EXIT_TEXT \
+ *(.exit.text) \
+ *(.text.exit) \
+ MEM_DISCARD(exit.text)
+#endif

 #define EXIT_CALL \
  *(.exitcall.exit)
@@ -977,7 +986,7 @@
  * section definitions so that such archs put those in earlier section
  * definitions.
  */
-#ifdef RUNTIME_DISCARD_EXIT
+#ifdef CONFIG_ARCH_RUNTIME_DISCARD_EXIT
 #define EXIT_DISCARDS
 #else
 #define EXIT_DISCARDS \
diff --git a/kernel/extable.c b/kernel/extable.c
index 71f482581cab..3362a9c2f3d8 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -71,6 +71,11 @@ int notrace core_kernel_text(unsigned long addr)
  if (system_state < SYSTEM_FREEING_INITMEM &&
      is_kernel_inittext(addr))
  return 1;
+
+ if (system_state < SYSTEM_FREEING_INITMEM &&
+     is_kernel_exittext(addr))
+ return 1;
+
  return 0;
 }

--=20
2.41.0
