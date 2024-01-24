Return-Path: <linux-kernel+bounces-37072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB783AB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF1F1C233D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A4777F14;
	Wed, 24 Jan 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1xQhb0O"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8000768ED;
	Wed, 24 Jan 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103677; cv=none; b=AkLP+/RUYP8PnujyS59F3DY4CF0E6shIExPH4Ym/wjI0qwZSbqrfWbLNDibm4AFDbfxnM2H0fIwdElPESxj2WlPoNRITEpZp87vby4z9gJeWd64SsMJmaobBUl+biuQ1NSAEpOsOe4aOgKajgI3HngqJu0uMi6LGsk7k0s1/nDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103677; c=relaxed/simple;
	bh=vT56aOtM7NbazYC3SYCMw2nVTSk/SFiY8y0USRd5iNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcqZ+2E3FotsH1H+Qa5kDOj2w2W11V4Vmr0cWKBBD2Zjnwl4L0FG46GU/PGhHeuJEN+EO44qFY/17HDoKz08rJ7bQGBRrBDrn33tRviSVIwQiuakn7PHe1hqYyi1Ivvxqwjzsv+/TbU9RjgmPforh9jZFJQr9VirnqI3C4SL820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1xQhb0O; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4267063a12.1;
        Wed, 24 Jan 2024 05:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706103675; x=1706708475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPiT1Qhh91E0XEYww6R8qQ4X6cf8yA6zsbUZdShM0TM=;
        b=C1xQhb0O+f1S71XBaTxTvH0xmafOraekDCh66XXSq4XD5gTinD7GRS7KtMbygt8Ic0
         zEBaczwaAvR9fuSCsQ+R0NZF1/O5tBvbkwDFuL/NFWpcexSXtMCf5lNQrLSs0nz73kL3
         70ZcIu0DA8ErxeH65xGNpNjf26+GSonVP7kMDrT2kDGXf/uesylKpWx3jHNxN+spzlFv
         WnX4wUnfqEn/ngjYLRk2gAaHhgdGaROk+UA4f7pfYiLZtn4PrxSUjxrPeuLXvMs0AShx
         cNWI+vaLGK2pTQEIHWJeCjsNvKh0McdALXtHySPCTed6lTcEb3IxQ/mHFrhMD+MuoVnO
         O5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706103675; x=1706708475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPiT1Qhh91E0XEYww6R8qQ4X6cf8yA6zsbUZdShM0TM=;
        b=aS4EJZ+vGZTMIwqhcuFwuxIAIJibIE0VWqXdqQSaEFW272gtEjWKY65UKjWNZ3ECUg
         N6nShHsU0sFkLV5QyPqgW4+CRzxPGH+7wJTMAsbSkgkXjj2Hv05zXvgzvuoJYz6zC+AJ
         oLALqSkJ1/3nQ2+e+2OfF5EPAVpr71fWCPhkT/KizPBRXtkwsVwN1ICKjTXffuwWjuto
         kJr55aB9FHWJqi+BuudK/ExcYk8NxaoCdf1vjlhlXVgOTHEPFmKkkmvcKiiu9t54GprQ
         7xTYQrG6rVJOUiBH1HMvEVhFhaAxKqtOgYVFwKKGfy2qVcy0RWV/c3inl73OI6GMaZzn
         XDEA==
X-Gm-Message-State: AOJu0YxU8uyZ3wxEKg6f1ZLunq+t/CLfu1ULf8y+zwtKgkP7Mw+PDlW2
	gU0foJkqXd00wtswgHfkNWYtoCCDHKspH+1nWvZJLrBmriLr8t9eOIbyIqhd8cYaznOo7Am1Ui3
	yznUMyq2BZ0beuae7JiJ+YHLpW/0=
X-Google-Smtp-Source: AGHT+IGP6YXUaGzYM4yxoSE7nwBee670s9Z3031Lw2CVZaNspnB+VAkHTB0Tkvm8A2KuFDnErI6UZYWTZqRURL/0uCw=
X-Received: by 2002:a17:90a:cb82:b0:290:cd3:a2d2 with SMTP id
 a2-20020a17090acb8200b002900cd3a2d2mr4358965pju.3.1706103674987; Wed, 24 Jan
 2024 05:41:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com> <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
 <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu> <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
 <CAOiHx==FzSyyqP3NzLTeOSVxUQYy3ZhypZrDLsc-OjGCdSzvUA@mail.gmail.com> <801eecbe-4bf9-4bb8-9de0-1a7ca6673ddf@roeck-us.net>
In-Reply-To: <801eecbe-4bf9-4bb8-9de0-1a7ca6673ddf@roeck-us.net>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 24 Jan 2024 14:41:03 +0100
Message-ID: <CAOiHx=mM7kpzR-MOshsgXZM+CSB0nawfWxMhpt=tuhmJyMTCzQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2024 at 18:47, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 1/23/24 08:50, Jonas Gorski wrote:
> > Hi,
> >
> > On Tue, 23 Jan 2024 at 14:56, Mark Brown <broonie@kernel.org> wrote:
> >>
> >> On Tue, Jan 23, 2024 at 01:26:04PM +0000, Christophe Leroy wrote:
> >>> Le 23/01/2024 =C3=A0 14:18, Mark Brown a =C3=A9crit :
> >>>> On Tue, Jan 23, 2024 at 12:04:30PM +0100, Herve Codina wrote:
> >>
> >>>>> Moving the SPI_CS_CNT_MAX value from 4 to 8 is not enough to handle=
 my case.
> >>>>> Tested moving SPI_CS_CNT_MAX to 16 and it was ok.
> >>
> >>>> OK, I've also heard 12 as a number which this would cover.
> >>
> >>> By the way the comment in include/linux/spi/spi.h is confusing. This
> >>> SPI_CS_CNT_MAX is really not the max number of CS supported per SPI
> >>> device but the max number of CS supported per SPI controller.
> >>
> >> Well, it's a combination of the comment being confusing and the
> >> implementation being a bit broken - we simply shouldn't be limiting th=
e
> >> number of chip selects per controller, the per device limit is much mo=
re
> >> reasonable.  So ideally the code would be changed to reflect the
> >> comment.
> >
> > At a first glance at all places using SPI_CS_CNT_MAX I don't see
> > anything being broken / reading out of bounds if a controller has more
> > chipselects than SPI_CS_CNT_MAX.
> >
> > So I think the check of ctrl->num_chipselect in of_spi_parse_dt() is
> > bogus/unnecessary and is in the wrong place, as this is for parsing a
> > spi device node and not a controller node. The following check for the
> > amount of chip selects defined for the spi device should just check
> > against SPI_CS_CNT_MAX instead of ctrl->num_chipselects.
> > __spi_add_device() later will ensure that any chip selects are valid
> > chip selects, so no need for of_spi_parse_dt() to check that either.
> >
> > But I didn't do a very thorough read, or even tested it, so I might
> > have easily missed something.
> >
>
> struct spi_controller {
>         ...
>         char                            last_cs[SPI_CS_CNT_MAX];
>
> does introduce the limit for controllers.

Right, but that is AFAICT bounded by the number of concurrent/parallel
chipselects supported by the API, not the number of chipselects in the
controller. It only ever iterates over it limited by SPI_CS_CNT_MAX,
and never by spi_controller::num_chipselects. So even if
spi_controller::num_chipselects is higher, it would not lead to
accesses larger than SPI_CS_CNT_MAX - 1 to this array.

For some reason we don't store neither the actual number of supported
parallel chipselects in the controller, nor the amount of chipselects
used by the spi device, so all loops always  need to iterate
SPI_CS_CNT_MAX times and check for the chipselect numbers not being
0xff instead of limiting by the (possible to know) actual number of
chip selects in use.

Best Regards,
Jonas

