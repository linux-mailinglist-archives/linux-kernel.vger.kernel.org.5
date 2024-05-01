Return-Path: <linux-kernel+bounces-165622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10948B8EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BEF1C20E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AF517C98;
	Wed,  1 May 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CsdP4LRi"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8ED168BD
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583105; cv=none; b=ZCJ/1unEo+NhNvrthuJwTUrdjPGSjhJisruXbWC5eTEOfadpOtB4SA7R7tHy+5jwH0/W4V8cjXSJFMCYUNOBf3eaxYv8Rau0qCgQLb+dg0M/k+k63orHbEStZVTaUqXB71zguTldJ708TNsUi4xSNWN44gVNlCGiH+C30P/sOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583105; c=relaxed/simple;
	bh=+MZIPJ0cp2Hrp3rYs7+GS9g8KSXuc61Ijyz78JQ904Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B40v+i6SfWVN12FWKJH23X5n/c+DndZnW99CM3TNWBbUpAi/JiXkfcbOSLzGERvFni8rUf1CDllBFw5EwIf6ZvaXi1mBNAPrp9+LiSS7jt/hjEBUq0KW4+Opadf92YnLqUq+ZiBnjYxBSSEx8R1ikZgmEeq3qfX1PKxPFkf8ixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CsdP4LRi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e65a1370b7so65622155ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714583102; x=1715187902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElGjJ6DhmRlqGsY+eiWz/anA6sw6bSbldqs1mMMSdXY=;
        b=CsdP4LRiKnn/ASIcvY/YDicsz/knDgbJoQqXly1E+lrpKWJ8EdBGgsyaaHvD6Thdk+
         e43irhqwXh+WcC7dObTqFgv4llYAZ6Gq3aOvTpGLBY+yJla2OV/61PZZzYzT1iWNdsvu
         VGQhSsAg7vxyHTKtgU9eF2RYU6cUuaMfwg4ogMx217PcVduNCaGJ7vD1X4RUInqMku80
         SyMeMVGsb3dWUCxtL8RV2huXUw8Unhh12rn/lpeakx2CPx/Y4M7OJOiMGtd+bQ0e+5SE
         wQvir9ldAB4vOeSxhBK2zmM/dMWD39V30m1Xv0j5JaZq+lZoj/rCrpiQGyh2hOQufn82
         cPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583102; x=1715187902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElGjJ6DhmRlqGsY+eiWz/anA6sw6bSbldqs1mMMSdXY=;
        b=NLjbxnWKdEO9dOOmErUJrM91MQNwbCeLLZbC1QOZwaVnpFFSc6NazST2aLakLHbU+F
         0YSAzCUmjh6FGJsHmYJz24YF2iHTje6vQPaEIJkbtgZPvMJiblNk20vE7YHyDqSY6yOM
         CYAejUxKlCcy1XTL02rC63XKSTAqWov3mmsN75pc2kV+Wc6S0yvsk/t2t1Obo5zrf9aL
         MBcY4UlsYY1Md1/W1VEU4wPZg831j9yGfvEeOczioOgvvEoIDLRay91ucllq5AUs1c4g
         H2/v9LNw7lOBxaucfyPUCjU5tVCaF+8aV40sZ74q+iMFRBnsW/RUCHujLfV8BYTGJpDR
         J02w==
X-Forwarded-Encrypted: i=1; AJvYcCW0sy0ReNM6gIe+o9ekJE8FrMQ3jau9a2K2glujAWhx1bgYzDKy+zPtah/xyFyp4u/T+kOlPJRguPxdDASnCC+ixO0Nk/UHuI1/iM0D
X-Gm-Message-State: AOJu0YyJkNB4F8mj6c4lyg/8N+QDKrqJQqUtQ0PIVnfjIa0CIQorn1o1
	IiESrY42WGal3lmAmAZNtrnGq/nVtTYVpz/n0OGeXW72ilarS3+bf44gfobq1oE=
X-Google-Smtp-Source: AGHT+IFvczd8ByrKjRpEmw2Tm8e/A7jIBRbW9BHOckqa6SdF3HlIzepIjpMlwHXG9pT5WMnsKMpNHw==
X-Received: by 2002:a17:902:e54f:b0:1eb:dae:bdab with SMTP id n15-20020a170902e54f00b001eb0daebdabmr3974726plf.46.1714583102382;
        Wed, 01 May 2024 10:05:02 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001e3d2314f3csm24412023plg.141.2024.05.01.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:05:02 -0700 (PDT)
Date: Wed, 1 May 2024 10:04:58 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <ZjJ2Omhynz02mAGk@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <20240501-chastise-gecko-342f2c35cfc1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-chastise-gecko-342f2c35cfc1@spud>

On Wed, May 01, 2024 at 11:46:07AM +0100, Conor Dooley wrote:
> On Fri, Apr 26, 2024 at 02:29:19PM -0700, Charlie Jenkins wrote:
> > Separate vendor extensions out into one struct per vendor
> > instead of adding vendor extensions onto riscv_isa_ext.
> > 
> > Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
> > code.
> > 
> > The xtheadvector vendor extension is added using these changes.
> 
> This mostly looks good to me, thanks for the updates. There's one thing
> that I think is wrong, but I need to test and will get back to you on...
> 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                               |  2 +
> >  arch/riscv/Kconfig.vendor                        | 19 ++++++
> >  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
> >  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
> >  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
> >  arch/riscv/kernel/Makefile                       |  2 +
> >  arch/riscv/kernel/cpufeature.c                   | 77 ++++++++++++++++++------
> >  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
> >  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
> >  arch/riscv/kernel/vendor_extensions/thead.c      | 36 +++++++++++
> >  10 files changed, 200 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index be09c8836d56..fec86fba3acd 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -759,6 +759,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> >  
> >  endchoice
> >  
> > +source "arch/riscv/Kconfig.vendor"
> > +
> >  endmenu # "Platform type"
> >  
> >  menu "Kernel features"
> > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > new file mode 100644
> > index 000000000000..4fc86810af1d
> > --- /dev/null
> > +++ b/arch/riscv/Kconfig.vendor
> > @@ -0,0 +1,19 @@
> > +menu "Vendor extensions"
> > +
> > +config RISCV_ISA_VENDOR_EXT
> > +	bool
> > +
> > +menu "T-Head"
> > +config RISCV_ISA_VENDOR_EXT_THEAD
> > +	bool "T-Head vendor extension support"
> > +	select RISCV_ISA_VENDOR_EXT
> > +	default y
> > +	help
> > +	  Say N here if you want to disable all T-Head vendor extension
> > +	  support. This will cause any T-Head vendor extensions that are
> > +	  requested to be ignored.
> 
> What does "requested to be ignored" mean to a punter configuring a
> kernel? I'd expect this to be something like:
> 
> "Say N here to disable detection of and support for all T-Head vendor
> extensions. Without this option enabled, T-Head vendor extensions will
> not be detected at boot and their presence not reported to userspace."

Sounds great I will change to that.

- Charlie

> 
> In general, I'd expect something that needs some support in the kernel
> (like vector) to function to have a dedicated option, but the likes of
> their Zba variant could be detected and reported via hwprobe et al
> once RISCV_ISA_VENDOR_EXT_THEAD is enabled.
> 
> Cheers,
> Conor.



