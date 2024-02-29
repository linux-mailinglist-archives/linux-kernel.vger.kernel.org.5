Return-Path: <linux-kernel+bounces-87300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008786D26D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605A01C2265E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09D70AE4;
	Thu, 29 Feb 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Le9kEfzb"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C479F1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231847; cv=none; b=GxPxvuvG95fr08zreP+u2pJapica53gQcIxe9Elxy7IcUrTeNPyifeltPpT2MJ4ZsXzj5fFrAup5BmaEyO65ZC93K4NTmE1TuGX5lxKWs3rLghHSFuU/NVtwJeZzo7oMRw3+pjiCIbwyqvLZVhnWt+kTAEr/cZ8FlvyiIBDgFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231847; c=relaxed/simple;
	bh=Ux3FswKlCw14tBuSmwuKQ+NEkYX9d2zLS/mv+GpKMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEXV1Ygb/B8XhsL/zqez8IwDzL43KnyxWj9/K7hpLBvRCNi/qw6MLgy9wwnvKP/q0sRYnz5sDxzo05eXpD//WEDyO5oA2tL5vnxo+epo/u/M/ohWVIzJrWzSzLiQiwhKNzoT6/dFvMeykbTBbgMQENL/oIDZX17scHSeWSinN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Le9kEfzb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so779763a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709231843; x=1709836643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3onkurgGwZnEhJcVtKriZJa3VO4hJPZAGQWDNhD7hV4=;
        b=Le9kEfzbjI/QDloZYdLk9+49Vhy44/plGXfzSneIyTi7ixFI1ksIlV2C0mvpJENgyU
         nSLfNXaSNGCdQaPFhzhPDTcU3+MXxsSKrhVh6n5GruRiw5DU6Na1pXAcCeQqz3/TAO3L
         VDD1cKAoTfF6ZO2tVFT9VUjyh9kBOwWHx2vcnCKKg5QNQx6b0TWPbRszQyas70O9jIEc
         Mir8LZzPqCPTs+ViBP2Iax2XO9CJHN+FefFNsU9Npht1z4KFAlxcHwkXyySE6E+K+afG
         6NfBnZ8GdwVjqaWjR1tuWS1chw47psKrqVuFhr8J0O1B7NM4qp+NpoXzd/TVJOueOz3d
         zRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231843; x=1709836643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3onkurgGwZnEhJcVtKriZJa3VO4hJPZAGQWDNhD7hV4=;
        b=tm6TgqrYFF8x20la9a88fd2mCME7yxKEpHfihyD0a1xEom8a2FJcRWUY8qhL9nqtNC
         T6kN5gVZmeY2IegP6ovC1yEdUVYQZynswO7xD5b/rVOU1IYTXTR9U3aJoupti1Bpx8pc
         HVEQ7FhNQ6Jcd1ZcQGig9ojNgYz8tOPPTn1fU/xE+LxMVtrl3W/a4ZhCv1hokyw9zhog
         erdDbf9yAA1gFntluEetc3szaQ+X/XXUsY5uYH6yyAF2dSqt8d9yPV1hYsd8bP+Z7iqJ
         rUvExly3gkHUKJG+jE74DDK8Lw+5npn5gt4RsKXQ8kshviirbzLDdgINQHe4MPqQv57c
         d0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX//v4CIFuVf2DijQvTg93z1TTojo++XRagY1r9iOdyPG1BHgDW3qGwBOta5tcAq3sW5IjNIWFFAndlhKU/ze5b7nj6WGsJ8PyRIXi9
X-Gm-Message-State: AOJu0Yxi328MAOBxiGIWvcLquo7n5fn/XvhFDNTPPpBBMGEu8ocppyUz
	JLWXLgnXt8eokUnPJbfHNb/7vFv03gdLklXDuWR2y6R7gr8DN0lYl5GT9smb/1g=
X-Google-Smtp-Source: AGHT+IGtuJS3MAvI4gpblQCoq0hyZ+R7ZzCqp75P0VIfk7XRT7G+I1gfdyMZoSlwNPIXcLTNBCc84Q==
X-Received: by 2002:a17:90a:fa8e:b0:29a:9a57:f367 with SMTP id cu14-20020a17090afa8e00b0029a9a57f367mr3266565pjb.2.1709231843596;
        Thu, 29 Feb 2024 10:37:23 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:b8d8:9761:53ea:51ce])
        by smtp.gmail.com with ESMTPSA id sb3-20020a17090b50c300b00299db19a81asm3919157pjb.56.2024.02.29.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:37:22 -0800 (PST)
Date: Thu, 29 Feb 2024 10:37:20 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Charles Lohr <lohr85@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: Set unaligned access speed at compile time
Message-ID: <ZeDO4CVOi6q4u8Lt@ghost>
References: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
 <20240227-disable_misaligned_probe_config-v5-2-b6853846e27a@rivosinc.com>
 <20240229-company-taste-daa305961e3a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-company-taste-daa305961e3a@spud>

On Thu, Feb 29, 2024 at 12:26:37PM +0000, Conor Dooley wrote:
> On Tue, Feb 27, 2024 at 03:13:14PM -0800, Charlie Jenkins wrote:
> 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index bffbd869a068..ad0a9c1f8802 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -690,25 +690,58 @@ config THREAD_SIZE_ORDER
> >  config RISCV_MISALIGNED
> >  	bool "Support misaligned load/store traps for kernel and userspace"
> >  	select SYSCTL_ARCH_UNALIGN_ALLOW
> > +	depends on RISCV_PROBE_UNALIGNED_ACCESS || RISCV_EMULATED_UNALIGNED_ACCESS
> >  	default y
> >  	help
> >  	  Say Y here if you want the kernel to embed support for misaligned
> >  	  load/store for both kernel and userspace. When disable, misaligned
> >  	  accesses will generate SIGBUS in userspace and panic in kernel.
> >  
> > +choice
> > +	prompt "Unaligned Accesses Support"
> > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > +	help
> > +	  This selects the hardware support for unaligned accesses. This
> > +	  information is used by the kernel to perform optimizations. It is also
> > +	  exposed to user space via the hwprobe syscall. The hardware will be
> > +	  probed at boot by default.
> > +
> > +config RISCV_PROBE_UNALIGNED_ACCESS
> > +	bool "Probe for hardware unaligned access support"
> > +	help
> > +	  During boot, the kernel will run a series of tests to determine the
> > +	  speed of unaligned accesses. This probing will dynamically determine
> > +	  the speed of unaligned accesses on the boot hardware.
> > +
> > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > +	bool "Assume the system expects emulated unaligned memory accesses"
> > +	help
> > +	  Assume that the system expects emulated unaligned memory accesses.
> > +	  When enabled, this option notifies the kernel and userspace that
> > +	  unaligned memory accesses will be emulated by either the kernel or
> > +	  firmware.
> > +
> > +config RISCV_SLOW_UNALIGNED_ACCESS
> > +	bool "Assume the system supports slow unaligned memory accesses"
> > +	depends on NONPORTABLE
> > +	help
> > +	  Assume that the system supports slow unaligned memory accesses. The
> > +	  kernel may not be able to run at all on systems that do not support
> > +	  unaligned memory accesses.
> > +
> >  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > -	bool "Assume the CPU supports fast unaligned memory accesses"
> > +	bool "Assume the system supports fast unaligned memory accesses"
> >  	depends on NONPORTABLE
> >  	select DCACHE_WORD_ACCESS if MMU
> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> >  	help
> > -	  Say Y here if you want the kernel to assume that the CPU supports
> > -	  efficient unaligned memory accesses.  When enabled, this option
> > -	  improves the performance of the kernel on such CPUs.  However, the
> > -	  kernel will run much more slowly, or will not be able to run at all,
> > -	  on CPUs that do not support efficient unaligned memory accesses.
> > +	  Assume that the system supports fast unaligned memory accesses. When
> > +	  enabled, this option improves the performance of the kernel on such
> > +	  systems.  However, the kernel will run much more slowly, or will not
> > +	  be able to run at all, on systems that do not support efficient
> > +	  unaligned memory accesses.
> >  
> > -	  If unsure what to do here, say N.
> > +endchoice
> 
> Thinking about this some more, you've got 6 different options here:
> 
> 1 probed with no emulation available (choice set to probe + RISCV_MISALIGNED=n)
> 2 probe with in-kernel emulation available (choice set to probe + RISCV_MISALIGNED=y)
> 3 in-kernel emulation only (choice set to emulated + RISCV_MISALIGNED=y)
> 4 no in-kernel emulation but report emulated (choice set to emulated + RISCV_MISALIGNED=n)
> 5 slow unaligned (choice set to slow)
> 6 fast unaligned (choice set to fast)
> 
> Out of these, only 2 and 3 are portable options, since 1, 4 and 5 will
> cause uabi issues if the CPUs or firmware does not support unaligned
> access & 6 will not run in the same circumstances.
> 
> My first thought here was about the motivation for the patch and what it
> has resulted in. Being able to support HAVE_EFFICIENT_ALIGNED_ACCESS is
> pretty nice, but it then seems like beyond that we are introducing
> configuration for configurations sake, without looking at what the
> resultant kernels will be useful for. Having 6 different options for how
> the kernel can be configured in this way seems excessive and I don't
> really get why some of them are even useful.
> 
> Take for example situation 4. Unless I have misunderstood the Kconfig
> options above, if you configure a kernel in that way, it will always
> report as emulated, but there is no emulation provided. This just seems
> like a option that's only purpose is setting a hwprobe value, which is
> a dog wagging the tail situation to me.

This goes back to my earlier comment that it would make sense for
somebody to select "emulated" even if the unaligned address is being
emulated by firmware. However, there may be no users for this and if
needed we can add that in the future.

> 
> The other thing is about what options are actually marked as
> NONPORTABLE, given it is done in the choice option - but whether or not
> something is actually non-portable actually depends on whether or not
> the in-kernel emulator exists.
> 
> I think what I would do here is simplify this quite a bit, starting by
> making RISCV_MISALIGNED an internal option that users cannot enable but
> is selected by the PORTABLE choice options. I would then re-work the
> choice options a bit. My 4 would be:
> 
> 1 probe: probe at boot time, falling back to emulated if not performant
> 2 emulated: always emulate it in the kernel
> 3 slow: don't probe or emulate in the kernel
> 4 fast: Your current fast option

Emulated doesn't mean that the kernel will always emulate the unaligned
accesses. It means that the kernel has the ability to emulate them. It
will only emulate them if the CPU traps on unaligned accesses. Kernel
code can choose to forcefully align an address it thinks may cause an
unaligned access, but that's slightly different from emulated.

Emulated is much slower than "slow", so it seems like it unfairly
penalizes "slow" to group the options for firmware emulated with a CPU
that actually just does slow unaligned accesses.

- Charlie

> 
> 1 & 2 select RISCV_UNALIGNED and are portable because they contain the
> emulated support and thus satisfy the UABI constaints.
> 3 & 4 are marked NONPORTABLE. I think 3 will run on systems that don't
> support unaligned accesses but it will have UABI problems. 4 for the
> reason mentioned in the Kconfig option above.
> 
> I think that that gives you 4 meaningful options, what do you think?
> 
> Cheers,
> Conor.



