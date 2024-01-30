Return-Path: <linux-kernel+bounces-45070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA99842B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8F91C25951
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610F14E2D1;
	Tue, 30 Jan 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQVZcKZO"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308F151CDC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637545; cv=none; b=eJd2wNQprJ5pTe7HKR06PAx26s9uWihN8I120oKaWxJW457305erClcH3fGHUuPI9+Yg6cL9myb7AgGzz9jewBm0APZQkPkO6E0QUIS5luP1gtyjvxNcoD/sykRrtd14Gb+tzklXNQQQfdKARUyi2grugTC1CgDnTAQ68MfgL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637545; c=relaxed/simple;
	bh=mNdeMPp9kt0FWgQWSFLBY7gbjxsw83wvcE3qv+u0rTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVL0phPxiU4iXUmW74UX8eQWVO0d2k4kaHcZtlXKMHnAYBuA6oNhYsoLpJEY64clNknGrGSc0877nrpR31v5vdU2vm1NP0oWO4ht0jCUirFYzSeEW38dv+75Xjk5ikKWyAO7y+CIuMwlLjZhxrR2hxiPrJyWabvYNxKLLsfTpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQVZcKZO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a35b32bd055so302598866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706637542; x=1707242342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgHUTX9LXYroMHHIZUCA3xA7OBCQHGBSeN9sd6vR7D4=;
        b=FQVZcKZO5GMwApAhBRWUhNRVSAf5AB0eJVjrcZ4uQLNXz+XJyu+Vivul7TiZFmAGXP
         ML2U3TFhqDynTlWfr6c7nczje98tVLK7L/YgYmSgCwGg8RnNnOl9bsg7KXbg0qBdhR4A
         RkVOnAjpgVZNH4bd9+RcL+fITYK7pRMnel9BUaRwlZEwwRKBTIN/sj5kICZptX1GXMKK
         GfD6dkbLpFwLlQ8V460DFVmoAiBc+/Guqp1ZEF4aFRZ5ZbTaHx1DD0WV63jFmZDnU4u/
         pK/n48or6KGW+C8HsoAdRWKq62jDjpVEucdH9sv42DtE0eewFfxyLPayN5wGXvoA0uBd
         tJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706637542; x=1707242342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgHUTX9LXYroMHHIZUCA3xA7OBCQHGBSeN9sd6vR7D4=;
        b=IVS8inE+dZf694F0lt6zHw9Y4/ot+MI1W1nRGqgCra2qCUmXTnNkdkvHBeqnmPdNsZ
         MtSkEd2rTfAWwTxZ6ndKzBXFRNgrvHATn8sl3rbfJ/WoZ2skZsDB5vsej8VAvEdqka2a
         +Q/DhUsTX/OxYoCOqhG1xW7aKCrYO/blylpTRFQ1fmOqPggC1qdY+Vki6B/lQThEUIRT
         gHP8UkUZzDyBK+UDDpowwDwiOp3dQfNfle+LviSclebRPQzT+s77JG8FHIAWZ50mDSkH
         lYhZDV3gnsPeQbMgqu4Mbt4Wr3gLPh47YTimJSdsFuGDQFSM2r1Leijiy8eS8s0d2612
         vuKA==
X-Gm-Message-State: AOJu0YyxJwVczjxVym0bhc5ZYt5K7jrKQtorBIFfqCBtdQZPOZIzc5fC
	sHzVtBTo7kiboEDRRthVbLIRcU4GGu3NTdGAXmnMuB2jHJ97URSxLowPWVn1cmg=
X-Google-Smtp-Source: AGHT+IFLUyc9y1/Y4zvFDyN1V15Aika6ikOb9XCFTyk5KE8S/3hCdbma6UfACb3seMs+6B8aHwXvqQ==
X-Received: by 2002:a17:906:34ca:b0:a35:9cf0:56d9 with SMTP id h10-20020a17090634ca00b00a359cf056d9mr5374596ejb.70.1706637542185;
        Tue, 30 Jan 2024 09:59:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU7upOCq2IQkNWCJzJREgFQGpJRAjj1co/EKnZ4J8n6L3pSa7Gur57T69Rs5tzNk3/zC/FIp5ur1ys3RpdaBS51d1jJbfeiEPG6n5TBMOnS5CjFJspLheO/YHysBxa/RND4tBuWtxyg8luT4oxqdVmke8ryDunCGm4CKV+BpeJBDmslDx3griEV+Q8MD+1B0vqkz46nrDLWinplWJeXwBfNyut1314UCVnOyyybs2cQwy6G+UK1FHSWaIfX9WtBpzoXUYosMvqb1UF0GTndL9Qz7L6PDYHomDpk714kw2TLFnitssW5m1luzMue/xTC50XdhchQ4ZkCvEF2ggs9ZP4D9fyK0YGLvHwnljGYQGsFfPdA
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vh5-20020a170907d38500b00a3517d26918sm4798338ejc.107.2024.01.30.09.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:59:01 -0800 (PST)
Message-ID: <cee1ca11-03bf-4a0b-9ff3-490457f9fbe8@linaro.org>
Date: Tue, 30 Jan 2024 18:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT
 schema
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf <mdf@kernel.org>, hao wu <hao.wu@intel.com>,
 yilun xu <yilun.xu@intel.com>, trix <trix@redhat.com>,
 krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>,
 Brian CODY <bcody@markem-imaje.com>,
 Allen VANDIVER <avandiver@markem-imaje.com>,
 linux-fpga <linux-fpga@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
 <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org>
 <1489222458.382780.1706629544559.JavaMail.zimbra@savoirfairelinux.com>
 <32669bc7-90b5-48d9-8845-2e072a477c6e@linaro.org>
 <154341320.386005.1706634341891.JavaMail.zimbra@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <154341320.386005.1706634341891.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/01/2024 18:05, Charles Perry wrote:
> 
> 
> ----- On Jan 30, 2024, at 11:05 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:
> 
>> On 30/01/2024 16:45, Charles Perry wrote:
>>>
>>>>> +
>>>>> +  reg:
>>>>> +    description:
>>>>> +      At least 1 byte of memory mapped IO
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  prog_b-gpios:
>>>>
>>>>
>>>> No underscores in names.
>>>>
>>>
>>> This is heavily based on "xlnx,fpga-slave-serial.yaml" which uses an underscore.
>>> I can use a dash instead but that would make things inconsistent across the two
>>> schemas.
>>
>> Inconsistency is not a problem. Duplicating technical debt is.
>>
>>>
>>>>
>>>>> +    description:
>>>>> +      config pin (referred to as PROGRAM_B in the manual)
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  done-gpios:
>>>>> +    description:
>>>>> +      config status pin (referred to as DONE in the manual)
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  init-b-gpios:
>>>>
>>>> Is there init-a? Open other bindings and look how these are called there.
>>>>
>>>
>>> No, the "-b" is there to denote that the signal is active low. I think its
>>> shorthand
>>> for "bar" which is the overline (‾) that electronic engineer put on top of the
>>> name of the
>>> signal on schematics. It comes from the datasheet.
>>
>> Then just "init-gpios"
>>
>> ...
>>
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - prog_b-gpios
>>>>> +  - done-gpios
>>>>> +  - init-b-gpios
>>>>> +
>>>>> +additionalProperties: true
>>>>
>>>> Nope, this cannot bue true.
>>>>
>>>
>>> Ok, I'll put this to false but I'm not quite sure I understand the implications.
>>>
>>> My reasoning behind assigning this to true was that the FPGA is an external
>>> device on a bus that needs to be configured by a bus controller. The bus
>>> controller
>>> would be the parent of the fpga DT node and the later would contain properties
>>> parsed by the bus controller driver.
>>
>> Which bus controller? MMIO bus does not parse children properties.
>> Anyway, if that's the case you miss $ref to respective
>> peripheral-props.yaml matching your bus and then "unevaluatedProperties:
>> false".
> 
> This one: https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/devicetree/bindings/bus/imx-weim.txt#L56

Eh, ok, so after fast check WEIM looks like some memory interface bus,
so the bus bindings should be moved to memory-controllers and converted
to YAML. Then you add child node properties to own schema and reference
in mc-peripheral-props, which is then referenced in your binding here,
as I mentioned.

Best regards,
Krzysztof


