Return-Path: <linux-kernel+bounces-26490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF9C82E1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743E31C22510
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8ED1B299;
	Mon, 15 Jan 2024 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOfiTTxF"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4961B275
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28b2e1a13fso957471066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705351403; x=1705956203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4rNyxIrXdrJfSwgY5I4UTH/t9CKdoBFSSdIUwYO4qE=;
        b=gOfiTTxFKuJvi+Dy1P+SLiNcnlRb73VeU73Sw3WV6+kC4o5G2s5yo5gcRAFubDx7YY
         0C51RcVqAQ529N/eBxnwKNZXW+6W3nfLbflBRFaN0qXSAZHYhB62FLbK5Zzn9DHRgXGb
         o5nl9mJDfl6h2SWNdt5E7rBfyR03TNzr8h+dsmOmk4l65gbf6txUgSXn6u2nBR7BtsJB
         0Si27Aj3SfRU7DuqpB8foOgRwCqX7zT58sSFWWyZ8MA/xCkJWyNnnOfpFWVFgR1evxtS
         6gw+escJpT/XpEztLy5Mc9bLn4SvKfoLKNmlfAifQ0ag1kSSKrPOh1l8X1lAUkH7T/b7
         j5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705351403; x=1705956203;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4rNyxIrXdrJfSwgY5I4UTH/t9CKdoBFSSdIUwYO4qE=;
        b=OvjXJOt9Y+7LbqeoOUeXksbjzTuk2mVXz8L4QlRG0HBgyh7irIysJEUC+ppzNFumIL
         +fe8oPYczaEj/tC6m22gYt2jXVtNCuUcZvHDBmqlQR7DRkO4tdVTNSJ6dtQ4TGfyaNQN
         zsUGGi8lJNRPIaUDBBySbdfr+zCUY0ftf2P4cGppeq1AKI9d018fG6D2Hhwriviql7Va
         EMNmtwR90P1IUeVLOYiv91N4pCLpRDn5Q2aVvZQt6+JubyF8MvwhzIpckQg4HBH354bt
         e9wlVYkGy1R0/ZfrQqhaNPUQNcsBRhBOVZ6muyZ8MM17rVNTiEs0fnI2QlHlywD6hnUY
         xn6g==
X-Gm-Message-State: AOJu0Yy22jaFaMNydiqfySs9LuZ/Oxlv/QJNkLLCa/vVczOCJYQJWQad
	lijrGQnK2H1/ICmvRrFi8k5t2s+Q/mpZ+Q==
X-Google-Smtp-Source: AGHT+IHE1IK67lYmlAAWORzLAE+iFpAZy4xB89ddiThaLpeFNhdRTfdG3avQYMtcqxx+dJ6NUSOJ2A==
X-Received: by 2002:a17:907:a0d3:b0:a2d:474e:8236 with SMTP id hw19-20020a170907a0d300b00a2d474e8236mr2033092ejc.134.1705351403465;
        Mon, 15 Jan 2024 12:43:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090639c400b00a27a766c6c8sm5658529eje.218.2024.01.15.12.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 12:43:23 -0800 (PST)
Message-ID: <aeeb0dfb-87e2-4024-9d4a-0b9529477315@linaro.org>
Date: Mon, 15 Jan 2024 21:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: xmos,xvf3500: add bindings for
 XMOS XVF3500
Content-Language: en-US
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
 <20240115-feature-xvf3500_driver-v1-2-ed9cfb48bb85@wolfvision.net>
 <333c2986-c7c2-4a46-90cf-b59ae206e55a@linaro.org>
 <96abddcc-fa65-4f27-84fe-2281fe0fcf1c@wolfvision.net>
 <644f7f02-405d-47fb-bc72-4d54e897255f@linaro.org>
 <5db4b898-93d5-446f-bfed-b57847f9967a@wolfvision.net>
 <435f502c-1e1b-4d40-8dcc-34487905d69c@linaro.org>
 <b7f76546-9998-43e0-abff-a4e73817dbae@wolfvision.net>
 <47bdc31c-50d2-4d33-9339-5132b6364539@linaro.org>
 <16027339-0a82-4dd1-86aa-19fda6e23f88@wolfvision.net>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <16027339-0a82-4dd1-86aa-19fda6e23f88@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 20:43, Javier Carrasco wrote:
> On 15.01.24 19:11, Krzysztof Kozlowski wrote:
>> On 15/01/2024 17:24, Javier Carrasco wrote:
>>> Do you mean that the XVF3500 should not be represented as a platform
>>> device and instead it should turn into an USB device represented as a
>>> node of an USB controller? Something like this (Rockchip SoC):
>>>
>>> &usb_host1_xhci {
>>> 	...
>>>
>>> 	xvf3500 {
>>> 		...
>>> 	};
>>> };
>>>
>>> Did I get you right or is that not the correct representation? Thank you
>>> again.
>>
>> I believe it should be just like onboard hub. I don't understand why
>> onboard hub was limited to hub, because other USB devices also could be
>> designed similarly by hardware folks :/
>>
>> And if we talk about Linux drivers, then your current solution does not
>> support suspend/resume and device unbind.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Actually this series is an attempt to get rid of a misuse of the
> onboard_usb_hub driver by a device that is not a HUB, but requires the
> platform-part of that driver for the initialization.

That's just naming issue, isn't it?

> 
> What would be the best approach to provide support upstream? Should I
> turn this driver into a generic USB driver that does what the
> platform-part of the onboard HUB does? Or are we willing to accept

No, because you did not solve the problems I mentioned. This is neither
accurate hardware description nor proper Linux driver model handling PM
and unbind.

> non-HUB devices in the onboard_usb_hub driver even though it supports
> more operations?
> 
> I am adding linux-usb to this thread in case someone has other suggestions.

I don't see any difference between this device and onboard hub. The
concept and the problem is the same. Therefore either treat it as as
onboard hub or come with USB-version of PCI power sequencing.

https://lore.kernel.org/all/20240104130123.37115-1-brgl@bgdev.pl/

Best regards,
Krzysztof


