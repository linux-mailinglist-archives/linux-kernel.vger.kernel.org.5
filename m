Return-Path: <linux-kernel+bounces-15735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65513823107
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C5A1F253B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C81B29A;
	Wed,  3 Jan 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqquyMvz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EA1BDE7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-556ab8b85e3so1095423a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704298172; x=1704902972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s7S73HU7AVAEIGkgOia8M6tFoLAPa3XpM2/kOMvb20o=;
        b=RqquyMvzuqt6T+sHl8EOIktwyrjAOYrrdTcdxPZEPTYmUK57lLhlUNof3lFIOo9Zqi
         G5jo7peguHu344u8CbiyMLM/D3S1xrPwXAUT6jcO8/2lijKoG8yc+WrA0u7Jogb9Cz4E
         stJRWZSp7QG39ovhcbjhrn5ZjGxtjOyn1e7SPEt/xPUGyQ+0FO3acyK9A8K7Kj6E5PO9
         P7GOrEOibhncI8NwuscRenjDL8BeisRBGICDiySbsdx/gsOZXiC1Qe5L3dzPB0SSX19I
         RMlaxLn/w78g2omLvQ3QjubZ4hd3G+5CCCQYk3GOa3nXQp9T64QY+lQPH5gtFJReP80L
         7uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704298172; x=1704902972;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7S73HU7AVAEIGkgOia8M6tFoLAPa3XpM2/kOMvb20o=;
        b=I/DetOKPPFYPi+02REL0YJskZbamoq4TOrH3R9gsxnYAtC3kTvR3fMmRLuY6HlaqKK
         QxJASBXyj8cQz8zGj5GYJKStPfCzK7tCCNkSQnmoXIg63jrmYtHBBRDR/CW6Y2eoMi8v
         U6Ev51qHMHxPs86I5p5SxQG7yRKw+PfYGWuGYbP5Fq6kmHF8bPoZc1pVqQ2+ERv1v/Ad
         MAM8PcI2c4JvQb0SZ+E68WKPxL67TE65oQ3vfMI7WjPjYXjksU7Mih6kYO7S4blcoEUR
         FNKG982CF2+RqgG5Yp0jW0JVZ34a5cI4F9Jq6tDI3Aj4r3teTGa++CVmgCrGLqndxc1p
         ZELg==
X-Gm-Message-State: AOJu0YyMmYTTNg6QLLikst+78KPbKGq33c27mHDrQy0GqMZWaiqzU9vJ
	hFkBwpWIpbXJD/05bFciKyukS/ACaZm+NA==
X-Google-Smtp-Source: AGHT+IHcMO6aQ/mEcGF1E7z26QmE6ElZvZeg2lxXH6Naq62uIb/uM1R9LQJnmvOzB4pXFZsd8ooKJg==
X-Received: by 2002:a50:a6c6:0:b0:553:29b0:7ed7 with SMTP id f6-20020a50a6c6000000b0055329b07ed7mr1183527edc.28.1704298171891;
        Wed, 03 Jan 2024 08:09:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ez9-20020a056402450900b0055504002a5fsm11466589edb.72.2024.01.03.08.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 08:09:31 -0800 (PST)
Message-ID: <1628a536-1c0b-4c80-b84a-41c290052da2@linaro.org>
Date: Wed, 3 Jan 2024 17:09:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/4] ASoC: dt-bindings: move tas2563
 from tas2562.yaml to tas2781.yaml
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz"
 <perex@perex.cz>,
 "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "soyer@irl.hu" <soyer@irl.hu>, "tiwai@suse.de" <tiwai@suse.de>,
 "Gupta, Peeyush" <peeyush@ti.com>, "Navada Kanyana, Mukund" <navada@ti.com>
References: <20231228153024.1659-1-shenghao-ding@ti.com>
 <9315a1ea-5ebe-47b7-a108-4a72b647bb4f@linaro.org>
 <6ae4809eca654fa49929fc81720a0687@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6ae4809eca654fa49929fc81720a0687@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/01/2024 16:10, Ding, Shenghao wrote:
>>> -  reg:
>>> -    description:
>>> -      I2C address, in multiple tas2781s case, all the i2c address
>>> -      aggregate as one Audio Device to support multiple audio slots.
>>> -    maxItems: 8
>>> -    minItems: 1
>>> -    items:
>>> -      minimum: 0x38
>>> -      maximum: 0x3f
>>> +    description: |
>>> +      ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
>>> +      DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
>>> +
>>> +      ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
>>> +      Protection and Audio Processing, 16/20/24/32bit stereo I2S or
>>> +      multichannel TDM.
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - ti,tas2563
>>> +          - const: ti,tas2781
>>> +      - enum:
>>> +          - ti,tas2781
>>> +
>>> +  reg: true
>>
>> min/maxItems must stay here
>>
>> I already reminded this in v3.
> How to express maxItems is 4 for tas2563 on the same i2c bus(only 4 different i2c addresses) 
> and maxItems is 8 for tas2781 on the same i2c bus (8 different i2c addresses) here.

Here you have only the widest constraints. In allOf:if:then you
customize them.

Best regards,
Krzysztof


