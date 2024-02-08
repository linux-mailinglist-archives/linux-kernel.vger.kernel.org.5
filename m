Return-Path: <linux-kernel+bounces-57771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967584DD3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EA2284EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3D6BFD2;
	Thu,  8 Feb 2024 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ievev3SY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB86A8B7;
	Thu,  8 Feb 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385649; cv=none; b=JS3wp/4lA3kz4f/ptkKOZwW8qSMBbVNrISWGrQhfvlVxRBNqQSET4zqjtQ31rDwSgDx84qFatbmo4h0E4l1GSU7UIxgj4M8t2wq6Jsj0wbYOT+qi658gyYM9nhtwSuWSKpojAWCVk/HaOccAx4inUz7OtRoFR4FZZKsnu52Eil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385649; c=relaxed/simple;
	bh=NJzTYxPGog+LHw69EzTQgjJrKi3/8IWhSZCZ12TQeTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fiued0Fezm1Lv3Spk1tpH6nmsmtNdboVsXfzqqVDUgbUOvXuJwGfy6Od9x6aeI7vl6TMnnJdOi6mwHj27HJKIM6aWAq1cd99EQ68Bf/aEumA9sngl/WBUuepCWNxvoLsrYVs/MksrDNPVWuUF6Rk9fy7g2UsocN1kr2qEQVKg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ievev3SY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a388c5542e9so126905266b.1;
        Thu, 08 Feb 2024 01:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707385645; x=1707990445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH3hgklJ1R75I/VpBMJ+510hVZo1X3MvgC5DTxJlxAI=;
        b=Ievev3SYGISIljGc9L95TWHsm4aaHm2deDlQ3h7XDI3nqfV5MSR1qAZwuwI7fsgEh8
         7UIDyiMMFJ7dV2JgYth2L3ctguRZ2ei2S1DkIsFxAMGTs3ZVq9gS81Gr0gCjJfuKYc8K
         ROBIiryRFIsxAzRGZG8LhBd8WOkrPtYqKekD1rr0EE8Agv7x4fQhPkBu2s2UX60x+umo
         DcUFt8kBR/5Mgbgqa223bR0nS0dmyGhxmAt2SY+x22jj/Vv7Vxz2aKVB4tX8vmUUwm55
         krXuk5c4ka4T+D5OoIwmfMJwn+5Ns9XCUdixoINCrW6p/ae4b6i+oUM3G7rzO4o4+nsI
         JgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707385645; x=1707990445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH3hgklJ1R75I/VpBMJ+510hVZo1X3MvgC5DTxJlxAI=;
        b=STIoDIFSdtk68k6fvAAWHer+0h1o7MR7ZsrsETDXSkOLymZbWb5yUUcebsnZJrw8IS
         PFJsckJJhGuPrdMC9vA8NsI5gJsg7w60CFnzDZHQzNubck5WD3aPpBkWwLSBAAA3/LX2
         4dxUC/LKtMkC/s1FhE+ki0PCazcIKz/D5SGulw+9AfjX+Vwdw45VVoqTzncY1Nfry9D2
         zeqcch7KWrQTMvTeX6i0yafnRtqLXEBRSdGwrDvv/a/Pe0OEjrDV/O9aYShDDgRVOTRz
         T1Ib2cCWxv9rgLypMQ3ALBGSuKClEPuN4OVsqfF6qjMK3xOHFQpG+i//J3lURH+urzVx
         quPw==
X-Gm-Message-State: AOJu0Yzbwm3tc2GReCzTFoKW9c6BwIHNHahjXZ6qoXw4KskrFhxw4Clo
	sJtaGIhzpu9x1VdcJYDCB79d/FCKodCbATL3ieHW2XKKA6FtmXRcAwRhzR+nfInppG0OksTh/S1
	24TotKsFKUf/GZjJvnKafko21j9BaQ0HPe3s=
X-Google-Smtp-Source: AGHT+IGezKKWZ25bbGDuM3CK5CVJTtXoxBQHcRsyoeEV3EpwXsWsIoYWuis+AHvCuxSKvkEOsZmGBuCOh9k6CbxtP2I=
X-Received: by 2002:a17:906:cc92:b0:a38:65e6:b996 with SMTP id
 oq18-20020a170906cc9200b00a3865e6b996mr1979455ejb.11.1707385644965; Thu, 08
 Feb 2024 01:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129131729.4311-1-lukas.bulwahn@gmail.com> <ZbsxfYVKqxwn5gl5@gondor.apana.org.au>
In-Reply-To: <ZbsxfYVKqxwn5gl5@gondor.apana.org.au>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 8 Feb 2024 10:47:14 +0100
Message-ID: <CAKXUXMynhktyTY8+JtDAuVHysV2g0eXy7dr09wvSqYxZ=paWUg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entries after crypto vmx file movement
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:51=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
au> wrote:
>
> On Mon, Jan 29, 2024 at 02:17:29PM +0100, Lukas Bulwahn wrote:
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2fb944964be5..15bc79e80e28 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10307,12 +10307,12 @@ M:  Nayna Jain <nayna@linux.ibm.com>
> >  M:   Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
> >  L:   linux-crypto@vger.kernel.org
> >  S:   Supported
> > -F:   drivers/crypto/vmx/Kconfig
> > -F:   drivers/crypto/vmx/Makefile
> > -F:   drivers/crypto/vmx/aes*
> > -F:   drivers/crypto/vmx/ghash*
> > -F:   drivers/crypto/vmx/ppc-xlate.pl
> > -F:   drivers/crypto/vmx/vmx.c
> > +F:   arch/powerpc/crypto/Kconfig
> > +F:   arch/powerpc/crypto/Makefile
> > +F:   arch/powerpc/crypto/aes*
>
> Are you sure about this? There are non-vmx aes* files in that
> directory.  Perhaps something more specific is needed here?
>

sorry for the late reply. I revisited this patch and now keep the
match exact in my patch v2:

https://lore.kernel.org/lkml/20240208093327.23926-1-lukas.bulwahn@gmail.com=
/

Herbert, I hope you are fine to pick this patch v2.

Lukas

