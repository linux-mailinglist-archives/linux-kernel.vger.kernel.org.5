Return-Path: <linux-kernel+bounces-16615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802682413A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858FA1C232EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16A21371;
	Thu,  4 Jan 2024 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpes5WeJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCF219EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cca5d81826so5924451fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704369785; x=1704974585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFIN0JRPxZeIYz9kF4NaZedcE87VAaRvQmqCR63HznA=;
        b=xpes5WeJ03jylSvs61Gd4ZQcY3A6dT/3JtBf8h184UkojiC1np8xwvhnkkQIxFePw2
         292R8Ls6I2MK0wK7Iwc+ms068/Um8sB1a9l9KtNavM1QD8o4a/lm72Qz9O2PWuP3j06t
         /KJ89YjO5AJHGKApI2rQ9D0Mvyyws3g+DyVxsWZ6K38y3EyWdPE9VeWo+LxdGI3xE3GW
         xXI2Lu9e+5zCKYPiJY/0j99G+tfh0T7+hgyB0wiPW3QeQvEI3+5JjteZwk2Ez3INeCW+
         ljgBj9UNHu1C7YgSUuubiOO5r+qwMecXRLFQoXhElDz3QzymVM034mvXpH40r4z3ONNK
         2cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704369785; x=1704974585;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFIN0JRPxZeIYz9kF4NaZedcE87VAaRvQmqCR63HznA=;
        b=hxWsXqcTBjq/Dbt64IIKQtOJctcucbAAR91zVhuTfvv4/OmxbBkDhdWm68zX4R6mnP
         kxatW+BV8X30mgptKRtN3VtvG3wIIJsD5gmA13eOcdil69V88ZgHdl3V91HybYqybl5m
         nP4PfBvBMHIaguC+5mXpd7QbD5yShK66C+bkCnBHxDujMFO27L3Fp6OAfREN1sVsIvCJ
         F3n1uWW/JBsXWAsZHGyKIOrDLCI5EY9uRCcEFWA9osgjxTesytdAFF7DA42cT0+cnrYD
         iUrYAfvV36S8sDh3f5qWSFM7kIYwsva1/jyCULkJWW9JfWGYaPzNwV3ZZmOS49PA2pUI
         w/ZA==
X-Gm-Message-State: AOJu0Yx/SyaQiNaJEqgxH0SYJLnKxx1A7SAlXKQ6Kz2rwdLxv9lhpALC
	DQY4qI1DZnT3PpOLZAPnJLsfCm1JtmZN3Q==
X-Google-Smtp-Source: AGHT+IEfclptb3Y6RoCGpyhaqWbQXBt6VX579x8n32GryTMhIBu+yxRbTfoeKYc+baWP3G64gwLKpw==
X-Received: by 2002:a2e:9d84:0:b0:2cd:13bf:78d7 with SMTP id c4-20020a2e9d84000000b002cd13bf78d7mr255488ljj.10.1704369784952;
        Thu, 04 Jan 2024 04:03:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id wh14-20020a170906fd0e00b00a234907311asm13618345ejb.55.2024.01.04.04.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 04:03:04 -0800 (PST)
Message-ID: <5cdd7549-1b44-4612-b020-84ce5a24e15a@linaro.org>
Date: Thu, 4 Jan 2024 13:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] dt-bindings: mfd: sophgo: add misc MFD for Sophgo
 CV1800 series SoC.
Content-Language: en-US
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
 <20231229090643.116575-4-qiujingbao.dlmu@gmail.com>
 <942d79d0-08a8-4cda-90de-57daa44d9dd7@linaro.org>
 <CAJRtX8Rv0Ws=fcgDf2jh6GRz3ba+CkjH4u6JUPZnN61-CqqzZA@mail.gmail.com>
 <73dc5e85-0442-4b48-8abb-4a323403f3c0@linaro.org>
 <CAJRtX8QKyGDrCa_L8YY_Bsy3TTJsfw0LOt2T8uLWEfKE9QrQDg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJRtX8QKyGDrCa_L8YY_Bsy3TTJsfw0LOt2T8uLWEfKE9QrQDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2024 12:42, Jingbao Qiu wrote:
ties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>>> +
>>>>> +    misc@5025000 {
>>>>
>>>>
>>>> misc can be anything.
>>>
>>> Actually, there are RTC and (Power On Reset/POR) here. I can't find a suitable
>>> word to describe him. Can you give me some advice?
>>
>> Then maybe just rtc? If there is nothing else, why RTC is separate subnode?
>>
> 
> There is also a por submodule used to provide power off and restart functions.
> Do you mean to use RTC as the parent node like this.
> rtc{
>     //something
>     por{
>     }

por is empty in your binding, so there is little point in having it as
subnode.

Best regards,
Krzysztof


