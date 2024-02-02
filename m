Return-Path: <linux-kernel+bounces-49203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB6846729
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498661F27B04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF7EF9CA;
	Fri,  2 Feb 2024 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0rgjYIYO"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DBF9C1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849713; cv=none; b=iHBGD3lMGKkRRqMFJzN9tzOGnpnnmkRNpVV6apTQAMX4qNM2nc4KikTiIzrJ50qAYewuXQu0/giy+OGHAJa+9g+rC3fJ0CMoXwZb0+Uvbb+EFFH+kG84L+m7IAaPlltRuJ7JVM46PDqYhCHyaW5anUVYEc5t8EsbjF2ClU0D35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849713; c=relaxed/simple;
	bh=7imjS2FoGObcyVs1TM+uIHz410qo+QrRZakHKZ02XOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I67+/cDC8PXXFeRXDNCsXMqUxvd3Y2i3ugVePXT3NNi4KfAL6+Z/oCzgzRRFSspG+2Ufd4sEPNJzJ8yUCVEtIMp0m5XjHV4OP2ZsEEEuyYLPjEBTniTUtd6qC+toPpRrQnSMbImk+j7/inWy8VbJoQTeMf+bIROByudKXExs/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0rgjYIYO; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3be48947186so890218b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 20:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706849710; x=1707454510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELOUzOOhC9OHyQkXGZvP+NJh1VjcNaclpZjQdZoL1A0=;
        b=0rgjYIYOiDNWbgJZlX36YLVhaAKmnnmxQecmD4tGCItz6KTFjNy9FHLtUm+CX7A50g
         XpKNj1FZ09IHtUJjzeVNJBredpZmdB3m4b8zE3IZxjAULsmgAgsjjUv97czHWFRNZZmm
         NEC7SfjWDDnL2WmpWzVUHyAUectg3iAnEUjDBs5yotjn5YUn/g4kSmagVR26+2ut0bwL
         5N4/nyjMW7Npvw9DWPEs2udnKj3sAnamStn2VusQExmZKzAJWgzSlQ9ZhFZ8fwGCqlCK
         IqRy4b8tpGbeZf3WlQX+/Zq4+yjIxwy8czi4wMc+VWGfgqyiroREuIXX+WIf7npav2aX
         b2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706849710; x=1707454510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELOUzOOhC9OHyQkXGZvP+NJh1VjcNaclpZjQdZoL1A0=;
        b=fxcFZV7/+bmmxg9SvzrUf8+YPhrXqNjSfvyzLt0ZX3ti2hq2jyDrjHkMpy9l5NdDQ5
         am3MsE+2V+SeldCFQjQdn2FOYyq8BwXAkIOZITvhHcAnkt9kNvjWOomOdbuPwjPSU3mG
         SUhgXI0o0HBi637cizA24iojp0dFaOCkntHijtToRSSTNn4Dlm8ShEKKUStEJ+hW+nh1
         E9qfFnbSCbQUDRhbbEpXeabBruByiBdy7T4ZmMe+Cil/aKc/ghPw1TAfQ5a95s9kiUDQ
         WS7tdP8TDwRzJp/biNP83qOR+o0sT6o5uOyQ2+ImWtBxr8uhollWB4X6GF+tKMhUtPgc
         OD6w==
X-Gm-Message-State: AOJu0YzLofCwG/PYera0gnBS5EFTplpiLso/tlR5Seek/hD13tKGtOx9
	iYqXZbYcCsAofM85upsEH6cdAmZsfsnoziqaDSVTokI/jc+AKihnhG0yUIEflOE=
X-Google-Smtp-Source: AGHT+IEt/9wko6Cibn+dwmpNKmXyDK48EPa2pWVscYQC2nlerGRXrHP67I5NFVgtquib0f23Ev+JDw==
X-Received: by 2002:a05:6808:15a4:b0:3bf:bc6b:ffe2 with SMTP id t36-20020a05680815a400b003bfbc6bffe2mr1626440oiw.38.1706849710167;
        Thu, 01 Feb 2024 20:55:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXaIf8VPRQDhUIzj9+k0XKjsZEiQYNzBqS4trMRWGdzWHRfcc5fnSubNMHCLB+ryltPFubGHu/4zhzI9lj4QStL/fLyHWw6PrWOsa6ex5MyDoZ/mIFU8HIo6AC33CxXKahoaWNJTpytH1PApkRRMjt1wOqnvCOwIQq9g6DIabmrLG4ZKljwS7lvit5Hb9M36Bgwj4Nb/Rty7QvZ+5PX1nTCdMb0Ia8VOdaEomzdshXyYwriOTp4y6rujYkM+6TlbnZ+8Z6XyT+uGp9PfzLEn9Zt7aTcRQ==
Received: from ghost ([2601:647:5700:6860:e95e:e3b9:1925:927a])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b006dd850bbd21sm617636pff.36.2024.02.01.20.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 20:55:09 -0800 (PST)
Date: Thu, 1 Feb 2024 20:55:06 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <Zbx1qlcfWJIBLobb@ghost>
References: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
 <20240201-disable_misaligned_probe_config-v2-2-77c368bed7b2@rivosinc.com>
 <gtwet3x2fokbne5642vleyp5u7pqjl2lbtbngjjfavmgvvytzg@z2gx6xoa3hvl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gtwet3x2fokbne5642vleyp5u7pqjl2lbtbngjjfavmgvvytzg@z2gx6xoa3hvl>

On Thu, Feb 01, 2024 at 08:31:10PM -0800, Elliot Berman wrote:
> Hi Charlie,
> 
> On Thu, Feb 01, 2024 at 03:30:46PM -0800, Charlie Jenkins wrote:
> > When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
> > set to have fast misaligned access without needing to probe.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                               |   1 +
> >  arch/riscv/include/asm/cpufeature.h              |   7 +
> >  arch/riscv/include/asm/misaligned_access_speed.h |  29 +++
> >  arch/riscv/kernel/Makefile                       |   3 +
> >  arch/riscv/kernel/cpufeature.c                   | 255 ----------------------
> >  arch/riscv/kernel/misaligned_access_speed.c      | 265 +++++++++++++++++++++++
> >  arch/riscv/kernel/sys_hwprobe.c                  |   4 +
> >  7 files changed, 309 insertions(+), 255 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index f71910718053..8be7f17da9ab 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -62,6 +62,9 @@ obj-y	+= tests/
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> >  
> >  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
> > +ifneq ($(RISCV_EFFICIENT_UNALIGNED_ACCESS), y)
> 
> Should this be CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS ?

Oh thank you Elliot! Yes it is. I was going back and forth on whether I
wanted this to be CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS or
CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS and I must have mistyped when I
was changing it. I settled on CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
everywhere else so this should also use that instead. These two configs
are effectively the same since the only way to select
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is by selecting
CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS.

- Charlie

> 
> > +obj-y	+= misaligned_access_speed.o
> > +endif
> >  obj-$(CONFIG_FPU)		+= fpu.o
> >  obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
> >  obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o

