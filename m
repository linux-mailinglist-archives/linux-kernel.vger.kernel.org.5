Return-Path: <linux-kernel+bounces-153958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD388AD550
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF8E1F216DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA70155384;
	Mon, 22 Apr 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7SHsRTk"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB0155335
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815788; cv=none; b=VvX1wGgvUKSUje0CpbIbjbHB53kyMAG7Lm12a+ZTmhAuS2p3avJt1Gsuqxo911e4sGpKFjNUStWmeIwt0GuXzjvglabhOoRFe5QLjSvUDVUtZjyYnNZL/NDM9zn8JmvInq2JfmVmf31vxKtWiZE56jcUrwk5X2FGqJnEezmgcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815788; c=relaxed/simple;
	bh=PyA4qHm52mOyermkCQUCEG0ISLw47umK1lO7AyVLnm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYy7KV9twI1LccKOaM0D5PSAIk6Nw5/Uh0dvtLiBp6xDhs8LqkHL2xqve6zk5rys9LU2yuUy2Pi2oc1DOWcXH2dNkc27dNiM7D3XiD5p+A7YFhrVvoXOXj+pvBvnKlfl0Z4EpvgN0gshlyEpBRAFhz2uVlwhNAj6fy08G4D1kyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7SHsRTk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51abf1a9332so4646324e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713815784; x=1714420584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UbtjWVwUCJ/Ep0G6WAYIECvngUoQOMEOfVKfxhjW0A=;
        b=W7SHsRTkINW304gebFKn5ish5ONdl0pPNL4W7eKbjqOf640ryRh9k6aqfWWYi+PhBT
         UL/9qogRyjnETNjRWjCvOGvFg0OaosAU7ew/nXD4XsIK/NEzHnVPKilnPtd76z0oVT7z
         urtQCVoB+L8ZXPB8rifxmry4XrT/y9PVAUlhutmJAFjAhhwaKnMUWhR8tBTMlAc3ASIt
         wbFQRg3plp+bX3x6C92wGQ+bFmO1UOWmMywDowc1sywRIKrBJNeEMTv5xJuMXOXihBZZ
         /DxSqEoYhqzn9hfaG039NQraH/VCpOwj41oXSo4Q0IltGN3aaN+QGrez7ywh0/oVHrm9
         F4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815784; x=1714420584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UbtjWVwUCJ/Ep0G6WAYIECvngUoQOMEOfVKfxhjW0A=;
        b=krhhnyn0gHU8wTjmpwCLhAvA6E3/9BmblzFgj18RKjk6c8RwPUXFyLqUOCMYHELTQ8
         cUiWuSuBP7D6rSCf9cqVQ/BnJv8eGelfIupMnPfgxsHhlv4WUdlXQKgOlJgp+Pn3Rn8p
         Y6TEJySGyB1bFRMHPqIai61dvzY/FjJn437jyQ4BQCgi9xF5WUpjaYp1mgtRr9zBy7Wy
         U7j4/Qyv9e0LamKYi1lNq2bKhY+fwdHqHEAhS9J6HCW8sWueDy8SE7EDMD45489KmoTp
         bhvTXobDg9NaPHdUaNlkJpVKP6MzW8kjPeMhp1TMpTmyjf1p9aFk8qrcR2GcdmSh5qWX
         rw8g==
X-Forwarded-Encrypted: i=1; AJvYcCWbiEvVYfY9pL82QL+mFZGi475jmBPthEB9HcBNpNWOLoMnG8Gh2iKtuDoYaLVkw6LnsZ6fFCxFw1QXgFpZedmVDTIQKAdhGlMajpxu
X-Gm-Message-State: AOJu0YzwWrCNn8L4IfPPq9ul00wER7zzaXMoZEtVLzu17Il82grGQuX7
	7SzFHSFqyaFPuUfMa0VTMjo+szWeLMgHGhCbFFCZ59cQ3VX1N/yp8JQyDqup0dQ=
X-Google-Smtp-Source: AGHT+IHRbKEd6Kb15twuNssTvNEBKSZ42gFAuOCW2DQijOTq7xBj6uhy/G5TKRMrCuOF62WWZsyRJQ==
X-Received: by 2002:a05:6512:4d0:b0:516:c7c2:23b6 with SMTP id w16-20020a05651204d000b00516c7c223b6mr6355450lfq.9.1713815784231;
        Mon, 22 Apr 2024 12:56:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id q5-20020ac24a65000000b00515cd3bab8fsm1798550lfp.154.2024.04.22.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:56:23 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:56:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] drm/bridge: simple-bridge: Use fwnode API to
 acquire device properties
Message-ID: <7xlzd62dvwjjv6zwbgjwphcgwpjpfxbv5rp243a2duobrpcvmd@gtr6cnm7ndrl>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-3-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422191903.255642-3-sui.jingfeng@linux.dev>

On Tue, Apr 23, 2024 at 03:18:56AM +0800, Sui Jingfeng wrote:
> Make this driver less DT-dependent by calling the freshly created helpers,
> should be no functional changes for DT based systems. But open the door for
> otherwise use cases. Even though there is no user emerged yet, this still
> do no harms.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 5813a2c4fc5e..3b09bdd5ad4d 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -9,7 +9,6 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -169,33 +168,32 @@ static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
>  
>  static int simple_bridge_probe(struct platform_device *pdev)
>  {
> +	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
>  	struct simple_bridge *sbridge;
> -	struct device_node *remote;
> +	int ret;
>  
>  	sbridge = devm_kzalloc(&pdev->dev, sizeof(*sbridge), GFP_KERNEL);
>  	if (!sbridge)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, sbridge);
>  
> -	sbridge->info = of_device_get_match_data(&pdev->dev);
> +	sbridge->info = device_get_match_data(&pdev->dev);
>  
>  	/* Get the next bridge in the pipeline. */
> -	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
> -	if (!remote)
> -		return -EINVAL;
> -
> -	sbridge->next_bridge = of_drm_find_bridge(remote);
> -	of_node_put(remote);
> -
> +	sbridge->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);

Can we please stick to the interface of drm_of_find_panel_or_bridge()?

Also note, the driver isn't looking for the next_bridge. It is looking
for the bridge at the fwnode remote endpoint.

>  	if (!sbridge->next_bridge) {
>  		dev_dbg(&pdev->dev, "Next bridge not found, deferring probe\n");
>  		return -EPROBE_DEFER;
> +	} else if (IS_ERR(sbridge->next_bridge)) {
> +		ret = PTR_ERR(sbridge->next_bridge);
> +		dev_err(&pdev->dev, "Error on finding the next bridge: %d\n", ret);
> +		return ret;
>  	}
>  
>  	/* Get the regulator and GPIO resources. */
>  	sbridge->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
>  	if (IS_ERR(sbridge->vdd)) {
> -		int ret = PTR_ERR(sbridge->vdd);
> +		ret = PTR_ERR(sbridge->vdd);
>  		if (ret == -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
>  		sbridge->vdd = NULL;
> @@ -210,9 +208,9 @@ static int simple_bridge_probe(struct platform_device *pdev)
>  
>  	/* Register the bridge. */
>  	sbridge->bridge.funcs = &simple_bridge_bridge_funcs;
> -	sbridge->bridge.of_node = pdev->dev.of_node;
>  	sbridge->bridge.timings = sbridge->info->timings;
>  
> +	drm_bridge_set_node(&sbridge->bridge, fwnode);

Please don't move the code. Having it in place of of_node setter
simplifies the review.

LGTM otherwise.

>  	drm_bridge_add(&sbridge->bridge);
>  
>  	return 0;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

