Return-Path: <linux-kernel+bounces-11972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8381EE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DCB1F22D94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B6F44387;
	Wed, 27 Dec 2023 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4UdEYh0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071944376
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d5a9cb423so12895655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703674587; x=1704279387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHce773lKvSW3d9PoMjyn58aiNhGgezLeBwW4a6Orpw=;
        b=X4UdEYh0EcwHkjpcvcramlZh/emuYEimRUigpdNU1vuL5iXKQfSXcChGs1mk42xz6n
         ECuGuChm0l8ivTwCIkQ8bAqT2mGBE+QZiVsWXLt1S7jl/ntZNBLfUbQCc3LUvcz5oxVm
         6psW8gF7MfWvF+8XudzJZd6ETIhkxp3AeCtxLeUmj0vFvzaZJz2EyX6vfW2CzzG2IuP5
         +iurSHCOU4SkLXafaE2bk7wqqQJmQxodfWAsMFNujqK48I31XjC+/b0ChLHm8zT3WTAu
         1Gieaq4RCcF/BLP/16MvYMOH0TeWU41NkKRrDRyAKYQGdKoGhh8KE+VKlIUmy5NkdCY5
         4njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703674587; x=1704279387;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHce773lKvSW3d9PoMjyn58aiNhGgezLeBwW4a6Orpw=;
        b=YEoUiipylguCouvK2sOd4LDqNrz3S5V2LORs5u1KT9zFlOHDmpfcHyUSuctDoabITD
         S2zOiONyxez4imzHAWMgxIn3ATQNlCrapCfWufoGsRfj+famwsT9XhpHrCQeq6TsldXN
         0VmexCaBU4E6HUcTA+qnX3t/grTJQDOVI52/5kYHF/tpV9ZhMP97GW1qc5CpYMT2VcpP
         DVZXFA/yuU0X0k8e5biWO7MGx/GGpo0Hc/OX+8WUYtrsW7CPNZ+F3yYKpLQzEoCqRlD/
         ObVBt7SncZ13ko+r5XMqxB0CudoOEEooKNQw5sMfwBHazZEoSkTcdN0C2QAvB6GHudC0
         Mxpg==
X-Gm-Message-State: AOJu0YykaztAt/jMTv91ZIFx43z+UcSj0UBgZozvIAPu4wHlpADd5Y+W
	tbMAK/o2sIA5PtUTnUNJaSqr6794K5HA9Q==
X-Google-Smtp-Source: AGHT+IE7PicW5CioiSRUJ2OW2wTwvR1bf06wN1vCmIc/JHED8Aw6ec5lsIUpR70J43IQWMjIfNXpsA==
X-Received: by 2002:a1c:7c18:0:b0:40d:5c0d:1e3f with SMTP id x24-20020a1c7c18000000b0040d5c0d1e3fmr1054482wmc.84.1703674587066;
        Wed, 27 Dec 2023 02:56:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s12-20020adfeccc000000b0033687672e48sm14141173wro.75.2023.12.27.02.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 02:56:26 -0800 (PST)
Message-ID: <ffc11f9c-6643-4e46-8bb2-8918e1179f72@linaro.org>
Date: Wed, 27 Dec 2023 11:56:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
 from yaml
Content-Language: en-US
To: "Ding, Shenghao" <shenghao-ding@ti.com>
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
 "Gupta, Peeyush" <peeyush@ti.com>, "Navada Kanyana, Mukund" <navada@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <7362295b-4a01-4574-8d96-d10f405eaea0@linaro.org>
 <8285d102645b43f6b46b15c99321105a@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8285d102645b43f6b46b15c99321105a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/12/2023 08:07, Ding, Shenghao wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, December 22, 2023 1:31 AM
>> To: Ding, Shenghao <shenghao-ding@ti.com>; broonie@kernel.org;
>> conor+dt@kernel.org
>> Cc: robh+dt@kernel.org; andriy.shevchenko@linux.intel.com; Lu, Kevin
>> <kevin-lu@ti.com>; Xu, Baojun <baojun.xu@ti.com>;
>> devicetree@vger.kernel.org; lgirdwood@gmail.com; perex@perex.cz; pierre-
>> louis.bossart@linux.intel.com; 13916275206@139.com; linux-
>> sound@vger.kernel.org; linux-kernel@vger.kernel.org;
>> liam.r.girdwood@intel.com; soyer@irl.hu; tiwai@suse.de; Gupta, Peeyush
>> <peeyush@ti.com>; Navada Kanyana, Mukund <navada@ti.com>
>> Subject: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
>> from yaml
>>
>> On 21/12/2023 11:13, Shenghao Ding wrote:
>>> Remove tas2563 from tas2562, it will be supported in tas2781 to better
>>> support dsp mode.
>>
>> Please provide rationale in terms of bindings and hardware, not in terms of
>> driver. Or at least not only. For example "supported in tas2781" does not fit
>> hardware part, so you sure must be talking about drivers thus why driver
>> change would affect bindings?
> This patch mainly change the binding, not the driver code. Tas2563 is unbound 
> to tas2562 driver, and bound to tas2781 driver.

Then why do you reference driver "tas2781" here?

Best regards,
Krzysztof


