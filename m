Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4557D6839
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJYKVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJYKVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:21:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D7FDD;
        Wed, 25 Oct 2023 03:21:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692c02adeefso4429399b3a.3;
        Wed, 25 Oct 2023 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698229276; x=1698834076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDsqw0sXkcqQTP0sCa4Jkp7YyhsxVpWNPP+SpDa1yZw=;
        b=Ry08MFy++i10BUT9Gr1QsV2SwmVt967p13eu7P4Mb20068ecWUdDy9Em2FN79ZpMAd
         SWDQ2o4J274/xQAYY4EkGRnEyoNOtsSuYYnOI1jS2lYuwYiR06qGuPHR0g/1wusHQIAU
         YkjFbVc3BKb7u3GYDq5sK5iGVwqc8D/FhxflepBYRVzs/CwEKEA40Kb97He2hmAgoRPL
         kYWGUrG2m2kwq0Rw8cmAqSkuPmQ+EHNdDY1u1Jy9gjaBQUz2NnjMvLo0JTPLX0Zey5eR
         SN1JXUNBooqQQBVV4X4YUJaw/rYW4k0wB/nVCIzlznjFyx4aroDsM6iP7j0lCVcdoTuO
         +VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698229276; x=1698834076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDsqw0sXkcqQTP0sCa4Jkp7YyhsxVpWNPP+SpDa1yZw=;
        b=lwXxN0POF4bi7wE1XSlTMGn+1HmJPTSi6nCDNRrQB2xqOdQdEoReiltwM4i+MIO0fH
         pYRUtX6wtQ9InIYTRkyVT/v95hao4nqpn76b8PWHCNCfWuX2m+DzGRAnk0zPs2w8m53o
         IqDnqvsq78Y0sg5dwL6Yjo2dwiAAtOAxbHi+wSEk3Ms6PNC8Eg6IA51iuRG8jHP32ZlF
         jrcH0P1wC+k4FnWG5lLhoDICO0hYhdqPieZsVVKiT7eFyjLhZyAmVXm4w/2QYOwHkdy2
         963IW44U1cCR4M9R17377rRPtlrACKxDe+TKR88eK6phgBUVfe9ijyCMrgQEStieZfAZ
         Cb2w==
X-Gm-Message-State: AOJu0YwU4lUkrdo9rRosoVqAbfvqs6JenYQ8fQqMj9gRsXM8/5GYJ3ZN
        1VUq0agW0uhjBqBbX944F/k=
X-Google-Smtp-Source: AGHT+IH9yiMfJqlyqVWm1XKh6cflreVosWhbEfsZ/kiLIaq/2Tu34NO9j5LGH3M2R0l95i7g8f7Cow==
X-Received: by 2002:a05:6a21:1506:b0:17a:f2ed:e921 with SMTP id nq6-20020a056a21150600b0017af2ede921mr5397424pzb.55.1698229276129;
        Wed, 25 Oct 2023 03:21:16 -0700 (PDT)
Received: from [10.5.209.17] ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id y3-20020a1709029b8300b001b81a97860asm8834554plp.27.2023.10.25.03.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 03:21:15 -0700 (PDT)
Message-ID: <c4eed4e8-77e1-4129-ab6c-cc76ee4197db@gmail.com>
Date:   Wed, 25 Oct 2023 15:50:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20231017034356.1436677-1-anshulusr@gmail.com>
 <20231017034356.1436677-2-anshulusr@gmail.com> <ZTWza+S+t+UZKlwu@nixie71>
Content-Language: en-US
From:   Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <ZTWza+S+t+UZKlwu@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,
Thanks for the review, I plan on addressing the changes you requested in
the next version of the patch. Though I had a few questions:

On 10/23/23 05:12, Jeff LaBundy wrote:
> Hi Anshul,
> 
> On Tue, Oct 17, 2023 at 09:13:45AM +0530, Anshul Dalal wrote:
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
>>  drivers/input/joystick/adafruit-seesaw.c | 273 +++++++++++++++++++++++
>>  4 files changed, 290 insertions(+)
>>  create mode 100644 drivers/input/joystick/adafruit-seesaw.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6c4cce45a09d..a314f9b48e21 100644
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
>> index 000000000000..2a1eae8d2861
>> --- /dev/null
>> +++ b/drivers/input/joystick/adafruit-seesaw.c
>> @@ -0,0 +1,273 @@
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
>> +/* clang-format off */
> 
> I don't think we need this directive; at least, no other input drivers have
> it, or really any drivers for that matter.
> 
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
>> +#define BUTTON_A	5
>> +#define BUTTON_B	1
>> +#define BUTTON_X	6
>> +#define BUTTON_Y	2
>> +#define BUTTON_START	16
>> +#define BUTTON_SELECT	0
> 
> Please namespace these (e.g. SEESAW_BUTTON_A) to make it clear they refer
> to device-specific bits and not standard keycodes (e.g. BTN_A). In fact,
> these seem better off as part of an array of structs; more on that below.
> 
>> +
>> +#define ANALOG_X	14
>> +#define ANALOG_Y	15
> 
> Please namespace these as well.
> 
>> +
>> +#define SEESAW_JOYSTICK_MAX_AXIS	1023
>> +#define SEESAW_JOYSTICK_FUZZ		2
>> +#define SEESAW_JOYSTICK_FLAT		4
>> +
>> +#define SEESAW_GAMEPAD_POLL_INTERVAL	16
>> +#define SEESAW_GAMEPAD_POLL_MIN		8
>> +#define SEESAW_GAMEPAD_POLL_MAX		32
>> +/* clang-format on */
>> +
>> +u32 BUTTON_MASK = BIT(BUTTON_A) | BIT(BUTTON_B) | BIT(BUTTON_X) |
>> +		  BIT(BUTTON_Y) | BIT(BUTTON_START) | BIT(BUTTON_SELECT);
>> +
>> +struct seesaw_gamepad {
>> +	char physical_path[32];
>> +	struct input_dev *input_dev;
>> +	struct i2c_client *i2c_client;
>> +};
>> +
>> +struct seesaw_data {
>> +	__be16 x;
>> +	__be16 y;
>> +	u8 button_a, button_b, button_x, button_y, button_start, button_select;
> 
> Please keep these each on a separate line.
> 
>> +};
> 
> Please declare this struct as __packed, as that is how it appears to be used.
> 
>> +
>> +static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
>> +{
>> +	int err;
> 
> Please use 'ret' for return variables that can indicate a positive value on success.
> 
>> +	unsigned char write_buf[2] = { SEESAW_GPIO_BASE, SEESAW_GPIO_BULK };
>> +	unsigned char read_buf[4];
> 
> Please use standard kernel type definitions (i.e. u8 in this case).
> 
>> +
>> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
>> +	if (err < 0)
>> +		return err;
> 
> You correctly return err (or rather, ret) for negative values, but you should also
> check that ret matches the size of the data sent. For 0 <= ret < sizeof(writebuf),
> return -EIO.
> 
>> +	err = i2c_master_recv(client, read_buf, sizeof(read_buf));
>> +	if (err < 0)
>> +		return err;
> 
> And here.
> 
>> +
>> +	u32 result = get_unaligned_be32(&read_buf);
> 
> Please do not mix declarations and code; all declarations must be at the
> top of the function.
> 
>> +
>> +	data->button_a = !test_bit(BUTTON_A, (long *)&result);
>> +	data->button_b = !test_bit(BUTTON_B, (long *)&result);
>> +	data->button_x = !test_bit(BUTTON_X, (long *)&result);
>> +	data->button_y = !test_bit(BUTTON_Y, (long *)&result);
>> +	data->button_start = !test_bit(BUTTON_START, (long *)&result);
>> +	data->button_select = !test_bit(BUTTON_SELECT, (long *)&result);
>> +
>> +	write_buf[0] = SEESAW_ADC_BASE;
>> +	write_buf[1] = SEESAW_ADC_OFFSET + ANALOG_X;
>> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
>> +	if (err < 0)
>> +		return err;
>> +	err = i2c_master_recv(client, (char *)&data->x, sizeof(data->x));
>> +	if (err < 0)
>> +		return err;
> 
> This is starting to look like a 16-bit register map. To that end, please
> consider using regmap instead of open-coding each of these standard write-
> then-read operations.
> 
> Using regmap would also save you the trouble of managing the endianness
> yourself, as well as having to check for incomplete transfers since its
> functions return zero or a negative error code only.
> 
In this driver there are only two places a 16-bit regmap could be used,
for getting the joystick X and Y values. I see minimal utility in adding
the boilerplate necessary to use the more sophisticated regmap API in
this case.

As for the handling of endianness, if I am not mistaken the
`be16_to_cpu` macro should manage it.

If you prefer I could add the following function to reduce code duplication:

int seesaw_get_analog(int pin) {
	__be16 result;
	u8 write_buf[2] = { SEESAW_ADC_BASE, SEESAW_ADC_OFFSET + pin };
	int ret;
	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
	if (ret < 0)
		return ret;
	ret = i2c_master_recv(client, (char *)&result, sizeof(result));
	if (ret < 0)
		return ret;
	return result;
}

>> +	/*
>> +	 * ADC reads left as max and right as 0, must be reversed since kernel
>> +	 * expects reports in opposite order.
>> +	 */
>> +	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(data->x);
>> +
>> +	write_buf[1] = SEESAW_ADC_OFFSET + ANALOG_Y;
>> +	err = i2c_master_send(client, write_buf, sizeof(write_buf));
>> +	if (err < 0)
>> +		return err;
>> +	err = i2c_master_recv(client, (char *)&data->y, sizeof(data->y));
>> +	if (err < 0)
>> +		return err;
>> +	data->y = be16_to_cpu(data->y);
>> +
>> +	return 0;
>> +}
>> +
>> +static void seesaw_poll(struct input_dev *input)
>> +{
>> +	struct seesaw_gamepad *private = input_get_drvdata(input);
>> +	struct seesaw_data data;
>> +	int err;
>> +
>> +	err = seesaw_read_data(private->i2c_client, &data);
>> +	if (err != 0) {
>> +		dev_dbg(&input->dev, "failed to read joystick state: %d\n",
>> +			err);
> 
> This should be dev_err_ratelimited().
> 
>> +		return;
>> +	}
>> +
>> +	input_report_abs(input, ABS_X, data.x);
>> +	input_report_abs(input, ABS_Y, data.y);
>> +	input_report_key(input, BTN_EAST, data.button_a);
>> +	input_report_key(input, BTN_SOUTH, data.button_b);
>> +	input_report_key(input, BTN_NORTH, data.button_x);
>> +	input_report_key(input, BTN_WEST, data.button_y);
>> +	input_report_key(input, BTN_START, data.button_start);
>> +	input_report_key(input, BTN_SELECT, data.button_select);
> 
> I think you can make this much cleaner and smaller by defining an array
> of structs, each with a key code and bit position. You can then simply
> iterate over the array and call input_report_key() once per element as
> in the following:
> 
> struct seesaw_btn_desc {
> 	unsigned int code;
> 	unsigned int shift;
> };
> 
> static const struct seesaw_btn_desc seesaw_btns[] = {
> 	{
> 		.code = BTN_EAST,
> 		.mask = 5,
> 	},
> 	[...]
> };
> 
> And then:
> 
> 	btn_status = ...;
> 
> 	for (i = 0; i < ARRAY_SIZE(seesaw_btns); i++)
> 		input_report_key(input, seesaw_btns[i].code,
> 				 btn_status & seesaw_btns[i].mask);
> 
> This would also make it easier to quickly discern what keycodes are mapped
> to which bits in the register.
> 
>> +	input_sync(input);
>> +}
>> +
>> +static int seesaw_probe(struct i2c_client *client)
>> +{
>> +	int err;
>> +	struct seesaw_gamepad *private;
> 
> I'd rather this be called something like 'seesaw' rather than private.
> 
>> +	unsigned char register_reset[] = { SEESAW_STATUS_BASE,
>> +					   SEESAW_STATUS_SWRST, 0xFF };
>> +	unsigned char get_hw_id[] = { SEESAW_STATUS_BASE, SEESAW_STATUS_HW_ID };
>> +
>> +	err = i2c_master_send(client, register_reset, sizeof(register_reset));
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* Wait for the registers to reset before proceeding */
>> +	mdelay(10);
>> +
>> +	private = devm_kzalloc(&client->dev, sizeof(*private), GFP_KERNEL);
>> +	if (!private)
>> +		return -ENOMEM;
>> +
>> +	err = i2c_master_send(client, get_hw_id, sizeof(get_hw_id));
>> +	if (err < 0)
>> +		return err;
>> +
>> +	unsigned char hardware_id;
> 
> Same comment as earlier with regard to mixed declarations.
> 
>> +
>> +	err = i2c_master_recv(client, &hardware_id, 1);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware ID: %02x\n",
>> +		hardware_id);
>> +
>> +	private->i2c_client = client;
>> +	scnprintf(private->physical_path, sizeof(private->physical_path),
>> +		  "i2c/%s", dev_name(&client->dev));
> 
> This seems overly complex; can we not simply set input_dev->phys to the
> literal "i2c/seesaw-gamepad"? Why to copy at runtime and incur the cost
> of carrying 'physical_path' throughout the life of the module?
> 
>> +	i2c_set_clientdata(client, private);
>> +
>> +	private->input_dev = devm_input_allocate_device(&client->dev);
>> +	if (!private->input_dev)
>> +		return -ENOMEM;
>> +
>> +	private->input_dev->id.bustype = BUS_I2C;
>> +	private->input_dev->name = "Adafruit Seesaw Gamepad";
>> +	private->input_dev->phys = private->physical_path;
>> +	input_set_drvdata(private->input_dev, private);
>> +	input_set_abs_params(private->input_dev, ABS_X, 0,
>> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
>> +			     SEESAW_JOYSTICK_FLAT);
>> +	input_set_abs_params(private->input_dev, ABS_Y, 0,
>> +			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
>> +			     SEESAW_JOYSTICK_FLAT);
>> +	input_set_capability(private->input_dev, EV_KEY, BTN_EAST);
>> +	input_set_capability(private->input_dev, EV_KEY, BTN_SOUTH);
>> +	input_set_capability(private->input_dev, EV_KEY, BTN_NORTH);
>> +	input_set_capability(private->input_dev, EV_KEY, BTN_WEST);
>> +	input_set_capability(private->input_dev, EV_KEY, BTN_START);
>> +	input_set_capability(private->input_dev, EV_KEY, BTN_SELECT);
> 
> Same comment with regard to creating an array of structs, and hence only
> having to call input_set_capability() from within a small loop.
> 
>> +
>> +	err = input_setup_polling(private->input_dev, seesaw_poll);
>> +	if (err) {
>> +		dev_err(&client->dev, "failed to set up polling: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	input_set_poll_interval(private->input_dev,
>> +				SEESAW_GAMEPAD_POLL_INTERVAL);
>> +	input_set_max_poll_interval(private->input_dev,
>> +				    SEESAW_GAMEPAD_POLL_MAX);
>> +	input_set_min_poll_interval(private->input_dev,
>> +				    SEESAW_GAMEPAD_POLL_MIN);
>> +
>> +	err = input_register_device(private->input_dev);
>> +	if (err) {
>> +		dev_err(&client->dev, "failed to register joystick: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	/* Set Pin Mode to input and enable pull-up resistors */
>> +	unsigned char pin_mode[] = { SEESAW_GPIO_BASE,	SEESAW_GPIO_DIRCLR_BULK,
>> +				     BUTTON_MASK >> 24, BUTTON_MASK >> 16,
>> +				     BUTTON_MASK >> 8,	BUTTON_MASK };
>> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
>> +	if (err < 0)
>> +		return err;
>> +	pin_mode[1] = SEESAW_GPIO_PULLENSET;
>> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
>> +	if (err < 0)
>> +		return err;
>> +	pin_mode[1] = SEESAW_GPIO_BULK_SET;
>> +	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
>> +	if (err < 0)
>> +		return err;
> 
> Please configure the HW before the input device is live and being polled.
> 

Could you elaborate on what you meant by this. To my knowledge, the
device is ready to be polled right after the pin state for the
`BUTTON_MASK` is configured. That is also how it's done in the Arduino
driver provided by the manufacturer. Please clarify if I'm missing
something here.

>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id of_seesaw_match[] = {
>> +	{
>> +		.compatible = "adafruit,seesaw-gamepad",
>> +	},
>> +	{ /* Sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, of_seesaw_match);
>> +#endif /* CONFIG_OF */
> 
> Please correct me if I am wrong, but it does not seem that OF support is
> required by this driver. There are no properties beyond the standard ones
> understood by the I2C core, which can match based on the ID table below.
> 
>> +
>> +/* clang-format off */
>> +static const struct i2c_device_id seesaw_id_table[] = {
>> +	{ SEESAW_DEVICE_NAME, 0 },
>> +	{ /* Sentinel */ }
>> +};
>> +/* clang-format on */
> 
> Again, I don't see any need for these directives.
> 
>> +
> 
> Nit: unnecessary NL.
> 
>> +MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
>> +
>> +static struct i2c_driver seesaw_driver = {
>> +	.driver = {
>> +		.name = SEESAW_DEVICE_NAME,
>> +		.of_match_table = of_match_ptr(of_seesaw_match),
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
> Kind regards,
> Jeff LaBundy

Regards,
Anshul Dalal
