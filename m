Return-Path: <linux-kernel+bounces-52184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC71C849513
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6D31F24353
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A52111BA;
	Mon,  5 Feb 2024 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3kRcd1K"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB410A39
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120487; cv=none; b=Uy4GTyt7AChFrgK6TH/8TVtdeoK9RoKrkOwbvOlj2zo2HyRNwkc3KCmx3Bxt5tOtJlaR2XOdPymC/TaDeCTFQzzgtNI9SFxDGi3QPalaybsLZW57/HVS9s09DW48JfwZPF3+U/uhgkwUV+cU5pBsl0rDETOtf2mkCWzJimvD6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120487; c=relaxed/simple;
	bh=bWM+0D1lTtcuG1JP4lEahFhZoqCkvK/+qMR0LGWCa8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OIASteIvg78BkRRivxzLZkLy7g0/HyBDipeDigEh/khEoVkF9WP+BchnBfsu9uWU5hPo1bUJwmN3fWYT4tmF5QnGyuIBaZkJjI+IuRhSVyeeI1Vzlg/Lifm1lRmYpgIJWY2e9rwax+VTGM9TnbJihTyLco43svbKQtfNYBh4SWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A3kRcd1K; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso3522433a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 00:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707120484; x=1707725284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTVDJ7kokpaWFwqAappHoDtn4ysbGjAW3398RVhJk3M=;
        b=A3kRcd1Kz6eEANiCQpa63nNfjCTEl7PZapUjUO9YxCZoJcIsLUbr4nFD8G2Z+zq0m6
         0Ed3zfb9b11Wd+8jro7UZKKLje4rlRVQLP0JB93eB/zHyVke9Ueb52Pp2eKnlrgdbH01
         zL1AZWWHsFhky8PdSxS5Dr9gtA7jVsnWDuE9l6Pat6Bbgk/zGayDZRmrN//80flKktrp
         1DJlMvrqNEbGUiOmg+3dYBrEtLzhX1HElB8h/QzVTFqo3zt+WGQvnCcH0kyfMyGOjDbG
         jEDugXNdTDXOnXMqtxFdgOwHDwG+CcAoTn9YbcPiUsaNiAZTCvLSL2wZqhLERU+jsqGo
         xUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707120484; x=1707725284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTVDJ7kokpaWFwqAappHoDtn4ysbGjAW3398RVhJk3M=;
        b=vFY6+qa/GD93/+2LRYk3NcYCHtGrJeUT/Dh9kFx56JWL5BNuKvqFMYUVWRxlWmRyXS
         w8D9kJDZyhNdzXfWtK26dTmjY86sbDmRX4F/FoTGxhGQDEFd2lA6drk52q2h2lzHSHX5
         9XxHU/GyOQfizYXTTUN5UFJH54vCKcGiUo8E4tCu2def8NwE1oIqOxngdn5MkkuNC1aQ
         iXiI2oymzBLt3m/20/bkUdCTsS2YWq3UMULQnls7Y3u7MBDlt1SgVgKNuQd0BN0JtFFf
         AN1wIMXxDSV9+1Qow3WDOGxlhccFKpobR1ovDkuXvzYGqLRfiSLNebSd3J3PVqArn0Rz
         /gyQ==
X-Gm-Message-State: AOJu0YwKaXnuAhvK6i5QywTr5wSFPr2gdeRtkV8eipPI8O+lJdevyp3s
	Hhaa+Q1TtTDz9FYbUbBQS6Lo1FxJux8B85zqSirfXgIqVu35uGNAHo/KuVygHJc=
X-Google-Smtp-Source: AGHT+IEdX1mmPyWx1Qh9N4TPEN74j3i7d2iQbKVGHYEWh/rr/lD4xHYSjuyP0Dk4I1GuaispotiJfA==
X-Received: by 2002:a05:6402:1647:b0:55f:e147:2524 with SMTP id s7-20020a056402164700b0055fe1472524mr4127840edx.38.1707120484024;
        Mon, 05 Feb 2024 00:08:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQ8VURNcFDgOTc8qvBT9g8xs8vufQCAvYX806+iJF1Uuk6pxkIgP+RUT4mTwW9l3YOp6WBKBdFsgj4bv+sBr6vIsLuf8scMrN08HVyP9vGbNoB6SeoziAEdPg7g9qFWCjn9BBmAuEFqrERFsoeG39+xUXxezPhAUhe2kPwJVgn0O8GAgqBLfG3SqmvS/ehDDQtDCPX2cp5HFfOZGXvFBWwDNld+9/cKFGfqc856ZdC7fNsk1KW4YR9gh2wXQ0aUb4JrGw+BsTcdtRxHN4NBcV5Gyoxa98XrV815EO8wW8H5Dso7e2ikeJJJekd24iEXUs7eacqdovIFmFXWjIBICUQm73zlKDpg/+ym+DYmAbrJcvSKYmVNAd6lR2OFDJwovY+b+qkZDmHzO7RmQA5f42+7Xr6uNx6HZn8APXfHziQSCBNqjtgIngEGDV1TeE1/+/wW5RNjFJvuQzbiqvz1zG+RjVZrGizqywlCpLN8vq/lOC1FqXiVENEG4mAmgToG5EttnlsrfpnFqeCBGKpjqRSi/3uJ/f2bT4eXZj6cSl3Edzr+k1s8CFbDOEecsPPUqoAuxChCnOHVnR9AEOSLgPSrKVrYgR/+B8xx2wPOm/5EyfxmMw/9DzyqtPOZCaV3DIhyyDIWZk2QaIQtQ1tv/XGZtNqF2ZsUbbqj8RyYpwtYTSbMKj5Ox2xB5crHwppdLDZP8TS7dqolv9JthtQps/74YcBaHsQzoQgxWPCswRoDqQeBgcThe0IxZzUtQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id u2-20020aa7d882000000b0055ffe74e39dsm3052782edq.85.2024.02.05.00.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 00:08:03 -0800 (PST)
Message-ID: <d6f787e6-a243-410f-ac6e-c57ea5309838@linaro.org>
Date: Mon, 5 Feb 2024 09:08:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek,xfi-tphy: add new bindings
Content-Language: en-US
To: =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "john@phrozen.org" <john@phrozen.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 =?UTF-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
 <bc-bocun.chen@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "dqfext@gmail.com" <dqfext@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
References: <702afb0c1246d95c90b22e57105304028bdd3083.1706823233.git.daniel@makrotopia.org>
 <adf20671-2f1d-43ea-8584-df0c0b095865@linaro.org>
 <031944545677573672000aee8f97149e56c15f83.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <031944545677573672000aee8f97149e56c15f83.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/02/2024 07:17, Chunfeng Yun (云春峰) wrote:
> On Fri, 2024-02-02 at 09:21 +0100, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 01/02/2024 22:52, Daniel Golle wrote:
>>> Add bindings for the MediaTek XFI T-PHY Ethernet SerDes PHY found
>> in the
>>> MediaTek MT7988 SoC which can operate at various interfaces modes:
>>>
>>> via USXGMII PCS:
>>>  * USXGMII
>>>  * 10GBase-R
>>>  * 5GBase-R
>>>
>>> via LynxI SGMII PCS:
>>>  * 2500Base-X
>>>  * 1000Base-X
>>>  * Cisco SGMII (MAC side)
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>  .../bindings/phy/mediatek,xfi-tphy.yaml       | 80
>> +++++++++++++++++++
>>>  1 file changed, 80 insertions(+)
>>>  create mode 100644
>> Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,xfi-
>> tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xfi-
>> tphy.yaml
>>> new file mode 100644
>>> index 0000000000000..e897118dcf7e6
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml
>>> @@ -0,0 +1,80 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/phy/mediatek,xfi-tphy.yaml#
>>
>> Please use compatible as filename. Your binding says only one is
>> possible (const, not enum), so there is no reasoning for different
>> filename.
>>
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek XFI T-PHY
>>> +
>>> +maintainers:
>>> +  - Daniel Golle <daniel@makrotopia.org>
>>> +
>>> +description:
>>> +  The MediaTek XFI SerDes T-PHY provides the physical SerDes lanes
>>> +  used by the (10G/5G) USXGMII PCS and (1G/2.5G) LynxI PCS found
>> in
>>> +  MediaTek's 10G-capabale SoCs.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^phy@[0-9a-f]+$"
>>
>> No need for nodename in individual bindings file.
>>
>>> +
>>> +  compatible:
>>> +    const: mediatek,mt7988-xfi-tphy
> Add a generic compatible "mediatek,xfi-tphy"?
> 
> Other socs also use this phy but not upstream.

Are they here? No... They will use this one as fallback. Stop insisting
on some generic fallbacks just because you do not like using other SoCs
as fallbacks.

You ignored other comments, so I understand you agree with them 100%.

Best regards,
Krzysztof


