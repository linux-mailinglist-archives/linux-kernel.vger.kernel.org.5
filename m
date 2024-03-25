Return-Path: <linux-kernel+bounces-117133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0A88A7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11A81F674ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F081741C1;
	Mon, 25 Mar 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sn/DIG2l"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C813B7AA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372778; cv=none; b=FwD8i3H+ZvzJfhC/I/Qo8P8Ni+GdG347OTXf48Q2/xKQBgEqoaWmWX3AJfTIgYscOTfBupsILRl+d1Fi/xPpoBle2kKKf50jB7DKgWTNpGiywOIP7BGxtFsw+0j4YmN2xWAb7rLvoEDDdOHpRaRed5yQwV0/rpJP6xGWmYs3ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372778; c=relaxed/simple;
	bh=d6CmeaRPtDfAafVHQJdPQOuU2Zhm/5dS96jiCyZA9+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iM8mNa1wEK4hCDkkcnd0HRHBQJlZfuqU3TYAukqu901fCcKk4VlZXP5wpqXir2G5CHrPwrc0YDk5Ag7mWLaCtiLcRISWFQmBbz1fu0mDKy+B00uOz2Cwm7Es91WogaP7I1/h1ZAUcQHWDGGxmEF3eNd9dIMRLAcueCfAB2eo5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sn/DIG2l; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4226947276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372776; x=1711977576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fT3MwGhMSQjWwd4oFtTdyz27PE3Zek9X7Wj5Tr9LaAI=;
        b=Sn/DIG2lLNhL7/pyEI667ZEvu7ZD87BaQbzGVRUSU5XiJI9wolb8pD0JAJ3I1k7eoX
         iHeBz0/iPl5fv6sKOGiOYVvX2UFOxQZzdipTll9pFmRV75TUfcpTkUBshw9sNop6vRSV
         gmecNV9ibzGH9U7BI4RRPUoQw+HZ9GIp7t3tdYQ+cOxqovlh4zkEC8f8xxbzSHgHIMrU
         78NTmqDaWgJBf43OOYNc7Le9/7NLmod2VFXRdyhS++PM8FHRxEfn7XSitbj4Oo/xnWKR
         gjgPEpwqqQ2CL71No57aSzJ0YEt8KXTaNJLyEj6tOwDfC1DZ8mLCOJASSzjU1Xsn/3h3
         jEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372776; x=1711977576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fT3MwGhMSQjWwd4oFtTdyz27PE3Zek9X7Wj5Tr9LaAI=;
        b=uEFexp/Tfrfavho10M0iBwBNtb5oKoR83Y6DbrSdVUQDchYZoEW00a3EJVtSHhrocV
         OMr4Qiwo+zvxKsiSgBWoQfsJ3TUcNTj8FTTO435+DIkknOLqIJdtGfnCWA98RlNgYhnQ
         la/yEPHYyCfD0AJJcjkyR+9C4URtiVZTl4i27hQtYVFeRlWNz2Ow9zvkhdShQ+8y0FSV
         +6gXPVPeKSw5OqoD88qqYYeGp9YNK9cCPjd0ayZEs7aU3z8eDdkr6x0Jw9PzBIQdfgNY
         86rpGb8COQzGR4nDphF6FuqOmizI+M/TimBdmTPRAECSK0zh8QaxTLydyP1h6N4l38ew
         ok2g==
X-Forwarded-Encrypted: i=1; AJvYcCWqL4vIwfb4XAPexbSqMP5mEAhhOHw1EL93Be/kQw+Dy5cpInBeWoBJ/b1RHB5YNFJ+90m6ZZnhKn+tnI0RTRHBxdZQ98qF3heFpXC1
X-Gm-Message-State: AOJu0YzzPLUxbyaOA1cDNzMgniYizz/x2W3vY71FGNIqjEWTw0jl0Kqb
	SaFEANmxj1MbPaZGDF++317gYvtxqiUpYWyDS/kEnjmgjAsi6wiQzNsfkkEn2pmNOBPY4gcx+70
	w/vqyA09MYRhNp4lKCWJtCSlQjBip3RO4a/k5nQ==
X-Google-Smtp-Source: AGHT+IGop6/PziXzCUHyTzYVdpvfKrK2/d+Evvn7C0ucdixP/Ox6Bjp4p3x8N/Ob7pmc2czLNFvZwPfs0rT/HDH5swQ=
X-Received: by 2002:a25:aea0:0:b0:dda:c5ca:c21b with SMTP id
 b32-20020a25aea0000000b00ddac5cac21bmr3876267ybj.37.1711372776266; Mon, 25
 Mar 2024 06:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9155963ffb12d18375002bf9ac9a3f98b727fc8.1710854108.git.limings@nvidia.com>
In-Reply-To: <b9155963ffb12d18375002bf9ac9a3f98b727fc8.1710854108.git.limings@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:19:00 +0100
Message-ID: <CAPDyKFrFA2vMbP6Nxt9egxK8-Mk9Td9+Cz73tNEF8mQpQJ_DPA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()
To: Liming Sun <limings@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, David Thompson <davthompson@nvidia.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:16, Liming Sun <limings@nvidia.com> wrote:
>
> This commit disables PM runtime in dwcmshc_remove() to avoid the
> error message below when reloading the sdhci-of-dwcmshc.ko
>
>   sdhci-dwcmshc MLNXBF30:00: Unbalanced pm_runtime_enable!
>
> Fixes: 48fe8fadbe5e ("mmc: sdhci-of-dwcmshc: Add runtime PM operations")
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index ab4b964d4058..1d8f5a76096a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -999,6 +999,17 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         return err;
>  }
>
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +       u16 ctrl;
> +
> +       ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +               ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +       }
> +}
> +
>  static void dwcmshc_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> @@ -1006,8 +1017,14 @@ static void dwcmshc_remove(struct platform_device *pdev)
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         struct rk35xx_priv *rk_priv = priv->priv;
>
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         sdhci_remove_host(host, 0);
>
> +       dwcmshc_disable_card_clk(host);
> +
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
>         if (rk_priv)
> @@ -1099,17 +1116,6 @@ static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>         }
>  }
>
> -static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> -{
> -       u16 ctrl;
> -
> -       ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -       if (ctrl & SDHCI_CLOCK_CARD_EN) {
> -               ctrl &= ~SDHCI_CLOCK_CARD_EN;
> -               sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> -       }
> -}
> -
>  static int dwcmshc_runtime_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
> --
> 2.30.1
>

