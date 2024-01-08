Return-Path: <linux-kernel+bounces-19824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9668274BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4AE1C22FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026195380B;
	Mon,  8 Jan 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgjlkBcl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969153804
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704730474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkZ71Vmc+u7cdGbhZ3QvvW6zoFvI0y6Sk09Sc1WtDpU=;
	b=YgjlkBclXzBG84QdeVv/WKOwsS/NeNnbuNao1eTA8Bz1W2WIyD01xcorvjXJCXIVGwUK1I
	y3D2/iMpP0qfS7H41VSqtZ2vf7Tb9S7LHMdrdhX1EdVPsBNu3IO3WUzA+rv0ib3zNE33/x
	v4K48xdnXe2Brm5GKRnC2aztmvLg/sg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-JUkKIeyLN0SFpX3AQTPqWg-1; Mon, 08 Jan 2024 11:14:33 -0500
X-MC-Unique: JUkKIeyLN0SFpX3AQTPqWg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d4966f020dso7290075ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704730472; x=1705335272;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkZ71Vmc+u7cdGbhZ3QvvW6zoFvI0y6Sk09Sc1WtDpU=;
        b=cPgHLGZ4IyHbx4i/UuB5imPQT3lDXUxDo66ydbUBAM7BWOj6dTIEffimUfY8ZNF8iT
         b0nsMz4ROgLBzGWnpDLQxkDaBczGqc6uXnOo0wiqYXPLm4d9vd88MO4JvL+Jwpuo+6V/
         bGlom2KSV35DUNoaFfZPiyeJeK+gRGdeyBTcrgQm7wCALNKVU1FNe7M3m3rMZo6pdmqo
         wgQXCWFwPsqemcPtH/mWGRpp2zJVfYYr4N0NrFardgXEzSCJlr5jIYCtZA+6yCxDXeUR
         ET81yWOu7vlzAIjsM9I5pJtMHZKsVpWdIDEY0VqxANbDtcri+J1EAeAHZo6aNNJhQnb0
         304A==
X-Gm-Message-State: AOJu0Yzvj/tGl77VV+nAFkTOjG/UYOdClt6n98p0Ps3HS77YrIcFRTAr
	LVEqd8wK7qmWTF/wYKbT2wNEwsiiJDR6SUudIyg9X5jC3ckmy3OSbL6YL4hfDPoqhDMUVxmRqF/
	Lclltha3RXKA6XmuEf0BF4kf00GAGKxoJ
X-Received: by 2002:a17:902:7008:b0:1d3:77c4:59db with SMTP id y8-20020a170902700800b001d377c459dbmr1510640plk.139.1704730471940;
        Mon, 08 Jan 2024 08:14:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxpetPyx2gDKiR82PKK51KAJw9puORhCUwXnkZI6lR96Xac0Nt4qc3rXXqQPsE1oGpJJpHYg==
X-Received: by 2002:a17:902:7008:b0:1d3:77c4:59db with SMTP id y8-20020a170902700800b001d377c459dbmr1510622plk.139.1704730471579;
        Mon, 08 Jan 2024 08:14:31 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id jf22-20020a170903269600b001d4c22ff497sm92938plb.21.2024.01.08.08.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:14:31 -0800 (PST)
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
Subject: Re: Re: Re: Re: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions & cpufeature
Date: Mon,  8 Jan 2024 13:14:23 -0300
Message-ID: <ZZwfX6PMqeKDsR-z@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108-c47754d958917d5d5e1efc75@orel>
References: <ZZWs0C19tz763FnH@LeoBras> <20240103-0c96ceea88523b7b946e4ba8@orel> <ZZXEpU-JzsvD2UDW@LeoBras> <20240104-4ecfb92d2f8c95fa773ca695@orel> <ZZbI3clKUbNbNtZj@LeoBras> <20240104-d6981cf63a39af4dff1d380a@orel> <ZZbuKCvATa7yyQOc@LeoBras> <20240105-faa40f2c20534ea498246cc3@orel> <ZZwH5w2QLN4t1KtU@LeoBras> <20240108-c47754d958917d5d5e1efc75@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 08, 2024 at 04:24:59PM +0100, Andrew Jones wrote:
> On Mon, Jan 08, 2024 at 11:34:15AM -0300, Leonardo Bras wrote:
> > On Fri, Jan 05, 2024 at 02:24:45PM +0100, Andrew Jones wrote:
> > > On Thu, Jan 04, 2024 at 02:43:04PM -0300, Leonardo Bras wrote:
> > > ...
> > > > > > > > I don't think we can detect a caller with non-zero offset at compile time, 
> > > > > > > > since it will be used in locks which can be at (potentially) any place in 
> > > > > > > > the block size. (if you have any idea though, please let me know :) )
> > > > > 
> > > > > I forgot to reply to this before. The reason I think it may be possible to
> > > > > validate offset at compile time is because it must be a constant, i.e.
> > > > > __builtin_constant_p(offset) must return true. So maybe something like
> > > > > 
> > > > >  static_assert(__builtin_constant_p(offset) && !(offset & 0x1f))
> > > > > 
> > > > > I'll try to find time to play with it.
> > > > > 
> > > > 
> > > > Let me know if you find anything.
> > > 
> > > There's nothing we can do in this file (insn-def.h), other than maybe
> > > masking, since all magic must happen at preprocessor time, other than
> > > a tiny bit of constant arithmetic allowed at assembly time. For C, using
> > > a wrapper, like patch 2 of this series introduces, we could add the
> > > static assert above. I'll suggest that in patch 2, since I've already
> > > thought it through, but it sort of feels like overkill to me.
> > 
> > It makes sense.
> > 
> > > 
> > > > 
> > > > > > > > 
> > > > > > > > On the other hand, we could create a S-Type macro which deliberately 
> > > > > > > > ignores imm[4:0], like  
> > > > > > > > 
> > > > > > > > + INSN_S_TRUNCATE(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > > > > > > > +                 SIMM12(offset), RS1(base))
> > > > > > > > 
> > > > > > > > Which saves the bits 11:5 of offset  into imm[11:5], and zero-fill 
> > > > > > > > imm[4:0], like
> > > > > > > > 
> > > > > > > > +#define DEFINE_INSN_S                                                    \
> > > > > > > > + __DEFINE_ASM_GPR_NUMS                                           \
> > > > > > > > +"        .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> > > > > > > > +"        .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> > > > > > > > +"                 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> > > > > > > > +"                 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> > > > > > > > +"                 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> > > > > > > > +"                 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> > > > > > > > +"        .endm\n"
> > > > > > > > +
> > > > > > > > 
> > > > > > > > Does this make sense?
> > > > > > > 
> > > > > > > If we create a special version of INSN_S, then I suggest we create one
> > > > > > > where its two SIMM fields are independent and then define prefetch
> > > > > > > instructions like this
> > > > > > > 
> > > > > > >  #define PREFETCH_W(base, offset) \
> > > > > > >      INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
> > > > > > >          SIMM_11_5(offset >> 5), SIMM_4_0(0), RS1(base))
> > > > > > > 
> > > > > > > which would allow simple review against the spec and potentially
> > > > > > > support other instructions which use hard coded values in the
> > > > > > > immediate fields.
> > > > > > > 
> > > > > > 
> > > > > > I agree, it looks better this way.
> > > > > > 
> > > > > > We could have:
> > > > > > INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2, SIMM_11_5, SIMM_4_0)
> > > > > > 
> > > > > > and implement INSN_S like:
> > > > > > #define INSN_S(OPCODE, FUNC3, RS1, RS2, SIMM_11_0) \
> > > > > > 	INSN_S_SPLIT_IMM(OPCODE, FUNC3, RS1, RS2,  \
> > > > > > 		SIMM_11_0 >> 5, SIMM_11_0 & 0x1f)
> > > > > 
> > > > > That won't work since SIMM_11_0 will be a string. Actually, with
> > > > > stringification in mind, I don't think defining INSN_S_SPLIT_IMM()
> > > > > is a good idea.
> > > > 
> > > > I don't see how SIMM_11_0 will be a string here. Is this due to using it 
> > > > on asm code?
> > > > 
> > > > I understand a user will call 
> > > > ---
> > > > PREFETCH_W(base, offset), which becomes:
> > > > 
> > > > INSN_S(OPCODE_OP_IMM, 6, base, 3, offset) , which becomes:
> > > > 
> > > > INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), RS1(base), RS2(3), \
> > > > 	SIMM_11_5(offset >> 5), SIMM_4_0(offset & 0x1f))
> > > 
> > > The other annotations, like SIMM12, stringify their arguments. So, if
> > > SIMM_11_5 and SIMM_4_0 also stringified, then it wouldn't be possible
> > > to recombine them into a simm12 for the '.insn s' directive. I suppose
> > > SIMM_11_5 and SIMM_4_0 could just expand their arguments without
> > > stringifying. With that, along with throwing even more ugly at it, then
> > > it is possible to get the end result we want, which is
> > > 
> > >  - PREFETCH_* instructions are defined with annotations and have a
> > >    SIMM_4_0(0) in their definitions to explicitly point out that field
> > > 
> > >  - the INSN_S definition still directly maps to the .insn s directive
> > > 
> > > 
> > > I got that to work with this
> > > 
> > > #define __RV_SIMM(v)           v
> > > #define RV___SIMM_11_5(v)      __RV_SIMM(v)
> > > #define RV___SIMM_4_0(v)       __RV_SIMM(v)
> > > 
> > > #define __INSN_S_SPLIT_IMM(opcode, func3, rs2, simm12, rs1) \
> > >         INSN_S(opcode, func3, rs2, SIMM12(simm12), rs1)
> > > 
> > > #define INSN_S_SPLIT_IMM(opcode, func3, rs2, simm_11_5, simm_4_0, rs1) \
> > >         __INSN_S_SPLIT_IMM(opcode, func3, rs2, (RV_##simm_11_5 << 5) | RV_##simm_4_0, rs1)
> > > 
> > > #define CBO_PREFETCH_W(base, offset)                            \
> > >         INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3),     \
> > >                 __SIMM_11_5((offset) >> 5), __SIMM_4_0(0), RS1(base))
> > > 
> > > 
> > > But, again, I feel like it's probably overkill...
> > 
> > I though our intention was to avoid the extra IMM masking in asm, while 
> > keeping the 5 lower bits zeroed at all times.
> > 
> > But IIUC here you are writing a insn_s_split_imm in terms of a plain 
> > insn_s, which guarantees the zeroed 5 lower bits but still does an 
> > unnecessaty masking in asm. In fact, if we use the split version, it 
> > concatenates the two IMM parts, to then split them again in order to build 
> > the instruction.
> 
> That's backwards.
> 
> INSN_S should map to its namesake directive '.insn s', which takes the
> immediate as a single simm12. simm7 and simm5 are only used in the
> fallback path.

Wait, but is not the final instruction build with a split simm7 and simm5 ?

Oh, ok, we are probably creating an asm with mnemonics first, and leaving 
it to the assembler to split the simm7 and simm5 from simm12. It does make 
sense.

Sorry for the confusion, I was wrongly thinking on terms of final bytecode.

> Also, it's likely few instructions care about the split.
> Other S-type instructions would want to treat the immediate as 12 bits,
> so INSN_S should not be written in terms of INSN_S_SPLIT_IMM, since we'd
> split a 12-bit immediate for those instructions just to have it merged
> again for the .insn s directive.

Yeah, makes sense now.

> 
> > 
> > In my suggestion above, we make INSN_S_SPLIT_IMM() the helper / standard 
> > way to write an s-type and write a INSN_S() in terms of the SPLIT version.
> > 
> > This allows using the split version when we don't need one of the halfs, 
> > thus avoiding a masking or a rotation. The full version just splits the 
> > halfs and pass to the split version that directly builds the instruction.
> > 
> > Well, I think I was under the wrong impression that we wanted to avoid the 
> > rotation and masking, but I just noticed that we are just dealing with 
> > splitting the offset, which is supposed to be a constant during the 
> > generation of the instruction, so we can just guarantee the value being 
> > masked at no runtime cost.
> 
> Right, there's no reason to avoid the rotation and masking with respect to
> performance, as it's all done at compile time. Avoiding the operations as
> much as possible is nice, though, since they're ugly and, with macro
> arguments, getting the parentheses right to ensure the correct order of
> operations is error prone.
> 
> > 
> > So in the end we are just thinking on how it could look better to the user, 
> > and maybe the split version is unnecessary if the user guarantees the 
> > masking to be correct. But if we are going to have it, I suggest we do 
> > INSN_S in terms of INSN_S_SPLIT_IMM() instead of the other way around.
> 
> Yes, the goal was to have __SIM_4_0(0) for the prefetch instructions to
> make it simple to review against the spec, but ((offset) & ~0x1f) is also
> simple to review.

Agreed

> 
> For the next revision of this series, I'd be happy with just the masking
> or even to just leave it up to the callers as this version does.
> 
> Thanks,
> drew
> 

Thank you!
Leo


