Return-Path: <linux-kernel+bounces-18452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A91825DC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C31C23B6E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0F2572;
	Sat,  6 Jan 2024 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktvig1Ln"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928B1FD9;
	Sat,  6 Jan 2024 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7b7f2c72846so6201339f.2;
        Fri, 05 Jan 2024 17:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704506070; x=1705110870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+hZAl2KSc4KmQzerEmAzsxT2m2pIts6XC6OIce7B9Q=;
        b=ktvig1LnGI2sAp6BhiKfHUMhRgftRYvir0GPJuqnxkgR8jZHUqR4gCdjfZ986bMgCZ
         FOoAdYKt+Ly9lZ6hF9QwpwabGC+VxfSzwje+LMCUqzdoGsXEhxcQnmUYKR4quyEzMNxl
         hiUp+RVFTZVnqOE+mKlfRKrEJ2Pzb7GVyyj1drZCRKPUDghoU4zTWyq5ZWrCzsCQVM66
         x0f6mqfG+cPVjjSokna46LlgCn3n6GG98aOzXuZR1Z0NsO946eSlsp6ED6QSGHJw4Jd4
         O1Q4ioUjw5jItwHtVejTnTJdy0vKc5161K/KNp5/WY7cNJlL4Qu+tSYiTs/Llhlu/LZg
         Ldbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704506070; x=1705110870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+hZAl2KSc4KmQzerEmAzsxT2m2pIts6XC6OIce7B9Q=;
        b=dQL3rTSYaUxywVBC00/ccF53FMjeWlPZAja+GhoyUeX9rCNKjsYaLzmmRNz5IJsU3A
         9ASxHt9AYDCVC7eJgA2D2xWzqEbXMWvwzgUxAFktSShUco//zE5XpZbsapjbz5hu9+PD
         FeMDNGwy0ijD35XQKD544KDVVXxMBxd/KnApAzeewhXlX6hXvLeUeyZPke0ZqR/W/Sw+
         hWx5KW7hrMgG2UjxPNkVJ/8VLpTYQl1LtuioUAs9BcjTH7ZXJ3P9oZrd2IsXpBo1eUjJ
         4l/CPrIXUeloQ4ZJSu9DmACFZBID59M50K15sXEs7QnwZZM0sQKGZ/rLOn//fuAmp491
         FyfQ==
X-Gm-Message-State: AOJu0YxEnJTYklM17asrIp3BCQQ4kFEY5aq8p7kXGDxK+zxaw+CdlJ09
	pd7mkA+Ubo2ArRl7h8mW1uH2ICniFeguUw==
X-Google-Smtp-Source: AGHT+IGeJ7drralljCCftM1pVXM0pVYYy3ac8VIGgO19B6ALEMgfHcGI8iXk5Vr8rTyacm5Y1u2IVA==
X-Received: by 2002:a05:6e02:17c7:b0:360:7f24:9bf7 with SMTP id z7-20020a056e0217c700b003607f249bf7mr256732ilu.49.1704506070443;
        Fri, 05 Jan 2024 17:54:30 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:6276:e9ca:df79:30b7:cb06:ba1f])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001cca8a01e68sm2000166plx.278.2024.01.05.17.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 17:54:29 -0800 (PST)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org,
	"Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
	"Conor Dooley" <conor.dooley@microchip.com>,
	"Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Jeff LaBundy" <jeff@labundy.com>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v12 2/2] input: joystick: driver for Adafruit Seesaw Gamepad
Date: Sat,  6 Jan 2024 07:21:00 +0530
Message-ID: <20240106015111.882325-2-anshulusr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106015111.882325-1-anshulusr@gmail.com>
References: <20240106015111.882325-1-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Changes for v12:
- Added time unit of ms to SEESAW_GAMEPAD_POLL_INTERVAL_MS
- Use a single u16 register as argument instead of two u8s in:
    seesaw_register_read
    seesaw_register_write_u8
    seesaw_register_write_u32
- Fixed improper usage of varaible name 'ret' where an error should be
  reported

Changes for v11:
- Removed `of_match_ptr` to prevent warning:
  'seesaw_of_table' defined but not used
  on non OF platforms

Changes for v10:
- no updates

Changes for v9:
- Added of_device_id

Changes for v8:
- Updated invalid references to `adafruit_seesaw` to `adafruit-seesaw`

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

Previous versions:
v11: https://lore.kernel.org/lkml/20231215031125.284939-2-anshulusr@gmail.com/
v10: https://lore.kernel.org/lkml/20231121123409.2231115-2-anshulusr@gmail.com/
v9: https://lore.kernel.org/lkml/20231121101751.2189965-2-anshulusr@gmail.com/
v8: https://lore.kernel.org/lkml/20231108005337.45069-2-anshulusr@gmail.com/
v7: https://lore.kernel.org/lkml/20231106164134.114668-2-anshulusr@gmail.com/
v6: https://lore.kernel.org/lkml/20231027051819.81333-2-anshulusr@gmail.com/
v5: https://lore.kernel.org/lkml/20231017034356.1436677-2-anshulusr@gmail.com/
v4: https://lore.kernel.org/lkml/20231010184827.1213507-2-anshulusr@gmail.com/
v3: https://lore.kernel.org/linux-input/20231008185709.2448423-2-anshulusr@gmail.com/
v2: https://lore.kernel.org/linux-input/20231008172435.2391009-2-anshulusr@gmail.com/
v1: https://lore.kernel.org/linux-input/20231007144052.1535417-2-anshulusr@gmail.com/
---
 MAINTAINERS                              |   7 +
 drivers/input/joystick/Kconfig           |  10 +
 drivers/input/joystick/Makefile          |   1 +
 drivers/input/joystick/adafruit-seesaw.c | 312 +++++++++++++++++++++++
 4 files changed, 330 insertions(+)
 create mode 100644 drivers/input/joystick/adafruit-seesaw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d5fc0bba68..b3f101edc24b 100644
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
index ac6925ce8366..7755e5b454d2 100644
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
index 000000000000..5aff3b3c97ac
--- /dev/null
+++ b/drivers/input/joystick/adafruit-seesaw.c
@@ -0,0 +1,312 @@
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
+#include <asm/unaligned.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#define SEESAW_DEVICE_NAME		"seesaw-gamepad"
+
+#define SEESAW_ADC_BASE			0x0900
+
+#define SEESAW_GPIO_DIRCLR_BULK		0x0103
+#define SEESAW_GPIO_BULK		0x0104
+#define SEESAW_GPIO_BULK_SET		0x0105
+#define SEESAW_GPIO_PULLENSET		0x010b
+
+#define SEESAW_STATUS_HW_ID		0x0001
+#define SEESAW_STATUS_SWRST		0x007f
+
+#define SEESAW_ADC_OFFSET		0x07
+
+#define SEESAW_BUTTON_A			0x05
+#define SEESAW_BUTTON_B			0x01
+#define SEESAW_BUTTON_X			0x06
+#define SEESAW_BUTTON_Y			0x02
+#define SEESAW_BUTTON_START		0x10
+#define SEESAW_BUTTON_SELECT		0x00
+
+#define SEESAW_ANALOG_X			0x0e
+#define SEESAW_ANALOG_Y			0x0f
+
+#define SEESAW_JOYSTICK_MAX_AXIS	1023
+#define SEESAW_JOYSTICK_FUZZ		2
+#define SEESAW_JOYSTICK_FLAT		4
+
+#define SEESAW_GAMEPAD_POLL_INTERVAL_MS	16
+#define SEESAW_GAMEPAD_POLL_MIN		8
+#define SEESAW_GAMEPAD_POLL_MAX		32
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
+static const struct key_entry seesaw_buttons_new[] = {
+	{ KE_KEY, SEESAW_BUTTON_A, .keycode = BTN_SOUTH },
+	{ KE_KEY, SEESAW_BUTTON_B, .keycode = BTN_EAST },
+	{ KE_KEY, SEESAW_BUTTON_X, .keycode = BTN_NORTH },
+	{ KE_KEY, SEESAW_BUTTON_Y, .keycode = BTN_WEST },
+	{ KE_KEY, SEESAW_BUTTON_START, .keycode = BTN_START },
+	{ KE_KEY, SEESAW_BUTTON_SELECT, .keycode = BTN_SELECT },
+	{ KE_END, 0 }
+};
+
+static int seesaw_register_read(struct i2c_client *client, u16 reg, void *buf,
+				int count)
+{
+	int ret;
+	__be16 register_buf = cpu_to_be16(reg);
+	struct i2c_msg message_buf[2] = {
+		{
+			.addr = client->addr,
+			.flags = client->flags,
+			.len = sizeof(register_buf),
+			.buf = (u8 *)&register_buf,
+		},
+		{
+			.addr = client->addr,
+			.flags = client->flags | I2C_M_RD,
+			.len = count,
+			.buf = (u8 *)buf,
+		},
+	};
+
+	ret = i2c_transfer(client->adapter, message_buf,
+			   ARRAY_SIZE(message_buf));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int seesaw_register_write_u8(struct i2c_client *client, u16 reg,
+				    u8 value)
+{
+	int ret;
+	u8 write_buf[3];
+
+	put_unaligned_be16(reg, write_buf);
+	write_buf[sizeof(reg)] = value;
+
+	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int seesaw_register_write_u32(struct i2c_client *client, u16 reg,
+				     u32 value)
+{
+	int ret;
+	u8 write_buf[6];
+
+	put_unaligned_be16(reg, write_buf);
+	put_unaligned_be32(value, write_buf + sizeof(reg));
+	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int seesaw_read_data(struct i2c_client *client, struct seesaw_data *data)
+{
+	int err;
+	__be16 adc_data;
+	__be32 read_buf;
+
+	err = seesaw_register_read(client, SEESAW_GPIO_BULK, (char *)&read_buf,
+				   sizeof(read_buf));
+	if (err)
+		return err;
+
+	data->button_state = ~be32_to_cpu(read_buf);
+
+	err = seesaw_register_read(
+		client, SEESAW_ADC_BASE | (SEESAW_ADC_OFFSET + SEESAW_ANALOG_X),
+		(char *)&adc_data, sizeof(adc_data));
+	if (err)
+		return err;
+	/*
+	 * ADC reads left as max and right as 0, must be reversed since kernel
+	 * expects reports in opposite order.
+	 */
+	data->x = SEESAW_JOYSTICK_MAX_AXIS - be16_to_cpu(adc_data);
+
+	err = seesaw_register_read(
+		client, SEESAW_ADC_BASE | (SEESAW_ADC_OFFSET + SEESAW_ANALOG_Y),
+		(char *)&adc_data, sizeof(adc_data));
+	if (err)
+		return err;
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
+		if (!sparse_keymap_report_event(input, i,
+						data.button_state & BIT(i),
+						false))
+			dev_err_ratelimited(&input->dev,
+					    "failed to report keymap event");
+	}
+
+	input_sync(input);
+}
+
+static int seesaw_probe(struct i2c_client *client)
+{
+	int err;
+	u8 hardware_id;
+	struct seesaw_gamepad *seesaw;
+
+	err = seesaw_register_write_u8(client, SEESAW_STATUS_SWRST, 0xFF);
+	if (err)
+		return err;
+
+	/* Wait for the registers to reset before proceeding */
+	usleep_range(10000, 15000);
+
+	seesaw = devm_kzalloc(&client->dev, sizeof(*seesaw), GFP_KERNEL);
+	if (!seesaw)
+		return -ENOMEM;
+
+	err = seesaw_register_read(client, SEESAW_STATUS_HW_ID, &hardware_id,
+				   sizeof(hardware_id));
+	if (err)
+		return err;
+
+	dev_dbg(&client->dev, "Adafruit Seesaw Gamepad, Hardware ID: %02x\n",
+		hardware_id);
+
+	/* Set Pin Mode to input and enable pull-up resistors */
+	err = seesaw_register_write_u32(client, SEESAW_GPIO_DIRCLR_BULK,
+					SEESAW_BUTTON_MASK);
+	if (err)
+		return err;
+	err = seesaw_register_write_u32(client, SEESAW_GPIO_PULLENSET,
+					SEESAW_BUTTON_MASK);
+	if (err)
+		return err;
+	err = seesaw_register_write_u32(client, SEESAW_GPIO_BULK_SET,
+					SEESAW_BUTTON_MASK);
+	if (err)
+		return err;
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
+	err = sparse_keymap_setup(seesaw->input_dev, seesaw_buttons_new, NULL);
+	if (err) {
+		dev_err(&client->dev,
+			"failed to set up input device keymap: %d\n", err);
+		return err;
+	}
+
+	err = input_setup_polling(seesaw->input_dev, seesaw_poll);
+	if (err) {
+		dev_err(&client->dev, "failed to set up polling: %d\n", err);
+		return err;
+	}
+
+	input_set_poll_interval(seesaw->input_dev,
+				SEESAW_GAMEPAD_POLL_INTERVAL_MS);
+	input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MAX);
+	input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MIN);
+
+	err = input_register_device(seesaw->input_dev);
+	if (err) {
+		dev_err(&client->dev, "failed to register joystick: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id seesaw_id_table[] = {
+	{ SEESAW_DEVICE_NAME },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, seesaw_id_table);
+
+static const struct of_device_id seesaw_of_table[] = {
+	{ .compatible = "adafruit,seesaw-gamepad"},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, seesaw_of_table);
+
+static struct i2c_driver seesaw_driver = {
+	.driver = {
+		.name = SEESAW_DEVICE_NAME,
+		.of_match_table = seesaw_of_table,
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
2.43.0


