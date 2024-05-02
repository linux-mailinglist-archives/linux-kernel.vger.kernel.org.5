Return-Path: <linux-kernel+bounces-166128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544558B969A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FE21F210E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82146525;
	Thu,  2 May 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDjswDWi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641F4206E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639250; cv=none; b=c7JuN9P+GjRIWRh2td6NHBfkDN09tD/VGXymjQVE8u2yIHFg7Si1Y0U1W72Aw+QQf5NaIemUz2iGvDPPh3pYbTm3fTaZuTz+hgkgnP1Wu/mhURqkCEqOZeIYU8EUHVLa49TlUW1zv6xJRyUqfeCvECN9r1zquQvo2taNFoC/2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639250; c=relaxed/simple;
	bh=VMLirMjE7AcT2Pt9YizN+gPPnTlDr2S+LO8VpGBJIyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwumSp7/lGEZryXLKVZ7rWuIjZafSF/+oDAjH2wREXsyf9ngUdJpYIzITsKwy9MWy6WVd00vQE3y087AEn8gkx9TIQ4MNll0dCKAkbDj6W6Qo2MU0OFOhWr/6EPFeS7E8Me7FUPiHN+8uutZwMTpRO6c4/LlXwTChnttoUmd4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDjswDWi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so58661275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639247; x=1715244047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bq3P2Ir5EDp6mbAqX1BN2BAvxEatV8uFmb1a71hk3Cs=;
        b=HDjswDWiVXR52vQGbP+jW+oRZzgBg8YOMNkYd/CBZipkHpdhMWM3WJRG8niOt5yxuk
         3whTOa33i4/I4yBZop+RhohhgR1cKN94V9igECAqsmfx34Pru2Zbl03ebRuXGPsYITIp
         aB8eYRJbxmdKE4w3Pakqwanj1+65j4OnmmYZhNCRV42tjyjiZ1KZ+H8WE1ojZqjIcbq2
         CcEpLRkUQbK6bQZKjs/w+F5+Ix0bjubOuB3LlOLDCmE0pGg1ZR4MMc1uTG4Uk9BBgJcb
         LbmqbA/tZrkZi7ecbwqvgxlVptUboDzMQ5xy+RF3dLDe9P+VuIVJ2OS9J16F4r2suc/9
         1VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639247; x=1715244047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bq3P2Ir5EDp6mbAqX1BN2BAvxEatV8uFmb1a71hk3Cs=;
        b=eIXeOBEqBqOB91xfYGShUcbSjP7IkMkducXjd5j7GV08u0aEeahMiu+/cJTsT/KYoD
         lXYS9SNW2Z8bBDCJUsfGDaTzK4xzyr8uaClzPfVydjjR9nYWLLp90Hj3U6mXIliG5NqJ
         WVsttPL9AW0SYDVZhBXeLj3HkHgivRfXVQ4mGwIZaGuSMOwbRd6Ps8mo6OYCbCmDD3Vq
         UjGXBQn3zv6rgfY/x+xtuFRmkE7PNrAauybhdfeM6YBDeyG+Z446gjl+8f95z3pVnXLq
         16tQHvLM3EYP2vw86SUhdqmx0wol+F3vvWM2tNU90wEBu8vF0eZiZPJnc1qWQWu3yFbR
         Rnfw==
X-Forwarded-Encrypted: i=1; AJvYcCULMr8PSYLDkh+3/f8UhPoI2R2zEugyUFIALRX+Af7MrGg6QrJvPI/0IAkslPQDj4qYV4QNi1hHHKXpx7jYcrMpHdROesaMO6hwCLFL
X-Gm-Message-State: AOJu0Yxl1idMCdwjy3/IGWzh2+qNAKzqGU0XT9CbFItDJHxZ/5JwUew4
	y5KfvRIpJ5sMimvxoTciu5u5ZHBn7csJWyTGJOZcGKgDmOoJ/Cpc
X-Google-Smtp-Source: AGHT+IHJnxzIwf+DgF1c1kiPElsKttyZJqap1UUMMrgC3gCd5mjUoBOTDzblLV9e7t6XE/b8mYxtfA==
X-Received: by 2002:a05:600c:4e11:b0:41c:8754:8793 with SMTP id b17-20020a05600c4e1100b0041c87548793mr4849943wmq.41.1714639246648;
        Thu, 02 May 2024 01:40:46 -0700 (PDT)
Received: from ?IPV6:2a06:c701:737b:ef00:c50a:d96c:6c34:ec52? ([2a06:c701:737b:ef00:c50a:d96c:6c34:ec52])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b00418f99170f2sm1160001wmg.32.2024.05.02.01.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 01:40:46 -0700 (PDT)
Message-ID: <fede8589-dd11-4b0c-aa70-7ec23aed64b1@gmail.com>
Date: Thu, 2 May 2024 11:40:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] staging: pi433: Use class_create instead of
 class_register.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: hverkuil-cisco@xs4all.nl, andriy.shevchenko@linux.intel.com,
 robh@kernel.org, felixkimbu1@gmail.com, dan.carpenter@linaro.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-2-ikobh7@gmail.com>
 <2024050109-reward-vision-58e9@gregkh>
Content-Language: en-US
From: Shahar Avidar <ikobh7@gmail.com>
In-Reply-To: <2024050109-reward-vision-58e9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2024 17:12, Greg KH wrote:
> On Wed, May 01, 2024 at 08:58:19AM +0300, Shahar Avidar wrote:
>> Make use of a higher level API.
> 
> What does this mean?
> 
By "higher level" I meant a wrapper function that includes the 
"class_register" call.

>> Reduce global memory allocation from struct class to pointer size.
> 
> No, you increased memory allocation here, why do you think you reduced
> it?
> 
Reducing *global* memory allocation.
I understand the tradeoff would be allocating in run time the class 
struct anyway, but than, it could also be freed.

Since the Pi433 is a RasPi expansion board and can be attached\removed 
in an asynchronous matter by the user, and only one can be attached at a 
time, I thought it is best not to statically allocate memory which won't 
be freed even if the hat is removed.

By using the class_create & class_destroy I thought of reducing memory 
allocated by the RasPi if the pi433 is removed.

But following your response I now actually see that the class struct 
will have the same lifespan anyway if allocated statically or 
dynamically if its alive between the init\exit calls.

> Also, this looks like a revert of commit f267da65bb6b ("staging: pi433:
> make pi433_class constant"), accepted a few months ago, why not just
> call it out as an explicit revert if that's what you want to do?
> 
I actually saw this commit, but for some reason did not connect the dots 
when I wrote this patch. My bad.

> class_create is going away "soon", why add this back when people are
> working so hard to remove its usage?  What tutorial did you read that
> made you want to make this change?
> 
It's true, I got it the wrong way I guess. I thought class_create is the 
preferred API (but now that you mentioned commit f267da65bb6b, I see 
it's not). I did notice it in many other drivers though, and took them 
as an example (e.g. gnss).


> thanks,
> 
> greg k-h

I actually initially thought that the pi433 class should be removed 
since it doesn't bring any new attributes with it, and that 
spi_slave_class is more appropriate, but then I saw no other driver 
using it. Any thoughts about that?
-- 
Regards,

Shahar


