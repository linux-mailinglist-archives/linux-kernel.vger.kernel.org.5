Return-Path: <linux-kernel+bounces-60835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699F850A06
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5340B281CFD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A15B695;
	Sun, 11 Feb 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1tbI18o"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48955C5F5;
	Sun, 11 Feb 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665815; cv=none; b=rJr4CFoOwTI+zF9He5UNSetTb/fK0LVxwMPDcTaUQO7HX924eHx1i9pCemgz8WsD1REIsP/aJscBewkME3/zU9vDfPuTaXGs6yGunVxuXObbPuZ+59bAKPu1cpBmTZqG3tn0jxxtJg70+LvNJIu96ejOOuQgc7m3QjG5cIct658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665815; c=relaxed/simple;
	bh=hHM8da2r//H7RQTmBqA7GjmCKedcHj4nhSu5kXs5QZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfPelJZUoABRwi532XXmBuphj+Zo+2xaMOSg6LG7Ovkbh9Yfqe1mZPiGRWZn7YiwmKXe5TZRSQfh20+4xgePwRlmcssSOpCgOTCdO/r5NebJosqe0X84ErCa4Jik/hxBgargM6L0iRHeQr2Eg7R1ECxPw+KxL9f9xSDL4epjUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1tbI18o; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-561b9b4040eso10668a12.2;
        Sun, 11 Feb 2024 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707665812; x=1708270612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKfqE5jOxp7VG9h1nJrsIT7KK1jLjaUUAxX3Hpv+Pfo=;
        b=L1tbI18oenpU2KJhGb6TTQNEqv/2Hzlrk8Vl59xkZjF2tkf6Q5paZAS6uQX+D0Md4G
         Xcyt4WueA+o+rSG1hDxjNdv9t/rFS3oOBMnESI+RgkmDSKfo2Jsm7wGwaqyb8I34Lajk
         nIDE9xMjgdA+lwHlRLbxhMLVnsco6eUlPkaorNpb/S+oi9dznufUznxXfSFVDROfvYMq
         uJwHFSprbI2NvA+I6RKqjzjf/nyQyZ8NcNZ4NCa1JWdU3GuC0LWn0pOm42aI3dsMeXmO
         iK+9f7Lbd6KrKCtFpQng8tpkaVYR/W8n8ZT1IJRL5qx0GfcAtIF55hNSCUy+moOIkWss
         bATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707665812; x=1708270612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKfqE5jOxp7VG9h1nJrsIT7KK1jLjaUUAxX3Hpv+Pfo=;
        b=EQlgnrRlj2SP7HMlAzt+EPgyz99ieTyueUvxCMnyUi3yl4NEad356r1T1qj/DrmFyG
         CB5HbH8yWkzocFS38H/OWxYT5gSc6l9QJVBfLo+bc9EVnfuv4+NrPNuQttqSUXGZoPir
         mKZbeldRcyGCCARYlcxT+tRi/HrvvdWhwQCih1SHXvj9KHO/oF+FDj/+scbq69zqON36
         DTTOGA9rJT2NOTjFbY68uzNL/636G5rzRka5uo5J6y2274WWQMLOV1AFPwcCB1xfBCF2
         WCHoBZDx6lAu99nw0cXaKEvfAWLYzrXF0oO6/WSLZ9kth1KCJkiIKeYX3LJd8tfuGOKN
         wifg==
X-Gm-Message-State: AOJu0YxAlWjqmg/pg1QoiOFLcUrsDN9Y/Vrp8fOu6/ANWlH3U7G8zqX0
	Mn2JJ6LJCkCIi2u+UDJRzgSnTuwwsYWzHDwvOHS2yP4HI4TEC20bJ4L5mAbmRE8riA==
X-Google-Smtp-Source: AGHT+IEKKAqE/uIqXhUY680VYhVQgRkRynVpR9S0OWj1sTu9vTyyBGDvmh2hKSTVh+oP4o8nP3CWLA==
X-Received: by 2002:a17:906:6899:b0:a39:34bc:493b with SMTP id n25-20020a170906689900b00a3934bc493bmr2765331ejr.45.1707665811910;
        Sun, 11 Feb 2024 07:36:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUug0fjklHRmfxKQatdFx9eLyVysdPLE5z01Gee5NkYzQehh3gNtAPO/gEP28++ZZrjbeeS2/UParvSqG7XbiYnS//v2cfxkPnaxZu+KKmgem24Bq9OLDfThI3z0fF8uzg8PTQJIup10rONMsfakweJw7in5ijUT/P1oXHO9Y0NSBDgORY3c7VPTjZzfr6yhiP/ACpZAHajj01akSkdSEHsftrx04v2Bxy6rMktQ4Jx8Z3CRZuy894ha1twNJMa
Received: from [192.168.3.110] (m90-131-46-29.cust.tele2.lt. [90.131.46.29])
        by smtp.gmail.com with ESMTPSA id j16-20020a170906831000b00a3bacd6d882sm2973136ejx.203.2024.02.11.07.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 07:36:51 -0800 (PST)
Message-ID: <0ddfb0ab-10e0-471c-97e1-63018884e4f7@gmail.com>
Date: Sun, 11 Feb 2024 17:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: mcp320x: Simplify device removal logic
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan.Cameron@huawei.com, oskar.andero@gmail.com, lars@metafoo.de,
 lukas@wunner.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 arturas.moskvinas@gmail.com
References: <20240208094339.82633-1-arturas.moskvinas@gmail.com>
 <20240210155857.59c58dcc@jic23-huawei>
Content-Language: en-US
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
In-Reply-To: <20240210155857.59c58dcc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/10/24 17:58, Jonathan Cameron wrote:
>> Use devm_* APIs to enable regulator and to register in IIO infrastructure.
>>
>> Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>
> 
> Don't get the same regulator twice so as automate turning it off.
> The devm_regulator_get_enable() call is carefully hiding the
> regulator for cases where the driver never accesses it.
> 
> Here we need it to read the voltage.
> 
> To convert such a case to fully devm managed, use a
> devm_add_action_or_reset() and a custom callback.
This is exactly the reason I wanted to use devm_regulator_get_enable() 
instead of devm_add_action_or_reset + custom callback which I saw in 
other ADCs code. It seems quite repetitive. Wondering if this could be 
addressed by regulator subsystem to provide device managed method which 
gets _enabled_ regulator resource and an automated disabling + resource 
freeing? We will loose fine grained information where failure happened 
exactly - getting resource or enabling regulator though...

>>   static void mcp320x_remove(struct spi_device *spi)
>>   {
>> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> -	struct mcp320x *adc = iio_priv(indio_dev);
>> -
>> -	iio_device_unregister(indio_dev);
>> -	regulator_disable(adc->reg);
>>   }
> Had the change otherwise been ok...
> 
> You should be able to remove this function completely now it is empty.
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L446
> checks it's existence before calling it.
Ack, will address with V2 patch.

Arturas Moskvinas

