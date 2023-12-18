Return-Path: <linux-kernel+bounces-3073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B58166F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE56B20D49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA979CB;
	Mon, 18 Dec 2023 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJWnm1YL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94757490
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e4fda12ef0so12520507b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702882714; x=1703487514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ww0M1P5mq83AgoiTq0T9S3I8YAm+W6G/Cvs6hVBdZfM=;
        b=nJWnm1YL0WfLlqvxIcZyKQn2iAm1jqxeSQMAbieQLZSKOma8QGkYVSHTE0l2nQ6fTu
         qMSW2u/XjFZFA5070pSXKOsT66PZWC3jCTmYAxBKSijxVxkjB0z9hr2uh5P0W+07kZ/Y
         OGPuoA60PSF8UyJSJskRNEdqQrpw8/E3nPd3bbqRbljN9NjJ219+/VxcL24ljIUJikXz
         yJcttrsM3Nm71jyr3bKoITMMVmLsUhxCoftytvL149YuPdVFz9rJjYNrVvKN5CB/s+Gm
         sYjsH6sXz/YaQoKOEbxDAFONbjc9o06rmAQgDOI7AnekDphjnHHftxLiNczgRksur6T2
         stGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702882714; x=1703487514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww0M1P5mq83AgoiTq0T9S3I8YAm+W6G/Cvs6hVBdZfM=;
        b=B9IJYO7DT67I5TTOQdrSsVsWcm5WOPHHSLwA664PV3XkrYa9Hn5hzxR+T+S5WfyEHG
         bUs2yfW39VzxyYWMpo2ahhRguDHGNDp2xwlNZAcrdli5OuJxUiLf5E1nphpYGq8Y2tND
         3wVyeGLt9ZU5nv011shYl+jODOYvEql8acWCZhMD3+6KsvRp/4DymBDwuZhEmVGofRwx
         4O/IhFrLLWJ8ZxairvZAJrgd1+Sh9AMLuAe8YAxggQ1RWJUfHQPfHS5r4nsGP/uPECKB
         LLBKbG+nJWAmRTYii8nyVaBnFV6UOeaSJF1XllWUImPoPOZ99mjYgSGoGUypghP8Aauc
         +vJA==
X-Gm-Message-State: AOJu0Yy5L/BieB7UY31+Rr5oG2sOUyjaWy1XMf9EU/fF+sPB/YyCTlUT
	bMaHiSRQtXgntlxvVhd+B+wRvA==
X-Google-Smtp-Source: AGHT+IF3XtZQxLkiu9lezaSY5Fyf48G1zPphl87rqb3Pk36Ma6BX0DjAR8MLjEuXrKewqESUg/ty4w==
X-Received: by 2002:a81:a04c:0:b0:5e5:e91e:dcdc with SMTP id x73-20020a81a04c000000b005e5e91edcdcmr935215ywg.3.1702882714525;
        Sun, 17 Dec 2023 22:58:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id v126-20020a818584000000b005a7aef2c1c3sm8611809ywf.132.2023.12.17.22.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 22:58:33 -0800 (PST)
Message-ID: <c19efc7d-2e63-43fb-952b-a4b373bc4371@linaro.org>
Date: Mon, 18 Dec 2023 07:58:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] w1: add UART w1 bus driver
Content-Language: en-US
To: Christoph Winklhofer <cj.winklhofer@gmail.com>, robh+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231217122004.42795-1-cj.winklhofer@gmail.com>
 <20231217122004.42795-3-cj.winklhofer@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231217122004.42795-3-cj.winklhofer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2023 13:20, Christoph Winklhofer wrote:
> Add a UART 1-wire bus driver. The driver utilizes the UART interface via
> the Serial Device Bus to create the 1-wire timing patterns. The driver
> was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> DART-6UL" with a DS18S20 temperature sensor.
> 
> The 1-wire timing pattern and the corresponding UART baud-rate with the
> interpretation of the transferred bytes are described in the document:
> 
> Link: https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
> 
> In short, the UART peripheral must support full-duplex and operate in
> open-drain mode. The timing patterns are generated by a specific
> combination of baud-rate and transmitted byte, which corresponds to a
> 1-Wire read bit, write bit or reset.
> 
> Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> ---
>  Documentation/w1/masters/index.rst   |   1 +
>  Documentation/w1/masters/w1-uart.rst |  48 +++++++
>  drivers/w1/masters/Kconfig           |  10 ++
>  drivers/w1/masters/Makefile          |   1 +
>  drivers/w1/masters/w1-uart.c         | 189 +++++++++++++++++++++++++++
>  5 files changed, 249 insertions(+)
>  create mode 100644 Documentation/w1/masters/w1-uart.rst
>  create mode 100644 drivers/w1/masters/w1-uart.c
> 
> diff --git a/Documentation/w1/masters/index.rst b/Documentation/w1/masters/index.rst
> index 4442a98850ad..cc40189909fd 100644
> --- a/Documentation/w1/masters/index.rst
> +++ b/Documentation/w1/masters/index.rst
> @@ -12,3 +12,4 @@
>     mxc-w1
>     omap-hdq
>     w1-gpio
> +   w1-uart
> diff --git a/Documentation/w1/masters/w1-uart.rst b/Documentation/w1/masters/w1-uart.rst
> new file mode 100644
> index 000000000000..0f546cf77f13
> --- /dev/null
> +++ b/Documentation/w1/masters/w1-uart.rst
> @@ -0,0 +1,48 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=====================
> +Kernel driver w1-uart
> +=====================
> +
> +Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
> +
> +
> +Description
> +-----------
> +
> +UART 1-wire bus driver. The driver utilizes the UART interface via the
> +Serial Device Bus to create the 1-Wire timing patterns as described in
> +the document `"Using a UART to Implement a 1-Wire Bus Master"`_.
> +
> +.. _"Using a UART to Implement a 1-Wire Bus Master": https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
> +
> +In short, the UART peripheral must support full-duplex and operate in
> +open-drain mode. The timing patterns are generated by a specific
> +combination of baud-rate and transmitted byte, which corresponds to a
> +1-Wire read bit, write bit or reset pulse.
> +
> +For instance the timing pattern for a 1-Wire reset and presence detect uses
> +the baud-rate 9600, i.e. 104.2 us per bit. The transmitted byte 0xf0 over
> +UART (least significant bit first, start-bit low) sets the reset low time
> +for 1-Wire to 521 us. A present 1-Wire device changes the received byte by
> +pulling the line low, which is used by the driver to evaluate the result of
> +the 1-Wire operation.
> +
> +Similar for a 1-Wire read bit or write bit, which uses the baud-rate
> +115200, i.e. 8.7 us per bit. The transmitted byte 0x00 is used for a
> +Write-0 operation and the byte 0xff for Read-0, Read-1 and Write-1.
> +
> +
> +Usage
> +-----
> +
> +Specify the UART 1-wire bus in the device tree by adding the single child
> +onewire to the serial node (e.g. uart0). For example:
> +::
> +
> +  @uart0 {
> +    ...
> +    onewire {
> +      compatible = "w1-uart";
> +    };
> +  };
> diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
> index 513c0b114337..e6049a75b35b 100644
> --- a/drivers/w1/masters/Kconfig
> +++ b/drivers/w1/masters/Kconfig
> @@ -78,5 +78,15 @@ config W1_MASTER_SGI
>  	  This support is also available as a module.  If so, the module
>  	  will be called sgi_w1.
>  
> +config W1_MASTER_UART
> +	tristate "UART 1-wire driver"
> +	depends on SERIAL_DEV_BUS
> +	help
> +	  Say Y here if you want to communicate with your 1-wire devices using
> +	  UART interface.
> +
> +	  This support is also available as a module.  If so, the module
> +	  will be called w1-uart.
> +
>  endmenu
>  
> diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
> index 6c5a21f9b88c..227f80987e69 100644
> --- a/drivers/w1/masters/Makefile
> +++ b/drivers/w1/masters/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_W1_MASTER_MXC)		+= mxc_w1.o
>  obj-$(CONFIG_W1_MASTER_GPIO)		+= w1-gpio.o
>  obj-$(CONFIG_HDQ_MASTER_OMAP)		+= omap_hdq.o
>  obj-$(CONFIG_W1_MASTER_SGI)		+= sgi_w1.o
> +obj-$(CONFIG_W1_MASTER_UART)		+= w1-uart.o
> diff --git a/drivers/w1/masters/w1-uart.c b/drivers/w1/masters/w1-uart.c
> new file mode 100644
> index 000000000000..e0da8ebfef58
> --- /dev/null
> +++ b/drivers/w1/masters/w1-uart.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * w1-uart - UART 1-Wire bus driver
> + *
> + * Uses the UART interface (via Serial Device Bus) to create the 1-Wire
> + * timing patterns. Implements the following 1-Wire master interface:
> + *
> + * - reset_bus: baud-rate 9600 (bit time 104.2 us) and tx-byte 0xf0
> + *
> + * - touch_bit: baud-rate 115200 (bit time 8.7 us) and tx-byte 0x00
> + *              (Write-0) or 0xff (Read-0, Read-1, Write-1)
> + *
> + * Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/completion.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/serdev.h>
> +#include <linux/w1.h>
> +
> +#define W1_UART_TIMEOUT msecs_to_jiffies(500)
> +
> +struct w1_uart_device {
> +	struct serdev_device *serdev;
> +	struct w1_bus_master bus;
> +
> +	struct completion buf_received;
> +	atomic_t buf;
> +
> +	unsigned int baudrate;
> +};
> +
> +/*
> + * Send one byte (tx_byte) and read one byte (rx_byte) via serdev.
> + */
> +static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
> +				unsigned int baudrate, unsigned char tx_byte,
> +				unsigned char *rx_byte)
> +{
> +	struct serdev_device *serdev = w1dev->serdev;
> +	struct device *dev = &serdev->dev;
> +	int ret;
> +
> +	serdev_device_write_flush(serdev);
> +	if (w1dev->baudrate != baudrate) {
> +		w1dev->baudrate = serdev_device_set_baudrate(serdev, baudrate);
> +		if (w1dev->baudrate != baudrate) {
> +			dev_err(dev, "set baudrate failed\n");
> +			return -1;

Use errno values when applicable (e.g. for internal parts).

> +		}
> +	}
> +
> +	reinit_completion(&w1dev->buf_received);
> +	ret = serdev_device_write_buf(serdev, &tx_byte, 1);
> +	if (ret != 1) {
> +		dev_err(dev, "write failed\n");

This is going to spam the logs. Check existing usages - nothing prints
errors on every write or read.

> +		return -1;
> +	}
> +	ret = wait_for_completion_interruptible_timeout(&w1dev->buf_received,
> +							W1_UART_TIMEOUT);
> +	if (ret <= 0) {
> +		dev_err(dev, "receive failed\n");

Also problem of possible flood.

> +		return -1;
> +	}
> +
> +	*rx_byte = (unsigned char)atomic_read(&w1dev->buf);
> +	return 0;
> +}
> +
> +static int w1_uart_serdev_receive_buf(struct serdev_device *serdev,
> +				      const unsigned char *buf, size_t count)
> +{
> +	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
> +
> +	if (count > 0) {
> +		atomic_set(&w1dev->buf, buf[count - 1]);

I fail to understand why you use atomic here. It does not solve any
locking problems - it's still there. Load and store tearing? But is it
ever possible for one byte stores and loads? Doesn't C standard
guarantee that byte writes are atomic?


I also do not understand why you store only last byte, ignoring all the
rest.

> +		complete(&w1dev->buf_received);
> +	}
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
> + * 1-wire reset and presence detect:
> + * The baud-rate 9600 (104.2 us per bit) and the byte 0xf0 generates a
> + * reset low time of 521 us (start-bit low). A present slave will
> + * manipulate the received byte by pulling the 1-wire low.
> + */
> +static u8 w1_uart_reset_bus(void *data)
> +{
> +	struct w1_uart_device *w1dev = data;
> +	unsigned char buf;

This is not buffer, just a value.

> +	int ret;
> +
> +	ret = w1_uart_serdev_tx_rx(w1dev, 9600, 0xf0, &buf);

Why the rate is fixed? What if all devices support different baud rates?

> +	if (ret < 0)
> +		return -1;
> +
> +	/* Device present (0) or no device (1) */
> +	return buf != 0xf0 ? 0 : 1;
> +}
> +
> +/*
> + * 1-Wire read and write cycle:
> + * The baud-rate 115200 (8.7 us per bit) and the byte 0xff generates the
> + * timing pattern for Read-0, Read-1 and Write-1 operation, with a low
> + * time of 8.7 us (start-bit low). Only the Read-0 manipulates the
> + * received byte, all others left the line untouched.
> + */
> +static u8 w1_uart_touch_bit(void *data, u8 bit)
> +{
> +	struct w1_uart_device *w1dev = data;
> +	unsigned char buf;

One character is not a buffer.

> +	int ret;
> +
> +	ret = w1_uart_serdev_tx_rx(w1dev, 115200, bit ? 0xff : 0x00, &buf);

Why the rate is fixed? What if all devices support different baud rates?

> +	/* return inactive bus state on error */
> +	if (ret < 0)
> +		return 1;
> +
> +	return buf == 0xff ? 1 : 0;
> +}
> +
> +static int w1_uart_probe(struct serdev_device *serdev)
> +{
> +	struct device *dev = &serdev->dev;
> +	struct w1_uart_device *w1dev;
> +	int ret;
> +
> +	w1dev = devm_kzalloc(dev, sizeof(struct w1_uart_device), GFP_KERNEL);

sizeof(*)

> +	if (!w1dev)
> +		return -ENOMEM;
> +	w1dev->bus.data = w1dev;
> +	w1dev->bus.reset_bus = w1_uart_reset_bus;
> +	w1dev->bus.touch_bit = w1_uart_touch_bit;
> +	w1dev->serdev = serdev;
> +
> +	serdev_device_set_drvdata(serdev, w1dev);
> +	serdev_device_set_client_ops(serdev, &w1_uart_serdev_ops);
> +
> +	init_completion(&w1dev->buf_received);
> +
> +	ret = devm_serdev_device_open(dev, serdev);
> +	if (ret < 0)
> +		return ret;
> +	serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	return w1_add_master_device(&w1dev->bus);
> +}
> +
> +static void w1_uart_remove(struct serdev_device *serdev)
> +{
> +	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
> +
> +	complete(&w1dev->buf_received);

This is odd - w1_uart_serdev_tx_rx() will read data on driver removal.
You should make sure that on removal any reads do not follow usual path.

> +	w1_remove_master_device(&w1dev->bus);
> +}
> +
> +#ifdef CONFIG_OF

Drop

> +static const struct of_device_id w1_uart_of_match[] = {
> +	{ .compatible = "w1-uart" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, w1_uart_of_match);
> +#endif
> +
> +static struct serdev_device_driver w1_uart_driver = {
> +	.driver	= {
> +		.name		= "w1-uart",
> +		.of_match_table	= of_match_ptr(w1_uart_of_match),

Drop of_match_ptr

> +	},
> +	.probe	= w1_uart_probe,
> +	.remove	= w1_uart_remove,
> +};

Best regards,
Krzysztof


