Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378F17DC427
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjJaCGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJaCGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:06:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D39B3;
        Mon, 30 Oct 2023 19:06:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc3388621cso17738875ad.1;
        Mon, 30 Oct 2023 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698717986; x=1699322786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHz556Zm7uDIyDqflcThIYkwentvkL/bD3ujxb0WOLg=;
        b=QWzfyOW06OLQrhG4QIMiS9JWt4Lx81LpxKvOEtE5wNS1LEZrwMElT2KlU3JDPRnkdH
         YCbJM5iHI/Fs/KyS51WX/PGaQ3IYnwfwBECGXcTjzNeJPSvVVq4n1zA4b5XhqEPZUAw9
         DiJ7eLNKqssXndSEvJbTPgs7+S6iJGDhLC8ztj/Dm3ifAGjOLeG7f3m2t8ciP6djLhi8
         fJxzvfVjnEh8/6+0CIrqFZ07wAm473mOkpkYjC2A0Qo/S7EXDzBrq6WTqrDNl+MsFPZt
         8QhpIGmDpgqesOANwQU9YYX3P1akAFZUqOfuQUEHQLl9CLlnQqW3jMC2bd/2VkrqFxVo
         xpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698717986; x=1699322786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHz556Zm7uDIyDqflcThIYkwentvkL/bD3ujxb0WOLg=;
        b=IIgPKx8elT61IxDEHp3+wqwbVUiXd8CnSVrT5qvdNjGC0CpM+u639pi2yLdflVgvCD
         AbD8ArS0Wj8w/c3rjQSKWp7/VYGARRPJb0NvHuoALGI8mAFtUdGCHU3bLb7ddtO3ODMY
         vGxYJ0FsYycWzrD0ZmkKgMysxnKT8ZKyQxTPbJuu7pGf3gAb1HvQf10GJvN/tHFLzMN+
         LZIAaRxGP1jvCDhkN/Jjvaa5n4YHqP9AFt0xcEG9AN18CAB9JYz/OW1irhJLvcWmOsrq
         0jcup6G6ifRGwEk5Zk8wiQ+VjUB31aSKcKffneVy8++ktdZgNFJofVCalSgxu9zdrfO3
         YKGg==
X-Gm-Message-State: AOJu0Yxpzuz+ciBHkRZ2nJF+f63Mkq7u4ykPSXaBOM2JBNHOeywHJJxY
        Lnp98xEvbY+WF94r4H2R3l8=
X-Google-Smtp-Source: AGHT+IFUKTjZ/w1q2ApjWu1YlVUYjFDy/lPnscUvLqvgIiMiXw7iGkWIFBQFCl+aKYD4Z+QLnkeXSQ==
X-Received: by 2002:a17:903:1c6:b0:1cc:4488:afba with SMTP id e6-20020a17090301c600b001cc4488afbamr1752225plh.6.1698717985873;
        Mon, 30 Oct 2023 19:06:25 -0700 (PDT)
Received: from ?IPV6:2401:4900:628c:8ee8:d1a1:4bda:564e:d992? ([2401:4900:628c:8ee8:d1a1:4bda:564e:d992])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090282ca00b001c74876f032sm156575plz.162.2023.10.30.19.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 19:06:25 -0700 (PDT)
Message-ID: <778c68af-b86b-401f-8fc5-0a43abab4dad@gmail.com>
Date:   Tue, 31 Oct 2023 07:35:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jeff LaBundy <jeff@labundy.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20231027051819.81333-1-anshulusr@gmail.com>
 <20231027051819.81333-2-anshulusr@gmail.com> <ZT9TqX0tfEKpHPV9@google.com>
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <ZT9TqX0tfEKpHPV9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

Thanks for the review, the requested changes will be added in the next
patch version. I have added a few comments below:

On 10/30/23 12:26, Dmitry Torokhov wrote:
> Hi Anshul,
> 
> On Fri, Oct 27, 2023 at 10:48:11AM +0530, Anshul Dalal wrote:
>> Adds a driver for a mini gamepad that communicates over i2c, the gamepad
>> has bidirectional thumb stick input and six buttons.
>>
>> The gamepad chip utilizes the open framework from Adafruit called 'Seesaw'
>> to transmit the ADC data for the joystick and digital pin state for the
>> buttons. I have only implemented the functionality required to receive the
>> thumb stick and button state.
>>
>> Steps in reading the gamepad state over i2c:
>>   1. Reset the registers
>>   2. Set the pin mode of the pins specified by the `BUTTON_MASK` to input
>>       `BUTTON_MASK`: A bit-map for the six digital pins internally
>>        connected to the joystick buttons.
>>   3. Enable internal pullup resistors for the `BUTTON_MASK`
>>   4. Bulk set the pin state HIGH for `BUTTON_MASK`
>>   5. Poll the device for button and joystick state done by:
>>       `seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)`
>>
>> Product page:
>>   https://www.adafruit.com/product/5743
>> Arduino driver:
>>   https://github.com/adafruit/Adafruit_Seesaw
>>
>> Driver tested on RPi Zero 2W
>>
>> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
>> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
>> ---
>> Changes for v6:
>> - Added TODO
>> - Removed `clang-format` directives
>> - Namespaced device buttons
>> - Removed `char physical_path[32]` field from `struct seesaw_gamepad`
>> - Added `packed` attribute to `struct seesaw_data`
>> - Moved from having booleans per button to single `u32 button_state`
>> - Added `seesaw_button_description` array to directly associate device
>>   buttons with respective keycodes
>> - Added wrapper functions `seesaw_register_` around `i2c_master_` API
>> - Ratelimited input error reporting with `dev_err_ratelimited`
>> - Removed `of_device_id`
>>
>> Changes for v5:
>> - Added link to the datasheet
>> - Added debug log message when `seesaw_read_data` fails
>>
>> Changes for v4:
>> - Changed `1UL << BUTTON_` to BIT(BUTTON_)
>> - Removed `hardware_id` field from `struct seesaw_gamepad`
>> - Removed redundant checks for the number of bytes written and received by
>>   `i2c_master_send` and `i2c_master_recv`
>> - Used `get_unaligned_be32` to instantiate `u32 result` from `read_buf`
>> - Changed  `result & (1UL << BUTTON_)` to
>>   `test_bit(BUTTON_, (long *)&result)`
>> - Changed `KBUILD_MODNAME` in id-tables to `SEESAW_DEVICE_NAME`
>> - Fixed formatting issues
>> - Changed button reporting:
>>     Since the gamepad had the action buttons in a non-standard layout:
>>          (X)
>>       (Y)   (A)
>>          (B)
>>     Therefore moved to using generic directional action button event codes
>>     instead of BTN_[ABXY].
>>
>> Changes for v3:
>> - no updates
>>
>> Changes for v2:
>> adafruit-seesaw.c:
>> - Renamed file from 'adafruit_seesaw.c'
>> - Changed device name from 'seesaw_gamepad' to 'seesaw-gamepad'
>> - Changed count parameter for receiving joystick x on line 118:
>>     `2` to `sizeof(write_buf)`
>> - Fixed invalid buffer size on line 123 and 126:
>>     `data->y` to `sizeof(data->y)`
>> - Added comment for the `mdelay(10)` on line 169
>> - Changed inconsistent indentation on line 271
>> Kconfig:
>> - Fixed indentation for the help text
>> - Updated module name
>> Makefile:
>> - Updated module object file name
>> MAINTAINERS:
>> - Updated file name for the driver and bindings
>>
>>  MAINTAINERS                              |   7 +
>>  drivers/input/joystick/Kconfig           |   9 +
>>  drivers/input/joystick/Makefile          |   1 +
>>  drivers/input/joystick/adafruit-seesaw.c | 310 +++++++++++++++++++++++
>>  4 files changed, 327 insertions(+)
>>  create mode 100644 drivers/input/joystick/adafruit-seesaw.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4cc6bf79fdd8..0595c832c248 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -441,6 +441,13 @@ W:	http://wiki.analog.com/AD7879
>>  W:	https://ez.analog.com/linux-software-drivers
>>  F:	drivers/input/touchscreen/ad7879.c
>>  
>> +ADAFRUIT MINI I2C GAMEPAD
>> +M:	Anshul Dalal <anshulusr@gmail.com>
>> +L:	linux-input@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
>> +F:	drivers/input/joystick/adafruit-seesaw.c
>> +
>>  ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
>>  M:	Jiri Kosina <jikos@kernel.org>
>>  S:	Maintained
>> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
>> index ac6925ce8366..df9cd1830b29 100644
>> --- a/drivers/input/joystick/Kconfig
>> +++ b/drivers/input/joystick/Kconfig
>> @@ -412,4 +412,13 @@ config JOYSTICK_SENSEHAT
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called sensehat_joystick.
>>  
>> +config JOYSTICK_SEESAW
>> +	tristate "Adafruit Mini I2C Gamepad with Seesaw"
>> +	depends on I2C
>> +	help
>> +	  Say Y here if you want to use the Adafruit Mini I2C Gamepad.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called adafruit-seesaw.
>> +
>>  endif
>> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
>> index 3937535f0098..9976f596a920 100644
>> --- a/drivers/input/joystick/Makefile
>> +++ b/drivers/input/joystick/Makefile
>> @@ -28,6 +28,7 @@ obj-$(CONFIG_JOYSTICK_N64)		+= n64joy.o
>>  obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
>>  obj-$(CONFIG_JOYSTICK_PXRC)		+= pxrc.o
>>  obj-$(CONFIG_JOYSTICK_QWIIC)		+= qwiic-joystick.o
>> +obj-$(CONFIG_JOYSTICK_SEESAW)		+= adafruit-seesaw.o
>>  obj-$(CONFIG_JOYSTICK_SENSEHAT)	+= sensehat-joystick.o
>>  obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
>>  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
>> diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
>> new file mode 100644
>> index 000000000000..1aa6fbe4fda4
>> --- /dev/null
>> +++ b/drivers/input/joystick/adafruit-seesaw.c
>> @@ -0,0 +1,310 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
>> + *
>> + * Driver for Adafruit Mini I2C Gamepad
>> + *
>> + * Based on the work of:
>> + *	Oleh Kravchenko (Sparkfun Qwiic Joystick driver)
>> + *
>> + * Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
>> + * Product page: https://www.adafruit.com/product/5743
>> + * Firmware and hardware sources: https://github.com/adafruit/Adafruit_Seesaw
>> + *
>> + * TODO:
>> + *	- Add interrupt support
>> + */
>> +
>> +#include <asm-generic/unaligned.h>
>> +#include <linux/bits.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +#define SEESAW_DEVICE_NAME	"seesaw-gamepad"
>> +
>> +#define SEESAW_STATUS_BASE	0
>> +#define SEESAW_GPIO_BASE	1
>> +#define SEESAW_ADC_BASE		9
>> +
>> +#define SEESAW_GPIO_DIRCLR_BULK	3
>> +#define SEESAW_GPIO_BULK	4
>> +#define SEESAW_GPIO_BULK_SET	5
>> +#define SEESAW_GPIO_PULLENSET	11
>> +
>> +#define SEESAW_STATUS_HW_ID	1
>> +#define SEESAW_STATUS_SWRST	127
>> +
>> +#define SEESAW_ADC_OFFSET	7
>> +
>> +#define SEESAW_BUTTON_A		5
>> +#define SEESAW_BUTTON_B		1
>> +#define SEESAW_BUTTON_X		6
>> +#define SEESAW_BUTTON_Y		2
>> +#define SEESAW_BUTTON_START	16
>> +#define SEESAW_BUTTON_SELECT	0
>> +
>> +#define SEESAW_ANALOG_X		14
>> +#define SEESAW_ANALOG_Y		15
>> +
>> +#define SEESAW_JOYSTICK_MAX_AXIS	1023
>> +#define SEESAW_JOYSTICK_FUZZ		2
>> +#define SEESAW_JOYSTICK_FLAT		4
>> +
>> +#define SEESAW_GAMEPAD_POLL_INTERVAL	16
>> +#define SEESAW_GAMEPAD_POLL_MIN		8
>> +#define SEESAW_GAMEPAD_POLL_MAX		32
>> +
>> +u32 SEESAW_BUTTON_MASK = BIT(SEESAW_BUTTON_A) | BIT(SEESAW_BUTTON_B) |
>> +			 BIT(SEESAW_BUTTON_X) | BIT(SEESAW_BUTTON_Y) |
>> +			 BIT(SEESAW_BUTTON_START) | BIT(SEESAW_BUTTON_SELECT);
>> +
>> +struct seesaw_gamepad {
>> +	struct input_dev *input_dev;
>> +	struct i2c_client *i2c_client;
>> +};
>> +
>> +struct seesaw_data {
>> +	__be16 x;
>> +	__be16 y;
>> +	u32 button_state;
>> +} __packed;
>> +
>> +struct seesaw_button_description {
>> +	unsigned int code;
>> +	unsigned int bit;
>> +};
>> +
>> +static const struct seesaw_button_description seesaw_buttons[] = {
>> +	{
>> +		.code = BTN_EAST,
>> +		.bit = SEESAW_BUTTON_A,
>> +	},
>> +	{
>> +		.code = BTN_SOUTH,
>> +		.bit = SEESAW_BUTTON_B,
>> +	},
>> +	{
>> +		.code = BTN_NORTH,
>> +		.bit = SEESAW_BUTTON_X,
>> +	},
>> +	{
>> +		.code = BTN_WEST,
>> +		.bit = SEESAW_BUTTON_Y,
>> +	},
>> +	{
>> +		.code = BTN_START,
>> +		.bit = SEESAW_BUTTON_START,
>> +	},
>> +	{
>> +		.code = BTN_SELECT,
>> +		.bit = SEESAW_BUTTON_SELECT,
>> +	},
>> +};
>> +
>> +static int seesaw_register_read(struct i2c_client *client, u8 register_high,
>> +				u8 register_low, char *buf, int count)
> 
> I am curious why we have 2 u8s instead of u16 that we send as __be16?
> 

That's done to be consistent with the manufacturer's implementation of
the seesaw framework from the Arduino driver:

  bool read(uint8_t regHigh, uint8_t regLow, uint8_t *buf, uint8_t num,
            uint16_t delay = 250);

The spec uses register_high as a namespace for the actual register you
want to work with: register_low.

For example when reading for the hardware id of the device, we have
`SEESAW_STATUS_BASE` [0x00] as the register_high and
`SEESAW_STATUS_HW_ID` [0x01] as the register_low which could also be
`SEESAW_STATUS_VERSION` [0x02] if instead wanted to get the framework
version the device is running.

Changing the register_high to say `SEESAW_TIMER_BASE` [0x08] and
register_low to `SEESAW_TIMER_FREQ` [0x02] would now have the chip
output the timer frequency.

>> +{
>> +	int ret;
>> +	u8 register_buf[2] = { register_high, register_low };
>> +
>> +	ret = i2c_master_send(client, register_buf, sizeof(register_buf));
>> +	if (ret < 0)
>> +		return ret;
>> +	ret = i2c_master_recv(client, buf, count);
> 
> I am curious can this be an i2c_transfer() with read/write messages
> instead (so 1 transaction)?
> 

Yes! here's what that could look like:

struct i2c_msg message_buf[2] = {
	{
		.addr = client->addr,
		.flags = client->flags,
		.len = sizeof(register_buf),
		.buf = register_buf
	},
	{
		.addr = client->addr,
		.flags = client->flags | I2C_M_RD,
		.len = count,
		.buf = buf
	}
};
ret = i2c_transfer(client->adapter, message_buf, ARRAY_SIZE(message_buf));
if (ret < 0)
	return ret;

I prefer this to the prior, let me know if I should go ahead with adding
this change.

>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int seesaw_register_write_u8(struct i2c_client *client, u8 register_high,
>> +				    u8 register_low, u8 value)
>> +{
>> +	int ret;
>> +	u8 write_buf[3] = { register_high, register_low, value };
>> +
>> +	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int seesaw_register_write_u32(struct i2c_client *client,
>> +				     u8 register_high, u8 register_low,
>> +				     u32 value)
>> +{
>> +	int ret;
>> +	u8 write_buf[6] = { register_high, register_low };
>> +
>> +	put_unaligned_be32(value, write_buf + 2);
>> +	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
>> +{
>> +	int ret;
>> +	u8 read_buf[4];
> 
> Why is this u8 buffer and not __be32?
> 
>> +
>> +	ret = seesaw_register_read(client, SEESAW_GPIO_BASE, SEESAW_GPIO_BULK,
>> +				   read_buf, sizeof(read_buf));
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->button_state = ~get_unaligned_be32(&read_buf);
> 
> If you use __be32 you would not need to use get_unaligned_be32.
> 

In my testing on a Raspberry Pi Zero 2 W (arm64), that
get_unaligned_be32 still seems to be required even with read_buf as __be32.

> 
>> +
>> +	ret = seesaw_register_read(client, SEESAW_ADC_BASE,
>> +				   SEESAW_ADC_OFFSET + SEESAW_ANALOG_X,
>> +				   (char *)&data->x, sizeof(data->x));
>> +	if (ret)
>> +		return ret;
>> +	/*
>> +	 * ADC reads left as max and right as 0, must be reversed since kernel
>> +	 * expects reports in opposite order.
>> +	 */
>> +	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(data->x);
>> +
>> +	ret = seesaw_register_read(client, SEESAW_ADC_BASE,
>> +				   SEESAW_ADC_OFFSET + SEESAW_ANALOG_Y,
>> +				   (char *)&data->y, sizeof(data->y));
>> +	if (ret)
>> +		return ret;
>> +	data->y = be16_to_cpu(data->y);
> 
> This is endianness violation and sparse should have warned you about
> this. A variable can either carry BE data, LE data, or CPU-endianness
> data, but not both.

Would reading the data into an __be16 and then using be16_to_cpu() to
assign it to data->y and data->x be an acceptable solution?

> I'd recommend combining seesaw_read_data() with
> seesaw_poll() into something like seesaw_report_events() and using
> temporaries for x and y and button data, and do not store them in the
> private structure at all. 
> 

The `struct seesaw_data` here is already temporary in seesaw_poll()
which then gets populated by seesaw_read_data(). I think the separation
of both functions is a better approach since it provides a convenient
error handler in case anything with the hardware goes wrong as:

err = seesaw_read_data(private->i2c_client, &data);
if (err) {
	dev_err_ratelimited(&input->dev,
			    "failed to read joystick state: %d\n", err);
	return;
}


>> +
>> +	return 0;
>> +}
>> +
>> +static void seesaw_poll(struct input_dev *input)
>> +{
>> +	int err, i;
>> +	struct seesaw_gamepad *private = input_get_drvdata(input);
>> +	struct seesaw_data data;
>> +
>> +	err = seesaw_read_data(private->i2c_client, &data);
>> +	if (err != 0) {
>> +		dev_err_ratelimited(&input->dev,
>> +				    "failed to read joystick state: %d\n", err);
>> +		return;
>> +	}
>> +
>> +	input_report_abs(input, ABS_X, data.x);
>> +	input_report_abs(input, ABS_Y, data.y);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(seesaw_buttons); i++) {
>> +		input_report_key(input, seesaw_buttons[i].code,
>> +				 data.button_state &
>> +					 BIT(seesaw_buttons[i].bit));
>> +	}
>> +	input_sync(input);
>> +}
>> +
>> +static int seesaw_probe(struct i2c_client *client)
>> +{
>> +	int err, i;
>> +	u8 hardware_id;
>> +	struct seesaw_gamepad *seesaw;
>> +
>> +	err = seesaw_register_write_u8(client, SEESAW_STATUS_BASE,
>> +				       SEESAW_STATUS_SWRST, 0xFF);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Wait for the registers to reset before proceeding */
>> +	mdelay(10);
> 
> Can this be usleep_range() instead? No need to block CPU.
> 
>> +
>> +	seesaw = devm_kzalloc(&client->dev, sizeof(*seesaw), GFP_KERNEL);
>> +	if (!seesaw)
>> +		return -ENOMEM;
>> +
>> +	err = seesaw_register_read(client, SEESAW_STATUS_BASE,
>> +				   SEESAW_STATUS_HW_ID, &hardware_id, 1);
> 
> sizeof(hardware_id)
> 
>> +	if (err)
>> +		return err;
>> +
>> +	dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware ID: %02x\n",
>> +		hardware_id);
>> +
>> +	/* Set Pin Mode to input and enable pull-up resistors */
>> +	err = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
>> +					SEESAW_GPIO_DIRCLR_BULK,
>> +					SEESAW_BUTTON_MASK);
>> +	if (err)
>> +		return err;
>> +	err = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
>> +					SEESAW_GPIO_PULLENSET,
>> +					SEESAW_BUTTON_MASK);
>> +	if (err)
>> +		return err;
>> +	err = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
>> +					SEESAW_GPIO_BULK_SET,
>> +					SEESAW_BUTTON_MASK);
>> +	if (err)
>> +		return err;
>> +
>> +	seesaw->i2c_client = client;
>> +	i2c_set_clientdata(client, seesaw);
>> +
>> +	seesaw->input_dev = devm_input_allocate_device(&client->dev);
>> +	if (!seesaw->input_dev)
>> +		return -ENOMEM;
>> +
>> +	seesaw->input_dev->id.bustype = BUS_I2C;
>> +	seesaw->input_dev->name = "Adafruit Seesaw Gamepad";
>> +	seesaw->input_dev->phys = "i2c/" SEESAW_DEVICE_NAME;
>> +	input_set_drvdata(seesaw->input_dev, seesaw);
>> +	input_set_abs_params(seesaw->input_dev, ABS_X, 0,
>> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
>> +			     SEESAW_JOYSTICK_FLAT);
>> +	input_set_abs_params(seesaw->input_dev, ABS_Y, 0,
>> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
>> +			     SEESAW_JOYSTICK_FLAT);
>> +	for (i = 0; i < ARRAY_SIZE(seesaw_buttons); i++) {
>> +		input_set_capability(seesaw->input_dev, EV_KEY,
>> +				     seesaw_buttons[i].code);
>> +	}
>> +
>> +	err = input_setup_polling(seesaw->input_dev, seesaw_poll);
>> +	if (err) {
>> +		dev_err(&client->dev, "failed to set up polling: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	input_set_poll_interval(seesaw->input_dev,
>> +				SEESAW_GAMEPAD_POLL_INTERVAL);
>> +	input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MAX);
>> +	input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MIN);
>> +
>> +	err = input_register_device(seesaw->input_dev);
>> +	if (err) {
>> +		dev_err(&client->dev, "failed to register joystick: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id seesaw_id_table[] = {
>> +	{ SEESAW_DEVICE_NAME, 0 },
>> +	{ /* Sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
>> +
>> +static struct i2c_driver seesaw_driver = {
>> +	.driver = {
>> +		.name = SEESAW_DEVICE_NAME,
>> +	},
>> +	.id_table = seesaw_id_table,
>> +	.probe = seesaw_probe,
>> +};
>> +module_i2c_driver(seesaw_driver);
>> +
>> +MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
>> +MODULE_DESCRIPTION("Adafruit Mini I2C Gamepad driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.42.0
>>
> 
> Thanks.
> 
