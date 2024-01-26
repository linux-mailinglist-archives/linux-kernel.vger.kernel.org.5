Return-Path: <linux-kernel+bounces-40067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2BE83D9A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92CC1F244A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11111805E;
	Fri, 26 Jan 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYMo0j0M"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4B17582
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269972; cv=none; b=Six32WWe2YxuYrunDuPa3NgWjZRfk/XU7y93VAPiYClR4CjsijfsdHsvdP4wbyFR/SdQuFpGRpTviZEyYRGJEZrnclUXoR8x2FHQFmcqU4QEnQ2U1BQ1WG2uX4Bde74NBEt0Qh5eiOv4Q8rliZudCseqSAAB/vdm9Mxo9x7TzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269972; c=relaxed/simple;
	bh=t2anX52nRA3jUYm8HdDgvlcO49DEUM2Owhj9NMAv8ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASutBWRVkKkMrnrM9QaWTFMWW1jeQZ0dSZk9BnmS4QS4y1eMYmVqMfxWj0t7pw/k4zpp3ZCC4B0New8XasI/rSan9+a04LoVMMpgI9dBKUFeEIiYq8KP+KVdvqZTPer4puSwlYDz0QMKqD7/TQKEHb5T9kgtJcDEnCVHpLR0Ncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rYMo0j0M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28fb463a28so27798966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706269969; x=1706874769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geAXU/jqhg6hPjco70kwTQYqqgsPO9C/X8TcVRQJY1k=;
        b=rYMo0j0M8ewDsmob5fJSNCAJy1cxSnLZd7PwyKq7o4Dej2KXwqj9gRl0LhWuQ2rEqn
         auPOhkNryo5JxQBCi6IBf1hYjI/OplYYG3uPCKo/+XWCMBiptBHbDA8Xdzf3aGZrHIdg
         br7I3Arydh1Lh4qg65xKRTXBt/3CRUh6Buf/yePvv/1K06w4E2TNTFfpOwogyJ3KlPQg
         j2mcsjTsQqZMJt+6HVC6uhQ2NvPbIOKxc9GLG9ZSZMMBy952/DYX5Jtz5WJ1EB94s3N2
         lw9QVr5/zCnid4lHfDKMtsRhxgXb8/SaXQ7hQWxC0kZzu7t17jOqOXA2stFudn5GG1W1
         xYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706269969; x=1706874769;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geAXU/jqhg6hPjco70kwTQYqqgsPO9C/X8TcVRQJY1k=;
        b=mBiuX4i3nbLyvsycKpWQl4a+E45Z2g9ZrOenw6j6jWPM2Ifg4jPEYYgM3vSXO6Kh95
         hztEdrXo6LUelLP8b/jDLaXpr3dmvKhma6MNh+sgiHgchGaBpWQlIACsrk15jXu19Q9p
         OQyRODUW8DOW9vjh6oC7CUi1tlQlUlIhO+yF31np/muG7ip3FhvHjMwOgFHlNNybcUel
         oModWOIgnFKQOYgz8Kw3ev9T+00jVE4NbTDs9XYbTcrmGTACOtMYKU5XhcKbbuQ4beB2
         Tp1aFdum6XHJu17EEn3vn6e/kSQN/IwX07bPpa4FjbsgaoVSecbzyNG6TVn+8hEoTRjL
         Gcxg==
X-Gm-Message-State: AOJu0YyyclU36r25QfNI0k/v3pwleiBVlLsV5e6g9Cw4xTBLHqSC5NJZ
	Ad8NFUowRmzXRRtNB3clLbN2AqcUhTRa3wZI5/g0rbZqH09PqEqok5kfEWB0IdU=
X-Google-Smtp-Source: AGHT+IH/G9FQT5gSG17T6ROEKidotJcR7Nu5nwcOa9PKUTRqcH8CWholcbHuepnjrsJJOhU4YdIzCA==
X-Received: by 2002:a17:906:1110:b0:a31:82e7:d5ac with SMTP id h16-20020a170906111000b00a3182e7d5acmr679876eja.0.1706269969454;
        Fri, 26 Jan 2024 03:52:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id vh5-20020a170907d38500b00a3517d26918sm840ejc.107.2024.01.26.03.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 03:52:48 -0800 (PST)
Message-ID: <8054e01d-0a1e-45b6-b62a-25303e8f4593@linaro.org>
Date: Fri, 26 Jan 2024 12:52:47 +0100
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
 <CYN43TSPPPZ5.1VUA1CH95D8KJ@bootlin.com>
 <CYN4D0Z6600X.20W9VWX4BGNXX@bootlin.com>
 <CAL_JsqKHPdmafDvKCHZTNNzRAzq2Y34b2dqUXQD6WpE7z2k-jA@mail.gmail.com>
 <CYNRCGYA1PJ2.FYENLB4SRJWH@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CYNRCGYA1PJ2.FYENLB4SRJWH@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/01/2024 12:40, Théo Lebrun wrote:
> Hello,
> 
> On Wed Jan 24, 2024 at 8:22 PM CET, Rob Herring wrote:
>> On Wed, Jan 24, 2024 at 11:40 AM Théo Lebrun <theo.lebrun@bootlin.com> wrote:
>>> On Wed Jan 24, 2024 at 6:28 PM CET, Théo Lebrun wrote:
>>>> On Wed Jan 24, 2024 at 4:14 PM CET, Rob Herring wrote:
>>>>> On Tue, Jan 23, 2024 at 07:46:49PM +0100, Théo Lebrun wrote:
> 
> [...]
> 
>>>>>> +      };
>>>>>> +
>>>>>> +      pinctrl-b {
>>>>>> +        compatible = "mobileye,eyeq5-b-pinctrl";
>>>>>> +        #pinctrl-cells = <1>;
>>>>>> +      };
>>>>>> +    };
>>>>>
>>>>> This can all be simplified to:
>>>>>
>>>>> system-controller@e00000 {
>>>>>     compatible = "mobileye,eyeq5-olb", "syscon";
>>>>>     reg = <0xe00000 0x400>;
>>>>>     #reset-cells = <2>;
>>>>>     #clock-cells = <1>;
>>>>>     clocks = <&xtal>;
>>>>>     clock-names = "ref";
>>>>>
>>>>>     pins { ... };
>>>>> };
>>>>>
>>>>> There is no need for sub nodes unless you have reusable blocks or each
>>>>> block has its own resources in DT.
>>>>
>>>> That is right, and it does simplify the devicetree as you have shown.
>>>> However, the split nodes gives the following advantages:
>>>>
>>>>  - Devicetree-wise, it allows for one alias per function.
>>>>    `clocks = <&clocks EQ5C_PLL_CPU>` is surely more intuitive
>>>>    than `clocks = <&olb EQ5C_PLL_CPU>;`. Same for reset.
>>
>> clocks: resets: pinctrl: system-controller@e00000 {
>>
>>>>
>>>>  - It means an MFD driver must be implemented, adding between 100 to 200
>>>>    lines of boilerplate code to the kernel.
>>
>> From a binding perspective, not my problem... That's Linux details
>> defining the binding. What about u-boot, BSD, future versions of Linux
>> with different structure?
>>
>> I don't think an MFD is required here. A driver should be able to be
>> both clock and reset provider. That's pretty common. pinctrl less so.
> 
> @Rob & @Krzysztof: following Krzysztof's question about the memory map
> and adding ressources to the system-controller, I was wondering if the
> following approach would be more suitable:

More or less (missing ranges, unit addresses, lower-case hex etc).

> 
> 	olb: system-controller@e00000 {
> 		compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> 		reg = <0 0xe00000 0x0 0x400>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 
> 		clocks: clock-controller {
> 			compatible = "mobileye,eyeq5-clk";
> 			reg = <0x02c 0x7C>;
> 			#clock-cells = <1>;
> 			clocks = <&xtal>;
> 			clock-names = "ref";
> 		};
> 
> 		reset: reset-controller {
> 			compatible = "mobileye,eyeq5-reset";
> 			reg = <0x004 0x08>, <0x120 0x04>, <0x200 0x34>;
> 			reg-names = "d0", "d2", "d1";
> 			#reset-cells = <2>;
> 		};
> 
> 		pinctrl0: pinctrl-a {
> 			compatible = "mobileye,eyeq5-a-pinctrl";
> 			reg = <0x0B0 0x30>;
> 		};
> 
> 		pinctrl1: pinctrl-b {
> 			compatible = "mobileye,eyeq5-b-pinctrl";
> 			reg = <0x0B0 0x30>;

Duplicate reg?

> 		};
> 	};
> 
> It highlights that they are in fact separate controllers and not one
> device. The common thing between them is that they were
> custom-implemented by Mobileye and therefore all registers were put in
> a single block.
> 


Best regards,
Krzysztof


