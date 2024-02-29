Return-Path: <linux-kernel+bounces-87337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E502B86D300
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FB01C212B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7A1384A8;
	Thu, 29 Feb 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HJW26cTx"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062D4AEFF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234596; cv=none; b=lcqKN26BMbJRGNJTFWw8etCTdxyj6zhRvIGMQQOzZP/3u9XVUdZRqF+GxJu/OYJ30TtOx+Qww3nFktQsY4DzvJayic1hirG7dEbhfGH1aWipX4MOAp4BqMEF3Ya+EsjlkW7ubxfWDXoVjzn4+6LARdKT/pztrkRT/hUAYAHgzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234596; c=relaxed/simple;
	bh=z9PH2/uwk4sWiGx2l7EKQKD5JbhJYghtlwS00+tQjpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD15qisuP8c2FmqvB8ObOvtNotIs30mXhVE/IkEoaYD9QquCKn3bPmfA6OqtD+Zz+HyaDLXI270fYRtKiADkiCuTEGI2Wh3vgAkl2kNKHyOfY/0ks5uDjAcz0x4hetLNQ3cRIhusSKCvefeGUbqb+KRgrad7t9DqqAmsi9Ktjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HJW26cTx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc29f1956cso11629215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709234593; x=1709839393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tuk7a+vKCe6RTEYqyB1hLiNO0I5Nq8cXBO1DhIdc6iw=;
        b=HJW26cTxyRWncji+zM+/4iLSyChBD7nCjSXQ0FbxlchGb+45Xm7eI5liePu2NvnQyF
         yd0rEf8HhaE/mBNlRHu61OacEwTVc5fR25Xg6Fy3ieGN+HhuOZnwHR5GFhz7StRXIOqU
         7mqD/gFS++QEoFyTWumQqZctDzfF+B61UKD5CbO+hK1b/qtvw5HKgmEGa4B3CgvpmimZ
         oopxh8rAPDQ+54mACGmZBcxQcW0Uzr3ZLiKawgLYAmJJ+7RHSPhExOjQKuTNWY8SCq8a
         TlMAv2QO950ctJAW7gjDNlerMNSyZrfDjfdSAwykUqM3zDx3NzR/NmpJNFyVRH+cbvA1
         LrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234593; x=1709839393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tuk7a+vKCe6RTEYqyB1hLiNO0I5Nq8cXBO1DhIdc6iw=;
        b=Xn4bdu7NIlsJCj7XV+jM0Q0LEovU1GI/Tw4gWCqkjoFLTiG/zVn9jIkPihKoeOR77l
         3GugDqCsp4K3knBNFS0jD7IhjNUQNdEE+FipWBYegZl983a8+7bos0fjtmX0HmhFpZID
         kv1yi389k+dsp7Fg0WDK3NNgKx9ux8fpoX9xM2IytvaOM+im4Y+rQDlO6ngJiz/Ysu9D
         O4MIJfEpNcP38O33kMI4D2oHiOe0Od0QGLQAK55+v92jUOW3BytdFheSFD4zz9Ss7/dn
         7LLoYnu6DKkOdlhJeSF5c/occ8wrwwvYrD0CM0oTf/Oq+j62ZZPuXBSuzxvtvSuBUV6Q
         0VFw==
X-Forwarded-Encrypted: i=1; AJvYcCVGjkNGKagPbuB8Rj08/jMTs8th5q9ToBbIe0kAYkCPWpEVN1ILdutPYP66HBNCxP46FW/ZYst+gtSZUTWLLUJ++7JQoG8uvzZxgyG4
X-Gm-Message-State: AOJu0YxTarsOSSeM1nAr+Y7H9LkSUxmUfRPLGLI+QIZdleODwHsTHjG9
	mZgPRJ9PXmnbyOledS6zJjgizjLL0pTrFR0/z3IqN78P2VsjWXZE7V2diJaBHMj4pwz3xfgK2Sh
	/Xa8=
X-Google-Smtp-Source: AGHT+IHUzPkndAgTV7P4u3begGmiBUm2ct/M7Ax0MCC20stQ6rwpWin83UXCLvAEaE3gIAiJUl43+Q==
X-Received: by 2002:a17:902:ce8e:b0:1dc:d4f9:fd1b with SMTP id f14-20020a170902ce8e00b001dcd4f9fd1bmr3924446plg.7.1709234593472;
        Thu, 29 Feb 2024 11:23:13 -0800 (PST)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001dcc09487e8sm1861463pla.50.2024.02.29.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:23:12 -0800 (PST)
Date: Thu, 29 Feb 2024 11:23:08 -0800
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
Message-ID: <ZeDZnIemm06yU4KF@ghost>
References: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
 <20240227-disable_misaligned_probe_config-v5-2-b6853846e27a@rivosinc.com>
 <20240229-company-taste-daa305961e3a@spud>
 <ZeDO4CVOi6q4u8Lt@ghost>
 <20240229-dolphin-pennant-eef41ce44043@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-dolphin-pennant-eef41ce44043@spud>

On Thu, Feb 29, 2024 at 06:49:33PM +0000, Conor Dooley wrote:
> On Thu, Feb 29, 2024 at 10:37:20AM -0800, Charlie Jenkins wrote:
> > On Thu, Feb 29, 2024 at 12:26:37PM +0000, Conor Dooley wrote:
> > > On Tue, Feb 27, 2024 at 03:13:14PM -0800, Charlie Jenkins wrote:
> > > 
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index bffbd869a068..ad0a9c1f8802 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -690,25 +690,58 @@ config THREAD_SIZE_ORDER
> > > >  config RISCV_MISALIGNED
> > > >  	bool "Support misaligned load/store traps for kernel and userspace"
> > > >  	select SYSCTL_ARCH_UNALIGN_ALLOW
> > > > +	depends on RISCV_PROBE_UNALIGNED_ACCESS || RISCV_EMULATED_UNALIGNED_ACCESS
> > > >  	default y
> > > >  	help
> > > >  	  Say Y here if you want the kernel to embed support for misaligned
> > > >  	  load/store for both kernel and userspace. When disable, misaligned
> > > >  	  accesses will generate SIGBUS in userspace and panic in kernel.
> > > >  
> > > > +choice
> > > > +	prompt "Unaligned Accesses Support"
> > > > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > > > +	help
> > > > +	  This selects the hardware support for unaligned accesses. This
> > > > +	  information is used by the kernel to perform optimizations. It is also
> > > > +	  exposed to user space via the hwprobe syscall. The hardware will be
> > > > +	  probed at boot by default.
> > > > +
> > > > +config RISCV_PROBE_UNALIGNED_ACCESS
> > > > +	bool "Probe for hardware unaligned access support"
> > > > +	help
> > > > +	  During boot, the kernel will run a series of tests to determine the
> > > > +	  speed of unaligned accesses. This probing will dynamically determine
> > > > +	  the speed of unaligned accesses on the boot hardware.
> > > > +
> > > > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > > > +	bool "Assume the system expects emulated unaligned memory accesses"
> > > > +	help
> > > > +	  Assume that the system expects emulated unaligned memory accesses.
> > > > +	  When enabled, this option notifies the kernel and userspace that
> > > > +	  unaligned memory accesses will be emulated by either the kernel or
> > > > +	  firmware.
> > > > +
> > > > +config RISCV_SLOW_UNALIGNED_ACCESS
> > > > +	bool "Assume the system supports slow unaligned memory accesses"
> > > > +	depends on NONPORTABLE
> > > > +	help
> > > > +	  Assume that the system supports slow unaligned memory accesses. The
> > > > +	  kernel may not be able to run at all on systems that do not support
> > > > +	  unaligned memory accesses.
> > > > +
> > > >  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > > > -	bool "Assume the CPU supports fast unaligned memory accesses"
> > > > +	bool "Assume the system supports fast unaligned memory accesses"
> > > >  	depends on NONPORTABLE
> > > >  	select DCACHE_WORD_ACCESS if MMU
> > > >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > >  	help
> > > > -	  Say Y here if you want the kernel to assume that the CPU supports
> > > > -	  efficient unaligned memory accesses.  When enabled, this option
> > > > -	  improves the performance of the kernel on such CPUs.  However, the
> > > > -	  kernel will run much more slowly, or will not be able to run at all,
> > > > -	  on CPUs that do not support efficient unaligned memory accesses.
> > > > +	  Assume that the system supports fast unaligned memory accesses. When
> > > > +	  enabled, this option improves the performance of the kernel on such
> > > > +	  systems.  However, the kernel will run much more slowly, or will not
> > > > +	  be able to run at all, on systems that do not support efficient
> > > > +	  unaligned memory accesses.
> > > >  
> > > > -	  If unsure what to do here, say N.
> > > > +endchoice
> > > 
> > > Thinking about this some more, you've got 6 different options here:
> > > 
> > > 1 probed with no emulation available (choice set to probe + RISCV_MISALIGNED=n)
> > > 2 probe with in-kernel emulation available (choice set to probe + RISCV_MISALIGNED=y)
> > > 3 in-kernel emulation only (choice set to emulated + RISCV_MISALIGNED=y)
> > > 4 no in-kernel emulation but report emulated (choice set to emulated + RISCV_MISALIGNED=n)
> > > 5 slow unaligned (choice set to slow)
> > > 6 fast unaligned (choice set to fast)
> > > 
> > > Out of these, only 2 and 3 are portable options, since 1, 4 and 5 will
> > > cause uabi issues if the CPUs or firmware does not support unaligned
> > > access & 6 will not run in the same circumstances.
> > > 
> > > My first thought here was about the motivation for the patch and what it
> > > has resulted in. Being able to support HAVE_EFFICIENT_ALIGNED_ACCESS is
> > > pretty nice, but it then seems like beyond that we are introducing
> > > configuration for configurations sake, without looking at what the
> > > resultant kernels will be useful for. Having 6 different options for how
> > > the kernel can be configured in this way seems excessive and I don't
> > > really get why some of them are even useful.
> > > 
> > > Take for example situation 4. Unless I have misunderstood the Kconfig
> > > options above, if you configure a kernel in that way, it will always
> > > report as emulated, but there is no emulation provided. This just seems
> > > like a option that's only purpose is setting a hwprobe value, which is
> > > a dog wagging the tail situation to me.
> > 
> > This goes back to my earlier comment that it would make sense for
> > somebody to select "emulated" even if the unaligned address is being
> > emulated by firmware. However, there may be no users for this and if
> > needed we can add that in the future.
> 
> I don't think that is going to provide any useful information, give you
> will never be able to know if slow means "slow but done by the cpu" or
> "slow but emulated by the firmware".

Okay makes sense. If somebody has a usecase in the future it would be
easy to change without breaking any UABI.

> 
> > > The other thing is about what options are actually marked as
> > > NONPORTABLE, given it is done in the choice option - but whether or not
> > > something is actually non-portable actually depends on whether or not
> > > the in-kernel emulator exists.
> > > 
> > > I think what I would do here is simplify this quite a bit, starting by
> > > making RISCV_MISALIGNED an internal option that users cannot enable but
> > > is selected by the PORTABLE choice options. I would then re-work the
> > > choice options a bit. My 4 would be:
> > > 
> > > 1 probe: probe at boot time, falling back to emulated if not performant
> > > 2 emulated: always emulate it in the kernel
> > > 3 slow: don't probe or emulate in the kernel
> > > 4 fast: Your current fast option
> > 
> > Emulated doesn't mean that the kernel will always emulate the unaligned
> > accesses. It means that the kernel has the ability to emulate them. It
> > will only emulate them if the CPU traps on unaligned accesses. Kernel
> > code can choose to forcefully align an address it thinks may cause an
> > unaligned access, but that's slightly different from emulated.
> 
> Sure, make option 2 "don't probe at boot time, emulate it in the kernel
> if we trap". I suppose in this case though, to get a correct output in
> hwprobe you'd have to still attempt an unaligned access at boot time to
> see if you trap but it will not perform the speed test?

Are you trying to cover the case here that the kernel is compiled as
"emulate unaligned accesses" but the kernel isn't actually needed to
emulate unaligned accesses? Seems like if the kernel is compiled as
such it would make sense to report emulated with the assumption that if
the kernel isn't emulating it, something else is.

> 
> > Emulated is much slower than "slow", so it seems like it unfairly
> > penalizes "slow" to group the options for firmware emulated with a CPU
> > that actually just does slow unaligned accesses.
> 
> As I said in my previous email, "slow" has a huge variance and may not
> be meaningfully faster. I wonder if it might actually even be slower on
> some systems that emulate it in firmware?

I have no real data and can only speculate. Your 4 options seem to cover
all of the "meaningful" use cases so I can make the change in a new
version.

- Charlie

> 
> > > 1 & 2 select RISCV_UNALIGNED and are portable because they contain the
> > > emulated support and thus satisfy the UABI constaints.
> > > 3 & 4 are marked NONPORTABLE. I think 3 will run on systems that don't
> > > support unaligned accesses but it will have UABI problems. 4 for the
> > > reason mentioned in the Kconfig option above.
> > > 
> > > I think that that gives you 4 meaningful options, what do you think?
> 



