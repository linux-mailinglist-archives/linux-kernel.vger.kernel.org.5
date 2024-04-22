Return-Path: <linux-kernel+bounces-152789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F418AC439
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81441B21CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7602D481B3;
	Mon, 22 Apr 2024 06:30:56 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C51F61C;
	Mon, 22 Apr 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767455; cv=none; b=Aw29ZCkuphrj5wk1jcmeQlV8Agi/XazVMPJJQ9kAX1eSqGbUA6BIaiTLvjuI3c6ctDFvvCjtGZSquI9Hq71189+Z1q8/vZjRHhMNc+ngLVZs9NxKQ4rAdXwnP9MTRym60pL9O2ALpleYUAz5TnFTQOJQQAdOL3iJSY9EHgp8urg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767455; c=relaxed/simple;
	bh=ZF8/roY0/AmpBQ3CMW4FkQw3iWV/Qxm6T515kZrXsKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGswfIaf+ds4Tx7WA0oPoeIjloXSL8oJ5d959kpNG8/YlnXo1Eu5FKxrTsZbcCNJLF+R3PnJ6L9rXXdDKntpLtcfCB9nQGA8tKUEzczF2DibAwLgdcudu9y20gsCeMQbHfmrbthvDO48+a107OwpL6tnsrtuFM5G5XwycaS790Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so8090168a12.0;
        Sun, 21 Apr 2024 23:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713767452; x=1714372252;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbek83bH+bmdJVeZSQAmI/qCW2wzUcsSL38Y65k0QiI=;
        b=BWGl1ARggi6ugmxq10uQIsaySt9pxo+gMsUiworBd4RohtYoMsE0ZJEtZWPcIzc9Fy
         gvQg5t5dUMxLsidjvZCZTnL0R7KT7kED0ijGhNDKdpRcgFs+WQtL2K/qFm2/QOPnwa7L
         wCtP3oWX7MmPpZcwwb2aTo4+TxCG/ETaPKJ6fh/HqunYyS3G0lEYQWi756Gk3wR4bcU0
         2IJdZfk8WI9vYKNlr3g12GGZkQpuR5bc83aHpfSK0EUH1s4/5yCtCeXL0b6gAwHsZdom
         bovshqF41pnS54i0uXb6kAmaaFdsCHvu6g3+TTgqlKMoYrXAghnWR9FfH4RltYUMRMoI
         z7TA==
X-Forwarded-Encrypted: i=1; AJvYcCVB0v+bQWrqFt1b6mHTd+Rm5IJoyKWCXC0BS7N6dsZEznFPu9269+NU5ydJq3D/Uyj0bxinBHCiEc1J3PT1NNisiAhHoWQz9gYc3I4Thw6R/djY/lvz2yFRKHNQaWlmuqd6dyjWcFLJZvU4
X-Gm-Message-State: AOJu0YzaVx443aqMzR3oK6EKaRZI2i3fW9S77ZozKwvEbp7a0HlXS8ex
	j6aHMuFl0ZWZt97lvBQ8tZLTxbIYSOCSyuvbLtSp9IFYhkGP/YKf
X-Google-Smtp-Source: AGHT+IHunsPki0d+qtMRiMmwa62qibNaTGF3JWV8VNMXzl3jYv+E6gKev6ZZ/3W0eVUnAVZOWG1AFA==
X-Received: by 2002:a17:906:c112:b0:a55:aded:200d with SMTP id do18-20020a170906c11200b00a55aded200dmr3553154ejc.12.1713767452360;
        Sun, 21 Apr 2024 23:30:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id mc11-20020a170906eb4b00b00a5256d8c956sm5315446ejb.61.2024.04.21.23.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 23:30:51 -0700 (PDT)
Message-ID: <7cf31245-b2a1-419c-add6-a6a50a3f3cf1@kernel.org>
Date: Mon, 22 Apr 2024 08:30:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
 robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
 manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
 u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
 Konstantin Pugin <ria.freelander@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Lech Perczak <lech.perczak@camlingroup.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240420182223.1153195-1-rilian.la.te@ya.ru>
 <20240420182223.1153195-4-rilian.la.te@ya.ru>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240420182223.1153195-4-rilian.la.te@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20. 04. 24, 20:22, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> XR20M1172 register set is mostly compatible with SC16IS762, but it has
> a support for additional division rates of UART with special DLD register.
> So, add handling this register by appropriate devicetree bindings.
..
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
..
> @@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
>   	return reg == SC16IS7XX_RHR_REG;
>   }
>   
> +static bool sc16is7xx_has_dld(struct device *dev)
> +{
> +		struct sc16is7xx_port *s = dev_get_drvdata(dev);
> +
> +		if (s->devtype == &xr20m1172_devtype)
> +			return true;
> +		return false;

:) so this should simply be:

return s->devtype == &xr20m1172_devtype;

..
> @@ -1002,6 +1052,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
>   				  const struct ktermios *old)
>   {
>   	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
> +	bool has_dld = sc16is7xx_has_dld(port->dev);
>   	unsigned int lcr, flow = 0;
>   	int baud;
>   	unsigned long flags;
> @@ -1084,7 +1135,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
>   	/* Get baud rate generator configuration */
>   	baud = uart_get_baud_rate(port, termios, old,
>   				  port->uartclk / 16 / 4 / 0xffff,
> -				  port->uartclk / 16);
> +				  port->uartclk / (has_dld ? 4 : 16));

Could you do this instead:
unsigned int divisor = sc16is7xx_has_dld(port->dev) ? 4 : 16;

..

uart_get_baud_rate(..., port->uartclk / divisor);


I am not sure the above warrants for a new version. Just in case you are 
sending one.

thanks,
-- 
js
suse labs


