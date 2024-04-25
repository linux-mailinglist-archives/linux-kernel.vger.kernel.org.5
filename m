Return-Path: <linux-kernel+bounces-158933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E91A08B2705
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7651A1F2248A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6939D14D6FA;
	Thu, 25 Apr 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYaFQU/G"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F214D719
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064401; cv=none; b=JU5rz0OQYL/4BojBKqpuZ2x642ky6nRRIy79Givwyol0tj8HSQ+RnCUc56d6bmMewOI994oDp2wlNDAnqWcT6/qHANbSD475BV/1QV42Ecr6qTkA1ZRoiOjEsSbfxyWLoeT/flBVngl7Q1ZUirqSOsgEIoa6KKDsAed15PmfLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064401; c=relaxed/simple;
	bh=qg8SZwpUN3b6LrPjOtHyorXHH1MH2warGErNjkgQBM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Huny2kukFUWNapWNHZe2IUxaLltZGPG8SuOIqsbBRfJ9w79g2XNOfVOwblBcnevkdCWE5I0Dx4Z0a4dlKtHh+ziI0GiIHAk580/4fSG9bretPbYWUWboY7ryjoQ/D2bAyCRNUPvYLG9LdjDNqwrKCGFFqbqOcJzwx5pJtuTrH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GYaFQU/G; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de462f3d992so1439848276.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714064399; x=1714669199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5abisNcD/ouIsr1NPEiIQ0iyqWHLbaxlL3KzDHmL5pg=;
        b=GYaFQU/GPcag7Args3242vwOwSAIgS5F+azZOMhlh1ZOqpk66Ld9ccJlar2JtMVgss
         2+YPMpts8R5lV3JUQLNKV2LjtAP7rMuvjWo4VKFlVV7r8bI/7BRWQ+Sh9c+DkWI65u1t
         d+CbpiWem4C/6+u11CIpdRrNg0chrBQBBAmPB/n+R56+6woSfhqEBRac6PNZqpruyX0M
         P6ZqScqxBIB34jnPcT45GTIOSV5Fh4wf2e4Shp5x/IhrGH4zmkhRTnXwBLA1jC1Ihthb
         Ne3EumkCjymhbnUyTtSJMSLdW8z+uzJD+4mSrBOEnSjfUjl1vk0K4WnMDzlUuXZ7x59+
         41mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714064399; x=1714669199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5abisNcD/ouIsr1NPEiIQ0iyqWHLbaxlL3KzDHmL5pg=;
        b=Tc8M4KQPR1UMXlErOfMFbhcxJp3hzOcYfnt+1oW5VKgxGDDlcVpbQrE01eJHVY3zCC
         8y9Z440uYTLuRCJsR7nC6ZrSRQ9+B6l9z3kW8TTmJ7faOAruU+eqnVkW6RkuTzv8VocE
         aXHK41zNCW4XDBymePQDKaLn512HZSvrpTlbSQiJj6vC9zUMIkT7+VOtm5gWfTJyJkAe
         n9IgUksIFgvdP7E6KFybe/OOlwoN5eNOgapDO7YxdjIFVIM66yqc+qpuFhSJraPV9/pL
         QWJ8TtrMRMUvUH+RhLKNth3lXh2Lh7Mvrt7d+vuNyTCIwT7rTa9u4JqeDPBN18d7zuja
         4sKw==
X-Forwarded-Encrypted: i=1; AJvYcCXJsSmuYpo8+uzGSsjD0hg6Pr+5BtQj0gzAeUc70LHUVm+IoIOrgQqLxZW4kchjX/csjWsdYfogj2Sl4VSH1Lg+NCK1HvxnAKlscm4b
X-Gm-Message-State: AOJu0YwWcnfEc86iexcSXHw6LqhWYrP1vNtBYmdPI+8OEM0IM43eG9Jz
	7aGqgODL/AyZR/Om3hqMN+jpn/vxEI3tlOgZtwfg77kaEgjMMySVlVC1kM22h6X20h1EvQxuYDV
	zkD7QvmUK+L0dNz9uPfKp60jOYM6zmSrY0CKInQ==
X-Google-Smtp-Source: AGHT+IHkKcKP3Xkl9RLGgzMddUnSxCUtH/hPFybh4i6xbbQ5alH6FHv7MLw6RQGyZBUoFY7dwUsvAuMfUe7ru3m+fmg=
X-Received: by 2002:a05:6902:2b01:b0:de5:9b53:614f with SMTP id
 fi1-20020a0569022b0100b00de59b53614fmr309834ybb.38.1714064399145; Thu, 25 Apr
 2024 09:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327024545.138351-1-ricky_wu@realtek.com> <CAPDyKFo3dkzDDEU7Lk14zH0td0AP=z2RJQibj8SP6JeUuz=iFA@mail.gmail.com>
 <8b966794f2bb4fda8cc7d3e111bfef70@realtek.com>
In-Reply-To: <8b966794f2bb4fda8cc7d3e111bfef70@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:59:22 +0200
Message-ID: <CAPDyKFp=prNyPE8hT_9irx0DyFCboF8Ms6uh4Euxe0oyPq79fg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: resume not check card exist before powerup
To: Ricky WU <ricky_wu@realtek.com>
Cc: "wenchao.chen@unisoc.com" <wenchao.chen@unisoc.com>, "ricardo@marliere.net" <ricardo@marliere.net>, 
	"marex@denx.de" <marex@denx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 08:53, Ricky WU <ricky_wu@realtek.com> wrote:
>
> Soft reminder
>
> If this solution, you still have concert on sd.c.
> can we just do this check card flow in mmc host power up call_back?
>
> > > >
> > > > _mmc_sd_resume
> > > > add get_cd before call powerup, make sure the card exist
> > >
> > > Please elaborate more on what problem you are trying to solve, the
> > > above doesn't make much sense to me, sorry.
> > >
> > > Yes, the card may be removed while the system is suspended. Then, even
> > > if ->get_cd() indicates that there is no card inserted in the
> > > SD-card-slot, we may still have the card being registered - and then
> > > we need to unregister it.
> > > That said, we need to call mmc_power_up() in order to try to
> > > communicate with the card again. At least that is what the
> > > mmc_rescan() work assumes when it runs the bus_ops->detect() callback
> > > at some point later in time.
> > >
> >
> > We saw the power up in a short time from waveform when removing the card,
> > So we saw mmc_sd_resume call the power up did not check the card exist.

Well, that doesn't really tell me if that is a problem or not?

Doesn't the first command sent to the SD card (that has been removed)
fail if there is no card inserted anyway?

> >
> > We think this the short time power up maybe cause OCP if no card exist.

OCP?

> > And this power up we think is unnecessary when no card exist.

It may not be necessary, but in what way does it hurt?

> >
> >
> > > >
> > > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > > ---
> > > >  drivers/mmc/core/sd.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> > > > 1c8148cdda50..35e036672cfb 100644
> > > > --- a/drivers/mmc/core/sd.c
> > > > +++ b/drivers/mmc/core/sd.c
> > > > @@ -1750,6 +1750,9 @@ static int _mmc_sd_resume(struct mmc_host
> > > *host)
> > > >         if (!mmc_card_suspended(host->card))
> > > >                 goto out;
> > > >
> > > > +       if (host->ops->get_cd && !host->ops->get_cd(host))
> > > > +               goto out;
> > > > +
> > > >         mmc_power_up(host, host->card->ocr);
> > > >         err = mmc_sd_init_card(host, host->card->ocr, host->card);
> > > >         mmc_card_clr_suspended(host->card);
> > > > --

Kind regards
Uffe

