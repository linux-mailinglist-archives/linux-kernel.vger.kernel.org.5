Return-Path: <linux-kernel+bounces-15929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC88235C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CDE1C24035
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D21CF90;
	Wed,  3 Jan 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oGVX+6kS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A61CABC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d89446895so5057305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704311043; x=1704915843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b9CHgCTAmoG5A60KnZf4T1tVz7YGGSxQ7gA16oR1g5Q=;
        b=oGVX+6kSrzNvFymvqgy5HEB/1pFKTqE9UjCchMLn4CJlNscnNHwj286uDldbt6svc7
         +PtKu1UbD1RcoCkChtpP0NRnpF1tTCgDLQNqzR2kbRjbUAwBmG/3aBoyCTxl/soQHbLZ
         ftXA7O1T/dHvxk5YxslYgqUuGWlPUaGUPsBzG+6OgPOUvN8php+0L8oAMw9TP37nNrWD
         eDb+Ck++S4SlfOGhlljr8gDzJfIXcpLaLVhki5S2hDwQW5PE9U9nlqpr6XxVprgfWwtD
         4aG3B2a90b7SHb9B0/XXrIclr6GHARL9PvUEWMMuLjiSpCoBO7Lu+bkubt+VZ7eS2Vmc
         t9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311043; x=1704915843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9CHgCTAmoG5A60KnZf4T1tVz7YGGSxQ7gA16oR1g5Q=;
        b=gpGvewyMFkFCo87Kilj7nOOoqMQnHv1CWF/ocvanviFc0D3cid6NmEyxdIBDliEA54
         JaLl6o4dr5heYVMVdxq4gxReRMrjv3WuTc2dJ7M3ov2tJWYczP15WfsurYh/kE6fsTrR
         joYrk1V3zAKDjRjr/NetvGoXDCVyjuAor4DZD6PiQkzIjBhY5Znkdu99XtXEoGDDAHjm
         vX0S191ypKV9wCAP6DhwnbKUQmngV8d61uQSw64FBs2/6/4PwFrNaovfrOGnNG9Uapkn
         EtFtlvG1wnHb4n6OhwgMy0WCI5kPU0i14L3igy2Ap6NlcszBeWph9i1GsoXQlqDS5xVy
         FeeQ==
X-Gm-Message-State: AOJu0YwyohJiV39SI3n+crTXG6Zbf+vuFL5UvWtKp3qiN7i6wrci/AvG
	CZ2qgGw7KJHt31kV+FnqIDNge05Mjl5G4g==
X-Google-Smtp-Source: AGHT+IGBIb7ITYX23JqCQXbEC6XyafHEd4Hpmwy7lvlIeRDAyFWSQQ1AGyRWcV48sj2HCLaP6yOSBg==
X-Received: by 2002:a05:600c:1390:b0:40d:88ba:b1a4 with SMTP id u16-20020a05600c139000b0040d88bab1a4mr735290wmf.97.1704311043266;
        Wed, 03 Jan 2024 11:44:03 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d4b82000000b003367ff4aadasm31164979wrt.31.2024.01.03.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:44:02 -0800 (PST)
Date: Wed, 3 Jan 2024 20:44:01 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Guo Ren <guoren@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: Re: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions
 & cpufeature
Message-ID: <20240103-e4221a773e12206048879101@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
 <20240102-4f12393de3c6313650a24c17@orel>
 <CAJF2gTRRqbC5RTGtwhQD1pR+JoP_D64+AUMdO2r5ff-cR5AaUg@mail.gmail.com>
 <20240103-8a6aba29ada25eb1ab004687@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240103-8a6aba29ada25eb1ab004687@orel>

On Wed, Jan 03, 2024 at 07:49:44AM +0100, Andrew Jones wrote:
> On Wed, Jan 03, 2024 at 02:13:00PM +0800, Guo Ren wrote:
> > On Tue, Jan 2, 2024 at 6:32 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
...
> > > >  #define HFENCE_VVMA(vaddr, asid)                             \
> > > > @@ -196,4 +244,16 @@
> > > >       INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
> > > >              RS1(base), SIMM12(4))
> > > >
> > > > +#define CBO_PREFETCH_I(base, offset)                         \
> > > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),               \
> > > > +            SIMM12(offset), RS1(base))
> > > > +
> > > > +#define CBO_PREFETCH_R(base, offset)                         \
> > > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),               \
> > > > +            SIMM12(offset), RS1(base))
> > > > +
> > > > +#define CBO_PREFETCH_W(base, offset)                         \
> > > > +     INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),               \
> > > > +            SIMM12(offset), RS1(base))
> > >
> > > Shouldn't we ensure the lower 5-bits of offset are zero by masking it?
> > The spec says:
> > "These instructions operate on the cache block whose effective address
> > is the sum of the base address specified in rs1 and the sign-extended
> > offset encoded in imm[11:0], where imm[4:0] shall equal 0b00000. The
> > effective address is translated into a corresponding physical address
> > by the appropriate translation mechanisms."
> > 
> > So, the user of prefetch.w should keep imm[4:0] zero.
> 
> Yes, the user _should_ keep imm[4:0] zero. Unless we can validate at
> compile time that all users have passed offsets with the lower 5-bits
> set to zero, then I think we should mask them here, since I'd rather
> not provide the user a footgun.
> 
> > Just like the
> > patch has done, the whole imm[11:0] is zero.
> 
> That's just one possible use, and I think exposing the offset operand to
> users makes sense for unrolled sequences of invocations, so I wouldn't
> count on offset always being zero.
>

Another thought on this line is that a base which isn't block size aligned
may not "work". The spec says

"""
...instruction indicates to hardware that the cache block whose effective
address is the sum of the base address specified in rs1 and the
sign-extended offset encoded in imm[11:0], where imm[4:0] equals
0b00000, is likely to be accessed...
"""

which implies we need an effective address which maps to a cache block.
However, unlike having a nonzero imm[4:0], I don't fear a problem with the
instruction if 'base' isn't block sized aligned, but the instruction might
not do anything.

I think we need to add DT parsing of riscv,cbop-block-size and then
use it to mask the base address in the callers of these macros. (But
that doesn't mean I don't think we still need to mask offset here.)

Thanks,
drew

