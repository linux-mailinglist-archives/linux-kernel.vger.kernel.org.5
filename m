Return-Path: <linux-kernel+bounces-91865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BDF87179D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B756B1C21D2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58FE7F46B;
	Tue,  5 Mar 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLPYemVb"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA317EF0D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626160; cv=none; b=R8LwR02rg2eMwE8bYQSpJTiKDTjwsUAb04WhB4uScubJmVVQW4zxfIqN/OkYVkrQ9evTaQixkr4g23JM46JVFMwrHpvhZSKI0fkLAbippdtVa0EHsozsBsIDqWEoqm5z4hDyjbdTRQ2YW+pHTBAsuzOttmkd11X3KauqtpWVsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626160; c=relaxed/simple;
	bh=gxghkhfCwCcy3FiXcI5OlAqUdRUVdOy92wS9GSHk/80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRPHg/pLGMgjBMJYtIJA9gSIEQKsjC8J0t256yGMkhrZTTHXuuKId2Qo8aJOMvStzf7NeCvs0UPznOFjO2dGY2mrvGYw23Mfoq7AbU5rdk4Ye1z5JFgM6mXE8mgfJyurksoJULMmcQW/Zx8qxzrUkSgSJxv7yYXsrGKmfkxaKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MLPYemVb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d275e63590so77184931fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626156; x=1710230956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGlX+l5FrCtoGILdkXog1qk1JDD1pTX7Iy+8O9A+Pew=;
        b=MLPYemVbAxSGxdpcow3wgkCzpuQYh11DZABqXRaT3uqrerSYx/th2ZnpY7CBv6jd9m
         n6wep15P8HCiFToIXRnEtGKGshzl6XJdiwDeME3Bfx7XDmn+Jdo1n4hH0oo5+bd83gas
         m+OHsCPqgcMX02dFRuaF8e/T92b1ewHzleugQrFJ3D5jwg2Xls5FO3P6ymg7DFZxd/7N
         4zcd1yYXatHRXZ8i0LMuYmPPWltjanrDJxP8KRJKQTkmAHEIgIuw3nlbXm+HKLm/986U
         4SEUwClW2ZneIM3FpEh7x9Gv2utfdHn8GtuziB0Cus7JKrhcCoIkd9fO3wkzUQHRllTU
         DKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626156; x=1710230956;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGlX+l5FrCtoGILdkXog1qk1JDD1pTX7Iy+8O9A+Pew=;
        b=tLpbzTm80s0hUS8Hp3aTzHD8geXz8LBqi4UmbM6nfCURvEbjgH/zaaf/qLn1c7wwAN
         LmOZ58B32AKXYB5nksUVlO8ymeOElsk0L4VW9TwicCJbfK510tpiBQYXr5vzBCh81nYi
         qNwVaVPh9QjMuxcWWC8XLpFu0sYFg/lXhrHx3e1UbdXhadfg9jsk+FFxSYV/rPI0bS/u
         +MOJrw6houaevMLbIF7cllhDyUVVZ3hFDHBh+eiBCAcU40T3ePW6EE2KxPwWa+4wqcjB
         F83ARtO2HMKjJm8eYMYEKDPSWIdKYWXrPRsrLIK1cknracr0XQO6O9No+w1M/UQTZjf1
         jYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+m7z+6/O+M9Gu2BVcDfK1XcxR3wG1oK/hl+gi7zioGqyPkqnC5Bc6/NiXAVpnBZPwqM3HnR4H4puGMjiJpjSPOC6ElbmOi6fK5zuj
X-Gm-Message-State: AOJu0YxXsq1kK3rDmQhpnqwiTEWYckwfepmNytxHARTphezwQuqQ2QCn
	852rqGpfniSpp3Mem6veKx3v9iI6Y2ZjuN3BcgUI9y1Fkr6CTrFaizUXTctlSzs=
X-Google-Smtp-Source: AGHT+IFlUpUmZuKjcod21fUszHyVvU9lm6lzrXoct8LfeGQXriWSYBPocI5sUhsrtUAYIa0x7W8XEQ==
X-Received: by 2002:a2e:a7cc:0:b0:2d3:ada:29e9 with SMTP id x12-20020a2ea7cc000000b002d30ada29e9mr856360ljp.12.1709626156438;
        Tue, 05 Mar 2024 00:09:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm5497551edq.74.2024.03.05.00.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:09:15 -0800 (PST)
Message-ID: <1e7e0404-ccb4-4994-abc3-12c3f53c2603@linaro.org>
Date: Tue, 5 Mar 2024 09:09:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] backlight: gpio: Simplify with dev_err_probe()
Content-Language: en-US
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-1-e5f57d0df6e6@linaro.org>
 <20240304104000.GA102563@aspen.lan>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240304104000.GA102563@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 11:40, Daniel Thompson wrote:
> On Mon, Mar 04, 2024 at 11:11:38AM +0100, Krzysztof Kozlowski wrote:
>> Common pattern of handling deferred probe can be simplified with
>> dev_err_probe().  Less code and also it prints the error value.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/video/backlight/gpio_backlight.c | 10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
>> index d28c30b2a35d..9f960f853b6e 100644
>> --- a/drivers/video/backlight/gpio_backlight.c
>> +++ b/drivers/video/backlight/gpio_backlight.c
>> @@ -64,13 +64,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>>  	def_value = device_property_read_bool(dev, "default-on");
>>
>>  	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
>> -	if (IS_ERR(gbl->gpiod)) {
>> -		ret = PTR_ERR(gbl->gpiod);
>> -		if (ret != -EPROBE_DEFER)
>> -			dev_err(dev,
>> -				"Error: The gpios parameter is missing or invalid.\n");
>> -		return ret;
>> -	}
>> +	if (IS_ERR(gbl->gpiod))
>> +		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
>> +				     "Error: The gpios parameter is missing or invalid.\n");
> 
> The "Error: " should be removed from the string. dev_err_probe() already prints
> that.

Sure.

Best regards,
Krzysztof


