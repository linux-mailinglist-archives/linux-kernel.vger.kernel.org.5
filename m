Return-Path: <linux-kernel+bounces-117511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5C88AC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9822A6E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDF54DA19;
	Mon, 25 Mar 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqSN8ykM"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1CE4DA0E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385508; cv=none; b=lC6Z9HHkkDsLZ9Ssc58Z5R3cT9idNSu3kUiD9A8N17cl1JhLOV3MWr+rqdAzlM4GJIQRY2M6+ZQChZDJZCGIGx0FFGLiXMal18P2DeTRrC0n8vdJvHjHEQttALx6eNkA7a2iS0YbFzAMm1uMt04HrPbGFZ4YiPlLYCKHKFMHzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385508; c=relaxed/simple;
	bh=R1UgrdHtX7NaBhIlzazKjCiPt8qDyKrwuHqMIduiCrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epx9o/ivGBhMZj0Isztahtg7uvWLNpP/hZq/X0xas1Yu9wgHyir5QYQOB0VbChWXMJXa7qS17APlcYOTM+TMqlx7oG3GLQyARpvLg4rwo9MUGUntCn9MjizQ8kkK/jkeLhnS0ly/N2tsI+hMWcXhMwYQq0aYUbBZfaaty0OXBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vqSN8ykM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e034607879so35610375ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711385506; x=1711990306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pj8PTKVryqKwwdBoZ+0WnicFRNErWIn69RAMUd5IKdc=;
        b=vqSN8ykMVrd2oHNvAGS9j0SG0p8EODHibAzv/GO+LRemaM7hMLCowpopYxNYTlQmVH
         n7y5rZXwnx+5RAY+Gz/+NuYNk7Lm9ktAuVAQa9EXWRPb9W2xPKMvvlQq6qaFjz5SmqXl
         CwSWRTKHM+DHoEAIz3Gkyy4BcOTyV5suZSdoEy0y8q3ffnviZfgiHoWcDZk8XEGJUawz
         fWrg6DEixZQVpv2XRklgjQBM5Mz7JEhb9K+uN4UuhVxyPk6lygsocVWDicgvGX8KZKqL
         nl3L8jnvLywG28l2P0X9ExdesLhCCplB8w8R50k/SDIsYdKp+KIXXXiGkNY8LTJ+G0Uv
         UJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711385506; x=1711990306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj8PTKVryqKwwdBoZ+0WnicFRNErWIn69RAMUd5IKdc=;
        b=s2MJnfuvRVfHNp8MLQNWQG0VZg1hjfdLEffrR173YqW6OX6PxJtsSD43/QnlboADvO
         uoUUuZPBKZzHUli9n48V7UB9QYGdMRdEhBdNV9z2X5oukeP2OqmPA1EbLPsC/cTIuBAE
         pxZuix9UX2BnMSxJQal2diNPFO96TQFLJfBepmCp+VNcYxgz3CVMZDHgbMEkD8evTZtm
         UyGDiVDSbPy1vL+m4QoNxnFDGUNT/Mt+4SrUH3/KBUmbklLNemF92B5BG4g+C70JCZeW
         0E7Dm+/fEIhMrflwBBTXLerwbfI0uUhbjJziV67PBUmr3ZIxthyoS8t2Wh8IsrKNpRu9
         XeQw==
X-Forwarded-Encrypted: i=1; AJvYcCWg1d5QMz47mYzxFasfSROhIVR3INkMo6IhE5qgXPJuJPJkTIsry7dDLD/TmCZWjWh6+dzOirAjT5qw9RKA0NdJHGq8Txd3BqoK73rV
X-Gm-Message-State: AOJu0Yy4xC/sQXDQVQHqnaqKgYWNOnyR8hgx6g0WrGOkYh0q/PGJ0v58
	3KpHRiw3Ju5tRo2p/dZ5NEW52wz3p/Hyj1J1KL78UtBmkeX+6vwfcb/BkoI4/4sG9JJCHR7flm/
	9
X-Google-Smtp-Source: AGHT+IGoV4RhZKceQIINbyMVzRZ5e1HPuju79F8lHHNd/Bx3c+IjzhBFu/0IBlEFjOn25VeKI5qwIA==
X-Received: by 2002:a17:902:f54c:b0:1de:ff81:f650 with SMTP id h12-20020a170902f54c00b001deff81f650mr12006579plf.10.1711385505732;
        Mon, 25 Mar 2024 09:51:45 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4a22:28de:eba3:89d1])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001e0c568ae8fsm1517672plx.192.2024.03.25.09.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:51:45 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:51:42 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Message-ID: <ZgGrnkcebcIQQic6@p14s>
References: <20240308144708.62362-1-arnaud.pouliquen@foss.st.com>
 <20240308144708.62362-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308144708.62362-5-arnaud.pouliquen@foss.st.com>

On Fri, Mar 08, 2024 at 03:47:08PM +0100, Arnaud Pouliquen wrote:
> The new TEE remoteproc device is used to manage remote firmware in a
> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
> introduced to delegate the loading of the firmware to the trusted
> execution context. In such cases, the firmware should be signed and
> adhere to the image format defined by the TEE.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> Updates from V3:
> - remove support of the attach use case. Will be addressed in a separate
>   thread,
> - add st_rproc_tee_ops::parse_fw ops,
> - inverse call of devm_rproc_alloc()and tee_rproc_register() to manage cross
>   reference between the rproc struct and the tee_rproc struct in tee_rproc.c.
> ---
>  drivers/remoteproc/stm32_rproc.c | 60 +++++++++++++++++++++++++++++---
>  1 file changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 8cd838df4e92..13df33c78aa2 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -20,6 +20,7 @@
>  #include <linux/remoteproc.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/tee_remoteproc.h>
>  #include <linux/workqueue.h>
>  
>  #include "remoteproc_internal.h"
> @@ -49,6 +50,9 @@
>  #define M4_STATE_STANDBY	4
>  #define M4_STATE_CRASH		5
>  
> +/* Remote processor unique identifier aligned with the Trusted Execution Environment definitions */

Why is this the case?  At least from the kernel side it is possible to call
tee_rproc_register() with any kind of value, why is there a need to be any
kind of alignment with the TEE?

> +#define STM32_MP1_M4_PROC_ID    0
> +
>  struct stm32_syscon {
>  	struct regmap *map;
>  	u32 reg;
> @@ -257,6 +261,19 @@ static int stm32_rproc_release(struct rproc *rproc)
>  	return 0;
>  }
>  
> +static int stm32_rproc_tee_stop(struct rproc *rproc)
> +{
> +	int err;
> +
> +	stm32_rproc_request_shutdown(rproc);
> +
> +	err = tee_rproc_stop(rproc);
> +	if (err)
> +		return err;
> +
> +	return stm32_rproc_release(rproc);
> +}
> +
>  static int stm32_rproc_prepare(struct rproc *rproc)
>  {
>  	struct device *dev = rproc->dev.parent;
> @@ -693,8 +710,19 @@ static const struct rproc_ops st_rproc_ops = {
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  };
>  
> +static const struct rproc_ops st_rproc_tee_ops = {
> +	.prepare	= stm32_rproc_prepare,
> +	.start		= tee_rproc_start,
> +	.stop		= stm32_rproc_tee_stop,
> +	.kick		= stm32_rproc_kick,
> +	.load		= tee_rproc_load_fw,
> +	.parse_fw	= tee_rproc_parse_fw,
> +	.find_loaded_rsc_table = tee_rproc_find_loaded_rsc_table,
> +};
> +
>  static const struct of_device_id stm32_rproc_match[] = {
> -	{ .compatible = "st,stm32mp1-m4" },
> +	{.compatible = "st,stm32mp1-m4",},
> +	{.compatible = "st,stm32mp1-m4-tee",},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
> @@ -853,6 +881,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct stm32_rproc *ddata;
>  	struct device_node *np = dev->of_node;
> +	struct tee_rproc *trproc = NULL;
>  	struct rproc *rproc;
>  	unsigned int state;
>  	int ret;
> @@ -861,9 +890,26 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
> -	if (!rproc)
> -		return -ENOMEM;
> +	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
> +		/*
> +		 * Delegate the firmware management to the secure context.
> +		 * The firmware loaded has to be signed.
> +		 */
> +		rproc = devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, NULL, sizeof(*ddata));
> +		if (!rproc)
> +			return -ENOMEM;
> +
> +		trproc = tee_rproc_register(dev, rproc, STM32_MP1_M4_PROC_ID);
> +		if (IS_ERR(trproc)) {
> +			dev_err_probe(dev, PTR_ERR(trproc),
> +				      "signed firmware not supported by TEE\n");
> +			return PTR_ERR(trproc);
> +		}
> +	} else {
> +		rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
> +		if (!rproc)
> +			return -ENOMEM;
> +	}
>  
>  	ddata = rproc->priv;
>  
> @@ -915,6 +961,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  		dev_pm_clear_wake_irq(dev);
>  		device_init_wakeup(dev, false);
>  	}
> +	if (trproc)

        if (rproc->tee_interface)


I am done reviewing this set.

Thanks,
Mathieu

> +		tee_rproc_unregister(trproc);
> +
>  	return ret;
>  }
>  
> @@ -935,6 +984,9 @@ static void stm32_rproc_remove(struct platform_device *pdev)
>  		dev_pm_clear_wake_irq(dev);
>  		device_init_wakeup(dev, false);
>  	}
> +	if (rproc->tee_interface)
> +		tee_rproc_unregister(rproc->tee_interface);
> +
>  }
>  
>  static int stm32_rproc_suspend(struct device *dev)
> -- 
> 2.25.1
> 

