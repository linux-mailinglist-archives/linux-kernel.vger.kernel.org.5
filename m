Return-Path: <linux-kernel+bounces-24936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471EE82C4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22251F22579
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6BA1AAAD;
	Fri, 12 Jan 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmRKJ2Re"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACBD17C82
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so77653895e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705081576; x=1705686376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dl7S1NAFZ0VMy5uxses/Ge8AyRzyd0KPqbKc6GY+0fA=;
        b=wmRKJ2Rev5W/WEyud0eFZy0GVSndxeKJ6NtKpURIvN9jDVijc9YUjrKiGxFdxYfuMx
         GIWq+9uHD8+5I1AmQoLP5LCk43vzvceVgA98MGvg2UBhdEQrmMkT5037h3efEWoR2LQY
         Fg5CUKsUFbfIK9+6CGXkP29xj/0MRGRiGGoyi0//d6hBNqaZibjdp+WVfvoBjXp0bZoB
         NefBWYziu9K0G4g2FvMIzdd2Dt+O3YLi+MEufsY0GmwVE6TRbWjGvjDppiXf8kJaUzm7
         uHy7n60KA9C8EF4soy3wC8j918E7pUJLpyvutw/dkCXRVClqwSOGGp/FnC7nivN7eXFT
         F6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705081576; x=1705686376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dl7S1NAFZ0VMy5uxses/Ge8AyRzyd0KPqbKc6GY+0fA=;
        b=tAYdUIini2Am+5bkC8C9oq1Dq03HS6dUSHkMw5ExW5kK6RAtg9rVpY2nyJUZvtn7AQ
         yXK/uaVWSBVDAgWgwcAuaNGRFO1yv9zuWiEh6vK1sdxOS7tKGz9wNfYQfk6tvUhgYVDX
         y4UTlYWp1hh2N7mb5B50jFgiyMrtCphCHKJU/gxq9xX8s0Q4VqDQmuzsdcYCCGz+52f8
         6TOF0X2RenUtwERk1IQAPtg6ySgBX7FcFNIv8Ko45tcG4eTV3IFQyexrfBeM6MERfE4x
         nA2OMR7ti1UMSkbmH2272uBa64KAWg1m1SXTUNwegWZxKF06gcJPVAcgCog9SpzYfepJ
         LJuw==
X-Gm-Message-State: AOJu0YwqrcIN0Xrt71m9DWgOfOqzabujcFOFODbpMw/qXpaXL6qIq20v
	9T+XiaLgJ7W0YjdIMbcg+7z2aZBqUIMKHw==
X-Google-Smtp-Source: AGHT+IExNXnfteMV9BfxGzW28CNSMTJA6onBUh7HAdDLcbMAaUD6Z8XAylVAdNrCWD7kP3WcBIbblQ==
X-Received: by 2002:a1c:7510:0:b0:40e:4244:c01b with SMTP id o16-20020a1c7510000000b0040e4244c01bmr750213wmc.7.1705081576064;
        Fri, 12 Jan 2024 09:46:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b0040e4746d80fsm6513363wmq.19.2024.01.12.09.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 09:46:15 -0800 (PST)
Message-ID: <61df52a3-860f-4813-9a71-72ab6be2d559@linaro.org>
Date: Fri, 12 Jan 2024 18:46:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: nuvoton: add Facebook Yosemite 4
 board
Content-Language: en-US
To: Patrick Williams <patrick@stwcx.xyz>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240112013654.1424451-1-Delphine_CC_Chiu@wiwynn.com>
 <20240112013654.1424451-2-Delphine_CC_Chiu@wiwynn.com>
 <8efef092-e70f-46c0-a60a-e62e676d6eb2@linaro.org>
 <ZaFydbPxbeczo97t@heinlein.vulture-banana.ts.net>
 <c0a83358-09a3-4c51-b8b6-6d6ea8b4f196@linaro.org>
 <ZaF56lwEi1MES89Q@heinlein.vulture-banana.ts.net>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZaF56lwEi1MES89Q@heinlein.vulture-banana.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2024 18:42, Patrick Williams wrote:
> On Fri, Jan 12, 2024 at 06:14:26PM +0100, Krzysztof Kozlowski wrote:
>> On 12/01/2024 18:10, Patrick Williams wrote:
>>> On Fri, Jan 12, 2024 at 08:10:25AM +0100, Krzysztof Kozlowski wrote:
>>>> On 12/01/2024 02:36, Delphine CC Chiu wrote:
>>>>> Document the new compatibles used on Facebook Yosemite 4.
>>>>
>>>> There is Yosemite4 board already supported. What is this for?
>>>> https://lore.kernel.org/all/20240109072053.3980855-5-Delphine_CC_Chiu@wiwynn.com/
>>>
>>> Yosemite4 is a server chassis which is managed by a BMC.  The BMC is on
>>> a pluggable module card.  Typically we've used Aspeed chips for this,
>>> but we are building an alternative BMC module using Nuvoton BMC chips.
>>
>> There are few ways to solve this, like having different compatibles or
>> having some shared compatibles to note common part of hardware. However
>> usually the final compatible represents the final device, which here you
>> use for two entirely different products. This works only for the cases
>> of carrier boards, where that compatible indeed represents the same
>> hardware.
>>
>> Not your case. This needs fixing.
> 
> This patch:
> +	model = "Facebook Yosemite 4 BMC";
> +	compatible = "facebook,yosemite4-n-bmc", "nuvoton,npcm845";
> 
> Aspeed patch:
> +       model = "Facebook Yosemite 4 BMC";
> +       compatible = "facebook,yosemite4-bmc", "aspeed,ast2600";
> 
> These have different compatibles already ('-n' for Nuvoton).  Do we just
> need the model to be clearly different also?  Maybe there is something
> else I'm not understanding.

Ah, no, it's fine. It is just a bit confusing.

However commit msg for sure misses a lot of this explanation. Please
write something useful to avoid such discussions...

Best regards,
Krzysztof


