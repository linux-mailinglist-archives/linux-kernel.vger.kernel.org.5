Return-Path: <linux-kernel+bounces-122899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6C88FF2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695BA2936A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F37EF13;
	Thu, 28 Mar 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCcqPo2h"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970D7F46E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629543; cv=none; b=BHanyK6UpgjJiIjUMojYQCvi7+T2JMgakg9SQrHYnMx0aG4i+q1PttUrFGyDdEjbEp7gwVJ1ARphsPTjO46pJCZ591biibBP8YxLG6BovFbUGe5RoXBz7YTOWg3ufUQ2jx13T//4mlVoqiwCUP76FD2Y14hhjlVQMJ4vCO6x/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629543; c=relaxed/simple;
	bh=i3zyUL1p+Drh++oy3h6WA7kTXggCpKM16wFE0I1SiNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSLWBioXiaEo+eoU8ifVyeFzLQd8sRbR/rXe7An4DO51KmWDXTG1/bpaZWKS6z0egV+yqrBXuDsN5kL7iwjJATY36hKxOEdlz2Md2WsDF/YOK2B/6Z+QGTsYqD9cUufT1hG536r996ceefXGFmRq1NtMD8VYbj8Jdid+276IC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCcqPo2h; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61424186a13so2174677b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711629541; x=1712234341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbFZsO42nxYTcylJXM+AgVeR+gZ+Nokwozi7iOFo168=;
        b=sCcqPo2h1PgNjicmUv1twnJ42ofd1MD/p8FdmKaf/eQEkBWp62jcfSAV/axFK7rww8
         1xUxVFay/dEC0uqjyTHVzYC8cx8RBtl2g86e9LorJlAlJemagNaSlwjIDRQQ3Q9C51qE
         lmJAMI9vZACxxa7u6EngP8zgyOf2eM3nD7fRKqbJT49xi5Lwn4MKv+vnkMl4FXwAlqH7
         yj2thN3RCBANMBmelwjeSLjU/yLMs7NOkA1WtFcYF4t1xwHnZuJqHSdOocnQge7DQD9D
         wQqVFJIyGpFgma0Mb3/kqbI1wm8QUPfPRQ8YTx+M6b0FrAqM6huic/sYVsXyQnCDTfeb
         EL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629541; x=1712234341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbFZsO42nxYTcylJXM+AgVeR+gZ+Nokwozi7iOFo168=;
        b=igT6iG2Dy2C/pbARvziPFqhP6MRU2lx+9Wl/KonXWltuevCSY3wpPJQ4Ryhkov9sE1
         GvF8lPs4NRsQNtbh7bYCoxWVNglTPP7V/TSUof7mbZQ4r8d4NG1gJIrvQMiu3lRwWABe
         UeWxg5wfwa4tuNlPtPVwAEna2Xhr1Kb4CdSpyujscwbr2D/ApuZ4bJTqVasulqY5gUiW
         l2woT0sVJva35nbIqryli3zQdrWI2gsQ0Ukc/TWdbFT6MPhDneBqXx9yvZW/2C5e89Id
         2E+u+CjWgCRKAEkuTuSNMJS/CqZEOpPOhzS/mebrUKzecJZt2bmixJ1HxJXRM1+Etf2d
         SqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmktZ2FAbJnAmgNUkWDocPZfOEr0pOJt+uSyfazr/oH4+JqEaoB8x626ZAr3JvnBFeiCFDZjLQdRbHjcPU+ZbUvjBZc4js227sAmor
X-Gm-Message-State: AOJu0YxyYTn4+oaWx5BGnIeN3ragyr0BZKVJx/Bzap6jPnbDL4YJiz/E
	OAAevFMpqEgkbRXBqJmu901ZQMhrfKUAi1Iiif/mIFBUjhqMItRYsB4t1T8X97IHU4mY4LnYzQl
	2C6qy/3TKWHAehWrWgY9CD4EoSv6/c/0Qlefy9g==
X-Google-Smtp-Source: AGHT+IFkDjr06H+k4p59jSQxZrMcpP2X/pxbmbf0Ojewgx1WYGoZRii2U3W8FdVbFnM+76XqmRq0dkex1V+VyDzFjO8=
X-Received: by 2002:a25:bed1:0:b0:dc6:d22e:ef4c with SMTP id
 k17-20020a25bed1000000b00dc6d22eef4cmr2625248ybm.17.1711629540724; Thu, 28
 Mar 2024 05:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327024545.138351-1-ricky_wu@realtek.com>
In-Reply-To: <20240327024545.138351-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 28 Mar 2024 13:38:24 +0100
Message-ID: <CAPDyKFo3dkzDDEU7Lk14zH0td0AP=z2RJQibj8SP6JeUuz=iFA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: resume not check card exist before powerup
To: Ricky Wu <ricky_wu@realtek.com>
Cc: wenchao.chen@unisoc.com, ricardo@marliere.net, marex@denx.de, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 03:46, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> _mmc_sd_resume
> add get_cd before call powerup, make sure the card exist

Please elaborate more on what problem you are trying to solve, the
above doesn't make much sense to me, sorry.

Yes, the card may be removed while the system is suspended. Then, even
if ->get_cd() indicates that there is no card inserted in the
SD-card-slot, we may still have the card being registered - and then
we need to unregister it.
That said, we need to call mmc_power_up() in order to try to
communicate with the card again. At least that is what the
mmc_rescan() work assumes when it runs the bus_ops->detect() callback
at some point later in time.

>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/mmc/core/sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdda50..35e036672cfb 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1750,6 +1750,9 @@ static int _mmc_sd_resume(struct mmc_host *host)
>         if (!mmc_card_suspended(host->card))
>                 goto out;
>
> +       if (host->ops->get_cd && !host->ops->get_cd(host))
> +               goto out;
> +
>         mmc_power_up(host, host->card->ocr);
>         err = mmc_sd_init_card(host, host->card->ocr, host->card);
>         mmc_card_clr_suspended(host->card);
> --
> 2.25.1
>

Kind regards
Uffe

