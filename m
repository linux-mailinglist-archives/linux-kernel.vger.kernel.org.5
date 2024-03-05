Return-Path: <linux-kernel+bounces-92344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F2871EDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52771F2347C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B942B5C60B;
	Tue,  5 Mar 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMb+mZMy"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310D5C5FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640928; cv=none; b=WQGfXMcwOYp1bwcmvR8wdaofVYSEB68H13r8T56V9eDYio5nz9UWovvkuj8G02Gz2lYqSHwEgF3rHxbl/iIBC0MAOUpemggGY6D6GLin/Dzkl+EW6mnwv3RbvNuJ5urNhRh85PxPGwjhAxaXMZ0bv08SLziUlBwbt+LKmK4N/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640928; c=relaxed/simple;
	bh=DcnzC15jjmF1MCyU9zIkSIhTwgFm9vccBcmaQItPkJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIZGXaHRBypyYmuwgdnL8ERPMZUADW/G6snqb0axkkptlDi+Ka72RbxXtxiort7kESSdTMUzc7Sg2DnnyOw8t+RBJ6iQKBRsnIZ+swUtkAy5catculwPN3A673ksxMidS/hZXtNL2Ic76GHyhYw98vUx9A/ve4jUiqr0cSzO7Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZMb+mZMy; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso5609588276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640923; x=1710245723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ5xx2edHD5FMmLecpHNeUGAP2uUzcBfz2t1dwA+19A=;
        b=ZMb+mZMye31AX8BUxTkQi0P/LOw3S6FuUIQ7H0+F39vTNu2l7MQIO85lr2HMZjtB7q
         shpCenLHdBUqe5PMUd8gUAVet5XkbHyovNHZAiRk4tGiJETpKxjNV5DkOHpILzwfC2jc
         X1XQtgUKLgDjmUpDtTtRxmxY9cDxF8nIq1IlzKZGVJ2CLHU4GB0lhNRz0qmKD32llPXg
         MoqBMRQSJywPXHJL+OVSkjVe8hSl537PvR1543TVNgfA3SP+zqSXpJvxuZHLgp1F0Ei+
         nl6JNXv3eesRUmXBx231qvY2wgSZiHX5SKiLiPrJDYf8QQQ8PTpY5NytVWottJ+AofR2
         qZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640923; x=1710245723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ5xx2edHD5FMmLecpHNeUGAP2uUzcBfz2t1dwA+19A=;
        b=jLVbN2h2mfiKdqvMh6FI5JLhflL4uFUwJX6ysLxoEya3Ief+zj9sMv24B3MrwikpDe
         9PJYIxlo0ZC5iyt++tVvyFUs/hf6Z6xW96LjAsdM1HF++p0SR5iumPs2WvHrqP2eRIqV
         rQWMDE+FFwpyYUYMYb6NK2HgGvqaDqy1vxMQjzqHTiACmLVcuEduj5cbe76Cs7KiNQPA
         1DX8MQQkOHpi1mNvdDJ4PuJ17aZki+nhXlgGAPe4Erwz5H0xHmyQe86Ovlx5bxusqZ8g
         +j1RgI8Sh0xjKOa3HSRkQZLCpODyBhFpkHePB6YKLJC19+sVO5eVwxiMHhZJNncSDbOT
         kdUw==
X-Forwarded-Encrypted: i=1; AJvYcCVktjtl2Wm+flGDmduYW6WUeKYvdXJrR8GYGdAarGoKZrIiVVWFHF2N6HkD1DglTHEvu6ejWPewgEaXfPaCWgx1pXzaM5qIyUIi29yP
X-Gm-Message-State: AOJu0YyAe5Ju8UCklxEGCXBk/cwFf0T2KHpcHB9uvOotz8eUzU5Y4jpF
	qKb4NnTVlp9pmPTY6BNiMEkCYhAbfoIWh7SWc3488CL1srOCicduH52z+qozryipGwwtzrPCbvI
	XvNn0/MpKw2AaWH3QktrapfDkmeet+uSsoiaijQ==
X-Google-Smtp-Source: AGHT+IFRHrlt93okZ8pF8wCozXRKOrxXQZtOR31rF4Oxv2ktk0VBMY0lfxSqY9Tg9+i8KGWI6harXSX+rrTSNtu1DrM=
X-Received: by 2002:a25:b91:0:b0:dc7:46b7:6d67 with SMTP id
 139-20020a250b91000000b00dc746b76d67mr9606155ybl.33.1709640923661; Tue, 05
 Mar 2024 04:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305105623.3379-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240305105623.3379-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:48 +0100
Message-ID: <CAPDyKFr_GyWVXPbaeLf5hp_SKuRpr9sixhDQxoYBbFEU2qiJ-Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: comment the ERR_PTR usage in this driver
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 11:56, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> It is not super obvious why the driver sometimes uses an ERR_PTR for the
> current mrq. Explain why in comments.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/tmio_mmc_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index c253d176db69..93e912afd3ae 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -972,6 +972,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 return;
>         }
>
> +       /* Disallow new mrqs and work handlers to run */
>         host->mrq = ERR_PTR(-EBUSY);
>
>         spin_unlock_irqrestore(&host->lock, flags);
> @@ -1006,8 +1007,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                         "%s.%d: IOS interrupted: clk %u, mode %u",
>                         current->comm, task_pid_nr(current),
>                         ios->clock, ios->power_mode);
> -       host->mrq = NULL;
>
> +       /* Ready for new mrqs */
> +       host->mrq = NULL;
>         host->clk_cache = ios->clock;
>
>         mutex_unlock(&host->ios_lock);
> --
> 2.43.0
>

