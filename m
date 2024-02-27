Return-Path: <linux-kernel+bounces-83913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D5586A008
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2C2284066
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E78251C47;
	Tue, 27 Feb 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TnNZf/fV"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C392E51C45
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061607; cv=none; b=a5unOyFJWKyBvMRAjzQCumtb7hMrA/leNtnXHMn/FI7aWAYRs1vBC625qAn3GIVAb00zJLWJOD2Dv3wYYGaa+OrtUCqGwLWlsWn+MHvSJG5D+rFGQR/qkDj4i9ekAGKkXeTyKRE2f16ghpjsHuXCFZSzF81xUkQ3DiB834Xvmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061607; c=relaxed/simple;
	bh=yEsKdJX+K7BkS3jD4MYdvy9KUq9/S1FUTqeOm3Nqg/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqkerkYP5fzXrYKofkynjDdibJ48nd+O3+wSSilb3e+wIoB9OB7FQZTIyoPfEDuQmFZ6vj2lNFZU7yqpYiMGUFYKOaYz+KcQ1VqSOU6XAyQwKFB3FumBK2Al8qQEYccmds0ryHqUFWFeLY+TnyL2Kk0/ijOnF1xShuLSIPFpREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TnNZf/fV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e55101cc56so607897b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709061605; x=1709666405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjU6LlOMoMfkxYT5TjTMLLN7YZEywYOA9lg639yTU1E=;
        b=TnNZf/fVeY9ZJEmpf98GCXalF6EdoHBNHJsMiO5FKBhCTVvVWwiye5naF5JyRHlaUE
         4JDEGmeQE4aN+sO1XqD8qoll8FWNsKLOmhclp43xUKq2CCDyG4LgeuQJ9m0yfvubPyPz
         +wGSK2x5nNv8EWnQQqKY7IS/DC01vn5y2wbPQPFYkR0R/wD6B0AqMY3Tk+xdKjhei1co
         uN0tKgiEvdQ/mLGGN21MtFoPvQbnFTZUO6GqfOLMrser7rkFhezLvN2CY55DoLwQW7Ty
         uj+TVzlawoS0xeqnZR2HAvt100d/dq0CjL5SCTsiY59o8L+X+XeCUj4zYuYXXKElhv+H
         s+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061605; x=1709666405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjU6LlOMoMfkxYT5TjTMLLN7YZEywYOA9lg639yTU1E=;
        b=S9BVMbq9un6EX4kM86uUB+21lhgBkCn2nEz88LyVPazA1szJBub0N5Cyb6gU7HrgJ7
         qIszlqibhfMBh/PqbY8wijjpvTIHUWSAedlqgcDyvHnUUp5Td3/BaTaYpSWLfKeliZsq
         0VI0g36Y3tx8HOn0rtbSMwEbGOHm+wJLxfFSE96KTjK4MyRYRV665mZGLOkolo+uQSaP
         4n5h2Vyt744JtigHxpNGn8coOrrZ1jJvKeqcqrJQVjNrPFqHX731jL7TJ7Hg0I9FwMUO
         Oa43i76JbjmJWvbkJMWXXeui/okGYDzBlhC6iemcWIcCpJ/BToItxwzo3KJyddT5gQoz
         A1bw==
X-Forwarded-Encrypted: i=1; AJvYcCX5ZEo2RwRhdVeLE27GDfHsd465P/Ld7FML3J2zaNtyugvEWd5CY4QmjFbLX5xZ6BUskUs3vxfSgdT01KkzGRun0kXIJzwfwj8v6e0P
X-Gm-Message-State: AOJu0YzB+8h9sHno5wb1OD5E0mG24Hz6yPcsACDMHuA/RRGuvzsP5Vwf
	C3dO5ZBbTc6YFQNxJbZ2PZJY/tFGKSQNGp7yg+AYS4OiZldVaf2ncEDJQevNY1I=
X-Google-Smtp-Source: AGHT+IGTsFO5Y+MUw+Dr+fwRnhGBCvict5u69UQFPCgZkAlJCy5uDoFE3U+pMRfAan3Q8Hi9tDNlUw==
X-Received: by 2002:a05:6a20:d706:b0:1a0:f7d0:e652 with SMTP id iz6-20020a056a20d70600b001a0f7d0e652mr3323640pzb.49.1709061605039;
        Tue, 27 Feb 2024 11:20:05 -0800 (PST)
Received: from ghost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id k25-20020a635619000000b005bdbe9a597fsm6128331pgb.57.2024.02.27.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:20:04 -0800 (PST)
Date: Tue, 27 Feb 2024 11:20:02 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>, Evan Green <evan@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, Charles Lohr <lohr85@gmail.com>
Subject: Re: [PATCH v4 2/2] riscv: Set unalignment speed at compile time
Message-ID: <Zd414nBtjHcsYWnL@ghost>
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
 <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>
 <20240227-condone-impeach-9469dffc6b47@wendy>
 <Zd4nMa+x28omuhiF@ghost>
 <20240227-citable-scanning-1fd48c96b758@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-citable-scanning-1fd48c96b758@spud>

On Tue, Feb 27, 2024 at 06:48:54PM +0000, Conor Dooley wrote:
> On Tue, Feb 27, 2024 at 10:17:21AM -0800, Charlie Jenkins wrote:
> > On Tue, Feb 27, 2024 at 11:39:25AM +0000, Conor Dooley wrote:
> > > On Fri, Feb 16, 2024 at 12:33:19PM -0800, Charlie Jenkins wrote:
> 
> > > > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > > > +	bool "Assume the CPU expects emulated unaligned memory accesses"
> > > > +	depends on NONPORTABLE
> > > 
> > > This is portable too, right?
> > 
> > I guess so? I think I would prefer to have the probing being the only
> > portable option.
> 
> I dunno, I think there could be value to someone in always emulating
> this in the kernel and I don't think that should relegate them to the
> naughty step, given it can work everywhere.

Alright, I will remove the nonportable.

> 
> 
> > > > +config RISCV_SLOW_UNALIGNED_ACCESS
> > > > +	bool "Assume the CPU supports slow unaligned memory accesses"
> > > > +	depends on NONPORTABLE
> > > > +	help
> > > > +	  Assume that the CPU supports slow unaligned memory accesses. When
> > > > +	  enabled, this option improves the performance of the kernel on such
> > > > +	  CPUs.
> > > 
> > > Does it? Are you sure that generating unaligned accesses on systems
> > > where they are slow is a performance increase?
> > > That said, I don't really see this option actually doing anything other
> > > than setting the value for hwprobe, so I don't actually know what the
> > > effect of this option actually is on the kernel's performance.
> > > 
> > > Generally I would like to suggest a change from "CPU" to "system" here,
> > > since the slow cases that exist are mostly because the unaligned access
> > > is actually emulated in firmware.
> > 
> > It would be ideal if "emulated" was used for any case of emulated
> > accesses (firmware or in the kernel).  Doing emulated accesses will be
> > orders of magnitude slower than a processor that "slowly" handles the
> > accesses.
> > 
> > So even if the processor performs a "slow" access, it could still be
> > beneficial for the kernel to do the misaligned access rather than manual
> > do the alignment.
> 
> Right. But, at least from a probing perspective, SLOW is what gets
> selected when firmware emulates the unaligned access so to userspace
> seeing slow means that the performance could be horrifically bad:
> 
> |     rzfive:
> |         cpu0: Ratio of byte access time to unaligned word access is
> | 1.05, unaligned accesses are fast
> | 
> |     icicle:
> | 
> |         cpu1: Ratio of byte access time to unaligned word access is
> | 0.00, unaligned accesses are slow
> |         cpu2: Ratio of byte access time to unaligned word access is
> | 0.00, unaligned accesses are slow
> |         cpu3: Ratio of byte access time to unaligned word access is
> | 0.00, unaligned accesses are slow
> | 
> |         cpu0: Ratio of byte access time to unaligned word access is
> | 0.00, unaligned accesses are slow
> | 
> |     k210:
> | 
> |         cpu1: Ratio of byte access time to unaligned word access is
> | 0.02, unaligned accesses are slow
> |         cpu0: Ratio of byte access time to unaligned word access is
> | 0.02, unaligned accesses are slow
> | 
> |     starlight:
> | 
> |         cpu1: Ratio of byte access time to unaligned word access is
> | 0.01, unaligned accesses are slow
> |         cpu0: Ratio of byte access time to unaligned word access is
> | 0.02, unaligned accesses are slow
> | 
> |     vexriscv/orangecrab:
> | 
> |         cpu0: Ratio of byte access time to unaligned word access is
> | 0.00, unaligned accesses are slow
>  https://lore.kernel.org/all/CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com/

If the accesses are horrifically slow then maybe they should be flagged
as emulated rather than slow by the probe.

> 
> > Currently there is no place that takes into account this "slow" option
> > but I wanted to leave it open for future optimizations.
> 
> I don't think you can really do much optimisation if you detect that it
> is slow, and since this option is analogous to detecting slow I dunno if
> you can do anything here either? This option really just seems to me to
> mean "don't do any optimisations for unaligned being fast but also don't
> emulate it in the kernel".

I am fine with that being the meaning of this option. However, on a
system that has misaligned accesses that are twice as slow as correctly
aligned accesses, the misaligned accesses would reasonably be selected
as "slow". However, something like the checksum functions would still
probably want to do the misaligned accesses because performing the
alignment would be even slower. This is all hypothetical and not a
"real" use case so maybe I am optimizing where no optimization is
needed.

> 
> > > > However, the kernel will run much more slowly, or will not be
> > > > +	  able to run at all, on CPUs that do not support unaligned memory
> > > > +	  accesses.
> > > > +
> > > >  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > > >  	bool "Assume the CPU supports fast unaligned memory accesses"
> > > >  	depends on NONPORTABLE
> > > >  	select DCACHE_WORD_ACCESS if MMU
> > > >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > >  	help
> > > > -	  Say Y here if you want the kernel to assume that the CPU supports
> > > > -	  efficient unaligned memory accesses.  When enabled, this option
> > > > -	  improves the performance of the kernel on such CPUs.  However, the
> > > > -	  kernel will run much more slowly, or will not be able to run at all,
> > > > -	  on CPUs that do not support efficient unaligned memory accesses.
> > > > +	  Assume that the CPU supports fast unaligned memory accesses. When
> > > > +	  enabled, this option improves the performance of the kernel on such
> > > > +	  CPUs.  However, the kernel will run much more slowly, or will not be
> > > > +	  able to run at all, on CPUs that do not support efficient unaligned
> > > > +	  memory accesses.
> > > > +
> > > > +config RISCV_UNSUPPORTED_UNALIGNED_ACCESS
> > > 
> > > This option needs to be removed. The uabi states that unaligned access
> > > is supported in userspace, if the cpu or firmware does not implement
> > > unaligned access then the kernel must emulate it.
> > 
> > Should it removed from hwprobe as well then?
> 
> No, I actually suggested that it be documented etc. Originally
> "UNSUPPORTED" was "UNKNOWN" and nothing more than the default value but
> I suggested that it be documented since that would allow a system that
> did not have the same uabi problem to use all the same defines.
> Technically it is possible for unaligned access to be unsupported, if
> you have a kernel that does not have the emulator but does have the
> hwprobe stuff supported. I think there was about a 6 month period where
> this was the case, so combine that with firmware that does not do the
> emulation and unaligned accesses are unsupported.

Sounds great, will remove :)

- Charlie

> 
> Cheers,
> Conor.



