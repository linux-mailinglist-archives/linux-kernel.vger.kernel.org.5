Return-Path: <linux-kernel+bounces-94668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722F8742E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10711F23844
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B871C6B6;
	Wed,  6 Mar 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCJrMKDH"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6221CA87
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764778; cv=none; b=m3LX4A4Z1sF3qnFbAvJU15iK5hpMfyI6nyq0de7LICM8ij7+rEuVfkmaUICEs/AOSgioiwuQmlevVqFpouTPI+qQh5hcIZt/wYCNPcUa0JWq4DfrCuYkJcB+W+k7QhRBg+HcXq8Vzu5w0VAHB0sYe1ZaHqx7YlGD9aqPIQGLzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764778; c=relaxed/simple;
	bh=uLe63viurQ3turla71biZSNzeHZERkHtpVBGMD4Knbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOBdvYKztXYPNE+Vc6ntNFaLJmFbFZKdCEE07KABn0nN4xLvAYs2tV1QwUESserswIqAfDcabr57d4JmJom3Ma8etLK8N/es9B9ugYqno2g6iBps6ChphF+F+tGwzED0dISwdiOSZH9DeQJUfcGQde0sUca+QCUipX3lfNpFVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCJrMKDH; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so201376276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709764776; x=1710369576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9vVK9zCdzIjogBkv8fl2BDMmRUTvYVhUa47aKUSIwk=;
        b=hCJrMKDH0f0SvaGviMN/ed/EieJ93R+PFWjpanA1td4Kttnl9v2iwCI9by6zNiBtmH
         IHdthxO8Lf479m0hxcXPQy82lCI4NeuMKxRq9hGXkSsqIv4AkF1RzuLjWjp+Z5o/l0C7
         5hLgzEorX+OnVyOkEmcMZv79Uaq3k1YBZ1i+ldMP3shenzQQh0vSEUYszDBajdN6u4SP
         v1KpMheeQfQx94V+w+G08MEFXmfDtugyvOSu0ZItTN0NYeHjhV1T8+Q3pvpasR3skpkV
         oqG2ZDBhCFr5Y0nm6G0P+nIszu/NBKEhKIMqOInoTx1UNt68RLgzKDkdQY/tjzySQBXQ
         IKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764776; x=1710369576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9vVK9zCdzIjogBkv8fl2BDMmRUTvYVhUa47aKUSIwk=;
        b=VXOWmd1wrP4W5I4L5kUhrNaxydbJalo6x1suNZamTHWErGNf+BBH1m29GEvsIwWGLm
         c/geq+6RgsIdNfrvGkjbt5vcizW3pr2nJiJPPh/S+qTvA4lmB14jl3XB0Di6irUrBRVL
         rJIqxxlfvW516VxDZU62fZ3ocXIcplVhJbdgWDd+n/LKftfGkAIpR2svzprJh1GYTmVH
         XMNogyCvijdEMbHTLGjEdS7o9B5ABXFByTS8+Vli8tBWjS4WAKN9hdcl2VvQkz0Stxn1
         AomQbW8+B830rooy0vRIg46NVSFnrSR6g5gqT937QK4PXpDBBdjUqMp13r9Xvwsn1LJq
         TNZw==
X-Forwarded-Encrypted: i=1; AJvYcCUA80jDdPy8Jchj/UtX6rr/+pkPQZgAj01wZIgBV/haGkc8tEDvSAf/R+b18kdzmy+jhDwDG2izvrptaoKM81QDd7Qn/xO1d5RD0kih
X-Gm-Message-State: AOJu0YydYVJjk+xFHKuXfbTe8sZaFTS689w51wuTgOZ2dN/UsmQrVobs
	h3K9UisdufBL8pjVNGPkK/VeblmpUeTeoKBadR1Q2xq2L0JehrWcHm0Ni98nzgijP39hNPBhJoo
	dDkmMpXeI4D6mri8w1fTCCOQc9qsUB3VnKcaTAIK0mH7r8j5q
X-Google-Smtp-Source: AGHT+IF/THkJ+YHww9cnfN6k2wCID7Xyd+DBGlTKOnX3BMJuZFhCJ/eFUhl1SAD7Qu8yGUVfFkXSR521FcIDe0ngjks=
X-Received: by 2002:a25:880b:0:b0:dcb:aa26:50f9 with SMTP id
 c11-20020a25880b000000b00dcbaa2650f9mr13196885ybl.46.1709764776292; Wed, 06
 Mar 2024 14:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-class_cleanup-mmc-v1-1-4a66e7122ff3@marliere.net>
In-Reply-To: <20240305-class_cleanup-mmc-v1-1-4a66e7122ff3@marliere.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 6 Mar 2024 23:38:59 +0100
Message-ID: <CAPDyKFpx2hsqmmyRRZeWjZuF2Fot=UR5=EzmCRi7Cv8xFaFUwg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: make mmc_host_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 20:49, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the mmc_host_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3aa9dda6fd4f..8f8781d6c25e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -88,7 +88,7 @@ static int mmc_host_classdev_shutdown(struct device *dev)
>         return 0;
>  }
>
> -static struct class mmc_host_class = {
> +static const struct class mmc_host_class = {
>         .name           = "mmc_host",
>         .dev_release    = mmc_host_classdev_release,
>         .shutdown_pre   = mmc_host_classdev_shutdown,
>
> ---
> base-commit: 0cd8fd15a75e82ef249e99b3d80e2012a729d028
> change-id: 20240305-class_cleanup-mmc-75258142f27e
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>

