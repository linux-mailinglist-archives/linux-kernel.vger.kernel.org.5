Return-Path: <linux-kernel+bounces-83860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B007D869F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650D0283F61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55E50A73;
	Tue, 27 Feb 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZADZZWsc"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F614F896
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059759; cv=none; b=luJVHeLH1zphXGJU6vPfWekSuz+dytHLQFW9WNGG6IPduTE9Y7Py+4VMPTljKRm05I5RUMioaAbzsBZSqjdITH4VjSGcRsVcF3ZIjQg3nKyn593eezwbkLOcDCdLYbp5zAfEM1kse8RSSSi8BNtvUZRHCVrRv/iHqORdQ1fx17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059759; c=relaxed/simple;
	bh=Wskn9MnZrYrzXjLH65blgzx/lnGt7j6wJWlwXZRwF2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmV0mi9TFmeIXMJRyhZ5Nsvd7937UAmGN8rOvQu2lykn+KALcWkRJYBOxT7Qy6NQf1oaAUFsOzTO6tmYh11kCWu7GuJUoOSNZ+dGN3L6lLTEHudEhv5NCBdrLv7Ds79jgZKTApcWIDJfiGktMTyVXuxwcBkmWSXmI0UhbqQ1i+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZADZZWsc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso5683094e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709059756; x=1709664556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDjOQKI5OUPcR0csLb2CoPXgDI3ZkfKtFyr9oAeRrX0=;
        b=ZADZZWscfZFEf6SZBpfr+kTeFheMk1GsdD5ZcpkWdMYNyED5IxJEL8ymSvcm1rWu5R
         rUmNDCzLR25LFDvfxL3y1qHiqv/xr75e1TBv+IcDLm7QXFImrOfQYgw5ocL6OxcGtMjT
         eEuNCiXvzxiYHZD+2JBUu9eZqZ9iw1XYm1JsP8E2Cofzc1RbOkv/TV51JjyGixGDSrFv
         rs1HBPwu0Y3aEA0LXKUgTi8XgHrJJiOAWoaoyCYbcEz9KfIx7sDkfs7wDDb9bV5vM0Ub
         XzRP7KmMY2yrUlBzS7t2Orzp91pJPqgqndyKIgrW1g1NbKHgbX3rYIjj12xgO7BuaIC8
         M67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709059756; x=1709664556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDjOQKI5OUPcR0csLb2CoPXgDI3ZkfKtFyr9oAeRrX0=;
        b=YR0xuNDRO0suyor02gUxnqY2KlE3KPQ3iF2/R13ds/qY94SCfhlES6t0hC83kDvX4h
         vGHZrT/yOxVC0D1gAzM98mJhm/J3mx3OZpCJoztVhgB+ut3dv4fvxGxnKu+Md3max6HX
         LrtaAr+qfbgw5c7B5ErKUHmJwjLcFFEGHh5pV1OWeYjfm4rMmV7KFiKBWADOtbNd7f4M
         wyVDc9anL5/OoCMtwDQG1AwvWaDcVZUDt6ZZf2DOtGOTCk8NQexdcurDf+AePTryAF2n
         +4vgWDUS6aY4g1kbcsUxxRSRDSMjtzHozudxUkYVMSnO9GhfI4NHmVQHcAQXQHvMhoDk
         FA5w==
X-Forwarded-Encrypted: i=1; AJvYcCVhyaHuHTEm68dbOeTDExtCV9RjvadOmUkt/qn1DQSgagosZcveslQvVbGp+aiW+is+qIaylHITLDisgi2Z1RD9H41nv82MqEqdsahG
X-Gm-Message-State: AOJu0YwXVDmzYO7VhDs1IxDotYOId8z0GKDYAWFWaTztoiYZJrgjdikc
	nAKTROObFyVgxY5aR8mSvwb9nMD7aO2fC1NyJ3C+mqydumjgUOby7N9AbgnBup9MUfBBTs/o0H0
	svhu/kvluweAIXa71di6kNjRmsyojWcK0skp83g==
X-Google-Smtp-Source: AGHT+IGhoAGg3KXVeQLuKpSIzH4loVOc3iAMsXp0MlWz1G0OVJXs9DIjcf6Dbc7pioXt/CUX2vIvELHtTdxxrq1jps4=
X-Received: by 2002:a19:7619:0:b0:512:d907:3161 with SMTP id
 c25-20020a197619000000b00512d9073161mr6510496lff.66.1709059755729; Tue, 27
 Feb 2024 10:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
 <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>
 <20240227-condone-impeach-9469dffc6b47@wendy> <Zd4nMa+x28omuhiF@ghost>
In-Reply-To: <Zd4nMa+x28omuhiF@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Tue, 27 Feb 2024 10:48:39 -0800
Message-ID: <CALs-HstdXnRZUaYxHF-a4e+A6-X30RFWP7PKu-6rKBMUVUxs0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] riscv: Set unalignment speed at compile time
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Eric Biggers <ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Charles Lohr <lohr85@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:17=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Tue, Feb 27, 2024 at 11:39:25AM +0000, Conor Dooley wrote:
> > On Fri, Feb 16, 2024 at 12:33:19PM -0800, Charlie Jenkins wrote:
> > > Introduce Kconfig options to set the kernel unaligned access support.
> > > These options provide a non-portable alternative to the runtime
> > > unaligned access probe.
> > >
> > > To support this, the unaligned access probing code is moved into it's
> > > own file and gated behind a new RISCV_PROBE_UNALIGNED_ACCESS_SUPPORT
> > > option.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/Kconfig                          |  58 +++++-
> > >  arch/riscv/include/asm/cpufeature.h         |  30 +++-
> > >  arch/riscv/kernel/Makefile                  |   6 +-
> > >  arch/riscv/kernel/cpufeature.c              | 255 ------------------=
--------
> > >  arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++=
++++++++++
> > >  arch/riscv/kernel/probe_emulated_access.c   |  64 +++++++
> > >  arch/riscv/kernel/sys_hwprobe.c             |  25 +++
> > >  arch/riscv/kernel/traps_misaligned.c        |  54 +-----
> > >  8 files changed, 442 insertions(+), 315 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index bffbd869a068..3cf700adc43b 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -690,25 +690,71 @@ config THREAD_SIZE_ORDER
> > >  config RISCV_MISALIGNED
> >
> >
> > Why can we not make up our minds on what to call this? The majority of
> > users are "unaligned" but the file you add and this config option are
> > "misaligned."
>
> We have both everywhere, maybe we (I?) should go in and standardize the
> wording everywhere. I personally prefer "misaligned" which means
> "incorrectly aligned" over "unaligned" which means "not aligned" because
> a 7-bit alignment is still "aligned" along a 7-bit boundary, but it is
> certainly incorrectly aligned.
>
> >
> > >     bool "Support misaligned load/store traps for kernel and userspac=
e"
> > >     select SYSCTL_ARCH_UNALIGN_ALLOW
> > > +   depends on RISCV_PROBE_UNALIGNED_ACCESS || RISCV_EMULATED_UNALIGN=
ED_ACCESS
> > >     default y
> > >     help
> > >       Say Y here if you want the kernel to embed support for misalign=
ed
> > >       load/store for both kernel and userspace. When disable, misalig=
ned
> > >       accesses will generate SIGBUS in userspace and panic in kernel.
> > >
> > > +choice
> > > +   prompt "Unaligned Accesses Support"
> > > +   default RISCV_PROBE_UNALIGNED_ACCESS
> > > +   help
> > > +     This selects the hardware support for unaligned accesses. This
> > > +     information is used by the kernel to perform optimizations. It =
is also
> > > +     exposed to user space via the hwprobe syscall. The hardware wil=
l be
> > > +     probed at boot by default.
> > > +
> > > +config RISCV_PROBE_UNALIGNED_ACCESS
> > > +   bool "Probe for hardware unaligned access support"
> > > +   help
> > > +     During boot, the kernel will run a series of tests to determine=
 the
> > > +     speed of unaligned accesses. This is the only portable option. =
This
> > > +     probing will dynamically determine the speed of unaligned acces=
ses on
> > > +     the boot hardware.
> > > +
> > > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > > +   bool "Assume the CPU expects emulated unaligned memory accesses"
> > > +   depends on NONPORTABLE
> >
> > This is portable too, right?
>
> I guess so? I think I would prefer to have the probing being the only
> portable option.
>
> >
> > > +   select RISCV_MISALIGNED
> > > +   help
> > > +     Assume that the CPU expects emulated unaligned memory accesses.
> > > +     When enabled, this option notifies the kernel and userspace tha=
t
> > > +     unaligned memory accesses will be emulated by the kernel.
> >
> > > To enforce
> > > +     this expectation, RISCV_MISALIGNED is selected by this option.
> >
> > Drop this IMO, let Kconfig handle displaying the dependencies.
> >
>
> I was debating if Kconfig handling was enough, so I am glad it is, I
> will remove this.
>
> > > +
> > > +config RISCV_SLOW_UNALIGNED_ACCESS
> > > +   bool "Assume the CPU supports slow unaligned memory accesses"
> > > +   depends on NONPORTABLE
> > > +   help
> > > +     Assume that the CPU supports slow unaligned memory accesses. Wh=
en
> > > +     enabled, this option improves the performance of the kernel on =
such
> > > +     CPUs.
> >
> > Does it? Are you sure that generating unaligned accesses on systems
> > where they are slow is a performance increase?
> > That said, I don't really see this option actually doing anything other
> > than setting the value for hwprobe, so I don't actually know what the
> > effect of this option actually is on the kernel's performance.
> >
> > Generally I would like to suggest a change from "CPU" to "system" here,
> > since the slow cases that exist are mostly because the unaligned access
> > is actually emulated in firmware.
>
> It would be ideal if "emulated" was used for any case of emulated
> accesses (firmware or in the kernel).  Doing emulated accesses will be
> orders of magnitude slower than a processor that "slowly" handles the
> accesses.
>
> So even if the processor performs a "slow" access, it could still be
> beneficial for the kernel to do the misaligned access rather than manual
> do the alignment.
>
> Currently there is no place that takes into account this "slow" option
> but I wanted to leave it open for future optimizations.
>
> >
> > > However, the kernel will run much more slowly, or will not be
> > > +     able to run at all, on CPUs that do not support unaligned memor=
y
> > > +     accesses.
> > > +
> > >  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > >     bool "Assume the CPU supports fast unaligned memory accesses"
> > >     depends on NONPORTABLE
> > >     select DCACHE_WORD_ACCESS if MMU
> > >     select HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >     help
> > > -     Say Y here if you want the kernel to assume that the CPU suppor=
ts
> > > -     efficient unaligned memory accesses.  When enabled, this option
> > > -     improves the performance of the kernel on such CPUs.  However, =
the
> > > -     kernel will run much more slowly, or will not be able to run at=
 all,
> > > -     on CPUs that do not support efficient unaligned memory accesses=
.
> > > +     Assume that the CPU supports fast unaligned memory accesses. Wh=
en
> > > +     enabled, this option improves the performance of the kernel on =
such
> > > +     CPUs.  However, the kernel will run much more slowly, or will n=
ot be
> > > +     able to run at all, on CPUs that do not support efficient unali=
gned
> > > +     memory accesses.
> > > +
> > > +config RISCV_UNSUPPORTED_UNALIGNED_ACCESS
> >
> > This option needs to be removed. The uabi states that unaligned access
> > is supported in userspace, if the cpu or firmware does not implement
> > unaligned access then the kernel must emulate it.
>
> Should it removed from hwprobe as well then?

We had added it as a hwprobe value in this discussion:
https://lore.kernel.org/lkml/Y+1VOXyKDDHEuejJ@spud/

Personally I like it as a possible hwprobe value, even if it is in
conflict with the uabi. I can't fully defend it, other than as a very
forward looking possibility, and as a nice value for people doing
weird things off the beaten path. My preference would be to keep it in
hwprobe, but I'm fine with not having a Kconfig for it.

-Evan

