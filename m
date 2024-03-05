Return-Path: <linux-kernel+bounces-91777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D370E871673
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909F8B2538C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD587E774;
	Tue,  5 Mar 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNTMvztD"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941A7D3E8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622730; cv=none; b=c/UbGaEoGvKxzIccu0P65Je1Iysgd9jTEvcjaq+rsVTax2idNDwArufG78GRAc6utJwgM7/yIIo3q/FTKV1idBmWRyZgsPRz22LVHtoqu6W7zabd9TFLHADhQ2PW6x07LOPsrDtUEi5kIG31+CAqquzPNzdDCO3oZKxgaeDh7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622730; c=relaxed/simple;
	bh=9nDrOEq8uUH/PadC1spOb6s3TIZ8zE2pyhQtq0NjJ5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRriuJU6OXFXCKO8/b4Agc2xE3GuW85RSAV2tok0CR7nJSkEhBhd/4jtyB5JO5VjgUTpPWqpsll0E7PvayelDXj4hMCbDKtLYppLyCv3SPiGZGiegnPwOxCEAD0wh+AiVFwj5oTs+nl9z0z+Okza/4wtEr7kEcDAAVguaMkcxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNTMvztD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso23250611fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709622726; x=1710227526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rnu6XMuMOVJz2kVOkfY7rMB2HqMl7o2rDtmatC4pNvw=;
        b=eNTMvztDei5c75mL0ScoWpSv4JB8deG6I4Ry1ABVpdV+V6++9ktBf+0nbCgmMq1gSQ
         GX8w725OjQtNSZqRfjks1Oiq2sbGvk9deXc/JLQUdNUMPLunI1pd3ZIvLoSmqJj3oq/p
         Q/hNPXGlsGm9u8FHbfXtFFAUVsff/c4ZrboV7/q5LkVo75bO3kf+qD47gtAICrt/azT2
         0SJPkZnA8KHSZYzmPVTTsQEKS5r+wzTr8Qsu+iMCEMtO5Z4ow295wIJMFu6DfIhgil5S
         hYjr0qfis/h+wIiHGsI0/uZMxMSaMk2Z/B5wEAqmRAZ5snRZWv6OIEVLHZco1hEE7cuY
         drdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622726; x=1710227526;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rnu6XMuMOVJz2kVOkfY7rMB2HqMl7o2rDtmatC4pNvw=;
        b=XYysGtcnb1NdD7Jgmd2Bw5zitfawsmnK9hvlGG2LV4Wqq/tfZ5yA/OwqiP+8Rm6Npn
         ZQV4ZbfYuelFbJOVzt6aCuKMzphqePmDLiRrMU0Lg2/Yg6RlOMtmfV4UX/Al+c5ZxKal
         KjMKnMUtvR410Y/I4jUmC0dBfOU3l1fWzpr4WF/SiAWp/Q2rkVCgZsu/HFfocicGUfPX
         Kkb/hIRUFvE5HnCvBlZGyw/o+mand/GIsf9983Z6FESYlZuQYORnXLyBlxchIRajx/9H
         LoP5FzrGBWJKRIJQxG7mukiTX742ncaq/hRzZglWEHA2dEcewidUCnahyaCikJBDO8cV
         HYxA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8nftM4gk+fdyW8vJzUJUr79teNm5GS/5QUngerGpjGUocAMew4fPQhvWNmNED8e550313x4ereFnVTfrF43BinewDCg8eYpBe1y5
X-Gm-Message-State: AOJu0YxMeNXBLzC5FU4mFGbD2neZg6Re+kYYASTcYqJ7tD2myXtdlOns
	DA76p/c8WxyYTVDX8EL4zNlR5RXO62lypNl8wAZPVVLq6SH2Dh4cnLyWKk3IXSs=
X-Google-Smtp-Source: AGHT+IGIJhZeo0cluzFNGhHnMPB+O6JQ9/ltfMrWYzEUprJTWw+6kPoPIYM12Q5FiUDiM2oeyShSkg==
X-Received: by 2002:a2e:9f06:0:b0:2d2:6d19:75ff with SMTP id u6-20020a2e9f06000000b002d26d1975ffmr575559ljk.50.1709622726394;
        Mon, 04 Mar 2024 23:12:06 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2709475edb.57.2024.03.04.23.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:12:05 -0800 (PST)
Message-ID: <1a722d0a-9fd9-40de-84d8-9f7e080ed648@linaro.org>
Date: Tue, 5 Mar 2024 08:12:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
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
References: <20240301-net-v7-0-45823597d4d4@outlook.com>
 <20240301-net-v7-4-45823597d4d4@outlook.com>
 <2c90731b-709a-4baa-963a-fbd35372fb3b@linaro.org>
 <SEZPR06MB6959B927591D5FE1F4B4D1D196222@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB6959B927591D5FE1F4B4D1D196222@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 03:58, Yang Xiwen wrote:
> On 3/1/2024 2:49 PM, Krzysztof Kozlowski wrote:
>> On 01/03/2024 04:35, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Convert the old text binding to new YAML.
>>>
>>> While at it, make some changes to the binding:
>>> - The version numbers are not documented publicly. The version also does
>>> not change programming interface. Remove it until it's really needed.
>>> - A few clocks are missing in old binding file. Add them to match the real
>>> hardware.
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>   .../bindings/net/hisilicon,hisi-femac.yaml         | 89 ++++++++++++++++++++++
>>>   .../devicetree/bindings/net/hisilicon-femac.txt    | 41 ----------
>>>   2 files changed, 89 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>>> new file mode 100644
>>> index 000000000000..ba207f2c9ae4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>>> @@ -0,0 +1,89 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Hisilicon Fast Ethernet MAC controller
>>> +
>>> +maintainers:
>>> +  - Yang Xiwen <forbidden405@foxmail.com>
>>> +
>>> +allOf:
>>> +  - $ref: ethernet-controller.yaml
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - hisilicon,hi3516cv300-femac
>>> +      - const: hisilicon,hisi-femac
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
> 
> 
> Could you please tell me which one did i miss? I have read all replies 
> to v1-v7 once again and fails to find one.
> 

https://lore.kernel.org/all/11d0bf3a-3341-4c7f-9a1a-e7c7bc078725@linaro.org/

Best regards,
Krzysztof


