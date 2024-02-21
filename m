Return-Path: <linux-kernel+bounces-74738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C585D874
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264F51F24134
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378569954;
	Wed, 21 Feb 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpzJnbgd"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19296930F;
	Wed, 21 Feb 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520121; cv=none; b=Sr34OQq3z1vd6o28amm6iDjL3D88+hKQzsRDVNAl+AA6IoVbZscXmyVW/W+hML0eWbVHntTkJfi0xhMYQys+Q35I/qxY0w/cKdbxljjfVCJ1vO6Ih0zM6TRnuSHSntZcoJUYlfGQVYtIZB/67u5y+//hQpgOT/eqm7bb/iVqqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520121; c=relaxed/simple;
	bh=GdiYV6wsr4EXwoXzZq3jKtYq6R298hyFdhnVeW4EdHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDA2gvZZ+fvYK1J3mhJPb3qyCbaHqXMuiKdkJGlt9xsW8hpYynKRJsn39GfDxUtFf33YUrc56InxRZLJH9A80gbHJ2rWm/flbdQ77P+SMV0KIOS5zf/FzLoX7Uly6OZrmLvF/eU4HO9H2F81zUU6ADs2KpJ7W/fR8lw3lM3lEiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpzJnbgd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b276979aso5060121a12.2;
        Wed, 21 Feb 2024 04:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708520119; x=1709124919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ry5MLE8fdfKGpRekU3VbZpIvbs3UzBTVWXCqh6a6iiU=;
        b=JpzJnbgdoRV7O/+wyZ2Leoqyn6rsj3DJ8wyRboxM0O3n0d41Rtpq5luht6Irve09BC
         f9y5Y+9IcEVQ7S+l/xtxguMmbDx9IJCBnnMt/m0Q5vqb9wjNT1xHAs/cH1Ny5z7+4Bff
         KIT5TpiJXu4jhAJdICfmgoJaSf2at7KcTa/9JdGr4svKNkfGAs+tZz9gipHUZ4Xxlnmz
         obs9amrzOXvgMoWX8IgR4F8efnfUCkcQ6nCFjVnmnlkn4bunlAqN2hM+iyX0s6pJ1htf
         epsnLs8YdcF430ARk8nI0p75bHzR2f8Q+3q1KJDEaRk/gPrMh/ZSg3Oq3ikHCE1GWyQJ
         x7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708520119; x=1709124919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ry5MLE8fdfKGpRekU3VbZpIvbs3UzBTVWXCqh6a6iiU=;
        b=n/I+70k2qbei1Ksts35K+fs+K6hrv8KuUjF+Qh6y55JxIBJAXTPb2FRYS9Hx5aUHII
         nm6NfTZEzk/a/yPbioED31VZvlFxPQVrtnmTKpHn67CqGw/I7UBLRi9iZGeXefCkQ2L1
         fh4s48O1yNDjsXpJqpQrDzMDjqHKdSIH8cuu8mTTiKNsIjKYPzopsVm23BuMmQAN8T5s
         bsEmFkJvdfEHUu4WBqxLVgRaDhTEq9w94UAeIw9CX8jMx+JiP1t4DYCke1FZ8c/j0Aee
         mO3izf/pz59KfqEbGo6qAYtpOSx/UUpOtwyYPk/EhV7LHOP/Ct31eL9urkzyFdWrfSRv
         3wGA==
X-Forwarded-Encrypted: i=1; AJvYcCWVcjCfQP8eSs9fE2+/JaTLSm0PAOQvyNg9wwhViJ6PG6tkXKGC6BsVf7fYaj8KVzKFwWU0G4ZiO5DL81zoJirvog3VNiqwoAnVnV/M+sbxbLV07KOBwdPJlFGTeH0bE2tgPOcPoBUNPe6qn4qknhXH1Y4Cjw/fo6rcgDozTUCStPk61r1E9Lij
X-Gm-Message-State: AOJu0YwM5zdYcvyFYK2Q74nPCUVS9gccSwugFXUXJeGPzDHbNJ719hHU
	S7Ca+kTs6pkr6nzmo4tpYMXAnzRI3v8iWfPiCcKk3FNKmc1zFMQo
X-Google-Smtp-Source: AGHT+IHLrLFSSc6fZHMtNHfKAVemaBpDk5FTLqVIp+18M27GOK/iRJsTJJvJizh/K9D3vhRQWhh2Jg==
X-Received: by 2002:a05:6a21:3a82:b0:1a0:cb1b:390d with SMTP id zv2-20020a056a213a8200b001a0cb1b390dmr685189pzb.52.1708520119170;
        Wed, 21 Feb 2024 04:55:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b006e471ade144sm4573360pfj.188.2024.02.21.04.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:55:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2024 04:55:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: forbidden405@outlook.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] watchdog: sp805_wdt: deassert the reset if
 available
Message-ID: <93e75a27-5676-4ce7-9860-258d9019977d@roeck-us.net>
References: <20240221-hisi-wdt-v3-0-9642613dc2e6@outlook.com>
 <20240221-hisi-wdt-v3-1-9642613dc2e6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-hisi-wdt-v3-1-9642613dc2e6@outlook.com>

On Wed, Feb 21, 2024 at 07:56:41PM +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> According to the datasheet, the core has an WDOGRESn input signal that
> needs to be deasserted before being operational. Implement it in the
> driver.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sp805_wdt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 2756ed54ca3d..109e2e37e8f0 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -25,6 +25,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/pm.h>
>  #include <linux/property.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> @@ -232,6 +233,7 @@ static int
>  sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>  	struct sp805_wdt *wdt;
> +	struct reset_control *rst;
>  	u64 rate = 0;
>  	int ret = 0;
>  
> @@ -264,6 +266,12 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  		return -ENODEV;
>  	}
>  
> +	rst = devm_reset_control_get_optional_exclusive(&adev->dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(&adev->dev, PTR_ERR(rst), "Can not get reset\n");
> +
> +	reset_control_deassert(rst);
> +
>  	wdt->adev = adev;
>  	wdt->wdd.info = &wdt_info;
>  	wdt->wdd.ops = &wdt_ops;
> 
> -- 
> 2.43.0
> 

