Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B619C7C728E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379571AbjJLQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379552AbjJLQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:29:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90DBC0;
        Thu, 12 Oct 2023 09:29:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9e06f058bso6351845ad.0;
        Thu, 12 Oct 2023 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697128145; x=1697732945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYJgt5+b5HVwNIIrlfXEoBwZ8hfn4jjcSeUfjjs6Z20=;
        b=FSBgfnNVLkRlZhUYANa2H950QdBwb21+fgDdQsKhxaRErlSc+EPGeH/PMol5AoJv+S
         WkBQeUTMTfYT/on63NsnuZHD4LJ/LtK7soT7GXGKoRWAENVbEqkWv60ZboYgbe0rHBCH
         vFHn4PgpfQGxGCJtrQ4XO74wvLPfIfW+IrAAz9bqAKn8zcodAUxKthtFTYrxRs5P26K+
         CxUN/Dwf42gf/wh4nGkOyEgCbdmhdTlltyh5umD3LcW7BomSnt/agwMl3MbwebfyPyux
         CQViGufyPEPBNZNMcTHfXyDkZ4vUvPnsYY7M0O688hMO6r/UmK7DT9CvdkQmDJeO/ND6
         c7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128145; x=1697732945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYJgt5+b5HVwNIIrlfXEoBwZ8hfn4jjcSeUfjjs6Z20=;
        b=AoNRja0xyygcMFqCXN2gpS3PAWUJO1JgIc2YZci/0lhaRNGj7BQQM2qctEuT5GEqeI
         G6nSOevKoJjHFBasLOVMGsDY7yUP98oQj4mnUAVHWc3P/6FIe64x4qPwjRlGwEf0SIMp
         8LhQfymF/4SEro0dVSIOosDBQdTpoorgfKG+/I0PAVI+mzR8WBeTpU4Pp6iITpqmRRTU
         hGYTbHM4GToAlvsxeqczItrozFgvelOSXc+URbKLe39rsISCykR4KG2sBl8/e2zu7H+X
         Z8hY5r7vUubfIXksZUzJSAjhjy0RVolzTyAhr2T7PqpKrrNLYqHUGtQNLT3pg2alYQPm
         B08w==
X-Gm-Message-State: AOJu0YyquLLticy5XbKt+A+FTRNuPpqo6MiF/PuJHCQ8rrIzK/yQ91TS
        +KY0G6nUOoER//BmaHnnLBr95UGjYzB4ri04
X-Google-Smtp-Source: AGHT+IEplS+hBqgmppkXIT5BVJywWknho121+6Zkx/sjKXbuRQWRXySiKi1xHpmak/ChlGNRmwuvYQ==
X-Received: by 2002:a17:903:41c4:b0:1c5:7d49:570e with SMTP id u4-20020a17090341c400b001c57d49570emr35874014ple.29.1697128144775;
        Thu, 12 Oct 2023 09:29:04 -0700 (PDT)
Received: from localhost.localdomain ([49.37.136.12])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001bb9f104328sm2181575plg.146.2023.10.12.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:29:04 -0700 (PDT)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] input: joystick: driver for Adafruit Seesaw Gamepad
Date:   Thu, 12 Oct 2023 21:57:56 +0530
Message-ID: <20231012162759.691555-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012162759.691555-1-anshulusr@gmail.com>
References: <20231012162759.691555-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a driver for a mini gamepad that communicates over i2c, the gamepad
has bidirectional thumb stick input and six buttons.

The gamepad chip utilizes the open framework from Adafruit called 'Seesaw'
to transmit the ADC data for the joystick and digital pin state for the
buttons. I have only implemented the functionality required to receive the
thumb stick and button state.

Steps in reading the gamepad state over i2c:
  1. Reset the registers
  2. Set the pin mode of the pins specified by the `BUTTON_MASK` to input
      `BUTTON_MASK`: A bit-map for the six digital pins internally
       connected to the joystick buttons.
  3. Enable internal pullup resistors for the `BUTTON_MASK`
  4. Bulk set the pin state HIGH for `BUTTON_MASK`
  5. Poll the device for button and joystick state done by:
      `seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)`

Product page:
  https://www.adafruit.com/product/5743
Arduino driver:
  https://github.com/adafruit/Adafruit_Seesaw

Driver tested on RPi Zero 2W

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v5:
- Added link to the datasheet
- Added debug log message when `seesaw_read_data` fails

Changes for v4:
- Changed `1UL << BUTTON_` to BIT(BUTTON_)
- Removed `hardware_id` field from `struct seesaw_gamepad`
- Removed redundant checks for the number of bytes written and received by
  `i2c_master_send` and `i2c_master_recv`
- Used `get_unaligned_be32` to instantiate `u32 result` from `read_buf`
- Changed  `result & (1UL << BUTTON_)` to
  `test_bit(BUTTON_, (long *)&result)`
- Changed `KBUILD_MODNAME` in id-tables to `SEESAW_DEVICE_NAME`
- Fixed formatting issues
- Changed button reporting:
    Since the gamepad had the action buttons in a non-standard layout:
         (X)
      (Y)   (A)
         (B)
    Therefore moved to using generic directional action button event codes
    instead of BTN_[ABXY].

Changes for v3:
- no updates

Changes for v2:
adafruit-seesaw.c:
- Renamed file from 'adafruit_seesaw.c'
- Changed device name from 'seesaw_gamepad' to 'seesaw-gamepad'
- Changed count parameter for receiving joystick x on line 118:
    `2` to `sizeof(write_buf)`
- Fixed invalid buffer size on line 123 and 126:
    `data->y` to `sizeof(data->y)`
- Added comment for the `mdelay(10)` on line 169
- Changed inconsistent indentation on line 271
Kconfig:
- Fixed indentation for the help text
- Updated module name
Makefile:
- Updated module object file name
MAINTAINERS:
- Updated file name for the driver and bindings

 MAINTAINERS                              |   7 +
 drivers/input/joystick/Kconfig           |   9 +
 drivers/input/joystick/Makefile          |   1 +
 drivers/input/joystick/adafruit-seesaw.c | 273 +++++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 drivers/input/joystick/adafruit-seesaw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c4cce45a09d..a314f9b48e21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -441,6 +441,13 @@ W:	http://wiki.analog.com/AD7879
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/touchscreen/ad7879.c
 
+ADAFRUIT MINI I2C GAMEPAD
+M:	Anshul Dalal <anshulusr@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
+F:	drivers/input/joystick/adafruit-seesaw.c
+
 ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
 M:	Jiri Kosina <jikos@kernel.org>
 S:	Maintained
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index ac6925ce8366..df9cd1830b29 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -412,4 +412,13 @@ config JOYSTICK_SENSEHAT
 	  To compile this driver as a module, choose M here: the
 	  module will be called sensehat_joystick.
 
+config JOYSTICK_SEESAW
+	tristate "Adafruit Mini I2C Gamepad with Seesaw"
+	depends on I2C
+	help
+	  Say Y here if you want to use the Adafruit Mini I2C Gamepad.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called adafruit-seesaw.
+
 endif
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index 3937535f0098..9976f596a920 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_JOYSTICK_N64)		+= n64joy.o
 obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
 obj-$(CONFIG_JOYSTICK_PXRC)		+= pxrc.o
 obj-$(CONFIG_JOYSTICK_QWIIC)		+= qwiic-joystick.o
+obj-$(CONFIG_JOYSTICK_SEESAW)		+= adafruit-seesaw.o
 obj-$(CONFIG_JOYSTICK_SENSEHAT)	+= sensehat-joystick.o
 obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
 obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
new file mode 100644
index 000000000000..2a1eae8d2861
--- /dev/null
+++ b/drivers/input/joystick/adafruit-seesaw.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Anshul Dalal <anshulusr@gmail.com>
+ *
+ * Driver for Adafruit Mini I2C Gamepad
+ *
+ * Based on the work of:
+ *	Oleh Kravchenko (Sparkfun Qwiic Joystick driver)
+ *
+ * Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
+ * Product page: https://www.adafruit.com/product/5743
+ * Firmware and hardware sources: https://github.com/adafruit/Adafruit_Seesaw
+ */
+
+#include <asm-generic/unaligned.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+/* clang-format off */
+#define SEESAW_DEVICE_NAME	"seesaw-gamepad"
+
+#define SEESAW_STATUS_BASE	0
+#define SEESAW_GPIO_BASE	1
+#define SEESAW_ADC_BASE		9
+
+#define SEESAW_GPIO_DIRCLR_BULK	3
+#define SEESAW_GPIO_BULK	4
+#define SEESAW_GPIO_BULK_SET	5
+#define SEESAW_GPIO_PULLENSET	11
+
+#define SEESAW_STATUS_HW_ID	1
+#define SEESAW_STATUS_SWRST	127
+
+#define SEESAW_ADC_OFFSET	7
+
+#define BUTTON_A	5
+#define BUTTON_B	1
+#define BUTTON_X	6
+#define BUTTON_Y	2
+#define BUTTON_START	16
+#define BUTTON_SELECT	0
+
+#define ANALOG_X	14
+#define ANALOG_Y	15
+
+#define SEESAW_JOYSTICK_MAX_AXIS	1023
+#define SEESAW_JOYSTICK_FUZZ		2
+#define SEESAW_JOYSTICK_FLAT		4
+
+#define SEESAW_GAMEPAD_POLL_INTERVAL	16
+#define SEESAW_GAMEPAD_POLL_MIN		8
+#define SEESAW_GAMEPAD_POLL_MAX		32
+/* clang-format on */
+
+u32 BUTTON_MASK = BIT(BUTTON_A) | BIT(BUTTON_B) | BIT(BUTTON_X) |
+		  BIT(BUTTON_Y) | BIT(BUTTON_START) | BIT(BUTTON_SELECT);
+
+struct seesaw_gamepad {
+	char physical_path[32];
+	struct input_dev *input_dev;
+	struct i2c_client *i2c_client;
+};
+
+struct seesaw_data {
+	__be16 x;
+	__be16 y;
+	u8 button_a, button_b, button_x, button_y, button_start, button_select;
+};
+
+static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
+{
+	int err;
+	unsigned char write_buf[2] = { SEESAW_GPIO_BASE, SEESAW_GPIO_BULK };
+	unsigned char read_buf[4];
+
+	err = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (err < 0)
+		return err;
+	err = i2c_master_recv(client, read_buf, sizeof(read_buf));
+	if (err < 0)
+		return err;
+
+	u32 result = get_unaligned_be32(&read_buf);
+
+	data->button_a = !test_bit(BUTTON_A, (long *)&result);
+	data->button_b = !test_bit(BUTTON_B, (long *)&result);
+	data->button_x = !test_bit(BUTTON_X, (long *)&result);
+	data->button_y = !test_bit(BUTTON_Y, (long *)&result);
+	data->button_start = !test_bit(BUTTON_START, (long *)&result);
+	data->button_select = !test_bit(BUTTON_SELECT, (long *)&result);
+
+	write_buf[0] = SEESAW_ADC_BASE;
+	write_buf[1] = SEESAW_ADC_OFFSET + ANALOG_X;
+	err = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (err < 0)
+		return err;
+	err = i2c_master_recv(client, (char *)&data->x, sizeof(data->x));
+	if (err < 0)
+		return err;
+	/*
+	 * ADC reads left as max and right as 0, must be reversed since kernel
+	 * expects reports in opposite order.
+	 */
+	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(data->x);
+
+	write_buf[1] = SEESAW_ADC_OFFSET + ANALOG_Y;
+	err = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (err < 0)
+		return err;
+	err = i2c_master_recv(client, (char *)&data->y, sizeof(data->y));
+	if (err < 0)
+		return err;
+	data->y = be16_to_cpu(data->y);
+
+	return 0;
+}
+
+static void seesaw_poll(struct input_dev *input)
+{
+	struct seesaw_gamepad *private = input_get_drvdata(input);
+	struct seesaw_data data;
+	int err;
+
+	err = seesaw_read_data(private->i2c_client, &data);
+	if (err != 0) {
+		dev_dbg(&input->dev, "failed to read joystick state: %d\n",
+			err);
+		return;
+	}
+
+	input_report_abs(input, ABS_X, data.x);
+	input_report_abs(input, ABS_Y, data.y);
+	input_report_key(input, BTN_EAST, data.button_a);
+	input_report_key(input, BTN_SOUTH, data.button_b);
+	input_report_key(input, BTN_NORTH, data.button_x);
+	input_report_key(input, BTN_WEST, data.button_y);
+	input_report_key(input, BTN_START, data.button_start);
+	input_report_key(input, BTN_SELECT, data.button_select);
+	input_sync(input);
+}
+
+static int seesaw_probe(struct i2c_client *client)
+{
+	int err;
+	struct seesaw_gamepad *private;
+	unsigned char register_reset[] = { SEESAW_STATUS_BASE,
+					   SEESAW_STATUS_SWRST, 0xFF };
+	unsigned char get_hw_id[] = { SEESAW_STATUS_BASE, SEESAW_STATUS_HW_ID };
+
+	err = i2c_master_send(client, register_reset, sizeof(register_reset));
+	if (err < 0)
+		return err;
+
+	/* Wait for the registers to reset before proceeding */
+	mdelay(10);
+
+	private = devm_kzalloc(&client->dev, sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
+
+	err = i2c_master_send(client, get_hw_id, sizeof(get_hw_id));
+	if (err < 0)
+		return err;
+
+	unsigned char hardware_id;
+
+	err = i2c_master_recv(client, &hardware_id, 1);
+	if (err < 0)
+		return err;
+
+	dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware ID: %02x\n",
+		hardware_id);
+
+	private->i2c_client = client;
+	scnprintf(private->physical_path, sizeof(private->physical_path),
+		  "i2c/%s", dev_name(&client->dev));
+	i2c_set_clientdata(client, private);
+
+	private->input_dev = devm_input_allocate_device(&client->dev);
+	if (!private->input_dev)
+		return -ENOMEM;
+
+	private->input_dev->id.bustype = BUS_I2C;
+	private->input_dev->name = "Adafruit Seesaw Gamepad";
+	private->input_dev->phys = private->physical_path;
+	input_set_drvdata(private->input_dev, private);
+	input_set_abs_params(private->input_dev, ABS_X, 0,
+			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
+			     SEESAW_JOYSTICK_FLAT);
+	input_set_abs_params(private->input_dev, ABS_Y, 0,
+			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
+			     SEESAW_JOYSTICK_FLAT);
+	input_set_capability(private->input_dev, EV_KEY, BTN_EAST);
+	input_set_capability(private->input_dev, EV_KEY, BTN_SOUTH);
+	input_set_capability(private->input_dev, EV_KEY, BTN_NORTH);
+	input_set_capability(private->input_dev, EV_KEY, BTN_WEST);
+	input_set_capability(private->input_dev, EV_KEY, BTN_START);
+	input_set_capability(private->input_dev, EV_KEY, BTN_SELECT);
+
+	err = input_setup_polling(private->input_dev, seesaw_poll);
+	if (err) {
+		dev_err(&client->dev, "failed to set up polling: %d\n", err);
+		return err;
+	}
+
+	input_set_poll_interval(private->input_dev,
+				SEESAW_GAMEPAD_POLL_INTERVAL);
+	input_set_max_poll_interval(private->input_dev,
+				    SEESAW_GAMEPAD_POLL_MAX);
+	input_set_min_poll_interval(private->input_dev,
+				    SEESAW_GAMEPAD_POLL_MIN);
+
+	err = input_register_device(private->input_dev);
+	if (err) {
+		dev_err(&client->dev, "failed to register joystick: %d\n", err);
+		return err;
+	}
+
+	/* Set Pin Mode to input and enable pull-up resistors */
+	unsigned char pin_mode[] = { SEESAW_GPIO_BASE,	SEESAW_GPIO_DIRCLR_BULK,
+				     BUTTON_MASK >> 24, BUTTON_MASK >> 16,
+				     BUTTON_MASK >> 8,	BUTTON_MASK };
+	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
+	if (err < 0)
+		return err;
+	pin_mode[1] = SEESAW_GPIO_PULLENSET;
+	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
+	if (err < 0)
+		return err;
+	pin_mode[1] = SEESAW_GPIO_BULK_SET;
+	err = i2c_master_send(client, pin_mode, sizeof(pin_mode));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id of_seesaw_match[] = {
+	{
+		.compatible = "adafruit,seesaw-gamepad",
+	},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_seesaw_match);
+#endif /* CONFIG_OF */
+
+/* clang-format off */
+static const struct i2c_device_id seesaw_id_table[] = {
+	{ SEESAW_DEVICE_NAME, 0 },
+	{ /* Sentinel */ }
+};
+/* clang-format on */
+
+MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
+
+static struct i2c_driver seesaw_driver = {
+	.driver = {
+		.name = SEESAW_DEVICE_NAME,
+		.of_match_table = of_match_ptr(of_seesaw_match),
+	},
+	.id_table = seesaw_id_table,
+	.probe = seesaw_probe,
+};
+module_i2c_driver(seesaw_driver);
+
+MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
+MODULE_DESCRIPTION("Adafruit Mini I2C Gamepad driver");
+MODULE_LICENSE("GPL");
-- 
2.42.0

