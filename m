Return-Path: <linux-kernel+bounces-82126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC82867FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABDFB24684
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C112F362;
	Mon, 26 Feb 2024 18:13:29 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65FD12C815;
	Mon, 26 Feb 2024 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971208; cv=none; b=Y0RVjWvnK+aH/Hk6SfmEWT8r/N3IOmQFMiGRG6DzHWAd+j83ygvn8nu5g7J6vwrn0BMxUM9gfnRs4LEIZMje/ccU+v9x5fTejMQ/+PvYvTPQLO/7XpIdg61Kd3JGAkW4lIfAvnkKqPNjVXaAFzaopri1T8SMWKkaZllOofQQ5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971208; c=relaxed/simple;
	bh=V6vYivW5ixHA4tMyXOoEY0KpWK4+ihx9tbl+aDLjJFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4gquhEQGFHhTZSv+qoCIzuAUq3SxgD2ECMVRw5T9mFb5MhO4P/zheNvlnVBvN5CmJPx9U5bjXf4WpWrc9aMs8IqRckp4Nfm+PnlaurmWFx2Hri6GLeWBUpBqAwOXADEPEJNuu78Puvd7EPn14kRGWbDrJX4tvrBuHWk78rDmic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607eefeea90so32542857b3.1;
        Mon, 26 Feb 2024 10:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971205; x=1709576005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RSmvdNSLXddAAwmpgrKIJMq/KDLPk9IVeQfKMlVWBA=;
        b=T4Etck3tjKc4fHWaBKb9fhTDK5+ukN2IyYb7lbc+EYTeIP4fbUkstwgc0SX+j9qtLi
         CvDXriYClHdCBpZfxCVc8hMgMjaXecaMt0TTX3B0mF2nyt1LIN57stvXX5K4lBh08DUD
         pq/yZSZwKBJ/CHx2HUrY7WkYLRZdEGk0VPDbcymZUZr3FMd/Pg+PkN6c2jHxKEVDPWVE
         KnBVz7fA8EKMN/5SGM7NeJvxs69vCeRUop8fVyRyFaDBId3EXSjgObAFUOzDfAYpCdtM
         e6WJAiiAy1AhCVUgQVvAacV/Uo/fOpnjs0McmtUUceTLQySKhjVl+2B0O9LJU86kY2Wu
         bXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6dVXvZQsfVvn3tTJ2Guv8t9yx39irMsRJunLpGEbRGEUShSXGavgcySB3d36kSL/mJctN/Iv0e+O/FYt6xdmJamBU9NvLiX3yl59xMQgtmSnyZiIzLZXPBT9AIJv+loCXeBCTpCiBuA==
X-Gm-Message-State: AOJu0YzHnnc2lsLRS1GwRbTQyLJuPMIcJCxRMvuVKBgo3WQrjNfhGjQ4
	xExA9qMIrL7TcdasKkA8omf4eHkovWszfj3BsUzTLP7PywNu/txOoMwsMvlnTJ4=
X-Google-Smtp-Source: AGHT+IFbEb4h5YA16Bsx/gw6HU25M3q1Y1TenMy7lvnbIHrPwZbboN99Jcv0Aavh3fmWlhL44S4Zvg==
X-Received: by 2002:a0d:e813:0:b0:608:e551:d9e9 with SMTP id r19-20020a0de813000000b00608e551d9e9mr2868502ywe.16.1708971205548;
        Mon, 26 Feb 2024 10:13:25 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id y132-20020a81a18a000000b0060799657d41sm1287012ywg.22.2024.02.26.10.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 10:13:25 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2681329276.0;
        Mon, 26 Feb 2024 10:13:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDwUYQEUQqfA0fSlF6CQHixQO8iWVjsDx6O77v0BBa12F6qmWCKy5ZdaEzEJZfThKlutyDdGG9veZV3r91vyW8rtMRdSq19gm+9f+DwL6xBvkWXFGEeGXTLykWLi8gM0tdxlpOVrhSkw==
X-Received: by 2002:a25:bdd1:0:b0:dc6:daa4:e808 with SMTP id
 g17-20020a25bdd1000000b00dc6daa4e808mr4559593ybk.12.1708971205242; Mon, 26
 Feb 2024 10:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <ZddRZWftWhMHUl23@smile.fi.intel.com> <CAMuHMdWQ1hx143eJYyCcEj-uqQ3uXLWfB_x70bQDn=wp3kQG7A@mail.gmail.com>
 <Zdy7PH8R21Zgzq1t@smile.fi.intel.com> <ZdzRxFG0WSDL8p6K@smile.fi.intel.com>
In-Reply-To: <ZdzRxFG0WSDL8p6K@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 19:13:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZYwaSaCDRE-sxh75d11=wXfxDPNrHd-LXTVkcxN4SaQ@mail.gmail.com>
Message-ID: <CAMuHMdWZYwaSaCDRE-sxh75d11=wXfxDPNrHd-LXTVkcxN4SaQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] auxdisplay: linedisp: Clean up and add new driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 26, 2024 at 7:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 26, 2024 at 06:24:29PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 22, 2024 at 02:56:35PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Feb 22, 2024 at 2:51=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Feb 19, 2024 at 06:57:59PM +0200, Andy Shevchenko wrote:
> > > > > Add a new initial driver for Maxim MAX6958/6959 chips.
> > > > > While developing that driver I realised that there is a lot
> > > > > of duplication between ht16k33 and a new one. Hence set of
> > > > > cleanups and refactorings.
> > > > >
> > > > > Note, the new driver has minimum support of the hardware and
> > > > > I have plans to cover more features in the future.
> > > >
> > > > Geert, would it be possible to give one more round of reviewing/tes=
ting
> > > > this week? I want to close auxdisplay for next merge window next we=
ek.
> > >
> > > For 1-7 (linedisp and ht16k33):
> > > Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Thank you for the testing and review, I have pushed patches 2-7, postpo=
ned
> > patch 1 and will see what I can do with patches 8-9.
>
> After discussion I have applied the patches 8-9 as is in this series with
> Geert's tags. The other things are considered as new features that can be
> implemented later on.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

