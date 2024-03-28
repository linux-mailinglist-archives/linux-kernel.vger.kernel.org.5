Return-Path: <linux-kernel+bounces-122631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7588FAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21981F2423C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB358230;
	Thu, 28 Mar 2024 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHeLh5Bc"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B357898
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616577; cv=none; b=UrzBdCwD35bA0YmefIKASLceZM6TI76MJkSeMEx5j7eBJmW2qU3vHEaG4l4wG3OUJZfwZnSGyA9SNjYBITvZmkpHNdGWWtn7zZAot8aq+zGRXtScW0mhWd9H8mhvncZQTSqQZpS89DfgY4qX8PBFKt6WRCW+V7RzUOZZmYz3QYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616577; c=relaxed/simple;
	bh=JjgYyUUaBl+PV0A5H1Z83FwloUk4nFkrY+/IViQuww4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Ew5AwGxpGB37F9xrjam3ZPAvz3Nnvf7jIOIK7wSVxWR1zDwCFLY05cImgHZLNs1QsjVa78cxbhn2vLhfTrcbYVGh/NDdBj5xv9Cf9oQEPRNn59tChaiLl0m0UiR2919KteTpQfqOyo0yu3/NaNQww8HI67LkDRrkrYOap30hP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHeLh5Bc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ddd1624beso432115f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711616574; x=1712221374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwyOlwPxgHT1CPKSoF7aGCVLvwYoa/el57EZd9pYFDc=;
        b=rHeLh5BcLOeODgxI/qGL5EC8NSwZRWLBzlm2CBxK68hLb5BH3wNuqicgLUtlpWlqQD
         MOWcytTW90ovv+hCGAaXqR8tLtk5hn0yMozMvOVz4tOGf2KCBZXu3WhxiEqZDQq7C5fT
         mbTx1yBoYqLWYiEghQUkrOxLMstWRGZ+j7tN5mgd1PdQBD4lyRmDSX/kKQsbXvWgSKy+
         khJ3hXfBLl5I83fFdQvzqWLBjbNb4hR6iX9I7pf/T5GPSXncqvJbHrKbS80ooVx1/zB/
         1HHtBe5q8IUWO+c8GqFpPSv2qDfmMOGp2Tn5bbEcubZ+0tZcPTUBPbPdvio/o4eR9vLA
         71rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616574; x=1712221374;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwyOlwPxgHT1CPKSoF7aGCVLvwYoa/el57EZd9pYFDc=;
        b=c0vOsmfIMtjoTbUnlBx1Upr5D1bKVj1LHP5H7+UMUUAucXEMgRaGNWD4SgHYzeGXkO
         ZTPd90uyYTNe/CIcQQW5yo9uDbEYEMEgA9Qzfuo/PT7wsMe7SSDQNxg9Tt7haBiThuMR
         ofKNYwBwwE6zHpeYllOaPPtUvlqsEov534emkXVHmMFQ5WLF72dGBFH4PCNMQRnbnIZ7
         BBhxbB7CtC7/tYmGpB3CIf7iidjSw7MuGbKm6Muo94tUjVb9JmVZqlkpxtTTjPSDjE8Z
         Q87rLHVIC6rm2STm16h1UPFFdP018zrbODTk7Fo1MnrQTFsgVATnu6Ial/uNJzhbfJCx
         d63Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwW8PRXIFmxtVRBA1BnP79OGR2mysx/9ttMRgNXePuVBlyu5Rox0YTYnEkzAXGqV23S9UeZ5roTHSYqATCLpnHmDATqAXBcC5Wevtl
X-Gm-Message-State: AOJu0YzqO3k3bluVPglkaa8hOXTfBCqmRwMRQX+Z1GLcwQgLVW5Ye8hN
	ekJP6kKxgRt79Au2Z75uP/AzID/ydHj9X+zfz6hr3HFOxq64VoqeKoRwcDrND3Y=
X-Google-Smtp-Source: AGHT+IHC8oA9gMMFOLPH695/vtXHLDH9IwtCsO4DhH6tLwSZJzTxCgs6cAIrUulngfH3k8l6wwmcgQ==
X-Received: by 2002:a05:6000:25c:b0:33d:8c9d:419 with SMTP id m28-20020a056000025c00b0033d8c9d0419mr1260042wrz.24.1711616573787;
        Thu, 28 Mar 2024 02:02:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id dq6-20020a0560000cc600b00341c3071c93sm1179989wrb.73.2024.03.28.02.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:02:53 -0700 (PDT)
Message-ID: <8568fb86-d0fb-4562-b8d1-2452a64a5354@linaro.org>
Date: Thu, 28 Mar 2024 10:02:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] dt-bindings: clock: meson: document A1 SoC
 audio clock controller driver
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
 <20240328010831.884487-4-jan.dakinevich@salutedevices.com>
 <cff5e036-7f7c-4270-be0c-f49b196a502b@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cff5e036-7f7c-4270-be0c-f49b196a502b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 10:01, Krzysztof Kozlowski wrote:
>> diff --git a/include/dt-bindings/clock/amlogic,a1-audio-clkc.h b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>> new file mode 100644
>> index 000000000000..b30df3b1ae08
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>> @@ -0,0 +1,122 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
>> + *
>> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> + */
>> +
>> +#ifndef __A1_AUDIO_CLKC_BINDINGS_H
>> +#define __A1_AUDIO_CLKC_BINDINGS_H
>> +
>> +#define AUD_CLKID_DDR_ARB		1
>> +#define AUD_CLKID_TDMIN_A		2
>> +#define AUD_CLKID_TDMIN_B		3
>> +#define AUD_CLKID_TDMIN_LB		4
> 
> Why both clock controllers have the same clocks? This is confusing. It
> seems you split same block into two!

Ah, no, I missed there are IDs for second clock controller. It's fine.

Best regards,
Krzysztof


