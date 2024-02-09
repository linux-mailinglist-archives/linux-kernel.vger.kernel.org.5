Return-Path: <linux-kernel+bounces-59149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043B84F222
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D191C22427
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1A664DD;
	Fri,  9 Feb 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejW3Ayfg"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48FD664CC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470227; cv=none; b=qzrAInL75xKyRbZ+cl+GhuEEkD1YIpr+sdYBjU1ZNLJ4GKmkX3KI6MTSlzKY3cqBtUe0cWTzAXhteV+9JUDglU6hjSr6kFWyNeAdCFbKwXWxLDlhNFlxbc0gxmHBklTNVqB/gbgYyYEdvAFOZMr/pJqn/f855zWbjgDs7RLSvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470227; c=relaxed/simple;
	bh=QF7+mfc6JS7As0X+3/fSZZd7eRxk52TBfXpLkNJIluQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfoocPXUUz8nQ7MCeZH8liU4jn4ErdcnUmqdVIMYNmSq6G5ZDYUa46yJwxN7hO1urSIb4Dd+dfRwVSoAkzjwEFPdPGp8umOjJWVEsLDt0zKZZoTD6HBeIbgvrNxOp1K0RhXhw1GutpA0bdnvYv3QJ7P8YiskU1OK03YaiAmgvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ejW3Ayfg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-339289fead2so350958f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707470224; x=1708075024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GapI84HT0kfFvAt1Rf92RVH8aiJZyoBWU7byRRdSVL4=;
        b=ejW3AyfgFNzbohr9HxKE3djr7QaNRoGL3eC2lLQZLthLa0e1dSiD+5iEMxKfbMbf/Z
         mfZrjNGbnz+lau+V2aXwijLXFvyh4jZStVDdqDAYL9373aJq/Lz9+yuTY/l5KQm8Tiqa
         FEHDh24lOaQOosZ1F3e/4iE++aabchaLTaAAuQnim7IEYryXKEpKzm4Gi5vhxCE09E+a
         b6PXi0LxB1TQHDc01lq6nfxBl/aytSRgzN5Pz/2vIgkuRbxxRu5LHsQ2B3pb+gS77W3U
         Ht7Mf0toaK9ooXXrGxH5Qii6LGRh6Yin4AxLNnktc0T50vK7hTFMoKW1QU95Ghsplah9
         0BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707470224; x=1708075024;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GapI84HT0kfFvAt1Rf92RVH8aiJZyoBWU7byRRdSVL4=;
        b=nUV2cw5DIxGoMYeYf7O+wsJuTo6r8DmrRfAA130Vf4vak/4ZgLCLeygZ/asVb4QFpF
         5ULoT5VDF5wtHzPzvLDQuLLFg18hgY0ADjDZMok8THdzwbufoU61ymfDMTlF+2ElqDTt
         txmpOqMf2UXIL2zWkVgDyZvNyldp/VduXxNLklgPn5DftxHdxaGN3+lgI77cT+C3x6gT
         8/HDlr2Uou/koybeuW3A0F+5z5ayi1mYpQ/GW6t/FxhpDST/n+uj2NmLo4SqmoB8B16N
         F0sb9yrxu9aAycQtgQUkoCm21Nf4luJIZmFcIHX6uKqgA1e7YYUHZBmf3olWvrlAfGhm
         OigQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1VPV5upI2+lX6QPU3lddwTu6MbJDx8Fpp+XondpB5AzYA7SivkE5yefu6sxPtWgBn5QR+yQo2T/lgP96dOO/lBM5zQUB5wVx6kBIW
X-Gm-Message-State: AOJu0YzBD7e4RIFJCgduvZTTcB5Tsf/yJbFnetpIslVLklTV05TbgXKJ
	4lICPNDJ4JrgvEJo9jTA1TmA6wfAYWFN552sGyS5Pgm4E40CxwUahNJPBLfmEyM=
X-Google-Smtp-Source: AGHT+IEL4+jKhNaGP83vx0SWElWtFB2cbFXYGfD6EAHSLUCSk7mYTBBciXJEACH0ENtx+YfCko8PCQ==
X-Received: by 2002:a5d:65d1:0:b0:33b:28d5:f770 with SMTP id e17-20020a5d65d1000000b0033b28d5f770mr678531wrw.62.1707470224058;
        Fri, 09 Feb 2024 01:17:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/FXELrq/Fj+qsSxl92K6wiwQP6yLjcFsYaF74KjlVu1kRajvd+6ifegcwwCEjGQTY7rBTzMli0i5BxSMz5iTyRbtGv19IGi3zWX5v7EzvxqA+LpDEpJ/JKb2g9Qc/1p7VemWvY+OpM+qdExSprIUYsCFt/BBoi9v+Y4jZMnm9q+oPtw6LZVm0e6fgItUDilE8gd/PvoLN4IsSKCO8DUAORUO7FnnIRBwLUBYlHTLTBWoAuAlImtI4lM+WSZIqWAC495SqCzddXLvnf7TLX/m/eKyA+jV0451k82HhyATvtjhWMDhJfOk0PYj5JPdhgbCv326vzDS7Y4klvtARgCcDFMsNtSL2W/w0vW7oCbvEDd/E2EwuZpmBxw4X9W3uetZyYhafB6TbPkS4FqgDfcIoOaoqLwcGE13l1agxbApPI7tVrsPJvCW7BErcxaTIOZ4Ql4yqjmzY1O9nDeOLMXs4swOi1yaytU2oF3cdklZwLG/MFsEKr0x+WRIG0Bmqj31/5uE=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5305000000b0033af5086c2dsm1295848wrv.58.2024.02.09.01.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 01:17:03 -0800 (PST)
Message-ID: <502836d9-5a57-4614-b908-2adc0f01df33@linaro.org>
Date: Fri, 9 Feb 2024 10:17:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: arm: mediatek: convert hifsys to the
 json-schema clock
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240208215926.10085-1-zajec5@gmail.com>
 <20240208215926.10085-2-zajec5@gmail.com>
 <d4a4a468-4a81-413e-9de6-060c2ba9e0b6@collabora.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d4a4a468-4a81-413e-9de6-060c2ba9e0b6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/02/2024 09:53, AngeloGioacchino Del Regno wrote:
> Il 08/02/24 22:59, Rafał Miłecki ha scritto:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> This helps validating DTS files. Introduced changes:
>> 1. Documented "reg" property
>> 2. Documented "#reset-cells" property
>> 3. Dropped "syscon" as it was incorrectly used
>> 4. Adjusted "compatible" and "reg" in example
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
>>   .../clock/mediatek,mt2701-hifsys.yaml         | 51 +++++++++++++++++++
>>   2 files changed, 51 insertions(+), 26 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>> deleted file mode 100644
>> index 323905af82c3..000000000000
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>> +++ /dev/null
>> @@ -1,26 +0,0 @@
>> -Mediatek hifsys controller
>> -============================
>> -
>> -The Mediatek hifsys controller provides various clocks and reset
>> -outputs to the system.
>> -
>> -Required Properties:
>> -
>> -- compatible: Should be:
>> -	- "mediatek,mt2701-hifsys", "syscon"
>> -	- "mediatek,mt7622-hifsys", "syscon"
>> -	- "mediatek,mt7623-hifsys", "mediatek,mt2701-hifsys", "syscon"
>> -- #clock-cells: Must be 1
>> -
>> -The hifsys controller uses the common clk binding from
>> -Documentation/devicetree/bindings/clock/clock-bindings.txt
>> -The available clocks are defined in dt-bindings/clock/mt*-clk.h.
>> -
>> -Example:
>> -
>> -hifsys: clock-controller@1a000000 {
>> -	compatible = "mediatek,mt2701-hifsys", "syscon";
>> -	reg = <0 0x1a000000 0 0x1000>;
>> -	#clock-cells = <1>;
>> -	#reset-cells = <1>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
>> new file mode 100644
>> index 000000000000..eb429337cdf4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek hifsys controller
> 
> Please, "MediaTek HIFSYS controller"

Them maybe "clock controller" or "clock and reset controller"?


Best regards,
Krzysztof


