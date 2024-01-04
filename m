Return-Path: <linux-kernel+bounces-17052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6189D8247A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4ABB2202E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCC28DAD;
	Thu,  4 Jan 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6KN+m9G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909628DA4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704390199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuNvixvj7I1gCW2L3EcndNwefy5FlO7a/IFG5Uu5x20=;
	b=J6KN+m9GdgkWYTkDS0ybJnOQIVBT+Rkvb97dJKiQnQJ4XE8pPCnPE6PcfTGKs+qRYROyUy
	7SQUqosuZecVtoCQvlUHTj7VoOoaub/W8Cp2k68xnEBsDx42JY6F+9EIXOBZjKfbqB3p4V
	ekeg4E3EXuJxq2Cy+6hw+uw/LId48zY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-Ir-n3T7xNMiT7Faf7MfaEg-1; Thu, 04 Jan 2024 12:43:17 -0500
X-MC-Unique: Ir-n3T7xNMiT7Faf7MfaEg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9b2360ed7so808088b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 09:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704390197; x=1704994997;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuNvixvj7I1gCW2L3EcndNwefy5FlO7a/IFG5Uu5x20=;
        b=T9O+66VIxoaFgmG7+oPltw38IpaJkok+zgk0/4+i10fmqb4TZtZ2yBwhuj2CeE5s2z
         Pv4oye+gfbYtfFqRx+N+S2AyH/huR2SCyN+ZUJsL/8C8Rzu1oqz4VTIBPlY0vbWiP77D
         GW+ZrnTpovSTCb6ghYjxZ/9KFb4GOlI8caPASmYv+/mi96x8alnBBNVin6NJ5EUzpuz9
         eOrltGO0ojzQOOEgsYHNLmSKZ1TSeAs2hPotx7fNRC2Lxyz744rXJ43lZ1fIrmS/dW9D
         SGf607EtlWzZKKT66I36lFepiibbevpy9cyyUww4YdSAXf4XUUqgBUuNUK8HzP7P+CIm
         ni1w==
X-Gm-Message-State: AOJu0YwguJXCuLG+SLCaPY077Vh8F0aoGSh4nrEovvUVt8C4nldIP9iS
	fWFaSG9zF4hRQG3GyltKGOldjRh0bPLuG6qCHDtjNSqrzv1kTyrhspavi1FSQyQlK/nsxGsmqJc
	uIrkG+fIGdMSvekS8tPDjDS5YwLCpauxJ
X-Received: by 2002:a62:5346:0:b0:6d9:b66f:3d16 with SMTP id h67-20020a625346000000b006d9b66f3d16mr1158920pfb.50.1704390196828;
        Thu, 04 Jan 2024 09:43:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExGwukcRooOCfEMKqSkNigh0IbyweP45i/89S1/IF+npn5FOcVr9q1nCUpn3nOrCZCCxpcug==
X-Received: by 2002:a62:5346:0:b0:6d9:b66f:3d16 with SMTP id h67-20020a625346000000b006d9b66f3d16mr1158903pfb.50.1704390196500;
        Thu, 04 Jan 2024 09:43:16 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:3c39:8a36:75f0:8b6e:b898])
        by smtp.gmail.com with ESMTPSA id u5-20020a056a00098500b006d9bf35dd1fsm18498772pfg.142.2024.01.04.09.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:43:15 -0800 (PST)
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
Subject: Re: Re: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions & cpufeature
Date: Thu,  4 Jan 2024 14:43:04 -0300
Message-ID: <ZZbuKCvATa7yyQOc@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104-d6981cf63a39af4dff1d380a@orel>
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-2-guoren@kernel.org> <ZZWs0C19tz763FnH@LeoBras> <20240103-0c96ceea88523b7b946e4ba8@orel> <ZZXEpU-JzsvD2UDW@LeoBras> <20240104-4ecfb92d2f8c95fa773ca695@orel> <ZZbI3clKUbNbNtZj@LeoBras> <20240104-d6981cf63a39af4dff1d380a@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jan 04, 2024 at 05:40:50PM +0100, Andrew Jones wrote:
> On Thu, Jan 04, 2024 at 12:03:57PM -0300, Leonardo Bras wrote:
> ...
> > > > > > What we need here is something like:
> > > > > > + enum {
> > > > > > + 	PREFETCH_I,
> > > > > > + 	PREFETCH_R,
> > > > > > + 	PREFETCH_W,
> > > > > > + }	 
> > > > > 
> > > > > Can't use enum. This header may be included in assembly.
> > > > 
> > > > Oh, I suggest defines then, since it's better to make it clear instead of 
> > > > using 0, 1, 3.
> > > 
> > > I don't think we gain anything by adding another define in order to create
> > > the instruction define. We have to review the number sooner or later. I'd
> > > prefer we use the number inside the instruction define so we only need
> > > to look one place, which is also consistent with how we use FUNC fields.
> > > 
> > 
> > Sorry, I was unable to understand the reasoning.
> > 
> > If we are going to review the numbers sooner or later, would not it be 
> > better to have the instruction define to have "PREFETCH_W" instead of a 
> > number, and a unified list of defines for instructions.
> > 
> > This way we don't need to look into the code for 0's 1's and 3's, but 
> > instead just replace the number in the define list.
> > 
> > What am I missing?  
> 
> PREFETCH_W isn't defined as just 3, it's defined as
>    INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3), ...)
> 
> Adding a define (PREFETCH_W_RS2?) for the 3 just bloats the code and
> requires reviewers of PREFETCH_W to go look up another define.
> OPCODE_OP_IMM gets a define because it's used in multiple instructions,
> but everything else in an instruction definition should be a number
> exactly matching the spec, making it easy to review, or be an argument
> passed into the instruction macro.

Ok, I see your point now.
It's fine by me, then.


> 
> > 
> > > > 
> > > > > 
> > > > > > +
> > > > > > + #define CBO_PREFETCH(type, base, offset)                      \
> > > > > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(type),              \
> > > > > > +            SIMM12(offset & ~0x1f), RS1(base))
> > > > > 
> > > > > Yes. I suggested we mask offset as well, but ideally we'd detect a caller
> > > > > using an offset with nonzero lower 5 bits at compile time.
> > > > 
> > > > I would suggest the compiler would take care of this, but I am not sure 
> > > > about the assembly, since I am not sure if it gets any optimization.
> > > > 
> > > > I don't think we can detect a caller with non-zero offset at compile time, 
> > > > since it will be used in locks which can be at (potentially) any place in 
> > > > the block size. (if you have any idea though, please let me know :) )
> 
> I forgot to reply to this before. The reason I think it may be possible to
> validate offset at compile time is because it must be a constant, i.e.
> __builtin_constant_p(offset) must return true. So maybe something like
> 
>  static_assert(__builtin_constant_p(offset) && !(offset & 0x1f))
> 
> I'll try to find time to play with it.
> 

Let me know if you find anything.

> > > > 
> > > > On the other hand, we could create a S-Type macro which deliberately 
> > > > ignores imm[4:0], like  
> > > > 
> > > > + INSN_S_TRUNCATE(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > > > +                 SIMM12(offset), RS1(base))
> > > > 
> > > > Which saves the bits 11:5 of offset  into imm[11:5], and zero-fill 
> > > > imm[4:0], like
> > > > 
> > > > +#define DEFINE_INSN_S                                                    \
> > > > + __DEFINE_ASM_GPR_NUMS                                           \
> > > > +"        .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> > > > +"        .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> > > > +"                 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> > > > +"                 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> > > > +"                 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> > > > +"                 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> > > > +"        .endm\n"
> > > > +
> > > > 
> > > > Does this make sense?
> > > 
> > > If we create a special version of INSN_S, then I suggest we create one
> > > where its two SIMM fields are independent and then define prefetch
> > > instructions like this
> > > 
> > >  #define PREFETCH_W(base, offset) \
> > >      INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
> > >          SIMM_11_5(offset >> 5), SIMM_4_0(0), RS1(base))
> > > 
> > > which would allow simple review against the spec and potentially
> > > support other instructions which use hard coded values in the
> > > immediate fields.
> > > 
> > 
> > I agree, it looks better this way.
> > 
> > We could have:
> > INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2, SIMM_11_5, SIMM_4_0)
> > 
> > and implement INSN_S like:
> > #define INSN_S(OPCODE, FUNC3, RS1, RS2, SIMM_11_0) \
> > 	INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2,  \
> > 		SIMM_11_0 >> 5, SIMM_11_0 & 0x1f)
> 
> That won't work since SIMM_11_0 will be a string. Actually, with
> stringification in mind, I don't think defining INSN_S_SPLIT_IMM()
> is a good idea.

I don't see how SIMM_11_0 will be a string here. Is this due to using it 
on asm code?

I understand a user will call 
---
PREFETCH_W(base, offset), which becomes:

INSN_S(OPCODE_OP_IMM, 6, base, 3, offset) , which becomes:

INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), RS1(base), RS2(3), \
	SIMM_11_5(offset >> 5), SIMM_4_0(offset & 0x1f))
---

I don't see an issue here, the same wouldwork for every INSN_S() 

Now suppose we make PREFETCH_W use SPLIT_IMM directly:
---
PREFETCH_W(base, offset), which becomes:

INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), RS1(base), RS2(3), \
	 SIMM_11_5(offset >> 5), SIMM_4_0(0))
---

I don't see how stringification gets in the way.

Thanks!
Leo




 #define CBO_PREFETCH(type, base, offset)                      \
> > > > > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(type),              \
> > > > > > +            SIMM12(offset & ~0x1f), RS1(base))



> 
> Thanks,
> drew
> 


