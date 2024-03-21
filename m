Return-Path: <linux-kernel+bounces-109800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C588855E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EB31F21E21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831181D6AA;
	Thu, 21 Mar 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnCLmwmV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B161426D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010408; cv=none; b=ZbrXdLI8jK0CRhzkkD6+lSm2p0BqByY8i7DE6FlsKzvNpvXMFRa7enFIy34tbT2IcFRtle1RGbLn9G0HjSjI2e5vf0Dzz7vaRuhk8fjY3ar3AW45v16R/+6fLUBmrX++r5jquxngV/zeRiL696DubgHUSTZpcyUmCd+NAJPRuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010408; c=relaxed/simple;
	bh=oRd+yM7ZzeNrMBRK5K8UEgWAj0LhRJwmY+bwbTNGQps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlXxJs0aG+dV0tqU7bXoeh7jf3hnOJGFEzPFuvnDXZ8rKPlQQO8Ev7VkWlf5+/+5ZRGbETNbNwhfTMHlpTqNayqTGBwgEU7L3+9WHfcidOI1ilU7JCLHhy/CvreNnSpPb3QISeTV+s9mT5rcCluc4u4AKudoPbvjJ2sFjpGAZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnCLmwmV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso731837a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711010405; x=1711615205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZmS4x8JWAHXoDT8/RhY2F7SBv6SO4D4gWDtaTnP6xI=;
        b=tnCLmwmVbQ2FOxhKPVLI37fLUHsAV/9MwuxXLsDClBH8s2GskUeb9/wqJ/jDiUuGOq
         IDlrfCjIiwrvjETAPZ2aFqxkfQnW6W9/qfV8aUYM1L9yuUZei4IVBoZkY4+RVEuid587
         sMuVdqIL5f8VeNGmMK32AQ39QhpfYLKfYoN4qQsU1+neRDGCxy26xd8egCFSERrp0OXc
         QIA1OXXKdraNJQAo+2eDGvR23Pxudp7PtO29B7YwhhPwURVeAnMAWMu7ejIIiTte+xYc
         /n/kdEKOMcPe9/8NA/2Lpa+JcePgOGBKP5596q9JPFoBPIouUJCK0pN/oV4W7hG1oFDS
         u3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711010405; x=1711615205;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZmS4x8JWAHXoDT8/RhY2F7SBv6SO4D4gWDtaTnP6xI=;
        b=cOEnfVh6lrSjqEnhydr14l3NrATSG792B/jn6Q7GCvnp643T7RJSqvuL3CYfMIsNK0
         9B7K3QNC/8omxzYowz/nTQZ87rQ1lGF+Svmxw06gvb0TBEiZZdKerBEAWcTm6eFGODwb
         d5ZCPzBkYRKI1fX8Jl9UmGw0Suq71k+iTJc0roV/4epSfmi/YG2GalVR5aMLmgP1rtVp
         a35zRAXgFtYgyzSB0GZ8tRRhvMJQz57WrEssZsYOsK06VtXWvDCzHmNG5szn4bEsu1iZ
         vkz3MgWp2NYy5bZCAciCDyCvh/OYGFzRIh1VKT+HEVBvqZEpJF1nWKozahmhhacdfp7k
         zfDA==
X-Forwarded-Encrypted: i=1; AJvYcCXB2aq5hvzv7h1dzeAW6ZmvB/OaUH732snPhK/DwN+TW79tTouuqbS3PKmGQ1lIHZyYIF9Kw/SE+8CM1FpYTypquM7nNoJ8N1DgEEnK
X-Gm-Message-State: AOJu0Yy8j4ltalPur8X8S2R950bT61LTJb/xkdWRR0KOFvqjQ+Dv6oAD
	BbRX0+IYXZa9XO8v2wSB7RjylUx7LiPjyq+YM4yxk8TtzbkX51tKXguATl4K6ng=
X-Google-Smtp-Source: AGHT+IGWsWDqP4bU6S67h6uto6SYqxREt3sKUyPaVbmgH1DOJ9Mxa9sxchyD4SniyP9lz2gR7hoqwQ==
X-Received: by 2002:a05:6402:2421:b0:566:f5d6:4b4 with SMTP id t33-20020a056402242100b00566f5d604b4mr5809365eda.12.1711010404783;
        Thu, 21 Mar 2024 01:40:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cf13-20020a0564020b8d00b00569731a1eb2sm4432406edb.46.2024.03.21.01.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:40:04 -0700 (PDT)
Message-ID: <96493beb-afbf-42f2-88f0-ad645422ecdb@linaro.org>
Date: Thu, 21 Mar 2024 09:40:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
To: Parthiban.Veerasooran@microchip.com, conor@kernel.org, andrew@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
 ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
 vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
 Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
 Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
 benjamin.bigler@bernformulastudent.ch
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
 <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
 <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
 <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/03/2024 09:38, Parthiban.Veerasooran@microchip.com wrote:
> Hi Krzysztof,
> 
> On 20/03/24 3:23 pm, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 20/03/2024 09:40, Parthiban.Veerasooran@microchip.com wrote:
>>> Hi Conor & Andrew,
>>>
>>> Please find my reply below by consolidating other two emails comments
>>> related to this.
>>>
>>> On 07/03/24 12:31 am, Conor Dooley wrote:
>>>> On Wed, Mar 06, 2024 at 07:48:57PM +0100, Andrew Lunn wrote:
>>>>>>> +description:
>>>>>>> +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
>>>>>>> +  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
>>>>>>> +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
>>>>>>> +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
>>>>>>> +  integrated into the LAN8650/1. The communication between the Host and
>>>>>>> +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
>>>>>>> +  Interface (TC6).
>>>>>>> +
>>>>>>> +allOf:
>>>>>>> +  - $ref: ethernet-controller.yaml#
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    oneOf:
>>>>>>> +      - items:
>>>>>>> +          - const: microchip,lan8650
>>>>>>> +          - const: microchip,lan8651
>>>>>> The order here is wrong, lan8561 needs to come before the fallback of
>>>>>> lan8650.
>>>>> I don't think it is a fallback. There are two devices, and hence two
>>>>> different compatibles. So i suspect the -items: is wrong here?
>>>> It'd just be a two entry enum then, but I did take a quick look at the
>>>> driver earlier and saw:
>>>> +static const struct of_device_id lan865x_dt_ids[] = {
>>>> +    { .compatible = "microchip,lan8650" },
>>>> +    { .compatible = "microchip,lan8651" },
>>>> +    { /* Sentinel */ }
>>>> +};
>>>>
>>>> That, along with no other of_device_is_compatible() type operations
>>>> made me think that having a fallback actually was suitable.
>>>>
>>>> You cropped it out, but the patch had:
>>>>> +  compatible:
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - const: microchip,lan8650
>>>>> +          - const: microchip,lan8651
>>>>> +      - enum:
>>>>> +          - microchip,lan8650
>>>> So it doesn't appear to be an accidental items in place of an enum,
>>>> since the other compatible is in another enum.
>>> As per Andrew's comment in another email, both LAN8650 and LAN8651 are
>>> two different variants but they both share almost all characteristics
>>> except one thing that is LAN8651 has "Single 3.3V supply with integrated
>>> 1.8V regulator" which doesn't have anything to do with driver. That's
>>
>> So why this is not reflected in your driver? Why didn't you address that
>> part, but ignored?
> No, it is not ignored. This difference is specific to hardware and there 
> is no configuration/setting to be done from driver.
>>
>>> why I have kept them as fallback as Conor said in this email. Hope you
>>> all OK with this.
>>
>> Did you read the feedback? Your response is not solving here anything.
>> How 8650 can be used twice? Please point me to DTS showing both usages.
> May be I have a misunderstanding here. Let's clarify it.
> 
> LAN8650 and LAN8651 both are two different variants but both implements 
> same functionality. The only difference is LAN8651 has "Single 3.3V 
> supply with integrated" where LAN8650 doesn't have this. This is 
> hardware specific difference and there is no configuration/setting to be 
> done in the driver specific to this difference in the LAN8651. So 
> basically the driver can support for both variants without any 
> additional settings.
> 
> LAN8650: https://www.microchip.com/en-us/product/lan8650
> LAN8651: https://www.microchip.com/en-us/product/lan8651
> 
> The below link shows the difference between them,
> https://www.microchip.com/en-us/product-comparison.lan8650.lan8651
> 
> With the above details, I would change the microchip,lan865x.yaml with 
> the below details.
> 
> compatible:
>    enum:
>      - microchip,lan8650
>      - microchip,lan8651
> 
> And in the lan865x.c, I would remove the below line because
> .compatible = "microchip,lan8650" already supports for LAN8651 as well.
> 
> .compatible = "microchip,lan8651"
> 
> Let me know your opinion on this proposal? or do you have any 
> misunderstanding here?

It's still wrong. Upstream your DTS and then test it. You will
immediately see that it does not work. So first make it working, then
send code to review.

Best regards,
Krzysztof


