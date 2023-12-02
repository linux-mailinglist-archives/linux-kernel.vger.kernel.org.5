Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C61801D29
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjLBNxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLBNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:52:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E02107
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 05:53:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA43C433CA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701525185;
        bh=omoFf0Pb8E4723BExdaEITPxCeKkg6A15sqBlNcLIoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qO2oyIkSm4woQUb1XTkcvI1vjRXeDu39hv+2mK0hNz+GOh0ifK0HPeJpraq1y6vTC
         OaaOQfidSJ/H+Skk54dBBUOgdkhKemhPYUPoeOyIYOEljhjAY4KFe3ux12FrEmnf9r
         qeJm61AEN2nyXUYTFttpPY2pR1HNlswxMqHQhZWmmIIUV8DbDKt65O7ybPkzYgfKP0
         B2RURoJ2z3C/Q3/tbIpemZ0IA/zCP77j/BY32kLhQ0xk0t9DcCPIiarI0kPU6PjVEY
         9pgEscA7bK78lz74zEvip88/nOOyh0sC2aIPfXVvMI8NBSpE1FpXkZZ8Gcqs6Z9MOT
         gskHY8DTrD2KQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b3ffaso3987850a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 05:53:05 -0800 (PST)
X-Gm-Message-State: AOJu0YyPYj8WFDmbMaXopryKpXEpjvxL7BHrskH1bgtuBeQqhH4ooF7P
        EmGWCSJPJmtbEvAO70bS1f+aQx7O0LOh70dvmew=
X-Google-Smtp-Source: AGHT+IE0peyiGSaoNVHxpOJXfNXUfW3/IKyVPvum1b8TXQX8n2hX5+redSF3sm8d7S0M/fKYNk/jRIOGosSU0kZKPu4=
X-Received: by 2002:a05:6402:cab:b0:54c:4837:9aa0 with SMTP id
 cn11-20020a0564020cab00b0054c48379aa0mr1433718edb.71.1701525183892; Sat, 02
 Dec 2023 05:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
In-Reply-To: <20231129130701.27744-1-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 2 Dec 2023 21:52:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7VWCFJPYLN6SRuxvvhe6gsj1HHYbLgZaWFk7g8sh1LPA@mail.gmail.com>
Message-ID: <CAAhV-H7VWCFJPYLN6SRuxvvhe6gsj1HHYbLgZaWFk7g8sh1LPA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add objtool and orc support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

There are still some build warnings.

If FUNCTION_TRACER enabled, we get
  AS      arch/loongarch/kernel/mcount_dyn.o
arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
ftrace_common+0x0: unreachable instruction
arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
ftrace_caller+0x0: unreachable instruction
arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
ftrace_regs_caller+0x0: unreachable instruction
arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
ftrace_graph_caller+0x0: unreachable instruction
arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
return_to_handler+0x0: unreachable instruction
arch/loongarch/kernel/mcount_dyn.o: warning: objtool:
ftrace_stub_direct_tramp+0x0: unreachable instruction

  AS      arch/loongarch/kernel/rethook_trampoline.o
arch/loongarch/kernel/rethook_trampoline.o: warning: objtool:
arch_rethook_trampoline+0x0: unreachable instruction

And when I use the latest binutils/gcc for native build, there are
some warnings in some files from the {init, kernel} directory. But
cross-building is fine, I don't know why.

Huacai

On Wed, Nov 29, 2023 at 9:07=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> This version is based on 6.7-rc3, tested with the latest upstream
> gcc and binutils (20231127).
>
> v5:
>   -- Fix the partial backtrace about irq stack
>   -- Check on_stack() again after get_stack_info()
>   -- Silence the orc warning about handle_syscall
>   -- Silence the objtool warnings if CONFIG_CPU_HAS_LBT=3Dy
>   -- Update the commit message about objdump and readelf info
>
> Tiezhu Yang (8):
>   objtool/LoongArch: Enable objtool to be built
>   objtool/LoongArch: Implement instruction decoder
>   objtool/x86: Separate arch-specific and generic parts
>   objtool/LoongArch: Enable orc to be built
>   objtool: Check local label about sibling call
>   objtool: Check local label in add_dead_ends()
>   objtool: Check local label in read_unwind_hints()
>   LoongArch: Add ORC stack unwinder support
>
>  arch/loongarch/Kconfig                        |   2 +
>  arch/loongarch/Kconfig.debug                  |  11 +
>  arch/loongarch/Makefile                       |  19 +
>  arch/loongarch/include/asm/Kbuild             |   2 +
>  arch/loongarch/include/asm/bug.h              |   1 +
>  arch/loongarch/include/asm/exception.h        |   2 +
>  arch/loongarch/include/asm/module.h           |   7 +
>  arch/loongarch/include/asm/orc_header.h       |  18 +
>  arch/loongarch/include/asm/orc_lookup.h       |  31 ++
>  arch/loongarch/include/asm/orc_types.h        |  58 ++
>  arch/loongarch/include/asm/stackframe.h       |   3 +
>  arch/loongarch/include/asm/unwind.h           |  19 +-
>  arch/loongarch/include/asm/unwind_hints.h     |  28 +
>  arch/loongarch/kernel/Makefile                |   4 +
>  arch/loongarch/kernel/entry.S                 |   6 +-
>  arch/loongarch/kernel/fpu.S                   |   7 +
>  arch/loongarch/kernel/genex.S                 |   6 +-
>  arch/loongarch/kernel/lbt.S                   |   5 +
>  arch/loongarch/kernel/module.c                |  22 +-
>  arch/loongarch/kernel/relocate_kernel.S       |   2 +
>  arch/loongarch/kernel/setup.c                 |   2 +
>  arch/loongarch/kernel/stacktrace.c            |   1 +
>  arch/loongarch/kernel/traps.c                 |  42 +-
>  arch/loongarch/kernel/unwind_orc.c            | 516 ++++++++++++++++++
>  arch/loongarch/kernel/vmlinux.lds.S           |   3 +
>  arch/loongarch/kvm/switch.S                   |   7 +-
>  arch/loongarch/lib/Makefile                   |   2 +
>  arch/loongarch/mm/tlb.c                       |  27 +-
>  arch/loongarch/mm/tlbex.S                     |   9 +
>  arch/loongarch/vdso/Makefile                  |   1 +
>  include/linux/compiler.h                      |   9 +
>  scripts/Makefile                              |   7 +-
>  tools/arch/loongarch/include/asm/inst.h       | 161 ++++++
>  tools/arch/loongarch/include/asm/orc_types.h  |  58 ++
>  tools/include/linux/bitops.h                  |  11 +
>  tools/objtool/Makefile                        |   4 +
>  tools/objtool/arch/loongarch/Build            |   3 +
>  tools/objtool/arch/loongarch/decode.c         | 356 ++++++++++++
>  .../arch/loongarch/include/arch/cfi_regs.h    |  22 +
>  .../objtool/arch/loongarch/include/arch/elf.h |  30 +
>  .../arch/loongarch/include/arch/special.h     |  33 ++
>  tools/objtool/arch/loongarch/orc.c            | 171 ++++++
>  tools/objtool/arch/loongarch/special.c        |  15 +
>  tools/objtool/arch/x86/Build                  |   1 +
>  tools/objtool/arch/x86/orc.c                  | 188 +++++++
>  tools/objtool/check.c                         | 117 ++--
>  tools/objtool/include/objtool/elf.h           |   1 +
>  tools/objtool/include/objtool/orc.h           |  14 +
>  tools/objtool/orc_dump.c                      |  69 +--
>  tools/objtool/orc_gen.c                       | 113 +---
>  50 files changed, 1983 insertions(+), 263 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/orc_header.h
>  create mode 100644 arch/loongarch/include/asm/orc_lookup.h
>  create mode 100644 arch/loongarch/include/asm/orc_types.h
>  create mode 100644 arch/loongarch/include/asm/unwind_hints.h
>  create mode 100644 arch/loongarch/kernel/unwind_orc.c
>  create mode 100644 tools/arch/loongarch/include/asm/inst.h
>  create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
>  create mode 100644 tools/objtool/arch/loongarch/Build
>  create mode 100644 tools/objtool/arch/loongarch/decode.c
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/cfi_regs.h
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/special.h
>  create mode 100644 tools/objtool/arch/loongarch/orc.c
>  create mode 100644 tools/objtool/arch/loongarch/special.c
>  create mode 100644 tools/objtool/arch/x86/orc.c
>  create mode 100644 tools/objtool/include/objtool/orc.h
>
> --
> 2.42.0
>
>
