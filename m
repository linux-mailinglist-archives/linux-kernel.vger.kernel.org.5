Return-Path: <linux-kernel+bounces-60151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A58500D1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA481C24A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8C38DEA;
	Fri,  9 Feb 2024 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcA3RQ2P"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45437712
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522133; cv=none; b=dCiZ3YSbAMFErKydjn7h3VyxYw1upZdBgRSPuzJG7HpBd4CmbMwtzGJlQ8Lana9JCG9Bx7qfuQwnWETjHTFHlw2rbrbx/QAPofmtKLXW17Qgiala+FCmSSzr8UemOB+nUtJRx0lQKjW6JOgi5+4LHT1o+QpnI0rDhZCv3Fl2XTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522133; c=relaxed/simple;
	bh=36Bp5V3HrWBZbS46TYrpP52qQdL28XvTzmsXoRqxpGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3v2SFRcJhxQKydbGp5KJwjSR4IT95pG15EAb04RT4gQIUEsaxM1pjXCwytaXTSD4t0gsXCaFT6Fp+fvBL3e/tw4I23K2Oi8jOSh50cE3tor/lteh2R0o+BPXmjvvlZ7B/8hv5WeoCkaWSAwruCWlUYO/X8u7tOYsn5/Sm3ir/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PcA3RQ2P; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2237433276.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 15:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707522130; x=1708126930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Bp5V3HrWBZbS46TYrpP52qQdL28XvTzmsXoRqxpGI=;
        b=PcA3RQ2PJQ/gQKp5Cbpb6Iyf1ol8kyLN0c/63Z6kA6JiW4NDdE0EtJaJkT2NyxXXMy
         Kyg5hdLAEPPNzB04lqr5hn0ILOjhm6/z7b3nh72UL9jePV13NKv6XRsNQ32UYHQX/sKc
         Mmap00ZUMCx8I848Z2GGHIuBpal/DUZjBCBz7OSHOZYEiRPXkng1ZmBtr+C9h83QY3v7
         2+limIbSa2U1/MlnGpPTyEYskY5d8oRshKsEVbSxvABbSzJ0y9Ld05H+5JDEiw+W/9Dz
         rLw3MXxoCUbIEtd6uqs73wvDSKnO5Sxs61WxY6Pm1sh8lqIOlcEeMfGTxx+w1e9YqGvi
         mC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707522130; x=1708126930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Bp5V3HrWBZbS46TYrpP52qQdL28XvTzmsXoRqxpGI=;
        b=fd3mw3Swo+T3U4sFuTbG/mqlGBetz+t3COxqU2fwLWypZa9mh0YF1futTpqO1LDpRO
         toluqyEnbGgPNy4WIRC8XRzxdQB/djiRUwgriVxEP6dRDeswZgFVD63Fp8GrF9fRBLVM
         XJUwFX8wwj/C/UeT8EUkyqgc1g8MrPK3adJ4+ckGATmWV3BZ+cFftqXlqCukEOtTDYyu
         t/zWgC2HLAXT0bPxthOv1DkO1k7OOAuJEG+ywE1ncglRRZHpfPt/HZwsKIhri8qzBHEe
         G059rWfmvLIJI6iUVbRn5D3VvIIRFx+opQwupgwOhpzotKYQN6KVoQk2LrciOzkpUjIq
         OVNg==
X-Gm-Message-State: AOJu0YzB3FBpQqKTtrdlS+g4oeCH+4nawvKRA/hlqa97JxEYyXfn2wjl
	hej5bv7ZdNwbXp6N2n9tZl8P0FpNFrYH3QvrHlIS1z5njqPM2PiJBL+35QIQGivpcUcZsBHthrO
	oKsaAggl0DZi4iON1ZCbImA5t6SoCSl5+CJIxQQ==
X-Google-Smtp-Source: AGHT+IH7eTrIingP+ahCyJb1b55HFte2tzebTYQbAUv8STciXDuToLLW+b9233LY5KATmB4DKaN2RVXULUm1vcU1YrI=
X-Received: by 2002:a25:7187:0:b0:dc2:2d55:4179 with SMTP id
 m129-20020a257187000000b00dc22d554179mr2436830ybc.17.1707522129933; Fri, 09
 Feb 2024 15:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
 <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com> <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
In-Reply-To: <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 10 Feb 2024 00:41:58 +0100
Message-ID: <CACRpkdb=aDd+CuJhckE9xZjA4MXRS_BD=qd3sc3Qjnm7CNbATA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:35=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-lin=
ux@rere.qmqm.pl> wrote:

> > I think it's worth mentioning the cb710 example here, which
> > uses a platform device as a child of a PCI device and
> > does not assign a DMA mask nor use DMA.
> >
> > This one will see a change in behavior, meaning that the
> > blockdev buffers are no longer bounced. As far as I can
> > tell, this is fine because the driver appears to correctly
> > use the sg_iter infrastructure for mapping data pages,
> > but it would be good to have this confirmed by
> > Micha=C5=82 Miros=C5=82aw because this code path has probably never
> > been tested without BLK_BOUNCE_HIGH.
>
> Hi, this driver doesn't do DMA at all, so having DMA mask set or not
> it should be good as long as the CPU can read/write the buffers.

The only difference is where the CPU have to read/write the
buffers really, before the change those were all guaranteed to
be in lowmem (bounced there by the block core), now they can
also be in highmem, but sg_miter will deal with it for sure.

Yours,
Linus Wallej

