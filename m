Return-Path: <linux-kernel+bounces-28966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745883054F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92972832D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE717FD;
	Wed, 17 Jan 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+sLHDON"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91A323C;
	Wed, 17 Jan 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494638; cv=none; b=B9UxzMhyeHI08UI2yWTfC/i46TIETW8qrPYtQsZ3/Yq+ABbeV58n3IUQcZX28iBSLb0hm2Tz0iogc2NiKxJF23wQcY2ZCEZPjM7GHKM1BNhucbk4cH88aJLiv0wfEjhzliajN9waVe0WWev+VoTbVFP7arjhpd83YntPdC+WoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494638; c=relaxed/simple;
	bh=k2YP41gfhRCO6Pvy0If05vh6BGXqT8zcyYOAEPetgsU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=oNEE4/OrXWJy1Z6sZqbeM829hQcuJ7+QBGq0E0wqPj6sx4YClkONBpOA5WYfDHkKmy2qM50NE7Sun7Cpb6Z9n75+CDL8X5TM0T56IN8jSMmg0BMd8SLjLLeMEnC8T9210i0eZMfA8Nnnv2xf8aW11FCcGIiSwVvo6PsvKVXT0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+sLHDON; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-559b3ee02adso2009643a12.3;
        Wed, 17 Jan 2024 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705494635; x=1706099435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4J0XnTedaZDRNfe7OrgwwHqKIo+SD8ns4luWlHiIYi8=;
        b=B+sLHDON6tv6Gyp3mQZbOcaYcOkXkyLykNwFLIXcbhMt+fW9F7+FWNKahMzBSJ7b7b
         bcEtFiXobBltkoKcC3YKe13mp/TBhIBPk4XzwxchJMZgZ1nq8nGsYUEj9IxO8Hv7Tr5P
         fcaNW/6fRJxEpVFD40vHOwdWnCnZjGqUF8S5Nlci/gMcVx85Du6FqK5UnkX1O3ZBu4VV
         c83JkPrPp30tq4L9DPZL6baQS1WXWYByxYMPQgpvR5FH6uuej4y11Xd3twKa/Eo8wnDA
         b/xMSBpFZBl+3P8QZN4RNkaVO5QbqEkpkgrrZaFqc3ah6ks/wU4uuNmd2OiMrwlP+bKq
         LlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705494635; x=1706099435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4J0XnTedaZDRNfe7OrgwwHqKIo+SD8ns4luWlHiIYi8=;
        b=qCC0iLrAtgqDN4gYyn89Z0ZdS2P+sinPL5K1Knni/mDJJgwPQ2FuNeg8V8FQ2S3Xwh
         3CNwCS8rzQMUHasNgKZTvMtx76Y7LX2RNOdgJstYcCmVnVHscR5CAgvQXpshdC4e2+uN
         4Wp3KVkfUrEJFv5VpJ0y9EtdKu7YnQ/Fj4owTxMoBALStisVjb2xiShNBDcIOTxxXaFu
         J6MKBOmA1SJAEFSIYuhk8Wrm+lYLcn8HfXrDz9owPhKAJVVExHXCqx2Q6Dqzx8VzYL2O
         1zrqp54wp6dOzfAxZY7/osCGSJMzO6++HDBf8WELG1cqSJaqi59OHD2LndNZdaWzRDTL
         wHHw==
X-Gm-Message-State: AOJu0YxSo1L59vloxa4+iCasZXn2sBEnFl8Oc3Se7IGx6qTR86N52Ufl
	0szXBhm/oSxqxZHwiAm0XvM=
X-Google-Smtp-Source: AGHT+IEpphXh8E9XIoChTO0OUusrPbDVBwCCh661wALpZ8tu8wuuo1wyWOdbUGa5FZomlx++15LQrg==
X-Received: by 2002:a17:906:480d:b0:a2e:98f4:c695 with SMTP id w13-20020a170906480d00b00a2e98f4c695mr745720ejq.81.1705494635278;
        Wed, 17 Jan 2024 04:30:35 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id gq26-20020a170906e25a00b00a2d5dc7f4c3sm4979968ejb.223.2024.01.17.04.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 04:30:34 -0800 (PST)
Message-ID: <38dcb8cc-5d16-41f2-845b-5c97cb691cb7@gmail.com>
Date: Wed, 17 Jan 2024 14:30:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] dt-bindings: adc: add AD7173
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>
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
 <CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/15/24 23:53, David Lechner wrote:
> On Wed, Dec 20, 2023 at 4:48 AM Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

..
> 
> According to the timing diagram in the datasheet, SCLK is high during
> idle, so don't we need `spi-cpol: true` here?
> 
> Likewise, data is valid on the trailing SCLK edge, so don't we need
> `spi-cpha: true` here?
> 
> 
V1 Rob Herring suggested that if device is not configurable, driver
should set the spi mode
>> +  gpio-controller:
>> +    description: Marks the device node as a GPIO controller.
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +    description:
>> +      The first cell is the GPIO number and the second cell specifies
>> +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
>> +
>> +  refin-supply:
>> +    description: external reference supply, can be used as reference for conversion.
> 
> If I'm understanding correctly, this represents both voltage inputs
> REF+ and REF-, correct? The datasheet says "Reference Input Negative
> Terminal. REF− can span from AVSS to AVDD1 − 1 V". It seems like they
> should be separate supplies in case REF- is non-zero. Otherwise, how
> can we know what voltage it is? (same comment applies to refin2.)
> Yes, but in that case, the value of the referenced supply should reflect
that and be equal to (REF+)-(REF-). I'll add to the description this.

..

>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
> 
> Why are interrupts required? What if the pin is not connected?
> 
From the datasheet, the reading of the conversions seem to be only
interrupt based: "As soon as the next conversion is complete,
the data register is updated; therefore, the period in which to
read the conversion is limited." this paragraph suggests to me that
interrupts are required

