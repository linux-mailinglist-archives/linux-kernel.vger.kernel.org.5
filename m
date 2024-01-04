Return-Path: <linux-kernel+bounces-16955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E163E82467A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76361C22452
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D928DD5;
	Thu,  4 Jan 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Zo7O8VJm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09B28DCC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd20d9d483so8526381fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704386452; x=1704991252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2FqLd+7fSNFOVRetfmjHxaVxLnzYZGauh/919f31n4=;
        b=Zo7O8VJm4Z08SIWTKbLLzcsUYfH8K8Bglx/hngJK3BN9nZ8Icwla02wqJDAEELFgCs
         WJiZPTjhD9D1xCVaA3DVcZZxEdvVK3A4yGGFalcadaXSAFYtoJLdxsuawKsV9NHrffru
         v2jIEn1sIODYgfSLlF+kS+WYUpwWIagTpwE9in5md+WZRnFdC1aIAh5PCGFpjWawXXTi
         TakQy3iaziv1JP7oL4b49QvaT0KhSLqZXxRHxr8uej2G+FgWhvdaTbcjo1xDRWFcZU0x
         1mv2N1ZkLowAf+HUsxBt3yGW4duCHCiir951NZHwZxX6dGUU9D/JYnJ7/KATq2M1TAT+
         31zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386452; x=1704991252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2FqLd+7fSNFOVRetfmjHxaVxLnzYZGauh/919f31n4=;
        b=Z6+DFrOSHRS9DR74vOY7PWIQHPUX8VKh5OCMQgqrwP0S1xa4KvopLDEIkriijWvHey
         69qqctgpsDWASu6Voquzv2JMce9giNvef8cO3eqE5s6PYZVKrLmFd4OUl/T9oP80+R8z
         oaLC1xnebMomTH3eGuPVTaZU2tHC5hOCiLjofPnvZTiaIrL9pYjvO0X/iNPkhDHmHxiq
         3QKc1uhgDtHkOLx0FXTN4gvYjsVL7MqHkzt9Vj7sIdrncsgPF6gTm4POOY2tOgsnLvg0
         xhf57nXc88HFxjDTCGO7wLmZ/2s+SdCWWLZ6B8oH/1iQjEjYd/OSXJoStzBz5apZ5hoB
         y7QQ==
X-Gm-Message-State: AOJu0Yxh+6tcbh0Y7ioCjliXcieM4AcWhR6d7vo23b0hlnw+VthGIus8
	LdzwbrZKGNiz1eL+2hpy9FcDg08z5EzWjA==
X-Google-Smtp-Source: AGHT+IGFO2UvTUj/ZscmTQoKmtFIQwFPXy9Y4BV7rHK7k8Pt7EyqdVTqewSUkncC86IP3RAOZJP0Rw==
X-Received: by 2002:ac2:5bdb:0:b0:50e:7a2d:6cd7 with SMTP id u27-20020ac25bdb000000b0050e7a2d6cd7mr473965lfn.55.1704386451954;
        Thu, 04 Jan 2024 08:40:51 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ez9-20020a056402450900b0055504002a5fsm13025509edb.72.2024.01.04.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:40:51 -0800 (PST)
Date: Thu, 4 Jan 2024 17:40:50 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn, 
	xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, uwu@icenowy.me, 
	jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: Re: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction
 definitions & cpufeature
Message-ID: <20240104-d6981cf63a39af4dff1d380a@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
 <ZZWs0C19tz763FnH@LeoBras>
 <20240103-0c96ceea88523b7b946e4ba8@orel>
 <ZZXEpU-JzsvD2UDW@LeoBras>
 <20240104-4ecfb92d2f8c95fa773ca695@orel>
 <ZZbI3clKUbNbNtZj@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZbI3clKUbNbNtZj@LeoBras>

On Thu, Jan 04, 2024 at 12:03:57PM -0300, Leonardo Bras wrote:
...
> > > > > What we need here is something like:
> > > > > + enum {
> > > > > + 	PREFETCH_I,
> > > > > + 	PREFETCH_R,
> > > > > + 	PREFETCH_W,
> > > > > + }	 
> > > > 
> > > > Can't use enum. This header may be included in assembly.
> > > 
> > > Oh, I suggest defines then, since it's better to make it clear instead of 
> > > using 0, 1, 3.
> > 
> > I don't think we gain anything by adding another define in order to create
> > the instruction define. We have to review the number sooner or later. I'd
> > prefer we use the number inside the instruction define so we only need
> > to look one place, which is also consistent with how we use FUNC fields.
> > 
> 
> Sorry, I was unable to understand the reasoning.
> 
> If we are going to review the numbers sooner or later, would not it be 
> better to have the instruction define to have "PREFETCH_W" instead of a 
> number, and a unified list of defines for instructions.
> 
> This way we don't need to look into the code for 0's 1's and 3's, but 
> instead just replace the number in the define list.
> 
> What am I missing?  

PREFETCH_W isn't defined as just 3, it's defined as
   INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3), ...)

Adding a define (PREFETCH_W_RS2?) for the 3 just bloats the code and
requires reviewers of PREFETCH_W to go look up another define.
OPCODE_OP_IMM gets a define because it's used in multiple instructions,
but everything else in an instruction definition should be a number
exactly matching the spec, making it easy to review, or be an argument
passed into the instruction macro.

> 
> > > 
> > > > 
> > > > > +
> > > > > + #define CBO_PREFETCH(type, base, offset)                      \
> > > > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(type),              \
> > > > > +            SIMM12(offset & ~0x1f), RS1(base))
> > > > 
> > > > Yes. I suggested we mask offset as well, but ideally we'd detect a caller
> > > > using an offset with nonzero lower 5 bits at compile time.
> > > 
> > > I would suggest the compiler would take care of this, but I am not sure 
> > > about the assembly, since I am not sure if it gets any optimization.
> > > 
> > > I don't think we can detect a caller with non-zero offset at compile time, 
> > > since it will be used in locks which can be at (potentially) any place in 
> > > the block size. (if you have any idea though, please let me know :) )

I forgot to reply to this before. The reason I think it may be possible to
validate offset at compile time is because it must be a constant, i.e.
__builtin_constant_p(offset) must return true. So maybe something like

 static_assert(__builtin_constant_p(offset) && !(offset & 0x1f))

I'll try to find time to play with it.

> > > 
> > > On the other hand, we could create a S-Type macro which deliberately 
> > > ignores imm[4:0], like  
> > > 
> > > + INSN_S_TRUNCATE(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > > +                 SIMM12(offset), RS1(base))
> > > 
> > > Which saves the bits 11:5 of offset  into imm[11:5], and zero-fill 
> > > imm[4:0], like
> > > 
> > > +#define DEFINE_INSN_S                                                    \
> > > + __DEFINE_ASM_GPR_NUMS                                           \
> > > +"        .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> > > +"        .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> > > +"                 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> > > +"                 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> > > +"                 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> > > +"                 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> > > +"        .endm\n"
> > > +
> > > 
> > > Does this make sense?
> > 
> > If we create a special version of INSN_S, then I suggest we create one
> > where its two SIMM fields are independent and then define prefetch
> > instructions like this
> > 
> >  #define PREFETCH_W(base, offset) \
> >      INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
> >          SIMM_11_5(offset >> 5), SIMM_4_0(0), RS1(base))
> > 
> > which would allow simple review against the spec and potentially
> > support other instructions which use hard coded values in the
> > immediate fields.
> > 
> 
> I agree, it looks better this way.
> 
> We could have:
> INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2, SIMM_11_5, SIMM_4_0)
> 
> and implement INSN_S like:
> #define INSN_S(OPCODE, FUNC3, RS1, RS2, SIMM_11_0) \
> 	INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2,  \
> 		SIMM_11_0 >> 5, SIMM_11_0 & 0x1f)

That won't work since SIMM_11_0 will be a string. Actually, with
stringification in mind, I don't think defining INSN_S_SPLIT_IMM()
is a good idea.

Thanks,
drew

