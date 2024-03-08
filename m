Return-Path: <linux-kernel+bounces-96604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0F5875ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8AB1F213C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52F4F887;
	Fri,  8 Mar 2024 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXn5Bap2"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF22AD39
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884284; cv=none; b=ZAFw5Hik488L31s3wq7AMG9BKzK6CkthuStEjy+HWI+lGpMzIh4bd+wfNfeJxeEobB6Lp6yIlZnwz7C3Y3VxCyiJlfG5v153EaPlothc1td0sgYnkWyoJh0I6w24RGfPXt785fv1KGvFKPT05FiusqYFqepgmQ5u7qRD2kYiueA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884284; c=relaxed/simple;
	bh=4zQBFEituRRJQGcAdyejGRIwJAdQOfvytMtKgM70fgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTEoZoeiyo6jVb5jI7uBghYkqqdDrgZ/6NTOH31xSkEkbjpqjdCH8oNBDjWSYC4uIrMfdqiXkmG/pJMZme4tQhNghfBHQYwaUfTEOtUasgbZ1qtTGCfcPKUjKW+/l0EXIQjVNhHqx2Xl+BF6qnYTTqfcgSgcYzkMLgJerc3QiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXn5Bap2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5683247fd0fso90629a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709884281; x=1710489081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BN5vuDIQIWrwopOBda9zrWNlKIbhe7/8kfFNi7Dj87Q=;
        b=DXn5Bap21LkLYTx5I4xpyilCYQs9FXs5KoDQxkzgjihllVLbJo+oVdhL1Ng5BXvg7x
         4HDF+YGiLp5SiqJJx4ZPl5FJYHRcjQ8VCy1F60WruKHDZRbBQW/k2pbD36k2xZZJlktR
         qcg0BTkYpjdPRtG6t9e7fGX6Yjp5yTKsimNk5X2QAqNu9qvOQzuAhNClUFB25yujMOhF
         3qD9FG97VN1odqtQyNdGAgvCx5NEtalZxDvavMrcZpAN4+VuCkm+/+Q8VssqrqzttUCG
         HB1KdRj1scg705aMJKtgCDhz1ll92QVs6UhkSgZRCHDp9gH/6RJkCX+rDNOwVjGa2BCa
         qHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884281; x=1710489081;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BN5vuDIQIWrwopOBda9zrWNlKIbhe7/8kfFNi7Dj87Q=;
        b=QwtGd1b1oEERPyHt2f2QGbkho9qf7s7sEDQ2qfzAkgqWm4cOCNGVAy8P1y1ilhTdru
         TuMzlXutSRPEP3BvWF2nSDyY1AjibsZDDyCVzhlD0Dmf8+j2FONYJfh+jSGILSZoGCfD
         YxMPIiigp7lcIObqkCMWf5ezjKEwh7tNEFARgQGQo3+mLQzId4EXWR60XUr2KkVXgmG2
         dOgWX7Zs5K5K+HLetcAknY37BLuiljcaguYAVA+5tdxpyLzTeH/C3aKjaQUrD038Cqoq
         bdDTvI1UlNlDRqYCfHIEAjt0QkDNDEUrNgPFLeZ/843jAFNtD+kAzrUBnguNjnj/x4Ay
         mO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/GDBC8HstPNAgMxdQkkXsp8LbemlZFoU/DhpZmla2jRy4kCgXT2z28lCy9o8B0nxGqaeRC28iKhBW3YaVjP8BAy6dhYxGngKwhzdN
X-Gm-Message-State: AOJu0YxbmupQlu2+wnLYYbn+m1BoNKNbSu1XCvEWDYV9oJGlANvJU8aB
	fBCptei3NrcIC5S4PuGvOjlRNnA9Ounm0h6dR8CQ3tcBD3kjZ4l3HIuDD8LkjOM=
X-Google-Smtp-Source: AGHT+IFY20soBaNQQ0/Sk+HJbI3Z785C5gJBhI8FG+8pTScLh6JuN7HdvEZ9HBl0W6MHNUYnXYY5wg==
X-Received: by 2002:a50:9992:0:b0:568:316:2616 with SMTP id m18-20020a509992000000b0056803162616mr1164636edb.15.1709884281171;
        Thu, 07 Mar 2024 23:51:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id el8-20020a056402360800b00566d6e30f1fsm7762452edb.31.2024.03.07.23.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 23:51:20 -0800 (PST)
Message-ID: <740b1f29-ab80-488b-b40d-3b8d95bc6c23@linaro.org>
Date: Fri, 8 Mar 2024 08:51:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxIDEvMl0gZHQtYmluZGluZ3M6IEFT?=
 =?UTF-8?Q?oC=3A_Add_PDM_controller_for_the_StarFive_JH8100_SoC?=
Content-Language: en-US
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Walker Chen <walker.chen@starfivetech.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
 <20240307033708.139535-2-xingyu.wu@starfivetech.com>
 <0b92700a-cf79-4f1c-986a-d18fe0151bb8@linaro.org>
 <NTZPR01MB095618FAFF22BDC301F69A0C9F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <NTZPR01MB095618FAFF22BDC301F69A0C9F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2024 08:49, Xingyu Wu wrote:
>>> +
>>> +  starfive,pdm-modulex:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1]
>>> +    description:
>>> +      The module x will be using in PDM controller. Default use module 0.
>>
>> This is an index of the block instance? If so, then it's not allowed.
>> Otherwise I don't understand the description.
>>
> 
> No, this is just one instance. The PDM have two internal and independent modules or called channels.
> They can be configured and used separately, and the user can choose which channel to use.
> 

Do the modulex differ? Why different boards would choose one over another?


Best regards,
Krzysztof


