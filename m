Return-Path: <linux-kernel+bounces-112280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D038877CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099671F21EF1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF66FC08;
	Sat, 23 Mar 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HoE6pFfX"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD509611A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711186544; cv=none; b=AeNlWQbSEqzefzB3Lbb4EXNJ+A+xp8xQZSUjb9q6AI8H6AnwJnEW1QYmF2zxFxVUCSgSdpePRvKY8QBunTKb9NJrpW9Qn3is5Au0h8ezeQPh0s/pQuQlUvvNMoZKyGVjq/9nWEF9TuPr7UlDPCM24UHB56PCUCA1IiEsYXO1hXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711186544; c=relaxed/simple;
	bh=IS2YT0ZGw+pwuMBw7oTHx8qnYRpFJ+PCjNBh1mJnF9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICdbTZxojBZdCro4jlPtL+uuF6K0yQCtGuQyXu5/evyhHgnfEaQFxGT1hcVWtyRQi/ccErb9K1QNnqmRaDRPRzRaWan/eh+JGjx4YXh8wo4tCe8qIRnd2nowU6j69NgXGuppvWSzFtMAstGpYBuVMrcPTTY4PulpuYTyYirtw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HoE6pFfX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3416df43cabso1664979f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711186541; x=1711791341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gifRQ1PeHTOYVEFwRFqeQ4RDDqpypI+PitbwyUwiMWU=;
        b=HoE6pFfXEUuJjG51J2ymubUO7cyU9rDGDIZ0D+rFscFjdSicMCKmzQR8Ob3qtAW1hd
         /iERj9xc/28SwZresj2Iid2Shp3hyaFd+NDD4welHBOREO767mrmN1KxH1QRc/g91zjA
         j9FYgG8OfNuUPAoEeeeKkgzssxggT4a/M78EW1nG29WvSuy0+mv/g8SwbpCDUPgtxDpY
         Q/tZA/PBxp3E6FkZO3rLdN3G+0p6awHLQriubEcWjzKFaCy7xZ2wUicDvxz5menSHZ5s
         JoTy1MtEXFb/q0X3iyqvWeErcwWxOapgV0YP35kqwXnOLWuvEvi2TUSWx8sdZeR3UPUe
         cBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711186541; x=1711791341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gifRQ1PeHTOYVEFwRFqeQ4RDDqpypI+PitbwyUwiMWU=;
        b=TnY6CHur83Qltpt9n2uTJayzdOYH05Kbhd1sc4+p5pgB63uzdT+VcfWa2K30QmYkkE
         RaNnItATIeuXwAfzV5KKtIKsk6JATJdq9i7rthpJlTVBZc03Uk2rVQ8iBoHtNUoLDJHE
         0dtBa9IAp2R47GaFvikbiNtI2bEeRmPWaqoaZ8zn4lx2sWTusIDdpupzOvjGRIgkcvWD
         c3Aw6UVO34LgvVVMJPFdehaI2W+QNN4mZQ9QjF5AaJk8qUUQ9tcVFFPc0BPTMBp0P5fc
         wD70JRdF3bZA5MUQtG1278T8EPd2tsOtX6YQjxa0tpBJxUI9p4DSmG7Om/hJkJ9ZX4db
         DQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdRERJ9ezHt37sWxAbISH0i3o73PsWNqoRWFLV/qrY4A1H5G5b1o5iKgRlP0rrFDff5J0kRnlmEuuO8oxCpPDEL7eQ6xI9qWVbPYR2
X-Gm-Message-State: AOJu0YwDWlKd7STqX2ZfaalXH6dW0vkyTsrXRTTz5ypz6tuhVBWy33PL
	dAgk6a37s6zLFAjIEfmEqGnOarHMM186eE9l9IetjQAWDD6g+ZuVxuG2rh5e4z4=
X-Google-Smtp-Source: AGHT+IFbwgqGndQ/tq89s59sI9i70gnFLDdzQdyEVv7eywiPzA9nOZyyH6mD6Ek/HoPjrrEzETlg/w==
X-Received: by 2002:a5d:40d2:0:b0:33e:78d5:848e with SMTP id b18-20020a5d40d2000000b0033e78d5848emr1084783wrq.12.1711186540910;
        Sat, 23 Mar 2024 02:35:40 -0700 (PDT)
Received: from localhost ([2a00:11b1:10c0:1192:d048:e3e1:1749:7466])
        by smtp.gmail.com with ESMTPSA id cl1-20020a5d5f01000000b0033e72e104c5sm3007561wrb.34.2024.03.23.02.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 02:35:40 -0700 (PDT)
Date: Sat, 23 Mar 2024 10:35:38 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, 
	Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org, 
	kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
Message-ID: <20240323-28943722feb57a41fb0ff488@orel>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com>
 <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
 <CAKC1njQYZHbQJ71mapeG1DEw=A+aGx77xsuQGecsNFpoJ=tzGQ@mail.gmail.com>
 <d9452ab4-a783-4bcf-ac25-40baa4f31fac@sifive.com>
 <CAKC1njRBbzM+gWowg1LOjq5GzVn4q+vJP9JUswVYfWmEw+yHSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKC1njRBbzM+gWowg1LOjq5GzVn4q+vJP9JUswVYfWmEw+yHSg@mail.gmail.com>

On Fri, Mar 22, 2024 at 10:13:48AM -0700, Deepak Gupta wrote:
> On Thu, Mar 21, 2024 at 5:13 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
> >
> > On 2024-03-19 11:39 PM, Deepak Gupta wrote:
> > >>>> --- a/arch/riscv/include/asm/switch_to.h
> > >>>> +++ b/arch/riscv/include/asm/switch_to.h
> > >>>> @@ -69,6 +69,17 @@ static __always_inline bool has_fpu(void) { return false; }
> > >>>>  #define __switch_to_fpu(__prev, __next) do { } while (0)
> > >>>>  #endif
> > >>>>
> > >>>> +static inline void sync_envcfg(struct task_struct *task)
> > >>>> +{
> > >>>> +       csr_write(CSR_ENVCFG, this_cpu_read(riscv_cpu_envcfg) | task->thread.envcfg);
> > >>>> +}
> > >>>> +
> > >>>> +static inline void __switch_to_envcfg(struct task_struct *next)
> > >>>> +{
> > >>>> +       if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
> > >>>
> > >>> I've seen `riscv_cpu_has_extension_unlikely` generating branchy code
> > >>> even if ALTERNATIVES was turned on.
> > >>> Can you check disasm on your end as well.  IMHO, `entry.S` is a better
> > >>> place to pick up *envcfg.
> > >>
> > >> The branchiness is sort of expected, since that function is implemented by
> > >> switching on/off a branch instruction, so the alternate code is necessarily a
> > >> separate basic block. It's a tradeoff so we don't have to write assembly code
> > >> for every bit of code that depends on an extension. However, the cost should be
> > >> somewhat lowered since the branch is unconditional and so entirely predictable.
> > >>
> > >> If the branch turns out to be problematic for performance, then we could use
> > >> ALTERNATIVE directly in sync_envcfg() to NOP out the CSR write.
> > >
> > > Yeah I lean towards using alternatives directly.
> >
> > One thing to note here: we can't use alternatives directly if the behavior needs
> > to be different on different harts (i.e. a subset of harts implement the envcfg
> > CSR). I think we need some policy about which ISA extensions are allowed to be
> > asymmetric across harts, or else we add too much complexity.
> 
> As I've responded on the same thread . We are adding too much
> complexity by assuming
> that heterogeneous ISA exists (which it doesn't today). And even if it
> exists, it wouldn't work.
> Nobody wants to spend a lot of time figuring out which harts have
> which ISA and which
> packages are compiled with which ISA. Most of the end users do `sudo
> apt get install blah blah`
> And then expect it to just work.

That will still work if the applications and libraries installed are
heterogeneous-platform aware, i.e. they do the figuring out which harts
have which extensions themselves. Applications/libraries should already
be probing for ISA extensions before using them. It's not a huge leap to
also check which harts support those extensions and then ensure affinity
is set appropriately.

> It doesn't work for other
> architectures and even when someone
> tried, they had to disable certain ISA features to make sure that all
> cores have the same ISA feature
> (search AVX12 Intel Alder Lake Disable).

The RISC-V software ecosystem is still being developed. We have an
opportunity to drop assumptions made by other architectures.


As I said in a different reply, it's reasonable for Linux to not add the
complexity until a use case comes along that Linux would like to support,
but I think it would be premature for Linux to put a stake in the sand.

So, how about we add code that confirms Zicboz is on all harts. If any
hart does not have it, then we complain loudly and disable it on all
the other harts. If it was just a hardware description bug, then it'll
get fixed. If there's actually a platform which doesn't have Zicboz
on all harts, then, when the issue is reported, we can decide to not
support it, support it with defconfig, or support it under a Kconfig
guard which must be enabled by the user.

Thanks,
drew

