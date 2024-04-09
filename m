Return-Path: <linux-kernel+bounces-136585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF7E89D5C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2991F242F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53B680C11;
	Tue,  9 Apr 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbvmNkrK"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE198003B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655774; cv=none; b=mYlDb+30wpQ8oZpKmDgeGhO9rCHkXi2h3nNmU4w8gPKkuPiUx+hEFfDx1v9zXIbWxaxRHOcX8ootUPB8t1umlfZFIilgOU0GiqnjSSPMkc5bhByE156+zzUa4f8aL9QCUWH/VA4/2bnn1QxOCJr9SU7ZtNXpC4qRFvZvULoVKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655774; c=relaxed/simple;
	bh=8vvOLQD5ZsaS2XUNwp5Pg+n59sKcIvNp2xo0fkfekN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cseWL2hPHoSe9jtveWOLKMTU1t1RBWS2TAhH8ftRyxJOQcK3AQ3iZrPASNiCsiPfO7D7y9iy1Zy2TCnxUhcMjeazFnFtfii975gNQ6gWyAZ9m35lk24UOBC8o/jbrQQUS+IBALigyXUzAKcr1nQ/u8aT6cyvGtTYAf8A61/U0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbvmNkrK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4155819f710so42126995e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712655771; x=1713260571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A6uDAqyEhHRvdZlwpXxXFcdgG+rDJbSomin1pngZPKM=;
        b=XbvmNkrKmYnieSSnT/TaDwTmJUqD/62QHOQqFWBRLgOCYFIpliKAYUzkA2p4Zr/FgB
         FX8AxPslqJrbCcTsHxXU69eQBLdSKfXxXMsEoBBo1J4ia3HDgzFYQd5oFxw6synv76xv
         6ZO3ShtCMiJz1jZszHmztI/pK59xaL7YuCjmD4zUSZiyWgs2S3/ZX9Xz/L/Hopufzkjb
         d912O5QMH/3CaugSxEKMzXNn8e16878wo1KIxc64WDvhsmbSaj75oHro48EBsVBawrsA
         5CRdzB1BZErYYU8b5VvvS1NR3ljg/aSE9hHgHDs+fWPta8jvL3zknbvpkMIsm+b++s22
         ru5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655771; x=1713260571;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6uDAqyEhHRvdZlwpXxXFcdgG+rDJbSomin1pngZPKM=;
        b=tByapoZvWbqG49+VJf8+EspMbH0paaU/6GEO/Gv51xdRSQyoalTzCp9hQmcBd3plAf
         ZUAsHB4vt3kKDaH7QLD0d/k/1OYZvnfh4TclCVtCxjZTONrSGONRRXI6s2i+3TDLOi/R
         J7Vh+OxzYdqp04tjgvY0uT6YEWb6wtGs7gm8vBGGLq35yq3+xW5uz50TRKX3mnPzmEoK
         Dx6csLY76m5+uLqFQuRSV7hM37nKaiOUH20iA1mR3LgZyC67nWh+96Qsmfit8jxEEeq4
         8X6kz8ISKZLseWkzqgVJ7Ldw6ecp5H7bnkzaRR1qJWKjAiIR3HzvIHUYAqSShzr22qfG
         jPmA==
X-Forwarded-Encrypted: i=1; AJvYcCUoaVGmFY8y1vF7sLygzfHc4FuUQU8/SDBwieRnhBnfJ9sqPkcZD3/ChQ4HZj9pmqruP/WyTxN5HsASpCEkeEtHQ86H+dMYD1rgTKBz
X-Gm-Message-State: AOJu0Yxd/RKamwAyGyU1lvqnKH9qXG6xpJKzE0wsIhdV2166UpsYKlkD
	aZgh89z1XmbMEHxf7ZTDBAW78GTefk02U2b8205JgA2iAJf5Idubwwl8Ezv6uOA=
X-Google-Smtp-Source: AGHT+IGpPPbz11kQsh+3NVfgfOFdIrZTnyJtzHQKO40Gmlg8uys/Ra3Ti+Bs76LJNPYnQOQ+yDtn+A==
X-Received: by 2002:a05:600c:4505:b0:413:ef8e:4cc with SMTP id t5-20020a05600c450500b00413ef8e04ccmr9259111wmo.40.1712655771528;
        Tue, 09 Apr 2024 02:42:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b00416aca5ff66sm1329775wms.19.2024.04.09.02.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:42:51 -0700 (PDT)
Message-ID: <89492719-f8ce-4cda-a5b2-ca09d57203bb@linaro.org>
Date: Tue, 9 Apr 2024 11:42:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-8-c447542fc362@gmail.com>
 <f0467c4f-45e2-4cae-b1b5-3867e5b9bf08@linaro.org>
 <89e7db2d-1de0-4e2e-a2d2-f00d45399b11@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <89e7db2d-1de0-4e2e-a2d2-f00d45399b11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 11:22, Javier Carrasco wrote:
> On 4/9/24 09:40, Krzysztof Kozlowski wrote:
>> On 08/04/2024 17:53, Javier Carrasco wrote:
>>> Convert existing binding to dtschema to support validation.
>>>
>>> The 'fsl,imx28-rtc' compatible is currently not supported, and it is
>>> only referenced in this binding and in nxp/mxs/imx28.dtsi. Therefore,
>>> that compatible has been dropped, which triggers a warning when testing
>>> the DT against the new binding.
>>
>> Instead document missing compatibles and mention this in commit msg.
>>
> 
> 
> There is no driver that will match 'fsl,imx28-rtc', only
> 'fsl,stmp3xxx-rtc', so I am not sure how to document the missing
> compatible in a sensible way. My first suggestion to account for

I don't understand what driver matching to it has anything to do with
the problem discussed here.

You have DTS, so you can see how it should be written.

> undocumented strings would be:
> 
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - fsl,imx23-rtc
>               - fsl,imx28-rtc
>           - const: fsl,stmp3xxx-rtc
>       - const: fsl,stmp3xxx-rtc
> 
> Any suggestions or improvements?
> 
>>>
>>> There is another reference to fsl,stmp3xxx-rtc in nxp/mxs/imx23.dtsi,
>>> where another unsupported compatible 'fsl,imx23-rtc' is used, and the
>>> same problem would arise when testing the file against the new binding.
>>
>> Please write concise messages... you have to paragraphs about the same?
>> What is the difference here?
>>
> The difference is that 'fsl,imx23-rtc' was not even mentioned in any
> binding, and it can only be found in imx23.dtsi. 'fsl,imx28-rtc' was
> indeed mentioned in the txt binding.

Bindings are not correct. Many times.

> 
> My understanding after your comment is that we should gather
> undocumented compatibles and add them to the bindings they would belong
> to,no matter if they are used anywhere or not. I added this one to the
> suggestion above as well.

What do you mean "unused"? If these you call unused, then shall we
remove 90% of such "unused" compatibles from the binding? No. See
writing bindings or hundreds of other bindings as examples. You need
specific part.


Best regards,
Krzysztof


