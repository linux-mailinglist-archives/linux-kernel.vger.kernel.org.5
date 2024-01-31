Return-Path: <linux-kernel+bounces-46469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E462844038
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7ED4B242B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3507BAF8;
	Wed, 31 Jan 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBl6C9W8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431D7AE75;
	Wed, 31 Jan 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706763; cv=none; b=G+pXpDKrREiOUA3vEIoyEKGuLqvn1t99MpbplJ+2r3nKnYPSuZG1fIzOU/s9KogjaSF/Rh1z1rgbuhPFmYLMzz//vAvdKLKVE1u7z9NfZZKyYx6GrTqy8bMGwWFbs9VTFXmT7jVV2R/oqn/3DuOQC2gWHfOAHQBhGTHJKy6alTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706763; c=relaxed/simple;
	bh=E9Gxoqng6/P8Ph3ofb6E1aBYNVtn0OQSV7S9DVCV/VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmkpc4EMt1WpuhvFTXScty2YX6bxxMwVlTuLEdI4whRSM8vxkoEMpGICZoSxlRNYksHCy7hVQOiM4FiH3ABvUV2C4RllOAKJCIoN4/jDA8Cs+f0NYwuIfqphF196z2QzNF0II6SuU1q3jKWMgbyGQ7LLwJcYNf6AILr0j3Wf59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBl6C9W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2FDC433F1;
	Wed, 31 Jan 2024 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706706762;
	bh=E9Gxoqng6/P8Ph3ofb6E1aBYNVtn0OQSV7S9DVCV/VY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BBl6C9W8r67VoHLBm2KjTB0Alnd+BKz41icU+Dd+mHlEjxZgHIPievnKf9u9Rjnpn
	 LldnkyNR+ac5t0Uv5In4nC1u8FuA127pm4dty/EL3ew4890rv9f4oY0uhgzQV7FLGm
	 zdNaGwiXJzY/4KKjv8mGO88V3XJ1IqTUKw+V8FE1hUYUwTqZ4A3aOd/EPu9n08HwXN
	 Nu+YF8QDXGHWRONo6LEoJK+/m/3F7Fas2RsWM/CRTNkbZvAYg0j+AU7aajBm1MVjsx
	 78BupN+lOFPMipRBumu6fFPH0va+8vPoCquvoSwiDrnPZTnbFBPH+SWoBIzgGV2P/R
	 XpHsB6l3BeguQ==
Message-ID: <092a9986-5ebb-483d-9911-37a93d7cb2dd@kernel.org>
Date: Wed, 31 Jan 2024 14:12:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] w1: add UART w1 bus driver
To: cj.winklhofer@gmail.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
 <20240126-w1-uart-v5-3-1d82bfdc2ae9@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240126-w1-uart-v5-3-1d82bfdc2ae9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 16:42, Christoph Winklhofer via B4 Relay wrote:
> From: Christoph Winklhofer <cj.winklhofer@gmail.com>
> 
> Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
> the Serial Device Bus to create the 1-Wire timing patterns. The driver
> was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> DART-6UL" with a DS18S20 temperature sensor.
> 

..

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

Missing documentation of mutex scope. What does it protect?

> +	struct mutex mutex;
> +};
> +

..

> +/*
> + * Send one byte (tx_byte) and read one byte (rx_byte) via serdev.
> + */
> +static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
> +				const struct w1_uart_config *w1cfg, u8 *rx_byte)
> +{
> +	struct serdev_device *serdev = w1dev->serdev;
> +	int ret;
> +
> +	serdev_device_write_flush(serdev);
> +	serdev_device_set_baudrate(serdev, w1cfg->baudrate);
> +
> +	/* write and immediately read one byte */
> +	reinit_completion(&w1dev->rx_byte_received);
> +	ret = serdev_device_write_buf(serdev, &w1cfg->tx_byte, 1);
> +	if (ret != 1)
> +		return -EIO;
> +	ret = wait_for_completion_interruptible_timeout(
> +		&w1dev->rx_byte_received, W1_UART_TIMEOUT);
> +	if (ret <= 0)
> +		return -EIO;
> +
> +	/* locking could fail during driver remove or when serdev is

It's not netdev, so:
/*
 *

> +	 * unexpectedly in the receive callback.
> +	 */
> +	if (!mutex_trylock(&w1dev->mutex))
> +		return -EIO;
> +
> +	ret = w1dev->rx_err;
> +	if (ret == 0)
> +		*rx_byte = w1dev->rx_byte;
> +
> +	if (w1cfg->delay_us > 0)
> +		fsleep(w1cfg->delay_us);
> +
> +	mutex_unlock(&w1dev->mutex);
> +
> +	return ret;
> +}
> +
> +static ssize_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
> +					  const u8 *buf, size_t count)
> +{
> +	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
> +
> +	mutex_lock(&w1dev->mutex);
> +
> +	/* sent a single byte and receive one single byte */
> +	if (count == 1) {
> +		w1dev->rx_byte = buf[0];
> +		w1dev->rx_err = 0;
> +	} else {
> +		w1dev->rx_err = -EIO;
> +	}
> +
> +	mutex_unlock(&w1dev->mutex);
> +	complete(&w1dev->rx_byte_received);
> +
> +	return count;
> +}
> +
> +static const struct serdev_device_ops w1_uart_serdev_ops = {
> +	.receive_buf = w1_uart_serdev_receive_buf,
> +	.write_wakeup = serdev_device_write_wakeup,
> +};
> +
> +/*
> + * 1-wire reset and presence detect: A present slave will manipulate
> + * the received byte by pulling the 1-Wire low.
> + */
> +static u8 w1_uart_reset_bus(void *data)
> +{
> +	struct w1_uart_device *w1dev = data;
> +	const struct w1_uart_config *w1cfg = &w1dev->cfg_reset;
> +	int ret;
> +	u8 val;
> +
> +	ret = w1_uart_serdev_tx_rx(w1dev, w1cfg, &val);
> +	if (ret < 0)
> +		return -1;
> +
> +	/* Device present (0) or no device (1) */
> +	return val != w1cfg->tx_byte ? 0 : 1;
> +}
> +
> +/*
> + * 1-Wire read and write cycle: Only the read-0 manipulates the
> + * received byte, all others left the line untouched.
> + */
> +static u8 w1_uart_touch_bit(void *data, u8 bit)
> +{
> +	struct w1_uart_device *w1dev = data;
> +	const struct w1_uart_config *w1cfg = bit ? &w1dev->cfg_touch_1 :
> +						   &w1dev->cfg_touch_0;
> +	int ret;
> +	u8 val;
> +
> +	ret = w1_uart_serdev_tx_rx(w1dev, w1cfg, &val);
> +
> +	/* return inactive bus state on error */
> +	if (ret < 0)
> +		return 1;
> +
> +	return val == w1cfg->tx_byte ? 1 : 0;
> +}
> +
> +static int w1_uart_probe(struct serdev_device *serdev)
> +{
> +	struct device *dev = &serdev->dev;
> +	struct w1_uart_device *w1dev;
> +	int ret;
> +
> +	w1dev = devm_kzalloc(dev, sizeof(*w1dev), GFP_KERNEL);
> +	if (!w1dev)
> +		return -ENOMEM;
> +	w1dev->bus.data = w1dev;
> +	w1dev->bus.reset_bus = w1_uart_reset_bus;
> +	w1dev->bus.touch_bit = w1_uart_touch_bit;
> +	w1dev->serdev = serdev;
> +
> +	init_completion(&w1dev->rx_byte_received);
> +	mutex_init(&w1dev->mutex);
> +
> +	ret = w1_uart_serdev_open(w1dev);
> +	if (ret < 0)
> +		return ret;
> +	serdev_device_set_drvdata(serdev, w1dev);
> +	serdev_device_set_client_ops(serdev, &w1_uart_serdev_ops);
> +
> +	return w1_add_master_device(&w1dev->bus);
> +}
> +
> +static void w1_uart_remove(struct serdev_device *serdev)
> +{
> +	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
> +
> +	mutex_lock(&w1dev->mutex);
> +
> +	w1_remove_master_device(&w1dev->bus);
> +
> +	mutex_unlock(&w1dev->mutex);

This is still suspicious. You do not have serdev_device_close and you
want to protect from concurrent access but it looks insufficient.

This code assumes that:

w1_uart_remove()
  <-- here concurrent read/write might start
  mutex_lock()
  w1_remove_master_device()
  mutex_unlock()
  <-- now w1_uart_serdev_tx_rx() or w1_uart_serdev_receive_buf() can be
executed, but device is removed. So what's the point of the mutex here?

What exactly is protected by the mutex? So far it looks like only some
contents of w1dev, but it does not matter, because it that memory is
still valid at this point.

After describing what is protected we can think whether it is really
protected...


> 

Best regards,
Krzysztof


