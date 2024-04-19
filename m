Return-Path: <linux-kernel+bounces-151544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B68AB04A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297E7B25ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C6130AC2;
	Fri, 19 Apr 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HGAMTS7t"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B8130A54
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535539; cv=none; b=D2HBHxPFOkbUaZX1ERlhlPFLedNRUTZ4RauoYqmma8R/ljBHb9N48Pw8rUpaqsUfq6jvd08BBCBLUwHbBpYZbwffzphA8xUqVFCdLzICZozBz5+kH766tYb7EZeXXiQv9n/xDMhbUoqi2Onp3pVW8pkgg7TK20N/qRkBzjdPH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535539; c=relaxed/simple;
	bh=300+u03GT/XBRX4/KLSctSmQOkx6NUhKeUlxTRuFEx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA+kVZ0WKxCIAOnwluGRjch1a5dPxaPA111lCndSxXWSnO6NbZJTFVrRKIsqyAhjZEPhNnoO5bPiKmfCjbow7dHKlflivBCVoeKkgxkiOj/B4tmnQAS9S1ZvcItlozjqoZbF3hl60d5ZLdHePkXsqrHRSOS4SZ49rbIFaB/eJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HGAMTS7t; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51acb95b892so619879e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713535536; x=1714140336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcZX0iTbIwoiKUb5BggVBNG79MAfC9FpmndZpC+sJGE=;
        b=HGAMTS7tdGoqGhja8BRzXcBbur+0MbzR0QvrlJAAGsN3L88QBRgUENYVOIKNyPABGr
         pPNYwo5dDhBmr5sktICtDHTEx9C8Ws0oFBkHE1atNRkeRCO2H5RCHanGUHv+nkuiei3r
         sS13V/TeAB5+t1OgZ9DAbBdU6iP3k8DGBzbzY/FVKC5t02gxzi0OCNAf+YTxkoW6cH2Z
         sgV2TgLj/V4afmqlJlJEWcLQ5N02nUaKWfT3bud+IrwGC7ZB9auDKYxf2NjqvnFM+y3P
         8JDEOveEbv0UNKfAJVOFf/jbC1+svjz9SEaFHwSMOn/iFIVYCq8neC7hCHPoY1706Kek
         7mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535536; x=1714140336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcZX0iTbIwoiKUb5BggVBNG79MAfC9FpmndZpC+sJGE=;
        b=JBZdsdMu1ahoxC9AmfUn5PnvsPRozSxZQU+RkEQz1yfSVW9Ay3soWpiiCBLW7/+CFQ
         PP6nKKNlrwo3SCzxpgIeNZAE6X6nfOvihcyRBOAb6K/goqAHW4VSE5EKZ/fMnxGsVhXw
         V1spvOUBlDEXpBqaNRoGRKaxZpPaRoeek3r0L3TNyll9KTDJpN90WjbrpKbiLyV967gF
         UsmEqYq3PFkvBTFzSUZFnFrSTAWmEkmrTjr2w/lCgyrTcq8j6FWH0CGEa6sgFcTOgbOx
         TRXDRPJQd/52lJZJX1kLzXfuagD8L2FQtzUExnpnLl5Nd9IbvKrQcocsz3BHKWFIQkzu
         pdyw==
X-Forwarded-Encrypted: i=1; AJvYcCU3S6JPrXwldhAfnuGvIx557GW7YZejDt067n7Io9YSphVuLlTKMaWX1JYH49OZ4zSpkEjL/gchDi9F48zPxFVQ2JJr9DTi3ZiUkw8r
X-Gm-Message-State: AOJu0YzW8WyVMPXSfs/NykCt/kHUiBJOmeaPtTeAfoLp/2yFDTvO2Uja
	PXtlqvkiNfTRXY2MXmpwYorPNfJzMfcTFQhNQjsJCwk1FcwjWF55IfNub7r5hTM=
X-Google-Smtp-Source: AGHT+IHs3qlXn7Awn9fZxIK3le0e9UTgAGysw6UwaUwZMzdcqQR0qEL9rQ2VUMMj5fKP5f+/lKDjmA==
X-Received: by 2002:a19:5f07:0:b0:516:b07a:5b62 with SMTP id t7-20020a195f07000000b00516b07a5b62mr1875404lfb.54.1713535535583;
        Fri, 19 Apr 2024 07:05:35 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id nb33-20020a1709071ca100b00a55778c1af7sm1854476ejc.11.2024.04.19.07.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:05:35 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:05:34 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Pu Lehui <pulehui@huaweicloud.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: clarify what some RISCV_ISA* config options do
Message-ID: <20240419-b5dbe7b133a749afdc0af416@orel>
References: <20240418-stable-railway-7cce07e1e440@spud>
 <20240419-ea2b867f6bde90e711464c95@orel>
 <20240419-excretory-dwarf-ba817cc725ea@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-excretory-dwarf-ba817cc725ea@spud>

On Fri, Apr 19, 2024 at 12:06:59PM +0100, Conor Dooley wrote:
> On Fri, Apr 19, 2024 at 01:01:52PM +0200, Andrew Jones wrote:
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 6d64888134ba..c3a7793b0a7c 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -503,8 +503,8 @@ config RISCV_ISA_SVNAPOT
> > >  	depends on RISCV_ALTERNATIVE
> > >  	default y
> > >  	help
> > > -	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
> > > -	  time and enable its usage.
> > > +	  Add support for the Svnapot ISA-extension when it is detected by
> > > +	  the kernel at boot.
> > 
> > I'm not sure we need the 'by the kernel', since I guess that's implied by
> > being in a Kconfig help text, but either way is fine by me.
> 
> I think we do, given some of the options are required for userspace to
> use it and others are not. Distinguishing between them doesn't cos us
> more than a few characters so I think it is worthwhile.

I agree we should ensure 'support in the kernel' type of text is present,
but here we're saying 'detected by the kernel' which I was thinking was
implied since this is kernel code. Maybe we should just add the 'the
kernel' text to where the support is rather than where the detection is?
I assumed it was left off of the 'Add support' because Svnapot is for
S-mode.

> 
> 
> > > @@ -686,7 +687,8 @@ config FPU
> > >  	default y
> > >  	help
> > >  	  Say N here if you want to disable all floating-point related procedure
> > > -	  in the kernel.
> > > +	  in the kernel. Without this option enabled, neither the kernel nor
> > > +	  userspace may use floating-point procedures.
> > >  
> > >  	  If you don't know what to do here, say Y.
> > >
> > 
> > Zicboz could also use some clarification, right? Or is the fact that
> > RISCV_ISA_ZICBOZ enables the use in both the kernel and userspace the
> > reason "Enable the use of the Zicboz extension (cbo.zero instruction)
> > when available." looks sufficient? Maybe Zicboz should follow the
> > "Say N here if..." pattern of V and FPU?
> 
> Yeah, I think I just overlooked Zicboz. If the kernel option is needed
> for userspace to use it then yeah, it should follow the same wording as
> V/FPU.

Actually, never mind. I was thinking we only set the envcfg when this
config was selected, but that's not true. We'll set it whenever the
extension is present with or without this config. So I guess it can
follow Zicbom's pattern.

Thanks,
drew

