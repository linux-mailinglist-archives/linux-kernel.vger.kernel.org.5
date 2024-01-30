Return-Path: <linux-kernel+bounces-44904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84448428E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A821F2ACC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62586AEC;
	Tue, 30 Jan 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wE/FUbNs"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6A86AC4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631062; cv=none; b=ursscGWzLU8rhjT1l5gt1ghGSiYLj/RvE2MowHrw25JYVkto3onuQhmrYt3QWztPzYTh44JlzEGn78AK3BpU4Drt4bf/IOJVwSYSs7fa21cCDtlcBQ+BgwrSIr+Mns0CfgQIapOg+2JaqU79fAzf7BE+4ao+10oNIOZZpOxVlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631062; c=relaxed/simple;
	bh=wRljHE2pZ+ep4eMof6Z6X0vRFpo3T1p5viDZXmFxtoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNoA6+ys8iJ8XPM4EqEh6WO/3TJzF+b9G92S20goqZ2wfQ1zP2kK+S9qE5yhFT2BCqo91JV/tTBhaKYoLvcRbjws+nv11zVz98ak6X6DEOg3uTcKpppQIb95SsKGQDrgSHJC60TmlDkmQjXNgBBZ+Kj6Nsdr3Qe1Qhd4kCQjSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wE/FUbNs; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42aa241b91aso30981971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706631059; x=1707235859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viLQtYhLxehILVWbYe+GBELnC8EiNzdA8isvJy5WVX0=;
        b=wE/FUbNsgujYVWfs0uaZ7cHA2bxbssvG5PZJNmXMLptyAKAFVdECyQQWfveyDEaktv
         D1cxUiRnQzvmBiClGmDaWC3vk5q1QFi9HuI0Xq8AlWHLLb5V0VDXQGWuuGf1SinA4ypw
         vSycXlT5QxTqVdc7P520SMCLoH7Iahgye+x3B51wPDtHcHLDFHFBbzpWnBaMpHUXsgJ0
         rYr4+pQzydVHojU4k4RGQj1lIoIJjErXStWczk5Ba06yl+ycWZYTH6u51ZryTmjGr6q1
         J5OOaO/kHr3eTJsCyrSBZniwS3hJpqaJCPLZG6A6C8OeOckkF4JHDIXFyH+qI7UieXFO
         scTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631059; x=1707235859;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viLQtYhLxehILVWbYe+GBELnC8EiNzdA8isvJy5WVX0=;
        b=WmiEs6c42egppmGnTudCq5VT5baz/XhSVop/GFlSCy/hhFZUX78aVNx7PgVbcbW0Hz
         27FkXC8kTge+k/MLxHTSTWBlQagBMI2VcV2OnEe1z0EgkTiXpPCG3Jv0Nnz0qGCl5t+x
         v4hwD8wcxJAIEUg8lXUSE+ifrlc22EIifweejXogk5dKM5D1VxvXcv/aVXXL/zTqbnpR
         RMYc3xk87dQ/SbiWAgFx5D8nOWUcC79HUgWiTrdHb1EZ99HfZ6Oyvlxxxv9wTzHuWqGN
         /BEf9bxnbtPQMELW7uwBrRLs3BupdDu5GIgtjj3ib5ADGR6ll48VBjYbXMVNfIKkOHoF
         hr5g==
X-Gm-Message-State: AOJu0YwbReX19yj5emkPuxZ2f/5PMJNF4Tq9i+wwjdCjmfDeW2a30WpF
	HZgdaT5g5KHSybOSOipPawE/OZigxoC1XQtFxPKcUCK0/ba/jNUx0O1uk2VIC1s=
X-Google-Smtp-Source: AGHT+IGP8Lyjn/kABeubZG7nOekQSy2JVYh2q+AoAHshfT1YLLPbVFWQgwm9iq9AEJlCTKQhYLTh4Q==
X-Received: by 2002:a05:6214:da1:b0:684:d760:cf7e with SMTP id h1-20020a0562140da100b00684d760cf7emr10535851qvh.26.1706631059278;
        Tue, 30 Jan 2024 08:10:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUznT0DUPhnSaF0lJuYXRFbJMEB87ECuDYfOGEdzcP2NUPUG6C3I9SbURWBtFsN4ynJkNmPz4zzwiSpOt1OgOIGq8s6gWoxEv4vcKcrPF7EFDrmvTrz5VbiRCgGxz+qxGNWdbsRsl7rojYY/eUhxZIVipgBjaCLuhKtgRzXre+47wbGtY+D3ceL/TKIBByxzhom5T2Y/wv3wr0lVgD+stlz5HAgZewGgTmmtOEQxeQp2MaCSj2sR4iROUDYm8vyK2ooRnw/FlHi1SO8X1jmxhJeCt/rWYQwmY3m125KZKuMJURaTWSZSUiACyOy2lUu86RT6CftPSaYDiYBsPBMR71WtIgvqq5u3Ev909Q7EzvTHcla2Pp76IX/7Jg+hfAnDWc1fK3Y5/YHDSz1g9jiYNKEu9bhMs+CtKUYAKrYe0GJFYU0V4W8QKCZaqt2F/BgZIekdY8F8L+tUYcc8BKDoW+csuD8Wvx5nwGXTuqzHWhOBYeQ21BrDRVruY9PhnmL
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id qp7-20020a056214598700b0068c39b7a7cfsm3845337qvb.12.2024.01.30.08.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:10:58 -0800 (PST)
Message-ID: <0be231a2-0c3d-4f18-8de2-3e4f1fe1cd29@linaro.org>
Date: Tue, 30 Jan 2024 17:10:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, thinh.nguyen@synopsys.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 balbi@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mark.rutland@arm.com, mathias.nyman@intel.com,
 pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
References: <20240123-anew-lilly-0d645bdbfb30@spud>
 <Za//LX9U6QG5A5NW@lizhi-Precision-Tower-5810>
 <20240123-nanometer-atlantic-6465b270043a@spud>
 <ZbAR/NQvjUnf2At+@lizhi-Precision-Tower-5810>
 <46781012-2678-4f6c-9aee-b020cabcbb28@linaro.org>
 <ZbA8ea9Ex+hMdDDZ@lizhi-Precision-Tower-5810>
 <ZbfB/KT+fzO/F2e5@lizhi-Precision-Tower-5810>
 <20240129-encode-catchable-f5712d561a47@spud>
 <ZbfjZoHiH7BsKyzl@lizhi-Precision-Tower-5810>
 <f3811c1f-eff2-4c7b-8cea-6d3115525235@linaro.org>
 <ZbkTvu0Q85zyieXr@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZbkTvu0Q85zyieXr@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 16:20, Frank Li wrote:
> On Tue, Jan 30, 2024 at 08:40:29AM +0100, Krzysztof Kozlowski wrote:
>> On 29/01/2024 18:41, Frank Li wrote:
>>> On Mon, Jan 29, 2024 at 04:49:21PM +0000, Conor Dooley wrote:
>>>> On Mon, Jan 29, 2024 at 10:19:24AM -0500, Frank Li wrote:
>>>>> On Tue, Jan 23, 2024 at 05:23:53PM -0500, Frank Li wrote:
>>>>>> On Tue, Jan 23, 2024 at 10:46:39PM +0100, Krzysztof Kozlowski wrote:
>>>>>>> On 23/01/2024 20:22, Frank Li wrote:
>>>>>>>> On Tue, Jan 23, 2024 at 06:42:27PM +0000, Conor Dooley wrote:
>>>>>>>>> On Tue, Jan 23, 2024 at 01:02:21PM -0500, Frank Li wrote:
>>>>>>>>>> On Tue, Jan 23, 2024 at 05:51:48PM +0000, Conor Dooley wrote:
>>>>>>>>>>> On Tue, Jan 23, 2024 at 12:49:27PM -0500, Frank Li wrote:
>>>>>>>>>>>> On Tue, Jan 23, 2024 at 05:27:13PM +0000, Conor Dooley wrote:
>>>>>>>>>>>>> On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
>>>>>>>>>>>>>> Add device tree binding allow platform overwrite default value of *REQIN in
>>>>>>>>>>>>>> GSBUSCFG0.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Why might a platform actually want to do this? Why does this need to be
>>>>>>>>>>>>> set at the board level and being aware of which SoC is in use is not
>>>>>>>>>>>>> sufficient for the driver to set the correct values?
>>>>>>>>>>>>
>>>>>>>>>>>> In snps,dwc3.yaml, there are already similary proptery, such as
>>>>>>>>>>>> snps,incr-burst-type-adjustment. Use this method can keep whole dwc3 usb
>>>>>>>>>>>> driver keep consistent. And not all platform try enable hardware
>>>>>>>>>>>> dma_cohenrence. It is configable for difference platform.
>>>>>>>>>>>
>>>>>>>>>>> When you say "platform", what do you mean? I understand that term to
>>>>>>>>>>> mean a combination of board, soc and firmware.
>>>>>>>>>>
>>>>>>>>>> In my company's environment, "platform" is "board". I will use "board" in
>>>>>>>>>> future. Is it big difference here?
>>>>>>>>>
>>>>>>>>> Nah, that's close enough that it makes no difference here.
>>>>>>>>>
>>>>>>>>> I'd still like an explanation for why a platform would need to actually
>>>>>>>>> set these properties though, and why information about coherency cannot
>>>>>>>>> be determined from whether or not the boss the usb controller is on is
>>>>>>>>> communicated to be dma coherent via the existing devicetree properties
>>>>>>>>> for that purpose.
>>>>>>>>
>>>>>>>> Actually, I am not very clear about reason. I guest maybe treat off power
>>>>>>>> consumption and performance.
>>>>>>>>
>>>>>>>> What's your judgement about proptery, which should be in dts. Such as
>>>>>>>> reg, clk, reset, dma and irq, which is tighted with SOC. It is the fixed
>>>>>>>> value for every SOC. The board dts never change these.
>>>>>>>
>>>>>>> Then it can be deduced from the compatible and there is no need for new
>>>>>>> properties.
>>>>>>
>>>>>> Okay, I think "*reqinfo" match this. When new Soc(using compatible dwc usb
>>>>>> controller) appear regardless dma-cohorence or not, connect by AXI3 or
>>>>>> AXI4, needn't add new propterties. 
>>>>>
>>>>> Anyone have objection? I will prepare v2 to fix rob's bot error.
>>>>
>>>> I'm not sure what you want me to object to/not object to.
>>>> Your last message said "needn't add new propterties", seemingly in
>>>> agreement with Krzysztoff saying that it can be deduced from the
>>>> compatible. That seems like a good way forward for me.
>>>
>>> Okay, let me clear it again. dwc usb is quite common IP. The below is
>>> what reason why need "*reginfo* instead of using compatible string.
>>>
>>> 1. *reginfo* property is decscript hardware behevior, which will be changed
>>> at difference SOC.
>>> 2. it may change at board level according to if enable dma coherence.
>>
>> dma coherence is not a board property. Anyway, you said it will never
>> change in the board.
> 
> Sorry, let's correct what my previous said. There are two kinds bus in
> system, one is dma_coherence, the other is none dma_coherence. There are
> some dwc usb core ip, which is the exact the same. Some connect to
> dma_coherence bus, some connect to non-dma_coherence bus.
> 
> So dma_coherence will be varible for this case. we need set *reginfo* for
> dwc usb core, which connnect to dma_coherence bus.  not set "reginfo* for
> the dwc usb core, which connect to none dma_coherence bus.

OK, that makes sense. Please provide link to upstream DTS
(mainline/next/lore link/other upstream projects) showing this.

Best regards,
Krzysztof


