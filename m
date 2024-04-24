Return-Path: <linux-kernel+bounces-157143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D9D8B0D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733A51F22F88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20A915ECF7;
	Wed, 24 Apr 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DA021eMb"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3C15EFB7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970668; cv=none; b=cMIplbI/EGrcAvRVhaKIw6uG0puzlw++jl7GV3HpVvLXhGzgFULsZzJ2BycUwdhIieYEiOpl8wrbDACqbX8l4wyfYshBpCiU0iwtZkd9n9eu9haQiJurrtHKxta2yY1ThxmuIHlbq8p/boGTREaRClN2rYFId0Q/3joaR9UBXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970668; c=relaxed/simple;
	bh=QMslz113vv9u8rbbuaQqQeBM4KeubIHYp+3TNEFioH4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjgKYNTPM4N9fuR4YgRgAbFoXxkDJlWHLXqmc/iN3KCdA0pU0Irmr0Y27kraWFLkdktuHoNe47pjlsdISxaDfS/6c/ylRSbjvQhESFVnzdl0Epm/PGwj88FEI+I/3C5Uh6cLO/CCPoc2oqfV/+kzgOER1goTOwSGUXgY6JJ8ptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DA021eMb; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 466E540590
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713970664;
	bh=5esocC9ZFW0Dfcow+sGknBU1wI/0vCj6NFX+zWkQdjU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=DA021eMbB/XsGVtLKMIMG1mKtATTf63AUeW8Lt7+LvgkjAHISZm3JwefjHtBM0H/i
	 qSqXIZdulN2d2BUMAaxs8t7v4xqrKHa3Y8R/Ip/+qfN9otkde3ASQZz/WuUtz3FRkK
	 nGsWCwKXm5bybhYdQsmbsp6SjRONllK815yO0yGLODAgp/FNunveRRRttpzMLf1Kt1
	 ofhkg+UJAa2TYjZmLyFfGJTSw+360rGIGvmL8unD0q9lzqewXSe2JIN8Jcm8iCyugq
	 n6bJ+5afDhLXHDjSDSjc6DQQAd7y2qfyfXbYwEBaIIj9u7DD4Sk+zWur+W0SpX7INQ
	 +Dl6pccMipFcQ==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-61ae546adf3so110293037b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970663; x=1714575463;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5esocC9ZFW0Dfcow+sGknBU1wI/0vCj6NFX+zWkQdjU=;
        b=wEfJtBVfCKT0TVqbhG6t8k5OXAUq4ZsYdM5lC+wCMDLaYBe1hXBrZrYlwiGGSHSDok
         pXSizoYiMRH4SlDMtM3vzfbypHoK9LgZcwtWIVb5SWY4Bl38FdeNJ6c0wyqc5khDoOcP
         OpUPkuGvMGIh8Ac5xTUZYR2pguh0PdYnag6XcohzkrhARhZTZacG3Zv2YwIYHC3dofLW
         326ITXsVjQ9zsDJC+TQssXvaBCNw8CcU0eteSjtSLASfB2TceCPngp/3vyTuFFNkcuUs
         8o6uwxuvozQ8zllh6Zw9V0QSMP47XLzlUUIt5LVEaXXNhxiPF5G2iTR+N9Z5M0kfuhey
         pP4A==
X-Forwarded-Encrypted: i=1; AJvYcCVq36DtJ9kJMApcmW07mUsThVMhlBzt4jcs98T1MysI7sZBk/GqsX8kV6vuU439nXq5amijAydgMwq7XIVz3b3aHQAudkcAFIOCRbzh
X-Gm-Message-State: AOJu0YxOfFN4om9OTPSQV5McHfvHbcLxiEQ/x71oSrrrojuz1BlZmPUv
	IxM6nqdPouiVaQrqBdTooJgkd5pKq+Sk6UndIo6xDfe/x0JGz6AySmva6vvyE5OqPTz+NEDNYO0
	27nt3OPvOSW3+Oh2p1FYsDeDiMHBbE4/YGAEr8nifqYOq+SSCka1XjcI3N4UkTNswT0uJhbyK3n
	QOB3VjuUqBIFGkqUFy5TW0VKd61HQSZ3QPpiTe7OkKMHyuCdHqBk9+
X-Received: by 2002:a05:690c:3612:b0:609:ff22:1a88 with SMTP id ft18-20020a05690c361200b00609ff221a88mr3109067ywb.44.1713970663329;
        Wed, 24 Apr 2024 07:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLj6vN82/lNMO93VtWofH8pTU6lK+eyGAXCYtefLHp0CWoW2WPTI12S+Ss5a+rfru0ns+AgDrPBoEFC+mLT9w=
X-Received: by 2002:a05:690c:3612:b0:609:ff22:1a88 with SMTP id
 ft18-20020a05690c361200b00609ff221a88mr3109036ywb.44.1713970662973; Wed, 24
 Apr 2024 07:57:42 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Apr 2024 07:57:42 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <SH0PR01MB08410B2FCAE1D9AA754865BFF910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
 <20240424075856.145850-2-joshua.yeong@starfivetech.com> <CAJM55Z-C7XkFo4STk3rdLG4kvPfed-AfrHB1QJ-Tzt1LDoKw9w@mail.gmail.com>
 <SH0PR01MB0841F8C45091E4A08020ADF2F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z9NAeRb_3ZBJksXt+4fJMdcYw55bfAs0EpSnM8VWBKQag@mail.gmail.com>
 <SH0PR01MB08415B9CDDFB1A4FAB0FC4A9F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z_G5EKSjHztCQ+gXDGwfpziZTE=HsHmwydJWB-uorMOqA@mail.gmail.com> <SH0PR01MB08410B2FCAE1D9AA754865BFF910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 24 Apr 2024 07:57:42 -0700
Message-ID: <CAJM55Z-6vqSjL3GPT7GqC1k01zH8+zexSpcOFFUpuZELAQxARw@mail.gmail.com>
Subject: RE: [PATCH v3 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
To: Joshua Yeong <joshua.yeong@starfivetech.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"conor@kernel.org" <conor@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Joshua Yeong wrote:
> Emil Renner Berthing wrote:
> > Joshua Yeong wrote:
> > >
> > >
> > > Emil Renner Berthing wrote:
> > > > Joshua Yeong wrote:
> > > > > Emil Renner Berthing wrote:
> > > > > > Joshua Yeong wrote:
> > > > > > > Add StarFive Starlink cache management driver for
> > > > > > > JH8100 SoC. This driver enables RISC-V non-standard cache
> > > > > > > operation on
> > > > > > > JH8100 that does not support Zicbom extension instructions.
> > > > > > >
> > > > > > > Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> > > > > > > ---
> > > > > > >  drivers/cache/Kconfig                   |   9 ++
> > > > > > >  drivers/cache/Makefile                  |   5 +-
> > > > > > >  drivers/cache/starfive_starlink_cache.c | 135
> > > > > > > ++++++++++++++++++++++++
> > > > > > >  3 files changed, 147 insertions(+), 2 deletions(-)  create
> > > > > > > mode
> > > > > > > 100644 drivers/cache/starfive_starlink_cache.c
> > > > > > >
> > > > > > > diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> > > > > > > index
> > > > > > > 9345ce4976d7..9181cd391f53 100644
> > > > > > > --- a/drivers/cache/Kconfig
> > > > > > > +++ b/drivers/cache/Kconfig
> > > > > > > @@ -14,4 +14,13 @@ config SIFIVE_CCACHE
> > > > > > >  	help
> > > > > > >  	  Support for the composable cache controller on SiFive
> > platforms.
> > > > > > >
> > > > > > > +config STARFIVE_STARLINK_CACHE
> > > > > > > +	bool "StarFive StarLink Cache controller"
> > > > > > > +	depends on RISCV
> > > > > > > +	depends on ARCH_STARFIVE
> > > > > > > +	select RISCV_DMA_NONCOHERENT
> > > > > > > +	select RISCV_NONSTANDARD_CACHE_OPS
> > > > > > > +	help
> > > > > > > +	  Support for the StarLink cache controller on StarFive
> > platforms.
> > > > > >
> > > > > > This is a bit misleading. The JH71x0s don't have this. It's onl=
y
> > > > > > on the JH8100 so far, and hopefully later SoCs will just
> > > > > > implement RISC-V
> > > > standards for this.
> > > > > > So maybe something like
> > > > > >
> > > > > > "Support for the StarLink cache controller on the StarFive JH81=
00 SoC."
> > > > > >
> > > > >
> > > > > Hi Emil,
> > > > >
> > > > > The StarLink-500 cache controller is not designed exclusively for=
 JH8100
> > SoC.
> > > > > While it is true that it currently exists on the StarFive
> > > > > platform, CPU/SoC that does not come with Zicbom extensions
> > > > > supported would need to rely on this cache drive to do cache
> > > > > management operations. I think we don=E2=80=99t need to mentioned=
 'JH8100
> > SoC' here.
> > > >
> > > > Wait, in the previous mail you said that future designs will
> > > > implement Zicbom and not need this work-around, but here you're
> > > > talking about other SoCs that do need it. So which is it?
> > >
> > > If you visit the company website and look for StarLink-500, you will
> > > find that it is a standalone IP that the company is selling as an
> > > interconnect. Anyone who integrates StarLink without Zicbom extension=
s
> > > may utilize the cache management operation from this IP.
> >
> > So then the "on StarFive platforms" part is wrong? Or will this always =
go
> > together with the Dubhe cores?
>
> It would be 'on StarFive platform' without 'JH8100 SoC' that you suggeste=
d.
> StarFive's newer cores that will have Zicbom extensions supported. Those
> CPU core will not need to have this cache controller enabled.

No, what I meant was that if you're selling the "StarLink-500" IP to other =
SoC
manufacturors then it will not be restricted to StarFive platforms. So then
"Support for the StarLink cache controller _on StarFive platforms_" is no l=
onger
true, right?

/Emil

