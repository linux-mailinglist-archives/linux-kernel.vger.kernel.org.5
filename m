Return-Path: <linux-kernel+bounces-4868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4581831E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3303286563
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3411709;
	Tue, 19 Dec 2023 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2XmDEMi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC80134D3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so475995966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702973566; x=1703578366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmhIqoB53ag/nQhOn6BK8OjhL81MvoTIirX6y3qIAoc=;
        b=a2XmDEMiJQHh0+0BSlQhtDkJlrOC1g3BnDqYZqpHB+rjZE1kUehuY7K34tU7tpER7r
         DpvGJ/adFfguVxBEqfseZJ6nhj32WVBAIEOxtoKxrRJA5XzO+W6T+rwWJjd5u8va94MA
         G1I3gZqPR0ACAO75v3+tXaOP97deMqpdUTzzwJVePKasGTJ8bCHnr+AHVUo0bJkfwyTG
         Cgp+YkyV7StB1lUbBNaINGNGcvpIueLntyz6c9Mn5HF537f1eaCOU76OOz1F5smOxhFR
         9Furs4hXZNt3234OsD6fZ3262tJsl3Hlv1qog/hsqcQSRw3qgCmP7GABMUN/u6hLEuZR
         Y0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702973566; x=1703578366;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmhIqoB53ag/nQhOn6BK8OjhL81MvoTIirX6y3qIAoc=;
        b=lv9cvwQKjOHIcdDFu8JBRk7GX6tV+NkqNybx1ZSfr5vVYFESY6pmfKsmiZllmlYCEE
         e9UodA7b48GevSbuivkXZX9/WYmOHSZkeHq7d3bxneAHlrldw+ACh7sZx3EkcnYmlTRQ
         stQwnOCF/Lz47U2pQKV5p3i+Ohbcnjo6KTZOa60hvYQ6H6GPKY0uXCbk/OV7jWPPs6cX
         dgvsK8HUAvk1Slnd59pIJaLwuqxB3IVvsJOKYM9DsMaYa7xBfYEzc4l1Dqw2M8jDx+dJ
         8771u9py/AsTDydlA/8O7T40KEjtTMCwng/VMb4bBHMq/0f4szdULGDMWf8y5ifsx4Ha
         Cvqw==
X-Gm-Message-State: AOJu0Ywkq43RzheEAfGTj9S8Qo14SKrdztSI5dETvl186364iTEdVgc4
	MkyiUp6ZrEmUdhbXAzTIvifusA==
X-Google-Smtp-Source: AGHT+IHzGLJBdYFxxeyoQevCcNYUoYnJYgX6ON7U/Cr5RUou3gZTgoBrDnZE7eY2aoJEgUNMF1YgLg==
X-Received: by 2002:a17:906:3295:b0:a23:7490:63be with SMTP id 21-20020a170906329500b00a23749063bemr261793ejw.32.1702973566213;
        Tue, 19 Dec 2023 00:12:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id um7-20020a170906cf8700b00a236263d825sm1544924ejb.35.2023.12.19.00.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 00:12:45 -0800 (PST)
Message-ID: <e8cdfbb4-920e-4d3c-94ea-be24a7e21d57@linaro.org>
Date: Tue, 19 Dec 2023 09:12:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: ti: iot2050: Factor out arduino connector
 bits
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
 <202d324ab0aa3728c8f846d31bedcbaba14aebdd.1702917360.git.jan.kiszka@siemens.com>
 <10f300d6-8a1a-4363-a16e-8337da8525d1@linaro.org>
 <f4b16dc6-1063-40d4-b68e-1eef9db32829@siemens.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f4b16dc6-1063-40d4-b68e-1eef9db32829@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2023 09:06, Jan Kiszka wrote:
> On 19.12.23 08:51, Krzysztof Kozlowski wrote:
>> On 18/12/2023 17:35, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> A new variant is to be added which will not have a arduino connector
>>> like the existing ones. Factor out all bits that are specific to this
>>> connector.
>>>
>>> The split is not perfect because wkup_gpio0 is defined based on what is
>>> common to all variants having the connector, thus containing also
>>> connector-unrelated information. But this is still cleaner than
>>> replicating this node into all 4 variants.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++++++++++++++++
>>>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 753 -----------------
>>
>> Please use proper -B/-M/-C arguments so code movements will be detected.
>>
> 
> Those are in place but have no impact, likely because the source file is

In place as what?

> still ~700 lines after the shuffling.

The original file has 720 lines, so if you move 750 (!) of them, I can
hardly believe the rename cannot be detected. You are basically moving
90% or 95% of file, so this must be represented with proper diff.

Your patches do not apply on next, neither on master, so it is tricky to
check.

How do you expect us to review it? Compare line by line?

Best regards,
Krzysztof


