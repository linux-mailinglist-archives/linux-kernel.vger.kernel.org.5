Return-Path: <linux-kernel+bounces-75202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC8B85E4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44572283B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4383CCE;
	Wed, 21 Feb 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMbIcT8O"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2C1C20
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536899; cv=none; b=WGwE4l7hRDe88ytCnIps+42ian75TQUYvVoT5yPTGX3WYTSvkanvZzyGjiCe/ndKA3+iAIG0F6kMryiNmWaDjtebsOfzacwdZr4MRElhlZAe7AMkBN0IfKePTFgaPrZTItlu+nneD8OZGeAo8reExBYY3h/C6bYlLNQgGDeiAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536899; c=relaxed/simple;
	bh=HzSReKzRzBUvmn6ggj+FRr4aRuCzrHPbNa8t5p5O8lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLWClAxMyeC5U+D2uykyPpT2X8qKPqG8I+XS7GNKBRHbFrENzqSMxyzxlg7dOShDSoMc4AiPiKC4xDfrNl5Cf6w71owl6EGtjBvgf1EEHVESE8QWJ3ifuTExK5vbyxyU4Qh3yOtalkb/57+jOoTfnnMnfAhyEfvWTh5mtJihtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMbIcT8O; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4741b23d7so2251169b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708536897; x=1709141697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6i/5+wAjAhxCfAy1lZZTKEUAvmZVwqR9MqJQFB/l10w=;
        b=gMbIcT8OSn8uq6zKBd7G6gmx4GoyKexLaxI7H8SJ+auLx9A3z2bQyU6QSqYZOjz6vK
         vbBi9/2vkXQEiRoPcyPeflCbgechUKJ09TyJ3XpufLF7FBKe24OI5nhLOCoq7WL5FyOC
         NoWqao2YC2XjE5wJMY41MZ1DVMXk51Ne0bkWdZmjKz4nkDIOETvvsAUf/N3TQ++ojb15
         F+wpm3kWs4ZpbSgE2sgXOeld/7SHgMe1QuIZN3PNIUVTn+lcO6eFgUAD4Rh8ZD4QUVrr
         NgVCs4CuLwF9VuYagaQQm82b33bnfK+HjmSJOVFlDxNBqi8MK8Mw7bBh0cFWkWtQqgJn
         J8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536897; x=1709141697;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i/5+wAjAhxCfAy1lZZTKEUAvmZVwqR9MqJQFB/l10w=;
        b=dzeljcku6THpcTQ+VCBsKkvZCA3gDsT5Jb1JH/rTb7Aedi3ERch4MweCScMz4hOveu
         k+VaiWKFb7stwZhrOya5z5caECYdL9lPsfYOU380PFcvJeu7Tw2m6w+L8cctrkIk/YOq
         Wc21bQO7LvDCvyhZPeMgncH0fVzE3BQDc30KxRSJ1Tmkqw8cSQni6FLAlOPb/1Qcu6Qx
         izppL5P4UxhlcytvHqfWVXvGqfEZwo+4MawkDuVlS26VynKjwAMsuIlLFi3uhPL76TYL
         BGJnilNM1EGxwtJRrRA7WnmO/nL/QDftv7M2Lr1xrVBsPxvoGEJ3bh/kL4R9XawlsL44
         q5bg==
X-Forwarded-Encrypted: i=1; AJvYcCWRa8cnJco9JUwioMomCJYm1TeeIWXoKXh70B+/zJdVEkwswm8KR7mZhZoHI4JjTDyHsXdUvD6VSrivEWuxaKy2i2ZBoyriIMzWDwEx
X-Gm-Message-State: AOJu0YxZ+9ABdFcCocdLkligcjCvDe0i8gvQoCUhLe06O6hyNwwjpozi
	VX6yR6aT/0AcxL9wDVEnXcFPik5t6K0VYXryCVkQlhrfnpknbOv7
X-Google-Smtp-Source: AGHT+IHyCW/M9Hn409XcgS1i1VlNbcVkcSQprSu7hN2XCAX8K7TtU41M3KEc/Jgz2InYuiG/+SJEfQ==
X-Received: by 2002:a05:6a00:9a4:b0:6e4:59b3:928c with SMTP id u36-20020a056a0009a400b006e459b3928cmr10988213pfg.10.1708536896686;
        Wed, 21 Feb 2024 09:34:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d5-20020aa78685000000b006e2301e702fsm8845982pfo.125.2024.02.21.09.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 09:34:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8ec638c2-93b6-48e4-8ac4-965072b1d5af@roeck-us.net>
Date: Wed, 21 Feb 2024 09:34:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: kempld-core: don't replace resources provided by
 ACPI
Content-Language: en-US
To: Michael Brunner <michael.brunner@kontron.com>,
 "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc: "mibru@gmx.de" <mibru@gmx.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 09:10, Michael Brunner wrote:
> The current implementation to retrieve ACPI resources is faulty
> and may cause issues that even can lead to non-booting systems.
> 
> When adding data from an ACPI device, the resources are already
> assigned to the platform device. Therefore there is no need to
> retrieve the resource list from ACPI and manually assign it to
> the platform device. Also there shouldn't be any BIOS in the wild
> anymore, that does not have resources added to the KEMPLD ACPI
> data.
> 
> In particular this fixes an issue where the retrieval of the
> resource list using /proc/ioports is disturbed and does not list
> the assigned resource for the kempld device or even no resources
> at all.
> On some distributions this also leads to problems during system
> initialization (e.g. with udev) and causes the system to not
> boot at all.
> 
> I have reproduced the issue with the following kernel versions:
>      5.10.209
>      5.15.148
>      6.1.25
>      6.6.17
>      6.7.5
>      6.8-rc5
> 
> The patch applies to all of those versions and seems to resolve
> the issue.
> 
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/mfd/kempld-core.c | 37 -------------------------------------
>   1 file changed, 37 deletions(-)
> 
> diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> index 67af36a38913..5557f023a173 100644
> --- a/drivers/mfd/kempld-core.c
> +++ b/drivers/mfd/kempld-core.c
> @@ -428,50 +428,13 @@ static int kempld_detect_device(struct kempld_device_data *pld)
>   #ifdef CONFIG_ACPI
>   static int kempld_get_acpi_data(struct platform_device *pdev)
>   {
> -	struct list_head resource_list;
> -	struct resource *resources;
> -	struct resource_entry *rentry;
>   	struct device *dev = &pdev->dev;
> -	struct acpi_device *acpi_dev = ACPI_COMPANION(dev);
>   	const struct kempld_platform_data *pdata;
>   	int ret;
> -	int count;
>   
>   	pdata = acpi_device_get_match_data(dev);
>   	ret = platform_device_add_data(pdev, pdata,
>   				       sizeof(struct kempld_platform_data));
> -	if (ret)
> -		return ret;
> -
> -	INIT_LIST_HEAD(&resource_list);
> -	ret = acpi_dev_get_resources(acpi_dev, &resource_list, NULL, NULL);
> -	if (ret < 0)
> -		goto out;
> -
> -	count = ret;
> -
> -	if (count == 0) {
> -		ret = platform_device_add_resources(pdev, pdata->ioresource, 1);
> -		goto out;
> -	}
> -
> -	resources = devm_kcalloc(&acpi_dev->dev, count, sizeof(*resources),
> -				 GFP_KERNEL);
> -	if (!resources) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	count = 0;
> -	list_for_each_entry(rentry, &resource_list, node) {
> -		memcpy(&resources[count], rentry->res,
> -		       sizeof(*resources));
> -		count++;
> -	}
> -	ret = platform_device_add_resources(pdev, resources, count);
> -
> -out:
> -	acpi_dev_free_resource_list(&resource_list);
>   
>   	return ret;
>   }


