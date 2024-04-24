Return-Path: <linux-kernel+bounces-157108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D48B0CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51EB1C213AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF915ECC9;
	Wed, 24 Apr 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="L71uEKY1"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D51E501
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969865; cv=none; b=uSAWcjzIPDz+zYE3t4Hd4hdlka3v8MzYt8KPVLP5SjCmSDrLnVv2vJlyNVNRx3AGMF5CoKdFXrPwxzl0eSsJyDfcYYWhutHCBPwBMGQfh/eibbVZQW8WC8c6aJy7dRdOm1vYt7tTo4Kykx0qHCnce2eszJRZE+KVEUPoBrn2UlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969865; c=relaxed/simple;
	bh=uWg8+ZtPG/ZLFFpZhnCvLb3hEOIhDlfyUNRqDJX575U=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqbkP3SMOCMeow5hzpI/6pFBS4klz7w+ZtVpyKkCNQSUP+6WKAspv29loQ5vwHDn+HPjgetxhWYABrLvcGASlrhdY6wcbery4/IiP/l0y5XRPqNYnG9AiOF5kpCuQlKd2TdyfJStUZDMeZpOWWQQPKC6EYf7f82Pv4+PXQwtoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=L71uEKY1; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D8933411E9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713969858;
	bh=cDX/Ta7sZiIBn1XBmkDtAtlryH2vK9PZZdp/V3uN0rM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=L71uEKY1PYxrzqFHLPJpKullI8cf/v6xYlugw8vkM0XZRb/u3zDAK9bzNPXOzx18W
	 N3OCngNDCbzpA5GWI2pC1NdNKrX56kk3CXGCR0XOjEJdCatrbGlQKuWjEyk73LcgdF
	 6RkrTO4g9ZqxGK48SeiiRGleJ4Su4FOZR6yZ3EV5XLuduSiGkQ9kO5efkwdvkBN4fI
	 U+HJ2gXwo/9loC3kgziscJJjU0FR/Y+ssmfa7F5e5/lH/KeL8EyHjIV+gGoJlml4Si
	 ZVjj9/ranb8WsNzOMDCSGthbyBIHtlOhHSKdL0XGkHWqS74Dghe80l2recxltny87s
	 WtOZyU6muSqIw==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-61afa79081dso116608707b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969858; x=1714574658;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cDX/Ta7sZiIBn1XBmkDtAtlryH2vK9PZZdp/V3uN0rM=;
        b=URvmnikHZ/HPhg0fRCCEmNdW7h9ip/D9Lt1UqB1nRUCvN0QVVLcM5CUb19AldbDi2K
         KdYz5uMpgQmAaj/tGvPKwunle5KvgVwLbS2WxP0JKyKSE6dM0SzUaY+Q53MgV45q5jIX
         t6zFbvHLE4HbOdLypWQBGZhEmcJyVMzxLp8kwW70VKcDwLV6OTMyJh1ftXihMDUra61H
         rgUhrWWrBTeNMc9f7Tx1e9bIrx/uxkx9WTR9sgkZZerFOzHVf8dH+vOUdhicF5os8oAk
         mUVus4EL7Gd6nEGw0/xFNLjvkKXwY9FryEGV8HVea1Vm1XXq10APDwhoW1ADae4Qh6dM
         I8Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVhdp9jJEln4cyPK9FMdBHBwUeI8ZIKPDw14PTr45rO2mvXc3TTDV4tQviy2LSxopEniy2hkz94QlVvZtVILVC+eP6bsChKAO0gn7OB
X-Gm-Message-State: AOJu0YyqNlcF8zI70CV8wA08QB1Zk4ppPNHY0GJ4gUWlCI/dAWzSXN8x
	siwUfidLOyVZjkrL+Odgao/1ZhKxA3yBobV9KKhRbtu82j5+mVA1WQ0G/aKEkVIHnv+joiBwUXD
	Bbcdy0OksCL4h+tPL6NaGNpTZUsfAT2daVbz0jQJRe0eVzkRSDMYmCTZvknU/qVNy1XAmy0wLLV
	TQwssttDzVY3O7kzn800OJmVXR3zEMtxhCuHTobirF6ErgUvu3pR5JWFX3ilzV
X-Received: by 2002:a05:690c:7484:b0:61a:ae0a:1f4d with SMTP id jv4-20020a05690c748400b0061aae0a1f4dmr2670986ywb.17.1713969857834;
        Wed, 24 Apr 2024 07:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAnkvq38wN8yqT3TvahJf1BBokL9ppAftSGKph8yTZ41xJ8L68lNa9+ahDLaDOVmyJ5hmuy3djep2ZQx+2DTg=
X-Received: by 2002:a05:690c:7484:b0:61a:ae0a:1f4d with SMTP id
 jv4-20020a05690c748400b0061aae0a1f4dmr2670968ywb.17.1713969857512; Wed, 24
 Apr 2024 07:44:17 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Apr 2024 07:44:16 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <SH0PR01MB08415B9CDDFB1A4FAB0FC4A9F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
 <20240424075856.145850-2-joshua.yeong@starfivetech.com> <CAJM55Z-C7XkFo4STk3rdLG4kvPfed-AfrHB1QJ-Tzt1LDoKw9w@mail.gmail.com>
 <SH0PR01MB0841F8C45091E4A08020ADF2F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z9NAeRb_3ZBJksXt+4fJMdcYw55bfAs0EpSnM8VWBKQag@mail.gmail.com> <SH0PR01MB08415B9CDDFB1A4FAB0FC4A9F910A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 24 Apr 2024 07:44:16 -0700
Message-ID: <CAJM55Z_G5EKSjHztCQ+gXDGwfpziZTE=HsHmwydJWB-uorMOqA@mail.gmail.com>
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
>
>
> Emil Renner Berthing wrote:
> > Joshua Yeong wrote:
> > > Emil Renner Berthing wrote:
> > > > Joshua Yeong wrote:
> > > > > Add StarFive Starlink cache management driver for
> > > > > JH8100 SoC. This driver enables RISC-V non-standard cache
> > > > > operation on
> > > > > JH8100 that does not support Zicbom extension instructions.
> > > > >
> > > > > Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> > > > > ---
> > > > >  drivers/cache/Kconfig                   |   9 ++
> > > > >  drivers/cache/Makefile                  |   5 +-
> > > > >  drivers/cache/starfive_starlink_cache.c | 135
> > > > > ++++++++++++++++++++++++
> > > > >  3 files changed, 147 insertions(+), 2 deletions(-)  create mode
> > > > > 100644 drivers/cache/starfive_starlink_cache.c
> > > > >
> > > > > diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig index
> > > > > 9345ce4976d7..9181cd391f53 100644
> > > > > --- a/drivers/cache/Kconfig
> > > > > +++ b/drivers/cache/Kconfig
> > > > > @@ -14,4 +14,13 @@ config SIFIVE_CCACHE
> > > > >  	help
> > > > >  	  Support for the composable cache controller on SiFive platfor=
ms.
> > > > >
> > > > > +config STARFIVE_STARLINK_CACHE
> > > > > +	bool "StarFive StarLink Cache controller"
> > > > > +	depends on RISCV
> > > > > +	depends on ARCH_STARFIVE
> > > > > +	select RISCV_DMA_NONCOHERENT
> > > > > +	select RISCV_NONSTANDARD_CACHE_OPS
> > > > > +	help
> > > > > +	  Support for the StarLink cache controller on StarFive platfor=
ms.
> > > >
> > > > This is a bit misleading. The JH71x0s don't have this. It's only on
> > > > the JH8100 so far, and hopefully later SoCs will just implement RIS=
C-V
> > standards for this.
> > > > So maybe something like
> > > >
> > > > "Support for the StarLink cache controller on the StarFive JH8100 S=
oC."
> > > >
> > >
> > > Hi Emil,
> > >
> > > The StarLink-500 cache controller is not designed exclusively for JH8=
100 SoC.
> > > While it is true that it currently exists on the StarFive platform,
> > > CPU/SoC that does not come with Zicbom extensions supported would nee=
d
> > > to rely on this cache drive to do cache management operations. I thin=
k
> > > we don=E2=80=99t need to mentioned 'JH8100 SoC' here.
> >
> > Wait, in the previous mail you said that future designs will implement =
Zicbom
> > and not need this work-around, but here you're talking about other SoCs=
 that
> > do need it. So which is it?
>
> If you visit the company website and look for StarLink-500, you will find=
 that
> it is a standalone IP that the company is selling as an interconnect. Any=
one
> who integrates StarLink without Zicbom extensions may utilize the cache
> management operation from this IP.

So then the "on StarFive platforms" part is wrong? Or will this always go
together with the Dubhe cores?

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

