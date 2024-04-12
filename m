Return-Path: <linux-kernel+bounces-142558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA88A2D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E025C286A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135A5380F;
	Fri, 12 Apr 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bifuBWKo"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8AF5336D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920529; cv=none; b=UOKKe4Y5hI3GfPOZlDEY8ExVmScKkIkhLblMcb/QSXgNCHQFUQgVjkDeOAqXfnB7yWoasC6FyfN/zgnB6RW15butut4lzj4IItRrPZXUscmLQ51GptF8XrhF81VhGJvNzxv/VheOpEQTsKcLXtWvCii09iIK3+gMa6OjY/9AcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920529; c=relaxed/simple;
	bh=E/uUvnAayS2kUpJvbMbwdVkr1FtYoVzqWi03CDEIUz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgGainBAttEMyh25D0X4i7B0pZAFfAPqkq7yQOWvb+6WR54VXFZzs3DbrlhZFKeSgU+pJ05sVlAj5o3aNNWd2EzAbIMH9QOKCsGSPfav1bop88U9apd+Kk4aZ7J5cVzYuAzAmDLbnmBSxTFpecncUoDkjbiBbzwY9zqmU42QfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bifuBWKo; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61874a5b8ecso7547717b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712920527; x=1713525327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+WKE9nZBcXA36QYNF70EQgVWpqyE2qptSPUnfSkOVlI=;
        b=bifuBWKoqEXsBcEm2jmBN5t75IYOcC8H5WVqonQq9fdP97++mGrx5zzp3GK4SGwz5V
         B5Bs7BJyG+srVqx2g5olPzboCxYHKOX8RkVv6jgwSy9boFUTDFT34eeuHaowynPMgIBn
         FALx7sRsip+pT8Agb+hChX8bK9I92A7KZwaMW1jWsQe6XPUeFoYSTT9Itlj9NVjaQUVJ
         w3dvYwZoYK+7bv8L+2Rc2KXjO/FrmHpEMq0DTke226ZBuCeK6XR+PkmtQgXWbPZN7F6Q
         +i6vLDGYbcrxZsu4OQcLsmedmO83WBMOjmqPxwPSFtKw9Jc8nu1fkSgVQTtEDCkzrIK3
         OTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712920527; x=1713525327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WKE9nZBcXA36QYNF70EQgVWpqyE2qptSPUnfSkOVlI=;
        b=d6lbboWuJBBjAc5Cc4Bz1gp/UWDRbE6RpLsybwA8dFLl1TbXcN3hLY565wJOIHfw98
         c/xgfa/yu+MX/MrIM9vzpOQMfgxjQo35qh+TDQXs2TbxLMfPp7+tgRxyhDAwtl4B17NI
         3pYThPEyTDs00mfSmRe3BT+6p1UNs84JFziyQlKuqK3O4a5uZcSyavP7JroIfWzqtSNC
         Cx0ODgPj4fWzGnJ1rTJO6aZ34jx7y1lEzb59u9rGh9umEAF2Wlm86ef/RAqjAaYAh7io
         +mB1jzPg/mbOvEDVnavsfpNrlQSk9uQu5ZFaPMRM8gSEdXnMuVVcSOv8D0ZYJfFTsb+g
         Hsmg==
X-Forwarded-Encrypted: i=1; AJvYcCXNBpryr+YaIcljTvhCwXSy713+TCWyHNPfnmEA9SuJLRMsTiaUn57F7gBwpjiY4m7Ao2oggx5bnLuAvC7TelJWNYsHgUBMgCQZy1+g
X-Gm-Message-State: AOJu0YzcfBW3MHnr1GDUkWGiS3wdep6ITuLZxkV6W2+YIPLWqU/nGyzf
	XHsbyqk46zb6TGfS2HBlNE5kjtr8aRd8gdR95Alz2L9MeG0VN4O4xHm7tRWTizNVGcitVOs3o95
	Gs3Dp6h1M+pOoscDcNk9lRU6C+s67Ks4YIzXbLg==
X-Google-Smtp-Source: AGHT+IFgT7mF3uN/XJl/pEETuZHEE3BcaQGuPPTM6pYVu0988Ijil85l3VLhQQ0xGShXQRYVoF63WvQ+ywlZ5uk6PAI=
X-Received: by 2002:a25:bb8c:0:b0:dc2:4f34:c964 with SMTP id
 y12-20020a25bb8c000000b00dc24f34c964mr2068134ybg.23.1712920527317; Fri, 12
 Apr 2024 04:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com> <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Apr 2024 13:14:51 +0200
Message-ID: <CAPDyKFqq+gMDHx_-g-j9rO3nBDcXRSoXRjJK9D51=VaQ5XaGvw@mail.gmail.com>
Subject: Re: [PATCH RESEND v8 09/10] watchdog: rzg2l_wdt: Power on the PM
 domain in rzg2l_wdt_restart()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	geert+renesas@glider.be, magnus.damm@gmail.com, biju.das.jz@bp.renesas.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 16:19, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt_restart() is called from atomic context. Calling
> pm_runtime_{get_sync, resume_and_get}() or any other runtime PM resume
> APIs is not an option as it may lead to issues as described in commit
> e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'")
> that removed the pm_runtime_get_sync() and used directly the
> clk_prepare_enable() APIs.
>
> Starting with RZ/G3S the watchdog could be part of its own software
> controlled power domain (see the initial implementation in Link section).
> In case the watchdog is not used the power domain is off and accessing
> watchdog registers leads to aborts.
>
> To solve this the patch powers on the power domain using
> dev_pm_genpd_resume() API before enabling its clock. This is not
> sleeping or taking any other locks as the power domain will not be
> registered with GENPD_FLAG_IRQ_SAFE flags.
>
> Link: https://lore.kernel.org/all/20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v8:
> - none, this patch is new
>
>  drivers/watchdog/rzg2l_wdt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index c8c20cfb97a3..98e5e9914a5d 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/units.h>
> @@ -164,6 +165,17 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>         struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>         int ret;
>
> +       /*
> +        * The device may be part of a power domain that is currently
> +        * powered off. We need to power it up before accessing registers.
> +        * We don't undo the dev_pm_genpd_resume() as the device need to
> +        * be up for the reboot to happen. Also, as we are in atomic context
> +        * here there is no need to increment PM runtime usage counter
> +        * (to make sure pm_runtime_active() doesn't return wrong code).
> +        */
> +       if (!pm_runtime_active(wdev->parent))
> +               dev_pm_genpd_resume(wdev->parent);
> +

I doubt this is the correct solution, but I may be wrong. Unless this
is invoked at the syscore stage?

>         clk_prepare_enable(priv->pclk);
>         clk_prepare_enable(priv->osc_clk);
>
> --
> 2.39.2
>
>

Can you redirectly me to the complete series, so I can have a better
overview of the problem?

Kind regards
Uffe

