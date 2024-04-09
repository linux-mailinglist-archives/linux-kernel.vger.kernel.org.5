Return-Path: <linux-kernel+bounces-136308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B8389D281
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36C52877D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE043AA0;
	Tue,  9 Apr 2024 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbpBfaZ0"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E71E498
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644409; cv=none; b=sjMzz0zgcsClqTkmh9oOAzM8/pzt0+5mfU2eDcL+lLM8S+MhK9ioLUk7M0Us2HJDBhr9Fy7iEJb6Ku1xdLA9L/2wBug/lepeE3dErodvkhKe+AlXZye1IMBQV7r5FOi0gAssEmrhPMRZz0XJR1FIHJGQRamzyZIpjCQOas4P8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644409; c=relaxed/simple;
	bh=Z1aYU/KF6AvQADh2jvgqNZzSsM7Ab0/WmyBX6QaNxeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnZCld9dXIoriMolXml74WiFXP54jj89OOP5Fwgq3+1vMaBKe2LylZzHc87752Vj/t1425dAh+5UYcSQr/wOd3SebWfRi7ldCCqf8PXVVjsuP6C6lOOVFlqp6O9nOlvKMLW85OvsV/k+DzCvRF6ve7MAxCjq0ALnnpa5fIb7vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dbpBfaZ0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516dbc36918so3438314e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712644404; x=1713249204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aTK2tY9bVzfl4l2ZpgIKVHWLJrOw4LwjZTAoE6HkNOo=;
        b=dbpBfaZ0Ferbi0LVcFFDBE+c0VyC6n4C1dj0A0tltX5rqKsxEWSZ4rf/J6oe8NueJF
         twPxn4duIfOl/CTiobqcnfuunaWH5xGgCSjETBK0jXbQnNS5bbM4u2VS88oqMT2vNL2V
         XKa057s9uOQS6Ds85NN885dOSI8Am3HJxoYaNd/ZM4VU7+MDUoeUH0X2+bi/J5AwOCxc
         ePRSzjZtknMVElDE1NnB4vXA+ReXOGdVHAD4yqByfbyOtb8h/R1wM00XhIC3znJnjnFn
         xnA1T05WZH8YJGdyTRvtQSgK6yi7UgACPyg8/n9BGwBqksqjqrkcCwH1SyLtv/SxuAZr
         tUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712644404; x=1713249204;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTK2tY9bVzfl4l2ZpgIKVHWLJrOw4LwjZTAoE6HkNOo=;
        b=C2cif78kqi60J3ta9OnUqK8WDldn0S4lGjgNcJe7S7ecliwBz0RIWBxazX+zDyc8qL
         LNiLZ0w4CS0A/Ef4B7IJVxiiLe0PEFdYGQhwy+4CcXB2szfHvVppuVRCNZXORzpF+Z9w
         +Gz+Q7zQH+igVx7Sx68ltllYAEvohdCql2RNLcUqkX0GrO20tAPceS8a/V79yJVVNusU
         sJPAl9UWWwrbukR7msM9sd+oy3fPtZi5XiJAiwIS1ZTG292Gh729nBMJAtpv7UT1egCm
         La++jgMf5fi6elcivGN8NNv4xGCOx1K4uHgqHFPvt4eC5HwoVApoQRuQMqIQ5V3dWbP8
         e4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVmp6pyHFXgZhl1BfR8uXiciC2bowP834ca/DrYUwQM3yWnFggqzGhdGPzIC0cBNtLnSe91+VI4Ch/uv0YBXusHIPa0POXY9LX8X1X
X-Gm-Message-State: AOJu0Yyi13slre4gfNeKt0F1xs9dcdG0/b3KF5qo43dGAef3GZdzs1UH
	xT57w/E8mV9JI/g5nXY/L0/DgwxJZyB19KObR6u3n8olpiWYPyN/IiemzHhx7Yo=
X-Google-Smtp-Source: AGHT+IFtzoy+zri/m83EH62Qlj2RXRgsD0JOv9OP762PQl16vrdGvZWkymUpxznvwlBgIWl9uerPQA==
X-Received: by 2002:a2e:9b84:0:b0:2d6:cbf2:ed2b with SMTP id z4-20020a2e9b84000000b002d6cbf2ed2bmr7291284lji.30.1712644404173;
        Mon, 08 Apr 2024 23:33:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b00416a6340025sm1235488wmq.6.2024.04.08.23.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 23:33:23 -0700 (PDT)
Message-ID: <76714850-0e02-4333-acce-02c7657666b0@linaro.org>
Date: Tue, 9 Apr 2024 08:33:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960/wm8962
 and sai[0,1,4,5]
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240404161914.1655305-1-Frank.Li@nxp.com>
 <efc9c624-6a31-4299-a604-8aad1d0cd878@linaro.org>
 <ZhAO4YWuB8r8k+m8@lizhi-Precision-Tower-5810>
 <938489b1-eb94-4f8a-8881-230951299f6a@linaro.org>
 <ZhQO979YpKA24pML@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhQO979YpKA24pML@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 17:36, Frank Li wrote:
> On Fri, Apr 05, 2024 at 08:21:18PM +0200, Krzysztof Kozlowski wrote:
>> On 05/04/2024 16:46, Frank Li wrote:
>>> On Fri, Apr 05, 2024 at 08:41:59AM +0200, Krzysztof Kozlowski wrote:
>>>> On 04/04/2024 18:19, Frank Li wrote:
>>>>> imx8qxp-mek use two kind audio codec, wm8960 and wm8962. Using dummy gpio
>>>>> i2c bus mux to connect both i2c devices. One will probe failure and other
>>>>> will probe success when devices driver check whoami. So one dtb can cover
>>>>> both board configuration.
>>>>
>>>> I don't understand it. Either you add real device or not. If one board
>>>> has two devices, then why do you need to check for failures?
>>>>
>>>> Anyway, don't add fake stuff to DTS.
>>>
>>> NAK can't resolve the problem. It should be common problem for long time
>>> cycle boards. Some chipes will be out life cycle. such as some sensor. So
>>> chips on boards have been replace by some pin to pin compatible sensor. For
>>> example: 
>>> 	old boards: use sensor A with address 0x1a
>>> 	new bench: use sensor B with address 0x1b.
>>>
>>> You can treat it as two kind boards, RevA or RevB. But most user want to
>>> use one dtb to handle such small differences. For this case, it should be
>>> simple. Just add a super set.
>>> 	i2c
>>> 	{
>>> 		sensorA@1a
>>> 		{
>>> 		}
>>> 		sensorB@1b
>>> 		{
>>> 		}	
>>> 	}
>>>
>>> It also depend on whoami check by i2c devices. Only A or B will probe.
>>>
>>> wm8960 and wm8962 are more complex example.  wm8960 is out of life. But
>>> wm8962 and wm8960 have the same i2c address. The current i2c frame can't
>>> allow the same i2c address in one i2c bus.
>>>
>>> You are feel to NAK my method, but I hope you also provide constructive
>>> solution to help resolve the problem.
>>
>> Yes, we resolved it long time ago. Your bootloader can (usually easily)
>> detect revision of the board and load appropriate DTS or DTS+DTSO.
> 
> I knewn it. But the problem is one development boards A have many options,
> so create many child dts for files, A1, A2, ... An which base on A

So use DTSO, what's the problem? Other vendors, liek Rpi does not have
problem with it and it works well. No confusion.

> 
> If there are difference happen at A, create new B. then create all child
> dtb, B1, B2, ... Bn.  DTB number will increase exponent.
> 
> If change is quite bit, we have to do that. But if change is quite small,
> One dtb can cover it by driver auto detect, which will work like some
> adaptor card have not plug into boards, or some sensor or NOR-flash have
> not installed because reduce cost.

You have two boards, not 20 here!

>   
> Although boot loader can update dts or choose difference dts, It also cause
> many confusition, such as layerscape, uboot update many kernel dtb's
> information, which actually increase dependence between uboot and kernel.
> Also it confuse people, for example,  when try to debug kernel dtb, why
> change have not token affect when change dts because not realized uboot
> over write it.
> 
> What's I dide is that trying to reduce unnecessary dts.

There is no confusion. That's normal process, so if someone is confused
by having variants of board, this someone will be even more confused by
seeing non-existing hardware in his DTS.

This problem was solved long time ago and you do not bring any
reasonable new arguments. All vendors solved it (just look at ongoing
discussions on board id) but only you have problem with their solution.

NAK

Best regards,
Krzysztof


