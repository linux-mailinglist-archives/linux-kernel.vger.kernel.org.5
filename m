Return-Path: <linux-kernel+bounces-92338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B708871EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4591C24494
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7E5917C;
	Tue,  5 Mar 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlXlibw3"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DD5A118
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640911; cv=none; b=b+BhitpfpXfXvLllLcq9mrU2L0V37RmA+/8l3xRA3kOEWsCWPcTvY2ziUCHFltj55i3SEjXxufMQK68OOp0Rljx5UnQEbWkxf1DCB5phk57ECdl4yFF5K+bIJdQKbPMFWSVYBPtcdADA/3spUBy8CE73V6Cwp+TwvCD/vYjKUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640911; c=relaxed/simple;
	bh=RCaP4GDWT87Zd9IUZzQQpBKEXe+s1x2lF2pIn4GuNXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzSLCwHUfaYxwT4wrUewS+CxMaRP6z6Gebnle085z1Z9Ello+rHS6ASU0cQSkntLKAtY1rDBulm0VpQhCyRebWGzjdKv5fxTijWznNruYHRUKR+1WPbkrm/c49wix2F9cmWcplbUlhOU8CqvWygSkIyEpUvjxphDgyowy2+k+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlXlibw3; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dd045349d42so625367276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640908; x=1710245708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVW/PXVs5nzy5Gr+BEyjbP8Shu9TAluG0kZZRSGaf1s=;
        b=UlXlibw3caQYA57kMfjNtfV6yf5J+oylhS9K4ZXt73FtLQhoSMTyKVWUDyiZYM9FlO
         EpBnaNdd20YdCCHFYLDfAnnK92S9dPpJ2Y9GVPA05wQI9IcIc2O1F8zGjuqEbuf3blQA
         Xj9Fvt86ML6cxLIoamGCj1otdU1z5qe1RbQvrj8ausuGUyRf1TBAKvzTjczJAhCmix1s
         qTtYnakLOvJnfliFe+S++misrWDWyrDGTwvbUAKHi7KiM62Jz34pKCbGwLnoWqAzuB2h
         cHAWIhmJRSiprowLH6F341m3oIAjgIg4nZXuKHrW/AA6Caed9MyL3loyZrer3w39SvHg
         fi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640908; x=1710245708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVW/PXVs5nzy5Gr+BEyjbP8Shu9TAluG0kZZRSGaf1s=;
        b=loRo7rAKWMe9ULNqshva9BbFuLOMjD6m7ujL40WCxe0cYMPOnsBuxHXPE36z4uBZx6
         wtPL3TGYGpVGFs1q+2Hxp3wOkmQGaSjmuuq7X2qJsxvUNQa1DmZFUb55gQj48ehvFVsv
         e6Alvqbu8qBHhjpJQARTTCDrKL81bQZ4ZZDvAG2tS6ZzFPPJ0NXof0hJ+efzMYTrjnz6
         LEUxm+SBqzT6giVP9GVRccNX6MSSXqa1LvQOJ8CWMNZr3Gw2PzD/VJcd3PNADb2NZOCC
         levWLVl2YVAryMUQvVRsMcBzJUwhDZoq896ltzZ72gStq80C6XqmVp6txIsjuZA+oWuH
         nM7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9K+tBwkDh367d3V3qc4yEzpfe3SbeXVWwGDqGdrBnGultDt31QAlxp1Red6UDPdn063CwuKp5uxyA7xALlsn4FnFijT3vsFNCIILL
X-Gm-Message-State: AOJu0Yz/+gO7ZzUQxprx+u41SU/CQrxl8tWH52h5pMw3ECHwi78uvAKp
	Kcw6YQeESr7tUAdUn0AqEfraytCyRbI8uOQYg8xZXTbnRmM0run/n2hiHhAd2MzY4B4ooRc6h5P
	jkNcqG8PWsRC+WCz4cvmZMUFqckI+WyX/PjzBVA==
X-Google-Smtp-Source: AGHT+IE2Y4cAajm9+l0CPilDWB96P4S9WhAwezHUZMdrZBUawlG/ZjtdnYQewd1l4phaxcPiQSTerAEAXTI4XU4tz+w=
X-Received: by 2002:a25:660c:0:b0:dd0:c2a:26f9 with SMTP id
 a12-20020a25660c000000b00dd00c2a26f9mr6859439ybc.27.1709640907662; Tue, 05
 Mar 2024 04:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:31 +0100
Message-ID: <CAPDyKFryGhRju5CohRipXk9E_G3kob2g8=VztjtPBZ_i6D9Ugw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: tmio: avoid concurrent runs of mmc_request_done()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, 
	stable@vger.kernel.org, Chris Ball <cjb@laptop.org>, 
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 11:44, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> With the to-be-fixed commit, the reset_work handler cleared 'host->mrq'
> outside of the spinlock protected critical section. That leaves a small
> race window during execution of 'tmio_mmc_reset()' where the done_work
> handler could grab a pointer to the now invalid 'host->mrq'. Both would
> use it to call mmc_request_done() causing problems (see link below).
>
> However, 'host->mrq' cannot simply be cleared earlier inside the
> critical section. That would allow new mrqs to come in asynchronously
> while the actual reset of the controller still needs to be done. So,
> like 'tmio_mmc_set_ios()', an ERR_PTR is used to prevent new mrqs from
> coming in but still avoiding concurrency between work handlers.
>
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Closes: https://lore.kernel.org/all/20240220061356.3001761-1-dirk.behme@de.bosch.com/
> Fixes: df3ef2d3c92c ("mmc: protect the tmio_mmc driver against a theoretical race")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
> Cc: stable@vger.kernel.org # 3.0+

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Change since v1/RFT: added Dirk's tags and stable tag
>
> @Ulf: this is nasty, subtle stuff. Would be awesome to have it in 6.8
> already!
>
>  drivers/mmc/host/tmio_mmc_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index be7f18fd4836..c253d176db69 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -259,6 +259,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>         else
>                 mrq->cmd->error = -ETIMEDOUT;
>
> +       /* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
> +       host->mrq = ERR_PTR(-EBUSY);
>         host->cmd = NULL;
>         host->data = NULL;
>
> --
> 2.43.0
>

