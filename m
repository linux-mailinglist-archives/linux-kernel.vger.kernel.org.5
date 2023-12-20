Return-Path: <linux-kernel+bounces-6470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537EB819968
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726D31C21105
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DD7156E2;
	Wed, 20 Dec 2023 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAn9B/OX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBF168C4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c2308faedso62919495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703057119; x=1703661919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuEyF1nHEUHBigvUtzAj4vJ9027dwktNZDyXx5jvFzY=;
        b=aAn9B/OX7QXZnhLsKnkORdCELU5tndhiqIYPGfdCcNAAEBsDqUl6hrqutA9N04pJrm
         gQZKyHskEQdLmR4zExYFsUwSzKiQQpbyI/7MmmmEV9l3vXAUHiHipGoiH8CwzTWlx6fb
         OGRZldRm1cUQqAyZ0WFyg/0jq9C1d1aOz4L3e3XmHqq05sVmRg6S3mNfpoMlAYTXYmnd
         jkaQxtkyGqAuLhmUPLfXoY/KYrOf2YenRCH78SEJBlvi27oUmgQLm/Lj2RrvYHaeYUrX
         WOXWFQiAuOrXaxLKtts2N6AurXYuNW9hcBZ8eDEsWZYVJs0oELnwNUz9F7yX0ipjRTQ8
         /w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057119; x=1703661919;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuEyF1nHEUHBigvUtzAj4vJ9027dwktNZDyXx5jvFzY=;
        b=kuKZvtpBKHgdawGiH7ZCIXXQeKKvhCJMiOmSL/NPGpDAsunbcgoRK9A0iVzQnRtLAa
         IlaN0UpUE6SzY+sZSOpURitwMPPHh3Qh+HZqrUm6VK/wazcJVYzhD/8XgD6mwX37Ubb1
         eDPe+klRQ8/vZViaWyb/oogAi8gj2hMbLHeKM1iIp4ebROy8w8GwpvlUtIEZdHVPHA6u
         8/e3Fa4wBQ1fGsJytKOqWItTaVyc69tIBL/w0EGUclnSSXAcpidYHAcn71o5LPvKsqcC
         8nE3FK4mUFVRsmM267gNTp7Gt8BIuPJsa3zatiLsqbajndHsFRZtMHk0mgmXI9ujfs19
         2xxQ==
X-Gm-Message-State: AOJu0YyMJDx0s6D6PxOiYxcrPTPca/NrBIZPG6UQfa61r4YZlpaw4fMQ
	kzbwCd75pE4PjoOJxqCFnkcNzw==
X-Google-Smtp-Source: AGHT+IEtfpzJCmNJux67Lj6mVECddYG6Pmv2DNH4elbWeODQo+S3bojlgpi0KB4JeKqmnIeVlwQRZQ==
X-Received: by 2002:a05:600c:3d8b:b0:40c:272e:49ea with SMTP id bi11-20020a05600c3d8b00b0040c272e49eamr10282694wmb.123.1703057119121;
        Tue, 19 Dec 2023 23:25:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c4acaa4bfsm6126622wmo.19.2023.12.19.23.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 23:25:17 -0800 (PST)
Message-ID: <1050b195-9ac2-4c63-88b0-d8ba3299d334@linaro.org>
Date: Wed, 20 Dec 2023 08:25:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Content-Language: en-US
To: =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
 =?UTF-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= <Eddie.Hung@mediatek.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20231215073431.8512-1-chunfeng.yun@mediatek.com>
 <d50abf1a-1ee7-4f84-9f53-69dfe9aad103@linaro.org>
 <2f38caeb95fe9b2d01f158fd91ed0cedafa5d2fa.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2f38caeb95fe9b2d01f158fd91ed0cedafa5d2fa.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2023 03:05, Chunfeng Yun (云春峰) wrote:
> On Fri, 2023-12-15 at 08:36 +0100, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 15/12/2023 08:34, Chunfeng Yun wrote:
>>> For Gen1 isoc-in endpoint on controller before about SSUSB IPM
>> v1.6.0, it
>>> still send out unexpected ACK after receiving a short packet in
>> burst
>>> transfer, this will cause an exception on connected device,
>> specially for
>>> a 4k camera.
>>> Add a quirk property "rx-fifo-depth" to work around this hardware
>> issue,
>>> prefer to use 2;
>>> The side-effect is that may cause performance drop about 10%,
>> including
>>> bulk transfer.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> ---
>>> v2: change 'mediatek,rxfifo-depth' to 'rx-fifo-depth'
>>> ---
>>>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml   | 12
>> ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-
>> xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-
>> xhci.yaml
>>> index e9644e333d78..e44a71acb5c0 100644
>>> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
>>> @@ -124,6 +124,18 @@ properties:
>>>        defined in the xHCI spec on MTK's controller.
>>>      default: 5000
>>>  
>>> +  rx-fifo-depth:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      It is a quirk used to work around Gen1 isoc-in endpoint
>> transfer issue
>>> +      that still send out unexpected ACK after device finish the
>> burst transfer
>>> +      with a short packet and cause an exception, specially on a
>> 4K camera
>>> +      device, it happens on controller before about IPM v1.6.0;
>> the side-effect
>>> +      is that may cause performance drop about 10%, include bulk
>> transfer,
>>> +      prefer to use 2 here.
>>
>> What is the meaning of 0-3? bytes? words?
> 0 - 1K bytes;
> 3 - 4K bytes;
> I will add this in description

No, don't add. Just use correct values. 0 means 0 words or bytes. Not
1000 bytes.

Best regards,
Krzysztof


