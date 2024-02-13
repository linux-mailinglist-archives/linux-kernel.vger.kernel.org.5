Return-Path: <linux-kernel+bounces-63121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84C852B30
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3EBCB22907
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641F1B5B1;
	Tue, 13 Feb 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npRm0MrQ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA72421F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812883; cv=none; b=tG98ke+q9Qq1NCYRkDvrYIgtgohfu7okB0EbLNjAUbU8WS8hjkg8znBqidUZQcyR90+JHDv/vEb69hpiZeMU4Bs9pmBzUtXI88KSfuubO7f/xCXgtyNeSLjs4NyoxzoJKzdSs5/h908dQkVu0dcoSL4L8FlB4VVw7NOUGYPaN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812883; c=relaxed/simple;
	bh=NFQ8Eln5KoExspwmfcVYKljJHKi3IqnIsAEvWlZKLWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZePg08Zf8RS5jF65Q9wH86Nt6a0H+t0v+k//vKyU68hwXv8B2JAqR1lW9Gd7X2oVceLduSyqAJG02p3augv9FKaPMagOfsI/IfrQPok02DJBZ4pXBUUhR2QMZ613w8tFG9omTJZCLiWTlNRyZu5rIKoO53+icNbZPZFDWCnN5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=npRm0MrQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ce0802f17so46306f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707812880; x=1708417680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+Or8C6zFHhe7sBrtU3uPWhG5vc9lJFYOzcSSs5Ma2k=;
        b=npRm0MrQkbTbBGlxwXJ3jfyU4f4r6r7YphqQNtFFEy2LrI0+MrJJFwFTe9fqS5EIG4
         1axuQePpvXh84Iu/xEltI+YduSZ69qXjcLXa/mzhaxHrJlfygZZQzhxQlOtPIvpLCDsH
         AvVBE0XMbEKJEsFG1WTDvvsRvhf43ODa3nR3D73mW5zIErP+8pnS6w7u2MB1G01/2hPT
         ZNVBiwVeeyq7AbRs+JFDfCSN0wU+BwUW3Z3+Dj8KSsps2SW68DWjG3v7Zy5ZNzGdubTQ
         Dh0fYGM2r2khjV5svs+7o/oEjqmAgruVuCeGT3Eq/h4uNjT9ul/7sNP12i3FNDc/xXCO
         DBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812880; x=1708417680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+Or8C6zFHhe7sBrtU3uPWhG5vc9lJFYOzcSSs5Ma2k=;
        b=Jdt8Anpmv2FyXBGJrWNika04Cw+5GNwbxIQvNJ2fHV8Rtte7DQfzn6nQcm/01RT0IF
         MP7Uk/y+g3WQ03mDO+51JuAkf6gRWo+mo3I+wVA910MEYEfakD0DCEgeph0QfU8e4DaV
         jCpBqpTHuP0bpFDfLhViRr9CDWj+yrmLPnjdatlfxy0K+qzmdXfdwTw4ThEOhv4Uag1Y
         BxdVh9iEcwAd6YAgAYpYc+wAhYtiZbGkZ6korseFuaxFyRbAxjRg0h0LBj+JEiBWbsuh
         F1SwEm2cOBQdw9TdjCzIADH5SLWrtvR5uab7af0yEFaJUMbcByiGxzO/ZeucVexe4va6
         XZrw==
X-Gm-Message-State: AOJu0YxSMCHlMPL3QEop3IhugVrd0uGh4EBQdS9839S4n77uOwtNW+3L
	J5CS0X7QyfNIzy5xXEzpi8321L0n4FPioQQPd7rB1r6A+8l7Yg4qSJ4CW/yDdY0=
X-Google-Smtp-Source: AGHT+IGbP+cP/cTUakgsci4ABHN0F0PPkXeHT2vwwls659mO7zeBC7mwXi7meDBoHVqP+h6vY4Gd2Q==
X-Received: by 2002:a5d:668e:0:b0:33c:e065:76c2 with SMTP id l14-20020a5d668e000000b0033ce06576c2mr172872wru.46.1707812880186;
        Tue, 13 Feb 2024 00:28:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz4IVYVva4AKF8MBOdfCnx0o8JMqJkNr16Qmx/coAsAdpH3Ng0+MD1c4+iAhBfupmIyDvgXmnBaQqoz+Ya1oNje5biVvRYksT34IfpLoir/L1o5v4QZH55i0cUQ1LImpEvPnJkjImD9+U0SEcGCxCo/E6DbhD4sdvSpxcfxuP9RHrIb5H0qrv4KAWI4NTua9N4hGJf/r/ojp+lWbj5mpbKup3GBMNkcpnryU5dH0/kRXAHFRC/BneJSfHE5h695L1p07SwquJdvpGnzCtMUY9ufEnd5X5b88f581+3/TbiR6je+G4Ev4dgK45liL+AstP2bZSAQp1jPtwagijyUC6u0Bz32QcpnVO9doU8FIZDozN/OSkkSgena5Ba
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id l21-20020adfa395000000b0033b3ceda5dbsm8933060wrb.44.2024.02.13.00.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 00:27:59 -0800 (PST)
Message-ID: <6a19bafa-1ae0-427a-9ad7-644e000b8520@linaro.org>
Date: Tue, 13 Feb 2024 09:27:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] w1: add UART w1 bus driver
Content-Language: en-US
To: Christoph Winklhofer <cj.winklhofer@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240209-w1-uart-v6-0-3e753c149196@gmail.com>
 <20240209-w1-uart-v6-3-3e753c149196@gmail.com>
 <466d7be4-6ca1-4eb2-a59b-a3f0a846a2df@linaro.org>
 <ZcsUCHu42ILfKSBs@cjw-notebook>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZcsUCHu42ILfKSBs@cjw-notebook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 08:02, Christoph Winklhofer wrote:
> On Mon, Feb 12, 2024 at 04:30:00PM +0100, Krzysztof Kozlowski wrote:
>> On 09/02/2024 07:22, Christoph Winklhofer via B4 Relay wrote:
>>> From: Christoph Winklhofer <cj.winklhofer@gmail.com>
>>>
>>> Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
>>> the Serial Device Bus to create the 1-Wire timing patterns. The driver
>>> was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
>>> DART-6UL" with a DS18S20 temperature sensor.
>>>
>>> The 1-Wire timing pattern and the corresponding UART baud-rate with the
>>> interpretation of the transferred bytes are described in the document:
>>
>>
>>> +/*
>>> + * struct w1_uart_config - configuration for 1-Wire operation
>>> + *
>>> + * @baudrate: baud-rate returned from serdev
>>> + * @delay_us: delay to complete a 1-Wire cycle (in us)
>>> + * @tx_byte: byte to generate 1-Wire timing pattern
>>> + */
>>> +struct w1_uart_config {
>>> +	unsigned int baudrate;
>>> +	unsigned int delay_us;
>>> +	u8 tx_byte;
>>> +};
>>> +
>>> +/*
>>> + * struct w1_uart_config - w1-uart device data
>>
>> That's neither correct (device, not config) nor proper kerneldoc nor
>> useful. Your comment repeats struct name. If you want to make it
>> kerneldoc, go ahead, but then make it a full kerneldoc.
>>
> 
> Yes, sorry - will use the correct name.
> 
>> And obviously compile with W=1.
>>
> 
> You mean the padding error of mutex, I get it with W=3 and will fix it
> by moving mutex up.

No, I meant W=1. Make it a kerneldoc and compile with W=1, so you will
see the warning.


Best regards,
Krzysztof


