Return-Path: <linux-kernel+bounces-96593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0652875EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4827D1F235E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A644F5FE;
	Fri,  8 Mar 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAZjVQvt"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A54F1F1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883568; cv=none; b=jqd4+PzpQve+9FVNsJr0ihh+WVWj14/JiRGjGaTzGP9dNrtjWFB+az5LpA6lcjXOLCkDGuSuKdXzJ/RU8k5vbZpPVtVrlBG7nCMHm+7scWElUxC5Xqa/KQRoNcdcXuHSNz5CjeE7Ubn+wh3VROopSl92Y3AUph0T7BCzkfHe1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883568; c=relaxed/simple;
	bh=beAe8VV4nx6fMMsN/VSmkXfGmdSWfTMjc5gpEu69w2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwyyZy12iZo0TBsYbMv3chp3ugDXPxvOCpISKromgpSAkgKYyCAavmaC/zo38BVI1JgyKad0Y3XKeY6FokAMvVoROsgJjsTcgNWutYHdE/qgQ1XM2KsM/CuqJwfUzSK+f6vBecDsx+Ru6BnWoExFshU4hTIWnhUgP2TSInet81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xAZjVQvt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso56393066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709883564; x=1710488364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfe/hV+Rb5o9a+XFpxwa7AcGfaflt1m8Wn542eQ+zSo=;
        b=xAZjVQvtNjnZxisVA9bkHELxlqA4on26dz0aYN+JdydUdNE8LY/NRVw9Q8BoCWK/VP
         8ynMpo6YI3hrGbO2+6iMShDel69ldGtMqBNUDbn4z4TxJzxFrN6Dxeq92tQcwgEiOzkR
         Ct+J9icgTWe91C0+VcZ9PHgFzN2nVWUdi7cF/wFil9pnELVPuuQ3HU+N0/4xEv3s1DAT
         N7PE+tWjw1hnRvJEPZAA8TCU41FI6B4DAuXrKYdSeD3lYfwRzHy+uWJEVD8ZHCpSJ/B7
         D6yrJODh0bnZeVw/DDyVnvwYJCBtmxINox33piiPRtxaG0jgZh61J+Py2AspnvBCjW7z
         aiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709883564; x=1710488364;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfe/hV+Rb5o9a+XFpxwa7AcGfaflt1m8Wn542eQ+zSo=;
        b=L+5iTGiltRTg918B8exL5cFewyJJshpdl5yJa/uKBkwzzQMTkd24vqReSgMPcQN1PG
         RedJBzyqLy5NvvLSYGLm8ycygufieb3+ANpDYXaWQftRbwa3j/0B5xjMC7MGv0IpGYEx
         bt3FctYdsWgxntDvXLbXJsWfp3mp20bN/GQQADKDuXIjfWA50RvJGQttYu8INpwVb3LL
         XA7e1zPIs+a2k43R4bC0bsjfzQDdZDeUh1wbeylFZ6VuS8mS3BA18IfvFJRTfcfRJmET
         X84HuVWYn3KUfPflVygV9Db/+N38noqsJkprvMFKCs7vEenmxsJx8hBaXsJeyl/MCDmk
         hc1w==
X-Forwarded-Encrypted: i=1; AJvYcCX/UexNVCLzM/hFrGKj0RDEsUiwHVOAWpAfbsC4bprAIz1Z3D+44e97ckumbN3yWWccr9IuAsunBZZGqRqqHSuSBaDHXoaOpykh378Q
X-Gm-Message-State: AOJu0Yxsr55W25zdh1ORSUk23czIWlalP2md+Q0SjvF/1LJzPe4EXIba
	+6Yg0i4L8fY0PcFVkBTH0ilD7V0ssRC2UpaPki/1vlP2lNVB28rj3b3xEQAGN4k=
X-Google-Smtp-Source: AGHT+IHBxhqqXXnLefHVKg5W5tjUWeZ/hVczSWvDPynV6/Q9HcavmOXC3PTE3KpC4xhTwoxQxqIonA==
X-Received: by 2002:a17:907:a093:b0:a45:f215:ce89 with SMTP id hu19-20020a170907a09300b00a45f215ce89mr390704ejc.6.1709883564004;
        Thu, 07 Mar 2024 23:39:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906288700b00a42ed7421b8sm9133569ejd.93.2024.03.07.23.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 23:39:23 -0800 (PST)
Message-ID: <28f260a7-d4a1-48b6-8387-af134b9a600d@linaro.org>
Date: Fri, 8 Mar 2024 08:39:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: dts: ralink: mt7621: add cell count properties to
 usb0
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240306202131.2009-1-justin.swartz@risingedge.co.za>
 <73e7a642-d993-485f-9ccc-abe3daf79390@linaro.org>
 <48fd88f29482fc1b94439727b2d2484f@risingedge.co.za>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <48fd88f29482fc1b94439727b2d2484f@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 15:58, Justin Swartz wrote:
> Hi Krzysztof
> 
> On 2024-03-07 10:01, Krzysztof Kozlowski wrote:
>> On 06/03/2024 21:21, Justin Swartz wrote:
>>> Add default #address-cells and #size-cells properties to usb0,
>>> suitable for hubs and devices without explicitly declared
>>> interface nodes, as:
>>>
>>>   "#address-cells":
>>>     description: should be 1 for hub nodes with device nodes,
>>>       should be 2 for device nodes with interface nodes.
>>>     enum: [1, 2]
>>>
>>>   "#size-cells":
>>>     const: 0
>>>
>>> -- from Documentation/devicetree/bindings/usb/usb-device.yaml
>>>
>>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>>> ---
>>>  arch/mips/boot/dts/ralink/mt7621.dtsi | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi 
>>> b/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> index 2069249c8..f02965db1 100644
>>> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
>>> @@ -309,6 +309,9 @@ usb: usb@1e1c0000 {
>>>
>>>  		interrupt-parent = <&gic>;
>>>  		interrupts = <GIC_SHARED 22 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>
>> Doesn't this bring new W=1 warnings?
> 
> For a fresh build (make O=build clean; make O=build W=1): I do not 

make dtbs W=1 is enough

> receive any warnings regarding mt7621.dtsi or my board's .dts file. I 

I meant for other boards due to unnecessary address/size cells, but if
you checked it is fine.

Best regards,
Krzysztof


