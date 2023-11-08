Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428AE7E538F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjKHKm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344242AbjKHKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:42:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B721BD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:42:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32fdd0774d9so1330253f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699440172; x=1700044972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBVY3LXBI0SP1Yr01Ro9ySuR+Ox+MEZVyCv79ogrTPI=;
        b=y9DQVui5vcvcuRj7Gb+AFKxe2ydDdI0bA7rXkqM3EaBHyU6KMNv7Iv9Dc6q/ZwkpbW
         K5xxfzNxnwrm7PgrkDt4jzRRvgH9VUFpkswPjoC5iHzkoz6TofPxwTfhwb36BTWLmteR
         gj4TgqyXa2Z5aTQFpSiTZH9L5Ywq4vDguxz5xWvwxPTjt1V38uh/7M/gp+xsfRQxrgwU
         2iutUzE7qg2NpE5m2vGNbZe/IuOlZDAqZeuheX2b1rXMuv/+IR92QiDpU2AX3Sqddo9K
         TJKJVFPNecDE96GwnFYiI8agCovgDdQESucsAwHeuWZMdAIvKAkz5L5Y9Wt5elFt6oqR
         GZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440172; x=1700044972;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBVY3LXBI0SP1Yr01Ro9ySuR+Ox+MEZVyCv79ogrTPI=;
        b=jakzqHxfNW0VUsbBZbRb/CZbwt48sk4pmR3ZcAe2d5XFbj/clxR4xijvIPs/kjwbkw
         +mAZ2yW6MdC+gOKgqGbfLU7+LHHVI5kEDR3gimNtpo2UPQf3Mvnk/NAM2VhSG7A4EiHU
         KUvMi48/fP+7/hXnzNTK+OewyFhmKDXrF8OmGbTNb4JFdlYkUwnXcm2fOcaduBZF3I6z
         NqYyTTIYQT/nqpPg2Vvetq1UCEIaO+tYCFQtJpEvk6wX1R3pdfC05USg2moYVNyvsNJQ
         E++sHQLwwgmoxmUmkp2uRmc6m7Sh6PaN0eRAZ7NzAKANnoyyOA2Vo3neQjnCpiXc2Sc/
         /X+Q==
X-Gm-Message-State: AOJu0Yy4eMDSeYLpMLnBrdgaSFN+uPPW6tewro74PBiledCe4k1Hf+lN
        Zo4tvvOemhh7Bhxb/Jm7yPHL2ulW33yVx7FVvkQ=
X-Google-Smtp-Source: AGHT+IGuQTcTqK6ErXO0p56cpARMFFFZtoLTyFX7OciwEg0uR158efzAha+3P1o3UwO44wQ/XeFTnA==
X-Received: by 2002:a05:6000:18a1:b0:32f:78dc:ecd7 with SMTP id b1-20020a05600018a100b0032f78dcecd7mr928005wri.48.1699440171710;
        Wed, 08 Nov 2023 02:42:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id d7-20020adffd87000000b0032fb7b4f191sm4578729wrr.91.2023.11.08.02.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 02:42:50 -0800 (PST)
Message-ID: <7951ebd9-821f-4592-8381-ceec5b01e1e7@linaro.org>
Date:   Wed, 8 Nov 2023 11:42:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Content-Language: en-US
To:     "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>,
        Yuxi Wang <wyx137120466@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231108032921.3134115-1-wyx137120466@gmail.com>
 <20231108032921.3134115-2-wyx137120466@gmail.com>
 <e63fbf69-fe21-45cc-ae46-7b95dae9151e@linaro.org>
 <BY5PR13MB4487AE8D2319B5F022C53343F6A8A@BY5PR13MB4487.namprd13.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BY5PR13MB4487AE8D2319B5F022C53343F6A8A@BY5PR13MB4487.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 10:30, Yuxi (Yuxi) Wang wrote:
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  mps,led-protect:
>>> +    description: |
>>> +      LED short protection threshold.
>>
>> threshold? So in some units? What does it mean? What do the values mean?
>>
> Yes, it indicates short protection threshold in mp3326.
> But they do not have the units. They just indicate the corresponding bits value of register which can configure short protection value.

I meant, what are the real, not how you wrote it here, values?

What do the values mean? Description should state that and according to
this, you might have to use standard unit suffixes so these will be real
values.

> 
>>> +    enum: [0, 1, 2, 3]
>>> +
>>> +  multi-led:
>>> +    type: object
>>> +
>>> +    properties:
>>> +      "#address-cells":
>>> +        const: 1
>>> +      "#size-cells":
>>> +        const: 0
>>> +
>>> +      color:
>>> +        description: RGB module
>>> +        const: LED_COLOR_ID_RGB
>>> +
>>> +      led_r:
>>
>> Nope. First, no underscores in names. Second, please open existing
>> bindings and look how it is done there.
>>
> Thank you for pointing out this, I will Fixed it in the next version.
>>> +        type: object
>>> +
>>> +        properties:
>>> +          "#address-cells":
>>> +            const: 1
>>> +          "#size-cells":
>>> +            const: 0
>>
>> Why do you have the,?
>>
> 
> Sorry,  here in no , .
> what do you mean?

s/the,/them/

Why do you need these?

> 
>>> +          reg:
>>> +            description: Index of the LED.
>>> +            minimum: 1
>>> +            maximum: 16
>>


Best regards,
Krzysztof

