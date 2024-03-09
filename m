Return-Path: <linux-kernel+bounces-97862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00B87709B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B01C20B78
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21B364AB;
	Sat,  9 Mar 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="fSAs6NE9"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981C364D8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709981541; cv=none; b=FETzGTpe2FBBxXz4qcrXoAnGTxhQ3WgcyUUa2W/zq1ypND52dwmxVelQns3pJ66o5oSVrHFmmuUx65kP7mX2SLSSpltpLTAXyw5za0pul73uHZKbX6PfX/rRpN7LRbIHkPdfVGQ54Srs3pzYJzLD/th+WhG6+K6DlAFRD6Xnsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709981541; c=relaxed/simple;
	bh=8U9xUD8/iMlj+LhXvon+mi9wqGh+c7IwmOt2iACCKb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rrbg8jO/4ObbUTgiFcibIgMoZg5tGhU6Z/wVArunI/EfdBieWPLG5GJRFv2LzoiJhOFgI090B9p4FSpO964Y5EAsntWVyMlrXFJfwk7HCtV1ltw4q1pXK6WTT6q7X8O5bYMb6nHYcCDWb6cFaV0P63ZN2X1fUIM9xWnvJqwnfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=fSAs6NE9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b276979aso2110808a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 02:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709981537; x=1710586337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF+KLS27gTiTEc7clOaV7HkQyC4uYvsx4tsjI9U/ALQ=;
        b=fSAs6NE9ABMCdjudETrNgtNDrF+NSaU79AYnlRgrlldzeki4OHXz6jY0dDKGg8UtVi
         ZxXTVGgKQIcvNfvB7i54gl3ocoKyttsEG6SiLr6GcHV9V90/OncGyMrRPgdRQHtmt+k4
         fvpIyyKy6eZ9eeOT9gmE+URNFyiE3Zxexahpr6mWm/RNvoLZAxWcd9rlYjZ9QFP8OwD1
         ga2x10doB5pT6Z4MTzQKKp0hQXCZ06nRIbUG/aaQolteSalt9P+W1+mG2q9whWoI2fFI
         M7w2piWaAgvMy+83Y1xu18pkbNnOKwQL5QQKQOn7z9dCAf5ybdP/2+7Ghda1/KJnTNms
         TkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709981537; x=1710586337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF+KLS27gTiTEc7clOaV7HkQyC4uYvsx4tsjI9U/ALQ=;
        b=mUhzQuZ/Ark/Ivo1k1jE82RHv5+kx1V0Lp17zxXspaHVSBgvG3bZO/p90g6fILFCFw
         fhlF0Y5dg6KZHZkTLmWAOSiwoj2utxWqn3WWtsKSnxBe60rX738+gFa8yQQcqs8RJPUv
         EGK4hR++WGNBn+RHXvdr6LIlZOU2y6Q/nS1l+5ALEBr1I7HjkTmg/qCwnLeR6eFXsKdJ
         oN51MG7CeUPcPDgyT14+akZoqgAixW2rX84PnggotqIaFxb4PyBT/n3vTyhdnBidWdtO
         LjLyP9QPQxmf/PcpjA9+zoXHwSs+JFOx7seuIALuF37mQXxU0mmORtXulmXEus9FVbsA
         pLXg==
X-Forwarded-Encrypted: i=1; AJvYcCWqQW5JfhcY6gB/dIqcnpyPNGy2e6hBToVIAaWPixzECzfucoTJfrCPCLL6h6D0GSY/ERdbtOy3X6i4V3x/J+ATUH0ehdDiAa6kQEn7
X-Gm-Message-State: AOJu0YzDNODqGiv8U0Z6drqxHlwhswQZnZ2hPfqmnFMZt9iOCC2l8G8U
	YUp92gx5AxOqfPrVhzGF4cf1RMomX0wXwGZlauOB6MbtWNvnzK1jCvsQadQcP1U=
X-Google-Smtp-Source: AGHT+IGQ6j9qKFpa0Xb0pejijv7JIEBLljm2Kg3RRx+dKiubUKV8Zz93WFvqyd7r5p9i6eRycM7eaA==
X-Received: by 2002:a17:903:1248:b0:1d9:8832:f800 with SMTP id u8-20020a170903124800b001d98832f800mr1295835plh.8.1709981537283;
        Sat, 09 Mar 2024 02:52:17 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001dcf7d03824sm1070608plh.55.2024.03.09.02.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 02:52:16 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/5] iio: light: Add support for APDS9306 Light Sensor
Date: Sat,  9 Mar 2024 21:20:31 +1030
Message-Id: <20240309105031.10313-6-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
References: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
channel approximates the response of the human-eye providing direct
read out where the output count is proportional to ambient light levels.
It is internally temperature compensated and rejects 50Hz and 60Hz flicker
caused by artificial light sources. Hardware interrupt configuration is
optional. It is a low power device with 20 bit resolution and has
configurable adaptive interrupt mode and interrupt persistence mode.
The device also features inbuilt hardware gain, multiple integration time
selection options and sampling frequency selection options.

This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
Scales, Gains and Integration time implementation.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v8 -> v9:
 - Added const at several places as per review
 - Removed 'ret' from iio_gts_find_new_gain_by_old_gain_time()
   as it is not used. The current implementaion of the above
   function passes all my tests of changing integration times,
   scales and gains from userspace.
 - Using the same apds9306_event_spec for both als and clear channels
   struct iio_chan_spec definitions.
 - Used IIO_MOD_EVENT_CODE() macro for Intensity channel events
 - Changes as per review:
   https://lore.kernel.org/all/20240303151422.5fc3c2f2@jic23-huawei/

v7 -> v8:
 - Renamed APDS9306_INT_CH_CLEAR to APDS9306_INT_SRC_CLEAR macro for higher
   readability
 - Removed APDS9306_CHANNEL macro for higher readability
 - Updated iio_push_event() functions with correct type of events (Light or Intensity)
 - Updated variable name "event_ch_is_light" to "int_src" and change as per
   review to fix compiler warning
 - Used scope for guard() functions
 - Other fixes as per reviews
   https://lore.kernel.org/all/20240224151340.3f2f51e8@jic23-huawei/
   https://lore.kernel.org/all/ZdycR6nr3rtrnuth@smile.fi.intel.com/

v6 -> v7:
 - Made comments to struct part_id_gts_multiplier as kernel doc
 - Removed static_asserts for array sizes
 - Moved regmap_field types from driver private data structure to a new
   structure and removed regfield_ prefix to reduce names
 - Used "struct apds9306_regfields *rf = &data->rf" in the respective
   functions to reduce names
 - Removed apds9306_runtime_power_on() and apds9306_runtime_power_off()
   functions in favour of using the runtime_pm calls directly from
   calling functions.
 - Fixed indentations
   https://lore.kernel.org/all/ZcOZX8mWTozC2EAc@smile.fi.intel.com/#r

v5 -> v6:
 - Changes as per review
 - Update kernel doc for private data
 - Change IIO Event Spec definitions
 - Update guard mutex lock implementation
 - Add pm_runtime_get()
 - Update styling
   Link: https://lore.kernel.org/all/20240204134056.5dc64e8b@jic23-huawei/

v2 -> v5:
 - Removed scale attribute for Intensity channel:
   Link: https://lore.kernel.org/all/20231204095108.22f89718@jic23-huawei/

 - Dropped caching of hardware gain, repeat rate and integration time and
   updated code as per earlier reviews.
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
---
 drivers/iio/light/Kconfig    |   12 +
 drivers/iio/light/Makefile   |    1 +
 drivers/iio/light/apds9306.c | 1355 ++++++++++++++++++++++++++++++++++
 3 files changed, 1368 insertions(+)
 create mode 100644 drivers/iio/light/apds9306.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 143003232d1c..fd972dd0364d 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -73,6 +73,18 @@ config APDS9300
 	  To compile this driver as a module, choose M here: the
 	  module will be called apds9300.
 
+config APDS9306
+	tristate "Avago APDS9306 Ambient Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_GTS_HELPER
+	help
+	  If you say Y or M here, you get support for Avago APDS9306
+	  Ambient Light Sensor.
+
+	  If built as a dynamically linked module, it will be called
+	  apds9306.
+
 config APDS9960
 	tristate "Avago APDS9960 gesture/RGB/ALS/proximity sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 2e5fdb33e0e9..a30f906e91ba 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ADUX1020)		+= adux1020.o
 obj-$(CONFIG_AL3010)		+= al3010.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
+obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
 obj-$(CONFIG_AS73211)		+= as73211.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
new file mode 100644
index 000000000000..de30b1afec9a
--- /dev/null
+++ b/drivers/iio/light/apds9306.c
@@ -0,0 +1,1355 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * APDS-9306/APDS-9306-065 Ambient Light Sensor
+ * I2C Address: 0x52
+ * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
+ *
+ * Copyright (C) 2024 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/iio-gts-helper.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
+
+#include <asm/unaligned.h>
+
+#define APDS9306_MAIN_CTRL_REG		0x00
+#define APDS9306_ALS_MEAS_RATE_REG	0x04
+#define APDS9306_ALS_GAIN_REG		0x05
+#define APDS9306_PART_ID_REG		0x06
+#define APDS9306_MAIN_STATUS_REG	0x07
+#define APDS9306_CLEAR_DATA_0_REG	0x0A
+#define APDS9306_CLEAR_DATA_1_REG	0x0B
+#define APDS9306_CLEAR_DATA_2_REG	0x0C
+#define APDS9306_ALS_DATA_0_REG		0x0D
+#define APDS9306_ALS_DATA_1_REG		0x0E
+#define APDS9306_ALS_DATA_2_REG		0x0F
+#define APDS9306_INT_CFG_REG		0x19
+#define APDS9306_INT_PERSISTENCE_REG	0x1A
+#define APDS9306_ALS_THRES_UP_0_REG	0x21
+#define APDS9306_ALS_THRES_UP_1_REG	0x22
+#define APDS9306_ALS_THRES_UP_2_REG	0x23
+#define APDS9306_ALS_THRES_LOW_0_REG	0x24
+#define APDS9306_ALS_THRES_LOW_1_REG	0x25
+#define APDS9306_ALS_THRES_LOW_2_REG	0x26
+#define APDS9306_ALS_THRES_VAR_REG	0x27
+
+#define APDS9306_ALS_INT_STAT_MASK	BIT(4)
+#define APDS9306_ALS_DATA_STAT_MASK	BIT(3)
+
+#define APDS9306_ALS_THRES_VAL_MAX	(BIT(20) - 1)
+#define APDS9306_ALS_THRES_VAR_VAL_MAX	(BIT(3) - 1)
+#define APDS9306_ALS_PERSIST_VAL_MAX	(BIT(4) - 1)
+#define APDS9306_ALS_READ_DATA_DELAY_US	(20 * USEC_PER_MSEC)
+#define APDS9306_NUM_REPEAT_RATES	7
+#define APDS9306_INT_SRC_CLEAR	0
+#define APDS9306_INT_SRC_ALS	1
+#define APDS9306_SAMP_FREQ_10HZ	0
+
+/**
+ * struct part_id_gts_multiplier - Part no. and corresponding gts multiplier
+ *
+ * GTS (Gain Time Scale) are helper functions for Light sensors which along
+ * with hardware gains also has gains associated with Integration times.
+ *
+ * There are two variants of the device with slightly different characteristics,
+ * they have same ADC count for different Lux levels as mentioned in the
+ * datasheet. This multiplier array is used to store the derived Lux per count
+ * value for the two variants to be used by the GTS helper functions.
+ *
+ * @part_id: Part ID of the device
+ * @max_scale_int: Multiplier for iio_init_iio_gts()
+ * @max_scale_nano: Multiplier for iio_init_iio_gts()
+ */
+struct part_id_gts_multiplier {
+	int part_id;
+	int max_scale_int;
+	int max_scale_nano;
+};
+
+/*
+ * As per the datasheet, at HW Gain = 3x, Integration time 100mS (32x),
+ * typical 2000 ADC counts are observed for 49.8 uW per sq cm (340.134 lux)
+ * for apds9306 and 43 uW per sq cm (293.69 lux) for apds9306-065.
+ * Assuming lux per count is linear across all integration time ranges.
+ *
+ * Lux = (raw + offset) * scale; offset can be any value by userspace.
+ * HG = Hardware Gain; ITG = Gain by changing integration time.
+ * Scale table by IIO GTS Helpers = (1 / HG) * (1 / ITG) * Multiplier.
+ *
+ * The Lux values provided in the datasheet are at ITG=32x and HG=3x,
+ * at typical 2000 count for both variants of the device.
+ *
+ * Lux per ADC count at 3x and 32x for apds9306 = 340.134 / 2000
+ * Lux per ADC count at 3x and 32x for apds9306-065 = 293.69 / 2000
+ *
+ * The Multiplier for the scale table provided to userspace:
+ * IIO GTS scale Multiplier for apds9306 = (340.134 / 2000) * 32 * 3 = 16.326432
+ * and for apds9306-065 = (293.69 / 2000) * 32 * 3 = 14.09712
+ */
+static const struct part_id_gts_multiplier apds9306_gts_mul[] = {
+	{
+		.part_id = 0xB1,
+		.max_scale_int = 16,
+		.max_scale_nano = 3264320,
+	}, {
+		.part_id = 0xB3,
+		.max_scale_int = 14,
+		.max_scale_nano = 9712000,
+	},
+};
+
+static const int apds9306_repeat_rate_freq[APDS9306_NUM_REPEAT_RATES][2] = {
+	{ 40, 0 },
+	{ 20, 0 },
+	{ 10, 0 },
+	{ 5,  0 },
+	{ 2,  0 },
+	{ 1,  0 },
+	{ 0,  500000 },
+};
+
+static const int apds9306_repeat_rate_period[APDS9306_NUM_REPEAT_RATES] = {
+	25000, 50000, 100000, 200000, 500000, 1000000, 2000000,
+};
+
+/**
+ * struct apds9306_regfields - apds9306 regmap fields definitions
+ *
+ * @sw_reset: Software reset regfield
+ * @en: Enable regfield
+ * @intg_time: Resolution regfield
+ * @repeat_rate: Measurement Rate regfield
+ * @gain: Hardware gain regfield
+ * @int_src: Interrupt channel regfield
+ * @int_thresh_var_en: Interrupt variance threshold regfield
+ * @int_en: Interrupt enable regfield
+ * @int_persist_val: Interrupt persistence regfield
+ * @int_thresh_var_val: Interrupt threshold variance value regfield
+ */
+struct apds9306_regfields {
+	struct regmap_field *sw_reset;
+	struct regmap_field *en;
+	struct regmap_field *intg_time;
+	struct regmap_field *repeat_rate;
+	struct regmap_field *gain;
+	struct regmap_field *int_src;
+	struct regmap_field *int_thresh_var_en;
+	struct regmap_field *int_en;
+	struct regmap_field *int_persist_val;
+	struct regmap_field *int_thresh_var_val;
+};
+
+/**
+ * struct apds9306_data - apds9306 private data and registers definitions
+ *
+ * @dev: Pointer to the device structure
+ * @gts: IIO Gain Time Scale structure
+ * @mutex: Lock for protecting adc reads, device settings changes where
+ *         some calculations are required before or after setting or
+ *         getting the raw settings values from regmap writes or reads
+ *         respectively.
+ * @regmap: Regmap structure pointer
+ * @rf: Regmap register fields structure
+ * @nlux_per_count: Nano lux per ADC count for a particular model
+ * @read_data_available: Flag set by IRQ handler for ADC data available
+ */
+struct apds9306_data {
+	struct device *dev;
+	struct iio_gts gts;
+
+	struct mutex mutex;
+
+	struct regmap *regmap;
+	struct apds9306_regfields rf;
+
+	int nlux_per_count;
+	int read_data_available;
+};
+
+/*
+ * Available scales with gain 1x - 18x, timings 3.125, 25, 50, 100, 200, 400 ms
+ * Time impacts to gain: 1x, 8x, 16x, 32x, 64x, 128x
+ */
+#define APDS9306_GSEL_1X	0x00
+#define APDS9306_GSEL_3X	0x01
+#define APDS9306_GSEL_6X	0x02
+#define APDS9306_GSEL_9X	0x03
+#define APDS9306_GSEL_18X	0x04
+
+static const struct iio_gain_sel_pair apds9306_gains[] = {
+	GAIN_SCALE_GAIN(1, APDS9306_GSEL_1X),
+	GAIN_SCALE_GAIN(3, APDS9306_GSEL_3X),
+	GAIN_SCALE_GAIN(6, APDS9306_GSEL_6X),
+	GAIN_SCALE_GAIN(9, APDS9306_GSEL_9X),
+	GAIN_SCALE_GAIN(18, APDS9306_GSEL_18X),
+};
+
+#define APDS9306_MEAS_MODE_400MS	0x00
+#define APDS9306_MEAS_MODE_200MS	0x01
+#define APDS9306_MEAS_MODE_100MS	0x02
+#define APDS9306_MEAS_MODE_50MS		0x03
+#define APDS9306_MEAS_MODE_25MS		0x04
+#define APDS9306_MEAS_MODE_3125US	0x05
+
+static const struct iio_itime_sel_mul apds9306_itimes[] = {
+	GAIN_SCALE_ITIME_US(400000, APDS9306_MEAS_MODE_400MS, BIT(7)),
+	GAIN_SCALE_ITIME_US(200000, APDS9306_MEAS_MODE_200MS, BIT(6)),
+	GAIN_SCALE_ITIME_US(100000, APDS9306_MEAS_MODE_100MS, BIT(5)),
+	GAIN_SCALE_ITIME_US(50000, APDS9306_MEAS_MODE_50MS, BIT(4)),
+	GAIN_SCALE_ITIME_US(25000, APDS9306_MEAS_MODE_25MS, BIT(3)),
+	GAIN_SCALE_ITIME_US(3125, APDS9306_MEAS_MODE_3125US, BIT(0)),
+};
+
+static const struct iio_event_spec apds9306_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec apds9306_channels_with_events[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = apds9306_event_spec,
+		.num_event_specs = ARRAY_SIZE(apds9306_event_spec),
+	}, {
+		.type = IIO_INTENSITY,
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.modified = 1,
+		.event_spec = apds9306_event_spec,
+		.num_event_specs = ARRAY_SIZE(apds9306_event_spec),
+	},
+};
+
+static const struct iio_chan_spec apds9306_channels_without_events[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_INTENSITY,
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.modified = 1,
+	},
+};
+
+/* INT_PERSISTENCE available */
+static IIO_CONST_ATTR(thresh_either_period_available, "[0 1 15]");
+
+/* ALS_THRESH_VAR available */
+static IIO_CONST_ATTR(thresh_adaptive_either_values_available, "[0 1 7]");
+
+static struct attribute *apds9306_event_attributes[] = {
+	&iio_const_attr_thresh_either_period_available.dev_attr.attr,
+	&iio_const_attr_thresh_adaptive_either_values_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group apds9306_event_attr_group = {
+	.attrs = apds9306_event_attributes,
+};
+
+static const struct regmap_range apds9306_readable_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_CTRL_REG, APDS9306_ALS_THRES_VAR_REG)
+};
+
+static const struct regmap_range apds9306_writable_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_CTRL_REG, APDS9306_ALS_GAIN_REG),
+	regmap_reg_range(APDS9306_INT_CFG_REG, APDS9306_ALS_THRES_VAR_REG)
+};
+
+static const struct regmap_range apds9306_volatile_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_STATUS_REG, APDS9306_MAIN_STATUS_REG),
+	regmap_reg_range(APDS9306_CLEAR_DATA_0_REG, APDS9306_ALS_DATA_2_REG)
+};
+
+static const struct regmap_range apds9306_precious_ranges[] = {
+	regmap_reg_range(APDS9306_MAIN_STATUS_REG, APDS9306_MAIN_STATUS_REG)
+};
+
+static const struct regmap_access_table apds9306_readable_table = {
+	.yes_ranges = apds9306_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_readable_ranges)
+};
+
+static const struct regmap_access_table apds9306_writable_table = {
+	.yes_ranges = apds9306_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_writable_ranges)
+};
+
+static const struct regmap_access_table apds9306_volatile_table = {
+	.yes_ranges = apds9306_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_volatile_ranges)
+};
+
+static const struct regmap_access_table apds9306_precious_table = {
+	.yes_ranges = apds9306_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9306_precious_ranges)
+};
+
+static const struct regmap_config apds9306_regmap = {
+	.name = "apds9306_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &apds9306_readable_table,
+	.wr_table = &apds9306_writable_table,
+	.volatile_table = &apds9306_volatile_table,
+	.precious_table = &apds9306_precious_table,
+	.max_register = APDS9306_ALS_THRES_VAR_REG,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct reg_field apds9306_rf_sw_reset =
+	REG_FIELD(APDS9306_MAIN_CTRL_REG, 4, 4);
+
+static const struct reg_field apds9306_rf_en =
+	REG_FIELD(APDS9306_MAIN_CTRL_REG, 1, 1);
+
+static const struct reg_field apds9306_rf_intg_time =
+	REG_FIELD(APDS9306_ALS_MEAS_RATE_REG, 4, 6);
+
+static const struct reg_field apds9306_rf_repeat_rate =
+	REG_FIELD(APDS9306_ALS_MEAS_RATE_REG, 0, 2);
+
+static const struct reg_field apds9306_rf_gain =
+	REG_FIELD(APDS9306_ALS_GAIN_REG, 0, 2);
+
+static const struct reg_field apds9306_rf_int_src =
+	REG_FIELD(APDS9306_INT_CFG_REG, 4, 5);
+
+static const struct reg_field apds9306_rf_int_thresh_var_en =
+	REG_FIELD(APDS9306_INT_CFG_REG, 3, 3);
+
+static const struct reg_field apds9306_rf_int_en =
+	REG_FIELD(APDS9306_INT_CFG_REG, 2, 2);
+
+static const struct reg_field apds9306_rf_int_persist_val =
+	REG_FIELD(APDS9306_INT_PERSISTENCE_REG, 4, 7);
+
+static const struct reg_field apds9306_rf_int_thresh_var_val =
+	REG_FIELD(APDS9306_ALS_THRES_VAR_REG, 0, 2);
+
+static int apds9306_regfield_init(struct apds9306_data *data)
+{
+	struct device *dev = data->dev;
+	struct regmap *regmap = data->regmap;
+	struct regmap_field *tmp;
+	struct apds9306_regfields *rf = &data->rf;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_sw_reset);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->sw_reset = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_en);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->en = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_intg_time);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->intg_time = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_repeat_rate);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->repeat_rate = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_gain);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->gain = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_int_src);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->int_src = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_int_thresh_var_en);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->int_thresh_var_en = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_int_en);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->int_en = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_int_persist_val);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->int_persist_val = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9306_rf_int_thresh_var_val);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	rf->int_thresh_var_val = tmp;
+
+	return 0;
+}
+
+static int apds9306_power_state(struct apds9306_data *data, bool state)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int ret;
+
+	/* Reset not included as it causes ugly I2C bus error */
+	if (state) {
+		ret = regmap_field_write(rf->en, 1);
+		if (ret)
+			return ret;
+		/* 5ms wake up time */
+		fsleep(5000);
+		return 0;
+	}
+
+	return regmap_field_write(rf->en, 0);
+}
+
+static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
+{
+	struct device *dev = data->dev;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct apds9306_regfields *rf = &data->rf;
+	u64 ev_code;
+	int ret, delay, intg_time, intg_time_idx, repeat_rate_idx, int_src;
+	int status = 0;
+	u8 buff[3];
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(rf->repeat_rate, &repeat_rate_idx);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(rf->int_src, &int_src);
+	if (ret)
+		return ret;
+
+	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
+	if (intg_time < 0)
+		return intg_time;
+
+	/* Whichever is greater - integration time period or sampling period. */
+	delay = max(intg_time, apds9306_repeat_rate_period[repeat_rate_idx]);
+
+	/*
+	 * Clear stale data flag that might have been set by the interrupt
+	 * handler if it got data available flag set in the status reg.
+	 */
+	data->read_data_available = 0;
+
+	/*
+	 * If this function runs parallel with the interrupt handler, either
+	 * this reads and clears the status registers or the interrupt handler
+	 * does. The interrupt handler sets a flag for read data available
+	 * in our private structure which we read here.
+	 */
+	ret = regmap_read_poll_timeout(data->regmap, APDS9306_MAIN_STATUS_REG,
+				       status, data->read_data_available ||
+				       (status & (APDS9306_ALS_DATA_STAT_MASK |
+						  APDS9306_ALS_INT_STAT_MASK)),
+				       APDS9306_ALS_READ_DATA_DELAY_US, delay * 2);
+	if (ret)
+		return ret;
+
+	/* If we reach here before the interrupt handler we push an event */
+	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
+		if (int_src == APDS9306_INT_SRC_ALS)
+			ev_code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+						       IIO_EV_TYPE_THRESH,
+						       IIO_EV_DIR_EITHER);
+		else
+			ev_code = IIO_MOD_EVENT_CODE(IIO_INTENSITY, 0,
+						     IIO_MOD_LIGHT_CLEAR,
+						     IIO_EV_TYPE_THRESH,
+						     IIO_EV_DIR_EITHER);
+
+		iio_push_event(indio_dev, ev_code, iio_get_time_ns(indio_dev));
+	}
+
+	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
+	if (ret) {
+		dev_err_ratelimited(dev, "read data failed\n");
+		return ret;
+	}
+
+	*val = get_unaligned_le24(&buff);
+
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return 0;
+}
+
+static int apds9306_intg_time_get(struct apds9306_data *data, int *val2)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int ret, intg_time_idx;
+
+	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
+	if (ret)
+		return ret;
+
+	ret = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
+	if (ret < 0)
+		return ret;
+
+	*val2 = ret;
+
+	return 0;
+}
+
+static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
+{
+	struct device *dev = data->dev;
+	struct apds9306_regfields *rf = &data->rf;
+	int ret, intg_old, gain_old, gain_new, gain_new_closest, intg_time_idx;
+	int gain_idx;
+	bool ok;
+
+	if (!iio_gts_valid_time(&data->gts, val2)) {
+		dev_err_ratelimited(dev, "Unsupported integration time %u\n", val2);
+		return -EINVAL;
+	}
+
+	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(rf->gain, &gain_idx);
+	if (ret)
+		return ret;
+
+	intg_old = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
+	if (ret < 0)
+		return ret;
+
+	if (intg_old == val2)
+		return 0;
+
+	gain_old = iio_gts_find_gain_by_sel(&data->gts, gain_idx);
+	if (gain_old < 0)
+		return gain_old;
+
+	iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old, intg_old,
+					       val2, &gain_new);
+
+	if (gain_new < 0) {
+		dev_err_ratelimited(dev, "Unsupported gain with time\n");
+		return gain_new;
+	}
+
+	gain_new_closest = iio_find_closest_gain_low(&data->gts, gain_new, &ok);
+	if (gain_new_closest < 0) {
+		gain_new_closest = iio_gts_get_min_gain(&data->gts);
+		if (gain_new_closest < 0)
+			return gain_new_closest;
+	}
+	if (!ok)
+		dev_dbg(dev, "Unable to find optimum gain, setting minimum");
+
+	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_field_write(rf->intg_time, ret);
+	if (ret)
+		return ret;
+
+	ret = iio_gts_find_sel_by_gain(&data->gts, gain_new_closest);
+	if (ret < 0)
+		return ret;
+
+	return regmap_field_write(rf->gain, ret);
+}
+
+static int apds9306_sampling_freq_get(struct apds9306_data *data, int *val,
+				      int *val2)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int ret, repeat_rate_idx;
+
+	ret = regmap_field_read(rf->repeat_rate, &repeat_rate_idx);
+	if (ret)
+		return ret;
+
+	if (repeat_rate_idx > ARRAY_SIZE(apds9306_repeat_rate_freq))
+		return -EINVAL;
+
+	*val = apds9306_repeat_rate_freq[repeat_rate_idx][0];
+	*val2 = apds9306_repeat_rate_freq[repeat_rate_idx][1];
+
+	return 0;
+}
+
+static int apds9306_sampling_freq_set(struct apds9306_data *data, int val,
+				      int val2)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++) {
+		if (apds9306_repeat_rate_freq[i][0] == val &&
+		    apds9306_repeat_rate_freq[i][1] == val2)
+			return regmap_field_write(rf->repeat_rate, i);
+	}
+
+	return -EINVAL;
+}
+
+static int apds9306_scale_get(struct apds9306_data *data, int *val, int *val2)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int gain, intg, ret, intg_time_idx, gain_idx;
+
+	ret = regmap_field_read(rf->gain, &gain_idx);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
+	if (ret)
+		return ret;
+
+	gain = iio_gts_find_gain_by_sel(&data->gts, gain_idx);
+	if (gain < 0)
+		return gain;
+
+	intg = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
+	if (intg < 0)
+		return intg;
+
+	return iio_gts_get_scale(&data->gts, gain, intg, val, val2);
+}
+
+static int apds9306_scale_set(struct apds9306_data *data, int val, int val2)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int i, ret, time_sel, gain_sel, intg_time_idx;
+
+	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
+	if (ret)
+		return ret;
+
+	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
+					intg_time_idx, val, val2, &gain_sel);
+	if (ret) {
+		for (i = 0; i < data->gts.num_itime; i++) {
+			time_sel = data->gts.itime_table[i].sel;
+
+			if (time_sel == intg_time_idx)
+				continue;
+
+			ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
+						time_sel, val, val2, &gain_sel);
+			if (!ret)
+				break;
+		}
+		if (ret)
+			return -EINVAL;
+
+		ret = regmap_field_write(rf->intg_time, time_sel);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_field_write(rf->gain, gain_sel);
+}
+
+static int apds9306_event_period_get(struct apds9306_data *data, int *val)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int period, ret;
+
+	ret = regmap_field_read(rf->int_persist_val, &period);
+	if (ret)
+		return ret;
+
+	if (!in_range(period, 0, APDS9306_ALS_PERSIST_VAL_MAX))
+		return -EINVAL;
+
+	*val = period;
+
+	return ret;
+}
+
+static int apds9306_event_period_set(struct apds9306_data *data, int val)
+{
+	struct apds9306_regfields *rf = &data->rf;
+
+	if (!in_range(val, 0, APDS9306_ALS_PERSIST_VAL_MAX))
+		return -EINVAL;
+
+	return regmap_field_write(rf->int_persist_val, val);
+}
+
+static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
+				     int *val)
+{
+	int var, ret;
+	u8 buff[3];
+
+	if (dir == IIO_EV_DIR_RISING)
+		var = APDS9306_ALS_THRES_UP_0_REG;
+	else if (dir == IIO_EV_DIR_FALLING)
+		var = APDS9306_ALS_THRES_LOW_0_REG;
+	else
+		return -EINVAL;
+
+	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_le24(&buff);
+
+	return 0;
+}
+
+static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
+				     int val)
+{
+	int var;
+	u8 buff[3];
+
+	if (dir == IIO_EV_DIR_RISING)
+		var = APDS9306_ALS_THRES_UP_0_REG;
+	else if (dir == IIO_EV_DIR_FALLING)
+		var = APDS9306_ALS_THRES_LOW_0_REG;
+	else
+		return -EINVAL;
+
+	if (!in_range(val, 0, APDS9306_ALS_THRES_VAL_MAX))
+		return -EINVAL;
+
+	put_unaligned_le24(val, buff);
+
+	return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
+}
+
+static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data, int *val)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int thr_adpt, ret;
+
+	ret = regmap_field_read(rf->int_thresh_var_val, &thr_adpt);
+	if (ret)
+		return ret;
+
+	if (!in_range(thr_adpt, 0, APDS9306_ALS_THRES_VAR_VAL_MAX))
+		return -EINVAL;
+
+	*val = thr_adpt;
+
+	return ret;
+}
+
+static int apds9306_event_thresh_adaptive_set(struct apds9306_data *data, int val)
+{
+	struct apds9306_regfields *rf = &data->rf;
+
+	if (!in_range(val, 0, APDS9306_ALS_THRES_VAR_VAL_MAX))
+		return -EINVAL;
+
+	return regmap_field_write(rf->int_thresh_var_val, val);
+}
+
+static int apds9306_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret, reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
+			reg = APDS9306_CLEAR_DATA_0_REG;
+		else
+			reg = APDS9306_ALS_DATA_0_REG;
+		/*
+		 * Changing device parameters during adc operation, resets
+		 * the ADC which has to avoided.
+		 */
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = apds9306_read_data(data, val, reg);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = apds9306_intg_time_get(data, val2);
+		if (ret)
+			return ret;
+		*val = 0;
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = apds9306_sampling_freq_get(data, val, val2);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SCALE:
+		ret = apds9306_scale_get(data, val, val2);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+};
+
+static int apds9306_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return iio_gts_avail_times(&data->gts, vals, type, length);
+	case IIO_CHAN_INFO_SCALE:
+		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(apds9306_repeat_rate_freq) * 2;
+		*vals = (const int *)apds9306_repeat_rate_freq;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9306_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9306_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val)
+			return -EINVAL;
+		return apds9306_intg_time_set(data, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return apds9306_scale_set(data, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return apds9306_sampling_freq_set(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t apds9306_irq_handler(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct apds9306_data *data = iio_priv(indio_dev);
+	struct apds9306_regfields *rf = &data->rf;
+	u64 ev_code;
+	int ret, status, int_src;
+
+	/*
+	 * The interrupt line is released and the interrupt flag is
+	 * cleared as a result of reading the status register. All the
+	 * status flags are cleared as a result of this read.
+	 */
+	ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS_REG, &status);
+	if (ret < 0) {
+		dev_err_ratelimited(data->dev, "status reg read failed\n");
+		return IRQ_HANDLED;
+	}
+
+	ret = regmap_field_read(rf->int_src, &int_src);
+	if (ret)
+		return ret;
+
+	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
+		if (int_src == APDS9306_INT_SRC_ALS)
+			ev_code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+						       IIO_EV_TYPE_THRESH,
+						       IIO_EV_DIR_EITHER);
+		else
+			ev_code = IIO_MOD_EVENT_CODE(IIO_INTENSITY, 0,
+						     IIO_MOD_LIGHT_CLEAR,
+						     IIO_EV_TYPE_THRESH,
+						     IIO_EV_DIR_EITHER);
+
+		iio_push_event(indio_dev, ev_code, iio_get_time_ns(indio_dev));
+	}
+
+	/*
+	 * If a one-shot read through sysfs is underway at the same time
+	 * as this interrupt handler is executing and a read data available
+	 * flag was set, this flag is set to inform read_poll_timeout()
+	 * to exit.
+	 */
+	if ((status & APDS9306_ALS_DATA_STAT_MASK))
+		data->read_data_available = 1;
+
+	return IRQ_HANDLED;
+}
+
+static int apds9306_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
+			ret = apds9306_event_period_get(data, val);
+		else
+			ret = apds9306_event_thresh_get(data, dir, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = apds9306_event_thresh_adaptive_get(data, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9306_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
+			return apds9306_event_period_set(data, val);
+
+		return apds9306_event_thresh_set(data, dir, val);
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		return apds9306_event_thresh_adaptive_set(data, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9306_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	struct apds9306_regfields *rf = &data->rf;
+	int int_en, int_src, ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH: {
+		guard(mutex)(&data->mutex);
+
+		ret = regmap_field_read(rf->int_src, &int_src);
+		if (ret)
+			return ret;
+
+		ret = regmap_field_read(rf->int_en, &int_en);
+		if (ret)
+			return ret;
+
+		if (chan->type == IIO_LIGHT)
+			return int_en && (int_src == APDS9306_INT_SRC_ALS);
+
+		if (chan->type == IIO_INTENSITY)
+			return int_en && (int_src == APDS9306_INT_SRC_CLEAR);
+
+		return -EINVAL;
+	}
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		ret = regmap_field_read(rf->int_thresh_var_en, &int_en);
+		if (ret)
+			return ret;
+
+		return int_en;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9306_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       int state)
+{
+	struct apds9306_data *data = iio_priv(indio_dev);
+	struct apds9306_regfields *rf = &data->rf;
+	int ret, val;
+
+	state = !!state;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH: {
+		guard(mutex)(&data->mutex);
+
+		/*
+		 * If interrupt is enabled, the channel is set before enabling
+		 * the interrupt. In case of disable, no need to switch
+		 * channels. In case of different channel is selected while
+		 * interrupt in on, just change the channel.
+		 */
+		if (state) {
+			if (chan->type == IIO_LIGHT)
+				val = 1;
+			else if (chan->type == IIO_INTENSITY)
+				val = 0;
+			else
+				return -EINVAL;
+
+			ret = regmap_field_write(rf->int_src, val);
+			if (ret)
+				return ret;
+		}
+
+		ret = regmap_field_read(rf->int_en, &val);
+		if (ret)
+			return ret;
+
+		if (val == state)
+			return 0;
+
+		ret = regmap_field_write(rf->int_en, state);
+		if (ret)
+			return ret;
+
+		if (state)
+			return pm_runtime_resume_and_get(data->dev);
+
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
+
+		return 0;
+	}
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		return regmap_field_write(rf->int_thresh_var_en, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info apds9306_info_no_events = {
+	.read_avail = apds9306_read_avail,
+	.read_raw = apds9306_read_raw,
+	.write_raw = apds9306_write_raw,
+	.write_raw_get_fmt = apds9306_write_raw_get_fmt,
+};
+
+static const struct iio_info apds9306_info = {
+	.read_avail = apds9306_read_avail,
+	.read_raw = apds9306_read_raw,
+	.write_raw = apds9306_write_raw,
+	.write_raw_get_fmt = apds9306_write_raw_get_fmt,
+	.read_event_value = apds9306_read_event,
+	.write_event_value = apds9306_write_event,
+	.read_event_config = apds9306_read_event_config,
+	.write_event_config = apds9306_write_event_config,
+	.event_attrs = &apds9306_event_attr_group,
+};
+
+static int apds9306_init_iio_gts(struct apds9306_data *data)
+{
+	int i, ret, part_id;
+
+	ret = regmap_read(data->regmap, APDS9306_PART_ID_REG, &part_id);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(apds9306_gts_mul); i++)
+		if (part_id == apds9306_gts_mul[i].part_id)
+			break;
+
+	if (i == ARRAY_SIZE(apds9306_gts_mul))
+		return -ENOENT;
+
+	return devm_iio_init_iio_gts(data->dev,
+				     apds9306_gts_mul[i].max_scale_int,
+				     apds9306_gts_mul[i].max_scale_nano,
+				     apds9306_gains, ARRAY_SIZE(apds9306_gains),
+				     apds9306_itimes, ARRAY_SIZE(apds9306_itimes),
+				     &data->gts);
+}
+
+static void apds9306_powerdown(void *ptr)
+{
+	struct apds9306_data *data = (struct apds9306_data *)ptr;
+	struct apds9306_regfields *rf = &data->rf;
+	int ret;
+
+	ret = regmap_field_write(rf->int_thresh_var_en, 0);
+	if (ret)
+		return;
+
+	ret = regmap_field_write(rf->int_en, 0);
+	if (ret)
+		return;
+
+	apds9306_power_state(data, false);
+}
+
+static int apds9306_device_init(struct apds9306_data *data)
+{
+	struct apds9306_regfields *rf = &data->rf;
+	int ret;
+
+	ret = apds9306_init_iio_gts(data);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(rf->intg_time, APDS9306_MEAS_MODE_100MS);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(rf->repeat_rate, APDS9306_SAMP_FREQ_10HZ);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(rf->gain, APDS9306_GSEL_3X);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(rf->int_src, APDS9306_INT_SRC_ALS);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(rf->int_en, 0);
+	if (ret)
+		return ret;
+
+	return regmap_field_write(rf->int_thresh_var_en, 0);
+}
+
+static int apds9306_pm_init(struct apds9306_data *data)
+{
+	struct device *dev = data->dev;
+	int ret;
+
+	ret = apds9306_power_state(data, true);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, 5000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_get(dev);
+
+	return 0;
+}
+
+static int apds9306_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct apds9306_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	mutex_init(&data->mutex);
+
+	data->regmap = devm_regmap_init_i2c(client, &apds9306_regmap);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "regmap initialization failed\n");
+
+	data->dev = dev;
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = apds9306_regfield_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "regfield initialization failed\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	indio_dev->name = "apds9306";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (client->irq) {
+		indio_dev->info = &apds9306_info;
+		indio_dev->channels = apds9306_channels_with_events;
+		indio_dev->num_channels = ARRAY_SIZE(apds9306_channels_with_events);
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						apds9306_irq_handler, IRQF_ONESHOT,
+						"apds9306_event", indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to assign interrupt.\n");
+	} else {
+		indio_dev->info = &apds9306_info_no_events;
+		indio_dev->channels = apds9306_channels_without_events;
+		indio_dev->num_channels =
+				ARRAY_SIZE(apds9306_channels_without_events);
+	}
+
+	ret = apds9306_pm_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed pm init\n");
+
+	ret = apds9306_device_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init device\n");
+
+	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action or reset\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed iio device registration\n");
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int apds9306_runtime_suspend(struct device *dev)
+{
+	struct apds9306_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return apds9306_power_state(data, false);
+}
+
+static int apds9306_runtime_resume(struct device *dev)
+{
+	struct apds9306_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return apds9306_power_state(data, true);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops,
+				 apds9306_runtime_suspend,
+				 apds9306_runtime_resume,
+				 NULL);
+
+static const struct of_device_id apds9306_of_match[] = {
+	{ .compatible = "avago,apds9306" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apds9306_of_match);
+
+static struct i2c_driver apds9306_driver = {
+	.driver = {
+		.name = "apds9306",
+		.pm = pm_ptr(&apds9306_pm_ops),
+		.of_match_table = apds9306_of_match,
+	},
+	.probe = apds9306_probe,
+};
+module_i2c_driver(apds9306_driver);
+
+MODULE_AUTHOR("Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>");
+MODULE_DESCRIPTION("APDS9306 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_GTS_HELPER);
-- 
2.34.1


