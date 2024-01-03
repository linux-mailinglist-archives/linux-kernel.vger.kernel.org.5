Return-Path: <linux-kernel+bounces-15506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B650822CE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BD5B21C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E89319440;
	Wed,  3 Jan 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jj0N50XA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812A19445
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e7c1012a42so85362127b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 04:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704284514; x=1704889314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy0HsVS+iZ9hEJU+wJGKHJ+eZMWAvGjx8XOWsGELyQo=;
        b=jj0N50XAG9+mAJSMenJBTAVtDzItZ/s8YOKfwUdzAW6Gmd73bXzlOkv4IPiT6JXQfJ
         yWdYXhmQaiCt8pWnJVOFK9n8AxlWCwZdgpLPMfrjkn/fmqfQYxHK1CnRCMi7p3hYibux
         D6BzYymUdhbNVrJX8lTEir7dI5dJKA2u/SKeQ/3+hypa98o25w0ZX1IJeuMEt+S+eizA
         nLpiADAZCLGs4UQ5FPANJJoRpwKyvg996bj9CWZE0MbbEmfGa8rbrYm/jVYdeUotNOBi
         P3bQYzbwpgKEYgQqYcImiKW2K2WEKYnQjP1rinSVA4VEm0CP+UHyWVH5yWxaSlQRpE7J
         HFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704284514; x=1704889314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dy0HsVS+iZ9hEJU+wJGKHJ+eZMWAvGjx8XOWsGELyQo=;
        b=IFilKLBeMk2jf9WzGWQPcaxbYSimHqKxMi+Ni7+STNYV4rIpU6Ms6PrUHXZTPXY7/9
         hqbMvvSjXTU76TerPoywU4vry/8RaVZEKLsipvygilqX/qaS2mv14kL1/r51yYoJ4RF4
         pryRnZs+tnt7RTKVKHnTabUtga2QFKLLLydHEEAmdUKiT9vdMlC3ALhqBhVmEy7jh0+C
         bVXbRr6s9TFhxJhPo9QmUst3eQKbTLG880wnmTsNyzDGBiMMcMnGoWlbnCLa+oNtH0t+
         dy6WExpgbLirbk1HYz96YJB8oW15JoMC57J1I5PlbFYTLO9VWe26bwojYKqt6Wp+EeuZ
         14MQ==
X-Gm-Message-State: AOJu0YyeQREKpFrKPz1QXnvxFPUDywoharLAuYZtTaj8iAwPweWsGdG8
	uN5EmocJ9xfEMHcgfYbmlprLRcPZjxs4hjWcxIzyeKEPbpn+xQ==
X-Google-Smtp-Source: AGHT+IGqLefkwFSdFQp9UDZGcvBiz2/bcMXHLdaRynGAl7qEyjonv9zAygb4WT3tck7RHMNmWS6mHyROAddAAgybgJ4=
X-Received: by 2002:a05:690c:2a46:b0:5ee:6403:8931 with SMTP id
 ej6-20020a05690c2a4600b005ee64038931mr5265480ywb.55.1704284514280; Wed, 03
 Jan 2024 04:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103112911.2954632-1-jorge@foundries.io>
In-Reply-To: <20240103112911.2954632-1-jorge@foundries.io>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Jan 2024 13:21:18 +0100
Message-ID: <CAPDyKFpRD2euDm5cArZFcS3b9Zpr8yKL6vcyk4Sb77Vkr-YDZA@mail.gmail.com>
Subject: Re: [PATCHv3] mmc: rpmb: do not force a retune before RPMB switch
To: Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc: adrian.hunter@intel.com, Avri.Altman@wdc.com, christian.loehle@arm.com, 
	ricardo@foundries.io, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 12:29, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> Requesting a retune before switching to the RPMB partition has been
> observed to cause CRC errors on the RPMB reads (-EILSEQ).
>
> Since RPMB reads can not be retried, the clients would be directly
> affected by the errors.
>
> This commit disables the retune request prior to switching to the RPMB
> partition: mmc_retune_pause() no longer triggers a retune before the
> pause period begins.
>
> This was verified with the sdhci-of-arasan driver (ZynqMP) configured
> for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
> cases, the error was easy to reproduce triggering every few tenths of
> reads.
>
> With this commit, systems that were utilizing OP-TEE to access RPMB
> variables will experience an enhanced performance. Specifically, when
> OP-TEE is configured to employ RPMB as a secure storage solution, it not
> only writes the data but also the secure filesystem within the
> partition. As a result, retrieving any variable involves multiple RPMB
> reads, typically around five.
>
> For context, on ZynqMP, each retune request consumed approximately
> 8ms. Consequently, reading any RPMB variable used to take at the very
> minimum 40ms.
>
> After droping the need to retune before switching to the RPMB partition,
> this is no longer the case.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Acked-by: Avri Altman <avri.altman@wdc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for updating the commit message, very nice! And thanks Adrian
for reviewing this!

Applied for next, thanks!

Kind regards
Uffe

> ---
>  v3:
>     Added some performance information to the commit message
>  v2:
>     mmc_retune_pause() no longer can trigger a retune.
>     Keeping Avri Altman Acked-by since they are functionally equivalent.
>  v1:
>     modify mmc_retune_pause to optionally trigger a retune.
>
>
>  drivers/mmc/core/host.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be00..ed44920e92df 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -119,13 +119,12 @@ void mmc_retune_enable(struct mmc_host *host)
>
>  /*
>   * Pause re-tuning for a small set of operations.  The pause begins after the
> - * next command and after first doing re-tuning.
> + * next command.
>   */
>  void mmc_retune_pause(struct mmc_host *host)
>  {
>         if (!host->retune_paused) {
>                 host->retune_paused = 1;
> -               mmc_retune_needed(host);
>                 mmc_retune_hold(host);
>         }
>  }
> --
> 2.34.1

