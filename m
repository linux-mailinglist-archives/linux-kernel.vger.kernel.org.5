Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5E479961A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjIIDdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjIIDdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:33:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC21FE3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:33:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68bedc0c268so2549053b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 20:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1694230406; x=1694835206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeLl8YdaHyx7HhDqMP87501A0Q5s54VhYD5XOxh2KIg=;
        b=qQaKkm31cjHXOpx/gF0LcnwaBPEp41Q4BpHdM7TDZeg4as/A45F6MfUvurGDHae+3O
         vhBOx0Zwo8dIK0bP023ZrZ0A8byXLTdeaYvbiowfFBtJIe3LUsdfgt4Wll2q6w1Td39T
         PRaxMOS1mdkVw+wizNLuPjpnHftglyfz6gNi7PbpYLFy1elJmT7r4Tepk2nhDrTNbM83
         c5CyY1UEhf/YuFmi+wlO40x9MERNk/d9inc6FaXx9j2SCe+LGq3Qz3x5UIxpDoi3LZ5j
         ThpT9KfCxKA5z0/BufiO/9tzXXd25u30Wk0v+AKpeIlBGj9Lt7dsMi7QAlXpFHuVhfng
         ribw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694230406; x=1694835206;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeLl8YdaHyx7HhDqMP87501A0Q5s54VhYD5XOxh2KIg=;
        b=ryeEi5JgdSHk07AN3tizDHrHUUPJCfoL5j4CirhwEd7ykbxEnw+MiaPIdx0pOLzGQi
         zFyWbWi6PzTTpRDBuSab8N+O+WCd0QZSTC8Q+graFUNTnqA9zxcBVsgQF9HsbPXUS+bk
         ys7fDdsh1rOp8yB+LraLRtfp8sUe8HdWen+gfKVgF4MQisTenmF3bzD6ymF1UQkrg1DA
         Lh4hJ5dSGEek1oXKFOTOyHBodaFPrZ8N/Ja1ZpOqtmUa6avyUiiE3BO7vkMuSVsZtU35
         QjRcVZsaNt4QHYmWgJsvToL+lx7O7xdLU6wTnT/CBrGIp3MdWe/vwMxfZ+sLe5m9Mlf8
         HNIA==
X-Gm-Message-State: AOJu0Yx5sD/eSbBKS1sM1Bzcf18jz8nxULv8vslwUsacL07Fm0T0FiCC
        aWdWAJwRAubh2ZK5cxSZiwMhVaWeaB/KXc8g33k=
X-Google-Smtp-Source: AGHT+IEiJmKf1OqFza5z8ll79wJncz+nIwfygCRyeflgKIknojjOTwUb1e5P02ibJCzrXupv9D92gA==
X-Received: by 2002:a05:6a00:b45:b0:68c:1004:1feb with SMTP id p5-20020a056a000b4500b0068c10041febmr5031058pfo.32.1694230405555;
        Fri, 08 Sep 2023 20:33:25 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id j9-20020aa79289000000b0066a31111cc5sm1926677pfa.152.2023.09.08.20.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 20:33:25 -0700 (PDT)
Date:   Fri, 08 Sep 2023 20:33:25 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Sep 2023 20:32:34 PDT (-0700)
Subject:     Re: [PATCH AUTOSEL 6.4 25/25] riscv: Add CFI error handling
In-Reply-To: <20230909003715.3579761-25-sashal@kernel.org>
CC:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        keescook@chromium.org, Conor Dooley <conor.dooley@microchip.com>,
        nathan@kernel.org, sashal@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ndesaulniers@google.com,
        peterz@infradead.org, ajones@ventanamicro.com, heiko@sntech.de,
        prabhakar.mahadev-lad.rj@bp.renesas.com, liaochang1@huawei.com,
        namcaov@gmail.com, andy.chiu@sifive.com, guoren@kernel.org,
        alexghiti@rivosinc.com, Bjorn Topel <bjorn@rivosinc.com>,
        jeeheng.sia@starfivetech.com, jszhang@kernel.org,
        greentime.hu@sifive.com, masahiroy@kernel.org,
        apatel@ventanamicro.com, mnissler@rivosinc.com,
        coelacanthushex@gmail.com, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sashal@kernel.org, samitolvanen@google.com
Message-ID: <mhng-e2cedb63-0933-4752-bfd8-592e4e1f6e2c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2023 17:37:13 PDT (-0700), sashal@kernel.org wrote:
> From: Sami Tolvanen <samitolvanen@google.com>
>
> [ Upstream commit af0ead42f69389cd4ed68e1a4c6cde45c0adb35c ]
>
> With CONFIG_CFI_CLANG, the compiler injects a type preamble immediately
> before each function and a check to validate the target function type
> before indirect calls:
>
>   ; type preamble
>     .word <id>
>   function:
>     ...
>   ; indirect call check
>     lw      t1, -4(a0)
>     lui     t2, <hi20>
>     addiw   t2, t2, <lo12>
>     beq     t1, t2, .Ltmp0
>     ebreak
>   .Ltmp0:
>     jarl    a0
>
> Implement error handling code for the ebreak traps emitted for the
> checks. This produces the following oops on a CFI failure (generated
> using lkdtm):
>
> [   21.177245] CFI failure at lkdtm_indirect_call+0x22/0x32 [lkdtm]
> (target: lkdtm_increment_int+0x0/0x18 [lkdtm]; expected type: 0x3ad55aca)
> [   21.178483] Kernel BUG [#1]
> [   21.178671] Modules linked in: lkdtm
> [   21.179037] CPU: 1 PID: 104 Comm: sh Not tainted
> 6.3.0-rc6-00037-g37d5ec6297ab #1
> [   21.179511] Hardware name: riscv-virtio,qemu (DT)
> [   21.179818] epc : lkdtm_indirect_call+0x22/0x32 [lkdtm]
> [   21.180106]  ra : lkdtm_CFI_FORWARD_PROTO+0x48/0x7c [lkdtm]
> [   21.180426] epc : ffffffff01387092 ra : ffffffff01386f14 sp : ff20000000453cf0
> [   21.180792]  gp : ffffffff81308c38 tp : ff6000000243f080 t0 : ff20000000453b78
> [   21.181157]  t1 : 000000003ad55aca t2 : 000000007e0c52a5 s0 : ff20000000453d00
> [   21.181506]  s1 : 0000000000000001 a0 : ffffffff0138d170 a1 : ffffffff013870bc
> [   21.181819]  a2 : b5fea48dd89aa700 a3 : 0000000000000001 a4 : 0000000000000fff
> [   21.182169]  a5 : 0000000000000004 a6 : 00000000000000b7 a7 : 0000000000000000
> [   21.182591]  s2 : ff20000000453e78 s3 : ffffffffffffffea s4 : 0000000000000012
> [   21.183001]  s5 : ff600000023c7000 s6 : 0000000000000006 s7 : ffffffff013882a0
> [   21.183653]  s8 : 0000000000000008 s9 : 0000000000000002 s10: ffffffff0138d878
> [   21.184245]  s11: ffffffff0138d878 t3 : 0000000000000003 t4 : 0000000000000000
> [   21.184591]  t5 : ffffffff8133df08 t6 : ffffffff8133df07
> [   21.184858] status: 0000000000000120 badaddr: 0000000000000000
> cause: 0000000000000003
> [   21.185415] [<ffffffff01387092>] lkdtm_indirect_call+0x22/0x32 [lkdtm]
> [   21.185772] [<ffffffff01386f14>] lkdtm_CFI_FORWARD_PROTO+0x48/0x7c [lkdtm]
> [   21.186093] [<ffffffff01383552>] lkdtm_do_action+0x22/0x34 [lkdtm]
> [   21.186445] [<ffffffff0138350c>] direct_entry+0x128/0x13a [lkdtm]
> [   21.186817] [<ffffffff8033ed8c>] full_proxy_write+0x58/0xb2
> [   21.187352] [<ffffffff801d4fe8>] vfs_write+0x14c/0x33a
> [   21.187644] [<ffffffff801d5328>] ksys_write+0x64/0xd4
> [   21.187832] [<ffffffff801d53a6>] sys_write+0xe/0x1a
> [   21.188171] [<ffffffff80003996>] ret_from_syscall+0x0/0x2
> [   21.188595] Code: 0513 0f65 a303 ffc5 53b7 7e0c 839b 2a53 0363 0073 (9002) 9582
> [   21.189178] ---[ end trace 0000000000000000 ]---
> [   21.189590] Kernel panic - not syncing: Fatal exception
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com> # ISA bits
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Link: https://lore.kernel.org/r/20230710183544.999540-12-samitolvanen@google.com
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/riscv/Kconfig            |  1 +
>  arch/riscv/include/asm/cfi.h  | 22 ++++++++++
>  arch/riscv/include/asm/insn.h | 10 +++++
>  arch/riscv/kernel/Makefile    |  2 +
>  arch/riscv/kernel/cfi.c       | 77 +++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/traps.c     |  4 +-
>  6 files changed, 115 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/cfi.h
>  create mode 100644 arch/riscv/kernel/cfi.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 052845384ed38..36dd0390b8257 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -45,6 +45,7 @@ config RISCV
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
>  	select ARCH_USE_MEMTEST
>  	select ARCH_USE_QUEUED_RWLOCKS
> +	select ARCH_USES_CFI_TRAPS if CFI_CLANG
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
> diff --git a/arch/riscv/include/asm/cfi.h b/arch/riscv/include/asm/cfi.h
> new file mode 100644
> index 0000000000000..56bf9d69d5e38
> --- /dev/null
> +++ b/arch/riscv/include/asm/cfi.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_CFI_H
> +#define _ASM_RISCV_CFI_H
> +
> +/*
> + * Clang Control Flow Integrity (CFI) support.
> + *
> + * Copyright (C) 2023 Google LLC
> + */
> +
> +#include <linux/cfi.h>
> +
> +#ifdef CONFIG_CFI_CLANG
> +enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
> +#else
> +static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
> +{
> +	return BUG_TRAP_TYPE_NONE;
> +}
> +#endif /* CONFIG_CFI_CLANG */
> +
> +#endif /* _ASM_RISCV_CFI_H */
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 603095c913e37..bbd878d4815ce 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -63,6 +63,7 @@
>  #define RVG_RS1_OPOFF		15
>  #define RVG_RS2_OPOFF		20
>  #define RVG_RD_OPOFF		7
> +#define RVG_RS1_MASK		GENMASK(4, 0)
>  #define RVG_RD_MASK		GENMASK(4, 0)
>
>  /* The bit field of immediate value in RVC J instruction */
> @@ -130,6 +131,7 @@
>  #define RVC_C2_RS1_OPOFF	7
>  #define RVC_C2_RS2_OPOFF	2
>  #define RVC_C2_RD_OPOFF		7
> +#define RVC_C2_RS1_MASK		GENMASK(4, 0)
>
>  /* parts of opcode for RVG*/
>  #define RVG_OPCODE_FENCE	0x0f
> @@ -269,6 +271,10 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
>  #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
>  #define RVC_X(X, s, mask) RV_X(X, s, mask)
>
> +#define RV_EXTRACT_RS1_REG(x) \
> +	({typeof(x) x_ = (x); \
> +	(RV_X(x_, RVG_RS1_OPOFF, RVG_RS1_MASK)); })
> +
>  #define RV_EXTRACT_RD_REG(x) \
>  	({typeof(x) x_ = (x); \
>  	(RV_X(x_, RVG_RD_OPOFF, RVG_RD_MASK)); })
> @@ -296,6 +302,10 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
>  	(RV_X(x_, RV_B_IMM_11_OPOFF, RV_B_IMM_11_MASK) << RV_B_IMM_11_OFF) | \
>  	(RV_IMM_SIGN(x_) << RV_B_IMM_SIGN_OFF); })
>
> +#define RVC_EXTRACT_C2_RS1_REG(x) \
> +	({typeof(x) x_ = (x); \
> +	(RV_X(x_, RVC_C2_RS1_OPOFF, RVC_C2_RS1_MASK)); })
> +
>  #define RVC_EXTRACT_JTYPE_IMM(x) \
>  	({typeof(x) x_ = (x); \
>  	(RVC_X(x_, RVC_J_IMM_3_1_OPOFF, RVC_J_IMM_3_1_MASK) << RVC_J_IMM_3_1_OFF) | \
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 153864e4f3996..c173a7cbf4e11 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -90,6 +90,8 @@ obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
>
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>
> +obj-$(CONFIG_CFI_CLANG)		+= cfi.o
> +
>  obj-$(CONFIG_EFI)		+= efi.o
>  obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
>  obj-$(CONFIG_COMPAT)		+= compat_signal.o
> diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
> new file mode 100644
> index 0000000000000..820158d7a2913
> --- /dev/null
> +++ b/arch/riscv/kernel/cfi.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clang Control Flow Integrity (CFI) support.
> + *
> + * Copyright (C) 2023 Google LLC
> + */
> +#include <asm/cfi.h>
> +#include <asm/insn.h>
> +
> +/*
> + * Returns the target address and the expected type when regs->epc points
> + * to a compiler-generated CFI trap.
> + */
> +static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
> +			    u32 *type)
> +{
> +	unsigned long *regs_ptr = (unsigned long *)regs;
> +	int rs1_num;
> +	u32 insn;
> +
> +	*target = *type = 0;
> +
> +	/*
> +	 * The compiler generates the following instruction sequence
> +	 * for indirect call checks:
> +	 *
> +	 *   lw      t1, -4(<reg>)
> +	 *   lui     t2, <hi20>
> +	 *   addiw   t2, t2, <lo12>
> +	 *   beq     t1, t2, .Ltmp1
> +	 *   ebreak  ; <- regs->epc
> +	 *   .Ltmp1:
> +	 *   jalr    <reg>
> +	 *
> +	 * We can read the expected type and the target address from the
> +	 * registers passed to the beq/jalr instructions.
> +	 */
> +	if (get_kernel_nofault(insn, (void *)regs->epc - 4))
> +		return false;
> +	if (!riscv_insn_is_beq(insn))
> +		return false;
> +
> +	*type = (u32)regs_ptr[RV_EXTRACT_RS1_REG(insn)];
> +
> +	if (get_kernel_nofault(insn, (void *)regs->epc) ||
> +	    get_kernel_nofault(insn, (void *)regs->epc + GET_INSN_LENGTH(insn)))
> +		return false;
> +
> +	if (riscv_insn_is_jalr(insn))
> +		rs1_num = RV_EXTRACT_RS1_REG(insn);
> +	else if (riscv_insn_is_c_jalr(insn))
> +		rs1_num = RVC_EXTRACT_C2_RS1_REG(insn);
> +	else
> +		return false;
> +
> +	*target = regs_ptr[rs1_num];
> +
> +	return true;
> +}
> +
> +/*
> + * Checks if the ebreak trap is because of a CFI failure, and handles the trap
> + * if needed. Returns a bug_trap_type value similarly to report_bug.
> + */
> +enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
> +{
> +	unsigned long target;
> +	u32 type;
> +
> +	if (!is_cfi_trap(regs->epc))
> +		return BUG_TRAP_TYPE_NONE;
> +
> +	if (!decode_cfi_insn(regs, &target, &type))
> +		return report_cfi_failure_noaddr(regs, regs->epc);
> +
> +	return report_cfi_failure(regs, regs->epc, &target, type);
> +}
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index bd19e885dcec1..8db848e2c244c 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -21,6 +21,7 @@
>
>  #include <asm/asm-prototypes.h>
>  #include <asm/bug.h>
> +#include <asm/cfi.h>
>  #include <asm/csr.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
> @@ -242,7 +243,8 @@ void handle_break(struct pt_regs *regs)
>  								== NOTIFY_STOP)
>  		return;
>  #endif
> -	else if (report_bug(regs->epc, regs) == BUG_TRAP_TYPE_WARN)
> +	else if (report_bug(regs->epc, regs) == BUG_TRAP_TYPE_WARN ||
> +		 handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN)
>  		regs->epc += get_break_insn_length(regs->epc);
>  	else
>  		die(regs, "Kernel BUG");

Sami probably understands the dependencies better than I do, but I don't 
think this one is sane to just backport -- there's a whole series here, 
and IIRC we had to set up some clang bits for it to work correctly.
