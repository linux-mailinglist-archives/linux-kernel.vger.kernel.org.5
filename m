Return-Path: <linux-kernel+bounces-16464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C763823EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00B12866FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8E7208C5;
	Thu,  4 Jan 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="etnyfX8x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A820B06
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so382961e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704361656; x=1704966456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjIOzASFKXtnzifSOlgR7uNlr9WKjwKVoy2m9WsQklE=;
        b=etnyfX8x7PnfmQK9s15o6DjiIedecs7X1ib0odYUMizoHhl9D7GXka3VfufaBx8Kd0
         gNZHjoeqNhbOSJPNeuOMP6TJYE0MZ17UsVpt4gQbApt1K2gXZMTZSou/9DQcYEm5X0Ae
         mtFlCl4Xih36VVB10MYYWuXA7Z9lo0SkMOsJ89GmqW3kzkl5KJWUW4XUf/4YbQNhfXMA
         LiiiHbXvcDIwNcoycf2ValLslh/GK+Ki+Daqsuldn8PMXkwHHBx7jSlcsxt92ZcCpDmX
         kLSzD9ET6eCsuec8/3IbxFhnAKBQrh28lnjNf00zv4ezY+W/Pl2Yb/xdkSIKJiMDQQ8z
         pHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704361656; x=1704966456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjIOzASFKXtnzifSOlgR7uNlr9WKjwKVoy2m9WsQklE=;
        b=gltV/IvsXKv9AzDHP2O+SZuLPjtij/mqYGCXgdE/Vmiv7hzn8SL/fMeExn4reDPEZR
         RJ6ho9L24dwbBmOOS1oBxl4w2o/hrGdWNNU/uzSHPNTb7JxIbQKcEPC8bst0cIwGzdxU
         pWzZHGPIot6pk//r/bJUIk9kHnKrWX1J7GcI/efzQiwu9WjAESsGHU+8BTJ9OQdHhIfg
         iFTVzvWs6vxnLK2tNzgj0qCNSHr/VQX4Cc5GMkjdog0ZPHDQS8fkilX+XKYvT488u0JJ
         BVw7devIwIj6NF8F671Z82J7BkpEdWNDn7Y+xPRm7xAW6eC7VdMT1TmcvgNc/gXr32dK
         Bg1A==
X-Gm-Message-State: AOJu0Yzk42qY5CULfEzXOp7pcdCFKeLOOZ1x/uzjRNp9sYDIIE65Odv1
	9R6F8/6Kw8z7pCnoeA5voGW/3oDcxhMlKg==
X-Google-Smtp-Source: AGHT+IHokDrCyFOkfMV2ZJkoKUpPp5Z2frj1npon3QRHNkknpBQw7ofTk3TqPl1odKml1sS1MObQxw==
X-Received: by 2002:a05:6512:2141:b0:50e:6a07:5c02 with SMTP id s1-20020a056512214100b0050e6a075c02mr201705lfr.15.1704361656189;
        Thu, 04 Jan 2024 01:47:36 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id p9-20020a170907910900b00a26ac5e3683sm12848872ejq.100.2024.01.04.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:47:35 -0800 (PST)
Date: Thu, 4 Jan 2024 10:47:34 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn, 
	xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, uwu@icenowy.me, 
	jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions
 & cpufeature
Message-ID: <20240104-4ecfb92d2f8c95fa773ca695@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
 <ZZWs0C19tz763FnH@LeoBras>
 <20240103-0c96ceea88523b7b946e4ba8@orel>
 <ZZXEpU-JzsvD2UDW@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZXEpU-JzsvD2UDW@LeoBras>

On Wed, Jan 03, 2024 at 05:33:41PM -0300, Leonardo Bras wrote:
> On Wed, Jan 03, 2024 at 08:29:39PM +0100, Andrew Jones wrote:
> > On Wed, Jan 03, 2024 at 03:52:00PM -0300, Leonardo Bras wrote:
> > > On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
...
> > > The shifts seem correct for S-Type, but I would name the IMM defines in a 
> > > way we could understand where they fit in IMM:
> > > 
> > > 
> > > INSN_S_SIMM5_SHIFT -> INSN_S_SIMM_0_4_SHIFT
> > > INSN_S_SIMM7_SHIFT -> INSN_S_SIMM_5_11_SHIFT
> > > 
> > > What do you think?
> > 
> > I'm in favor of this suggestion, but then wonder if we don't need another
> > patch before this which renames INSN_I_SIMM12_SHIFT to
> > INSN_I_SIMM_0_11_SHIFT in order to keep things consistent.
> 
> Agree. If it's ok, I can provide a patch doing the rename on top of this 
> patchset.

The INSN_I change is only needed if we also take the new INSN_S shift
macros, so I think the INSN_I change should be part of this series.

BTW, I just noticed we wrote the numbers backwards. They should be

 INSN_I_SIMM_11_0_SHIFT
 INSN_S_SIMM_11_5_SHIFT
 INSN_S_SIMM_4_0_SHIFT

> > > >  
> > > > +#define CBO_PREFETCH_I(base, offset)				\
> > > > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),		\
> > > > +	       SIMM12(offset), RS1(base))
> > > > +
> > > > +#define CBO_PREFETCH_R(base, offset)				\
> > > > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),		\
> > > > +	       SIMM12(offset), RS1(base))
> > > > +
> > > > +#define CBO_PREFETCH_W(base, offset)				\
> > > > +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),		\
> > > > +	       SIMM12(offset), RS1(base))
> > > > +
> > > 
> > > For OP_IMM & FUNC3(6) we have ORI, right?
> > > For ORI, rd will be at bytes 11:7, which in PREFETCH.{i,r,w} is
> > > offset[4:0].
> > > 
> > > IIUC, when the cpu does not support ZICBOP, this should be fine as long as 
> > > rd = 0, since changes to r0 are disregarded.
> > > 
> > > In this case, we need to guarantee offset[4:0] = 0, or else we migth write 
> > > on an unrelated register. This can be noticed in ZICBOP documentation pages 
> > > 21, 22, 23, as offset[4:0] is always [0 0 0 0 0]. 
> > > (Google docs in first comment)
> > > 
> > > What we need here is something like:
> > > + enum {
> > > + 	PREFETCH_I,
> > > + 	PREFETCH_R,
> > > + 	PREFETCH_W,
> > > + }	 
> > 
> > Can't use enum. This header may be included in assembly.
> 
> Oh, I suggest defines then, since it's better to make it clear instead of 
> using 0, 1, 3.

I don't think we gain anything by adding another define in order to create
the instruction define. We have to review the number sooner or later. I'd
prefer we use the number inside the instruction define so we only need
to look one place, which is also consistent with how we use FUNC fields.

> 
> > 
> > > +
> > > + #define CBO_PREFETCH(type, base, offset)                      \
> > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(type),              \
> > > +            SIMM12(offset & ~0x1f), RS1(base))
> > 
> > Yes. I suggested we mask offset as well, but ideally we'd detect a caller
> > using an offset with nonzero lower 5 bits at compile time.
> 
> I would suggest the compiler would take care of this, but I am not sure 
> about the assembly, since I am not sure if it gets any optimization.
> 
> I don't think we can detect a caller with non-zero offset at compile time, 
> since it will be used in locks which can be at (potentially) any place in 
> the block size. (if you have any idea though, please let me know :) )
> 
> On the other hand, we could create a S-Type macro which deliberately 
> ignores imm[4:0], like  
> 
> + INSN_S_TRUNCATE(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> +                 SIMM12(offset), RS1(base))
> 
> Which saves the bits 11:5 of offset  into imm[11:5], and zero-fill 
> imm[4:0], like
> 
> +#define DEFINE_INSN_S                                                    \
> + __DEFINE_ASM_GPR_NUMS                                           \
> +"        .macro insn_s, opcode, func3, rs2, simm12, rs1\n"               \
> +"        .4byte  ((\\opcode << " __stringify(INSN_S_OPCODE_SHIFT) ") |"  \
> +"                 (\\func3 << " __stringify(INSN_S_FUNC3_SHIFT) ") |"    \
> +"                 (.L__gpr_num_\\rs2 << " __stringify(INSN_S_RS2_SHIFT) ") |" \
> +"                 (.L__gpr_num_\\rs1 << " __stringify(INSN_S_RS1_SHIFT) ") |" \
> +"                 (((\\simm12 >> 5) & 0x7f) << " __stringify(INSN_S_SIMM7_SHIFT) "))\n" \
> +"        .endm\n"
> +
> 
> Does this make sense?

If we create a special version of INSN_S, then I suggest we create one
where its two SIMM fields are independent and then define prefetch
instructions like this

 #define PREFETCH_W(base, offset) \
     INSN_S_SPLIT_IMM(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
         SIMM_11_5(offset >> 5), SIMM_4_0(0), RS1(base))

which would allow simple review against the spec and potentially
support other instructions which use hard coded values in the
immediate fields.

But I'm not sure it's worth it. I think

 #define PREFETCH_W(base, offset) \
     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3), \
         SIMM12(offset & ~0x1f), RS1(base))

is also pretty easy to review against the spec and we don't have any other
instructions yet with other requirements for the immediates.

Thanks,
drew

