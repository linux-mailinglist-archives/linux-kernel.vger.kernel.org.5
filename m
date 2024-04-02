Return-Path: <linux-kernel+bounces-127540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D03894D56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7381F22AFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9398F3DB9A;
	Tue,  2 Apr 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mLeIThmn"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E563D57A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045981; cv=none; b=nMZhpIKXCjbricXWb4MLIOLhx76ksPyqvR3fs7reEqvcWEDhN9mslKjFBYr0QFMeOtLjv/7CKv5SCrXotd9bvsB02BcCM2iy2KQDYtQ2YAUsjcF5oOL7UHulHNgFsRxyGpb5E8czT9d7qzpKeApXeNi9K7reshYrY7CdY+0da5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045981; c=relaxed/simple;
	bh=7NiD2rTtekBippb303o/PwVTk8fqzYuL/kFsudbCtCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOuHkF9p0jROryz8RMwiMbWhhWvq1ONuGVctj9OMmgMg+Hf5lFoI2Q8/Wa34OaZUbpE1+YmL2XHb97aLJlsrpW//4NF41QqVUo8R8WFJ66bvm9BFGKW7ZAshFw01q2/zQCu2GrYdecF9wBFzsJH1406j+BPO4liwRWFeWqavH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mLeIThmn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6ee81bc87so43227421fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712045978; x=1712650778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gvKuEkojvEJgZVr6mPnxPmclDAQ+3pW/HiTvyYuEMzE=;
        b=mLeIThmnNO3dX/p9paZpPSyVisksMMtk2/gbD1L+6czeOheyg4i84vkPXfGY6EX4Te
         uGkWefPFOibegv5v9ihBcPZcG3k7orZGHwbNEwDUUQMbtpWVjWqI3zUV1cdb1YpC7oKH
         0Zn46l9akLpIlwLes6rJd4JWKIzevwXTp7FqkJIj3DNcon52PozY3a2dXO7U1J7fFTsU
         Huw1z5oq2jjQbk7dr253/IaQjUePlR43BSQm618E7HKzFMQsSbEtd0/q880vtmM6WqgB
         u2QvcpMlwjtNsBc5BwEgBzUfUMX6twE54skVUupNtBQdaVCaRbSL1mlMs0oeTlFpE7xK
         9Ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045978; x=1712650778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvKuEkojvEJgZVr6mPnxPmclDAQ+3pW/HiTvyYuEMzE=;
        b=mAfU/JIZVzr3KvHeWDXHsDbVSXBVMoDfzele7y4j198xweHrqCXsj81ec9gLvu6LaQ
         KVuQNls3toNKQzcT7SNhp4YKnek0iftZgxljO3niTCmhqW/W0tsLDD1dMIClUHExeBtL
         0ChXi+DdA2oa6FThOrnmm1EZUaBrRw8i72GWEgOu+NHJQnqFGP5SQaveqe8Zw1HmC803
         RdWD69SN/i2yPTUlcakgzf0WNbAvVGIyR5TUlLkqZ5j2BukAvL3ulpEeeU5hwvgQgsKk
         5z4ZIVHoc6y7lfix+h5QccnkmxEH3GOhXzDpjPzrF4Y02lPv/ixOkIw8kk3qIAGZI9IX
         iZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmE34NFUYsgJwE6PLpYzr0GOSdMGMpCcVVbt0Yk5YarP2mGDbqJiRm3KBxXRuX3Vnq5ImwhORn0fHnww3WGFHGb/8qmmPHhHxc50//
X-Gm-Message-State: AOJu0Yx9wNIiUoj7DCXof47rwmDB/dBT1/MHZTrN3bn2Omm4mbujjgb4
	Uyh9157Xz3aKbhucjGMh2UQx0xNIl2e4dZ2zDDsdVbrjODfBEzjivcALvsPXP8Y=
X-Google-Smtp-Source: AGHT+IEdC7QAWpDO9ofMLjj5d27IdqehrMkIhnDY5YTTVjp3/Rqjsn5l64obtRMXwHeVHJBUbxPVAg==
X-Received: by 2002:a2e:a989:0:b0:2d4:6aba:f1a3 with SMTP id x9-20020a2ea989000000b002d46abaf1a3mr7609411ljq.6.1712045977722;
        Tue, 02 Apr 2024 01:19:37 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id by7-20020a056000098700b0033ec94c6277sm13556503wrb.115.2024.04.02.01.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:19:37 -0700 (PDT)
Date: Tue, 2 Apr 2024 10:19:36 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Andrew Davis <afd@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] firmware: ti_sci: Unconditionally register reset
 handler
Message-ID: <mnksnjonudeih2iijiu25ewzrlme277nhhcy573qsold5aletu@gyid6glsgg33>
References: <20240326223730.54639-1-afd@ti.com>
 <20240326223730.54639-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326223730.54639-3-afd@ti.com>

On Tue, Mar 26, 2024 at 05:37:28PM -0500, Andrew Davis wrote:
> There was once a limitation that there could only be one system
> reset handler. Due to that we only would register this handler
> when a non-standard device tree property was found, else we left
> the default handler in place (usually PSCI). Now that we can
> have multiple handlers, and TI-SCI reset is always available
> in the firmware, register this handler unconditionally.
> 
> This priority is left at the default so higher priority handlers
> (like PSCI) are still attempted first.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus
> ---
>  drivers/firmware/ti_sci.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 9885e1763591b..160968301b1fb 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3299,7 +3299,6 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	struct mbox_client *cl;
>  	int ret = -EINVAL;
>  	int i;
> -	int reboot = 0;
>  	u32 h_id;
>  
>  	desc = device_get_match_data(dev);
> @@ -3323,8 +3322,6 @@ static int ti_sci_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	reboot = of_property_read_bool(dev->of_node,
> -				       "ti,system-reboot-controller");
>  	INIT_LIST_HEAD(&info->node);
>  	minfo = &info->minfo;
>  
> @@ -3395,14 +3392,10 @@ static int ti_sci_probe(struct platform_device *pdev)
>  
>  	ti_sci_setup_ops(info);
>  
> -	if (reboot) {
> -		ret = devm_register_restart_handler(dev,
> -						    tisci_reboot_handler,
> -						    info);
> -		if (ret) {
> -			dev_err(dev, "reboot registration fail(%d)\n", ret);
> -			goto out;
> -		}
> +	ret = devm_register_restart_handler(dev, tisci_reboot_handler, info);
> +	if (ret) {
> +		dev_err(dev, "reboot registration fail(%d)\n", ret);
> +		goto out;
>  	}
>  
>  	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
> -- 
> 2.39.2
> 

