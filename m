Return-Path: <linux-kernel+bounces-72016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3685ADD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303601F26964
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11A53E3E;
	Mon, 19 Feb 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ix1lpdx7"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245955E47
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378644; cv=none; b=tb9mRZz9B+25/84522mKqT0OeUYCKk4vmboTp04BQctn0ybqXXJ//jVBHxpuywclbGKr/oDmxICzQ8T7F9pp6oK0iERFNtjBCGcHpjXmCdyeYHJsEQ+LVumMXMaNBnaJer1CaJiE5jcivak4ezNP8Fpgl9FGQ+qHXqGInDBYgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378644; c=relaxed/simple;
	bh=TKn2TrIuEVPU93U+6nZajsCQi17cj8SdYFtBCLMFPfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W70Mk9afJCIdreZWUS8e/Xn6tFSMdF9oQL0mZcuR4bY/TZaSqlvATu2df/7IO6rTvaqMe0Eigug9+ew+PVFfraFuD13D85Rr/WWXbU2M5+XLxnB8b6n6gVM+MoJ76P9ognNdj1+0KxyTwN2zMU6d9d0psZ+innwXW9A88HDrZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ix1lpdx7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d208d0b282so63859901fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708378641; x=1708983441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kiwyw9WX7QB6j1OI0/JCJDw1jGKOzumcYj5mvbxIKlI=;
        b=ix1lpdx7g0vJf3ZKcLFwbdgJa3kNpp0PEphQ2iZOmX8tJLqK4JQMwRMbc1hYAH8Fja
         KVJ/Fg/CWhRvVuluumgUmgBoB0EyqucoUOctb8nwF6WiDny161hy1psXkoKJepmAlcIk
         bwaW/KrI9qcODbC3oMSVyn2grVZSSvXm4tEd42CVkqkxviXlv8A+JsRUbZjQLEZ9O0bj
         X+WbCn4/CkIR3HrYlGd49ojmaDudWIaF8Cc+e23r8sNGaLrfkTLCIP6EDTC8mk1+q66t
         BZsMQ7osjWltLErYznEu3rvYLnIlMLQF0GdqJAbjjefZvxNkhKRF8ZkoHLMmrqWCxvrk
         LP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378641; x=1708983441;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kiwyw9WX7QB6j1OI0/JCJDw1jGKOzumcYj5mvbxIKlI=;
        b=djd2n9RPi4cWHv91A/VzwBflL24eNssyIZkHly00GycZ8+s4OHJ6AbT7sTkJUFPbbp
         od8Gwp37iUqAsImfvDkMivULZGW/zojMxKhZeFQUZWcHiTvjAUjmQ9FzA0Jt8AqRS/xX
         hPpBOOSPdErNe5srbinATTam4TwlU9lwenGjq1wJm2+lLC57pl36ujlyeZKTUgQn4Q3P
         fhA/ExhnQU0wVx4XLqTI2unKqykfRWmnRHBaz/HRbtm7GWgCaFcqpZvOfkCz+QsSce2d
         6fZzqBwztq8TRh8y45KkYVKwZ1v/7etZzJovBMmeod5qEqEhgWq9IINVuTOm7lMDt2ZZ
         9wVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV53GBxjXM/JrHRvpH+pqmJ8zGX9JkfH0LCEKdbvOz2ZTjftOqSNQYjLIAKPz5+QBIVbAb12B8YuyJIyVWCzgFn8kPh1v5yDAl/InSk
X-Gm-Message-State: AOJu0YyvxrnSpWY8RKRoMSk+EpxpEt42o2Il9bty7rJ5T62cHa2UTmUi
	347AAYrdG6o11/9y4HOMqXIu2cQAmUKTVH9pdKZ3jjU3LX2H8wwksWSdwLDOw+g=
X-Google-Smtp-Source: AGHT+IFLvDieckfxWuMTSZsG6r5J9pLX9Da+hCOAlK8PQHUs4f0CF8+gngV48Lho/TBsm8wYOzHKVA==
X-Received: by 2002:a05:651c:7a1:b0:2d2:2e2f:97f6 with SMTP id g33-20020a05651c07a100b002d22e2f97f6mr3596965lje.50.1708378640861;
        Mon, 19 Feb 2024 13:37:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id dn23-20020a05600c655700b0040fafd84095sm12314551wmb.41.2024.02.19.13.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 13:37:20 -0800 (PST)
Message-ID: <6f3f22f6-f659-494d-963c-544cf5f44adc@linaro.org>
Date: Mon, 19 Feb 2024 22:37:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert to
 YAML
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
 <62221084-247c-4a0b-a030-e12cb2931411@linaro.org>
 <SEZPR06MB6959AAB6B43F3E1F5E1C526596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB6959AAB6B43F3E1F5E1C526596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 22:35, Yang Xiwen wrote:
> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>> list due to prior driver change.
>>>
>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>> compatible lists.
>>>
>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>   .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>   .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>   2 files changed, 95 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>> new file mode 100644
>>> index 000000000000..1b57e0396209
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>> @@ -0,0 +1,95 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>> +
>>> +maintainers:
>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - hisilicon,hi3798cv200-usb2-phy
>>> +          - hisilicon,hi3798mv100-usb2-phy
>>> +      - const: hisilicon,inno-usb2-phy
>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>> hisilicon,inno-usb2-phy are not compatible.
> Ah, i didn't pay too much attention to that. I should remove the entry 
> for hisilicon,inno-usb2-phy in the driver. Sorry for that.

We don't talk here about driver, although I used the driver as proof or
argument, because I don't have access to hardware datasheet (and no
intention to look there).

What I claim is these are not compatible, so respond to this argument,
not some other one.

Best regards,
Krzysztof


