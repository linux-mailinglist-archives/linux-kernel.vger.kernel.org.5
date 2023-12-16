Return-Path: <linux-kernel+bounces-2394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4057815C88
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC101F22686
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C9374D8;
	Sat, 16 Dec 2023 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjHO6wf4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01037169
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso22885555e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 15:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702768340; x=1703373140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWQ768EYZOxvcALHGE3+QsDGQTu32k76xRbkD7I2xc4=;
        b=jjHO6wf45EiqhrL9fDB8sXISjk3hXrrLr38jKT19nps8J+d3rK0gECwy6mffkw/BXN
         qjCForlQgnBOVBlqqTldKVkuQdq18e+mlkW5lZ6Ae8BPt9P8IGySV/as354TBcwk0HeK
         pdUrvL+he3AW9BiDUDTHxAW/u0Y7pjpaTmfQS/572/vq0dgUzhOZlh3Uuj/X1c0O5bi0
         HMX0isxMvrCvlGlXnF+lUK5iNyPgbilS3XEDyzN5yqUjW4KVBDvhyOEJogCeJ2oel9LL
         6UoqF16b35+FMYYE+FiFjWOBBPnIbN0J5NDO+AHzCvSsTqwYPWdl7cB2raPM7SqWowTl
         s9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702768340; x=1703373140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWQ768EYZOxvcALHGE3+QsDGQTu32k76xRbkD7I2xc4=;
        b=OFSfvESP/G8mBJVhiw0CMRBirXAznsEQuQXfas4mj+NfcmLpE6ncjQ3epDpm25tFnj
         V9Dv5UFo3ZoLhIeMRyMHDewH5vGQvpjXXfLgPcWwkyPybWmD4S+wrp2B+pfaotlvrNxi
         gwP5KaEVDRJq2SftaSylCHoyEqIcGS2hjg7il9XFxuX3MiHkSC2k8BAEzyArYgGlR+E3
         KGzEiPQ0mKjfz9OCYXU193P0vIjkD/Zw016pF9Ajqe/fSMpnNbGhz+Q01JXQCvM8dKBs
         5Q5OpZ8nnFUxG/589RVOblNiFM4jBg4BuLmaC603Lcbv47OQBtLvtO50XeWLE0GAHFIT
         WUyA==
X-Gm-Message-State: AOJu0Yxo3K1FQgkbv7XwNoEY/x/LsPCkBCzvxZSWTepDZ7UuLB/AcuDn
	6jPGQUCGs/DOUKpBoqhuxu0=
X-Google-Smtp-Source: AGHT+IFVUtVZMBPe1oVF3X+wn0VSZMz3Sgb/ENpi8qjCOD/ESvPSho/wESSfjDeZ8AMBXe/mFBQiXA==
X-Received: by 2002:a7b:c8d4:0:b0:40c:48fb:ea00 with SMTP id f20-20020a7bc8d4000000b0040c48fbea00mr5392408wml.194.1702768339592;
        Sat, 16 Dec 2023 15:12:19 -0800 (PST)
Received: from ?IPV6:2a02:1810:a404:e700:259e:a1b4:62cb:af3d? (ptr-4x653mgnc6rxc3brvi5.18120a2.ip6.access.telenet.be. [2a02:1810:a404:e700:259e:a1b4:62cb:af3d])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm37599258wmb.27.2023.12.16.15.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 15:12:18 -0800 (PST)
Message-ID: <78ec36c9-5e87-4c83-bdbf-5680f6eaff4c@gmail.com>
Date: Sun, 17 Dec 2023 00:12:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: print 'struct resource *' correctly
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, tzimmermann@suse.de
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20231015131100.331880-1-yussef.dalton@gmail.com>
 <35984b5f-d4f5-4d45-9e17-b41140ff78e0@infradead.org>
From: Yussef Dalton <yussef.dalton@gmail.com>
In-Reply-To: <35984b5f-d4f5-4d45-9e17-b41140ff78e0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/23 17:35, Randy Dunlap wrote:
> 
> 
> On 10/15/23 06:11, Yussef Dalton wrote:
>> Since format specifier %pr refers to a 'struct resource *', there is no
>> need to take the address of the 'res' variable since it is already of
>> type 'struct resource *'.
>>
>> Signed-off-by: Yussef Dalton <yussef.dalton@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
>> ---
>>   drivers/gpu/drm/tiny/ofdrm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
>> index 2d999a0facde..6372ab383747 100644
>> --- a/drivers/gpu/drm/tiny/ofdrm.c
>> +++ b/drivers/gpu/drm/tiny/ofdrm.c
>> @@ -1208,13 +1208,13 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
>>   
>>   	ret = devm_aperture_acquire_from_firmware(dev, fb_pgbase, fb_pgsize);
>>   	if (ret) {
>> -		drm_err(dev, "could not acquire memory range %pr: error %d\n", &res, ret);
>> +		drm_err(dev, "could not acquire memory range %pr: error %d\n", res, ret);
>>   		return ERR_PTR(ret);
>>   	}
>>   
>>   	mem = devm_request_mem_region(&pdev->dev, fb_pgbase, fb_pgsize, drv->name);
>>   	if (!mem) {
>> -		drm_warn(dev, "could not acquire memory region %pr\n", &res);
>> +		drm_warn(dev, "could not acquire memory region %pr\n", res);
>>   		return ERR_PTR(-ENOMEM);
>>   	}
>>   
> 

Hi,

Sorry for the bump, but is there any news on my patch?

Regards,

Yussef

