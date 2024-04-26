Return-Path: <linux-kernel+bounces-160061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE768B388F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B0D288464
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04594147C70;
	Fri, 26 Apr 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOrjKOfU"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFF145343;
	Fri, 26 Apr 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138589; cv=none; b=sa7mWiBqXkLYCT4S1tbwZzFU8XfugcKCfDJfnUnfMNY4LWbvE02XE+C1avpeTgwHg7Q24MldkinZ3afysqP9w7eTeE8WIuQ3QVnEz/AkGjg2ZzVIDirTBqjmXYSIwR4/WNJe58wvKkyfPolRuaPkX6AsaQPf9ipe4IZE14my1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138589; c=relaxed/simple;
	bh=LM9VwrU66EmUoyoapr/EkV6USSuQIFOkkUsLl4/DLvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAmtg+v8NPtB4CtWwzqFtiFRWaew4rkNKfWrO3H7aMdxwe1Q5wBrWXRQVTpyLShG+l3+4IlyuqostPIR86+x5aoj6L4YLE+CTjTu8Awsjm47CP49aipxzMPDh/lKyll6PpEcQgEF9tP64k2h199YP6tqDsG21IZcWXFDQISToWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOrjKOfU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed5109d924so1930943b3a.0;
        Fri, 26 Apr 2024 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714138586; x=1714743386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=X4QMDNlauyd66ufLUeH7YRbbHnbJwVK53B+XBL6CSCM=;
        b=dOrjKOfU5La+bDTUuJpV4jMNRyHv6rJEjjeyg6uRCxBWYKussWbyZvBit8IbqW5Wj1
         lqWxIRjxpbAf/NXsJ2H6IcfjxWL2/vp1PzGMlO0cbYbTKlHFAR6XL1FaRNRGl3V0o4U9
         B1lDhSK2q2IGV4fXCQGH7/NrWHBdiVwKhabObwVbrCnGLyld7iQB2HxwDnF1D2Wg2ofb
         vMSd3ln3knWcemqhy17QbG+P60YeQYggNoXhAXsjs6pQgeNJfoRPQ/CpTWUWvZiS3YjP
         PqmoKrimwm2y5mS27GgexUGuOjlR5vq8wClk9YOEJT4osBbzFCiIlycqKlPawh8XE4gF
         3T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138586; x=1714743386;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4QMDNlauyd66ufLUeH7YRbbHnbJwVK53B+XBL6CSCM=;
        b=FmJz+qViu1aKQ7DtMW5/gXPSMEVaXfM/7ZDYfPta4Opt0x8/0uzcRlr/M0X6C+H/j+
         xQn7ut6Bnd3tGUrsdjPq2BuKTwWTTjOrcrV3IWx5dcoWAx+vlODL1q2t2xQvnkRiw7O6
         OXRnBV9i6H8FN2649idElsHAuRD6qK6IyOEdM6ubzZ4VDDlme0nDaCJedCfe1gK/NCOW
         V3MmcUl//x3jAP8QkRWqSr/j53HsfZFxF94Z1T/49W4eaOJahKDncwY0b2ZgH5VRT7wz
         hP4Z0BslOYyIyp9aod2Sr3xR4mEvdwfl5Q85q37YeAPTCzrXMq5gChpJ0Pk149dM7dHZ
         YyMw==
X-Forwarded-Encrypted: i=1; AJvYcCV845tFryP1Qd+Kz2E48AHlwxX2ih8z+kxNBuny1WdGlJlH7Ld8ReBF6MCIDUJjtOt67eWho/azfxsR+ssEV1wC0i+Us2+t4AYMZ/6D
X-Gm-Message-State: AOJu0Ywdc+aso+v6YUnzJYCFVaBF7lEdnPKu6+lB15CrLcu8nwKVF3so
	LUnLbtxND6PiEkODHnMlbH3gG+Yka6Ar9rFQwm6bmCyLyIysEn4/
X-Google-Smtp-Source: AGHT+IFas4zbnLq0aNKljn/3tAbkxbRxVpYNq+o2NckU8TwCCUZbiN1Be7qXF2wG/N6j1D8dO1X5MQ==
X-Received: by 2002:a05:6a20:5504:b0:1a7:aba5:7ce9 with SMTP id ko4-20020a056a20550400b001a7aba57ce9mr2465969pzb.34.1714138586474;
        Fri, 26 Apr 2024 06:36:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x1-20020a63b201000000b005e838b99c96sm14550674pge.80.2024.04.26.06.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 06:36:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41e47453-a014-4450-bc5b-3ef76f09b786@roeck-us.net>
Date: Fri, 26 Apr 2024 06:36:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: sa1100: Fix PTR_ERR_OR_ZERO() vs NULL check in
 sa1100dog_probe()
To: Chen Ni <nichen@iscas.ac.cn>, wim@linux-watchdog.org, arnd@arndb.de
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240426075808.1582678-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240426075808.1582678-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 00:58, Chen Ni wrote:
> devm_ioremap() doesn't return error pointers, it returns NULL on error.
> Update the check accordingly.
> 
> Fixes: e86bd43bcfc5 ("watchdog: sa1100: use platform device registration")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sa1100_wdt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
> index 5d2df008b92a..34a917221e31 100644
> --- a/drivers/watchdog/sa1100_wdt.c
> +++ b/drivers/watchdog/sa1100_wdt.c
> @@ -191,9 +191,8 @@ static int sa1100dog_probe(struct platform_device *pdev)
>   	if (!res)
>   		return -ENXIO;
>   	reg_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> -	ret = PTR_ERR_OR_ZERO(reg_base);
> -	if (ret)
> -		return ret;
> +	if (!reg_base)
> +		return -ENOMEM;
>   
>   	clk = clk_get(NULL, "OSTIMER0");
>   	if (IS_ERR(clk)) {


