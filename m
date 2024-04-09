Return-Path: <linux-kernel+bounces-136580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4E89D5B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB700B2210E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A4580024;
	Tue,  9 Apr 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyKNNbR6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D717FBBC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655644; cv=none; b=Fqp0iwFTtU9mXP4KA8PnCuu4+/8Txg9sH1AmEN0nJxGMq4NqCzRz8+7sS80BOl2YbK/QTM+ccsqZWFXC1plNSP++knDMZDgVhBW9nXZNPJEs/AB5lbU7fpn5D5e+lL+72+pI73oTW6RJQaPt+81x44U0MB5zRU84d7eS6L4Y7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655644; c=relaxed/simple;
	bh=TxSYGiRfu7aaveeB0Y8MegY4U0m6GbTReYvO72k/SrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iizok4i2M8+EbzOJSJfeAs41s56RsVe1Otqs3JNGTJHD9n7ULYea6KP42ULohYKi+vMWcnbJihCLBATdGZ44aoZ51ocKJCk+3iCopGFg8SRSrUZ36xqNk8Svq9Y5TuPtF1PNPptA0rhqde1FSGKbnn29e0r+i8xAGFzFXXFJ5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jyKNNbR6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343f8fc5c69so2181127f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712655641; x=1713260441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cMVhtAm6vqVRRg54kID72AW24B0pe3D18jLWSvsKVQU=;
        b=jyKNNbR6gQlOYjbod5xfRgUg+3YFGNjDTAfbe/ftCt0TpaniMYUP6kBAhAA7s0ynAH
         gf7ydGnaiLh1lR+BPE9w4mViTNX3bcPTTptiJpwis3MqgJaSimpIJ+peKDvq/Vsioo92
         83hlzWJP79+Jrj9ooURFicB9/yTRZ83znkbgWzw2HaSdUb/r1JMipz6DxmjpGU8gCq1+
         Sc+Txjlidr/qa9C/qrNyoKjAAemWAqBoJhfYPKMRXvh/asQvm8K3cW0Imtec/O/MJOwL
         Kxr+jpH+8nvRlqNX8Sefws42I3U65eHWTrdXg0EaIITRWuqf735Kb8dqPUQS7bcw+zzY
         XIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655641; x=1713260441;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMVhtAm6vqVRRg54kID72AW24B0pe3D18jLWSvsKVQU=;
        b=XA0LdfB5MEeIgdAiBfYs/2bVCol/CQ8u6VBmY2lAk+3xrnyFgswC7//7xi8FEjNiyx
         JZ9FISB/Hcr3U+VC8J7MkNeFGCR81cUn1HyzhUAFan9E5NQpAuzXox3mnbv0tHDfCy3J
         DcKKpK53NTiuNV+WycE3vTtCwjfAT/WZUmbe+s745aVLvWWlt9tUkpcQSDBcNm023FVr
         JH5VRjq3n+p1uH5IO/Bjyyyd143VRUs7RicN/Muh6zTzEIJlr5ZNsh6fiLa+sGG9Em0J
         +KL7qjDQ2A6U25ZCGFqqW9xjEq+077Yf0ZbnRplrlI2B2DDD7mHLHcVRljL6KMzgDOQa
         rsbg==
X-Forwarded-Encrypted: i=1; AJvYcCWEIvKI1BvTTx3uzbxD1i/QWdHjZm07PPg7tm/7EV8Hvq8B1KjyjBDtH38RQiWnxLGX06c56F0U8Pw4FmH38E+OLucRUR0EDjCWlegr
X-Gm-Message-State: AOJu0Yxv4cL2k6loeZwP+ttCOKpOOMz5YKKCCl+gx32zpmQe40A+f+xL
	PP/zZbnxlTNk5fiSJptm54UThY7lBpnjGExgF2Omc9PBCe3JWM2DJ/DR8ZV2W44=
X-Google-Smtp-Source: AGHT+IHNYKec5AgdsW2xf6hs+LFjsV1tO1d8+PGn+8kx3O+NNk0UjzkCxex+tQAWqyYfp3Dx7iskRw==
X-Received: by 2002:adf:ef52:0:b0:343:9a57:7d1f with SMTP id c18-20020adfef52000000b003439a577d1fmr7060414wrp.69.1712655640901;
        Tue, 09 Apr 2024 02:40:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m28-20020adfa3dc000000b003435e1c0b78sm11106758wrb.28.2024.04.09.02.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:40:40 -0700 (PDT)
Message-ID: <ea5a9c80-c43f-49e9-b9ac-da27c74a32bb@linaro.org>
Date: Tue, 9 Apr 2024 11:40:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240408-rtc_dtschema-v1-3-c447542fc362@gmail.com>
 <dd5e9837-0dcf-4b0e-8d11-f8bed868cdf2@linaro.org>
 <6dc808bf-682f-4e91-aac7-7ce6f05a0ab4@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6dc808bf-682f-4e91-aac7-7ce6f05a0ab4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 10:52, Javier Carrasco wrote:
> On 4/9/24 09:34, Krzysztof Kozlowski wrote:
>> On 08/04/2024 17:53, Javier Carrasco wrote:
>>> This RTC requires a compatible, a reg and a single interrupt,
>>> which makes it suitable for a direct conversion into trivial-rtc.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt  | 15 ---------------
>>>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
>>>  2 files changed, 2 insertions(+), 15 deletions(-)
>>
>> This one no... and if you tested DTS you would see errors, although you
>> need to test specific lpc config, not multi_v7.
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>>
>> Anyway, you *must* check all DTS before moving anything to trivial.
>>
>> Does it mean all other bindings were not checked against DTS at all?
>>
>> Best regards,
>> Krzysztof
>>
> Hi,
> 
> I did check the conversion against nxp/lpc/lpc3250-phy3250.dts, which
> throws a message about the 'clocks' property.
> 
> That property is not documented in the original binding, and even though
> it could be missing, I could not find any function to get a clock (i.e.

Old bindings are not really accurate.

> any form of clk_get()) in rtc-lpc32xx.c, which is the only file where
> the compatible can be found.
> 
> Is therefore the property not useless in the dts? My apologies if I am
> missing something here.

Useless for whom? For Linux yes. For U-Boot or out-of-tree users of DTS,
I don't know. Anyway the true question is if there is a clock or there
is no. If there is a clock, then it should be in the binding even if
Linux driver does not use it.

I propose to add it and be done with it.




Best regards,
Krzysztof


