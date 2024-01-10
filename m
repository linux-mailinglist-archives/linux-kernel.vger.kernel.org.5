Return-Path: <linux-kernel+bounces-15902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE02823558
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A3DB2347E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E281CA9D;
	Wed,  3 Jan 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMZ0Tael"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80621CA8B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704308824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/jicjVu5Pj0CVrekeSkEQotUQ9nBr6fdfF7yQZAyO4=;
	b=NMZ0TaelLEsmbhHeRJ7HsPgfXyNhzmhxKhihS72K9ITyVsRLYRewE8+QB6rDN9+eWsmsiY
	O46AZW0v+iBshMlx727GbBY8jie77YYVGe11074gZ94pSAmaEYnXh6rj9T6RSqwuZI76Qc
	CKjGp8DJCWL6qdHhNoCyS/g6/2BWjQw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-pwiJZ3jSOwW0ysMDRqWHFQ-1; Wed, 03 Jan 2024 14:07:03 -0500
X-MC-Unique: pwiJZ3jSOwW0ysMDRqWHFQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28c5c622a3cso4326307a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308822; x=1704913622;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/jicjVu5Pj0CVrekeSkEQotUQ9nBr6fdfF7yQZAyO4=;
        b=clq1uIJBrv/QuSIAHgZl3lHr9ieI2PrS6y0V5JdUQuM9pqLru52qzpWADHGeJJzVtA
         EzHtDoiwfochmunCSz3xoTYpIBaZ1gj3p0+yUPMLuvuRVNPBkY3UysRZjzZU8h881r79
         cmqwHZX7oz4eLlKc+bT2lOU8yh4YjpQbpMvaR5i2UKnhrxg7gHrups9EcJuy0AYWGfrL
         JR3xuGSNtzDF1zzg3oH+X2KyYzJOijCO5Uhn68jJMd8KcKOa1K2ld+HDJGdw/Qa4UNj8
         Fe4mFU5akYRrO63J76CfaYyFkxbT/55UgQMUqr2LvNCW0hCqYmg5oJgyykUSYqqawKpB
         dfZQ==
X-Gm-Message-State: AOJu0YyjrgWk00QHls17QHcqDadpCnM7wOcScT2+IWIhDgx7Xgbb7mAo
	m/KQBn3saVmkUhBOBKNAbVg/zrtB5g8YNByVBkbGBlpuQ/9nqclsPj/oHNztFYIy0NTGREPCSz/
	zgtQEs3y5llLYWWIciTkyUQgJW80QlCfA
X-Received: by 2002:a17:90a:4587:b0:28c:7e37:d10 with SMTP id v7-20020a17090a458700b0028c7e370d10mr5314460pjg.43.1704308822316;
        Wed, 03 Jan 2024 11:07:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG82d0nu89OYPTNAg1NdtJcYG8lEZN3VcH66EhPHK4HbAlttT1DBeXXdSZgye8WhzkosTTQPg==
X-Received: by 2002:a17:90a:4587:b0:28c:7e37:d10 with SMTP id v7-20020a17090a458700b0028c7e370d10mr5314446pjg.43.1704308821992;
        Wed, 03 Jan 2024 11:07:01 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id gn2-20020a17090ac78200b0028bd9f88576sm2124024pjb.26.2024.01.03.11.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:07:01 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	guoren@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	peterz@infradead.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions & cpufeature
Date: Wed,  3 Jan 2024 16:06:51 -0300
Message-ID: <ZZWwSxoNJ5uEti02@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102-4f12393de3c6313650a24c17@orel>
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-2-guoren@kernel.org> <20240102-4f12393de3c6313650a24c17@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 02, 2024 at 11:32:44AM +0100, Andrew Jones wrote:
> On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > Cache-block prefetch instructions are HINTs to the hardware to
> > indicate that software intends to perform a particular type of
> > memory access in the near future. This patch adds prefetch.i,
> > prefetch.r and prefetch.w instruction definitions by
> > RISCV_ISA_EXT_ZICBOP cpufeature.
> 
> It also adds S-type instruction encoding support which isn't mentioned.
> Actually, it'd probably be best to put the new instruction encoding in
> its own separate patch.
> 
> > 
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig                | 15 ++++++++
> >  arch/riscv/include/asm/hwcap.h    |  1 +
> >  arch/riscv/include/asm/insn-def.h | 60 +++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c    |  1 +
> >  4 files changed, 77 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 24c1799e2ec4..fcbd417d65ea 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -579,6 +579,21 @@ config RISCV_ISA_ZICBOZ
> >  
> >  	   If you don't know what to do here, say Y.
> >  
> > +config RISCV_ISA_ZICBOP
> > +	bool "Zicbop extension support for cache block prefetch"
> > +	depends on MMU
> > +	depends on RISCV_ALTERNATIVE
> > +	default y
> > +	help
> > +	  Adds support to dynamically detect the presence of the ZICBOP
> > +	  extension (Cache Block Prefetch Operations) and enable its
> > +	  usage.
> > +
> > +	  The Zicbop extension can be used to prefetch cache block for
> 
> blocks
> 
> > +	  read/write fetch.
> > +
> > +	  If you don't know what to do here, say Y.
> > +
> >  config TOOLCHAIN_HAS_ZIHINTPAUSE
> >  	bool
> >  	default y
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 06d30526ef3b..77d3b6ee25ab 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -57,6 +57,7 @@
> >  #define RISCV_ISA_EXT_ZIHPM		42
> >  #define RISCV_ISA_EXT_SMSTATEEN		43
> >  #define RISCV_ISA_EXT_ZICOND		44
> > +#define RISCV_ISA_EXT_ZICBOP		45
> >  
> >  #define RISCV_ISA_EXT_MAX		64
> >  
> > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > index e27179b26086..bbda350a63bf 100644
> > --- a/arch/riscv/include/asm/insn-def.h
> > +++ b/arch/riscv/include/asm/insn-def.h
> > @@ -18,6 +18,13 @@
> >  #define INSN_I_RD_SHIFT			 7
> >  #define INSN_I_OPCODE_SHIFT		 0
> >  
> > +#define INSN_S_SIMM7_SHIFT		25
> > +#define INSN_S_RS2_SHIFT		20
> > +#define INSN_S_RS1_SHIFT		15
> > +#define INSN_S_FUNC3_SHIFT		12
> > +#define INSN_S_SIMM5_SHIFT		 7
> > +#define INSN_S_OPCODE_SHIFT		 0
> > +
> >  #ifdef __ASSEMBLY__
> >  
> >  #ifdef CONFIG_AS_HAS_INSN
> > @@ -30,6 +37,10 @@
> >  	.insn	i \opcode, \func3, \rd, \rs1, \simm12
> >  	.endm
> >  
> > +	.macro insn_s, opcode, func3, rs2, simm12, rs1
> > +	.insn	s \opcode, \func3, \rs2, \simm12(\rs1)
> > +	.endm
> > +
> >  #else
> >  
> >  #include <asm/gpr-num.h>
> > @@ -51,10 +62,20 @@
> >  		 (\simm12 << INSN_I_SIMM12_SHIFT))
> >  	.endm
> >  
> > +	.macro insn_s, opcode, func3, rs2, simm12, rs1
> > +	.4byte	((\opcode << INSN_S_OPCODE_SHIFT) |		\
> > +		 (\func3 << INSN_S_FUNC3_SHIFT) |		\
> > +		 (.L__gpr_num_\rs2 << INSN_S_RS2_SHIFT) |	\
> > +		 (.L__gpr_num_\rs1 << INSN_S_RS1_SHIFT) |	\
> > +		 ((\simm12 & 0x1f) << INSN_S_SIMM5_SHIFT) |	\
> > +		 (((\simm12 >> 5) & 0x7f) << INSN_S_SIMM7_SHIFT))
> > +	.endm
> > +
> >  #endif
> >  
> >  #define __INSN_R(...)	insn_r __VA_ARGS__
> >  #define __INSN_I(...)	insn_i __VA_ARGS__
> > +#define __INSN_S(...)	insn_s __VA_ARGS__
> >  
> >  #else /* ! __ASSEMBLY__ */
> >  
> > @@ -66,6 +87,9 @@
> >  #define __INSN_I(opcode, func3, rd, rs1, simm12)	\
> >  	".insn	i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n"
> >  
> > +#define __INSN_S(opcode, func3, rs2, simm12, rs1)	\
> > +	".insn	s " opcode ", " func3 ", " rs2 ", " simm12 "(" rs1 ")\n"
> > +
> >  #else
> >  
> >  #include <linux/stringify.h>
> > @@ -92,12 +116,26 @@
> >  "		 (\\simm12 << " __stringify(INSN_I_SIMM12_SHIFT) "))\n"	\
> >  "	.endm\n"
> >  
> > +#define DEFINE_INSN_S							\
> > +	__DEFINE_ASM_GPR_NUMS						\
> > +"	.macro insn_s, opcode, func3, rs2, simm12, rs1\n"		\
> > +"	.4byte	((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"	\
> > +"		 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"	\
> > +"		 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> > +"		 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> > +"		 ((\\simm12 & 0x1f) << " __stringify(INSN_S_SIMM5_SHIFT) ") |" \
> > +"		 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> > +"	.endm\n"
> > +
> >  #define UNDEFINE_INSN_R							\
> >  "	.purgem insn_r\n"
> >  
> >  #define UNDEFINE_INSN_I							\
> >  "	.purgem insn_i\n"
> >  
> > +#define UNDEFINE_INSN_S							\
> > +"	.purgem insn_s\n"
> > +
> >  #define __INSN_R(opcode, func3, func7, rd, rs1, rs2)			\
> >  	DEFINE_INSN_R							\
> >  	"insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n" \
> > @@ -108,6 +146,11 @@
> >  	"insn_i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n" \
> >  	UNDEFINE_INSN_I
> >  
> > +#define __INSN_S(opcode, func3, rs2, simm12, rs1)			\
> > +	DEFINE_INSN_S							\
> > +	"insn_s " opcode ", " func3 ", " rs2 ", " simm12 ", " rs1 "\n"	\
> > +	UNDEFINE_INSN_S
> > +
> >  #endif
> >  
> >  #endif /* ! __ASSEMBLY__ */
> > @@ -120,6 +163,10 @@
> >  	__INSN_I(RV_##opcode, RV_##func3, RV_##rd,		\
> >  		 RV_##rs1, RV_##simm12)
> >  
> > +#define INSN_S(opcode, func3, rs2, simm12, rs1)			\
> > +	__INSN_S(RV_##opcode, RV_##func3, RV_##rs2,		\
> > +		 RV_##simm12, RV_##rs1)
> > +
> >  #define RV_OPCODE(v)		__ASM_STR(v)
> >  #define RV_FUNC3(v)		__ASM_STR(v)
> >  #define RV_FUNC7(v)		__ASM_STR(v)
> > @@ -133,6 +180,7 @@
> >  #define RV___RS2(v)		__RV_REG(v)
> >  
> >  #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> > +#define RV_OPCODE_OP_IMM	RV_OPCODE(19)
> >  #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
> >  
> >  #define HFENCE_VVMA(vaddr, asid)				\
> > @@ -196,4 +244,16 @@
> >  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> >  	       RS1(base), SIMM12(4))
> >  
> > +#define CBO_PREFETCH_I(base, offset)				\
> > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),		\
> > +	       SIMM12(offset), RS1(base))
> > +
> > +#define CBO_PREFETCH_R(base, offset)				\
> > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),		\
> > +	       SIMM12(offset), RS1(base))
> > +
> > +#define CBO_PREFETCH_W(base, offset)				\
> > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),		\
> > +	       SIMM12(offset), RS1(base))
> 
> Shouldn't we ensure the lower 5-bits of offset are zero by masking it?

Note for my future self, read other reviews before doing my own :)


> 
> > +
> >  #endif /* __ASM_INSN_DEF_H */
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index b3785ffc1570..bdb02b066041 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -168,6 +168,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> >  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> >  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> >  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> > +	__RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),
> 
> zicbop should be above zicboz (alphabetical)
> 
> >  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> >  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
> >  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> > -- 
> > 2.40.1
> >
> 
> Thanks,
> drew
> 


