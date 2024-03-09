Return-Path: <linux-kernel+bounces-98016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99D187735D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5291C2095D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CBC45BE2;
	Sat,  9 Mar 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="aAK4D8VQ"
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E343CBA4D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009757; cv=none; b=KBlA9pelcIENFZfXDNO0DPReaXiCeL1Aj8PVKPpY0YyUuXtxhb6U4a9Xws4ea22NxUOgPIX12IZvbiHylQbsJ63a5z9rkETTJzl+fgdeAH3pTFiSVmjRXhoHZMq6257k2QVugHBhiFvjGKH6f3SGqfFUC8DjRApERLFzUi4fHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009757; c=relaxed/simple;
	bh=c8PmTWLnnDb//vMowOEKQb0imEN0Yqkw5iZkuZXjioU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvP89SXhMdeS0NCNaxp5I/rD7ikIu4oysndM+yJCvvWcQNAHHxgPQIRzsSVIgCvrgndRTn5AypViNbYEuvNKjGYo/W+6FSZUuyBYIQr3Abphhd5M/CAdAYsEFdxd81dCu3pD7CKGOwVy5AJWcArNrJ1BupT4iYanC4Te2+mtEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=aAK4D8VQ; arc=none smtp.client-ip=80.12.242.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id j1eIrVhPHEp3aj1eJrrqB5; Sat, 09 Mar 2024 19:42:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710009746;
	bh=0j0PKKkwYYvccxlRTUfbfOmfkc4Yb70UUL+d4S0VMjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=aAK4D8VQ2lfRVr54MgsRiBdhNCTXu1jbvzCEAWkVAS0JMSaZ/qY+fPRUUT6cg7XVU
	 oXCHU5lIZ9LjOXHq1vSHQGqny++IK6FGxdWOJgx7zWor10kSE2H4ZhJgNwjbaOK0ND
	 uwB1tjiAGL4NgOHN+4B/L39CyNU+rludAvZ9jfmGR/BcSLQO7tQ/H7x/NXZnY5Gema
	 Rxx52DN7raL1EH2GNMyue8N6zOz5BV5VNAXD3+erXujY3/ftAcYe3RayNOGaZgd8zL
	 KeNMEicN7pDLc8aYlQZxj9pfMyNLhsz20Nh7g3X9hgSmBr90FtItXZ/mO85HpHvcmZ
	 Yixw0nja3tpew==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Mar 2024 19:42:26 +0100
X-ME-IP: 92.140.202.140
Message-ID: <b354e05d-c699-47a7-b4e2-dd844902b85c@wanadoo.fr>
Date: Sat, 9 Mar 2024 19:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: core: Calculate alloc_size only once in
 iio_device_alloc()
Content-Language: en-MW
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: Jonathan.Cameron@huawei.com, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com>
 <20240304140650.977784-3-andriy.shevchenko@linux.intel.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240304140650.977784-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/03/2024 à 15:04, Andy Shevchenko a écrit :
> No need to rewrite the value, instead use 'else' branch.
> This will also help further refactoring the code later on.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/iio/industrialio-core.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8684ba246969..c7ad88932015 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1643,11 +1643,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>   	struct iio_dev *indio_dev;
>   	size_t alloc_size;
>   
> -	alloc_size = sizeof(struct iio_dev_opaque);
> -	if (sizeof_priv) {
> -		alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN);
> -		alloc_size += sizeof_priv;
> -	}
> +	if (sizeof_priv)
> +		alloc_size = ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN) + sizeof_priv;

maybe size_add() to be super-safe?

CJ

> +	else
> +		alloc_size = sizeof(*iio_dev_opaque);
>   
>   	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
>   	if (!iio_dev_opaque)


