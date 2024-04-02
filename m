Return-Path: <linux-kernel+bounces-127849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E779D8951AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168521C22D77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DB962147;
	Tue,  2 Apr 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ+V23QT"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988E604BB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056764; cv=none; b=JHoI7YvEA/TU3fp6K5N7bXvgIhWgXdRYNSJrklRFuXKXuLlyVKu4BPdNwl+VsKsFRNUDlH8MLJryNnvF523mpY+RBPL4R3DOh53zFjNY7x6yER4ivrEnrGy7a7EG0mZalWMk4//y1VJ5+ev+eepDLRU6DvNZChxKq39p4pKAYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056764; c=relaxed/simple;
	bh=rQFgi4M3cexqDiX/+IGY5Z+RJksbQHqthZoyORy+Juo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svegN1BUILlFnj6k6dmgX2OucBL/9VgFOnNxD4HGysGh8xlmh39okSQGARhCXujsZ4f+m+he5RvgP6yt6+L6YEG+UklXXnBo50zL9QQ0b3tZKYy4uAYo1hr/ustMt3OVjyX6KOiAnCYEEk68pPUd5g2bzyn2KyGiT+U5X3dfhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ+V23QT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-415db53d905so4846585e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712056761; x=1712661561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcdJ2aIprvBghotSA/VhJHR8Q1l5wGnaxpQFSHTwQ/s=;
        b=WQ+V23QT9EoVZC6O6ShzYq8ViV/KjKCeLicG8bROGgjR0lVFWFtK3Kp/v7IclRpa5z
         ISBemVAAZiHKrM/9IfTDpYpxAeJ5gRyKBOzurWmB4omoQK5mUExMEX/aMsPxUQmD27K+
         YTJ9O9zR9no7CUe+slv1YKAkl1sr8AvG75CRd+qgSndHVC9ZmpMxxt3gdSCXusnVI/7A
         myi91UkfkEgnma3DUSo22PC6kuD5NH2cLNE0P+ud6CbIPUxLBUq7ZzbVhGc0LQf4hCIg
         uod6IuVOFvjHUmz4R/B/OdXe7pwJGPEzgxWmR677/YthZvZV1CmGNscj7RZSikRK3gop
         ThSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056761; x=1712661561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcdJ2aIprvBghotSA/VhJHR8Q1l5wGnaxpQFSHTwQ/s=;
        b=jBVoi3I87lomgZ8vORnZjACOh8MmL1FFgi4VolULQF4ZxOuIHsMXlieSkH1Q76QnEs
         5f7ndNqS+7fHw8xqNwhQmYZP++WpZIksV3vEgaY6LtvIvKqDyLSA26/R00ySjRX60VEj
         yhez59Sx2aeOYXUQ0FuLP8MK0AZHf7BeEijRxuIarpgp2pJ8PtMWvG5Pk/7UctfafLWW
         W6JDqFE+1cznmj6vSpmtW2xLAmfznpcaOUntrObDjNNwoM+rftjbZP8SD6s5NTSEr7zM
         tcG+ChMlumN1TvPDOJv1ix8IJE7dHjt91Tia1UTtOvC2wVnrYeOHgq+ndOE8CvcjuZPz
         NYjw==
X-Forwarded-Encrypted: i=1; AJvYcCUS1keFWJ9C9MWpQkxI5+chydd04mRHNG6iCs3BCoKfwiblOWwKBkNrampm4kAgIQMEFtmKteD+BiLLwDhmcL8UoWijZvz0LoGFNrJl
X-Gm-Message-State: AOJu0Yw/7y9RtfYkHqdWTwK5VnxBPv73/I9Zkam74d8PGAXr/0FOrCjf
	A5QxJwe23vH4HXAraORr2aV019Ln4oV46nqVvaBatMxRkOJxMF3J
X-Google-Smtp-Source: AGHT+IGHt2nx7R5Gkn9VecupLkbMsdI+X4a4VkRjtUoxpqHUTjCSoXT5wPR3+GmOhpv3Fb+qRsNNFg==
X-Received: by 2002:a05:600c:4589:b0:414:809f:8ff8 with SMTP id r9-20020a05600c458900b00414809f8ff8mr9025704wmo.12.1712056761524;
        Tue, 02 Apr 2024 04:19:21 -0700 (PDT)
Received: from ?IPV6:2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf? ([2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf])
        by smtp.gmail.com with ESMTPSA id fm12-20020a05600c0c0c00b004156a55592fsm4760123wmb.6.2024.04.02.04.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 04:19:20 -0700 (PDT)
Message-ID: <8e363bc3-2643-4019-beb8-76284e6171cd@gmail.com>
Date: Tue, 2 Apr 2024 14:19:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] staging: pi433: Remove duplicated code using the
 "goto" error recovery scheme.
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
 andriy.shevchenko@linux.intel.com, robh@kernel.org, felixkimbu1@gmail.com,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240328121244.1244719-1-ikobh7@gmail.com>
 <20240328121244.1244719-7-ikobh7@gmail.com>
 <9c5b4159-da26-49d8-9682-445c01b19a51@moroto.mountain>
Content-Language: en-US
From: Shahar Avidar <ikobh7@gmail.com>
In-Reply-To: <9c5b4159-da26-49d8-9682-445c01b19a51@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan, I appreciate your review.

On 28/03/2024 16:03, Dan Carpenter wrote:
> On Thu, Mar 28, 2024 at 02:12:44PM +0200, Shahar Avidar wrote:
>> pi433_init had "unregister_chrdev" called twice.
>> Remove it using goto statements.
>>
>> Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
>> ---
>>   drivers/staging/pi433/pi433_if.c | 23 ++++++++++++-----------
>>   1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
>> index 62ce75b07bf0..e538f1d4e787 100644
>> --- a/drivers/staging/pi433/pi433_if.c
>> +++ b/drivers/staging/pi433/pi433_if.c
>> @@ -1400,24 +1400,25 @@ static int __init pi433_init(void)
>>   	 */
>>   	status = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
>>   	if (status < 0)
>> -		return status;
>> +		goto fail;
> 
> Just return directly.  Do nothing gotos are bad for readability and they
> create Forgot to Set the Error Code bugs.  Also there was a direct
> return earlier in the function so it's better to do things consistently.
Fixed in V2.

> 
>>   
>>   	status = class_register(&pi433_class);
>> -	if (status) {
>> -		unregister_chrdev(MAJOR(pi433_devt),
>> -				  pi433_spi_driver.driver.name);
>> -		return status;
>> -	}
>> +	if (status)
>> +		goto unreg_chrdev;
>>   
>>   	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
>>   
>>   	status = spi_register_driver(&pi433_spi_driver);
>> -	if (status < 0) {
>> -		class_unregister(&pi433_class);
>> -		unregister_chrdev(MAJOR(pi433_devt),
>> -				  pi433_spi_driver.driver.name);
>> -	}
>> +	if (status < 0)
>> +		goto unreg_class;
>>   
>> +	return 0;
>> +
>> +unreg_class:
>> +	class_unregister(&pi433_class);
> 
> There is a debugfs_remove() missing.  I have written a blog that might
> be helpful:
> 
> https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/
Interesting blog post.
I hope I followed through & made the right changes.
> 
> regards,
> dan carpenter
> 
>> +unreg_chrdev:
>> +	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
>> +fail:
>>   	return status;
>>   }
> 
-- 
Regards,

Shahar


