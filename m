Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EFF7E2A28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjKFQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjKFQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:43:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AAED6A;
        Mon,  6 Nov 2023 08:43:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b20a48522fso3917407b3a.1;
        Mon, 06 Nov 2023 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699289010; x=1699893810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AP87UhSCC46+0c928P7ouPYnXUNXXO4Vz6ijcnIzTD8=;
        b=nsvY1P+e7SCtDGeda6eOR3abtOxDai8DQ80lu9v9FqIazQ27VTSZkNJqxs30LVDJ7g
         XQJT5QbKwNSwBY5U86xHRVPbtvxcNcQeMzuxyfxVWFO5kJ8sMU1COvkjd/Wjbss7K+E7
         7byS8o+4xKDg8412OM2PyO3Cj+Zr73Wzp4t67tVkfp1/Oe7dsxelYQfU0Vutz+r0MAZw
         qdrWdczoAhJRIXe2h/Xm4G6Dh+Lxwgb0up+MrPwONiS80X0LbCVz5Er2cmYU+O0kRTMk
         QoJxKUuZm+d/m6tDK+2kaar9IDuvl4DxAQVlz0gMdinhOx+kxBxsTZqpmYfMf9ZX1VsU
         R+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289010; x=1699893810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AP87UhSCC46+0c928P7ouPYnXUNXXO4Vz6ijcnIzTD8=;
        b=eQocTXYGowsMPSJcsxrJXfZsqG3FZn+K4zY3i5FTGXlOJGyuaDCk2atiSLArAGPPck
         cKTe3OZMnJX5oHcr1/m6hKngjWz1MvSxPBQ62Lyq/Umqjj9NGvhN7GW/WOSxwmBMZyHI
         HKrkHzT/DBM2UfG5ckJViAGy9sTy94bjGVsOgyLzO9Dj/KyFcl5pwTQQ1lWpSDLObDSW
         MsyDbkHMB8bexmu8shAM2Do3Nd0+zhc+FtFZ5v7S2uiuzzXk6SqXZpW8JZjc4di9w3h3
         icBYhLnLBxN+oZq+pp1oDO+O9xia5sofBS05aGUzalwNU1qMiev2y1J4zCJBFUMKbZYw
         EPnA==
X-Gm-Message-State: AOJu0YyZxOfasNqoIiF1em3E6DaXotqV6/W80SKTj6zshb7i2A58phOK
        jrquZjhfWnPj7K34W0QD86zuDXQvh3VceUbc
X-Google-Smtp-Source: AGHT+IGZpcEKGhDjlddo0oTBeKfc7jgJTuvIBOxlRqoN8wR1J+6id150fQL4Jlu9OdPhI8L4tsjjkQ==
X-Received: by 2002:a05:6a00:816:b0:6bc:b13c:35d5 with SMTP id m22-20020a056a00081600b006bcb13c35d5mr28249801pfk.13.1699289010324;
        Mon, 06 Nov 2023 08:43:30 -0800 (PST)
Received: from archlinux.srmu.edu.in ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id b6-20020a056a000a8600b006933e71956dsm5828227pfl.9.2023.11.06.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 08:43:30 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jeff LaBundy <jeff@labundy.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] input: joystick: driver for Adafruit Seesaw Gamepad
Date:   Mon,  6 Nov 2023 22:11:32 +0530
Message-ID: <20231106164134.114668-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106164134.114668-1-anshulusr@gmail.com>
References: <20231106164134.114668-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---

Changes for v7:
adafruit-seesaw.c
- Fixed formatting for macro definitions
- Made SEESAW_BUTTON_MASK static const
- Removed __be16 type for x and y fields of seesaw_data
- Used sparse_keymap implementation instead of custom keymap
- Used i2c_msg instead of i2c_master_send and recv in
  seesaw_register_read
- Use temporary variable `adc_data` to store data received from ADC
- Changed read_buf from u8[4] to __be32
- Use usleep_range instead of msleep
- Removed 'Reviewed-by: Thomas Weißschuh' due to large number of changes
  since last review
Kconfig:
- Added `select INPUT_SPARSEKMAP`

Changes for v6:
- Added TODO
- Removed `clang-format` directives
- Namespaced device buttons
- Removed `char physical_path[32]` field from `struct seesaw_gamepad`
- Added `packed` attribute to `struct seesaw_data`
- Moved from having booleans per button to single `u32 button_state`
- Added `seesaw_button_description` array to directly associate device
  buttons with respective keycodes
- Added wrapper functions `seesaw_register_` around `i2c_master_` API
- Ratelimited input error reporting with `dev_err_ratelimited`
- Removed `of_device_id`

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
---
 MAINTAINERS                              |   7 +
 drivers/input/joystick/Kconfig           |  10 +
 drivers/input/joystick/Makefile          |   1 +
 drivers/input/joystick/adafruit-seesaw.c | 315 +++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 drivers/input/joystick/adafruit-seesaw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d5fc0bba68..cd4f9deb77e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -441,6 +441,13 @@ W:	http://wiki.analog.com/AD7879
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/touchscreen/ad7879.c
 
+ADAFRUIT MINI I2C GAMEPAD
+M:	Anshul Dalal <anshulusr@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/adafruit_seesaw.yaml
+F:	drivers/input/joystick/adafruit_seesaw.c
+
 ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
 M:	Jiri Kosina <jikos@kernel.org>
 S:	Maintained
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index ac6925ce8366..7914bef999b7 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -412,4 +412,14 @@ config JOYSTICK_SENSEHAT
 	  To compile this driver as a module, choose M here: the
 	  module will be called sensehat_joystick.
 
+config JOYSTICK_SEESAW
+	tristate "Adafruit Mini I2C Gamepad with Seesaw"
+	depends on I2C
+	select INPUT_SPARSEKMAP
+	help
+	  Say Y here if you want to use the Adafruit Mini I2C Gamepad.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called adafruit_seesaw.
+
 endif
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index 3937535f0098..fdc653209542 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_JOYSTICK_N64)		+= n64joy.o
 obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
 obj-$(CONFIG_JOYSTICK_PXRC)		+= pxrc.o
 obj-$(CONFIG_JOYSTICK_QWIIC)		+= qwiic-joystick.o
+obj-$(CONFIG_JOYSTICK_SEESAW)		+= adafruit_seesaw.o
 obj-$(CONFIG_JOYSTICK_SENSEHAT)	+= sensehat-joystick.o
 obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
 obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
diff --git a/drivers/input/joystick/adafruit-seesaw.c b/drivers/input/joystick/adafruit-seesaw.c
new file mode 100644
index 000000000000..8e8ef26a585f
--- /dev/null
+++ b/drivers/input/joystick/adafruit-seesaw.c
@@ -0,0 +1,315 @@
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
+ *
+ * TODO:
+ *	- Add interrupt support
+ */
+
+#include <asm-generic/unaligned.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#define SEESAW_DEVICE_NAME	     "seesaw-gamepad"
+
+#define SEESAW_STATUS_BASE	     0x00
+#define SEESAW_GPIO_BASE	     0x01
+#define SEESAW_ADC_BASE		     0x09
+
+#define SEESAW_GPIO_DIRCLR_BULK	     0x03
+#define SEESAW_GPIO_BULK	     0x04
+#define SEESAW_GPIO_BULK_SET	     0x05
+#define SEESAW_GPIO_PULLENSET	     0x0b
+
+#define SEESAW_STATUS_HW_ID	     0x01
+#define SEESAW_STATUS_SWRST	     0x7f
+
+#define SEESAW_ADC_OFFSET	     0x07
+
+#define SEESAW_BUTTON_A		     0x05
+#define SEESAW_BUTTON_B		     0x01
+#define SEESAW_BUTTON_X		     0x06
+#define SEESAW_BUTTON_Y		     0x02
+#define SEESAW_BUTTON_START	     0x10
+#define SEESAW_BUTTON_SELECT	     0x00
+
+#define SEESAW_ANALOG_X		     0x0e
+#define SEESAW_ANALOG_Y		     0x0f
+
+#define SEESAW_JOYSTICK_MAX_AXIS     1023
+#define SEESAW_JOYSTICK_FUZZ	     2
+#define SEESAW_JOYSTICK_FLAT	     4
+
+#define SEESAW_GAMEPAD_POLL_INTERVAL 16
+#define SEESAW_GAMEPAD_POLL_MIN	     8
+#define SEESAW_GAMEPAD_POLL_MAX	     32
+
+static const u32 SEESAW_BUTTON_MASK =
+	BIT(SEESAW_BUTTON_A) | BIT(SEESAW_BUTTON_B) | BIT(SEESAW_BUTTON_X) |
+	BIT(SEESAW_BUTTON_Y) | BIT(SEESAW_BUTTON_START) |
+	BIT(SEESAW_BUTTON_SELECT);
+
+struct seesaw_gamepad {
+	struct input_dev *input_dev;
+	struct i2c_client *i2c_client;
+};
+
+struct seesaw_data {
+	u16 x;
+	u16 y;
+	u32 button_state;
+};
+
+struct seesaw_button_description {
+	unsigned int code;
+	unsigned int bit;
+};
+
+static const struct key_entry seesaw_buttons_new[] = {
+	{ KE_KEY, SEESAW_BUTTON_A, .keycode = BTN_SOUTH },
+	{ KE_KEY, SEESAW_BUTTON_B, .keycode = BTN_EAST },
+	{ KE_KEY, SEESAW_BUTTON_X, .keycode = BTN_NORTH },
+	{ KE_KEY, SEESAW_BUTTON_Y, .keycode = BTN_WEST },
+	{ KE_KEY, SEESAW_BUTTON_START, .keycode = BTN_START },
+	{ KE_KEY, SEESAW_BUTTON_SELECT, .keycode = BTN_SELECT },
+	{ KE_END, 0 },
+};
+
+static int seesaw_register_read(struct i2c_client *client, u8 register_high,
+				u8 register_low, char *buf, int count)
+{
+	int ret;
+	u8 register_buf[2] = { register_high, register_low };
+
+	struct i2c_msg message_buf[2] = {
+		{
+			.addr = client->addr,
+			.flags = client->flags,
+			.len = sizeof(register_buf),
+			.buf = register_buf
+		},
+		{
+			.addr = client->addr,
+			.flags = client->flags | I2C_M_RD,
+			.len = count,
+			.buf = buf
+		},
+	};
+	ret = i2c_transfer(client->adapter, message_buf,
+			   ARRAY_SIZE(message_buf));
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int seesaw_register_write_u8(struct i2c_client *client, u8 register_high,
+				    u8 register_low, u8 value)
+{
+	int ret;
+	u8 write_buf[3] = { register_high, register_low, value };
+
+	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int seesaw_register_write_u32(struct i2c_client *client,
+				     u8 register_high, u8 register_low,
+				     u32 value)
+{
+	int ret;
+	u8 write_buf[6] = { register_high, register_low };
+
+	put_unaligned_be32(value, write_buf + 2);
+	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
+{
+	int ret;
+	__be16 adc_data;
+	__be32 read_buf;
+
+	ret = seesaw_register_read(client, SEESAW_GPIO_BASE, SEESAW_GPIO_BULK,
+				   (char *)&read_buf, sizeof(read_buf));
+	if (ret)
+		return ret;
+
+	data->button_state = ~be32_to_cpu(read_buf);
+
+	ret = seesaw_register_read(client, SEESAW_ADC_BASE,
+				   SEESAW_ADC_OFFSET + SEESAW_ANALOG_X,
+				   (char *)&adc_data, sizeof(adc_data));
+	if (ret)
+		return ret;
+	/*
+	 * ADC reads left as max and right as 0, must be reversed since kernel
+	 * expects reports in opposite order.
+	 */
+	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(adc_data);
+
+	ret = seesaw_register_read(client, SEESAW_ADC_BASE,
+				   SEESAW_ADC_OFFSET + SEESAW_ANALOG_Y,
+				   (char *)&adc_data, sizeof(adc_data));
+	if (ret)
+		return ret;
+	data->y = be16_to_cpu(adc_data);
+
+	return 0;
+}
+
+static void seesaw_poll(struct input_dev *input)
+{
+	int err, i;
+	struct seesaw_gamepad *private = input_get_drvdata(input);
+	struct seesaw_data data;
+
+	err = seesaw_read_data(private->i2c_client, &data);
+	if (err) {
+		dev_err_ratelimited(&input->dev,
+				    "failed to read joystick state: %d\n", err);
+		return;
+	}
+
+	input_report_abs(input, ABS_X, data.x);
+	input_report_abs(input, ABS_Y, data.y);
+
+	for_each_set_bit(i, (long *)&SEESAW_BUTTON_MASK,
+			 BITS_PER_TYPE(SEESAW_BUTTON_MASK)) {
+		if (!sparse_keymap_report_event(
+			    input, i, data.button_state & BIT(i), false)) {
+			dev_err_ratelimited(&input->dev,
+					    "failed to report keymap event");
+			return;
+		};
+	}
+
+	input_sync(input);
+}
+
+static int seesaw_probe(struct i2c_client *client)
+{
+	int ret;
+	u8 hardware_id;
+	struct seesaw_gamepad *seesaw;
+
+	ret = seesaw_register_write_u8(client, SEESAW_STATUS_BASE,
+				       SEESAW_STATUS_SWRST, 0xFF);
+	if (ret)
+		return ret;
+
+	/* Wait for the registers to reset before proceeding */
+	usleep_range(10000, 15000);
+
+	seesaw = devm_kzalloc(&client->dev, sizeof(*seesaw), GFP_KERNEL);
+	if (!seesaw)
+		return -ENOMEM;
+
+	ret = seesaw_register_read(client, SEESAW_STATUS_BASE,
+				   SEESAW_STATUS_HW_ID, &hardware_id,
+				   sizeof(hardware_id));
+	if (ret)
+		return ret;
+
+	dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware ID: %02x\n",
+		hardware_id);
+
+	/* Set Pin Mode to input and enable pull-up resistors */
+	ret = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
+					SEESAW_GPIO_DIRCLR_BULK,
+					SEESAW_BUTTON_MASK);
+	if (ret)
+		return ret;
+	ret = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
+					SEESAW_GPIO_PULLENSET,
+					SEESAW_BUTTON_MASK);
+	if (ret)
+		return ret;
+	ret = seesaw_register_write_u32(client, SEESAW_GPIO_BASE,
+					SEESAW_GPIO_BULK_SET,
+					SEESAW_BUTTON_MASK);
+	if (ret)
+		return ret;
+
+	seesaw->i2c_client = client;
+	seesaw->input_dev = devm_input_allocate_device(&client->dev);
+	if (!seesaw->input_dev)
+		return -ENOMEM;
+
+	seesaw->input_dev->id.bustype = BUS_I2C;
+	seesaw->input_dev->name = "Adafruit Seesaw Gamepad";
+	seesaw->input_dev->phys = "i2c/" SEESAW_DEVICE_NAME;
+	input_set_drvdata(seesaw->input_dev, seesaw);
+	input_set_abs_params(seesaw->input_dev, ABS_X, 0,
+			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
+			     SEESAW_JOYSTICK_FLAT);
+	input_set_abs_params(seesaw->input_dev, ABS_Y, 0,
+			     SEESAW_JOYSTICK_MAX_AXIS, SEESAW_JOYSTICK_FUZZ,
+			     SEESAW_JOYSTICK_FLAT);
+
+	ret = sparse_keymap_setup(seesaw->input_dev, seesaw_buttons_new, NULL);
+	if (ret) {
+		dev_err(&client->dev,
+			"failed to set up input device keymap: %d\n", ret);
+		return ret;
+	}
+
+	ret = input_setup_polling(seesaw->input_dev, seesaw_poll);
+	if (ret) {
+		dev_err(&client->dev, "failed to set up polling: %d\n", ret);
+		return ret;
+	}
+
+	input_set_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_INTERVAL);
+	input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MAX);
+	input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MIN);
+
+	ret = input_register_device(seesaw->input_dev);
+	if (ret) {
+		dev_err(&client->dev, "failed to register joystick: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id seesaw_id_table[] = {
+	{ SEESAW_DEVICE_NAME, 0 },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
+
+static struct i2c_driver seesaw_driver = {
+	.driver = {
+		.name = SEESAW_DEVICE_NAME,
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

