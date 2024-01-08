Return-Path: <linux-kernel+bounces-19714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5D827179
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB0F284230
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696347A46;
	Mon,  8 Jan 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToUepqIU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF54778E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704724470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkiqsaVDl5/2LelsXlVddSZIPY53rJQPMJGJG6V+LnM=;
	b=ToUepqIUPpTYEVPz1vfTdOQvnBUNHLYT3ZlzUNUpbYTgDk/NoYYA5IG1Xo49xsb0x9isLF
	cooF8OrEi7BZywyd0YZrVUAOaT6+TV4uU3ukLbKdiNY8LabE951//guDUEfzHUkrlP8HAh
	s1oDHUhg/B5Swr9qeIm5uKcL5cJy+o0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-D3pvQzhYMPymmAMFsrHkJA-1; Mon, 08 Jan 2024 09:34:27 -0500
X-MC-Unique: D3pvQzhYMPymmAMFsrHkJA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d9c07b2372so1907249b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704724466; x=1705329266;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkiqsaVDl5/2LelsXlVddSZIPY53rJQPMJGJG6V+LnM=;
        b=KNoRvnGwTF2Td56XqPgXbD0wo38XYOmJDT7geASojZtCJNVDPR8nS/+ja7FIoTl+dY
         RmE41rZGZK/8rXVEeLMOLeZ+hcAjlIZPcadZd07Zx3kaakN6OH8Vru6CXvG6eaHvAfix
         pkSK+6qUgETboHUct5QaUTP4MoabYF2dYJAIIMmqZy9uq7D+T3DOJwGry1KhLqBjsWZR
         Ss8Kyh73xCDZ1VD+d4iOVIezz24Fmk0PtNbi4z23Ruo1uRXOJNJsqAiML89S/HeyQlAB
         fyONS6LekcpRYyqYeqWjVmR2cX1dYOnA6dvvkRwhAQxeDSplGOJfwQfj5+MvsV/wSHGH
         s3Gg==
X-Gm-Message-State: AOJu0YxUDv8pDyZDuc/lUBxbq//mFGEMGbj7f2bH7n3/0aeuaeJpJSU3
	Afj+fga45vYtgFCkzq8ut7mWMLjm9+dFIA/c2cBPrzUeti81CUJ/UhrWfVtG9zov1IocAI/5fEK
	wecUp8zg/dVt5/j9S69oVd5e/N17Tyyeq
X-Received: by 2002:a05:6a20:914b:b0:199:afa3:25f7 with SMTP id x11-20020a056a20914b00b00199afa325f7mr2404072pzc.39.1704724466223;
        Mon, 08 Jan 2024 06:34:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwR7HdOtCOkj2Ss21wiDgFQrjnmmvRn1uShoSU6/NrXe4s+oZV3zebXCwrGIsW5414AL4AyQ==
X-Received: by 2002:a05:6a20:914b:b0:199:afa3:25f7 with SMTP id x11-20020a056a20914b00b00199afa325f7mr2404045pzc.39.1704724465817;
        Mon, 08 Jan 2024 06:34:25 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id fk10-20020a056a003a8a00b006da8b181bfbsm6035561pfb.169.2024.01.08.06.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:34:25 -0800 (PST)
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
Subject: Re: Re: Re: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions & cpufeature
Date: Mon,  8 Jan 2024 11:34:15 -0300
Message-ID: <ZZwH5w2QLN4t1KtU@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105-faa40f2c20534ea498246cc3@orel>
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-2-guoren@kernel.org> <ZZWs0C19tz763FnH@LeoBras> <20240103-0c96ceea88523b7b946e4ba8@orel> <ZZXEpU-JzsvD2UDW@LeoBras> <20240104-4ecfb92d2f8c95fa773ca695@orel> <ZZbI3clKUbNbNtZj@LeoBras> <20240104-d6981cf63a39af4dff1d380a@orel> <ZZbuKCvATa7yyQOc@LeoBras> <20240105-faa40f2c20534ea498246cc3@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 05, 2024 at 02:24:45PM +0100, Andrew Jones wrote:
> On Thu, Jan 04, 2024 at 02:43:04PM -0300, Leonardo Bras wrote:
> ...
> > > > > > I don't think we can detect a caller with non-zero offset at compile time, 
> > > > > > since it will be used in locks which can be at (potentially) any place in 
> > > > > > the block size. (if you have any idea though, please let me know :) )
> > > 
> > > I forgot to reply to this before. The reason I think it may be possible to
> > > validate offset at compile time is because it must be a constant, i.e.
> > > __builtin_constant_p(offset) must return true. So maybe something like
> > > 
> > >  static_assert(__builtin_constant_p(offset) && !(offset & 0x1f))
> > > 
> > > I'll try to find time to play with it.
> > > 
> > 
> > Let me know if you find anything.
> 
> There's nothing we can do in this file (insn-def.h), other than maybe
> masking, since all magic must happen at preprocessor time, other than
> a tiny bit of constant arithmetic allowed at assembly time. For C, using
> a wrapper, like patch 2 of this series introduces, we could add the
> static assert above. I'll suggest that in patch 2, since I've already
> thought it through, but it sort of feels like overkill to me.

It makes sense.

> 
> > 
> > > > > > 
> > > > > > On the other hand, we could create a S-Type macro which deliberately 
> > > > > > ignores imm[4:0], like  
> > > > > > 
> > > > > > + INSN_S_TRUNCATE(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > > > > > +                 SIMM12(offset), RS1(base))
> > > > > > 
> > > > > > Which saves the bits 11:5 of offset  into imm[11:5], and zero-fill 
> > > > > > imm[4:0], like
> > > > > > 
> > > > > > +#define DEFINE_INSN_S                                                    \
> > > > > > + __DEFINE_ASM_GPR_NUMS                                           \
> > > > > > +"        .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> > > > > > +"        .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> > > > > > +"                 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> > > > > > +"                 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> > > > > > +"                 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> > > > > > +"                 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> > > > > > +"        .endm\n"
> > > > > > +
> > > > > > 
> > > > > > Does this make sense?
> > > > > 
> > > > > If we create a special version of INSN_S, then I suggest we create one
> > > > > where its two SIMM fields are independent and then define prefetch
> > > > > instructions like this
> > > > > 
> > > > >  #define PREFETCH_W(base, offset) \
> > > > >      INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
> > > > >          SIMM_11_5(offset >> 5), SIMM_4_0(0), RS1(base))
> > > > > 
> > > > > which would allow simple review against the spec and potentially
> > > > > support other instructions which use hard coded values in the
> > > > > immediate fields.
> > > > > 
> > > > 
> > > > I agree, it looks better this way.
> > > > 
> > > > We could have:
> > > > INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2, SIMM_11_5, SIMM_4_0)
> > > > 
> > > > and implement INSN_S like:
> > > > #define INSN_S(OPCODE, FUNC3, RS1, RS2, SIMM_11_0) \
> > > > 	INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2,  \
> > > > 		SIMM_11_0 >> 5, SIMM_11_0 & 0x1f)
> > > 
> > > That won't work since SIMM_11_0 will be a string. Actually, with
> > > stringification in mind, I don't think defining INSN_S_SPLIT_IMM()
> > > is a good idea.
> > 
> > I don't see how SIMM_11_0 will be a string here. Is this due to using it 
> > on asm code?
> > 
> > I understand a user will call 
> > ---
> > PREFETCH_W(base, offset), which becomes:
> > 
> > INSN_S(OPCODE_OP_IMM, 6, base, 3, offset) , which becomes:
> > 
> > INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), RS1(base), RS2(3), \
> > 	SIMM_11_5(offset >> 5), SIMM_4_0(offset & 0x1f))
> 
> The other annotations, like SIMM12, stringify their arguments. So, if
> SIMM_11_5 and SIMM_4_0 also stringified, then it wouldn't be possible
> to recombine them into a simm12 for the '.insn s' directive. I suppose
> SIMM_11_5 and SIMM_4_0 could just expand their arguments without
> stringifying. With that, along with throwing even more ugly at it, then
> it is possible to get the end result we want, which is
> 
>  - PREFETCH_* instructions are defined with annotations and have a
>    SIMM_4_0(0) in their definitions to explicitly point out that field
> 
>  - the INSN_S definition still directly maps to the .insn s directive
> 
> 
> I got that to work with this
> 
> #define __RV_SIMM(v)           v
> #define RV___SIMM_11_5(v)      __RV_SIMM(v)
> #define RV___SIMM_4_0(v)       __RV_SIMM(v)
> 
> #define __INSN_S_SPLIT_IMM(opcode, func3, rs2, simm12, rs1) \
>         INSN_S(opcode, func3, rs2, SIMM12(simm12), rs1)
> 
> #define INSN_S_SPLIT_IMM(opcode, func3, rs2, simm_11_5, simm_4_0, rs1) \
>         __INSN_S_SPLIT_IMM(opcode, func3, rs2, (RV_##simm_11_5 << 5) | RV_##simm_4_0, rs1)
> 
> #define CBO_PREFETCH_W(base, offset)                            \
>         INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3),     \
>                 __SIMM_11_5((offset) >> 5), __SIMM_4_0(0), RS1(base))
> 
> 
> But, again, I feel like it's probably overkill...

I though our intention was to avoid the extra IMM masking in asm, while 
keeping the 5 lower bits zeroed at all times.

But IIUC here you are writing a insn_s_split_imm in terms of a plain 
insn_s, which guarantees the zeroed 5 lower bits but still does an 
unnecessaty masking in asm. In fact, if we use the split version, it 
concatenates the two IMM parts, to then split them again in order to build 
the instruction.

In my suggestion above, we make INSN_S_SPLIT_IMM() the helper / standard 
way to write an s-type and write a INSN_S() in terms of the SPLIT version.

This allows using the split version when we don't need one of the halfs, 
thus avoiding a masking or a rotation. The full version just splits the 
halfs and pass to the split version that directly builds the instruction.

Well, I think I was under the wrong impression that we wanted to avoid the 
rotation and masking, but I just noticed that we are just dealing with 
splitting the offset, which is supposed to be a constant during the 
generation of the instruction, so we can just guarantee the value being 
masked at no runtime cost. 

So in the end we are just thinking on how it could look better to the user, 
and maybe the split version is unnecessary if the user guarantees the 
masking to be correct. But if we are going to have it, I suggest we do 
INSN_S in terms of INSN_S_SPLIT_IMM() instead of the other way around.


Thanks!
Leo

> 
> Thanks,
> drew
> 


