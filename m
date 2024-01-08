Return-Path: <linux-kernel+bounces-19252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C42A826A57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2601F221D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EEB10A19;
	Mon,  8 Jan 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2VqKcYx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96A10A2C;
	Mon,  8 Jan 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so1857581a12.2;
        Mon, 08 Jan 2024 01:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704705104; x=1705309904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+690ILLvmgoiVG3rWqnA7YdVgSm8xx8o94ASaIKF+E=;
        b=j2VqKcYxIpZe3vpNASTNnJVf5QUE1+D0ItwoxtJPktdooj1U2TAUFnz+WxbEip+XKz
         0DinEN6FEsbnobmYtpbX+s6o/oHusFNyeu1OX6NBSsuWU+kuIgMqOH/4KqnptPtTpvza
         dvIgpbH/q2TbunMDVzPxQjm9U3hwcaSs5dO5EUTtCHTN2+oH7VRxZsydBDe+wFhKothC
         b9kp1qUg///a/+MeKi3U4dUwD7KqG9srdi0+FOkzXwXjdsK8nUq59XExI1wT7DgGUryz
         FkzdJWzty7NE6RePFjrxqMrxqOzJt+b4cJT7krKoQFC7fgikyAJrd7Fmsuxkgb2TO29n
         hqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705104; x=1705309904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+690ILLvmgoiVG3rWqnA7YdVgSm8xx8o94ASaIKF+E=;
        b=F3AyUmrSrqrQPB+El43jpYkfgASHLjHRjT9e9AoeFyk0h8DTBgNlPBpDQ91qfIzxe4
         lxpyx0oG9PMmUWrY7ftZcIV7oVAbMPdx/KmhSnLuRy9WmD0UgU0IhuPE6mlrXS/VI6I6
         dEcPC4mVBLS+d2Vq5Xr1tvCbKulnwOdbUBMd7idswIAbuf3l/GyQUUyqvgiuiiEw4pKr
         nprF4FXGXjWbvfv+LQjbzf1Jgg9yM3RwKLaoOs6W0HsGEh337N6Q/2tfjRhGPmt9fK1C
         dLB8L4VryLzjyEUFkLaBi4A84bQoQlZ8tpKkkklHqxNxO9EQJobt2tERYFmsks9yeefD
         FLBg==
X-Gm-Message-State: AOJu0YxEM7zOyqB7Gt1hE5K72OVHi0MgG4gEBln8WMEtyVXUyTBxhnoi
	gjBaIsP8Jvfl9FNJLDzKrRo=
X-Google-Smtp-Source: AGHT+IGWg/D2gzOJy5VZ0MkQ3jSBwyisSv8a+0uDyYO+7UHcw4Ew1YjljFCQhimSw7dKm/fOaIkTrA==
X-Received: by 2002:a17:906:f350:b0:a26:98a1:9e89 with SMTP id hg16-20020a170906f35000b00a2698a19e89mr1629990ejb.41.1704705103488;
        Mon, 08 Jan 2024 01:11:43 -0800 (PST)
Received: from [172.25.98.130] ([86.125.72.218])
        by smtp.gmail.com with ESMTPSA id d26-20020a170906175a00b00a27c463fbdesm3742109eje.211.2024.01.08.01.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 01:11:43 -0800 (PST)
Message-ID: <3d44d8ec-8c31-40f4-afc4-78e5b7a9c79b@gmail.com>
Date: Mon, 8 Jan 2024 11:11:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] dt-bindings: adc: add AD7173
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231220104810.3179-1-mitrutzceclan@gmail.com>
 <5b63afc1-3449-4231-b0f6-2b540237d725@linaro.org>
Content-Language: en-US
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <5b63afc1-3449-4231-b0f6-2b540237d725@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 19:45, Krzysztof Kozlowski wrote:
> On 20/12/2023 11:48, Dumitru Ceclan wrote:
>> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
>> which can be used in high precision, low noise single channel applications
>> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
>> primarily for measurement of signals close to DC but also delivers
>> outstanding performance with input bandwidths out to ~10kHz.
>>
>> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
>> ---
>> V10->V11
>>  - Fix example warning: '#gpio-cells' is a dependency of 'gpio-controller'
>>  - Add description to #gpio-cells property
>> V9->V10
> 
> None of your previous version were tested before sending, so I have
> really doubts that this version was.
> 
>>  - Fix dt_binding_check type warning from adi,reference-select
>> V8->v9
> 
> ...
> 
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright 2023 Analog Devices Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices AD7173 ADC
>> +
>> +maintainers:
>> +  - Ceclan Dumitru <dumitru.ceclan@analog.com>
>> +
>> +description: |
>> +  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
> 
> If there is going to be resend:
> Drop "Bindings for" and instead describe shortly the hardware. Also wrap
> above according to Linux coding style, so at 80.
> 
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-2.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7176-2.pdf
>> +
> 
> Rest looks good, so please tell did you test it?

Yes.

