Return-Path: <linux-kernel+bounces-66899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5792685634F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4F1C236ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471412D74F;
	Thu, 15 Feb 2024 12:35:49 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51412C7E9;
	Thu, 15 Feb 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000548; cv=none; b=BC5TYpKVdJqcjeGnOyQ1zY26PACamIYpSnfEUHKKInuBb2OsNHXiuEzacv6JL7hNOfI0EuJibtwMU6pJyjdm/CLfST/tR9frFheCYUaIJIEAQpbdF73BNJ9RVXSs/jgvtDmBMMobHwPK46AZ5FJwIdufe522tIx+cjZEkB3Id94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000548; c=relaxed/simple;
	bh=LwzDR4yCn3d14jXIBaDJKNvSf9WMsivayM9j3LY1rmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIOiOrSYAT6mn9WVFNmXg8B5XCIqtrEeP4MAG5ZFY7anIA/sFF59vZW4lQ6hXiMwFsTlAytj+aZqBPDQeuQKoPi3NHgIaWlzBxPwv41dEWMcRV83JHIHJk12LFbCu7YnFfNDaojsXBiAbLuFqdxw7pK0iWdDOwy8TDaWECYzzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607d590aeb5so4442597b3.0;
        Thu, 15 Feb 2024 04:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000545; x=1708605345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADZIKwAMQn9TDB/vs6/mOoxFiY3uTl3NN2VFTg7/dd0=;
        b=nzjV4s8m2ZrptQVaELl2KKVfDulmK+qJM9jkz0YGwPt+ZPAQDxpMGGecROte0jSN4U
         elbg8fbX4n+koGUpqA3vLsiRLnUMEtJNlGkOsgCU7iGAsCvT0Ro7iWdEj9Ls2c0xJ+ua
         lrUlIhp5Qi21mGDDVnB0JlahrxcnPMrgHE6t1of0vz3bVaxxzDwTgN2p8ZYm7DHGMUkD
         1vDAr7Sn8iUeD/XD5YPrzpmshZUBV8ocyCFe9vPmDrx4HgezliwRofHfd9UQ68ENTGTU
         5KDnN8ZeReVVFe5frQFNuJ17R28DsG9eUUMdUY87eNxyIuMNjdTRzfAU0zhQMvuGQbmi
         B4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdlMzmq56xKlsz5Q91XuCV7CVGY9ZnH1+oOo+2yWMY3/Klzn/KZl8xzSOMcc6MF937FbcrCsDZa0durUedeVVFu4upxlwkjxEA4+bS
X-Gm-Message-State: AOJu0YxlaB01iyo0JD5oZL9xWkxTs++pNK//sNaiiOLkrkYYku3Xc36h
	glkAmblvvugDa79n5ik4f6RqAuFIsYb+KXqsewED2q3kACJC7lA+kyI+5Efi+NJATQ==
X-Google-Smtp-Source: AGHT+IGFWqqR6HnswriP1lmNSKOp68Rjax+ajQrr8h4aC52tN8ph1ViaLE6ozZlNJmgvh0ji1N8u7g==
X-Received: by 2002:a81:4916:0:b0:607:8d3a:61ad with SMTP id w22-20020a814916000000b006078d3a61admr1578831ywa.44.1708000545036;
        Thu, 15 Feb 2024 04:35:45 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id j13-20020a81920d000000b00607ac837eb5sm225012ywg.13.2024.02.15.04.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 04:35:44 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607d590aeb5so4442347b3.0;
        Thu, 15 Feb 2024 04:35:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6/qEpf0yM47ILtyFvCygxlaS5w3WPaiCe9A5W0Nnmgwg+03CkqXJ7jDR9PULQNwVLwRFqwXcDBSIL93JTcLRcOfW6TMSb7a0W+n2n
X-Received: by 2002:a0d:d5d7:0:b0:607:76c6:4ed9 with SMTP id
 x206-20020a0dd5d7000000b0060776c64ed9mr1714640ywd.41.1708000544622; Thu, 15
 Feb 2024 04:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-8-andriy.shevchenko@linux.intel.com>
 <CAMuHMdW=gTH12vLALAU_ioCKX9E2mJ3uR+8Q6GT0brc4yg83_A@mail.gmail.com> <Zc3147U697zQ6OwY@smile.fi.intel.com>
In-Reply-To: <Zc3147U697zQ6OwY@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 13:35:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWqfUHGP4t17=4UVE0uOFqwpc7dF8D9MCU4EmdYSnfjDQ@mail.gmail.com>
Message-ID: <CAMuHMdWqfUHGP4t17=4UVE0uOFqwpc7dF8D9MCU4EmdYSnfjDQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] auxdisplay: linedisp: Group line display drivers together
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Feb 15, 2024 at 12:30=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Feb 15, 2024 at 11:05:00AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >  obj-$(CONFIG_CHARLCD)          +=3D charlcd.o
> > >  obj-$(CONFIG_HD44780_COMMON)   +=3D hd44780_common.o
> > > -obj-$(CONFIG_ARM_CHARLCD)      +=3D arm-charlcd.o
> > > +obj-$(CONFIG_HD44780)          +=3D hd44780.o
> > > +obj-$(CONFIG_LCD2S)            +=3D lcd2s.o
> > >  obj-$(CONFIG_KS0108)           +=3D ks0108.o
> > >  obj-$(CONFIG_CFAG12864B)       +=3D cfag12864b.o cfag12864bfb.o
> > > -obj-$(CONFIG_IMG_ASCII_LCD)    +=3D img-ascii-lcd.o
> > > -obj-$(CONFIG_HD44780)          +=3D hd44780.o
> > > -obj-$(CONFIG_HT16K33)          +=3D ht16k33.o
> > > -obj-$(CONFIG_PARPORT_PANEL)    +=3D panel.o
> > > -obj-$(CONFIG_LCD2S)            +=3D lcd2s.o
> > >  obj-$(CONFIG_LINEDISP)         +=3D line-display.o
> > > +obj-$(CONFIG_IMG_ASCII_LCD)    +=3D img-ascii-lcd.o
> > > +obj-$(CONFIG_HT16K33)          +=3D ht16k33.o
> > > +obj-$(CONFIG_ARM_CHARLCD)      +=3D arm-charlcd.o
> > > +obj-$(CONFIG_PARPORT_PANEL)    +=3D panel.o
> >
> > IMHO it hurts to not sort Makefile entries alphabetically.
>
> I can add blank lines to follow the same grouping as in Kconfig. Would it=
 work
> for you?

Unlike Kconfig, this is not user-visible.
Most Makefiles use sorted entries.  If they look unsorted, people will
just add new entries at the end.

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

