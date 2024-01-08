Return-Path: <linux-kernel+bounces-19095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713ED8267E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6243281AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE027493;
	Mon,  8 Jan 2024 06:18:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018079C2;
	Mon,  8 Jan 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28d61ba65eso141977066b.3;
        Sun, 07 Jan 2024 22:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704694717; x=1705299517;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxKWZ0iFvolfQySmIZiVviFxg2q/+Ns/Cenq1wSZJho=;
        b=gdxQB2+Q9VoolFW97n58rOvf38dqBjg6aKqWFWSS517gmtfbDvacYCLLqcjgT1a9J6
         R4jOeUCh4CZVeFTU7Ve8wWnAytzv6Xy1yVCaSoTYdAOFX8MxkzFtMLVK+Yxw9oVDzuNF
         Q54f6w4JqwjAp2mhFFPde8nlYM/jdQpBO3gDKmpe+J1tPFI6MpJGnOo4mu2WLyCs2SVJ
         SHdoy6o6YVoI0r2wKro+onQzjxLYG+QNCspHA/qblf5/VbC4bXyjrkku0d3N5K4HnQV/
         F+w0GmH2w7nrCKiZJA8MN5J7lR+5k6eWDFRuEvLMtjnwvjWhe2sWviLkpwAJUw2mCYIS
         49fg==
X-Gm-Message-State: AOJu0YySFNvM1QFFAetVw/LG/MYCK0LlnQsy6cyvHCoRoPFV9GROsBaB
	xQE9123Qmfs3CgF8Lffdal4=
X-Google-Smtp-Source: AGHT+IFeqtsrG2JhlBgein+Rw5XTWn/lKs4vnN4bvJMQevNx/oK+r3H1HNZrWhEAjCpUj4ErahUCVw==
X-Received: by 2002:a17:906:4f:b0:a28:aa08:200b with SMTP id 15-20020a170906004f00b00a28aa08200bmr744741ejg.140.1704694712800;
        Sun, 07 Jan 2024 22:18:32 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id d11-20020a170906640b00b00a26f1f36708sm3624821ejm.78.2024.01.07.22.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 22:18:32 -0800 (PST)
Message-ID: <5ff1d706-9f06-4eb6-bc86-75f933e54118@kernel.org>
Date: Mon, 8 Jan 2024 07:18:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] w1: add UART w1 bus driver
Content-Language: en-US
To: cj.winklhofer@gmail.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <20240106-w1-uart-v4-3-7fe1378a8b3e@gmail.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240106-w1-uart-v4-3-7fe1378a8b3e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06. 01. 24, 17:02, Christoph Winklhofer via B4 Relay wrote:
> From: Christoph Winklhofer <cj.winklhofer@gmail.com>
> 
> Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
> the Serial Device Bus to create the 1-Wire timing patterns. The driver
> was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> DART-6UL" with a DS18S20 temperature sensor.
> 
> The 1-Wire timing pattern and the corresponding UART baud-rate with the
> interpretation of the transferred bytes are described in the document:
> 
> Link: https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
> 
> In short, the UART peripheral must support full-duplex and operate in
> open-drain mode. The timing patterns are generated by a specific
> combination of baud-rate and transmitted byte, which corresponds to a
> 1-Wire read bit, write bit or reset.
...
> --- /dev/null
> +++ b/drivers/w1/masters/w1-uart.c
> @@ -0,0 +1,398 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * w1-uart - UART 1-Wire bus driver
> + *
> + * Uses the UART interface (via Serial Device Bus) to create the 1-Wire
> + * timing patterns. Implements the following 1-Wire master interface:
> + *
> + * - reset_bus: requests baud-rate 9600
> + *
> + * - touch_bit: requests baud-rate 115200
> + *
> + * Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/serdev.h>
> +#include <linux/w1.h>
> +
> +#define W1_UART_TIMEOUT msecs_to_jiffies(500)
> +
> +/*
> + * struct w1_uart_config - configuration for 1-Wire operation
> + *
> + * @baudrate: baud-rate returned from serdev
> + * @delay_us: delay to complete a 1-Wire cycle (in us)
> + * @tx_byte: byte to generate 1-Wire timing pattern
> + */
> +struct w1_uart_config {
> +	unsigned int baudrate;
> +	unsigned int delay_us;
> +	unsigned char tx_byte;

If it is a "byte", it should be u8.

> +};
> +
> +struct w1_uart_device {
> +	struct serdev_device *serdev;
> +	struct w1_bus_master bus;
> +
> +	struct w1_uart_config cfg_reset;
> +	struct w1_uart_config cfg_touch_0;
> +	struct w1_uart_config cfg_touch_1;
> +
> +	struct completion rx_byte_received;
> +	unsigned char rx_byte;

The same here.

> +	int rx_err;
> +
> +	struct mutex mutex;
> +};
> +
> +/*
> + * struct w1_uart_limits - limits for 1-Wire operations
> + *
> + * @baudrate: Requested baud-rate to create 1-Wire timing pattern
> + * @bit_min_us: minimum time for a bit (in us)
> + * @bit_max_us: maximum time for a bit (in us)
> + * @sample_us: timespan to sample 1-Wire response
> + * @cycle_us: duration of the 1-Wire cycle
> + */
> +struct w1_uart_limits {
> +	unsigned int baudrate;
> +	unsigned int bit_min_us;
> +	unsigned int bit_max_us;
> +	unsigned int sample_us;
> +	unsigned int cycle_us;
> +};
> +
> +static inline unsigned int baud_to_bit_ns(unsigned int baud)
> +{
> +	return 1000000000 / baud;

NSEC_PER_SEC

> +}
> +
> +static inline unsigned int to_ns(unsigned int us)
> +{
> +	return us * 1000;

NSEC_PER_USEC

> +}
> +
> +/*
> + * Set baud-rate, delay and tx-byte to create a 1-Wire pulse and adapt
> + * the tx-byte according to the actual baud-rate.
> + *
> + * Reject when:
> + * - time for a bit outside min/max range
> + * - a 1-Wire response is not detectable for sent byte
> + */
> +static int w1_uart_set_config(struct serdev_device *serdev,
> +			      const struct w1_uart_limits *limits,
> +			      struct w1_uart_config *w1cfg)
> +{
> +	unsigned int bits_low;
> +	unsigned int bit_ns;
> +	unsigned int low_ns;
> +
> +	w1cfg->baudrate = serdev_device_set_baudrate(serdev, limits->baudrate);
> +	if (w1cfg->baudrate == 0)
> +		return -EINVAL;
> +
> +	/* Compute in nanoseconds for accuracy */
> +	bit_ns = baud_to_bit_ns(w1cfg->baudrate);
> +	bits_low = to_ns(limits->bit_min_us) / bit_ns;
> +	/* start bit is always low */
> +	low_ns = bit_ns * (bits_low + 1);
> +
> +	if (low_ns < to_ns(limits->bit_min_us))
> +		return -EINVAL;
> +
> +	if (low_ns > to_ns(limits->bit_max_us))
> +		return -EINVAL;
> +
> +	/* 1-Wire response detectable for sent byte */
> +	if (limits->sample_us > 0 &&
> +	    bit_ns * 8 < low_ns + to_ns(limits->sample_us))

BITS_PER_BYTE

> +		return -EINVAL;
> +
> +	/* delay to complete 1-Wire cycle, include start and stop-bit */
> +	w1cfg->delay_us = 0;
> +	if (bit_ns * 10 < to_ns(limits->cycle_us))

What is this 10? Dub it.

> +		w1cfg->delay_us =
> +			(to_ns(limits->cycle_us) - bit_ns * 10) / 1000;

And this 10?

The end: / NSEC_PER_USEC

> +
> +	/* byte to create 1-Wire pulse */
> +	w1cfg->tx_byte = 0xff << bits_low;
> +
> +	return 0;
> +}
...

> +static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
> +				const struct w1_uart_config *w1cfg,
> +				unsigned char *rx_byte)

u8 *

> +{
...
> +}
> +
> +static int w1_uart_serdev_receive_buf(struct serdev_device *serdev,
> +				      const unsigned char *buf, size_t count)

serdev already uses u8 * here. You are basing on the top of some old tree.

regards,
-- 
js
suse labs


