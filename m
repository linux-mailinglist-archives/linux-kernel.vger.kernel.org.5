Return-Path: <linux-kernel+bounces-110196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B512F885B60
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6973B1F2323F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4328E86252;
	Thu, 21 Mar 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eNoMiKT6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D7186628
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033471; cv=none; b=W57O/h8bOoCjvEpOv7/qmrf5rzpYZK+fewWhHju2txQtpQQv+NnPrZsEnA66kxsGXHN2rN3opGttGZ+je+7J6e0xNajgr6W8HNzXRjF+A+iAacow9OhdeMlCt+ebVs3OV+rAreQr/PzoO/cuWBuoDD9bbb7fofhCDENNMVxlHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033471; c=relaxed/simple;
	bh=Vq7IOpduPovhWTfIlq7OpToTmsK0spCNnOeA70VT+y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXKNaZ1oEjAofDECTYuo9REEnAoGHbQBbFaeChccvcWO4jhwY3wZsx/gIhzY1adr9hl4GZh5jvf8Ega0DwrsdPoTy6W3rW+WMS0IiHK144ALsKUAIulxWi0VJqvPn8zuLoTDQT+Wdminl2YvjdN2kmj4BAFaPqQIhnYlprTVG8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eNoMiKT6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46dec5d00cso148445666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711033466; x=1711638266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+M26qwP0oSliowXOMgjRNibYsMtGqN5dSYVPUjBSio=;
        b=eNoMiKT6XYtKZHsskb7rdYNAAS4SQs7CfVWlA6ZJDSzJOfgeN4mxnY1uLWloSTH2cD
         JKGgq48bc+g8P0+ZIQguxYIyArnmkBnNrhg9khh/bHov4A0OOs3hWfDdf5OTJJMW2QmG
         kSqoqcq5XkhRheMWC5brD6HLMp6Jr1bI97JwdrEElrq9HeJOHHeUKatWEYemtpsIxduC
         G7gUMJdW1IKrVsPPf0fuCQZMBhEVwfDSTYbOhWc9iLggqBWBGCOTM3RN9Lc+NixigToX
         2s8NZ3KU/8mscLUK6QbPmx2wqaQrptc7xZk1Ag3oWl1X5duBDyiBuk83Ls16av4HfwT2
         r7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711033466; x=1711638266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+M26qwP0oSliowXOMgjRNibYsMtGqN5dSYVPUjBSio=;
        b=KIgcTMIwBg1+Pu+ZoQsvlCoUWlR+HxmrIgmw337+fIeJxwOWCgmlnO6qV6JCqlaVWy
         8wuxr1ps/e4hXcVIPdbmAaXe967G2aVlcBajiWdlnOLz/StR3/2WdKjI+PRmG5nKQjUt
         AkH9ybimCAfw+mQKCpTIaOHpWwLX3nYMz6xceMtKmn6m1bU6sOUamnsQTzGPk92NzH6O
         VFwfZ/bL9qB1x2OHc/Fh/R3acW5EgKmKP7rZMIbcMNJfvYzOwGEP+5rc+4w/VBsh2ZZg
         +sw5Y0Inqs+zrehacU/nimKJbDp7WsDIgeCw28pF1hubic8oqULoTvwDh/lAX38q/FUs
         /Bdg==
X-Forwarded-Encrypted: i=1; AJvYcCVcpftAuAKRYu1Ka/QEWejYz/b42tnrQu8/yGYKjrrBess2Obo2ls6rfPQsgJNOxGFcqVwr0LUSZjg38taPzZhN6hxigjuxTtkG8wqs
X-Gm-Message-State: AOJu0Ywp4eKo6URXrzDTmAoqZCeCDKwDUYxY6hfVmsivH98mP17BNHow
	eNQaU7xBkRXivGppu26BnAZ1iUMt06huB7214yqzeJlhXR5J2YiQ+vbkaaxDtqs=
X-Google-Smtp-Source: AGHT+IHEcr1Lc61NMyPIBSb8z115P5vSr6cXrLSqEMELys5uxp7RSzY4HAP3yVuJ9q6mhhIjpF5WHw==
X-Received: by 2002:a17:906:1817:b0:a46:af3e:dedc with SMTP id v23-20020a170906181700b00a46af3ededcmr1426310eje.40.1711033466146;
        Thu, 21 Mar 2024 08:04:26 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906179500b00a46cffe6d06sm13598eje.42.2024.03.21.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:04:25 -0700 (PDT)
Date: Thu, 21 Mar 2024 16:04:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Mikhail Malyshev <mike.malyshev@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Do not enable/disable runtime PM for PCI
 devices
Message-ID: <ZfxMdihnVqSNJZG6@nanopsycho>
References: <20240321-stmmac-fix-v1-1-3aef470494c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-stmmac-fix-v1-1-3aef470494c6@gmail.com>

Thu, Mar 21, 2024 at 02:54:15PM CET, mike.malyshev@gmail.com wrote:
>Common function stmmac_dvr_probe is called for both PCI and non-PCI
>device. For PCI devices pm_runtime_enable/disable are called by framework
>and should not be called by the driver.

I don't follow. The rest of the pm_runtime* functions are okay to call,
but enable() is not. Why? You need to provide more reasoning.


>
>For PCI devices plat->pdev != NULL. Use this fact to detect PCI devices

Sentence ends with "."

I assume this is a bug fix. Do you have a trace or some other symptoms?
Please add it to the patch description. You also need to add "Fixes"
tag.

Make sure you read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr

Thanks

pw-bot: cr


>
>Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
>---
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>index 24cd80490d19..db45d8dbc1eb 100644
>--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>@@ -7743,7 +7743,9 @@ int stmmac_dvr_probe(struct device *device,
> 
> 	pm_runtime_get_noresume(device);
> 	pm_runtime_set_active(device);
>-	if (!pm_runtime_enabled(device))
>+
>+	/* For PCI devices PM is disabled/enabled by the framework */
>+	if (!priv->plat->pdev)
> 		pm_runtime_enable(device);
> 
> 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
>@@ -7846,7 +7848,10 @@ void stmmac_dvr_remove(struct device *dev)
> 	mutex_destroy(&priv->lock);
> 	bitmap_free(priv->af_xdp_zc_qps);
> 
>-	pm_runtime_disable(dev);
>+	/* For PCI devices PM is disabled/enabled by the framework */
>+	if (!priv->plat->pdev)
>+		pm_runtime_disable(dev);
>+
> 	pm_runtime_put_noidle(dev);
> }
> EXPORT_SYMBOL_GPL(stmmac_dvr_remove);
>
>---
>base-commit: 23956900041d968f9ad0f30db6dede4daccd7aa9
>change-id: 20240321-stmmac-fix-f506d52882d2
>
>Best regards,
>-- 
>Mikhail Malyshev <mike.malyshev@gmail.com>
>
>

