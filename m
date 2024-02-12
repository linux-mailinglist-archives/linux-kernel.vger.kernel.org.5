Return-Path: <linux-kernel+bounces-61896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF12B8517F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF1D2816D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7127C3C495;
	Mon, 12 Feb 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlQCAiIC"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9F3BB46
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751806; cv=none; b=E0YrEqos3Ftr0hmHGmtrDak9q2kyL9C9SoGvbc+gYZpLxhauH+OZIPdgQ0Gd6t/SqkRwhKNGW0U1eSm0rK3eJi/cKfI8bGvLbiV0645UEj5PiGvOq+1OI4VcPkmQfVCgOsNYA+rIh1VXoYgtE0W84NH6MXLxzeDGwRg4sgw9rK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751806; c=relaxed/simple;
	bh=o7EqBulYBqX7382gGUYN5q/Lgfux7Xv/kCzdBM5LRTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ri6qqrfQyU8n9LNd1luippSfUx++8XCdThRZkT+ljNGxWJdgu4GX+VZm3vGxt+pLXERX4K2DUiEBy32qPOTTLrJ9v+/Vbx/dd+FoiEeuGPs2h6JRfXVLXHM3LAZKWzQM0vy0nXryaNmQTu/kjxlv8s6EHsIS4xNVZboYf0FceyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AlQCAiIC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so1578654f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707751803; x=1708356603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5crm3hu9WEw2jTPVi0avg8DNPaQGl8WHHBqfWevK2EI=;
        b=AlQCAiICxdvPMKAckj70O/UV1b8noN3OQjczCYgFJv461Y+bz/ex0t1OtCzMA5/b2Z
         53kivEcjKF3rqtqTHU/mTgI1/gRIQacgOi135jqwHBerFVKg3fOtcMoN1IoT/j6lcwj5
         lqYHC7x/dizNQHTF8j1qWEUj2iqmFu8/PtHVY9RC8ULNtIr6V10ZG/dmvWJWG2fZY9Ds
         raWj9p2KA49lkI4u4+ZCmsHDUUxSoVlUZ7f+F7SsvhHBRbL1fVncWioLGLnuFx//rR8z
         An7lxwMfSA9pJEfiryTGCyR+YD/B3DG9roRAXrFaACKscGBXcj119VqGEKXDJEgoIVXs
         SlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707751803; x=1708356603;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5crm3hu9WEw2jTPVi0avg8DNPaQGl8WHHBqfWevK2EI=;
        b=K5QEsFBoA5qgTz9tV54OG/pCx0rZmmwXrnvJvVou2RBev1gDHTBb10DmU4Yu5NNJV+
         UcLYW2p9K1wDKMTDGtZBcXcADHNNR2Vhp610FVskmSj5GwYkJJ1nuNMzZ0wnwVFts2Dm
         Or9gG6IBPdSgBCInNEFPTOUiX8cFWaw3k+265R4nVccc1gE/qOwUvb8/zLMIjDNpX0XO
         YR5pbYzgijmX93dR39iykSBA+qjnJlG00d91HDgicGYBn/C5kAHaEtjakOwfeZaixbXY
         p/ei4ZQB7Tv24FPtW/qb/JaFtKj3Dd2420jBJCctpIQjk6rVo7sMTVY5rbr+8n/xVpGk
         b6kA==
X-Gm-Message-State: AOJu0YwcTWd66WUw2aqwW36h60XS7Ph9SDkPYfV2CwlaHgU+PUlhzIYk
	Sz3B43owmqCzMrhc0HlWsoGOjQuuqSMXEH0YGNpLljbcogAYMz62+sSeuPEORsc=
X-Google-Smtp-Source: AGHT+IHPbkJBXzIx7t0YdNRWGOhtrizVim2+F59oREaGU6TsoEv8GzZWetmxxnvv6iQdFSCUCnpsCg==
X-Received: by 2002:a05:6000:108f:b0:33b:63f7:eba2 with SMTP id y15-20020a056000108f00b0033b63f7eba2mr5228867wrw.5.1707751802981;
        Mon, 12 Feb 2024 07:30:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuRpsmM0NGEbL0Zwfx4noAWP51su9KUi51YxTuJK98jV8UWp44VKfztUIGM3L16Sk2FVxoRe8SyGMSb21oPRxClXusbwDXlSwNUmi5pai+GnHE+GloRBNWBZ1Bbf0bMXNGH/2fhUpNy2mCr6s4RGf8Cvvf0M2uLu+VaZtVFU4bfZcIbEkrehoi5WPEv2FVPrDGr/abyb5W3iXq/Rbkhk8GbaqK3Nz6zSq7UlgG5HGq8Jo3I6y/e+N9nBPRwDmnWOlH+7DWrL5C8SKOlNdqHWQ3SsFfCG/4DnEWi+JuOYM4Twjne4kkWEWMQTkErm424YjPjJcd+b1NGc43sxJ/8aW5dJMUDZ6zRv8lI0sOfJgoWDf/OkV3z6Symc8uiSkjMUAy4PxG
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id y12-20020a056000108c00b0033b40a3f92asm7107465wrw.25.2024.02.12.07.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:30:02 -0800 (PST)
Message-ID: <466d7be4-6ca1-4eb2-a59b-a3f0a846a2df@linaro.org>
Date: Mon, 12 Feb 2024 16:30:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] w1: add UART w1 bus driver
Content-Language: en-US
To: cj.winklhofer@gmail.com, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240209-w1-uart-v6-0-3e753c149196@gmail.com>
 <20240209-w1-uart-v6-3-3e753c149196@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240209-w1-uart-v6-3-3e753c149196@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 07:22, Christoph Winklhofer via B4 Relay wrote:
> From: Christoph Winklhofer <cj.winklhofer@gmail.com>
> 
> Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
> the Serial Device Bus to create the 1-Wire timing patterns. The driver
> was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> DART-6UL" with a DS18S20 temperature sensor.
> 
> The 1-Wire timing pattern and the corresponding UART baud-rate with the
> interpretation of the transferred bytes are described in the document:


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
> +	u8 tx_byte;
> +};
> +
> +/*
> + * struct w1_uart_config - w1-uart device data

That's neither correct (device, not config) nor proper kerneldoc nor
useful. Your comment repeats struct name. If you want to make it
kerneldoc, go ahead, but then make it a full kerneldoc.

And obviously compile with W=1.

> + *
> + * @serdev: serial device
> + * @bus: w1-bus master
> + * @cfg_reset: config for 1-Wire reset
> + * @cfg_touch_0: config for 1-Wire write-0 cycle
> + * @cfg_touch_1: config for 1-Wire write-1 and read cycle
> + * @rx_byte_received: completion for serdev receive
> + * @rx_err: indicates an error in serdev-receive
> + * @rx_byte: result byte from serdev-receive
> + * @mutex: mutex to protected rx_err and rx_byte from concurrent access
> + *         in w1-callbacks and serdev-receive.
> + */
> +struct w1_uart_device {
> +	struct serdev_device *serdev;
> +	struct w1_bus_master bus;
> +
> +	struct w1_uart_config cfg_reset;
> +	struct w1_uart_config cfg_touch_0;
> +	struct w1_uart_config cfg_touch_1;
> +
> +	struct completion rx_byte_received;
> +	int rx_err;
> +	u8 rx_byte;
> +

How did you solve my comment and checkpatch warning from previous version:

CHECK: struct mutex definition without comment

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

..

> +/*
> + * Configuration for write-1 and read cycle (touch bit 1)
> + * - bit_min_us is 5us, add margin and use 6us
> + * - limits for sample time 5us-15us, use 15us
> + */
> +static int w1_uart_set_config_touch_1(struct w1_uart_device *w1dev)
> +{
> +	struct serdev_device *serdev = w1dev->serdev;
> +	struct device_node *np = serdev->dev.of_node;
> +
> +	struct w1_uart_limits limits = { .baudrate = 115200,
> +					 .bit_min_us = 6,
> +					 .bit_max_us = 15,
> +					 .sample_us = 15,
> +					 .cycle_us = 70 };
> +
> +	of_property_read_u32(np, "write-1-bps", &limits.baudrate);
> +
> +	return w1_uart_set_config(serdev, &limits, &w1dev->cfg_touch_1);
> +}
> +
> +/*
> + * Configure and open the serial device
> + */
> +static int w1_uart_serdev_open(struct w1_uart_device *w1dev)
> +{
> +	struct serdev_device *serdev = w1dev->serdev;
> +	struct device *dev = &serdev->dev;
> +	int ret;
> +
> +	/* serdev is automatically closed on unbind or driver remove */

Drop comment, that's obvious. That's what devm* functions are for.


> +	ret = devm_serdev_device_open(dev, serdev);


> +	if (ret < 0)
> +		return ret;
> +
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret < 0) {
> +		dev_err(dev, "set parity failed\n");
> +		return ret;
> +	}


Best regards,
Krzysztof


