Return-Path: <linux-kernel+bounces-35329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B45A838F82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C561F2A8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF560260;
	Tue, 23 Jan 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MR33zzv1"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708E5FEED
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015422; cv=none; b=MUyJ/N9JdZ8tYR0NpmIdx/M2wksxED+cqVZWpvvm3ocvqPys0jfzJhXqWtnjeASvzVNi/7ZaKimwS/PALmu+bLwGpvDms68MxiMhoiXukCK2AkAZxleWVvjDXlR2e9qIn1oRZGgm4zNgDVPgrcXuElb2fs3RdvuBEnu8A0g8mOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015422; c=relaxed/simple;
	bh=S8Dj3R8prRqV+AGEE3+JoAYYKm0kKP9XmwiZ7qnLb7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF1SLnV8yT2LX2u05+ssFiTWyX49QuGGkqF7tFP7LucuXmHZ1oAdINhL1PyfrokkT033/VZOg2sK+ciGakZvvWhxw/nP6y6wRQg06hM4cAMSVhU7TzIj+6Z9h3DWi2+tkhqwVTG5HIxSaazyLFXMgOd8xaC7XHUwH0pK4tZ4QHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MR33zzv1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff821b9acfso38555907b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706015418; x=1706620218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClWdOeIIsl1FRVjuiLa2Y1YzPPvokp0yG8BguuXnqc0=;
        b=MR33zzv1dMLfOlp2DyTnpO8VSm44CSkBBMt8RazjoKHX03SNdOib5O3TQz2ZIR1PwV
         kbJSOOHl8q1MZQ4mwxHksEl+4RHE9M6TfgqCihvK6zEiYUQImxxnFuJnJx4HWKBITgLn
         XJDPWzi7z44a4mYx2dcF8+V/0uyrUoaVLNizJhys8b9ajq7V3PIqM7UM4x/OM5iPyP06
         uF4PB/Rnl5qO1UI0jxAVoMNW5+59UQTVc4gcaOpZrZneDWzgZohKSH8laWUlUNXl7Bmu
         eF+DfZQ0JDYyNUfR/z4TP5it9t4BQ/3q55ejAwNCPhVQIU5zZdHUigE7wT5nBxGp/hAk
         KEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706015418; x=1706620218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClWdOeIIsl1FRVjuiLa2Y1YzPPvokp0yG8BguuXnqc0=;
        b=oYLPF2ugiFa4Zmt2dw9WnjbJ9sCEiU7jWik/VD3HaRfKOvnBPynkOryLSidoshlCSU
         KjpnC3LPLzhrlhA/SMdqB4wlWcVmJKy2AeC5tVAEDRC/UL8uxRU60u9hPkJQVRW430tx
         ony3BnoZSZlKWgfWsD9uCnpzKwAYI6Ug23jM92EUMm0joLo4EURa7B7xAvVo11uBaGBc
         pyso6xNBSbv5xLbn2sQyHiDbY36CMsEmSQH56ESQiviyUIY1eo2QhsfHFYbyioPNLGP8
         07F4aLJSmwB1CEOjGB+AGn/plNzVPq6yoRUT2jpbW7p7MojuNnQNah1AozAOCGplMUOy
         G71w==
X-Gm-Message-State: AOJu0YxJn+mFN9qkMicxncGquNBx1R2M7nKGUHIjLbqs/MrubfALRpzk
	wZzGLOClMTgrgs0ubj+39ElWg+faeVxvQ78Skq1G52yi+75PZHiCSkHaUEb3T73feTqfzmikl9f
	tv4LUqOR5its0wjSFa/b0nuF83UkI/Z362NymgQ==
X-Google-Smtp-Source: AGHT+IEB3Cxo0INGCf0y2wXya0QKY/fgxTBzH8Ng/kwVYdAssiWSk0LizxhqKtTwMuP+AZRocKYHManbRbjqV6LExu8=
X-Received: by 2002:a81:8306:0:b0:5ff:4281:a6a with SMTP id
 t6-20020a818306000000b005ff42810a6amr4578656ywf.8.1706015418575; Tue, 23 Jan
 2024 05:10:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de> <13ba99e2578d4448fd85f516fbe328f5d05eda05.1705944943.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <13ba99e2578d4448fd85f516fbe328f5d05eda05.1705944943.git.u.kleine-koenig@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Jan 2024 14:09:42 +0100
Message-ID: <CAPDyKFr8=4=qWM0AR7ZZ-MyGUH+kLZZRWhVE4vu94cZqB5jxnQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/33] mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yang Yingliang <yangyingliang@huawei.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 at 19:08, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>
> To be able to remove these compatibility macros push the renaming into
> this driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

It looks like we need a decision if this should go via Mark's tree,
the series altogether - or if each subsystem maintainer should apply
each patch separately and postpone the final cleanups.

While waiting for a conclusion, here's my ack.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_spi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index b8dda8160c4e..bf35761f783a 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -935,7 +935,7 @@ static void mmc_spi_request(struct mmc_host *mmc, str=
uct mmc_request *mrq)
>  #endif
>
>         /* request exclusive bus access */
> -       spi_bus_lock(host->spi->master);
> +       spi_bus_lock(host->spi->controller);
>
>  crc_recover:
>         /* issue command; then optionally data and stop */
> @@ -967,7 +967,7 @@ static void mmc_spi_request(struct mmc_host *mmc, str=
uct mmc_request *mrq)
>         }
>
>         /* release the bus */
> -       spi_bus_unlock(host->spi->master);
> +       spi_bus_unlock(host->spi->controller);
>
>         mmc_request_done(host->mmc, mrq);
>  }
> @@ -1157,7 +1157,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>         /* We rely on full duplex transfers, mostly to reduce
>          * per-transfer overheads (by making fewer transfers).
>          */
> -       if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
> +       if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
>                 return -EINVAL;
>
>         /* MMC and SD specs only seem to care that sampling is on the
> --
> 2.43.0
>

