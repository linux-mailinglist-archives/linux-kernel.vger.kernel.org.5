Return-Path: <linux-kernel+bounces-150252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8108A9C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD2D1C209AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5446165FC6;
	Thu, 18 Apr 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N5VmfLW9"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90B1649B3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449428; cv=none; b=KgfpFF2byztIhB1MP/DtAbPsKKKLBeD6Ey8l9/EVIt+CsM5a0Jspbpxkb3GPHuQ9Xv/FbngTLhuwnn7A3P8TtLQr8WwpHj0jFEzzCSr+i1Sxgd5dHdQqvpIETSYkjGGEyGnTe+EwjWIcTn1CkjJq3SnGWpHnFPscVV8x4rAyZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449428; c=relaxed/simple;
	bh=MhPo15x3SxKdRDAF5Hg2hBfSEBMnhXYH7rFIINvOKIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx6wZqDqx98FfSqjLK9S/jAUylDq1Kij43wK5UMxZBTWvlPD1gUSZrmuhKxlC1DdwpfVDmcTBU7hegtRQ675GP99S51d2VaqAibxq1hrGGsdqv6a65VTPInXC+HeEVu3Fdf1AtPisI7LCAamvusfHvTkJxMb/bIIaQMx6/s5YGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N5VmfLW9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d3a470d5so1039149e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713449421; x=1714054221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d2TO+6uZMB/zwvZb021ALlLKsmPjZN9AI+Kk+fYRpT4=;
        b=N5VmfLW91I+5cJGONBnWDx7WNduwnkv2lFHlPJFFP7o1fUTDcRRZss0TfczUphAQpf
         es8zUGUaOEihReWE1wy4eze9r0hfBBaI3IcmZr3Yf/WSyEKQ8JovksngUH2QoA2mam0p
         Kk/EY35COfyGLyhLL43cS9qHeaVWkk9I0yr46vPZz2QErxjXY42Qwol2XUxUDeNiWldA
         TtlBm0SUNG+3YZ7biEn5WP39SIcHhbnSoFnfdk84iCtaeclELMpr4Q7k1FU3oTwUhm/g
         m5DL216wcBZALRCcFqxy0cUqR2SJpLn4E6mQvS8w3UPzifyq+bfkfFBlHSSeJCqtCzsa
         vqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449421; x=1714054221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2TO+6uZMB/zwvZb021ALlLKsmPjZN9AI+Kk+fYRpT4=;
        b=PoyjbSjInXeIIS7P8K6ZDLBPZ7pyfMGk8d+b3aQTUL5Rz10r2bNVrlC6KhLW2/Q6Gv
         qhBTOp/aqyW3WCxpO4Du1PxcEMJulICbIFN/dr6aF+z2s8ax4s9HBBiCuplXDTG0zSBr
         HR8CcHRqMHfoCjwumd+bvylsyWOuamtdqB6mU5RRPFiztXjzWhvtX5nQ5HDC6/Y8+6+b
         PKbX5rUjwcLhR/QkSibbphMydFt83Spaq+9t6Ol+Bzychvex34ARG2bBEsMZOR+X7FQh
         /82qrgxqY0htC2CNYPmD3kXvwTVgI8+lS1gtznlKdolhIQoMb2tZtx8EMXw0FN00deyX
         QHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvflZIdQdK57v3O+isiUnJcy9J/KlitoCPHsM2NngclFZXwfV/ftIcsrffe9c6QBKBV/hmz/+qD1hBh9IkHm8LVvMf6ed59tSFeYDV
X-Gm-Message-State: AOJu0YxakhufRNCYRDKRRPNgfrrraLLRbDFDBID67izBw6nj1PuW0nXe
	nbY9GQ+5CwfqQEPuxzwi/fvWtyMu90Ks4fQPFp6q6mslB2Akk6+4GQcbKXwui08=
X-Google-Smtp-Source: AGHT+IE36Axh+eo8YV5jJfyakiHVt4NrWCVCrtov9Ii3lj1CXix1Y7yCbpKd8JrdXYX5BJ58eAHjBw==
X-Received: by 2002:ac2:4c3a:0:b0:518:e249:c10d with SMTP id u26-20020ac24c3a000000b00518e249c10dmr1792461lfq.37.1713449420877;
        Thu, 18 Apr 2024 07:10:20 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id oz34-20020a1709077da200b00a5271ae4458sm966288ejc.16.2024.04.18.07.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:10:20 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:10:19 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: Christoph =?utf-8?Q?M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com, 
	guoren@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lihangjing@bytedance.com, dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	chaiwen.cc@bytedance.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [External] Re: [RFC 0/2] riscv: Idle thread using Zawrs extension
Message-ID: <20240418-606209ea257878abceb8dc79@orel>
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <CAEg0e7gDk6SFRh4oF0KsA7xZoMr7RuZXFWL8qD7rmM2cBDLwcg@mail.gmail.com>
 <CAPYmKFsQQPCd-34GArHfC-Sv8PCYHgmZxprK3WHKnJquQDoXiQ@mail.gmail.com>
 <CAEg0e7hpjAec=2k+PwJeb0WezmJCFdUD=HbCiGe7+RxKgPHgtg@mail.gmail.com>
 <CAPYmKFudqq6Yg=uaVjAubCMM5TBMj8dkC0mXz+6eq3vNizTt7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPYmKFudqq6Yg=uaVjAubCMM5TBMj8dkC0mXz+6eq3vNizTt7A@mail.gmail.com>

On Thu, Apr 18, 2024 at 09:09:06PM +0800, Xu Lu wrote:
> On Thu, Apr 18, 2024 at 8:56 PM Christoph Müllner
> <christoph.muellner@vrull.eu> wrote:
> >
> > On Thu, Apr 18, 2024 at 2:44 PM Xu Lu <luxu.kernel@bytedance.com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 8:26 PM Christoph Müllner
> > > <christoph.muellner@vrull.eu> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 1:50 PM Xu Lu <luxu.kernel@bytedance.com> wrote:
> > > > >
> > > > > This patch series introduces a new implementation of idle thread using
> > > > > Zawrs extension.
> > > >
> > > > This overlaps with the following series:
> > > >   https://lore.kernel.org/all/20240315134009.580167-7-ajones@ventanamicro.com/
> > >
> > > Hi Christoph.
> > > Thanks for your reply!
> > > Actually our patch series is different from this. The work from your
> > > link focuses on providing support for Zawrs and implementing spinlock
> > > using it, while our work focuses on implementing idle thread using
> > > Zawrs and accelerating IPI to idle cpu. Of course, the ISA ZAWRS
> > > config part can be merged. We will refine our code in the next version
> > > to reduce code conflicts.
> >
> > Yes, I've seen that this targets another optimization, but the basic
> > Zawrs support
> > would be identical to the other patchset (even if it is not).
> > I would propose that we work on a basic Zawrs support patchset that introduces
> > the Kconfig, DTS and hwprobe parts (a subset of Andrew's patchset).
> > Once this is merged, all other optimizations can be built upon it
> > (spinlocks, idle thread, glibc CPU spinning).
> > If this proposal is fine for the maintainers/reviewers, then Andrew could resend
> > these basic-support patches.
> >
> > BR
> > Christoph
> 
> Roger that! This does make more sense. We will rebase our code on
> Andrew's basic support patches in the next version.

And I'm just about to send that next version. I'll send tomorrow morning
if not yet today.

Thanks,
drew



> 
> Regards,
> Xu Lu
> 
> >
> >
> > >
> > > >
> > > > BR
> > > > Christoph
> > > >
> > > > >
> > > > > The Zawrs[0] extension introduces two new instructions named WRS.STO and
> > > > > WRS.NTO in RISC-V. When software registers a reservation set using LR
> > > > > instruction, a subsequent WRS.STO or WRS.NTO instruction will cause the
> > > > > hart to stall in a low-power state until a store happens to the
> > > > > reservation set or an interrupt becomes pending. The difference between
> > > > > these two instructions is that WRS.STO will terminate stall after an
> > > > > implementation-defined timeout while WRS.NTO won't.
> > > > >
> > > > > This patch series implements idle thread using WRS.NTO instruction.
> > > > > Besides, we found there is no need to send a real IPI to wake up an idle
> > > > > CPU. Instead, we write IPI information to the reservation set of an idle
> > > > > CPU to wake it up and let it handle IPI quickly, without going through
> > > > > tranditional interrupt handling routine.
> > > > >
> > > > > [0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> > > > >
> > > > > Xu Lu (2):
> > > > >   riscv: process: Introduce idle thread using Zawrs extension
> > > > >   riscv: Use Zawrs to accelerate IPI to idle cpu
> > > > >
> > > > >  arch/riscv/Kconfig                 |  24 +++++++
> > > > >  arch/riscv/include/asm/cpuidle.h   |  11 +---
> > > > >  arch/riscv/include/asm/hwcap.h     |   1 +
> > > > >  arch/riscv/include/asm/processor.h |  31 +++++++++
> > > > >  arch/riscv/include/asm/smp.h       |  14 ++++
> > > > >  arch/riscv/kernel/cpu.c            |   5 ++
> > > > >  arch/riscv/kernel/cpufeature.c     |   1 +
> > > > >  arch/riscv/kernel/process.c        | 102 ++++++++++++++++++++++++++++-
> > > > >  arch/riscv/kernel/smp.c            |  39 +++++++----
> > > > >  9 files changed, 205 insertions(+), 23 deletions(-)
> > > > >
> > > > > --
> > > > > 2.20.1
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

