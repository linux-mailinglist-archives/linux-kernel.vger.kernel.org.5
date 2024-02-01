Return-Path: <linux-kernel+bounces-47444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6514F844DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816E21C2603B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A921848;
	Thu,  1 Feb 2024 00:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6Rnb49t"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3802107;
	Thu,  1 Feb 2024 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748073; cv=none; b=SVq+GXVT/3zzPibAoX9lBbl20qmy22ZKnHEtvFmdF1em3QczxwUWhRKPsmqhdoRQV52KYbaEEYGUbbBAVqqbqN108mMizVnShfWK4sI3sVh4inkt2lCN7I/7bXbj501i3DzV0xfkVPKIEKs+oUBMVV3q3+TBw60JGwGiTSNU6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748073; c=relaxed/simple;
	bh=uUmJSq6btKnv5W49olTzUlxdEegZOvbNbgtUSFSVkIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MC1UucEl6iTZki5elsEXmEQSkO5ob1R8cERX+sRYOMi5+gEJFdwD+uVCuJL7f52v5zZeS8hhGKZxJjtMOX9naxmCl/uFNHe4oCeTDwfD4tpnw9a/RaTicxcUYL01DkuXQ53Ft+Hj1KHccRNy3gbDzUQw/+JV+rfxcvWZF4Si1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6Rnb49t; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so317193b3a.1;
        Wed, 31 Jan 2024 16:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706748070; x=1707352870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=38E/3enwOkQa6c3xlGOttOG0xIG/9fEDu/gcDwqCk84=;
        b=Q6Rnb49tmvYSJobmET6UTToheAkR1coySlas4MnhT9LarTaR8+6/9sXUIX2HkIRSym
         f5rgY/RxGYDwbDDV4aTDN7e3mGaCo8/C4fpVpo1Uc/H1d+Gcp2lyX3v4jh+5xttVXnph
         PJfMPuoB9Mjq4IriTVo9xkF66SZLiNW8rFQL1SRzAVI779UHaCn9rSv4JhdYX8nBvqWe
         URZ2/bHouuxzw+6z5GFhiHw1QGZlQwWcQtjTB7S6n67zR7VWBaOpNFFxhOFSIC/sepOy
         NXIOWzfglhb4yAkvMsf8EvImE2+g3a5mKGa0B+N6Wk10wvE2Qe8QNBDMiYfmo6JLZBdW
         SCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706748070; x=1707352870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38E/3enwOkQa6c3xlGOttOG0xIG/9fEDu/gcDwqCk84=;
        b=fE5B2vs/PBFlToqX/5VecDk20jbh7qWnaZfyL5DTxT1pSQ1auyVkGBsgk/JJcQlz7V
         w0Cau2N9XFWumIRlv5dEqyH/HiMrlN63D2zDubKcuLPpKLnd3ZO3qtljUS3ftcnF3bqV
         5pKGKCctzxMj6T2aarQwPiaofdGMwQwdVLRRPJvTYLhq/nEusxSTAlTh9XnmviIyK94y
         9mpiEIyWIJ95Qq1BRFdCjfhVf6XZZoMrHg228dHw7WSgn0PCEIdw6gxeXq8Y8aUB2XBu
         hsw/caODq68p0RSwvdfhP0uCnN7npRkkCHlRKFgaFn0nD9ncDg9s3ZTTSn1GjEmsF3hE
         Ageg==
X-Gm-Message-State: AOJu0Ywf5CCWquO20JpB4tDhId10LGO+O9a3qz8nu47ZyP1Sjxf5vnti
	os/EY/S1GUnws45kd8/nLuGPQLci54GeH0vpt1r94+HYBSGT4aEx
X-Google-Smtp-Source: AGHT+IG9Eg5K5Wmm4nSEVCLYxTSHIxMfVJYkTFqkdc/HaVM1EtAhfeQ34QAP4aAFkoGdFurV0pQlWg==
X-Received: by 2002:a05:6a00:80d8:b0:6db:a0ef:5f2d with SMTP id ei24-20020a056a0080d800b006dba0ef5f2dmr3299444pfb.19.1706748070435;
        Wed, 31 Jan 2024 16:41:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVS+5/yGp5evlDkCVRCzzfckgay7JW589dQi6Acp+wgc/1FQM7BgZMtUNF6P+NDrqdzTwN/4rzXWim2jNxQbssFrjEqXkarqP64b3YQtz9mo3evz4VDY2mRpT+5Eaxn8Jo7/AlzRgUAcVTFTSIgP+60FQJJwelLnVNzwOtIlQrkylFL0bXR4egCvT0C0xm8BC9nIPeod3AbB/elqAbx83duMW8zMdhbUrI1g7R/QQNxxvoWpyV4cVdXFHeYl4ZYK0MwhA/4CfYaXkkrbS6iky6amFd3hSSrp6FUpuq89yXehI8A6V75Fz2FlCLLq5iPI/6jV4mVEsP8/oBcN6YUdQ==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1-20020a635901000000b005d7b18bb7e2sm11175642pgb.45.2024.01.31.16.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 16:41:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d20e1f93-4e6c-4c18-b4bd-19412eb4e8da@roeck-us.net>
Date: Wed, 31 Jan 2024 16:41:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: Add MPQ8785 voltage regulator device
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Charles Hsu <ythsu0511@gmail.com>
Cc: jdelvare@suse.com, corbet@lwn.net, Delphine_CC_Chiu@wiwynn.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240131055526.2700452-1-ythsu0511@gmail.com>
 <20240131055526.2700452-2-ythsu0511@gmail.com>
 <20240131-eraser-given-8381a44f41a4@spud>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240131-eraser-given-8381a44f41a4@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 07:41, Conor Dooley wrote:
> On Wed, Jan 31, 2024 at 01:55:26PM +0800, Charles Hsu wrote:
>> Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.
>>
>> Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 79dcd92c4a43..088b23ed2ae6 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -129,6 +129,8 @@ properties:
>>             - mps,mp2975
>>               # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
>>             - mps,mp5990
>> +            # Monolithic Power Systems Inc. synchronous step-down converter mpq8785
>> +          - mps,mpq8785
> 
> q sorts before 2, otherwise

It does ? Not in ASCII. Am I missing something ?

Thanks,
Guenter


