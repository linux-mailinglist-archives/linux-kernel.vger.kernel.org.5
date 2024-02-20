Return-Path: <linux-kernel+bounces-72926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173A285BACC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A3D2843A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6167A0F;
	Tue, 20 Feb 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNuhW8dX"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE4664B9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429320; cv=none; b=sCfEt25FQQFPGY9zbqp/ZoLl6jbkF7+eCxnJiTCiYv6Pkh/BlUsOqAzREIgW/u1XoeoTn4B7n5f6jer9QOktd4WuPGBKaogyN/sA6Aq8IE6wSVr98HPF87zhOMczX9RHmLLZwL340KmdXQcMfq5j5y0LIZyapMigDJ4bC1aLGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429320; c=relaxed/simple;
	bh=07vhUlZzzQQe6hC9s5mP3ELa3vbii3u8ZF3kCqTPA7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRDR6SatZlyvaezw48RQfh1xd53it2jZH0g/3Q6ZskhxbgKt7svpdT0LvqdSKeIhxIA1/tvILc9I5pYOcAiIKigy7P8h0LvMdZY+OTeJOKPn7NVfXM1URqouKLp655t3ABh0lSBQVW7KDgVZGJ/sVNXEPtLAwh9N+rqwhmtTJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jNuhW8dX; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d220ad10b3so43292361fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708429317; x=1709034117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9J9gv981elm4Fd66m9fg/wZTGDz7xrs+dihVcv+w61U=;
        b=jNuhW8dXJLuMC8ni1+Cr1aXhEJny36vVtL1URIWiAOulGamxadH7wMkhMy7/mr5yU+
         QzduP2FwMub3qs6tNV4H1ijKXu2FbzdbRL5spAtjTTCbdRdgK4+V/DOA+ZD8iRQfIzEj
         5T8qrQRjSAqIUbhIchDHCUbQxZ4KVc2Jv3y4BfXX6l4LIlRYjXZh4F+mbxt/zCxI+mOp
         9uBu9ahAOwzFQL0N1Mg3607DCSx0fLueiR4GXewI5TvoIgnOH/FqFQCcv/DVVO9lV/Pw
         B0nX4qvalJFQqEFFtWnog5yAn58QeoNpMOJ3gUc1S1MTGKXkMhBwy41rBxlphBNFItqg
         6qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429317; x=1709034117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9J9gv981elm4Fd66m9fg/wZTGDz7xrs+dihVcv+w61U=;
        b=iclx/F27GZ5YyV0XMmXhW9UzdcTP7P+QL46csoaWB45icjefyxo4CRocokx6t+9npc
         4iFujNZnNJOye2zRz7Es5XD/aev6QKZt2LQd8ZYgpag//CG7O38TTGczdMmgBXRXsmni
         lbnZmsh2xcp7z8SdSkNQ3RfCon4AOVURUqLeCqUivR+00AW7MsCo8yrnl4GEpBAc0uWu
         lf+MZElUGyBlcQ9bIchIzveGzzaPXCHKGqWkjzVVgwsPSo4FXmqqbkqVwve0/PAc8hq3
         V1HUjmgPepDFihHpXwhqtMQ6gXcga8jeuxMHi7ruzbwB+Il57AVZylOzP7k2Hvdagyia
         J//g==
X-Forwarded-Encrypted: i=1; AJvYcCXeruL+5KRuYYQ+W+3f1V4CMyDknvNT4TZ4BC/s1SYmnWjba9KrlHFolHRNsCGzai2IEWYYK6vzMM83N/TzqzeQFATlS9qysPK91mC2
X-Gm-Message-State: AOJu0Yw2/cJ2EiIAPR0zpTK11DHJgcHWm62/1foWRRPyWoO9A2lAWQGV
	rYSoYE21lddmp0zf88s1kDmD2Ek4Gw8IN36rzJGl8kD+sIzUCQD/mM8VnQX8d7o=
X-Google-Smtp-Source: AGHT+IFUQvaY0OdaOh15fAs6s35jjCrzlsk5A/Ryckie3o7N51ipQgngErmVVAJ1N6CY6X66LraSEQ==
X-Received: by 2002:ac2:5e66:0:b0:512:bdd7:a932 with SMTP id a6-20020ac25e66000000b00512bdd7a932mr2334062lfr.8.1708429316854;
        Tue, 20 Feb 2024 03:41:56 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id t5-20020a056402240500b0056394d0e989sm3586620eda.76.2024.02.20.03.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 03:41:56 -0800 (PST)
Message-ID: <bf4ce87a-51ab-49e1-ac70-c463d8008a62@linaro.org>
Date: Tue, 20 Feb 2024 12:41:54 +0100
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
 <6f3f22f6-f659-494d-963c-544cf5f44adc@linaro.org>
 <SEZPR06MB69592FACB1EF1B9FEDA89E5996512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <9a5e9363-79eb-416c-89ae-c826062350b5@linaro.org>
 <SEZPR06MB69594A5036F122CE6C14043C96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69594A5036F122CE6C14043C96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 11:40, Yang Xiwen wrote:
> On 2/20/2024 4:16 PM, Krzysztof Kozlowski wrote:
>> On 19/02/2024 22:49, Yang Xiwen wrote:
>>> On 2/20/2024 5:37 AM, Krzysztof Kozlowski wrote:
>>>> On 19/02/2024 22:35, Yang Xiwen wrote:
>>>>> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>>>>>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>
>>>>>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>>>>>> list due to prior driver change.
>>>>>>>
>>>>>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>>>>>> compatible lists.
>>>>>>>
>>>>>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>>>> ---
>>>>>>>     .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>>>>>     .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>>>>>     2 files changed, 95 insertions(+), 71 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..1b57e0396209
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>> @@ -0,0 +1,95 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    items:
>>>>>>> +      - enum:
>>>>>>> +          - hisilicon,hi3798cv200-usb2-phy
>>>>>>> +          - hisilicon,hi3798mv100-usb2-phy
>>>>>>> +      - const: hisilicon,inno-usb2-phy
>>>>>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>>>>>> hisilicon,inno-usb2-phy are not compatible.
>>>>> Ah, i didn't pay too much attention to that. I should remove the entry
>>>>> for hisilicon,inno-usb2-phy in the driver. Sorry for that.
>>>> We don't talk here about driver, although I used the driver as proof or
>>>> argument, because I don't have access to hardware datasheet (and no
>>>> intention to look there).
>>>>
>>>> What I claim is these are not compatible, so respond to this argument,
>>>> not some other one.
>>> Why not? Of course they are compatible. All 3 SoCs are using
>> Why? Because...
>>
>>> inno-usb2-phy. The only difference here is the method to access the
>> ... here! Different programming interface means not compatible.
>>
>> Please provide instead any argument that they are compatible, in the
>> meaning of Devicetree of course. You are claiming inno-usb2-phy  can be
>> used for hi3798mv100 and it will work fine?
>>
>>> registers. They are all enabled by `writing BIT(2) to address 0x6`. In
>>> the cover letter, I said the driver is actually doing things wrong.
>> Cover letter does not matter, I don't even read them. Your commits matter.
>>
>>> Especially the commit adding PHY_TYPE enums, the name is confusing and
>>> conveys the wrong info. It's not PHY which are not compatible, it's the
>>> bus. I'll fix the driver, but still the PHY hardwares are compatible
>>> between these 3 SoCs.
>> Provide any argument.
> 
> Just take a look at the driver. hisi_inno_phy_write_reg() is the 
> function that differs between different models. But for all of them, 
> hisi_inno_phy_setup() is the same.
> 
> 
> hisi_inno_phy_write_reg() should be moved to a separate bus driver. It's 
> bus-related, not phy. PHY driver should not care how to access the bus, 

So drivers are compatible or hardware? We talk about hardware, not
drivers...

> but the bus driver should. The PHY driver only needs to use regmap_* 
> APIs to "write BIT(2) to addr 6".

Different programming interface, so not compatible.

> 
> 
> For mv100 and cv200, the PHY master bus interface is attached to the 
> perictrl core in SoC (though the perictrl core provides slightly 
> different register offsets to access the PHY bus). For mv200, it is 
> directly attached to AHB/APB system bus so we don't need to put it under 
> a perictrl node anymore. So here, clearly it's the bus the PHY attached 

Different programming interface, so not compatible.

> to which is different, not the PHY itself.
> 
> 
> That's why i say the driver is wrong from the beginning. It's mixing PHY 


I don't care. We do not talk about drivers.

> driver and bus driver together but they ought to be different. PHY is 
> always compatible, but the bus is not.

Do you understand what does it mean "compatible" in DT?

> 
> 
> The correct fix should be moving hisi_inno_phy_write_reg() to a new bus 
> driver and migrating to regmap_* APIs in PHY driver. But i'll have to 

Don't care. Driver stuff.

> write a new driver for that, which i try to avoid (it takes too much 
> time!). So i said clearly in the cover-letter this should be considered 
> a hack.


Best regards,
Krzysztof


