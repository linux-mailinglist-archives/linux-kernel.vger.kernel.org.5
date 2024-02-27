Return-Path: <linux-kernel+bounces-83211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6AD86904E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AA11F28946
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9D13AA2C;
	Tue, 27 Feb 2024 12:20:55 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1213957E;
	Tue, 27 Feb 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036455; cv=none; b=mwI2klrZAWs0uiW5d90CyPU4tn1Gd3jn/fN4voV8MZaaS3ROFuoBortEyKUw10Y0B2g5HqcGjiogb5mAAvkhc+v6WEkrBv2C75Y+OmP5XpddWv8mc6AkI9COc/dyn9RNrxXK3V7JDRExwMrS7l/eSmFtAa9TZLvoSAvWUnYOjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036455; c=relaxed/simple;
	bh=iC88RgM5r5SiEYIkA/txize5IVZ7sGnIcuQvwD8EN0s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxzZGgch2OekqdyywpffSjdx/5npm/8lsor3LzQ5L7hSl++VFRw9Hp8IB0KAEJfuE6ZLoj+Qq/JPO+T2yPFWiDC8WzqNDsjK3903s7rNCHJyApAhtyF36c4J69BUk7TVnRJ+QtlSgFMfhou9RQJ0EVKfygEzwTsVMD+PShd05zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tkc1C0j7Lz6K90Z;
	Tue, 27 Feb 2024 20:17:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B60BF1404F4;
	Tue, 27 Feb 2024 20:20:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 12:20:47 +0000
Date: Tue, 27 Feb 2024 12:20:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Martin Kaiser <martin@kaiser.cx>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwrng: hisi - use dev_err_probe
Message-ID: <20240227122046.00006c97@Huawei.com>
In-Reply-To: <20240226185700.39411-1-martin@kaiser.cx>
References: <20240226185700.39411-1-martin@kaiser.cx>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 19:57:00 +0100
Martin Kaiser <martin@kaiser.cx> wrote:

> Replace dev_err + return with dev_err_probe.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Maybe worth wrapping the line in this subsystem still strives for
<= 80 chars


> ---
>  drivers/char/hw_random/hisi-rng.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/hw_random/hisi-rng.c b/drivers/char/hw_random/hisi-rng.c
> index b6f27566e0ba..4e501d5c121f 100644
> --- a/drivers/char/hw_random/hisi-rng.c
> +++ b/drivers/char/hw_random/hisi-rng.c
> @@ -89,10 +89,8 @@ static int hisi_rng_probe(struct platform_device *pdev)
>  	rng->rng.read = hisi_rng_read;
>  
>  	ret = devm_hwrng_register(&pdev->dev, &rng->rng);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register hwrng\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register hwrng\n");


















>  
>  	return 0;
>  }


