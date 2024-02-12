Return-Path: <linux-kernel+bounces-61424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40485122B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FB7B26E39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7650C39AF8;
	Mon, 12 Feb 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqtqzNMR"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D555439AE1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737154; cv=none; b=FYH9Eng1FrQDioffjENUaL/i7Ul95uaA5Qm/eeDcSzMbq6rhFLQUk58xoIMtW6ZiswEVW8fBnurdAThuZXFC6Z5JB3pd8jpBmtq5inv3O2qJwJ59W+sCeSzvufXzMbBdXbxTxWgfjpl7BlgXAP0Sdx0BQlNJnrUO4+bpc7tMl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737154; c=relaxed/simple;
	bh=mv3dvF/jvZb+LLQsojThwfQ1e2zP48EvLr5YjELeiag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGWcK+bWnmTz5bSxvwWj/uUXITfUYZUzYiRL0EHMxq70HFLn5IDAIRlqSvAzO2XuKfWSb8VpHAcCLNvutjFRyvhm177B+B4AtmEOmKbL8g5yyfsHKI6TSC+2W4Lf3w0QHt3Mo3+Pi4Nn7dCBFIR94lW5NcXfdFrC0dIlh6X6Iug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqtqzNMR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394ca0c874so2138407f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707737151; x=1708341951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RHd6/9I+xkFHICy+C3VZHglLBzgAJ/lAIOT/iO2qeI=;
        b=aqtqzNMR7WHlMFTPQ2VeIZDksX6CnWppVCwKrWOuC0gWdyloILM8TDTsdsvhr7lGxh
         +Tnw3H6V0g2TSCKD6ol9g4DA3P/XUzSJyBiKALc1vOAEhYvNRdFVfsjy8Ilhu7Ye0mS8
         /dAL900pErjHmplOJNlK7ctwC3iYvPViZ5z6pZrWbA2gfKmqQmKPFftBXMyyCcsZYHOV
         5fWOyYljDW+CQ6xzxC9kvZ+DF/otn1sZOx/wJd5c9+a0lYUK8BYr19GZLVNQ7PW0pnwA
         KuDpYXYqla5wPKam8QxsiXk8htGo4duhJAopNTJsbQ93iFI4dDLscMm1j95x+e5Y/Vhm
         tdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737151; x=1708341951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RHd6/9I+xkFHICy+C3VZHglLBzgAJ/lAIOT/iO2qeI=;
        b=CDsoCIfYPVHRWyO70vRxbo6n6VNgtvf2M+GkueGWwpxsZNGKaVcH2PiHavTrMzo3Wc
         tkr5w5xINKgS6EvoZiUYVHplXFT+wEPPOPRkUyM8AIQgsMDdp73NyFmJ/BsdIFaRume7
         6OsHeQKmuxEyHFUuWnsp2gXLNWERm8bH0+uPzzjRx/Pjk2fXyWkvv04TjFwDhqoBxaLl
         tAykI0pB9qf9EB4dNu5qGE5dyqjij01STiIQh+GZXSnGlNDaPi/ALGzxbPYjMFkghbbW
         Aa4dgg23nytqpkm0Vc4i1FQI4ddlzfAvkKudIy1V/RjAbhWubOqf0jI3Xbw3HlTqgksG
         iIeA==
X-Gm-Message-State: AOJu0Yz8WSVujmxo8J0f/g9vWtoqehLGtb2zOa4uEvBp/Vwhnmz2//7A
	lmDSUGH82UBAqy84jwVaRu0zDG3cxqPb3OcWzXXP7bA/Ir8kzR1kcdpR4jzbh5Q=
X-Google-Smtp-Source: AGHT+IFoR1n8Lq65e1mWU/YOlZbfEWtGGgdg/Xi2NQdAP/sI9zpd61DBileYjN0gnjmqMzdHS4yTmw==
X-Received: by 2002:adf:fc49:0:b0:33b:4ec0:8159 with SMTP id e9-20020adffc49000000b0033b4ec08159mr4866132wrs.33.1707737151101;
        Mon, 12 Feb 2024 03:25:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEDC84ZrRQg68O5ujKDeE3Qp5VzXbYdYqp1Iuf6dK/5cbY91u11zmNThjXcey3OXJXwoXgWLlVYJJ9NgNzVdy1WOSRGpjOQK1ybgrHxRHsGhFj7MokN08DKvy3Y+Hsqn5fO8AvSgbEAFFvpytf/OfzJnyWq2mBQLDYyC7TwtiFJqhbbMAJd1TvdYE/1tDBqzQgYNF9AL5b8QK92TZ0P0YSLXNVYuw2r/6aIplzXswoCRuiGluJWVZRQrJpSLeoaokm+S/RYqC+CjcQ9ZtC2a9vbJH8fpty7yr/tgQn0hBm+wnOO7nop7w5lgR53W0jNSG+PIbZk3Y9nngRkfeYIz25FCosHOCF/IUaEub9trVvKX7UGuiJtt9xMfQAAmlEgQsmzaG0smnZkRWEB3zWkvmlwhrW4L9QKfcdCOZSyMdvZxW5kIDaxR4i8g==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d43c8000000b0033b512b2031sm6501728wrr.114.2024.02.12.03.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:25:50 -0800 (PST)
Message-ID: <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
Date: Mon, 12 Feb 2024 12:25:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit,hd44780: drop redundant
 GPIO node
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda
 <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ralf Schlatterbeck <rsc@runtux.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 09:41, Geert Uytterhoeven wrote:
> Thanks for your patch!
> 
>> --- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
>> +++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
>> @@ -99,17 +99,7 @@ examples:
>>      };
>>    - |
>>      #include <dt-bindings/gpio/gpio.h>
>> -    i2c {
>> -            #address-cells = <1>;
>> -            #size-cells = <0>;
>>
>> -            pcf8574: pcf8574@27 {
>> -                    compatible = "nxp,pcf8574";
>> -                    reg = <0x27>;
>> -                    gpio-controller;
>> -                    #gpio-cells = <2>;
>> -            };
>> -    };
> 
> This part was added delberately in commit c784e46c8445635a ("auxdisplay:
> Add I2C gpio expander example"), to aid makers who are not DT experts.
> Note that there are no other examples of this popular wiring scheme
> in upstream DTS.

Hm, I don't understand how exactly it helps. The GPIO expander has its
own example and as you pointed below, this is basically the same code,
except rw and backlight GPIOs.


> 
>>      hd44780 {
>>              compatible = "hit,hd44780";
>>              display-height-chars = <2>;
> 
> If you do want to insist on removing the i2c GPIO expander part,
> I think this node should be removed too, as it is almost identical
> to the first example.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Best regards,
Krzysztof


