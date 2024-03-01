Return-Path: <linux-kernel+bounces-88372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D6086E092
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4141C2263C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46846CDC7;
	Fri,  1 Mar 2024 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qk6wSSDT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA86A8B9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293337; cv=none; b=hFmFXsE4o9jFbHZEHWnOPnD0bBBQnIeHFElIGdIAE943yJw9Pi+SHZAcgsWk0RgiQFJW/XkjtFt/GxRHbAhC0E6CtXVeNtNEPDVUHHXvMOAPzrL48cIvaaf4smlu9LTc3pOVjhy6oZqJdpcATdui0tP7bWk2DfLPr6+V4TpsK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293337; c=relaxed/simple;
	bh=Fk/8aINaEQM0bfD2/7nSa9F+mk4kiLQBYgSxPkYq//M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh9T3D8BBQmvE4oCYcUwcYf3bmEEf8rXyYJjSLY5VSRyifXSoTFjMkveVLWCNWeJu4U0yHA+HTekK5gtRvTEBH6X/9Yja4VO5StiuHBoDRjTmHJ/cVokKmrGQ49mL58vUWusbsGAhYMCMptbriBpskzsXp0m4Av3hohAJKDC84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qk6wSSDT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1091149f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709293334; x=1709898134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fk/8aINaEQM0bfD2/7nSa9F+mk4kiLQBYgSxPkYq//M=;
        b=qk6wSSDTM3phyzBs4hWbCQznm++AVIJKqcfktXeJ28JmPNWpG/uyXfAzVwB92Vhyr5
         Zp83hmhdcnPgzBr6uv999LAuMLpU3i/+PV3iALnO+EX6MAtZedrgUyFa44b/aj+fVyqU
         U7Ca+7LV3lp4BZB86T1U5W9RvNTj1r2m94KAqmrXAA8YRKUn8mQBkIcalafQ3GV49cYw
         t/vz+tRi8yOFXTpzWHl+tP+odj5LkEVm7Feyvtdg3KGkH68IHJmWV4cLTXZbJghQqQhF
         dwZwzQOblCv1mD/sv7CVUgtXnPl2jrzQTY9+DAzs8T2p3boftb/3sg5rozYlexp88Gir
         mAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709293334; x=1709898134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk/8aINaEQM0bfD2/7nSa9F+mk4kiLQBYgSxPkYq//M=;
        b=bJPL6Vxgeuml41lHOVzwqE5SQ0u1nUyz+ZgPCMlB7aZFJ3HAceFvpMGsyKozqipr83
         K5qmE/br6SUwtevdizhSmEyjIX0grpKDZwSQkKeKhzkBXERZJewGihhE4NJq9Bj75+t5
         bzrJfDUaS1E9B5ZBlUsvpu1Fs5pQitEOrP/ZGU4vFp2rk8enV1UTZthfVRpIIyHSW2zy
         G5NZ8Dxbl1TEQpOUyYq4wuVEwZlHYi2b++DbiCPM3Pq6gmI+ho10JhpnYV984N5StWXm
         LOwpIfl7+nw5ZSLXczxCnEXad82tAz1Ph38spQmcpVjnn48/Q6LANnpn0zlgCUmMGzm5
         6bgA==
X-Forwarded-Encrypted: i=1; AJvYcCWrQoRk0AOmeRsu/BhTukL22ogl6TCRtbEa0EU7tGxvPjI6+EZH6nuKDOkFa01OzDHvyDuBT8jECryA14vGuP1hydbNi258LUbtfttI
X-Gm-Message-State: AOJu0YxULG5EYR9xwjURB3ogo14R5p2ohcpFE7v0ty7fFlRDFTLzh964
	aQIElg0MwaeqIXukUpFIWxk9O+tIBpFqzRITq3HjxSlOf37q3bNHIo05yPooldo=
X-Google-Smtp-Source: AGHT+IE2uhCi8X432pGEBh56x9XSYEEUgvIsPSx1jQ7q/Eb2CMyGNmb0dbM/AJCZjWPg0rwg3OKN4g==
X-Received: by 2002:adf:ca89:0:b0:33d:754c:8daf with SMTP id r9-20020adfca89000000b0033d754c8dafmr1515020wrh.10.1709293334266;
        Fri, 01 Mar 2024 03:42:14 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id q1-20020adfab01000000b0033ce727e728sm4341417wrc.94.2024.03.01.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:42:13 -0800 (PST)
Date: Fri, 1 Mar 2024 11:42:11 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
Message-ID: <20240301114211.GC5795@aspen.lan>
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
 <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>
 <20240228131104.GB22898@aspen.lan>
 <CAD=FV=VYV_EMFXS0vvMZLGSRZcGwit6=DMdgSW349bVAu_7a1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VYV_EMFXS0vvMZLGSRZcGwit6=DMdgSW349bVAu_7a1Q@mail.gmail.com>

On Thu, Feb 29, 2024 at 10:34:26AM -0800, Doug Anderson wrote:
> Hi,
>
> On Wed, Feb 28, 2024 at 5:11 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > > I'm still hoping to get some sort of feedback here. If people think
> > > this is a terrible idea then I'll shut up now and leave well enough
> > > alone, but it would be nice to actively decide and get the patch out
> > > of limbo.
> >
> > I've read patch through a couple of times and was generally convinced by
> > the "do what x86 does" argument.
> >
> > However until now I've always held my council since I wasn't familiar
> > with these code paths and I figured it was OK for me to have no opinion
> > because the first line of the description says that kgdb/kdb is 100% not
> > involved in causing the problem ;-) .
> >
> > However today I also took a look at the HAVE_NMI architectures and there
> > is no consensus between them about how to implement this: PowerPC uses
> > NMI and most of the others use IRQ only, s390 special cases for the
> > panic code path and acts differently compared to a normal SMP shutdown.
> >
> > <snip>
> >
> > However, if we talking ourselves into copying x86 then perhaps we should
> > more accurately copy x86! Assuming I read the x86 code correctly then
> > crash_smp_send_stop() will (mostly) go staight to NMI rather
> > than trialling an IRQ first! That is not what is currently implemented
> > in the patch for arm64.
>
> Sure, I'm happy to change the patch to work that way, though I might
> wait to get some confirmation from a maintainer that they think this
> idea is worth pursuing before spending more time on it.

100%. Don't respin on my account.

> I don't think it would be hard to have the "crash stop" code jump
> straight to NMI if that's what people want. Matching x86 here seems
> reasonable, though I'd also say that my gut still says that even for
> crash stop we should try to stop things cleanly before jumping to NMI.
> I guess I could imagine that the code we're kexec-ing to generate the
> core file might be more likely to find the hardware in a funny state
> if we stopped CPUs w/ NMI vs IRQ.

In terms of the "right thing to do" for kdump then reviewing the s390
might be a good idea. Unfortunately it's a bit different to the other
arches and I can't offer a 95% answer about what that arch does.


Daniel.

