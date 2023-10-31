Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016337DC42D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjJaCK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJaCKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:10:53 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789FE6;
        Mon, 30 Oct 2023 19:10:48 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2e44c7941so3564917b6e.2;
        Mon, 30 Oct 2023 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698718248; x=1699323048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HvaTCZaVfa8YOs/0i4vt5upvE/+93PV8qucCPmWYZzM=;
        b=lE5yUIqqi/s8FtoPKJDhqmhlVNAW1lEMClL5kVwhJnRqdbcLiDxBu762PlZlPS0asj
         Ls+sFzRDe0OVrpg146pHKOxu0Bfa7K5xyZl6bNu3cqyBET20SjEL8wl/qCHU/aWX7I0D
         adFkqfONm94A4ztxxXrJlJBPmWK20eYHJ8KyInRyxOqBnuqoiqpwVVpn+8sqxKLQRjnA
         /LN+qEjuQRLQjrCJkVx7B7DJQO7E95BC7N12UwwxOjgxGJMBPpmWXPOguu/Y7nNp+7Hx
         vZNapEHTLvFculB33SVeeFei7NsobV2z9i+HSftRbtoJ0Yr+AWXInYG7Qfx23hSq6Qt5
         PDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698718248; x=1699323048;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvaTCZaVfa8YOs/0i4vt5upvE/+93PV8qucCPmWYZzM=;
        b=jxxGz+qu6nIxakrE3aMI0YFe6VDspqvBcxxSjoMNLlKMCc0k58Egjw3oohpeVt3RU4
         s9ipYqZGEwMEiZMrjjxEUV1hKHZOoqwq4Al1bQvfKLoz+7W20Lj8VxQB2M4X0cm6EX+B
         CkXEpSDcewTj065mHQVAddrzew9ZXYh/u9xRxcjalLZBUWkfC1tvMCj8PBloVVspf9Df
         n+QU6T4lH9+xOwXriRDETFwstdrdRfOjLn8ui5Xp75EM17f5ONHuLcuHjZUXi74rDT9L
         5Imgh5KuiK965Ja/9WtT1+Aug0J2teFvxeFgrQclG3CHVxCMo0t9mMq2KXWIiIAZnVFD
         p0SQ==
X-Gm-Message-State: AOJu0YzJYFz8iQN5vel6TSFedDSyFfZSBaI+xyGRANJNQ/McIFCsvuSN
        eHcqH9wL6Dven4+n+R2o7ZY=
X-Google-Smtp-Source: AGHT+IGN9eO8LyWf1xKG3Fx7H+WbTQi4R3oKTUC6n64ofAK1rLf7fydn9KmdpkTnvjqpD4pYruJ6iQ==
X-Received: by 2002:a05:6808:1156:b0:3af:b6d3:cda0 with SMTP id u22-20020a056808115600b003afb6d3cda0mr16201493oiu.40.1698718247655;
        Mon, 30 Oct 2023 19:10:47 -0700 (PDT)
Received: from ?IPV6:2401:4900:628c:8ee8:d1a1:4bda:564e:d992? ([2401:4900:628c:8ee8:d1a1:4bda:564e:d992])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a001a5200b0069305627491sm159470pfv.159.2023.10.30.19.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 19:10:47 -0700 (PDT)
Message-ID: <efea5ae2-7e41-4b78-a283-1f907be560b0@gmail.com>
Date:   Tue, 31 Oct 2023 07:39:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Anshul Dalal <anshulusr@gmail.com>
Subject: Re: [PATCH v6 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20231027051819.81333-1-anshulusr@gmail.com>
 <20231027051819.81333-2-anshulusr@gmail.com>
 <d1dd2142-546f-42b7-8966-ab75fd4f8817@t-8ch.de>
Content-Language: en-US
In-Reply-To: <d1dd2142-546f-42b7-8966-ab75fd4f8817@t-8ch.de>
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

Hello Thomas,

Thanks for the review! The requested changes will be addressed in the
next patch version though I had a few comments below:

On 10/27/23 11:44, Thomas Weißschuh wrote:
> Hi Anshul,
> 
> thanks for the reworks!
> 
> Some more comments inline.
> 
> On 2023-10-27 10:48:11+0530, Anshul Dalal wrote:
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
> 
> [..]
> 
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
> 
> The fact that these are big endian is now an implementation detail
> hidden within seesaw_read_data(), so the __be16 can go away.
> 
>> +	u32 button_state;
>> +} __packed;
> 
> While this was requested by Jeff I don't think it's correct.
> The struct is never received in this form from the device.
> I guess he also got confused, like me, by the fact that data is directly
> read into the fields of the struct.
> 
> See my comment seesaw_read_data().
> 
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
> 
> This looks very much like a sparse keymap which can be implemented with
> the helpers from <linux/input/sparse-keymap.h>.
> 

When going through the API provided by sparse-keymap, I could only see
the use for sparse_keymap_report_entry here. Which leads to the
following refactored code:

static const struct key_entry seesaw_buttons_new[] = {
	{KE_KEY, SEESAW_BUTTON_A, {BTN_SOUTH}},
	{KE_KEY, SEESAW_BUTTON_B, {BTN_EAST}},
	...
};

for (i = 0; i < ARRAY_SIZE(seesaw_buttons_new); i++) {
	sparse_keymap_report_entry(input, &seesaw_buttons_new[i],
		data.button_state & BIT(seesaw_buttons_new[i].code),
		false);
}

I don't think this significantly improves the code unless you had some
other way to use the API in mind.

> Personally I prefer each keymap entry to be on a single line (without
> designated initializers, maybe with some alignment) to save a bunch of
> vertical space.
> 
>> +
>> +static int seesaw_register_read(struct i2c_client *client, u8 register_high,
>> +				u8 register_low, char *buf, int count)
>> +{
>> +	int ret;
>> +	u8 register_buf[2] = { register_high, register_low };
>> +
>> +	ret = i2c_master_send(client, register_buf, sizeof(register_buf));
>> +	if (ret < 0)
>> +		return ret;
>> +	ret = i2c_master_recv(client, buf, count);
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
>> +
>> +	ret = seesaw_register_read(client, SEESAW_GPIO_BASE, SEESAW_GPIO_BULK,
>> +				   read_buf, sizeof(read_buf));
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->button_state = ~get_unaligned_be32(&read_buf);
>> +
>> +	ret = seesaw_register_read(client, SEESAW_ADC_BASE,
>> +				   SEESAW_ADC_OFFSET + SEESAW_ANALOG_X,
>> +				   (char *)&data->x, sizeof(data->x));
> 
> Nitpick: read into a dedicated local variable instead of 'data', as it's
> easier to understand.
> 
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
> 
> Everywhere else this is just 'if (err)'.
> 
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
>> +
>> +	seesaw = devm_kzalloc(&client->dev, sizeof(*seesaw), GFP_KERNEL);
>> +	if (!seesaw)
>> +		return -ENOMEM;
>> +
>> +	err = seesaw_register_read(client, SEESAW_STATUS_BASE,
>> +				   SEESAW_STATUS_HW_ID, &hardware_id, 1);
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
> 
> I'm not familiar with the i2c APIs but this clientdata seems to be
> unused.
> 
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
> 
> Why the linebreak on this line and not on the ones below?
> 

It was clang-format trying to prevent the line from being 81 characters
long, would be fixed in the next patch.

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
