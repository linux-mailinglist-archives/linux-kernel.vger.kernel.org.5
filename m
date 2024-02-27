Return-Path: <linux-kernel+bounces-83947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F68486A06E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1500B1F28F56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1113AA27;
	Tue, 27 Feb 2024 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FqJ5oBE/"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA54F896
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063111; cv=none; b=C0jUF+llqDg6TUFEw9kw4hst5MFQQLDdq9qt0TpKn2u+GBlrxCjiWxzvqq2S6+MPSariZ5ctuQWT8F/LGZWYV2pex+kmLykUuF+09B2J8+hbyojNBGh2/uHNNqgjYwA4h9CLo0NJblDnF2FBYSpW+JaK+8AnrnCE31mDXa6iHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063111; c=relaxed/simple;
	bh=EZbfYJ747wWftifCZazkKvuK2WvhkmdBgzvxlwncvSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdncmQVvXwoUh8nKyJH8wYV7BOcpIdJRxk6q2ZsIyJPghxP+SnTlGB/E8jZlUwCJLAdaiZ8tJJsUezfVqD9bQGw4CV9Tv+FN7GRoHG2MLT9oX/5+7M7Li39waJS5u/ATt+QaSHPp4d4Xw34xlAJbPdt17SWhJ1194j/YaaO47+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FqJ5oBE/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512b700c8ebso5853239e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709063107; x=1709667907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzyPyl18HcItr2oh7QJ73KXzsNopBuzQaSIWsMutKKQ=;
        b=FqJ5oBE/ijyYzjk0whLArkgi3XWdnJfkl45ii39DDDRZ2IHQyG6VmJTVDHU0WcWNud
         HZK9lGgymQF5VDz2mUfNnZD5eXIya7s5z6/ft+m9yFVPmy5slkKEeJfopYKfMOYqbg38
         78YNQYljzEyWvdrljGPazTbv9QKeQRVVq9STZn1d9KSMQ5Yd2vFRW4KaUWi/P065csZm
         DoyCECKKya1DgfImkdQ2PA0SeSNjkLH703eokmAckteGKJ5syagFA6Oj7RIAm1TRKUcV
         gSw3ziBQQ/5AlbiNZgqCGCK7mHSC/fye1+6g28vkp5Sc/71RicjpjeA06UA4kP4e+VU4
         AeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709063107; x=1709667907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzyPyl18HcItr2oh7QJ73KXzsNopBuzQaSIWsMutKKQ=;
        b=N4u5bRe2j3LefLN0PCv9G7Wuq69+V4hbC+Ph7zjOKRRdhe8Lx0mF/7pv9v/UXJyYU0
         R8RBWxtr8Afcpc7KR+IMfEWiR9VdHOUVQ3ii8eXV0mqUlB2Wn0skYP1RwwCHG4Bm5sVt
         LAqunVOa9f6Wb1tt0mPPm5S+ZoWt6DfAMKbXinHxzzKya6aN6MgI/jjwOfxuj7A8KE1g
         BAcXTP8O0ibhefZIT3+8W9gqId8wqFh36WVGrFgR/Ye8W+4/b/8TuI4dItUECUcHmivu
         wkp5g5P9blXTR89H1fDlG/V5Sk8HlNnRNiLOx1ZjOIfU9mFvnC0kCLlKgs7y3LMxKvFV
         0jmw==
X-Forwarded-Encrypted: i=1; AJvYcCV4J2mtB7zZ/8ulE2t8YNrsMhabxIEB3tasOYAmTCfKxAeV+1hgyFOz3pnRfQi0b3tIcN6r5cLJTYydP7yambO2SQH/hXFChJpog3cG
X-Gm-Message-State: AOJu0YzO+/h9Y/b788+EgEk9n8RUUeEcUI3pGWSx8G9JAtgcq3iqxCa9
	dL3ouDi661IUeklgrz6Et3o7Zy3GoGgvoAsIzquvbJ2xSKG4jJ3VMOGYXuYZVbT8OGT0DuHW9FH
	SC6gZXHAxt3pg7TMRy44pnEpLdSP6kkLcmLuCDw==
X-Google-Smtp-Source: AGHT+IH92D/WyVxt0CyoZJb7+4/LBEXw9wuWt1w3xm370DIz8YGVmA3y1qQ7Mqz48tyPrHyjwzQ5UNpkidzVMgG+2ss=
X-Received: by 2002:ac2:4dab:0:b0:513:1652:585b with SMTP id
 h11-20020ac24dab000000b005131652585bmr808015lfe.63.1709063107167; Tue, 27 Feb
 2024 11:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
 <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>
 <20240227-condone-impeach-9469dffc6b47@wendy> <Zd4nMa+x28omuhiF@ghost>
 <20240227-citable-scanning-1fd48c96b758@spud> <Zd414nBtjHcsYWnL@ghost>
In-Reply-To: <Zd414nBtjHcsYWnL@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Tue, 27 Feb 2024 11:44:30 -0800
Message-ID: <CALs-HssaGBHrFdavM=VYm+z0vBWKSnoS2b0cAmjnXA_Kji1KdA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] riscv: Set unalignment speed at compile time
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-riscv@lists.infradead.org, Charles Lohr <lohr85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:20=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Tue, Feb 27, 2024 at 06:48:54PM +0000, Conor Dooley wrote:
> > On Tue, Feb 27, 2024 at 10:17:21AM -0800, Charlie Jenkins wrote:
> > > On Tue, Feb 27, 2024 at 11:39:25AM +0000, Conor Dooley wrote:
> > > > On Fri, Feb 16, 2024 at 12:33:19PM -0800, Charlie Jenkins wrote:
> >
> > > > > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > > > > +       bool "Assume the CPU expects emulated unaligned memory ac=
cesses"
> > > > > +       depends on NONPORTABLE
> > > >
> > > > This is portable too, right?
> > >
> > > I guess so? I think I would prefer to have the probing being the only
> > > portable option.
> >
> > I dunno, I think there could be value to someone in always emulating
> > this in the kernel and I don't think that should relegate them to the
> > naughty step, given it can work everywhere.
>
> Alright, I will remove the nonportable.
>
> >
> >
> > > > > +config RISCV_SLOW_UNALIGNED_ACCESS
> > > > > +       bool "Assume the CPU supports slow unaligned memory acces=
ses"
> > > > > +       depends on NONPORTABLE
> > > > > +       help
> > > > > +         Assume that the CPU supports slow unaligned memory acce=
sses. When
> > > > > +         enabled, this option improves the performance of the ke=
rnel on such
> > > > > +         CPUs.
> > > >
> > > > Does it? Are you sure that generating unaligned accesses on systems
> > > > where they are slow is a performance increase?
> > > > That said, I don't really see this option actually doing anything o=
ther
> > > > than setting the value for hwprobe, so I don't actually know what t=
he
> > > > effect of this option actually is on the kernel's performance.
> > > >
> > > > Generally I would like to suggest a change from "CPU" to "system" h=
ere,
> > > > since the slow cases that exist are mostly because the unaligned ac=
cess
> > > > is actually emulated in firmware.
> > >
> > > It would be ideal if "emulated" was used for any case of emulated
> > > accesses (firmware or in the kernel).  Doing emulated accesses will b=
e
> > > orders of magnitude slower than a processor that "slowly" handles the
> > > accesses.
> > >
> > > So even if the processor performs a "slow" access, it could still be
> > > beneficial for the kernel to do the misaligned access rather than man=
ual
> > > do the alignment.
> >
> > Right. But, at least from a probing perspective, SLOW is what gets
> > selected when firmware emulates the unaligned access so to userspace
> > seeing slow means that the performance could be horrifically bad:
> >
> > |     rzfive:
> > |         cpu0: Ratio of byte access time to unaligned word access is
> > | 1.05, unaligned accesses are fast
> > |
> > |     icicle:
> > |
> > |         cpu1: Ratio of byte access time to unaligned word access is
> > | 0.00, unaligned accesses are slow
> > |         cpu2: Ratio of byte access time to unaligned word access is
> > | 0.00, unaligned accesses are slow
> > |         cpu3: Ratio of byte access time to unaligned word access is
> > | 0.00, unaligned accesses are slow
> > |
> > |         cpu0: Ratio of byte access time to unaligned word access is
> > | 0.00, unaligned accesses are slow
> > |
> > |     k210:
> > |
> > |         cpu1: Ratio of byte access time to unaligned word access is
> > | 0.02, unaligned accesses are slow
> > |         cpu0: Ratio of byte access time to unaligned word access is
> > | 0.02, unaligned accesses are slow
> > |
> > |     starlight:
> > |
> > |         cpu1: Ratio of byte access time to unaligned word access is
> > | 0.01, unaligned accesses are slow
> > |         cpu0: Ratio of byte access time to unaligned word access is
> > | 0.02, unaligned accesses are slow
> > |
> > |     vexriscv/orangecrab:
> > |
> > |         cpu0: Ratio of byte access time to unaligned word access is
> > | 0.00, unaligned accesses are slow
> >  https://lore.kernel.org/all/CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=3DFw4jL3=
fcp4wO1etzQ@mail.gmail.com/
>
> If the accesses are horrifically slow then maybe they should be flagged
> as emulated rather than slow by the probe.

Yeah, I thought about that too. I didn't feel like I had enough info
to come up with the delineating number for "horrifically slow". Plus
Clement came in with a series to detect specifically that accesses are
emulated (though it will only work on future platforms that can
delegate the trap to the kernel).

-Evan

