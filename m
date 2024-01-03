Return-Path: <linux-kernel+bounces-15219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ABA822894
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C721C22F89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FAD1798C;
	Wed,  3 Jan 2024 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HT5T1oMu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342714F6C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d76923ec4so39930505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 22:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704264591; x=1704869391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eZvBlPK9tEXh/6idjRUyZbuu0z27bQiMm1LKGzDKtTA=;
        b=HT5T1oMuoov1DzpqG3LBaGSfWEk5oq4byErDp44MUrlez3nSQIuaEulnlu7BHtlDJM
         GUCUCo8SPNrsO/7jFmQJ59RwgeKqIkFtgJzAf/9AwXyyRs7bVhKxxnMuK+753D2ADMkU
         qD2aQDawTgVuuAGQQ/u5y8flSRctla9xkza2BHLGdPAWQccEdzKJtolDUE/RYdQWKQrS
         qHfRLZ9KUwv1kVUubzV0ukDCljZcBHL9KTyjNy6W0NQux8qBahZJFHixheXgjlCY+WT3
         6iTuJUpYabw4LCK6XhPLRKNwz6/LBqUCquXE7syR6H3ESDNrQQbrh+iMM1SdvTSpgjpz
         xyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704264591; x=1704869391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZvBlPK9tEXh/6idjRUyZbuu0z27bQiMm1LKGzDKtTA=;
        b=vAn2AV574jFTOO8bI37eC3Nxxj+qzlzJLPtF0JPQ2NmH4QgPr5H7eciXN1gOPUOTKL
         Z1Hw6B4ijQLIhNX/RnkSzBiwYmwW8OvnmqB9xVir3C2Or4MwZymPO62rtdFu91hxJBsz
         MjG+qxY++XPkADvR7ejF4Fajnx7bAY02nnkvILE2Is+mleLVNdnjp2B+MNBqqIZCSoGx
         HBrFMCNxsE11pjOES1mK3K7HOFWpY0nGxCKUv8fMzuC34RwGr/l9PcLBOAD0/YXNA6KB
         MfffqvRZH53oioRulQ72nbFARptOFfahgwJ5/eAxxzG9Mf4wee5JxwTiudQmucpmjF+R
         Erpw==
X-Gm-Message-State: AOJu0Ywyrt9XmP66a7h0v49RTX4NmSVOzDT44tyX+YqPZ9IrwhNl0+/F
	HMKMXx6DaDD7q5oqdPxWyWiPUOvZCR6MrQ==
X-Google-Smtp-Source: AGHT+IFeQ+FaIEd4TnBWqLCjj67cK5t0mWUddT+qMz0iJhTvN5+HLwazYdnUePv7VYYkxzKiS2n7Rw==
X-Received: by 2002:a05:600c:470d:b0:40d:7264:2218 with SMTP id v13-20020a05600c470d00b0040d72642218mr3876286wmo.17.1704264591632;
        Tue, 02 Jan 2024 22:49:51 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b0040d5a5c523csm1314206wmq.1.2024.01.02.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 22:49:51 -0800 (PST)
Date: Wed, 3 Jan 2024 07:49:44 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Guo Ren <guoren@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions &
 cpufeature
Message-ID: <20240103-8a6aba29ada25eb1ab004687@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
 <20240102-4f12393de3c6313650a24c17@orel>
 <CAJF2gTRRqbC5RTGtwhQD1pR+JoP_D64+AUMdO2r5ff-cR5AaUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTRRqbC5RTGtwhQD1pR+JoP_D64+AUMdO2r5ff-cR5AaUg@mail.gmail.com>

On Wed, Jan 03, 2024 at 02:13:00PM +0800, Guo Ren wrote:
> On Tue, Jan 2, 2024 at 6:32 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Cache-block prefetch instructions are HINTs to the hardware to
> > > indicate that software intends to perform a particular type of
> > > memory access in the near future. This patch adds prefetch.i,
> > > prefetch.r and prefetch.w instruction definitions by
> > > RISCV_ISA_EXT_ZICBOP cpufeature.
> >
> > It also adds S-type instruction encoding support which isn't mentioned.
> > Actually, it'd probably be best to put the new instruction encoding in
> > its own separate patch.
> Okay, I would separate the instruction encoding patch in the next version.
> 
> >
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/Kconfig                | 15 ++++++++
> > >  arch/riscv/include/asm/hwcap.h    |  1 +
> > >  arch/riscv/include/asm/insn-def.h | 60 +++++++++++++++++++++++++++++++
> > >  arch/riscv/kernel/cpufeature.c    |  1 +
> > >  4 files changed, 77 insertions(+)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 24c1799e2ec4..fcbd417d65ea 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -579,6 +579,21 @@ config RISCV_ISA_ZICBOZ
> > >
> > >          If you don't know what to do here, say Y.
> > >
> > > +config RISCV_ISA_ZICBOP
> > > +     bool "Zicbop extension support for cache block prefetch"
> > > +     depends on MMU
> > > +     depends on RISCV_ALTERNATIVE
> > > +     default y
> > > +     help
> > > +       Adds support to dynamically detect the presence of the ZICBOP
> > > +       extension (Cache Block Prefetch Operations) and enable its
> > > +       usage.
> > > +
> > > +       The Zicbop extension can be used to prefetch cache block for
> >
> > blocks
> >
> > > +       read/write fetch.
> > > +
> > > +       If you don't know what to do here, say Y.
> > > +
> > >  config TOOLCHAIN_HAS_ZIHINTPAUSE
> > >       bool
> > >       default y
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > index 06d30526ef3b..77d3b6ee25ab 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -57,6 +57,7 @@
> > >  #define RISCV_ISA_EXT_ZIHPM          42
> > >  #define RISCV_ISA_EXT_SMSTATEEN              43
> > >  #define RISCV_ISA_EXT_ZICOND         44
> > > +#define RISCV_ISA_EXT_ZICBOP         45
> > >
> > >  #define RISCV_ISA_EXT_MAX            64
> > >
> > > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > > index e27179b26086..bbda350a63bf 100644
> > > --- a/arch/riscv/include/asm/insn-def.h
> > > +++ b/arch/riscv/include/asm/insn-def.h
> > > @@ -18,6 +18,13 @@
> > >  #define INSN_I_RD_SHIFT                       7
> > >  #define INSN_I_OPCODE_SHIFT           0
> > >
> > > +#define INSN_S_SIMM7_SHIFT           25
> > > +#define INSN_S_RS2_SHIFT             20
> > > +#define INSN_S_RS1_SHIFT             15
> > > +#define INSN_S_FUNC3_SHIFT           12
> > > +#define INSN_S_SIMM5_SHIFT            7
> > > +#define INSN_S_OPCODE_SHIFT           0
> > > +
> > >  #ifdef __ASSEMBLY__
> > >
> > >  #ifdef CONFIG_AS_HAS_INSN
> > > @@ -30,6 +37,10 @@
> > >       .insn   i \opcode, \func3, \rd, \rs1, \simm12
> > >       .endm
> > >
> > > +     .macro insn_s, opcode, func3, rs2, simm12, rs1
> > > +     .insn   s \opcode, \func3, \rs2, \simm12(\rs1)
> > > +     .endm
> > > +
> > >  #else
> > >
> > >  #include <asm/gpr-num.h>
> > > @@ -51,10 +62,20 @@
> > >                (\simm12 << INSN_I_SIMM12_SHIFT))
> > >       .endm
> > >
> > > +     .macro insn_s, opcode, func3, rs2, simm12, rs1
> > > +     .4byte  ((\opcode << INSN_S_OPCODE_SHIFT) |             \
> > > +              (\func3 << INSN_S_FUNC3_SHIFT) |               \
> > > +              (.L__gpr_num_\rs2 << INSN_S_RS2_SHIFT) |       \
> > > +              (.L__gpr_num_\rs1 << INSN_S_RS1_SHIFT) |       \
> > > +              ((\simm12 & 0x1f) << INSN_S_SIMM5_SHIFT) |     \
> > > +              (((\simm12 >> 5) & 0x7f) << INSN_S_SIMM7_SHIFT))
> > > +     .endm
> > > +
> > >  #endif
> > >
> > >  #define __INSN_R(...)        insn_r __VA_ARGS__
> > >  #define __INSN_I(...)        insn_i __VA_ARGS__
> > > +#define __INSN_S(...)        insn_s __VA_ARGS__
> > >
> > >  #else /* ! __ASSEMBLY__ */
> > >
> > > @@ -66,6 +87,9 @@
> > >  #define __INSN_I(opcode, func3, rd, rs1, simm12)     \
> > >       ".insn  i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n"
> > >
> > > +#define __INSN_S(opcode, func3, rs2, simm12, rs1)    \
> > > +     ".insn  s " opcode ", " func3 ", " rs2 ", " simm12 "(" rs1 ")\n"
> > > +
> > >  #else
> > >
> > >  #include <linux/stringify.h>
> > > @@ -92,12 +116,26 @@
> > >  "             (\\simm12 << " __stringify(INSN_I_SIMM12_SHIFT) "))\n" \
> > >  "    .endm\n"
> > >
> > > +#define DEFINE_INSN_S                                                        \
> > > +     __DEFINE_ASM_GPR_NUMS                                           \
> > > +"    .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> > > +"    .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> > > +"             (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> > > +"             (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> > > +"             (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> > > +"             ((\\simm12 & 0x1f) << " __stringify(INSN_S_SIMM5_SHIFT) ") |" \
> > > +"             (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> > > +"    .endm\n"
> > > +
> > >  #define UNDEFINE_INSN_R                                                      \
> > >  "    .purgem insn_r\n"
> > >
> > >  #define UNDEFINE_INSN_I                                                      \
> > >  "    .purgem insn_i\n"
> > >
> > > +#define UNDEFINE_INSN_S                                                      \
> > > +"    .purgem insn_s\n"
> > > +
> > >  #define __INSN_R(opcode, func3, func7, rd, rs1, rs2)                 \
> > >       DEFINE_INSN_R                                                   \
> > >       "insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n" \
> > > @@ -108,6 +146,11 @@
> > >       "insn_i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n" \
> > >       UNDEFINE_INSN_I
> > >
> > > +#define __INSN_S(opcode, func3, rs2, simm12, rs1)                    \
> > > +     DEFINE_INSN_S                                                   \
> > > +     "insn_s " opcode ", " func3 ", " rs2 ", " simm12 ", " rs1 "\n"  \
> > > +     UNDEFINE_INSN_S
> > > +
> > >  #endif
> > >
> > >  #endif /* ! __ASSEMBLY__ */
> > > @@ -120,6 +163,10 @@
> > >       __INSN_I(RV_##opcode, RV_##func3, RV_##rd,              \
> > >                RV_##rs1, RV_##simm12)
> > >
> > > +#define INSN_S(opcode, func3, rs2, simm12, rs1)                      \
> > > +     __INSN_S(RV_##opcode, RV_##func3, RV_##rs2,             \
> > > +              RV_##simm12, RV_##rs1)
> > > +
> > >  #define RV_OPCODE(v)         __ASM_STR(v)
> > >  #define RV_FUNC3(v)          __ASM_STR(v)
> > >  #define RV_FUNC7(v)          __ASM_STR(v)
> > > @@ -133,6 +180,7 @@
> > >  #define RV___RS2(v)          __RV_REG(v)
> > >
> > >  #define RV_OPCODE_MISC_MEM   RV_OPCODE(15)
> > > +#define RV_OPCODE_OP_IMM     RV_OPCODE(19)
> > >  #define RV_OPCODE_SYSTEM     RV_OPCODE(115)
> > >
> > >  #define HFENCE_VVMA(vaddr, asid)                             \
> > > @@ -196,4 +244,16 @@
> > >       INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
> > >              RS1(base), SIMM12(4))
> > >
> > > +#define CBO_PREFETCH_I(base, offset)                         \
> > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),               \
> > > +            SIMM12(offset), RS1(base))
> > > +
> > > +#define CBO_PREFETCH_R(base, offset)                         \
> > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),               \
> > > +            SIMM12(offset), RS1(base))
> > > +
> > > +#define CBO_PREFETCH_W(base, offset)                         \
> > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > > +            SIMM12(offset), RS1(base))
> >
> > Shouldn't we ensure the lower 5-bits of offset are zero by masking it?
> The spec says:
> "These instructions operate on the cache block whose effective address
> is the sum of the base address specified in rs1 and the sign-extended
> offset encoded in imm[11:0], where imm[4:0] shall equal 0b00000. The
> effective address is translated into a corresponding physical address
> by the appropriate translation mechanisms."
> 
> So, the user of prefetch.w should keep imm[4:0] zero.

Yes, the user _should_ keep imm[4:0] zero. Unless we can validate at
compile time that all users have passed offsets with the lower 5-bits
set to zero, then I think we should mask them here, since I'd rather
not provide the user a footgun.

> Just like the
> patch has done, the whole imm[11:0] is zero.

That's just one possible use, and I think exposing the offset operand to
users makes sense for unrolled sequences of invocations, so I wouldn't
count on offset always being zero.

Thanks,
drew

