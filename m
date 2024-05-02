Return-Path: <linux-kernel+bounces-166130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE98B969D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EAC2831EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886246450;
	Thu,  2 May 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCMTpp9r"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EED51C45
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639461; cv=none; b=dkVYbo0JcfzHyZ505yS56TE7vTG7XQmrDETXaQrBkRsiSaf6tERWJbL08NMPzrUen0Lohz1IUjijEqdSodrSGYdgFSCa9J7Wjx2GPvIW/5q4ak9/mqEz73690ZhDXcl0R86663SUF9+Vd/uqTMvxCmeMuAripOLYpoeClLx2zJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639461; c=relaxed/simple;
	bh=kgt/1SMeEZnm5Ptv8rEZ64sSPgtiVX0biVlUi6l52F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUf+iQkO9cTh2xaR5Blmb9umFpDdpTpoHp9fmFaA/Wz40puzoN8ibCO3h+JcSAL1+YfgUNYXznKCOeoqk6lx/td7+LUwtwl6sqElh3CqTz4Ch3b0ILwkKdXFmXq5fOPx0PvhnjhkOup0DjCVjxVep/GmqKebfWZ/xpP4T6Q/vXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCMTpp9r; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518931f8d23so7704420e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639457; x=1715244257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcUAASY20ow1VFW4//wEVrnYF6VyjHuuXQ8tiu7WF10=;
        b=BCMTpp9rocuAM/HAt7tiGo9WECmoMR4A4YyIzhtu58pM4MMCVGqs7envSDIE1Y3Bzr
         fZNwfGu2TX8nG4+CSjx2YeUhYtahVFMWS0xc33E9Dw7M84AnKYOL5OMx79tkqjzRRQFa
         AyqX7nL3bi4NhV/tIb86pBLMpqm/kh+rpIgHm1CoK4I5W4KSHPhv7zRTVvq/cfhiKCkt
         PgPC/qNlR7UTx3J4m68+twHB+2739vqa1YwCUROj5/ZFEzgEaHUNIQLwC7paXwPS5yAg
         IqPM/OoltjB80UHQ9O6XLcqzUxp39Vz2xLx7NPa7CTjq3YcwhGTVctA1SUC55yzV+nyX
         k39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639457; x=1715244257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcUAASY20ow1VFW4//wEVrnYF6VyjHuuXQ8tiu7WF10=;
        b=nJ8sKJAe/1UEgZ030H23PtiDRDHT3XXeZ4pLhY+fAYfNa8b4KPQpcDVYpDN70VCvxL
         s6Eqj7jZKdulRbPaBsP4HTB8J3+w+4XNK8OSBZqtSJEj1gNbGQbr+F/MXzdbgZs/KPk+
         3R03HGZcM0bbn9DJRByFjawP9wcFNUVk0sZLZAN+8USk554kAAnoEq6su1HJNElEXc6o
         n+mjvYmu8YyzlFagj23Mvh8NcCbpSP2940CXJy0aHJYoRX/0KjO5Efb+ZzQyS743vzdj
         qk1kP1cB3klglwB3BGHlOOQLt4ocEJQMZQhTPlFzAOvFVILGW+SSuL12d7gF5jZ+U+sn
         N1GA==
X-Forwarded-Encrypted: i=1; AJvYcCW5osJz43cOdeP7jUsxCHY80pw7QQVGHD1WZcKauu0vBtU3Tq/fDOXri9g1/IzF6rfJEKXF1jxuWGZ16lesJpTAgxH8yERU82AItIN7
X-Gm-Message-State: AOJu0YzF7W/hVbctD5XQgGiGLEyJJJ2kTEYmK8l3GdVfjZ4OScA/IMh7
	YYeZRyjsDuOZnkqX/WJn4SNODovTWC/MgPmtDRpT8bP1A2glexEh
X-Google-Smtp-Source: AGHT+IGVAwRs80djLEUTTlp/zFwopzo7i0fXr93wtXW+S5botvqJTpOB/D17ajYNyCvcpnMsh7p1UA==
X-Received: by 2002:a19:2d06:0:b0:51f:4a03:a053 with SMTP id k6-20020a192d06000000b0051f4a03a053mr257773lfj.4.1714639457317;
        Thu, 02 May 2024 01:44:17 -0700 (PDT)
Received: from ?IPV6:2a06:c701:737b:ef00:c50a:d96c:6c34:ec52? ([2a06:c701:737b:ef00:c50a:d96c:6c34:ec52])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b0041bfa349cadsm4902544wmq.16.2024.05.02.01.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 01:44:16 -0700 (PDT)
Message-ID: <b0cd37c3-5465-467d-8074-67fa2fddcc4d@gmail.com>
Date: Thu, 2 May 2024 11:44:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] staging: pi433: Rename goto label.
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
 andriy.shevchenko@linux.intel.com, robh@kernel.org, felixkimbu1@gmail.com,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-3-ikobh7@gmail.com>
 <3005db51-58f7-4247-a37b-02933767f644@moroto.mountain>
Content-Language: en-US
From: Shahar Avidar <ikobh7@gmail.com>
In-Reply-To: <3005db51-58f7-4247-a37b-02933767f644@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2024 17:06, Dan Carpenter wrote:
> On Wed, May 01, 2024 at 08:58:20AM +0300, Shahar Avidar wrote:
>> Use destroy_class_and_remove_dbfs instead of unreg_class_and_remove_dbfs.
>>
>> Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
>> ---
>>   drivers/staging/pi433/pi433_if.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
>> index c8c1d296184b..4fffd7007040 100644
>> --- a/drivers/staging/pi433/pi433_if.c
>> +++ b/drivers/staging/pi433/pi433_if.c
>> @@ -1409,11 +1409,11 @@ static int __init pi433_init(void)
>>   
>>   	status = spi_register_driver(&pi433_spi_driver);
>>   	if (status < 0)
>> -		goto unreg_class_and_remove_dbfs;
>> +		goto destroy_class_and_remove_dbfs;
>>   
>>   	return 0;
>>   
>> -unreg_class_and_remove_dbfs:
>> +destroy_class_and_remove_dbfs:
>>   	debugfs_remove(root_dir);
>>   	class_destroy(pi433_class);
> 
> This is cleaning up something which changed in patch 1 so it should have
> been done in patch 1.
> 
Thanks for your input.
I thought of a previous comment you had were you noted Greg preferred 
small patches, so I did my best to keep the first patch the with minimum 
changes without breaking git digest.

This patchset won't be accepted anyway.

> regards,
> dan carpenter
> 
>>   unreg_chrdev:
>> -- 
>> 2.34.1
-- 
Regards,

Shahar


