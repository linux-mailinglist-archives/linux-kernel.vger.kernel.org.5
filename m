Return-Path: <linux-kernel+bounces-150662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BF8AA28D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17521C20B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CDD17AD9C;
	Thu, 18 Apr 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dCZAvTUx"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915317AD78
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467459; cv=none; b=ON3YOajySHkfQuPUVrXsGac35uE/idDMdeImOl/drVT3QLRYs7Tiu7efAZqEW4lPH1OgULzO3OJ22n2GwNmA4lV59i1lKB7wDutPASrE79aVian5v+PglmMbr1DFsFBrOMFcloG4N6chAL3ORKRNCb67Ij12Ko61829k1NFaeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467459; c=relaxed/simple;
	bh=fKvjYa4hT357YRHB0hcQ/ZXQT9zlt9zFPHDmQfgcgPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEx1IsrYxTPEZz07KGJYHjQhM8+G3Iixp0HlWwHJyQwB1jkVfQZHeDmtBkyUVBGFvre5oRrswqU/6d9egcEFZfcnNtR2jzdMo/TDcJ71zn7a7tVtZ0Sjg+RLplGYh68OM+BVmjfHjtG94L/0t9Mz+6s9BBs+ja8gGQDFkwA9QhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dCZAvTUx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-418c2bf2f15so10491195e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713467456; x=1714072256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXdSYYCw4tbBK12sFpumhiTHBryJ6X9NPqaTloVYbGU=;
        b=dCZAvTUxdjq43+gm0Ks91sLpqqJcXtuw4u6O3w9hxUyhDr3RWVDfzNx7E2XCl3HWbU
         j/+wKYeWEeGGSZ7HLLCnFxGmqlCSHnCR6kDeLeqQB58+NFDBjfarDN09ubQsSIuBf3jm
         yq/Op/MOiYJRCt6+GH1+JpXhU8jBcL5tHQ1Rh92RdkXD7ka6DNpX0ydDArbAaIXQ+VoQ
         0wv5zabGLP0Srjmitc8PWqpVlWbPcr353qwSESYbS9saOO63ci8kAGKL0vnRB9/uwVTy
         woRuLuvjIx5QmnTumN5syEX5uFJVIvCSRdTM4hZEGZ11dkZXgHLOC5FmbMK6ZBRyEn2t
         BR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713467456; x=1714072256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXdSYYCw4tbBK12sFpumhiTHBryJ6X9NPqaTloVYbGU=;
        b=p++KyLQsKWm4JurfBeWKKej7Vg7UTPa0FvYgRX/B/sqavP1dQ41NRwCB6C2UtLBPfV
         KlbSHmU1zhWSVXXzAr794q2ZPiadEq+bMpR5+yk7HH3hI1d6lMl3BGdutFNx8t/kagnD
         9G+ziAtyVE2nbQTvaf2WCLlmyk/wdJoxsU5AuhXHU0yEXiC4n75Qny4DYWhpj06m2dN0
         gacylATCUolT5bIaZ+MBR7gq3t5LkDbUTPAWIl9BgePfYAbDe/2NLcb0EPGMoaE87ZNQ
         Xg/4AyE4nd/7a0K9ZDd3v7qG1cDmkWAnRTniWJKo9xSVGQFs565GbVerZXRaG3p7qoef
         WsMg==
X-Forwarded-Encrypted: i=1; AJvYcCX1r6bxbuhjg28JYpRpI9j0c7rJNpM4WZ9KO3dxHcCmgRUHVkHy11xy9kkT+MwXctVMoBYiR3+srhmbcO2cFXd6KDs+YxYQJfD1j5AX
X-Gm-Message-State: AOJu0YzL3OhbQ5vxoMOG+kQi8hZtxjSj5u6QMWWcAXCscxK6lI89rhJq
	v8SAXu0wXI+qICO1c0Y8T0pOpGSGyCqctF/bQvG8JIlgkphf/E21cJ5L6M2X0cE=
X-Google-Smtp-Source: AGHT+IEW9e+5B+54U3zhcer9b4WmdKoqb4N3E3Rq+DsJVrLICB1hplQdrHWsY00Soarca1d97Rc1YA==
X-Received: by 2002:a05:600c:4511:b0:417:fbc2:caf8 with SMTP id t17-20020a05600c451100b00417fbc2caf8mr2760993wmo.23.1713467456173;
        Thu, 18 Apr 2024 12:10:56 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b00418a6d62ad0sm7472101wmq.34.2024.04.18.12.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:10:55 -0700 (PDT)
Date: Thu, 18 Apr 2024 21:10:54 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: Xu Lu <luxu.kernel@bytedance.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com, guoren@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, lihangjing@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, chaiwen.cc@bytedance.com
Subject: Re: [RFC 1/2] riscv: process: Introduce idle thread using Zawrs
 extension
Message-ID: <20240418-d9f305770dc71c2687a6e84b@orel>
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <20240418114942.52770-2-luxu.kernel@bytedance.com>
 <20240418-dove-deferral-2b01100e13ca@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-dove-deferral-2b01100e13ca@spud>

On Thu, Apr 18, 2024 at 04:05:55PM +0100, Conor Dooley wrote:
> + Drew,
> 
> On Thu, Apr 18, 2024 at 07:49:41PM +0800, Xu Lu wrote:
> > The Zawrs extension introduces a new instruction WRS.NTO, which will
> > register a reservation set and causes the hart to temporarily stall
> > execution in a low-power state until a store occurs to the reservation
> > set or an interrupt is observed.
> > 
> > This commit implements new version of idle thread for RISC-V via Zawrs
> > extension.
> > 
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
> > Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
> > Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
> > ---
> >  arch/riscv/Kconfig                 | 24 +++++++++++++++++
> >  arch/riscv/include/asm/cpuidle.h   | 11 +-------
> >  arch/riscv/include/asm/hwcap.h     |  1 +
> >  arch/riscv/include/asm/processor.h | 17 +++++++++++++
> >  arch/riscv/kernel/cpu.c            |  5 ++++
> >  arch/riscv/kernel/cpufeature.c     |  1 +
> >  arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
> >  7 files changed, 89 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index be09c8836d56..a0d344e9803f 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -19,6 +19,7 @@ config RISCV
> >  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> >  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> >  	select ARCH_HAS_BINFMT_FLAT
> > +	select ARCH_HAS_CPU_FINALIZE_INIT
> >  	select ARCH_HAS_CURRENT_STACK_POINTER
> >  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
> >  	select ARCH_HAS_DEBUG_VM_PGTABLE
> > @@ -525,6 +526,20 @@ config RISCV_ISA_SVPBMT
> >  
> >  	   If you don't know what to do here, say Y.
> >  
> > +config RISCV_ISA_ZAWRS
> > +	bool "Zawrs extension support for wait-on-reservation-set instructions"
> > +	depends on RISCV_ALTERNATIVE
> > +	default y
> > +	help
> > +	   Adds support to dynamically detect the presence of the Zawrs
> > +	   extension and enable its usage.
> 
> Drew, could you, in your update, use the wording:
> 	   Add support for enabling optimisations in the kernel when the
> 	   Zawrs extension is detected at boot.

How about

  The Zawrs extension defines a pair of instructions to be used in
  polling loops which allow a hart to enter a low-power state or to
  trap to the hypervisor while waiting on a store to a memory location.
  Enable the use of these instructions when the Zawrs extension is
  detected at boot.

Thanks,
drew

