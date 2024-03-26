Return-Path: <linux-kernel+bounces-119771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C023288CCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14EA1C3678A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C0613CA97;
	Tue, 26 Mar 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ/Vnn/s"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB6481A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480358; cv=none; b=Ucu7sf99xfpcwOU/quIKDJoc///s1trp4P1bjwTuWZdTaJFTA64xQZFn6v05ulH9hSCHwLnuRyvA0DOZ5VbYQPlffP9ohACdG/SrwV8JzMlvMO+VLjslhUsrqjwE3p5RRwI0xVt78Jzk+ZyuvYKBsmSrP1B9w3vI3RvaMDdPRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480358; c=relaxed/simple;
	bh=vf3NWfA3B2pN92scVZUpS8FutXNA4Gu9OrZsXCtRMHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XE9Okn8TFKd1eG+AiIhppKRkehbwr0mxqlU/xhxIVLwGTeMVgeEejzFyGuL0Gi1pktN3uNfp9JKVoVw+NjqZ/D30z2sUlzRXaW+1vc3l8X5D8VyyWpIGpYXHs72IGI7QtdGscshAY/KE88wYT5RU6u4SSwLJdVYgytRZX4tpVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ/Vnn/s; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41490d249e9so3875505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711480355; x=1712085155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8CSbXEuA4Zn/RoDwlaOSx79lJuQhcbis+lvZo8LMpo=;
        b=IQ/Vnn/sEVwzTEalqZ4fTYcCOrwQDahKLkPbwyO3HcegAiqzFhva7pNXimH0nZ0TKR
         Ve/RVa2DRzYINBt94XyUQWZkT3UdgEVOggti0tG+fAHY6oE66JKMwRdZri3i2suWkBf3
         u6I1C3RTIkasgs0SC4g1Qf/5vyMTXKgi3R/aE3FaO5O6Rh240gMx/hDpJouNZV0mu8qs
         JfYbcB6IQhwOncpFyFabDfj3aykIfCW9khWHg+Uywu5AXSrh7+AOAR0KwHmiL0ycjE0P
         LUWI5DnhU32x4vZWBaeR8ds83INewn35JCGzxqydOkqRTpUKLq+y1XjGOcfQeZFm6VE0
         m0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480355; x=1712085155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8CSbXEuA4Zn/RoDwlaOSx79lJuQhcbis+lvZo8LMpo=;
        b=q9eSZBZ3EDu85gZncF++UCAJL6EP/QMrBMdKa0XESdP9df+W9GqYbMz1dFvD71SsSP
         fyDD5unrHoiu0MyHyFaEXUpDTtmacbovL+Tv5KpdzMCqBSwrvucKlhyW8arDuEBE7oHV
         cx1xCXcAJyeE+ZudXJDU07rugXnomERjNIr9IndtjFC0VN6rm1FkQJeAB9Aln2OOnc/c
         SRLxpzZPP4aw9Y6AhSg8LVcCaO1QN8eQgcZD0Bl3l/cdZFh8OJjkfGBI20tHnQLztzH+
         MheUwTrgBKwtssX593GXI+F+ucNhjfVPxFKHPa2dapR96pOoScBB9xQnknNoAgdcta4p
         gFeA==
X-Gm-Message-State: AOJu0Yy8vi/NVGopg3CR1wELCl3IY4t1jvJxWwbPKxqJg4otzeJIrqiX
	3amO4h8MRpk3nD0LFBTVzRCQj3ORauxbR+kUkNQzY9jjfK/lV5nF
X-Google-Smtp-Source: AGHT+IE/grDEsdCKbR306sqoBmvU1BZ79Gn3+x8Z09xZAupDMP2oPEBtP/2jf8tRWrwR0NG458TgPg==
X-Received: by 2002:a05:600c:1f84:b0:414:887f:6167 with SMTP id je4-20020a05600c1f8400b00414887f6167mr6519766wmb.7.1711480354591;
        Tue, 26 Mar 2024 12:12:34 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c470b00b0041488978873sm8462862wmo.44.2024.03.26.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:12:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 20:12:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 1/1] headers/deps: x86/fpu: Make task_struct::thread
 constant size
Message-ID: <ZgMeH9p0BTnMfmOM@gmail.com>
References: <20240320131908.2708438-1-mingo@kernel.org>
 <20240320131908.2708438-2-mingo@kernel.org>
 <20240326174903.GA4539@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326174903.GA4539@redhat.com>


* Oleg Nesterov <oleg@redhat.com> wrote:

> On 03/20, Ingo Molnar wrote:
> >
> > --- a/arch/x86/kernel/fpu/init.c
> > +++ b/arch/x86/kernel/fpu/init.c
> > @@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
> >  	/* Flush out any pending x87 state: */
> >  #ifdef CONFIG_MATH_EMULATION
> >  	if (!boot_cpu_has(X86_FEATURE_FPU))
> > -		fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
> > +		fpstate_init_soft(current->thread.fpu->fpstate->regs.soft);
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Typo? it should be
> 
> 	&current->thread.fpu->fpstate->regs.soft

Thx, fixed.

> 
> > +static struct fpu x86_init_fpu __read_mostly;
> > +
> >  static void __init fpu__init_system_early_generic(void)
> >  {
> > +	{
> > +		int this_cpu = smp_processor_id();
> > +
> > +		fpstate_reset(&x86_init_fpu);
> > +		current->thread.fpu = &x86_init_fpu;
> > +		per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> > +		x86_init_fpu.last_cpu = this_cpu;
> > +	}
> 
> Can't x86_init_fpu be declared inside the block above?

As a function-local static? I think globals are better defined in a visible 
fashion, not hidden among local variables where they are easy to overlook.

But the extra block is unnecessary in any case.

> >  void __init fpu__init_system(void)
> >  {
> > -	fpstate_reset(&current->thread.fpu);
> >  	fpu__init_system_early_generic();
> > +	fpstate_reset(current->thread.fpu);
> 
> It seems that fpstate_reset(current->thread.fpu) is not needed after the
> change in fpu__init_system_early_generic() above.

Yeah. Something like the delta patch below?

Thanks,

	Ingo

=================>

 arch/x86/kernel/fpu/init.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index f9412d012191..de618ec509aa 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(current->thread.fpu->fpstate->regs.soft);
+		fpstate_init_soft(&current->thread.fpu->fpstate->regs.soft);
 	else
 #endif
 		asm volatile ("fninit");
@@ -75,14 +75,12 @@ static struct fpu x86_init_fpu __read_mostly;
 
 static void __init fpu__init_system_early_generic(void)
 {
-	{
-		int this_cpu = smp_processor_id();
+	int this_cpu = smp_processor_id();
 
-		fpstate_reset(&x86_init_fpu);
-		current->thread.fpu = &x86_init_fpu;
-		per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
-		x86_init_fpu.last_cpu = this_cpu;
-	}
+	fpstate_reset(&x86_init_fpu);
+	current->thread.fpu = &x86_init_fpu;
+	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
+	x86_init_fpu.last_cpu = this_cpu;
 
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
@@ -222,7 +220,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 void __init fpu__init_system(void)
 {
 	fpu__init_system_early_generic();
-	fpstate_reset(current->thread.fpu);
 
 	/*
 	 * The FPU has to be operational for some of the

