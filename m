Return-Path: <linux-kernel+bounces-15398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DE7822B78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B55B23116
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618918C1D;
	Wed,  3 Jan 2024 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7Koooix"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47A18C13
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e76948cda7so68292897b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704278139; x=1704882939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XKcY2AE/GnBCs5Lls0ys+fJ/B8ZrEmV4zu/inBIOxr4=;
        b=P7Koooix6G88RAYwhBkB9Nnt4mAfEeiHBOIxC7yOTvWgDGZrc7qf5n17Jdzd6Mc26W
         A/CUiVcTEnYidG8eJxHS/R7joWBJsEhW+vQv3i1Kp4tMViu6D2DNFESzh324SRNruvLm
         2B0zrjPYKFjIWS2NVRJVDoyVjYNHyXqYufl5YRfpR0igblgclGSkIhTXVCIOE3cRs+Fl
         cG5cQvav7Jl0vCT+XPntYxLevdwmDZsUDrTrbgsLo98Vkirfue1zDLNbAvkYHP1yRkAu
         Cqe9LAO7l2XF+z9KEutGsRGG2RuJEyPuXTnZVV5hYB8HDde8BHk0BdzrYwA5w/TqDX42
         4bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704278139; x=1704882939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKcY2AE/GnBCs5Lls0ys+fJ/B8ZrEmV4zu/inBIOxr4=;
        b=Y4yAIi1CCe/XI6GVnjo5xeLwRg+kK09JY+MBTYt63OkoVJp84jmWnxC2KOqXmTYWk+
         T2uBp8w4OQXVlsI7xxWkk4UYG8HLxwa1CWGZye8z2vuZkvJVJolhESWKG7Cz4oecdsPb
         uV2b/djhBWJGiTQKIvILq9mcZhSeNIG8zYhmazm9Cg4QloEp07u/vZ+zGuJDzEicCTd1
         /XU2sblYyyZMzMMJiTAvekB2crzIPbdkjNWoMW3g/GZTgyuWdUVrwN5dskGfeWEo4QyS
         v6vKjHBVjUaIp7ZgTocmLAFd7f3N/brYCK/rPYtKV8teyHbM2jtkwnL0B2+u1ahBwbKY
         NY9A==
X-Gm-Message-State: AOJu0YyhcGViu1y9Gmf+U7GO5bXCRNXEoV+j+p0y6W6XXnSxXygbQKqB
	O2ZP8aNTJCu6GedUxRKP8bAlhs6UA3v3DWufFOraKk8JhBymZA==
X-Google-Smtp-Source: AGHT+IEzFFE/PDz0tjijKTkNBojFc3RAcywQW+814rzPWLEaJLf345psyNbsCZx2AGC6jfmcWM9HQYQnWXxMAcSb70g=
X-Received: by 2002:a81:c509:0:b0:5f1:5ab9:2f53 with SMTP id
 k9-20020a81c509000000b005f15ab92f53mr2770939ywi.27.1704278139277; Wed, 03 Jan
 2024 02:35:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211165500.310097-1-jorge@foundries.io>
In-Reply-To: <20231211165500.310097-1-jorge@foundries.io>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Jan 2024 11:35:03 +0100
Message-ID: <CAPDyKFrbdL5fYm6o9RA7Eva2sRVydVFWwszEAve1cZYuh5-awQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
To: Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc: adrian.hunter@intel.com, Avri.Altman@wdc.com, christian.loehle@arm.com, 
	ricardo@foundries.io, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Dec 2023 at 17:55, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
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
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Acked-by: Avri Altman <avri.altman@wdc.com>

This seems reasonable, but I would like to see some justification from
a performance point of view in the commit message too.

Moreover, please bump the version number of the patch at each
iteration and add a version summary of what has changed. That helps
the review process.

Kind regards
Uffe

> ---
>  v2:
>     mmc_retune_pause() no longer can trigger a retune.
>     Keeping Avri Altman Acked-by since they are functionally equivalent.
>  v1:
>     modify mmc_retune_pause to optionally trigger a retune.
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

