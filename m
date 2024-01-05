Return-Path: <linux-kernel+bounces-17873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48D825469
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBAB1F21BF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228362D632;
	Fri,  5 Jan 2024 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EStafhKz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFA2D61B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28e31563ebso177345966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704461087; x=1705065887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWrxWM20Sc/0fg8zOr8GrEJNxiypntEhdE5ySeFTgNc=;
        b=EStafhKzHhiWpLrhiM+3aPLG03nu5pp5psTMz7kSB+LtbpfFz74gvrVMPajAGRgUJU
         ZMjRg6YoJvQVTiG8hy4u8pf1lCEDI7duSaRw8Xoi7kXqS4nKJbX4oEhYszBeoXoIpOiG
         eFSX6QdKsDakCc8WE7Ik+PZja1tAqJUWrBO0JNiodODsZeXy5lP1nZ8Fn3kmDpWAdwfG
         KgvPqNgWsznhI6N8Zva3WK0hQkl698hiNQ4xVGSwXEm4bHvHGzAy4WlrM0vwYVuaYnkH
         qbQ6JgsCFE96MPJvUUHtAEBcuYbRL4FqYeeeHAEcFBDhYerOAT+7e2ZC+9DFig9VecGt
         BDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461087; x=1705065887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWrxWM20Sc/0fg8zOr8GrEJNxiypntEhdE5ySeFTgNc=;
        b=J5iB31KaFsi/l7OtHt0ItLkdyGEO2ooyxPfuMOgwuKnuMf7aIEalWu+vT1pKpnK+tg
         vBIXUqARcfCSVC/jIJoyjZP5DrQq1SNPRcU6AxydgIszdFHNu6q2jnKmpcXVKGLz8MH6
         5wjYyaATqTz53k1yANE0HNoDYDmwCknCY3dDWMp6LorUtryGFdzO3+IEkfKwr+iJXqXP
         ZO3tPHsCDIguEkmEv3y5w29w4/v7kti6Iftec+va23Uq4ia+/pN0tLKF8dxowtAkHiyh
         bRhErsjz3IeWDL4bd24o2Nj7BGLA7hjCvl5TNxofhUguhYug5sVQ7P+kQ5iNS9NwXq19
         eKTg==
X-Gm-Message-State: AOJu0YwvzeRbumsYgvlWP/yMxYY0isOo+Cty1qbTA9RFIsIp9/9cQzKE
	ZpRvAm5IGRdoYFlINJOO9vbSK5kaN0L6Pw==
X-Google-Smtp-Source: AGHT+IE4KzVZAe1lCDbe9dWTEOivaccz0byV8T1YuB4aioJo6qHOOt4mWa3WyJ9xY8x4iUl3yRwkcw==
X-Received: by 2002:a17:907:940f:b0:a26:cee8:3713 with SMTP id dk15-20020a170907940f00b00a26cee83713mr1417765ejc.55.1704461086710;
        Fri, 05 Jan 2024 05:24:46 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id r22-20020a1709062cd600b00a26f5e9506fsm879710ejr.109.2024.01.05.05.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:24:46 -0800 (PST)
Date: Fri, 5 Jan 2024 14:24:45 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn, 
	xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, uwu@icenowy.me, 
	jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: Re: Re: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction
 definitions & cpufeature
Message-ID: <20240105-faa40f2c20534ea498246cc3@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
 <ZZWs0C19tz763FnH@LeoBras>
 <20240103-0c96ceea88523b7b946e4ba8@orel>
 <ZZXEpU-JzsvD2UDW@LeoBras>
 <20240104-4ecfb92d2f8c95fa773ca695@orel>
 <ZZbI3clKUbNbNtZj@LeoBras>
 <20240104-d6981cf63a39af4dff1d380a@orel>
 <ZZbuKCvATa7yyQOc@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZbuKCvATa7yyQOc@LeoBras>

On Thu, Jan 04, 2024 at 02:43:04PM -0300, Leonardo Bras wrote:
...
> > > > > I don't think we can detect a caller with non-zero offset at compile time, 
> > > > > since it will be used in locks which can be at (potentially) any place in 
> > > > > the block size. (if you have any idea though, please let me know :) )
> > 
> > I forgot to reply to this before. The reason I think it may be possible to
> > validate offset at compile time is because it must be a constant, i.e.
> > __builtin_constant_p(offset) must return true. So maybe something like
> > 
> >  static_assert(__builtin_constant_p(offset) && !(offset & 0x1f))
> > 
> > I'll try to find time to play with it.
> > 
> 
> Let me know if you find anything.

There's nothing we can do in this file (insn-def.h), other than maybe
masking, since all magic must happen at preprocessor time, other than
a tiny bit of constant arithmetic allowed at assembly time. For C, using
a wrapper, like patch 2 of this series introduces, we could add the
static assert above. I'll suggest that in patch 2, since I've already
thought it through, but it sort of feels like overkill to me.

> 
> > > > > 
> > > > > On the other hand, we could create a S-Type macro which deliberately 
> > > > > ignores imm[4:0], like  
> > > > > 
> > > > > + INSN_S_TRUNCATE(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > > > > +                 SIMM12(offset), RS1(base))
> > > > > 
> > > > > Which saves the bits 11:5 of offset  into imm[11:5], and zero-fill 
> > > > > imm[4:0], like
> > > > > 
> > > > > +#define DEFINE_INSN_S                                                    \
> > > > > + __DEFINE_ASM_GPR_NUMS                                           \
> > > > > +"        .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> > > > > +"        .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> > > > > +"                 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> > > > > +"                 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> > > > > +"                 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> > > > > +"                 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> > > > > +"        .endm\n"
> > > > > +
> > > > > 
> > > > > Does this make sense?
> > > > 
> > > > If we create a special version of INSN_S, then I suggest we create one
> > > > where its two SIMM fields are independent and then define prefetch
> > > > instructions like this
> > > > 
> > > >  #define PREFETCH_W(base, offset) \
> > > >      INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
> > > >          SIMM_11_5(offset >> 5), SIMM_4_0(0), RS1(base))
> > > > 
> > > > which would allow simple review against the spec and potentially
> > > > support other instructions which use hard coded values in the
> > > > immediate fields.
> > > > 
> > > 
> > > I agree, it looks better this way.
> > > 
> > > We could have:
> > > INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2, SIMM_11_5, SIMM_4_0)
> > > 
> > > and implement INSN_S like:
> > > #define INSN_S(OPCODE, FUNC3, RS1, RS2, SIMM_11_0) \
> > > 	INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2,  \
> > > 		SIMM_11_0 >> 5, SIMM_11_0 & 0x1f)
> > 
> > That won't work since SIMM_11_0 will be a string. Actually, with
> > stringification in mind, I don't think defining INSN_S_SPLIT_IMM()
> > is a good idea.
> 
> I don't see how SIMM_11_0 will be a string here. Is this due to using it 
> on asm code?
> 
> I understand a user will call 
> ---
> PREFETCH_W(base, offset), which becomes:
> 
> INSN_S(OPCODE_OP_IMM, 6, base, 3, offset) , which becomes:
> 
> INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), RS1(base), RS2(3), \
> 	SIMM_11_5(offset >> 5), SIMM_4_0(offset & 0x1f))

The other annotations, like SIMM12, stringify their arguments. So, if
SIMM_11_5 and SIMM_4_0 also stringified, then it wouldn't be possible
to recombine them into a simm12 for the '.insn s' directive. I suppose
SIMM_11_5 and SIMM_4_0 could just expand their arguments without
stringifying. With that, along with throwing even more ugly at it, then
it is possible to get the end result we want, which is

 - PREFETCH_* instructions are defined with annotations and have a
   SIMM_4_0(0) in their definitions to explicitly point out that field

 - the INSN_S definition still directly maps to the .insn s directive


I got that to work with this

#define __RV_SIMM(v)           v
#define RV___SIMM_11_5(v)      __RV_SIMM(v)
#define RV___SIMM_4_0(v)       __RV_SIMM(v)

#define __INSN_S_SPLIT_IMM(opcode, func3, rs2, simm12, rs1) \
        INSN_S(opcode, func3, rs2, SIMM12(simm12), rs1)

#define INSN_S_SPLIT_IMM(opcode, func3, rs2, simm_11_5, simm_4_0, rs1) \
        __INSN_S_SPLIT_IMM(opcode, func3, rs2, (RV_##simm_11_5 << 5) | RV_##simm_4_0, rs1)

#define CBO_PREFETCH_W(base, offset)                            \
        INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3),     \
                __SIMM_11_5((offset) >> 5), __SIMM_4_0(0), RS1(base))


But, again, I feel like it's probably overkill...

Thanks,
drew

