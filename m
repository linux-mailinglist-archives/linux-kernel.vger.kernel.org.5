Return-Path: <linux-kernel+bounces-38101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0183BAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808891F25B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1513AF3;
	Thu, 25 Jan 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lwp/Nw5+"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB5134DE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169009; cv=none; b=qYzPBFwpKFJwjdIZEBh+9ZWUU34thTrxrsoAo3oYnYs1J3TAOx0Brttxx7iRTfkWIuqQFZcF03VPerq73coD4Uog5JGQvUuHN8E2S4HXoVRdTI5PZJ6QpZqUqq+F2ZYUvzFCx9JC6Vp/w04ey2OxnEd5VB88h2PhOxTv8HknmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169009; c=relaxed/simple;
	bh=Rx1m8W5qcYoLqxuwR6PWRIHj/JKmUKw1q9wg+h2yxxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZW1mr7zkF+zYZz4VXAuUBKtrqB58/q5Oy1U0fmvBwXW7++IYR30PmYu2QiudQfCXB4ye3GgaXvyvwiq958rz8TIQm6lk3xJcZoYfqAA8YV/4hX2mTIyGRdQ9tSDa4YD4loxORieW270OQPqOWEkYJ30LbmnZxblNti5QNGIcqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lwp/Nw5+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so7257835a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706169006; x=1706773806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAYu80DmXRENUtwrMjEwKt1nZY4pwGfPgGYSpZ+esrA=;
        b=Lwp/Nw5+U/gmaCfmVeszr6aYbVQwYmflZcdKKILUs1LDwFfykeSMgTMZxAZ+S6Wwb/
         aOWilmlI44Jp8LTG97Zx+C6WuJL9K99eeWgGytEhOXA+6ALuBEgcg3LLmz/WKaNTXhdn
         kuRmHDBM37G9WB/FPvnWP0HrYCBFpUhVQVKUhPHfwotrMIdE9fSLg04ddYvohqaB1BAy
         G/SqjmceSYMLHNdDA2mOnWXKazfqq5GHWbSel45qCuR5cwjo7zN8ekoL3+Oq65oXGBTw
         e1Y6PbdHC+BdUQGu5ZwmjTjx+plsOr7O8Zt2mLic44V47tL/Lu9k0zHj86xds+Ee6nl8
         AAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169006; x=1706773806;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAYu80DmXRENUtwrMjEwKt1nZY4pwGfPgGYSpZ+esrA=;
        b=hldbsiMuWmKGqTX6ytvYXPf4X1Ro+D/1NoZjr976YhU+ZlL4zF/ccIsjhWA5fB0ybO
         EAwdMwMfVHPWt0av9najY640mdxhA/0nb/eJkDdrbw2wF9eR/qPlgxqEIojo0AnP2RwP
         7pZeVsIyUw4tKEEhptwKiko4Mco+krzaxl7Flw/EJCaXnqEuQlWeWfYI9J/rnuiVlNfx
         gji7r5b7ztNwYUyjqV9B60NAXO9SHoBXBc30k/cpWKH9ynzkfv6AbLFXfRTL2pq0n4VV
         Qcw8aXA/hzPKhMEZ31RhsyMmeihvfPJUfcR2f05eET1mY00Cmgo2Ej/ko8aqKP30dyNy
         fiYA==
X-Gm-Message-State: AOJu0Yxw1EpFErK5KZVfhK7f/+7YGPzba7VbBJim9nccT1NfIsJlrAY9
	Fm9VXCKsgOUCDLp4o0Ma+OWjmyAi7bjbU98kF/ept2nKnLZRz9tphncBuwhMdK4=
X-Google-Smtp-Source: AGHT+IGtffkK3MVjn1PVMcY5xJaYn+bXhOby+WAtg7NMd/hxZNp+zAxIuoX+Jp0AKauxM6gVTvzjBQ==
X-Received: by 2002:aa7:dccd:0:b0:55c:8855:952e with SMTP id w13-20020aa7dccd000000b0055c8855952emr235614edu.15.1706169004760;
        Wed, 24 Jan 2024 23:50:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id fk4-20020a056402398400b005576a384b46sm17162999edb.10.2024.01.24.23.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:50:04 -0800 (PST)
Message-ID: <d8f00ea9-3bb2-4b17-bbc7-48800516e408@linaro.org>
Date: Thu, 25 Jan 2024 08:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v1 4/4] ASoc: dt-bindings: Create yaml file
 for pcm6240 codec driver
Content-Language: en-US
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
 "soyer@irl.hu" <soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
 "tiwai@suse.de" <tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
 "McPherson, Jeff" <j-mcpherson@ti.com>,
 "Navada Kanyana, Mukund" <navada@ti.com>
References: <20240123111411.850-1-shenghao-ding@ti.com>
 <20240123111411.850-4-shenghao-ding@ti.com>
 <92c1a3f3-6b3b-47cb-a4bf-0d20e4af95e5@linaro.org>
 <a6c6cad6efc647ba8f0c828ffdb3a54f@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a6c6cad6efc647ba8f0c828ffdb3a54f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 08:39, Ding, Shenghao wrote:
>>
>> Why do you repeat the reg constraints? This does not seem needed.
>>
>>> +        interrupts: false
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - ti,pcm3140
>>> +              - ti,pcm5140
>>> +              - ti,pcm6140
>>> +              - ti,pcmd3180
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          description:
>>> +            I2C address, in multiple pcmdevices case, all the i2c address
>>> +            aggregate as one Audio Device to support multiple audio slots.
>>> +          maxItems: 4
>>> +          minItems: 1
>>

You did not respond to any of other comments, therefore I assume you
agree with them 100% and you will implement them fully.


>> Drop entire if
> How to convey ti,pcm1690 does not support interrupt, and others support if I remove this if

How? There is no pcm1690 here.

BTW, add missing line breaks, especially before next blocks like
additionalProperties.

>>
>>> +          items:
>>> +            minimum: 0x4c
>>> +            maximum: 0x4f
>>> +
> 
> BR
> Shenghao Ding
> 

Best regards,
Krzysztof


