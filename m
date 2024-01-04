Return-Path: <linux-kernel+bounces-16831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE366824497
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7920F1F21FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B9241F8;
	Thu,  4 Jan 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAo6hyHF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646DD241EA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704380653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54czl3D5X40O/vQlC+9Ni2dHi6OnEwWDJH786ySVlbE=;
	b=gAo6hyHFFctAMVrDq+YJE0SG8sD58e85kLJU9GJOXp23Vo2n3pxnMv0lmuc1i/GPpIuK0w
	tNUuOOGLuWQVNlxa6n1DnOBcC9bjSWsDhfQkp0fKGoPzCmphLWyqohWM/WHNgNUK/8C6Vz
	h67YQFv1/jb7rM3k4f4MZ1uWjTkn3SI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-tcV1uLR5NeKtV18hJpqOLg-1; Thu, 04 Jan 2024 10:04:11 -0500
X-MC-Unique: tcV1uLR5NeKtV18hJpqOLg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cec8bc5c66so411734a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380650; x=1704985450;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54czl3D5X40O/vQlC+9Ni2dHi6OnEwWDJH786ySVlbE=;
        b=G1udqKVmGHkdW3upqtRpsbelzdhytDUJ4fUfugamK1DzD0hD6yOoNIBiO2+HdVwTZL
         X1TihZ70RKWA7U7861uXFas/QLQr39QPRjgym49dMyvl9AhDZYUSSL25VClkcMLeEd9g
         QiDFsXfQpm3TNFV2/S2dRlWaCzBNmKQnqcAgRdNGCtA3DG7xChrPYMu8YQQE/e952vgN
         YCFa/r9llVBxSW2GrhhcrFevCztLvuhRU2NmAa/XGDxEQdnMOWi8ocIyN6ImWVuxSkHP
         6HRCJSGCXZmcWD3JC34JhfI/1yBXAo0+VXiBHb0U+dQJjj1ar9gMsxKDHKZ6BKFHX752
         TCpQ==
X-Gm-Message-State: AOJu0Yy7UtMpwz6u49dwDWnMfYk7Z8DIAQIGQ84TtscUX2zK0a2r8HLh
	IvTRIw2OACPT59hX/5k/f7dACVyyeW7FM0pARmwO7B76xhhmyNqltvvjwj3UW+mcd/Z/DeiHuC0
	m7FqOVqqsb60DBinveQy2vGu8/04bEgpY
X-Received: by 2002:a17:902:7ec8:b0:1d4:df66:42fa with SMTP id p8-20020a1709027ec800b001d4df6642famr484767plb.65.1704380650530;
        Thu, 04 Jan 2024 07:04:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBUSGQH4kHn/+tNl9EDAVAQc3MloODmEGyIqw0UaTuZn9ttpODkJIeEzjf6zBFcG/+1lIqkQ==
X-Received: by 2002:a17:902:7ec8:b0:1d4:df66:42fa with SMTP id p8-20020a1709027ec800b001d4df6642famr484738plb.65.1704380650191;
        Thu, 04 Jan 2024 07:04:10 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:3b60:7b8a:588b:5256:ce57])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b001d49e742d51sm11304580plc.30.2024.01.04.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:04:09 -0800 (PST)
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
Subject: Re: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions & cpufeature
Date: Thu,  4 Jan 2024 12:03:57 -0300
Message-ID: <ZZbI3clKUbNbNtZj@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104-4ecfb92d2f8c95fa773ca695@orel>
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-2-guoren@kernel.org> <ZZWs0C19tz763FnH@LeoBras> <20240103-0c96ceea88523b7b946e4ba8@orel> <ZZXEpU-JzsvD2UDW@LeoBras> <20240104-4ecfb92d2f8c95fa773ca695@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 04, 2024 at 10:47:34AM +0100, Andrew Jones wrote:
> On Wed, Jan 03, 2024 at 05:33:41PM -0300, Leonardo Bras wrote:
> > On Wed, Jan 03, 2024 at 08:29:39PM +0100, Andrew Jones wrote:
> > > On Wed, Jan 03, 2024 at 03:52:00PM -0300, Leonardo Bras wrote:
> > > > On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
> ...
> > > > The shifts seem correct for S-Type, but I would name the IMM defines in a 
> > > > way we could understand where they fit in IMM:
> > > > 
> > > > 
> > > > INSN_S_SIMM5_SHIFT -> INSN_S_SIMM_0_4_SHIFT
> > > > INSN_S_SIMM7_SHIFT -> INSN_S_SIMM_5_11_SHIFT
> > > > 
> > > > What do you think?
> > > 
> > > I'm in favor of this suggestion, but then wonder if we don't need another
> > > patch before this which renames INSN_I_SIMM12_SHIFT to
> > > INSN_I_SIMM_0_11_SHIFT in order to keep things consistent.
> > 
> > Agree. If it's ok, I can provide a patch doing the rename on top of this 
> > patchset.
> 
> The INSN_I change is only needed if we also take the new INSN_S shift
> macros, so I think the INSN_I change should be part of this series.

Ok then,

> 
> BTW, I just noticed we wrote the numbers backwards. They should be
> 
>  INSN_I_SIMM_11_0_SHIFT
>  INSN_S_SIMM_11_5_SHIFT
>  INSN_S_SIMM_4_0_SHIFT
>

That's right, so it matches ISA documentation :)

 
> > > > >  
> > > > > +#define CBO_PREFETCH_I(base, offset)				\
> > > > > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),		\
> > > > > +	       SIMM12(offset), RS1(base))
> > > > > +
> > > > > +#define CBO_PREFETCH_R(base, offset)				\
> > > > > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),		\
> > > > > +	       SIMM12(offset), RS1(base))
> > > > > +
> > > > > +#define CBO_PREFETCH_W(base, offset)				\
> > > > > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),		\
> > > > > +	       SIMM12(offset), RS1(base))
> > > > > +
> > > > 
> > > > For OP_IMM & FUNC3(6) we have ORI, right?
> > > > For ORI, rd will be at bytes 11:7, which in PREFETCH.{i,r,w} is
> > > > offset[4:0].
> > > > 
> > > > IIUC, when the cpu does not support ZICBOP, this should be fine as long as 
> > > > rd = 0, since changes to r0 are disregarded.
> > > > 
> > > > In this case, we need to guarantee offset[4:0] = 0, or else we migth write 
> > > > on an unrelated register. This can be noticed in ZICBOP documentation pages 
> > > > 21, 22, 23, as offset[4:0] is always [0 0 0 0 0]. 
> > > > (Google docs in first comment)
> > > > 
> > > > What we need here is something like:
> > > > + enum {
> > > > + 	PREFETCH_I,
> > > > + 	PREFETCH_R,
> > > > + 	PREFETCH_W,
> > > > + }	 
> > > 
> > > Can't use enum. This header may be included in assembly.
> > 
> > Oh, I suggest defines then, since it's better to make it clear instead of 
> > using 0, 1, 3.
> 
> I don't think we gain anything by adding another define in order to create
> the instruction define. We have to review the number sooner or later. I'd
> prefer we use the number inside the instruction define so we only need
> to look one place, which is also consistent with how we use FUNC fields.
> 

Sorry, I was unable to understand the reasoning.

If we are going to review the numbers sooner or later, would not it be 
better to have the instruction define to have "PREFETCH_W" instead of a 
number, and a unified list of defines for instructions.

This way we don't need to look into the code for 0's 1's and 3's, but 
instead just replace the number in the define list.

What am I missing?  

> > 
> > > 
> > > > +
> > > > + #define CBO_PREFETCH(type, base, offset)                      \
> > > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(type),              \
> > > > +            SIMM12(offset & ~0x1f), RS1(base))
> > > 
> > > Yes. I suggested we mask offset as well, but ideally we'd detect a caller
> > > using an offset with nonzero lower 5 bits at compile time.
> > 
> > I would suggest the compiler would take care of this, but I am not sure 
> > about the assembly, since I am not sure if it gets any optimization.
> > 
> > I don't think we can detect a caller with non-zero offset at compile time, 
> > since it will be used in locks which can be at (potentially) any place in 
> > the block size. (if you have any idea though, please let me know :) )
> > 
> > On the other hand, we could create a S-Type macro which deliberately 
> > ignores imm[4:0], like  
> > 
> > + INSN_S_TRUNCATE(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > +                 SIMM12(offset), RS1(base))
> > 
> > Which saves the bits 11:5 of offset  into imm[11:5], and zero-fill 
> > imm[4:0], like
> > 
> > +#define DEFINE_INSN_S                                                    \
> > + __DEFINE_ASM_GPR_NUMS                                           \
> > +"        .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> > +"        .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> > +"                 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> > +"                 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> > +"                 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> > +"                 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> > +"        .endm\n"
> > +
> > 
> > Does this make sense?
> 
> If we create a special version of INSN_S, then I suggest we create one
> where its two SIMM fields are independent and then define prefetch
> instructions like this
> 
>  #define PREFETCH_W(base, offset) \
>      INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
>          SIMM_11_5(offset >> 5), SIMM_4_0(0), RS1(base))
> 
> which would allow simple review against the spec and potentially
> support other instructions which use hard coded values in the
> immediate fields.
> 

I agree, it looks better this way.

We could have:
INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2, SIMM_11_5, SIMM_4_0)

and implement INSN_S like:
#define INSN_S(OPCODE, FUNC3, RS1, RS2, SIMM_11_0) \
	INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2,  \
		SIMM_11_0 >> 5, SIMM_11_0 & 0x1f)

This would avoid extra instructions in asm while not having duplicated 
code.


> But I'm not sure it's worth it. I think
> 
>  #define PREFETCH_W(base, offset) \
>      INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
>          SIMM12(offset & ~0x1f), RS1(base))
> 
> is also pretty easy to review against the spec and we don't have any other
> instructions yet with other requirements for the immediates.
> 

It makes sense, but I think having INSN_S being implemented with 
INSN_S_SPLIT_IMM like suggested above would allow us to have the 
benefits of a split version without the code duplication.

> Thanks,
> drew
> 

Thanks!
Leo


