Return-Path: <linux-kernel+bounces-82764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D2868962
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3567F1C226D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F1554662;
	Tue, 27 Feb 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CY7rWYhK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D6537F4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016797; cv=none; b=ZI0RrM87aI/lopP2zNGdfHJTIBcUfaCWMzXHtF1XWRaeEBxO3qWS9D8eL0xHtis16TVTbXgaIV/Dqh2lLTqEaciHYuYpnp8bgLRonHXqFCmqdPtaFspQdvjtj7jkaC9dl3hRAXsm+qEOlBuzkUxj3qhrCOOuT3Q5+oOIE2KyVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016797; c=relaxed/simple;
	bh=SKPgOyUaWMp7tVKq+GIAuvqq2ASkAq2PcfWyU1kwv6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVyq58zh9b/0UYGdEd1hK8n9P/2Y/vvU/pmoT7XR9odOibsvwQACDcgSvC1n2gNpRL/CC0lnq1JbThfQAYZ5OH10MgZdId2/qs6nwFrwCQAGRa+QDHrGdCsCQGLZkWzMM/j5l3rZTOSlGPah5Jnj/A61EkMuR2UPmPSrmScnDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CY7rWYhK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so4922830a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709016794; x=1709621594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUW9NBgii9foEKz4KuucqEYpYQWu5QkJlFAfiZzpmZI=;
        b=CY7rWYhKQCuUbEbb81ncPErfClJjZFtQ0Lqv4awW2j4gb1D8g6ppk0zLp8UKLRgTZR
         E7qHx00HaL7NqfHXltn3H9pW7hqy2wbi73dSO9pJM2katqREBDNnLT/ZsjMJEWnWehLs
         DAsIKeDTx3uXoBVbr9Ud+7X7w1UqAiux+3SEq+K4Y+nwsxvVD2VhsgNf7Se76W1Wliqk
         KQf5Ji0ZXMIkYehSjMHVnCrlWRkPY2Js0ME825IGTm4jHXYQbjhfnt2EI6R2Rxy6RUwO
         hxTeBxBhhKGswdROBwviiiXZCxvi8XnAubSsv4JhSoJdK7t6iWfEJ0hetXVz4/D3YrVa
         H6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016794; x=1709621594;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUW9NBgii9foEKz4KuucqEYpYQWu5QkJlFAfiZzpmZI=;
        b=md3KMMeGoiWxIXN0oyjtyA6A9QNs4AoUQ1Hbe49FcxrbKZofNsx2wKri0ZPh96j1cq
         GvHRaaNG/SjtWIZzwtR6YgXloDlOoaXJYO0puEGLyueBfceXywfM+8MGUlMQsIFMRJEW
         iEPBWJaAVLV1ugDpnyQMNWPxxtpbiLQ+oXzviKFYrUItYLisGqQwO7JzeriY1KZF9cN7
         lBNMyRrLeolQf1Ne3XgOHPC0s+QDwtXBDznJ75x2WX/rIiBqtNOkXuhBLszchUyFnG5a
         jN2I3ckjeSue6ZHNpPLm3unqC5eMgeLV/0YUc1KeME5czpEohIGdjSnUIoYLpyZsRcyy
         rpvA==
X-Forwarded-Encrypted: i=1; AJvYcCWuVduEaHjl9ONFUrz709FlTuDpHndtqIWhGxCNFzOLy50bpkvsMY1CSg/bFQuKzvhmidyIaR/gpxTylTs6eC7Rff2KNjEY9QdWtnwn
X-Gm-Message-State: AOJu0Yz47u1It0I0I7NoNXUIsTOJU2FFk7vkI6MEhshRL3bxGp6sI32m
	oqhNqZZxNFGtWK7P7F10bbXbk9pXMG9M4XSRteCJpJ+TbiDf2y0oEzzAFWqHmMs=
X-Google-Smtp-Source: AGHT+IGdu3sTsVj5pjxhy4ECPzYDAu8G5MlflGFu8A707RBlJ/Pa6FNwGTlbSqurHC22ggY2UADy6w==
X-Received: by 2002:a17:906:8d6:b0:a3e:91fd:c0f0 with SMTP id o22-20020a17090608d600b00a3e91fdc0f0mr5537134eje.49.1709016793910;
        Mon, 26 Feb 2024 22:53:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vh3-20020a170907d38300b00a433634ba03sm458176ejc.43.2024.02.26.22.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 22:53:13 -0800 (PST)
Message-ID: <90ab2113-f3f7-4d1f-83ca-aa57cbe63a79@linaro.org>
Date: Tue, 27 Feb 2024 07:53:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/6] net: hisi_femac: remove unused compatible
 strings
Content-Language: en-US
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69590A200BDDD6D3DA4CD2DA96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 02:51, Yang Xiwen wrote:
> On 2/26/2024 3:55 PM, Krzysztof Kozlowski wrote:
>> On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> The only documented SoC Hi3516DV300 does not receive any updates from 8
>>> years ago. With the recent driver changes, it unlikely works for this
>>> SoC anymore. Remove the binding for this SoC.
>>>
>>> Also it's hard to get the version number and it's unknown how the
>>> version can be used. Remove them until it's really needed.
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>  drivers/net/ethernet/hisilicon/hisi_femac.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
>>> index eab91e011d11..9466ca9da2bb 100644
>>> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
>>> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
>>> @@ -990,9 +990,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>>  #endif
>>>  
>>>  static const struct of_device_id hisi_femac_match[] = {
>>> -	{.compatible = "hisilicon,hisi-femac-v1",},
>>> -	{.compatible = "hisilicon,hisi-femac-v2",},
>>> -	{.compatible = "hisilicon,hi3516cv300-femac",},
>>> +	{.compatible = "hisilicon,hisi-femac",},
>>
>> What is happening here? Removal could be justified, but then order of
>> your patches is totally wrong. But that hisi-femac is a no-go or provide
>> proper rationale.
> 
> I don't understand exactly... In dts, we commonly have a SoC specific
> compatible string first, generic compatible string the second. e.g.
> 
> compatible = "hisilicon,hi3798mv200-perictrl", "syscon", "simple-mfd".

There is no generic compatible here. hi3798mv200 is soc.

> 
> So i think this is recommended. Or does it mean we only need them in

It is allowed for certain cases and recommended for even fewer ones. Do
you want to say you have fully discoverable features here and you do not
need any properties? Or you want to say that all possible hardware will
have exactly the same programming interface (registers etc)?

Best regards,
Krzysztof


