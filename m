Return-Path: <linux-kernel+bounces-27515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A7B82F170
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27C0B2251E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B51C293;
	Tue, 16 Jan 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EArOeC80"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0B1BF5B;
	Tue, 16 Jan 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3373bc6d625so8487140f8f.3;
        Tue, 16 Jan 2024 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418707; x=1706023507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=849yydgd36arlaWZQsqtEZfmb0t6PwML+B+XstHbWQE=;
        b=EArOeC80b3Csij3U0dTUHCk39z23UkSdLsq3BSe2/iAoQZ8G9QIFLcUfZIE0AL8IY9
         OwTq9+IfD4TkhLzVfQMCM5Dxs/I0P3tzKTqmaZLPg/h3gEcc2k4kjzBUFHibt+L42PhN
         PfYwa9NDljlWXG3uHyFgAjfY8zrgYzVJnsn7XTK8n5x2N3JAbb8cNEdc2O6AD4Y9EKh8
         V75OUxvM/sZUe3ovEawb/Adbs83E+t4AoigE0KMWBZdzPXR1hCInaCFDUMuAyXIabuqA
         iW9SuvAMOt35McegAnkNx5Jzfj9oOWWJhhUCeS6c+dtlkEq8tRDYiajkhGhx3ru97lhO
         wv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418707; x=1706023507;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=849yydgd36arlaWZQsqtEZfmb0t6PwML+B+XstHbWQE=;
        b=rFcXElSix9zc9xiknYa8AlatM455sNb0npNuTMkcEfV/cPtZDD2DEOnwMcc3kz7U64
         Hk8SRGKkZzKy0DdmdDtk1QhZAyktLaA2lDGpBYWQUiGnc63WYEMp2KhBLY3NNdv59+/F
         ou3jaTboDlatYDPrjr17MfXwSmVb/wMBVVb/BBeUZWoLWSUnmqZrQwNYwgcsQ87c1qVW
         UdXV45ueezIwKORTA39q6Li5J1G36U+TvVnywG0yUbMGIxb5qwIRyZHCNfAPVlJFin8W
         YzvtPWvzbu99GMoAA5b+mAcvX8iGmZNMNbrFK65smaJJ7Y+4cn7jn+lMg5x2N7P9e1If
         r69A==
X-Gm-Message-State: AOJu0YwtzfZ9PUBaHzKwniB/S/c/sn870fwU6dNt/WDXO89etTATpsyn
	uGONW/TGaNSdIp27mZCe9qmU+8mPlJrIeqKKmLn8UuWLfYXDow==
X-Google-Smtp-Source: AGHT+IHgy84+3Az6dnMywVDVGqr2V2PiKSHckH4fhLG9m4gctcX7B2JTERJwR3uF28+/1kkDY6xEympqZXcfZ3r+wgc=
X-Received: by 2002:a05:6000:118a:b0:336:4dc7:2d03 with SMTP id
 g10-20020a056000118a00b003364dc72d03mr3395437wrx.142.1705418706763; Tue, 16
 Jan 2024 07:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 16 Jan 2024 16:24:56 +0100
Message-ID: <CADFWO8HOb4zY7rPsCxWe2nvrzd8FjVNw0k8=8s4yB7C_BwS0ig@mail.gmail.com>
Subject: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sensirion SDP500 is a digital differential pressure sensor. The sensor is
accessed over I2C.

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 drivers/iio/pressure/Kconfig  |   9 ++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/sdp500.c | 201 ++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 drivers/iio/pressure/sdp500.c

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 95efa32e4289..5debdfbd5324 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -212,6 +212,15 @@ config MS5637
       This driver can also be built as a module. If so, the module will
       be called ms5637.

+config SDP500
+    tristate "Sensirion SDP500 differential pressure sensor I2C driver"
+    depends on I2C
+    help
+      Say Y here to build support for Sensirion SDP500 differential pressure
+      sensor I2C driver.
+      To compile this driver as a module, choose M here: the core module
+      will be called sdp500.
+
 config IIO_ST_PRESS
     tristate "STMicroelectronics pressure sensor Driver"
     depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 436aec7e65f3..489ef7b7befa 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_MS5611) += ms5611_core.o
 obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
 obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
 obj-$(CONFIG_MS5637) += ms5637.o
+obj-$(CONFIG_SDP500) += sdp500.o
 obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
 st_pressure-y := st_pressure_core.o
 st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
new file mode 100644
index 000000000000..bc492ef3ef3e
--- /dev/null
+++ b/drivers/iio/pressure/sdp500.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+
+#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normalized to 0x31)
+#define SDP500_READ_SIZE        3
+
+#define SDP500_SCALE_FACTOR 60
+
+#define SDP500_I2C_START_MEAS 0xF1
+
+#define sdp500_err(idev, fmt, ...)                    \
+    dev_err(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
+
+#define sdp500_dbg(idev, fmt, ...)                    \
+    dev_dbg(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
+
+#define sdp500_info(idev, fmt, ...)                    \
+    dev_info(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
+
+struct sdp500_data {
+    struct device *dev;
+};
+
+uint8_t calculate_crc8(uint8_t *data, uint32_t len, uint8_t poly)
+{
+    uint8_t    count = 0;
+    uint8_t    value = 0;
+    uint8_t    temp = 0;
+
+    while (len--) {
+        temp = *(data);
+        data++;
+        value ^= temp;
+        for (count = 0; count < BITS_PER_BYTE; count++) {
+            if (value & 0x80)
+                value = (value << 1) ^ poly;
+            else
+                value = value << 1;
+        }
+    }
+
+    return value;
+}
+
+static int sdp500_xfer(struct sdp500_data *data, u8 *txbuf, size_t txsize,
+              u8 *rxbuf, size_t rxsize, const struct iio_dev *indio_dev)
+{
+    struct i2c_client *client = to_i2c_client(data->dev);
+    int ret;
+
+    ret = i2c_master_send(client, txbuf, txsize);
+    if (ret < 0) {
+        sdp500_err(indio_dev, "Failed to send data");
+        return ret;
+    }
+    if (ret != txsize) {
+        sdp500_err(indio_dev, "Data is sent wrongly");
+        return -EIO;
+    }
+
+    if (!rxsize)
+        return 0;
+
+    ret = i2c_master_recv(client, rxbuf, rxsize);
+    if (ret < 0) {
+        sdp500_err(indio_dev, "Failed to receive data");
+        return ret;
+    }
+    if (ret != rxsize) {
+        sdp500_err(indio_dev, "Data is received wrongly");
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static int sdp500_start_measurement(struct sdp500_data *data, const
struct iio_dev *indio_dev)
+{
+    u8 txbuf = SDP500_I2C_START_MEAS;
+
+    return sdp500_xfer(data, &txbuf, 1, NULL, 0, indio_dev);
+}
+
+static const struct iio_chan_spec sdp500_channels[] = {
+    {
+        .type = IIO_PRESSURE,
+        .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+    },
+};
+
+static int sdp500_read_raw(struct iio_dev *indio_dev,
+              struct iio_chan_spec const *chan,
+              int *val, int *val2, long mask)
+{
+    int ret = -EINVAL;
+    u8 rxbuf[SDP500_READ_SIZE];
+    u8 rec_crc, calculated_crc;
+    s16 dec_value;
+    struct sdp500_data *data = iio_priv(indio_dev);
+
+    switch (mask) {
+    case IIO_CHAN_INFO_PROCESSED:
+        sdp500_xfer(data, NULL, 0, rxbuf, SDP500_READ_SIZE, indio_dev);
+        rec_crc = rxbuf[2];
+        calculated_crc = calculate_crc8(rxbuf, SDP500_READ_SIZE - 1,
+                        SDP500_CRC8_POLYNOMIAL);
+        if (rec_crc != calculated_crc) {
+            sdp500_err(indio_dev, "calculated crc = 0x%.2X but
received 0x%.2X",
+                calculated_crc, rec_crc);
+            return -EIO;
+        }
+
+        dec_value = ((rxbuf[0] << 8) & 0xFF00) | rxbuf[1];
+        sdp500_dbg(indio_dev, "dec value = %d", dec_value);
+
+        *val = dec_value;
+        *val2 = SDP500_SCALE_FACTOR;
+        ret = IIO_VAL_FRACTIONAL;
+        break;
+    }
+    return ret;
+}
+
+static const struct iio_info sdp500_info = {
+    .read_raw = &sdp500_read_raw,
+};
+
+static int sdp500_probe(struct i2c_client *client)
+{
+    struct iio_dev *indio_dev;
+    struct sdp500_data *data;
+    struct device *dev = &client->dev;
+    int ret;
+
+    indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+    if (!indio_dev) {
+        dev_err(dev->parent, "Failed to allocate iio device\n");
+        return -ENOMEM;
+    }
+
+    i2c_set_clientdata(client, indio_dev);
+
+    data = iio_priv(indio_dev);
+    data->dev = dev;
+
+    indio_dev->dev.parent = dev;
+    indio_dev->name = client->name;
+    indio_dev->channels = sdp500_channels;
+    indio_dev->info = &sdp500_info;
+    indio_dev->modes = INDIO_DIRECT_MODE;
+    indio_dev->num_channels = ARRAY_SIZE(sdp500_channels);
+
+    ret = sdp500_start_measurement(data, indio_dev);
+    if (ret) {
+        sdp500_err(indio_dev, "Failed to start measurement");
+        return ret;
+    }
+
+    ret = iio_device_register(indio_dev);
+    if (ret < 0) {
+        sdp500_err(indio_dev, "Failed to register indio_dev");
+        return ret;
+    }
+
+    return 0;
+}
+
+static const struct i2c_device_id sdp500_id[] = {
+    { "sdp500" },
+    { },
+};
+MODULE_DEVICE_TABLE(i2c, sdp500_id);
+
+static void sdp500_remove(struct i2c_client *client)
+{
+    struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
+
+    iio_device_unregister(indio_dev);
+}
+
+static const struct of_device_id sdp500_of_match[] = {
+    { .compatible = "sensirion,sdp500" },
+    { }
+};
+MODULE_DEVICE_TABLE(of, sdp500_of_match);
+
+static struct i2c_driver sdp500_driver = {
+    .driver = {
+        .name    = "sensirion,sdp500",
+        .of_match_table = sdp500_of_match,
+    },
+    .probe        = sdp500_probe,
+    .remove        = sdp500_remove,
+    .id_table    = sdp500_id,
+};
+module_i2c_driver(sdp500_driver);
+
+MODULE_AUTHOR("Thomas Sioutas <thomas.sioutas@prodrive-technologies.com>");
+MODULE_DESCRIPTION("Driver for Sensirion SDP500 differential pressure sensor");
+MODULE_LICENSE("GPL");
-- 
2.30.2

