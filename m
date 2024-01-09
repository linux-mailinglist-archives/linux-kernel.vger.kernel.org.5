Return-Path: <linux-kernel+bounces-20633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D878282BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB302881C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F52E650;
	Tue,  9 Jan 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dU1cDEuv"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDC29422
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a277339dcf4so289502466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704791441; x=1705396241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/iSBtYdwkzNJEGVGY2jh4ufoDK8wyYf7JBua7/iNqHw=;
        b=dU1cDEuvDFsUS5vbfBNB1JU9qTrdf0VfmoRjzC1GahVW8rlJzmOba/BsEt4iiMxUff
         v5M0Ez9jITKwVjBY5cxRagpe18Nu2VoeKh6Ws6Tvf9i3HxiKx86ItY8kne7Jfq73POd+
         1gR4kXsJABVqtnqo2jOYAe5ObMzpWbKl/dhwEjPmxFRX/7pj2A+svr0KBDPibLUnimaB
         b+OvRO64A+J/BmReXP5JrIrN9slQk+vjBFjss8qSjUP6EtjuhycMsxgV2YvuWEMEZF9J
         bGkvaG+gIEORJiBYKD9BwfLBw6rVzh09Jsxxj1MDorZ5oa7fyvhgr1VqexWyesaWWGdd
         ykhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791441; x=1705396241;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iSBtYdwkzNJEGVGY2jh4ufoDK8wyYf7JBua7/iNqHw=;
        b=tkvhrYjCBvvZRj3u7XDbS9Y5wBhRsciplkO+cbGFiHQp/jvtSqYQdQOElFxpYBGMKs
         x0E2TN2ALDcIua+2naPsmDM6BV5HvftPzEvVRqKZ00/wCAVFLBtDLz958jinIcArVFqE
         QVOhgqN3wz/Tr8YEDB3Mh42Wd2dOHwjRr/EwuYkmuLZH/46gcrtF7rnoXOa27h3oP3kI
         zQVXb+v8NIJjLjbnJaFPTdHcBQjchmKWntD3ptO0lxhPpwVI6cOpBwh7pXBegavOEZ/O
         5EAVDlMMo7O30CcCTHapB4A7c3D0zNtGNHWgpyChYAHy6KXKODVnvuOP95JdttNEMfKI
         N83g==
X-Gm-Message-State: AOJu0YyotLss7hkzO7f2/X7V0L/IJVqOqb/EVjs0VekhnSoAxt/El+pw
	2a7ILAqNmoZelw5/Ropi19BRHbTiL9IlKw==
X-Google-Smtp-Source: AGHT+IGm6PZjlHEKx2AHG4YPb1RHkDwxvlRtsHuJuqeE/n5nf5ahrdkTSBxpvPc3NaM3Lu/illGZWw==
X-Received: by 2002:a17:907:3e8f:b0:a23:57a1:d85b with SMTP id hs15-20020a1709073e8f00b00a2357a1d85bmr384401ejc.74.1704791441466;
        Tue, 09 Jan 2024 01:10:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id kq15-20020a170906abcf00b00a2b6a9e9c4csm218319ejb.113.2024.01.09.01.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 01:10:40 -0800 (PST)
Message-ID: <7cc4fa92-27cb-4b0d-8f1b-88091548bdb9@linaro.org>
Date: Tue, 9 Jan 2024 10:10:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] dt-bindings: net: snps,dwmac: per channel
 irq
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>,
 Leong Ching Swee <leong.ching.swee@intel.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Rohan G Thomas <rohan.g.thomas@intel.com>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-2-leong.ching.swee@intel.com>
 <ffiewfybqvh66nmri4im4veupwytvlxk5jfgdy3nbj6wldxjl2@2vwvnnu37pt7>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ffiewfybqvh66nmri4im4veupwytvlxk5jfgdy3nbj6wldxjl2@2vwvnnu37pt7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2024 21:10, Serge Semin wrote:
> On Fri, Jan 05, 2024 at 03:09:22PM +0800, Leong Ching Swee wrote:
>> From: Swee Leong Ching <leong.ching.swee@intel.com>
>>
>> Add dt-bindings for per channel irq.
>>
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
>> Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
>> ---
>>  .../devicetree/bindings/net/snps,dwmac.yaml   | 24 +++++++++++++------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index 5c2769dc689a..e72dded824f4 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -103,17 +103,27 @@ properties:
>>  
>>    interrupts:
>>      minItems: 1
>> -    items:
>> -      - description: Combined signal for various interrupt events
>> -      - description: The interrupt to manage the remote wake-up packet detection
>> -      - description: The interrupt that occurs when Rx exits the LPI state
>> +    maxItems: 19
>>  
>>    interrupt-names:
>>      minItems: 1
>> +    maxItems: 19
>>      items:
>> -      - const: macirq
>> -      - enum: [eth_wake_irq, eth_lpi]
>> -      - const: eth_lpi
>> +      oneOf:
>> +        - description: Combined signal for various interrupt events
>> +          const: macirq
>> +        - description: The interrupt to manage the remote wake-up packet detection
>> +          const: eth_wake_irq
>> +        - description: The interrupt that occurs when Rx exits the LPI state
>> +          const: eth_lpi
>> +        - description: DMA Tx per-channel interrupt
>> +          pattern: '^dma_tx[0-7]?$'
>> +        - description: DMA Rx per-channel interrupt
>> +          pattern: '^dma_rx[0-7]?$'
>> +
>> +    allOf:
>> +      - contains:
>> +          const: macirq
> 
> In order to restore the v1 discussion around this change, here is my
> comment copied from there:
> 
>> As Rob correctly noted it's also better to make sure that 'macirq' is placed first
>> in the array. So instead of the constraint above I guess the next one would
>> make sure both the array has 'macirq' name and it's the first item:
>>
>> allOf:
>>   - maxItems: 34
>>     items:
>>       - const: macirq
> 
> Leong said it didn't work:
> https://lore.kernel.org/netdev/CH0PR11MB54904615B45E521DE6B1A7B3CF61A@CH0PR11MB5490.namprd11.prod.outlook.com/
> 
> Rob, Krzysztof, Conor could you please clarify whether this change is ok the
> way it is or it would be better to preserve the stricter constraint
> and fix the DT-schema validation tool somehow?

First of all this change is not good, because commit msg explains
absolutely nothing why this is done and what exactly you want to achieve
here. The "what" part often is obvious from the code, but not in this
case. Are the per-channel IRQs conflicting with macirq or others? Are
they complementary (maxItems: 19 suggests that, though, but could be
mistake as well)? Do they affect all snps,dwmac derivatives or only some?

So many questions and zero answers in one liner commit msg!

Now about the problem, I think we should preserve the order, assuming
that these are complementary so first three must be defined. This
however could be done in the device schema referencing snps,dwmac. I
think I will repeat myself: I dislike this schema, because it mixes two
purposes: defining shared part and defining final device part. The code
in this patch is fine for a schema defining the shared part.

Therefore before we start growing this monstrosity into bigger one, I
think we should go back to the plans of reworking and cleaning it.

Best regards,
Krzysztof


