Return-Path: <linux-kernel+bounces-129321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA77896890
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A024F28AA74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5147F477;
	Wed,  3 Apr 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+MECMRM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1585C909;
	Wed,  3 Apr 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132511; cv=none; b=XCIkz56YR0rMo8xKRe7FMf44CYORbYCISMmti4qDtVER0KF++/MpIIF3QYqMczFssQ8mQkAyfCoVf9JSNdhLX4o92NkwvT2u7RLjQsrLXVMd4UNVbvMoC7i747EoxffW0i0SWVnHU7g52nfOCHOsk4Ilx9H6jXcbvhWr6BK8WDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132511; c=relaxed/simple;
	bh=0u5pDssKyWkYQsTffNHzasSNhkOtut+vEZs+EvBKuWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rUAHpAWITjIGnx+PKXyuyHpRVVTCfK3ia+IqjR0haT7z6xYiXjQyTYe/ltJp7UCSTWRen2vJ6U+i/JL+g5ctxhq+Bpbjx50Ug0Y+YxT8lTxoBPD0d7Hiph5TFttR1ul30w1JDPL5uFCK57JbfKGsvMHyL8geEtFgix99w535kYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+MECMRM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41624fe40a2so657325e9.3;
        Wed, 03 Apr 2024 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712132509; x=1712737309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOtG2aZPYvMjEsq2Lkc7OY8kMcgQN0ZYfGaU64JVs2s=;
        b=M+MECMRMB1TtZqoOPt/+I7nd23HJPk6APjgru3a4bIj1KGsyIGfaPcqBT3dVPVGX2N
         WQvuFb/8rQNPVrT7P8VybjINx4Imd+n6PMccxYneg6gOBxF1/WV+ceiX63C9lgJDi1U2
         dedS3t+7hUr4FENd65R9TU0pFq7qq3XzhL+zVgyPVvr6VKo3tUXswRUQbneGj4z2RpxR
         bWVW32pju+qm7UOc8zJiCAabkGvn9DhW62BJtejPnmxGNxT6hLafrWxFTU/M9rGdMADO
         KP5nPsNxmQ16fT8VE6zDmJ6lhvMsGeswChAzylwNdAEapWgOA08ZaTp7ETCbmPq4QHyH
         lixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712132509; x=1712737309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOtG2aZPYvMjEsq2Lkc7OY8kMcgQN0ZYfGaU64JVs2s=;
        b=sYe5wybUFr3PBroREcYKIqftpFSvG9X+F8epZc9wKUSkmeecMGQ+PHbATTr1wzVLfq
         O+dKhGZEdwhsMqdABx5wBHM5IA3ZIcdv3uT755uHG+dxyVRKS/exWiaCaF65l7ycBaKO
         LSbWIdFbSPCTVX/2+gw2S2StCdfJjt6RIlJri3smnTSxT4pDH/t1EZsIDrXwg7NNiOTh
         dSnWijbPaoNIjxWMHrrHQ+Vb8n4Id0zpmvZ1lLLvQKlN/QaproJ3oI6lvi9lQDfv56EW
         LhnKd5R/9GVoqM1pdNRfP7lw3ScjhtmXfP+sTkwK0c+AsdQVvmQ3CosNs05SYYfRZaoL
         MFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVObD5++MKPYr+/X09FSY//bZuZEZ3Z3DShY9JDITQx9jY4ODEQV6qN6gQr8JzxInb9RUP8qMGm6+Mz/3ZaicVVkd4dv/GeXNvPq79zUtnAWxQA8MOkh8BAC4hL3tKR0oWX5I68smT4yQ==
X-Gm-Message-State: AOJu0Yy3bH0Qz0IPR2VPTm2jtooSOUI3fTmlEO9cFAiHaTurjWcBfk0P
	JdLGtYRLvEmk3f7DqO6ZW1SaBXTm7Vk9J9e+3NgtFfaunJMj6ZWRo3/bpKoT
X-Google-Smtp-Source: AGHT+IHITiCw+ZyHNOdPQS4ZwDtmgS1xNc7Gi8xEVH0jXDD9oxZTwKeiVBidxGx8bj2wxcXhkn0Y5A==
X-Received: by 2002:a2e:9189:0:b0:2d6:c43e:f0b3 with SMTP id f9-20020a2e9189000000b002d6c43ef0b3mr1091942ljg.50.1712132485169;
        Wed, 03 Apr 2024 01:21:25 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id e4-20020a2eb1c4000000b002d71a341375sm1457593lja.41.2024.04.03.01.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:21:24 -0700 (PDT)
Message-ID: <8bd6e631-ea7d-4380-be98-9719279111a4@gmail.com>
Date: Wed, 3 Apr 2024 11:21:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mfd: rohm-bd71828: Add software-compatible variant
 BD71879
Content-Language: en-US, en-GB
To: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402193515.513713-1-andreas@kemnade.info>
 <20240402193515.513713-3-andreas@kemnade.info>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240402193515.513713-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 22:35, Andreas Kemnade wrote:
> Add the BD71879 PMIC which is software-compatible to the BD71828, so reuse
> the same device_type enum.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/mfd/rohm-bd71828.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index 4a1fa8a0d76a..f0b444690d4d 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -585,6 +585,10 @@ static const struct of_device_id bd71828_of_match[] = {
>   	{
>   		.compatible = "rohm,bd71828",
>   		.data = (void *)ROHM_CHIP_TYPE_BD71828,
> +	}, {
> +		.compatible = "rohm,bd71879",
> +		/* equivalent from a software point of view */
> +		.data = (void *)ROHM_CHIP_TYPE_BD71828,
>   	}, {
>   		.compatible = "rohm,bd71815",
>   		.data = (void *)ROHM_CHIP_TYPE_BD71815,

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


