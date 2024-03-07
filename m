Return-Path: <linux-kernel+bounces-95083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633AB87490E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879811C20C9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B935633F5;
	Thu,  7 Mar 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8MgwQsk"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746363128
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797726; cv=none; b=XHJqvXxVW5XdB1sqdM7HeilbmC2r7innqbvr7kTEmbF+NunZgR4hSct7ts6kYnS143VvTwRKrDPhsw20x/51dQ5uFcYnApQGmeU30YUzzbi97/4xAA2XRHvF7wwKksMBiE59aDHqXEAOppY5FNlOzar7lIYVP7lz4E2W0tZgToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797726; c=relaxed/simple;
	bh=jFQDXvGLp7p9vbgk3JL45+aqTnlwztWMeH8uOV/OvQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdZgHKlRHtQOUgjCeg5NlY6AGVFe75R2ODPmklfsS/gw5udky9i8J2eiruogB3bmLqNqduBt1xVOHTu/8GA21psaA312YWjiC0tvGL8G2L82bv4TGpgzPZmHH18M2Ox9EsnCV61gKbY5be5FrqiWsHSESfIpo0y2QVtRvktmLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D8MgwQsk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so72439166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709797723; x=1710402523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5FrdVWeE9Ji8keRga1zHmD6NeczS9crX8d/3FFqO1E=;
        b=D8MgwQskx5ZmQjkhTseCn501SB6oEjRQTBMOyluRbzA2QvHmvyI+NGVQLMkxkymgg8
         1QJR+mB57pjf0aXGuEdGND9G3Ud9js4RsiTUbbtMDOJjVIXiK9qq0zic+xxcmCA8spbG
         Or1GIqOrE2bFWi6/vnPoVGx+3BOqqzYuq6oBPJgxPEXT7UjgPiwBSmiKSjhXJfswGu6f
         mGM0mLToV2SwOdLjXx1cKT89Bk+UnBe5MrdctNvCY3RAq7sRXpmQcw3LlG27b822mO+N
         oaStRezgdlZ6NvN3p/FDBRfJT5Y7OrZxHGzt3GjCIfsrqqFgfgbJ/fvXOC5Ph3p//NI1
         QQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709797723; x=1710402523;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5FrdVWeE9Ji8keRga1zHmD6NeczS9crX8d/3FFqO1E=;
        b=qZwzMDyOVvhUuDC5cZZFX1tcpiG1sgcHq9hmEBYcGhlDF5YzaPm27LIN6TKSPesb3s
         BmTQnUAd6fLNJrUFEmsF9sZdLa8c93UrUXqYpEyA2obzeyS+mI4Z3j4uqyELOq0x0KW0
         u0NEQlt/Q2kddYaLBo+Be/a0HCnb5c2FjnpmzCJROfkp0IaJFnFpybrQR5P5CBMPRmHJ
         0SVEnowpH6KJF6O3E14yQ4O4AxscyuMqcianeMzjRK7QuLY8X2VTI35nGY8NTY20YQOO
         AeCLz365K4k28zhUhf+eWu+k0G/FrJ1ubtnuyT1CntPe0GWPnmjJN5fUdAuQPuwDn4kl
         Y/qA==
X-Forwarded-Encrypted: i=1; AJvYcCXGlxHh7DRAqCPMglJnB413r2LAAmR65Idp984lN7VP/ShNOgFcF4Ur37d9RrfX1mUGfJSNtNcZHh/aDohpRpHRzEzoaS8NV+QVjbv1
X-Gm-Message-State: AOJu0YwxyBXkIHnu7mfGQ+IdcJFnQmMEp4Sr9b70ShBvMTPDMp+Vx4zX
	ItC5FNEAH8YyMoka4rp7FJ7TibZ0Gr3HdJ+il/TQkStJrElSC9qCXM3B55GIcHc=
X-Google-Smtp-Source: AGHT+IFPaVLeT7/HA8AHTsJEb61jX7OAF91GsQxpDYTjXrFZIvYX0U2Xry9PQ1zs9dOnPWI1zfHLZQ==
X-Received: by 2002:a17:906:a2cf:b0:a3f:33b2:5ce2 with SMTP id by15-20020a170906a2cf00b00a3f33b25ce2mr12791329ejb.35.1709797722846;
        Wed, 06 Mar 2024 23:48:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170906e91600b00a45c18345e0sm1181462ejb.163.2024.03.06.23.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:48:42 -0800 (PST)
Message-ID: <66f578b4-5e1b-4cc3-b39c-3b61797cacd3@linaro.org>
Date: Thu, 7 Mar 2024 08:48:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240305-net-v8-0-166aaeea2107@outlook.com>
 <20240305-net-v8-4-166aaeea2107@outlook.com>
 <66cf4c42-5b8e-41b8-bbdb-7fb2c6bb9e66@linaro.org>
 <SEZPR06MB69594BB6F24CF86E859D698196212@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69594BB6F24CF86E859D698196212@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 10:28, Yang Xiwen wrote:
> On 3/6/2024 3:39 PM, Krzysztof Kozlowski wrote:
>> On 05/03/2024 08:51, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Convert the old text binding to new YAML.
>>>
>>> While at it, make some changes to the binding:
>>> - The version numbers are not documented publicly. The version also does
>>> not change programming interface. Remove it until it's really needed.
>>> - A few clocks are missing in old binding file. Add them to match the real
>>> hardware.
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>   .../bindings/net/hisilicon,hisi-femac.yaml         | 89 ++++++++++++++++++++++
>>>   .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------
>>>   2 files changed, 89 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>>> new file mode 100644
>>> index 000000000000..ba207f2c9ae4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>>> @@ -0,0 +1,89 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Hisilicon Fast Ethernet MAC controller
>>> +
>>> +maintainers:
>>> +  - Yang Xiwen <forbidden405@foxmail.com>
>>> +
>>> +allOf:
>>> +  - $ref: ethernet-controller.yaml
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - hisilicon,hi3516cv300-femac
>>> +      - const: hisilicon,hisi-femac
>> Drop this fallback, your later driver change does not use it, so neither
>> should have binding. Explain in commit msg, that old binding was
>> incorrect (we discussed it a lot) thus you are making such change during
>> conversion.
> 
> 
> What about deprecating "hisilicon,hisi-femac-vn" compatibles and 
> introduce a new generic compatible "hisilicon,hisi-femac" instead? This 
> way, We can keep backward compatibility.

What backward compatibility? Didn't you say bindings and driver are
broken and you are going to break ABI to fix them up?

Best regards,
Krzysztof


