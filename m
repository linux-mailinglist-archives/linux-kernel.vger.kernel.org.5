Return-Path: <linux-kernel+bounces-82824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4934868A25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120D31C219EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D755E7A;
	Tue, 27 Feb 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TesDGQWl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB754F8F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020135; cv=none; b=d9wwbOT1t6gNgg1q29G0FLkUPZJgS96dSrytGUfstpuBjg67PK7Htq51gL7cpcQD0rz9TtOlOW74nCPcoscFMF4I93sEbn5amI7ZrcBtNfuFq+H/BfnkVH6EOXCnwvEiJ8Lk1mcvxgir7wGMleNZYM1/HT5sbotHWt3Xx0ahaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020135; c=relaxed/simple;
	bh=0XcpYIVycFq8C6EZqoO1e5SnrQdaeiWBYSh8TFw+qrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxtndR9QYL9dtkL75Ipi623t0+FbnGF0h6zOUiQm2ZzpM6tAHnIb1J50T5yJ89ACgHwpklVv/3eJm1gAw1CKdvp+NCvDZReLq8InOd7qK0y9XQ7CQs6STWN+F/r1nszZRF5MgpiWQ7XmGzBbefzxRIJvT0It9i2urFwgDwIrZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TesDGQWl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so546758566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709020131; x=1709624931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zpa7FJE7ovtFcXBy2ufebK/95x4a764UoBJ00w2JWHM=;
        b=TesDGQWl4/6lKitHd++dlrK/uNzm/LVSbj7P2qTVyxfRy0C1IYj1UuoWmMf6Mn3bsL
         jD1uAHNmQxA5xEhGrpF/0TNLOSFnZBAtGoMSNBUUf8ciHFwJrvLcGDDaBWOWxmTHbJj+
         m4scNBB1JllEIcJni5hyZ38j9S1aWeiU1vJmq5OYI3+AgjCGApm++Lvw4gWpVEBd5vXs
         nMnZIcJAH36tFfJTXP46zOqC2f49c4ZIMi4M+FYYL0Mh9LST3fL+HSbUM+gcGLbH+W3s
         5qEx+oEBUWGRq0boLFarOJKxJIubePm5H9E3fO68MydT7GTpVdfdoKOxw/HXg2w8j07z
         LIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020131; x=1709624931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpa7FJE7ovtFcXBy2ufebK/95x4a764UoBJ00w2JWHM=;
        b=B18cBV8bcMslhtQQG9eaeKDT5YpyR/BLrVQas5/2JscDo/Hv2Gop+vCxxNdofm+XSV
         DDEOb1bni+XLp21kijrOu6/W9JPYPpV2iyKWJo6X7k7AtJxXoKWdiOmAB9jM/54F/esL
         VdwCLzY5NDJgGMFqn3mVZkt7az3ccToQPGkhDwhdUyL8O0qKXn9CM3zhiTyuq6QjMFce
         ukH9tmalWkF3Z1nBxvVvaN6wYsdK2uo/yJfBch6z/RgGd32q6WOHgPhPsCm0ECz/Bksb
         T2ywOA0xc3c2tJuP26LxgcTs3McvTTCQq0Ab5cAZWL58uMuPXtVJYX4RM9/aNp74lULj
         kYMw==
X-Forwarded-Encrypted: i=1; AJvYcCVen+GdnDt7O37CxzWZFbDY5zqslfwPXmQa26SXpUN50Dwo6icV/um9FmdQ286hScpxI/QfJX9vJ4mlg9OKHqgMJoiv3r+PF6aBqWyn
X-Gm-Message-State: AOJu0YwlNQJQJ03a9uA710qWK+XI8zsQKMBo9ax0kX3wJ1CxHMSoN662
	xKaO1MWW5DfUSTPUdzbRTu2vZWdbpjszaVVTikZdo3fzOCp8eGhPkBkW/q4XN2w=
X-Google-Smtp-Source: AGHT+IFLsOEBbPXwnKa00McbfaYLvGgBP0506INWeHuKc2pJp33JhOhXvHnYbVXwL+K77BweHSD+og==
X-Received: by 2002:a17:906:3488:b0:a43:ccd:a816 with SMTP id g8-20020a170906348800b00a430ccda816mr4908976ejb.31.1709020130888;
        Mon, 26 Feb 2024 23:48:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vg15-20020a170907d30f00b00a4319de07c6sm488962ejc.127.2024.02.26.23.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 23:48:50 -0800 (PST)
Message-ID: <7f722ffc-b0b5-4bd7-a46b-3ce5ae61ad5d@linaro.org>
Date: Tue, 27 Feb 2024 08:48:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/6] net: hisi_femac: remove unused compatible
 strings
To: Yang Xiwen <forbidden405@outlook.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
 <20240222-net-v4-6-eea68f93f090@outlook.com>
 <ccdcdb1b-44a9-4233-994e-18d875a99c2f@linaro.org>
 <SEZPR06MB69590A200BDDD6D3DA4CD2DA96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <90ab2113-f3f7-4d1f-83ca-aa57cbe63a79@linaro.org>
 <SEZPR06MB6959E3E0C16ABFA9171FC4DE96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB6959E3E0C16ABFA9171FC4DE96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 08:36, Yang Xiwen wrote:
> On 2/27/2024 2:53 PM, Krzysztof Kozlowski wrote:
>> On 27/02/2024 02:51, Yang Xiwen wrote:
>>> On 2/26/2024 3:55 PM, Krzysztof Kozlowski wrote:
>>>> On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>
>>>>> The only documented SoC Hi3516DV300 does not receive any updates from 8
>>>>> years ago. With the recent driver changes, it unlikely works for this
>>>>> SoC anymore. Remove the binding for this SoC.
>>>>>
>>>>> Also it's hard to get the version number and it's unknown how the
>>>>> version can be used. Remove them until it's really needed.
>>>>>
>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>> ---
>>>>>  drivers/net/ethernet/hisilicon/hisi_femac.c | 4 +---
>>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
>>>>> index eab91e011d11..9466ca9da2bb 100644
>>>>> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
>>>>> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
>>>>> @@ -990,9 +990,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>>>>  #endif
>>>>>  
>>>>>  static const struct of_device_id hisi_femac_match[] = {
>>>>> -	{.compatible = "hisilicon,hisi-femac-v1",},
>>>>> -	{.compatible = "hisilicon,hisi-femac-v2",},
>>>>> -	{.compatible = "hisilicon,hi3516cv300-femac",},
>>>>> +	{.compatible = "hisilicon,hisi-femac",},
>>>>
>>>> What is happening here? Removal could be justified, but then order of
>>>> your patches is totally wrong. But that hisi-femac is a no-go or provide
>>>> proper rationale.
>>>
>>> I don't understand exactly... In dts, we commonly have a SoC specific
>>> compatible string first, generic compatible string the second. e.g.
>>>
>>> compatible = "hisilicon,hi3798mv200-perictrl", "syscon", "simple-mfd".
>>
>> There is no generic compatible here. hi3798mv200 is soc.
>>
>>>
>>> So i think this is recommended. Or does it mean we only need them in
>>
>> It is allowed for certain cases and recommended for even fewer ones. Do
>> you want to say you have fully discoverable features here and you do not
>> need any properties? Or you want to say that all possible hardware will
>> have exactly the same programming interface (registers etc)?
> 
> Of course not. Take FEMAC for example. The FEMAC core on Hi3516 and

If they have different programming interface then you cannot use generic
compatible as fallback.

> Hi3798 can programmed in the same way. They use the same
> resources(resets and clocks). Though still a bit different in hardware,
> basically the fifo depth etc..
> 
> Hi3516 FEMAC is not special enough to have a new compatible string, nor
> do hi3798 FEMAC. Nor do i think we need those undocumented version
> numbers, i.e. "hisilicon,hisi-femac-v1/2". As i observed, this driver is
> generic enough to handle all the FEMAC cores i know, no matter which
> version nor which SoC. This can also be concluded from the driver, the
> driver defined 3 compatibles but they are all treated the same.
> 
> Should I remove all of them, and only leave a generic
> "hisilicon,hisi-femac" instead?

No.

Use one SoC specific compatible as fallback. That's what we ask almost
every time...

Best regards,
Krzysztof


