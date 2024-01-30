Return-Path: <linux-kernel+bounces-44574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295DD842466
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51491F25852
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAE467A08;
	Tue, 30 Jan 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NM8G3Afo"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417567751
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616324; cv=none; b=Beq9Bhsh9Lf0uDimp2vpbtP79rAthfEZ6N/BcT01KHYKI2qABE7isWdC1QwU/wExnXhdJ3f0Xlu9VjQr4TNvt8ZRPhD0Y49J0OeGIQ4htnDcFl8FZuUIqiMMlmySZwqC8QxAcvP7d5GK4skgKUH8zuZNYSak26mIbCH7IYjiRJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616324; c=relaxed/simple;
	bh=34lAr/f6hcj4owT9SrqMJGvWlqsHvE6OdEw+4hom4kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4TL8r4xkN29uYQPmkmigvnux0AP+HiH9TC8KYD7gB5ol9HHvX95rpFco0DLiEjKEE1M9fTR+Qywv96ksg57vyJU8f/oXxz/3PUFmNLhNuSAQQ9mXzh3OWPqbqABpBul6LmfgPLGoRGiVbP50X9yM8jAQSYT5Ab7Foo3J04S1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NM8G3Afo; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-603e370790cso17451307b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706616320; x=1707221120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qubJ1YPqAKPOck4mRrIO3V8EJvvCUM+3Ty6ScGXxBl8=;
        b=NM8G3AfoegSmYm9qiUyQXUfy6dlc+H5bugGEwwisrQn2dc2y3nPGbqPasv/Jqb7PPx
         xlh3RGbaLBGO+ijxjNZD1dS3sBgFceRAnU5mtb1vcxp7Rfpj7JU3rM45Pa8F8GbZIe3a
         NXq+npDdNwXkwyu4h3I6AjPbQN9z0pEt0xvcIvqWPeNlD450CZew3fO9eI8iFPKVxTeu
         ut6Wzu6hAI91ry0sPjF5+ors1c3Jc6F7FGo/ekGOxhi2OW5XtrDlznvlLRbhVod4zQMk
         igHTEeZv2E+AMPm4kUWrfzp8j4S4VdCgHDx2RkIr5BSVA/PR5vhPupz3E5q8AZW1ZwZk
         tk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616320; x=1707221120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qubJ1YPqAKPOck4mRrIO3V8EJvvCUM+3Ty6ScGXxBl8=;
        b=lg67Wcec8BpxgLVl7sa25RBETPnp9sdF1w8ZsJn5zJvX2Rdb86E29va49yq0FfTBnQ
         LwtHCyis+Wt3+kxQI84VL9q7hWy3g0Jnl6V1l7/dCE0Aih5Fr/lE7OnAbw8J37FN+6/v
         S5FRLnKXSDXfP6gyCtU4Ccq+6m2a3LAjp40tQCLDwVkOfoem943T3CnFMZdI28xWPh6o
         5tB8XpXWlF7QXBOQBg5wdjtmB8cs++ZfcwBhbDa2HW9tyLjEVncG+H7Zp6y/+v3LytWC
         sfg9K9XbLEXwycYAhs6CXFzf7eNf3B2uBpyu2Im1jU8HPBx3zps3IX3OJI11wjK9WhyR
         3avA==
X-Gm-Message-State: AOJu0Yxyir0JVmqq+e5fCnDO5TzVEpK3XPzBrjSD9xk8kN3odD5LlwvA
	O/ZRKWC3iHf1VbuGbOVZIcQwiQawDY0hYF8iN6ru9O6NHmY0Jl/AeXgALYCBEycnEyCKsmGg0yT
	CQKeOFcat42rzG0eP0c3qAaDiy/9etqDmsCtYwQ==
X-Google-Smtp-Source: AGHT+IEvdQML9EzKRohvbXSDGQ2AJM4jpPokotXmgSlDhQ0/ChFy4HuK8Hm/woeKoy3AWIJDiaRSBqz+jWTjDsfRGPA=
X-Received: by 2002:a81:6c87:0:b0:5ff:7f31:1bce with SMTP id
 h129-20020a816c87000000b005ff7f311bcemr7755757ywc.30.1706616320353; Tue, 30
 Jan 2024 04:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126190110.148599-1-afd@ti.com>
In-Reply-To: <20240126190110.148599-1-afd@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Jan 2024 13:04:44 +0100
Message-ID: <CAPDyKFpc38-CFrzhnhutS7c78tZTLM6Bg6XsTKENP8oVT6SQXg@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq: Use proper reboot notifier path
To: Andrew Davis <afd@ti.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Yangtao Li <frank.li@vivo.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 20:01, Andrew Davis <afd@ti.com> wrote:
>
> This driver registers itself as a reboot handler, which means it claims
> it can reboot the system. It does this so it is called during the system
> reboot sequence. The correct way to be notified during the reboot
> sequence is to register a notifier with register_reboot_notifier().
> Do this here.
>
> Note this will be called during normal reboots but not emergency reboots.
> This is the expected behavior, emergency reboot means emergency, not go
> do some cleanup with emmc pins.. The reboot notifiers are intentionally
> not called in the emergency path for a reason and working around that by
> pretending to be a reboot handler is a hack.

I understand the reason for the $subject patch, but it will not work,
unfortunately.

For eMMC we need to manage emergency reboots too. The fiddling with
GPIOs isn't a "cleanup", but tries to move the eMMC into a clean reset
state. This is needed on some platforms with broken bootloaders (ROM
code), that is expecting the eMMC to always start in a clean reset
state.

So, we need both parts, as was discussed here [1] too.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/1445440540-21525-1-git-send-email-javier@osg.samsung.com/

>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/mmc/core/pwrseq_emmc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index 3b6d69cefb4eb..d5045fd1a02c1 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -70,14 +70,8 @@ static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
>                 return PTR_ERR(pwrseq->reset_gpio);
>
>         if (!gpiod_cansleep(pwrseq->reset_gpio)) {
> -               /*
> -                * register reset handler to ensure emmc reset also from
> -                * emergency_reboot(), priority 255 is the highest priority
> -                * so it will be executed before any system reboot handler.
> -                */
>                 pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
> -               pwrseq->reset_nb.priority = 255;
> -               register_restart_handler(&pwrseq->reset_nb);
> +               register_reboot_notifier(&pwrseq->reset_nb);
>         } else {
>                 dev_notice(dev, "EMMC reset pin tied to a sleepy GPIO driver; reset on emergency-reboot disabled\n");
>         }
> --
> 2.39.2
>

