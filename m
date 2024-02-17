Return-Path: <linux-kernel+bounces-69694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B76858D63
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2D41C21167
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEFD1CA9B;
	Sat, 17 Feb 2024 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K3G6Op5s"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAC149DE0
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708148564; cv=none; b=tTuRJu9IaBVA8gFs1vhe+2vLJNTtzhMt5xKHX1OeUe0KhNFPhzj/OfBn5K8FaTDimVhQtU339Q2y+27KzVhpwbdTZ2Aw4QVgZmNTD6NCOFl3ZHxytvvEsMBZ2v3xK5bJ1w9zefpHM4CV5rp6Hltt6FxcWeJnDOIlM1yREEzLhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708148564; c=relaxed/simple;
	bh=Q2XJqDi+VWb+RWFjBl96LehTOOg8v5aVoczUYhI4x1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoW0ZCn9aS2qnnCvwZ2kHj/KejGu1kQpoefi+RI2KxFUBTIvy0soPjSaPl3sIkRUcNwH3o7pRPN8GAcns28avVZWxTccH9A58lJEjFz/F4fmjZBBBoje1vdCAhA6ovETDGlkLbhwJkipR5ScrdkV1UEITSD0KBYTjBVuIR3H3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K3G6Op5s; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511ac32fe38so4066255e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708148561; x=1708753361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2XJqDi+VWb+RWFjBl96LehTOOg8v5aVoczUYhI4x1E=;
        b=K3G6Op5sje0wQ/2M8WNZ5+PUz2OXrBG5Tms28bIyeb2v4GJVfJ4KyZ9MP1ACdYQVuK
         NXK9XHOMf7mzge/ec2Bt0Pnj+mGTicMQiwDK1BpuN4sea8rn8CUi/Lgz8mcd5dEVcWP6
         FcDPKWIL1d++2ihJoIcKsY1E72LfOPWSCEmRGrR5SzovEY+nQrD6okhGK1oe5Vp59Vwb
         KXbXL+12Bk85ythDrC8xuANCdnV4b2O51jW2vWYSqixnBZ1o62U+Jsx9UH5OLCf8jYZd
         6HzRl5Y3c8TtHIscZ8B0QKnPwRPfg6ZnQIAw9cxZvE4SLc992z36RZKEOqP7PZ5VSZjl
         DJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708148561; x=1708753361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2XJqDi+VWb+RWFjBl96LehTOOg8v5aVoczUYhI4x1E=;
        b=lR2+LdU3m4KYN0Rhe5NTNQNvp2dkcbxPjgSqhA42BoUX9EXF7Be4UTnipLPLrN6jq4
         jfNC2e31cC2b787zdjDxaHL5rVT6uAqA0WMcT5Zn7ygOHWJXdy3MJGkk9Rhloz0MOyBV
         scbvqW6rLo8m1/hEuBnWhg4IdRNiXMdiMGK3GAh2jrniYKBmotLFLKlEmby/j5XdI50L
         afYO/XUS24f7TyH5vjZTyK5/qfNcyOdGuSJOgvw0XLllZxZzP1e/JB1UbNqLuAUAVVgw
         GLHd1Fz7Dn2bNBY4m6nB5TMpLM8QD3pgy5U3gt1HnwDcNipVGe8lGBY9ngMXCKo+2ZXP
         rYnw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Q3onxixUOIMSS7vwO8ssOw6+74WMg+tsixtZpJr8wxUqZPBGHXVj0FfjaFCM8qFLOR1xcxaGoZ0MYlvA3P1EKOvrhCezPDLGsMrI
X-Gm-Message-State: AOJu0YzLOn/PaI60GSA5mXmDnzy/MFZP5Y2qFA7mKbuz4HpT7/WN2+/P
	HQqKziCAvf4gDKByH+D3RxBeyu6UzHEtS9j3wKqflAPDaIJVC076u6Lcw1SvlPcT68IE/3NVqt3
	7hN7yz5mXqoNEN+twIG6ji1+Lkkmly4Flm2GiLg==
X-Google-Smtp-Source: AGHT+IGNn3qXE8Q2rV0AbEGEYH7CRDHvt7ZbR9eJEmA9ut7fgUgx1eQcMY50Tzh0dWXfbhyTfzgBRj3nELnm/DfNA7E=
X-Received: by 2002:a05:6512:526:b0:511:96d0:5ae1 with SMTP id
 o6-20020a056512052600b0051196d05ae1mr5084453lfc.40.1708148560820; Fri, 16 Feb
 2024 21:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-15-apatel@ventanamicro.com> <87jzn4ctks.ffs@tglx>
 <CAAhSdy2aeyJBcMVre12jGwU52oP9Z=1emB-bcYxygdR3QhP+6w@mail.gmail.com> <878r3kcg7e.ffs@tglx>
In-Reply-To: <878r3kcg7e.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sat, 17 Feb 2024 11:12:29 +0530
Message-ID: <CAK9=C2WWBrUae2hduUBwuxd8=23_KO3-x1fF=BaTtxJMHVyFrg@mail.gmail.com>
Subject: Re: [PATCH v12 14/25] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:52=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, Feb 16 2024 at 22:41, Anup Patel wrote:
> > On Fri, Feb 16, 2024 at 9:03=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> I don't think that removing the setup protection is correct.
> >>
> >> Assume you have maxcpus=3DN on the kernel command line, then the above
> >> for_each_online_cpu() loop would result in cpuhp_setup =3D=3D true whe=
n the
> >> instances for the not onlined CPUs are set up, no?
> >
> > A platform can have multiple PLIC instances where each PLIC
> > instance targets a subset of HARTs (or CPUs).
> >
> > Previously (before this patch), we were probing PLIC very early so on
> > a platform with multiple PLIC instances, we need to ensure that cpuhp
> > setup is done only after PLIC context associated with boot CPU is
> > initialized hence the plic_cpuhp_setup_done check.
> >
> > This patch converts PLIC driver into a platform driver so now PLIC
> > instances are probed after all available CPUs are brought-up. In this
> > case, the cpuhp setup must be done only after PLIC context of all
> > available CPUs are initialized otherwise some of the CPUs crash
> > in plic_starting_cpu() due to lack of PLIC context initialization.
>
> You're missing the point.
>
> Assume you have 8 CPUs and 2 PLIC instances one for CPU0-3 and one for
> CPU4-7.
>
> Add "maxcpus=3D4" on the kernel command line, then only the first 4 CPUs
> are brought up.
>
> So at probe time cpu_online_mask has bit 0,1,2,3 set.
>
> When the first PLIC it probed the loop which checks the context for each
> online CPU will not clear cpuhp_setup and the hotplug state is installed.
>
> Now the second PLIC is probed (the one for the offline CPUs 4-7) and the
> loop will again not clear cpuhp_setup and it tries to install the state
> again, no?

Ahh, yes. Good catch.

For the "maxcpus" in kernel command-line, we can't rely on the
cpu_online_mask. I will preserve the plic_cpuhp_setup_done
check in the next revision.

Regards,
Anup

