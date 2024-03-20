Return-Path: <linux-kernel+bounces-108720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A31880F20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47661F232A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921A3C08F;
	Wed, 20 Mar 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKdlWy+k"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1B3BB4B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928420; cv=none; b=uQKdmj+pz4OBd8J2QgfBrt44ZEuiC5gnWJFUgMfx4DBdl5fdqVDg6dhbkglr0n2HBVCYyIBqXJU97A8523QSSSRZ+uAJElKJeB7I7gq0AO90uLztXZeg0fZ13oDJ3scYCVvk/lCGIiJX6NS1Ru36t4Dcr38BQsJ7Lqr4oB6xI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928420; c=relaxed/simple;
	bh=+2evvTDzBtO0FQrhJwAEK+MwwS9Fr0eaFZ9PKdLg2GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnrwwiBsboRWnBVdqNClGqE/zqNHr08nqkNp9B2j5OytFCmglZsLsDnlqH1TQS+E51uhc+McX5hq14lHvRr/zeRxoB/zaCwSzCt8fUTT8gxvQa2KfoV8GiMdNvziY37NqS9DMmFDkXtKGDNSehwMvIrznDkrjcjthlf314zcFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qKdlWy+k; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46dec5d00cso208927466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710928417; x=1711533217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U6nKbWZtEY3hm9Ix57M5ktBJRk5n32E70+Auc1guwak=;
        b=qKdlWy+kjTivB6Ns0OtXMLigNoDHrlkr4OsvfRqfujsiKmEXyVNs4ODzCpHPZ/LSeB
         cBukqbwS7M5B8nt0rNxXYwYeGDXw/6wpVbRMFMTJZWc8JNfJisWLtyHkqNGa0YNLgcQG
         SIqfoqQ6G5xEC5MOYlrz834RYFtrbJkNacBBydMPvb0QEHDnizWuNG+5XxUJi0SIeGd2
         mHUhn9wAp9dfF96z2ilt0kkXuZ5XV6WDYZ9gFZIq2Aseg5rsg9xtI9qb9LqZrGUwmaRG
         Wk2UBvSiWEZ0GbniPY7QkenlK3Svl+ucPf5pzPVhv06EUCHTFeem/Jv6DE0RK2DzBdB7
         3+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710928417; x=1711533217;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6nKbWZtEY3hm9Ix57M5ktBJRk5n32E70+Auc1guwak=;
        b=K4IR+dMvy0RPCQ/oVKwyLgJ9fxQwRG4BssYifqXtL8bB5GPDM6Tw2mlENM0FAIki92
         n23RT27v1DpO+CcZvNH/nd2WA7V4451edefE6VIn1KKLTgCXG1BZfD1RCwZ+DIisfSR/
         gHX+VlgLPbMJqLADGJheraKMXL1/0hz4HcrUdfGVYXBuYEOWHoVSCuGeHDqXqKo8+GNS
         UbxGbOjGxUq/RS+Kiqo0RsVLWKGm/SjwZLATSEFSTajKluH3WK0XfjuiX5G/q5CHwr3G
         g7Ud+WEi9r0FPO6/Bh0sV49laDs8V9UvkfSDkF6MHgWlVOLH3obYaVNo9WS2KNVW9NqO
         J9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCViSm3snXnUHWUfVq9HWwkRdl0c8wU5/N2lkYZrx9kT9DQbsoEKVDODRuws2QbkvnEaaA1d0nXbrzTsSzX39fuaqfzjxb9rX7R8d/84
X-Gm-Message-State: AOJu0YzCxveuWSoZs271X2c+Xi4zGkfI1Qy2FE5yEcLXxqKTuUn0AolA
	bvHfwK0W+KsIeTwSpJyqzOvnpstnG/CGAW616snoich3Y0YNxLYLav/CLG3bN+w=
X-Google-Smtp-Source: AGHT+IEvZ7bKKZ0/iwfAzolxQqj/F77oORXiD8num18ctkbp/mJOuZ50pDC3j1fvLJ9CMbvDUo4yqg==
X-Received: by 2002:a17:906:199b:b0:a46:c8e3:c9b9 with SMTP id g27-20020a170906199b00b00a46c8e3c9b9mr4819322ejd.42.1710928417155;
        Wed, 20 Mar 2024 02:53:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ww2-20020a170907084200b00a46cc48ab07sm2803850ejb.221.2024.03.20.02.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:53:36 -0700 (PDT)
Message-ID: <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
Date: Wed, 20 Mar 2024 10:53:33 +0100
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/2024 09:40, Parthiban.Veerasooran@microchip.com wrote:
> Hi Conor & Andrew,
> 
> Please find my reply below by consolidating other two emails comments 
> related to this.
> 
> On 07/03/24 12:31 am, Conor Dooley wrote:
>> On Wed, Mar 06, 2024 at 07:48:57PM +0100, Andrew Lunn wrote:
>>>>> +description:
>>>>> +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
>>>>> +  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
>>>>> +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
>>>>> +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
>>>>> +  integrated into the LAN8650/1. The communication between the Host and
>>>>> +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
>>>>> +  Interface (TC6).
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: ethernet-controller.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    oneOf:
>>>>> +      - items:
>>>>> +          - const: microchip,lan8650
>>>>> +          - const: microchip,lan8651
>>>> The order here is wrong, lan8561 needs to come before the fallback of
>>>> lan8650.
>>> I don't think it is a fallback. There are two devices, and hence two
>>> different compatibles. So i suspect the -items: is wrong here?
>> It'd just be a two entry enum then, but I did take a quick look at the
>> driver earlier and saw:
>> +static const struct of_device_id lan865x_dt_ids[] = {
>> +	{ .compatible = "microchip,lan8650" },
>> +	{ .compatible = "microchip,lan8651" },
>> +	{ /* Sentinel */ }
>> +};
>>
>> That, along with no other of_device_is_compatible() type operations
>> made me think that having a fallback actually was suitable.
>>
>> You cropped it out, but the patch had:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - const: microchip,lan8650
>>> +          - const: microchip,lan8651
>>> +      - enum:
>>> +          - microchip,lan8650
>> So it doesn't appear to be an accidental items in place of an enum,
>> since the other compatible is in another enum.
> As per Andrew's comment in another email, both LAN8650 and LAN8651 are 
> two different variants but they both share almost all characteristics 
> except one thing that is LAN8651 has "Single 3.3V supply with integrated 
> 1.8V regulator" which doesn't have anything to do with driver. That's 

So why this is not reflected in your driver? Why didn't you address that
part, but ignored?

> why I have kept them as fallback as Conor said in this email. Hope you 
> all OK with this.

Did you read the feedback? Your response is not solving here anything.
How 8650 can be used twice? Please point me to DTS showing both usages.

Best regards,
Krzysztof


