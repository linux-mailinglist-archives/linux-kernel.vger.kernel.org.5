Return-Path: <linux-kernel+bounces-164264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E08B7B88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5527283735
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134F17A932;
	Tue, 30 Apr 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix0Bnv5D"
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1CD179658;
	Tue, 30 Apr 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490858; cv=none; b=nACdZwvJKG1K9xjCIGnT35dJMWpnuy/YpCOAI+d3zYEi2YcmY8BrMFBHLFCmsychEIzNpvCdWBrxur9BAGdy1m1P5uHqwbTbh+GZSJH+T2Cn3GrKniGLC3XiHfmLxDf6s3E4ro6VRvea4o5zVrCbNkVSUAT5aBHuc+VKdnCoBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490858; c=relaxed/simple;
	bh=TMnfaLDw8Wdg348ZSYv8S2FHUn452XaRifRi7nKkpq4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Fh/yvhhpNnpTuRnlyZbECf4kL4eRqAirRMUwa/xFCRJ+Q91QduQ0bpY2U6Ip/T6O1EwCexvB4Xvqg2pITWpuyo8JXBYVEXpsYs2+aUlEO2hmWfC1pD7WEdGjKXpaMOn3uWUot0UutAW6RM1QvC+Lf9QwitL2N8S3VO/asKTqvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix0Bnv5D; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-7decd8cd028so102555539f.0;
        Tue, 30 Apr 2024 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714490856; x=1715095656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=brijGud1qRc3bUwMaKoQ6h0gClq5IQ0B11HmLfSyAqg=;
        b=ix0Bnv5D9q9s2kr1u4mIPX9MNZ2VQqiMtgkHaVb4dpEQ4/3O12WY9XZ4ridGzA3Ysh
         gxykpmsS3ao/spUGfOfF1qEd7BaHNwRplCzDhn0nPDiM4XDfv6lBxpbCsn5jGCb8lYuQ
         4p/hBaJaK73WBTJ5XU0ixNxDigBx9qtghzER3qTchPn/Th8wSkZBV2/VAwI3DKnRQ1km
         OYr5Vm0mqYCmRtLIxdF/x0ZLnKbQJGYdZh2PuOHEaWhevAzD8h6NWgGhOV8WMNvhEb1d
         V+Pq16pyutnKKfpFv6t+wbuePFjwB0c9Q0VGNhHbyy6LB469XH3/ZS1aZTpCuEi8jK+q
         z7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490856; x=1715095656;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brijGud1qRc3bUwMaKoQ6h0gClq5IQ0B11HmLfSyAqg=;
        b=MrJzwJqntJB06NfMMBVJFUYPVQwrRka06OOygAwOnaYdGoJYS86IAUtm3NZCVmMVtD
         cM5YSnm6UG0daITTHuMa/HXY/0oE3GbipUVuJz1D1YUvCZfOG4IPU79vbwgPXKb615lx
         F/Brp61vCIThiPZSjcWS+fLK1+RZDadKvGcFCIRlF9S2VY8mnHvA00qVHp9mRud+nLlG
         LdOiveDwKHSlYSWwth8BX8wvZOrNLfo4u15AmUlmGgjf5xWjZV66Ntfcs8t1JPwUrdxU
         AqjHhkZx8jggj7BFxaOifj9/nOuMu7XdVJ85LVEym6uTF1hgxZn5PPeY2V2nwEIif3EV
         5+ag==
X-Forwarded-Encrypted: i=1; AJvYcCUxrADzv2hd9tYUPF5rok+OkBnQ6pgXjkETptC2OpPFC65R+E8DmzJ1iDGqHQhFweU3Ta/xHckGIrPiLnCQn7DgaQq+j4ZBaCHnMp4o+FBzR3niC7bIxQPBbdbK6vzjOV9GVkSdsvfh0Q==
X-Gm-Message-State: AOJu0YwpFqAHYBo+rf4o23hLFavFCPMgtOhPNQf/sKkmeKNBBU2/SHH9
	dsmrmKjL+FH3gPkSVT6kftRDQlI9iQm92Ip/n3eLDkJh7xCoQCKCQu3EruXLCwmVECJfUelTnZA
	e+gxRzrG7/H7gb4qIR49PX+u2ezWx01Llsx8=
X-Google-Smtp-Source: AGHT+IFfaIxhkpOxsCw7FpHXw46pRhJ2LVFn8Oc9SGAPdS6fH3Ze4GA/Z38ZEQQ/P5c/Ln4ZzD46j+EO0yhoyXWF64Q=
X-Received: by 2002:a05:6602:2147:b0:7de:c8c4:74d4 with SMTP id
 y7-20020a056602214700b007dec8c474d4mr184740ioy.11.1714490855767; Tue, 30 Apr
 2024 08:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 30 Apr 2024 17:27:24 +0200
Message-ID: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
Subject: [PATCH v2 2/3] iio: pressure: Add driver for Sensirion SDP500
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 6ae7537517f551540121ca6fb3b99080b7580410 Mon Sep 17 00:00:00 2001
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Mon, 15 Jan 2024 12:21:26 +0100
Subject: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500

Sensirion SDP500 is a digital differential pressure sensor. The sensor is
accessed over I2C.

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 drivers/iio/pressure/Kconfig  |   9 +++
 drivers/iio/pressure/Makefile |   1 +
 drivers/iio/pressure/sdp500.c | 144 ++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
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
index 000000000000..7efcc69e829c
--- /dev/null
+++ b/drivers/iio/pressure/sdp500.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/i2c.h>
+#include <linux/crc8.h>
+#include <linux/iio/iio.h>
+#include <asm/unaligned.h>
+
+#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normalized to 0x31)
+#define SDP500_READ_SIZE        3
+#define SDP500_CRC8_WORD_LENGTH 2
+#define SDP500_CRC8_INIT        0x00
+
+#define SDP500_SCALE_FACTOR 60
+
+#define SDP500_I2C_START_MEAS 0xF1
+
+struct sdp500_data {
+    struct device *dev;
+};
+
+DECLARE_CRC8_TABLE(sdp500_crc8_table);
+
+static int sdp500_start_measurement(struct sdp500_data *data, const
struct iio_dev *indio_dev)
+{
+    struct i2c_client *client = to_i2c_client(data->dev);
+
+    return i2c_smbus_write_byte(client, SDP500_I2C_START_MEAS);
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
+    int ret;
+    u8 rxbuf[SDP500_READ_SIZE];
+    u8 rec_crc, calculated_crc;
+    s16 dec_value;
+    struct sdp500_data *data = iio_priv(indio_dev);
+    struct i2c_client *client = to_i2c_client(data->dev);
+
+    switch (mask) {
+    case IIO_CHAN_INFO_PROCESSED:
+        ret = i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
+        if (ret < 0) {
+            dev_err(indio_dev->dev.parent, "Failed to receive data");
+            return ret;
+        }
+        if (ret != SDP500_READ_SIZE) {
+            dev_err(indio_dev->dev.parent, "Data is received wrongly");
+            return -EIO;
+        }
+
+        rec_crc = rxbuf[2];
+        calculated_crc = crc8(sdp500_crc8_table, rxbuf,
SDP500_CRC8_WORD_LENGTH,
+            SDP500_CRC8_INIT);
+        if (rec_crc != calculated_crc) {
+            dev_err(indio_dev->dev.parent, "calculated crc = 0x%.2X,
received 0x%.2X",
+                calculated_crc, rec_crc);
+            return -EIO;
+        }
+
+        dec_value = get_unaligned_be16(rxbuf);
+        dev_dbg(indio_dev->dev.parent, "dec value = %d", dec_value);
+
+        *val = dec_value;
+        *val2 = SDP500_SCALE_FACTOR;
+        return IIO_VAL_FRACTIONAL;
+    default:
+        return -EINVAL;
+    }
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
+    u8 rxbuf[SDP500_READ_SIZE];
+
+    indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+    if (!indio_dev)
+        return -ENOMEM;
+
+    /* has to be done before the first i2c communication */
+    crc8_populate_msb(sdp500_crc8_table, SDP500_CRC8_POLYNOMIAL);
+
+    data = iio_priv(indio_dev);
+    data->dev = dev;
+
+    indio_dev->name = "sdp500";
+    indio_dev->channels = sdp500_channels;
+    indio_dev->info = &sdp500_info;
+    indio_dev->modes = INDIO_DIRECT_MODE;
+    indio_dev->num_channels = ARRAY_SIZE(sdp500_channels);
+
+    ret = sdp500_start_measurement(data, indio_dev);
+    if (ret)
+        return dev_err_probe(dev, ret, "Failed to start measurement");
+    /* First measurement is not correct, read it out to get rid of it */
+    i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
+
+    ret = devm_iio_device_register(dev, indio_dev);
+    if (ret < 0)
+        return dev_err_probe(dev, ret, "Failed to register indio_dev");
+
+    return 0;
+}
+
+static const struct i2c_device_id sdp500_id[] = {
+    { "sdp500" },
+    { }
+};
+MODULE_DEVICE_TABLE(i2c, sdp500_id);
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
+    .probe       = sdp500_probe,
+    .id_table    = sdp500_id,
+};
+module_i2c_driver(sdp500_driver);
+
+MODULE_AUTHOR("Thomas Sioutas <thomas.sioutas@prodrive-technologies.com>");
+MODULE_DESCRIPTION("Driver for Sensirion SDP500 differential pressure sensor");
+MODULE_LICENSE("GPL");
-- 
2.30.2

