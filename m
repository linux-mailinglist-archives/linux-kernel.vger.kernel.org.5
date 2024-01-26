Return-Path: <linux-kernel+bounces-40066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D183D9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750CA298200
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951718038;
	Fri, 26 Jan 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3y0vTya"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3817582
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269891; cv=none; b=d33bBdzPPVrserD4sdF3Kj3//yAfBKdngIyepryvS0RId/rrhUGtek8c4W9HLGrzCKnLSFoAreyZNUf9nqezmkOBgPETswvhiMEz2h+bRpd8arP9wniv0Rc8dHswFNcXDZK1Zw3z4UKmRp5q0sCLafLBzz37SyXcvOIkzV4AUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269891; c=relaxed/simple;
	bh=OtD6qtzg55sWzM5Z8Rb+7F4VnGdyNRhHaoa+dKRUkVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBAcHzMxck2e6DOa3eFkx0bAONBaP/n2bgwde3bM0W/r9H7XHvykQFDVZcKSE9Efw+PXd6HayUN5HawTn6ZVICTp6DcheiAqPGC0/MJX3Kmb5eTb6LpRM0q2rFMUmtpxzJoRkprtmBUA0/omC37BE1vRmw5Ih4IfPIKzJLNEL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3y0vTya; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a45a453eeso836070a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706269887; x=1706874687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RO2vy9Gohf4fesVKOSGHEr8L+y5rrbvowDx96zw2txI=;
        b=G3y0vTyad9eY74vZMWtz7BihfGIZe1YJg6QI5Ey9eaCnpG5KeHUtX5FJnZEMUqSioA
         dAKRz0T4K4fsPVlq2Ng/hCJHEup/kpkkZ/uthCTs9VfeZxEVE7x2Y5neMA/A98N/EtVM
         nKY6x+QvjBh2bYjDVCJGcmvBhs2LEueSlIPqbUdJWk140rxcrcQE+QHL/bXHZFAiWZRp
         SiXIkmGh9dlCnwL6f5sksgcpOMyCHFmilZyntyYjG0yj7ZfSOR09WLSAGCQ2CFNZY1aP
         ieIXWfxzWfxzU6UdTDUsVjLu4qBMfHQ2VNW418Y8NYP82kIPNI0yePkRHTMEgl+7oVYA
         myXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706269887; x=1706874687;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RO2vy9Gohf4fesVKOSGHEr8L+y5rrbvowDx96zw2txI=;
        b=w3KQsZaJxAJTbK7AmVZLeIwAQ4I51EHH6I8ZpwJPy7mQMnLtiUnun0lzNtdPviKf1D
         Ip/lEtNvrHL5ZN7AJSFpRAkQOmht0maa3HKSm5zz0DdvZjejkWTeJbF4e5C66CiYTKjC
         nUB5tBM/NGQp7PAc3g+Q/DlytTC++bVDkU1RTTBuMfVCk7cyDNd6uLNWmZXxbeTdFdfT
         fw4dyXd6DDx/wuCKHIIeaAQ/Fv1aZcNA7USxcax0/UIU6GBL7dYlMwqkASgWYNnqP3zr
         t952bkMyUTEd/nr2bzPEFuY/f7J2Ik+TZPMsvdKmC2CdaZhCE5D8ZX6ELGvHunNf16t5
         5+ww==
X-Gm-Message-State: AOJu0YxzGWQvHC3o601xfCD8wffRY2GP+38eGaXR7YfIWv7eRjC78cIO
	aoB2I9ij2mkGbvYWwaMu6gMIoF/6Ru+GnbuuyRQ7gVi8OJKeOTeZzwUgELexJHQ=
X-Google-Smtp-Source: AGHT+IF9IhXflvx/W5B3Po+MJ3rAwfJ8wZiq7vbmid2/bAXymV9jEMmCULgsLH6q+PDyMhOrjEbSIg==
X-Received: by 2002:a17:906:5a87:b0:a31:7af3:f46f with SMTP id l7-20020a1709065a8700b00a317af3f46fmr1085152ejq.77.1706269887267;
        Fri, 26 Jan 2024 03:51:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id vh5-20020a170907d38500b00a3517d26918sm840ejc.107.2024.01.26.03.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 03:51:26 -0800 (PST)
Message-ID: <48edb603-3d45-45ed-be25-31fd8a5b69f1@linaro.org>
Date: Fri, 26 Jan 2024 12:51:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Rob Herring <robh@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
 <20240124151405.GA930997-robh@kernel.org>
 <dd7e723d-3c4c-4edf-afc2-51db9a074efa@linaro.org>
 <CYNQHXOZ73YR.3QODFI2X08KC6@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CYNQHXOZ73YR.3QODFI2X08KC6@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/01/2024 12:01, Théo Lebrun wrote:
> Hello,
> 
> On Thu Jan 25, 2024 at 8:51 AM CET, Krzysztof Kozlowski wrote:
>> On 24/01/2024 16:14, Rob Herring wrote:
>>>> +
>>>> +      pinctrl-b {
>>>> +        compatible = "mobileye,eyeq5-b-pinctrl";
>>>> +        #pinctrl-cells = <1>;
>>>> +      };
>>>> +    };
>>>
>>> This can all be simplified to:
>>>
>>> system-controller@e00000 {
>>>     compatible = "mobileye,eyeq5-olb", "syscon";
>>>     reg = <0xe00000 0x400>;
>>>     #reset-cells = <2>;
>>>     #clock-cells = <1>;
>>>     clocks = <&xtal>;
>>>     clock-names = "ref";
>>>
>>>     pins { ... };
>>> };
>>>
>>> There is no need for sub nodes unless you have reusable blocks or each 
>>> block has its own resources in DT.
>>
>> Yes, however I believe there should be resources here: each subnode
>> should get its address space. This is a bit tied to implementation,
>> which currently assumes "everyone can fiddle with everything" in this block.
>>
>> Theo, can you draw memory map?
> 
> It would be a mess. I've counted things up. The first 147 registers are
> used in this 0x400 block. There are 31 individual blocks, with 7
> registers unused (holes to align next block).

Holes are not really a problem.

> 
> Functions are reset, clocks, LBIST, MBIST, DDR control, GPIO,
> accelerator control, CPU entrypoint, PDTrace, IRQs, chip info & ID
> stuff, control registers for PCIe / eMMC / Eth / SGMII / DMA / etc.

So they are within separate blocks or not?



Best regards,
Krzysztof


