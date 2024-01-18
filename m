Return-Path: <linux-kernel+bounces-30302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8A831CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC583B217F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DA28DAB;
	Thu, 18 Jan 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOmWctDI"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3FE28DA6;
	Thu, 18 Jan 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593085; cv=none; b=rV62zmQVZm2cJnuYZRHlwlezklokMFavmiNTUYYr8QGptI40Ybe116TQlpE7/DhWQu0fTLNwmjRXYrsXteJ4qZQqiD7GYx7J3T8KHlmT0XvARFBgkyvyJ268YxUHCjVGC7PnxEEE0l8HSrxV1hTl2k5C7El4WE2LJbEgxcnAv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593085; c=relaxed/simple;
	bh=oWpi2JrQuUZLZromKslwlBpZlFwq2927wlFJpoDKjrg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=BcJT7aLrmu5R8RI/+2CoBm7YDUAfa9uIWpWAC2JvO8P4bwGFK2LBoyq/GKtEsOX4s8CBP8iLYoQfsk1tJiYSdG6Gm9xuYYanfnCH+r206Askyf7iuxIKTF3k9M7MU9qsP5X+JTHDEzvVEsthhdEB4gX1J7p/fU4pwdoYTSGJjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOmWctDI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2cea0563cbso984317166b.3;
        Thu, 18 Jan 2024 07:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705593082; x=1706197882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9f+L4gOO/9O6aBb0rArE0lflDdOky7Q24Fs1sGyzzw=;
        b=IOmWctDILRfXqcaWr79cjiPHqKAu8+HBqYKY7ibowws7B3nU4akeYfpZbiawB7QY3q
         1wxPRmNE3b8aAd+ic8kVO3Km5HEx7iMKFzTME+dwAP2PsVAAhFsHOho2eBJ+D9azS2fk
         D47iRRwGZwVylyYIUQPRIiFdNrp6xo2lcS7P2B/2ZqNldDEHTg2UGEzXTff8Ha/z7J5F
         7ji8cXOW2+6fD6ot2LsZMQZUfBi6+vLd5OsopKsmgs41WZZMK7hvUjTB+uVAsvCSgSls
         1U5srS6vFitCmYND9eWNmaetjOS0hv9S5cbtVLBfWoFQ463jISoyecwqjBAxUr5sh9gJ
         gJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593082; x=1706197882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9f+L4gOO/9O6aBb0rArE0lflDdOky7Q24Fs1sGyzzw=;
        b=DhoIbm/azJ1YQ6PvgcWnymTpM9BNdS1lZnQqNdzCY8ggn+2yJhEOVEZmiHZhe7A1Hj
         WQPr5QDvI6KuOuM9YLamthbvuRrBLkEfAceTvvwGqwC7vqXHcPPM1WIR2ECjO8F3a5pF
         /YVh8FVwGNuV11fOZc1mjFU3iRpnvtNWwXiu3J5MBQIa9CxUTpkFQAg7VOEWtrbD6pbf
         Untg/keJ6NqvP9Bd1EfwgTC5hC5nSFqmsHv9div6FVa55IUB+ZhO+jj1LE5vgX/CTIl7
         uhz8ZvJfp297NuIZgzUknGhGspV+fBLZv1OZrgIFQZq6S7wbVNsZvIwRVc6e9AyFu+rG
         nU9Q==
X-Gm-Message-State: AOJu0Yws1ytVyheZV9nOxFQTXb9031I6OMbT53gb+t+2mjUFvAj5QmPf
	u9vX5h0sL9dcbANM5QA4gwFUox2Ul0UDm1CQopr/+eOIsPyVhy9D
X-Google-Smtp-Source: AGHT+IFNOGUSHmhkyBC95bCQG2EUFZpsiNRgUFypRFhQKu1gmfIqRGPzYONGSYDJqQ194/mYvb+Tgw==
X-Received: by 2002:a17:907:3f08:b0:a29:105:4dd4 with SMTP id hq8-20020a1709073f0800b00a2901054dd4mr770790ejc.13.1705593082175;
        Thu, 18 Jan 2024 07:51:22 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906244400b00a2a0fa29cc7sm9205834ejb.47.2024.01.18.07.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 07:51:21 -0800 (PST)
Message-ID: <b96d5bfc-cc38-44c7-a88f-e7ac5e4eb71d@gmail.com>
Date: Thu, 18 Jan 2024 17:51:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/2] dt-bindings: adc: add AD7173
To: Conor Dooley <conor@kernel.org>
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
 David Lechner <dlechner@baylibre.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
 <20240118-lunar-anthem-31bf3b9b351d@spud>
Content-Language: en-US
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20240118-lunar-anthem-31bf3b9b351d@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/24 17:23, Conor Dooley wrote:
> On Thu, Jan 18, 2024 at 02:49:22PM +0200, Dumitru Ceclan wrote:

..

>> +  adi,clock-select:
>> +    description: |
>> +      Select the ADC clock source. Valid values are:
>> +      int         : Internal oscillator
>> +      int-out     : Internal oscillator with output on XTAL2 pin
>> +      ext-clk     : External clock input on XTAL2 pin
>> +      xtal        : External crystal on XTAL1 and XTAL2 pins
>> +
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum:
>> +      - int
>> +      - int-out
>> +      - ext-clk
>> +      - xtal
>> +    default: int
> I am not a fan of properties like this one, that in my view reimplement
> things that are supported by the regular clocks properties. I've got
> some questions for you so I can understand whether or not this custom
> property is required.
> 
> Whether or not the ext-clk or xtal is used is known based on
> clock-names - why is the custom property required to determine that?
> If neither of those clocks are present, then the internal clock would be
> used. Choosing to use the internal clock if an external one is provided
> sounds to me like a software policy decision made by the operating
> system.

If there was no int-out, sure. I considered that the choice between int
and int-out could be made here. So better for driver to choose int/int-out?

> 
> Finally, if the ADC has a clock output, why can that not be represented
> by making the ADC a clock-controller?
> 

Was not familiar with this/did not cross my mind. So if xtal/ext-clk is
present, the driver should detect it and disable the option for clock
output? (Common pin XTAL2)

