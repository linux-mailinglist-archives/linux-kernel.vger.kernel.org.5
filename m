Return-Path: <linux-kernel+bounces-86534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C786C6AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A3C1C2215B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4A64CC0;
	Thu, 29 Feb 2024 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4NZ3243"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1D60EEA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201860; cv=none; b=lvvCZHSOLuf9bhTZRXYuja3QGycmKIwi/wOslrzZb3Y3zaOP14QXldr7nU3U+243dqfQY9NuwvOB5ScVJeDAtBDeHU6kN5bBYjeUk9IcQK9OIq6E+d3ReAzFTcr7rkqDZxDJZxOJTSmEEMAb5yL/7UQlCUtma3jrIBEIZTi7qNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201860; c=relaxed/simple;
	bh=K1fJVSFXOapuZkRApsHKlwS0hpcsSRB/OwFwjlZSfP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pkz5ww87PlxnyxClGuMF62PvgWS29felUHUn5kSqyU9hmiufQfOgLyOpXetLHwffxzpaTgIgschNeTx6eoFZaKRtBK7fQFZH4XeIQMjSlOrnqQVcqZ078Zv+rsVE0Bk5ZGKHqTclGPs6hfw54bMwVmSJStlGlQpdNG17kriWq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K4NZ3243; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so107111166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709201857; x=1709806657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNpCczB7PZBZwd9gjheaAopuAgC3CSpSIIFa4Hwe2TM=;
        b=K4NZ3243o4J0mN1Bj7+L7jMVaDXdy0EzPtFc2UdjiiBh4xW3V6bXZMZ/dUF35DQrt2
         tusm3I21i+5tcAasUIayDAY0k+4tKHh5xz75w4CSoRVurujzAyEc7BxWTgHTgE7BS2fw
         4qMXMRLdcn4aq1EvgSp3HR5dXaJ0v0YGt9fbJaMqSAq4sCQHUyBhJIuedUo6ccmNV/0Z
         frLFK2eAplSuItCTkDkeVGR5x40YfPpOX60vUr5q6Lh1y3mW/r6iYq/fAt3gmkb/+3vA
         Lc5pKzumhHhcws2LudUOfa/3S5c1ncxEQLYWv6SJrNTdCObnb+thgVI9MKUon4wDaDaF
         C9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201857; x=1709806657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNpCczB7PZBZwd9gjheaAopuAgC3CSpSIIFa4Hwe2TM=;
        b=QTqZi3qX/ODvbIZNQBkcfDtK7/uSuX0WlrWrt7zvuoHiTYq1j1hc40BPb2TiHq0RBK
         4klShtoLgUvEWn1NIZYNBho8yru9VynYJbHTIuWgEk4XKgGVE2ug18pdhKNxXV+aaTrf
         JACOgym9zeXcaC8eEJc8s2QwKtb9Ywf7fAV1Fn3yvuBo9BFx1oaLoswmSd6hYJzcOlBO
         4dM54+e73vDJ95fHC4DnN0BlMk7HNDPHx1ehZYR4CvkUt0w3fzRnGVGLLTMlNDyOLjoV
         cfCATpEWkvQQMrN57VzYzOwt2D+cKorIn+/zC9GhUKEO179NoyDsyzSbNQCkw6bz/CI4
         YWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcTUpauxhJhlwNaOxCVrDuLAqBoB+sbakUerlkS3DBzS6nIhHlGysLKNe/TVDaxlutBkrQXIVDLZAO493D2jVCx4K75CcGaHpGEVes
X-Gm-Message-State: AOJu0Yyn12W2wPoWZul9rueFrs2fe6GDNSGGEFTV+zTGu+34BZ8bcbqY
	XI4JoisnRhzFaW/3SYeT8IkLRlP4x6QXlD/jmgZHwiJz15uuXsJ3qtUh2HvwtPI=
X-Google-Smtp-Source: AGHT+IGNkfe+mb0d0etTLBeLA+Sk/jlaBBJVD7gaG74Glwo4zX6IQSPHu8noXTtxlSg5JN9/2BAyQw==
X-Received: by 2002:a17:906:c28e:b0:a3e:34e8:626f with SMTP id r14-20020a170906c28e00b00a3e34e8626fmr1167823ejz.66.1709201857098;
        Thu, 29 Feb 2024 02:17:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id vw9-20020a170907a70900b00a42ea24f8b4sm522044ejc.108.2024.02.29.02.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 02:17:36 -0800 (PST)
Message-ID: <0a9a0a85-d345-41e8-a821-d537f1ce827e@linaro.org>
Date: Thu, 29 Feb 2024 11:17:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/11] net: hisi_femac: add support for
 hisi_femac core on Hi3798MV200
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
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
 <20240228-net-v6-11-6d78d3d598c1@outlook.com>
 <7c171041-30cd-41a1-8b8a-00168d112cc5@linaro.org>
 <KL1PR06MB69645ED79CED22F5BB1DE45C965F2@KL1PR06MB6964.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <KL1PR06MB69645ED79CED22F5BB1DE45C965F2@KL1PR06MB6964.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 09:14, Yang Xiwen wrote:
> On 2/29/2024 4:10 PM, Krzysztof Kozlowski wrote:
>> On 28/02/2024 10:02, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Register the sub MDIO bus if it is found. Also implement the internal
>>> PHY reset procedure as needed.
>>>
>>
>>
>>>  
>>> @@ -947,6 +992,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>>  static const struct of_device_id hisi_femac_match[] = {
>>>  	{.compatible = "hisilicon,hisi-femac",},
>>>  	{.compatible = "hisilicon,hi3516cv300-femac",},
>>> +	{.compatible = "hisilicon,hi3798mv200-femac",},
>>
>> No, it does not make any sense. Why do you keep growing this table?
> 
> So do I only have to keep the generic compatible "hisilicon,hisi-femac"
> or the two SoC compatibles?

You only need to keep here fallback compatible.

Best regards,
Krzysztof


