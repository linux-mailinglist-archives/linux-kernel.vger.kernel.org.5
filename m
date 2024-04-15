Return-Path: <linux-kernel+bounces-144537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A58A4789
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB04B21FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B24FC0C;
	Mon, 15 Apr 2024 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eBcGSnfF"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19AFDDA0;
	Mon, 15 Apr 2024 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713158527; cv=none; b=FHoa7X5V2Hp5K/O+IbhL9blFJJFl3bBBzJ77QsL+mS4dJ3zTQM7OZnVzy7nZpcN1c+vB6zo8AE87RBewtglXgS/NdBniw6gDyhWehYqAziNGXKdMLKTndJ0g4gBHNOyzo6gJulMdts+1KNEquO6C32yiw0oqxZULh8mzEjWwnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713158527; c=relaxed/simple;
	bh=af+vCRXyspSi9MJ0pzGRGuEN+y5mi6S+Gs2cHujIqH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq5qY4iHQM69oOQig+oecpltCbgbKSgnk75wk5+LJNz7Bclz3hu8L7SrfIms1EyjGIlsLqxqhdiHKs9JrXHdImHQEvEygLI0bKiObz3o46rCgkkJN75p7rUtWLSd1Uh2LgDZcXNvuhsCl690IS2e57U1Z/3y1XOojzo4vWzcJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eBcGSnfF; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id wEltrhWOB6xfSwEltr3EP3; Mon, 15 Apr 2024 07:20:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713158451;
	bh=e+coi2XuyVt27S+sawO0+ct4WY40vRADSePAuZ4om2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eBcGSnfFRZpQCrq0tFRGpc9UskSnQVSvwdaDbTHmuLJHlDyal1yldoi0VkObbgki1
	 GfRoj8hxjcXuNnKYQDGw9t0aI/mRTzSdlNft8YE8QylB4pyGuEEtqgMcQ/i0dxs3XS
	 CgQ1cdzkJ2+x0IpIq4WCmqsGSx195jgU5vkjRBFPaQKsFhKSwtgzA/uapMQN8XosBa
	 eipJ7EVDkOhzsqQi7N8JxCssgUEjPV907amEfqah4BtAtPJdC6pd9Cjwdpmka7CxFZ
	 hW+BlngWFO8c/9Ou12h7fTO+ldRbWg0gCIHEA53748cuoMEi97a4YiTImxlW/criqt
	 EJ2pcsUINSuxg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Apr 2024 07:20:51 +0200
X-ME-IP: 86.243.17.157
Message-ID: <b8751b8d-f42d-4121-836d-f21b91df1b7e@wanadoo.fr>
Date: Mon, 15 Apr 2024 07:20:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mmc: sdhci-acpi: Use
 devm_platform_ioremap_resource()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240412184706.366879-2-andriy.shevchenko@linux.intel.com>
 <20240412184706.366879-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240412184706.366879-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/04/2024 à 20:46, Andy Shevchenko a écrit :
> The struct resource is not used for anything else, so we can simplify
> the code a bit by using the helper function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/mmc/host/sdhci-acpi.c | 20 +++-----------------
>   1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 32ae6f763c1d..b9c8eb87a01a 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -779,8 +779,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>   	struct acpi_device *device;
>   	struct sdhci_acpi_host *c;
>   	struct sdhci_host *host;
> -	struct resource *iomem;
> -	resource_size_t len;
>   	size_t priv_size;
>   	int quirks = 0;
>   	int err;
> @@ -801,17 +799,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>   	if (sdhci_acpi_byt_defer(dev))
>   		return -EPROBE_DEFER;
>   
> -	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!iomem)
> -		return -ENOMEM;
> -
> -	len = resource_size(iomem);
> -	if (len < 0x100)
> -		dev_err(dev, "Invalid iomem size!\n");

HI,

Was this test useful?
Should it be mentioned in the commit message?

CJ

> -
> -	if (!devm_request_mem_region(dev, iomem->start, len, dev_name(dev)))
> -		return -ENOMEM;
> -
>   	priv_size = slot ? slot->priv_size : 0;
>   	host = sdhci_alloc_host(dev, sizeof(struct sdhci_acpi_host) + priv_size);
>   	if (IS_ERR(host))
> @@ -833,10 +820,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>   		goto err_free;
>   	}
>   
> -	host->ioaddr = devm_ioremap(dev, iomem->start,
> -					    resource_size(iomem));
> -	if (host->ioaddr == NULL) {
> -		err = -ENOMEM;
> +	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(host->ioaddr)) {
> +		err = PTR_ERR(host->ioaddr);
>   		goto err_free;
>   	}
>   


