Return-Path: <linux-kernel+bounces-111818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82620887150
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326BD28737C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908A15F575;
	Fri, 22 Mar 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gt7Zs7LI"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0AC605A8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126380; cv=none; b=sXMT14f7iC7W/susKgAyvPhoHxAiCNUQ7QIj/Ua5LqVj/2fxaJ16vQXm2YozbuYPOxEl6SzeSfGw1+BNuboygSxoD3eeIKY0+3I0hJixpnrYnBlEVENeYFPoBHzcBc0PiY1E4j3u4ae4qfCMbzi2Bs83nWkM/w5i+RdUh4AvE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126380; c=relaxed/simple;
	bh=ugO3VCcCbFXqa0j0ulFrbXaGajsAP4EqVB7of7qqfPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKw3lH3nkKYurBELdBqmA4VbFIx8lw7kQHR06kpqVW9yEh6OZAMuO8JN2PyLOUVaDEwfHnnxMBm/cGYm//8Xrg2ivIgTW4fALBtpfrNOCxTsGieNxXe+xdM/o9bblCBhFH69JKJOhPfzg8vRcy9QV5fSHADWs+VIsre/EmveksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gt7Zs7LI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a068e26d8so26378817b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711126377; x=1711731177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y51uEGJ03D6pw21uRms6OLbBjZsNY8YSRn9RWNKVb+8=;
        b=gt7Zs7LIEjkrCuFLBHQq+9o8bSsfH1Ov05v4LPLE48/hUiYYODfkVGVUaYhBcFjHJ+
         0X6i9UOEdDeICZydK840q2xp/F+AB3VW4Zmf8NTkSmYOqZ8T/ovN5fZ44dw1oM6+AUoI
         zXET6j7bNXPdROlqyKcR7OPsdT3j0Qc9vLS+nXD/1vw8jT6QeBkKH2a44Daox+SH4ep+
         MNNd4bpmivvUdP4WFv3LEq0wp6aIP8Gb6qRxiDSzwvjpFfhou84x3tnZYo7AwL7XpK+L
         vOnuj6//8GRCtfQzE7llvlSmRkXL+DQasnbiIQY43gK+e3C8sZNrW6HvLBgRs4onCSwl
         doYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126377; x=1711731177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y51uEGJ03D6pw21uRms6OLbBjZsNY8YSRn9RWNKVb+8=;
        b=qTkXlwJ1RzQMAylc2aRY0UK9aer5Bd5q/isBWQd7TKiU5SyE5OuVLp2lvwo07Ux3qe
         LfOx9G8RDQfOXATE9yP77Wxvpgi+Ifncwr1MPG2PLE/neuHXcZxswqcpQOw/sWtee2zE
         F4oEKMuOfxN4Pj/9Agt5V/UDuCCFK+5exdRpmk2ext7PvJUD2ecqb2tZBhCpgmPOgrf/
         +xN9ltLrdx3zCOfoOW2z1yt6HZLUljcqG6aeHMJVVQcrCWp1fYIZT9QlyXTz0vDlDTzt
         jBym+7F6Bo1ME1nPADt66h11x7OP9iLujBzFG5oQy1ZzwS9BXSnMW4PqmFIVRlF0gjTf
         Ju3g==
X-Forwarded-Encrypted: i=1; AJvYcCX9UpJqQ5uWM1NPWWtg196gI82ZGo40SYeAFbI5rAnfQpZlcIx5QNVaN1j12cbTwIZyD1lbtXzonkuyJ7d5ngrlE8E67iZg8KxTnn4w
X-Gm-Message-State: AOJu0Yxl/dYngzFOtBIVX6AGqmBzrzZuIs2VNEKBdgQLYZxg+De/rA/S
	IZ+Hz9IVen1vDLnZAtmw+iJrI5jUKTXCL7j3t1sY2VLmcr3dMkm79NVLv9StFUgm+oZ/5gtb5LC
	WNOEER+nnzrlx6s9STFGQXud8sLe4mae0i3kjwg==
X-Google-Smtp-Source: AGHT+IEpg7MCg3bZ38eIAspdWgzOjXUKRaxb3wbMQl77qTIMFr7IGfaPlazJNe4j1FElxowopIqWuHH20jjSqY11dPk=
X-Received: by 2002:a81:710a:0:b0:60f:d6fc:74f3 with SMTP id
 m10-20020a81710a000000b0060fd6fc74f3mr228823ywc.7.1711126377529; Fri, 22 Mar
 2024 09:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com> <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com> <CAKC1njQYZHbQJ71mapeG1DEw=A+aGx77xsuQGecsNFpoJ=tzGQ@mail.gmail.com>
 <20240322-3c32873c4021477383a15f7d@orel>
In-Reply-To: <20240322-3c32873c4021477383a15f7d@orel>
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 22 Mar 2024 09:52:48 -0700
Message-ID: <CAKC1njTGSMPekhvyRW0gz6+mY2S_==voCcspoLAyp38X-BcWcw@mail.gmail.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	tech-j-ext@lists.risc-v.org, Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 1:09=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Mar 19, 2024 at 09:39:52PM -0700, Deepak Gupta wrote:
> ...
> > I am not sure of the practicality of this heterogeneity for Zicboz and
> > for that matter any of the upcoming
> > features that'll be enabled via senvcfg (control flow integrity,
> > pointer masking, etc).
> >
> > As an example if cache zeroing instructions are used by app binary, I
> > expect it to be used in following
> > manner
> >
> >  - Explicitly inserting cbo.zero by application developer
> >  - Some compiler flag which ensures that structures larger than cache
> > line gets zeroed by cbo.zero
> >
> > In either of the cases, the developer is not expecting to target it to
> > a specific hart on SoC and instead expect it to work.
> > There might be libraries (installed via sudo apt get) with cache zero
> > support in them which may run in different address spaces.
> > Should the library be aware of the CPU on which it's running. Now
> > whoever is running these binaries should be aware which CPUs
> > they get assigned to in order to avoid faults?
> >
> > That seems excessive, doesn't it?
> >
>
> It might be safe to assume extensions like Zicboz will be on all harts if
> any, but I wouldn't expect all extensions in the future to be present on
> all available harts. For example, some Arm big.LITTLE boards only have
> virt extensions on big CPUs. When a VMM wants to launch a guest it must
> be aware of which CPUs it will use for the VCPU threads. For riscv, we
> have the which-cpus variant of the hwprobe syscall to try and make this
> type of thing easier to manage, but I agree it will still be a pain for
> software since it will need to make that query and then set its affinity,
> which is something it hasn't needed to do before.
>

Sure, the future may be a world where heterogeneous ISA is a thing. But
that's not the present. Let's not try to build for something which
doesn't exist.
It has been (heterogeneous ISA) tried earlier many times and mostly have
fallen flat (remember on Intel alder lake, Intel had to ship a ucode patch =
to
disable AVX512 exactly for same reason)
https://www.anandtech.com/show/17047/the-intel-12th-gen-core-i912900k-revie=
w-hybrid-performance-brings-hybrid-complexity/2

As and when ISA features get enabled, they get compiled into libraries/bina=
ries
and end user many times use things like `taskset` to set affinity
without even realizing
there is some weirdness going on under the hood. For majority of use
cases -- heterogeneous
ISA doesn't make sense. Sure if someone is willing to build a custom
SoC with heterogeneous
ISA for their strict usecase, they control their software and hardware
and thus they can do that.
But littering linux kernel to support wierd usecases and putting a
burden of that on majority of
usecases and software is not wise.

If something like this has to be done, I expect first that it doesn't
force end users to learn
about ISA differences between harts on their system and then figure
out which installed
packages have which ISA features compiled in. This is like walking on
eggshells from the end
user perspective. Sure, end user can be extremely intelligent / smart
and figure it all out but
that population is rare and that rare population can develop their
custom kernel and libc
patches to do something like this.

This is a good science project to support heterogeneous ISA but
practically not viable unless
there is a high level end user use case.

> Thanks,
> drew

