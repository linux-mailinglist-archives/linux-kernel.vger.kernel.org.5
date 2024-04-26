Return-Path: <linux-kernel+bounces-160101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E688B391F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9352819A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD514B093;
	Fri, 26 Apr 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3iLN1TX"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1C149C5E;
	Fri, 26 Apr 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139638; cv=none; b=UJD32aGp7Lxq4MfxNVs+vkUGOXyR/izEhuG0X7LWRmyg2YFEXFGcUGyw+koe9Ai7PKX2zHCK36F5MsApwCoKoLnjzo+bCarauaeoZLlK2dPIbxGmhPau35k2AP8Mwum6LiQUxPWeKXtf8KHWWonJz+Tkf1iyphoC/Z1w7BcJT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139638; c=relaxed/simple;
	bh=rJtXjKg6ZWI5a7lo6Xd17omcsIy+jBYVKlQfUedFurM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQuMynNGpkrLP51p5PPMEItad4oKSeojvFg/yKFgGPRyfGJBmSRonE8xgAT/hUV5p2C3cJiyo7qHubrDOFY+0SnDNeQE04EB2maYzSTikgQv4oA9M0Gg2n1X1BN7aytUIou6CvKIivkKF3pQp89KS3Q//1xWyjUoC1X9RYcnAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3iLN1TX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dd041acff1so24883271fa.1;
        Fri, 26 Apr 2024 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139634; x=1714744434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/LeaNjTWEUw5QtbBfyzBktuvZcdWjgMJOzSv2xaVgQ=;
        b=G3iLN1TXyOME9TzjdcsEVzjXD51RrdwcOL4mUIPDllK6G5F2JIbl8ETV+IEOBKCzHg
         7tQrC8639pkD1/RXxWci3XPQArXffacjKrPRnC1Uqn4jcsQENGDPB3oABsMFFaO8XXmt
         sAO+Bk0LvqjJ738YMKxY9cHPsORVtkHPVOC8TNvBdMa8+hdl5vUZpMDBYYaTGXhl4jZZ
         jBhmbT6+qyvxvsbED8EYWdvFALjwmfcOKpEpWTHRJxKwqW89aE988XndyV4SCHh+wn/5
         zsHkGn9vcI/wC+p+RQdHwclAnsShOXwT39cqgOQPLuIVrcwbZynyNPTklr/itW2ifmab
         SHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139634; x=1714744434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/LeaNjTWEUw5QtbBfyzBktuvZcdWjgMJOzSv2xaVgQ=;
        b=ep+NCGO3qpJlFmTPriZSJQmVIsDLpapreFn0yz3isbwp3x4QO/ZrFVWgyhQSh8+qH5
         6vMp7kEG/0VNszzMcVSEZa5fmsXvWIpwTgI6R9woayVOwgN/WDwEzCnHOVSvNOp82Stc
         hiUB8iI3dZYTkzGUuVPN2sU6/v5NYGyIpgkmA/aO0eVvxbQp10BX0xC6cRkdfEevEf32
         cif2G+Kz88PuMRJPI7e+0e67iCsKYn3cb+Cbnds7dfGxtpotMpcEaEgRlpSjtoLUsVfh
         7hc4mQNkfauHFeNk9/Xm1Kf4icmex/Bo7sg9LQMGtbLnS8uW6H2znEpIK6pyXVnl5EC6
         6ytg==
X-Forwarded-Encrypted: i=1; AJvYcCXGuSHQODdF9YzwdhsdmRVmfdSA6lrwoO+4S7UUDuNTBbrKZQv58FsZ7mn0lr46TbuwoUEjUWgveZpXF1fh4VxvN34UtD4Mrx8UQ5b2IEhIbcZ+t1z4O+4Rk1h9UI/3MA6vFas5Ag==
X-Gm-Message-State: AOJu0Yw2v2FIpAcnKsaFFVXo4iDtuo+/7x9N6SrPDU7gjmrwrCzGFwAA
	mrEZm2GOzZGjhC5MXPbOTMAtt0BdN79glE9nsXKE7T6JoSRmWXMA6B/1N2Pc
X-Google-Smtp-Source: AGHT+IHcqQZY6kCnPEwFlENRusJNjO0vmGYjYddT0dYcsiyirDxc6xCBiVdL2nOCFIo0tjE4Mj3DFA==
X-Received: by 2002:a2e:94c3:0:b0:2da:e7f7:7315 with SMTP id r3-20020a2e94c3000000b002dae7f77315mr1635334ljh.45.1714139633468;
        Fri, 26 Apr 2024 06:53:53 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:f4f8:b5e1:d7d4:bf65])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm22302919wri.95.2024.04.26.06.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:53 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH 7/7] drivers: iio: imu: Add support for adis1657x family
Date: Fri, 26 Apr 2024 16:53:39 +0300
Message-Id: <20240426135339.185602-8-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ADIS1657X family devices in already exiting ADIS16475
driver.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
 drivers/iio/imu/adis16475.c | 536 +++++++++++++++++++++++++++++++++---
 1 file changed, 499 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 7cfef553f298..c759ec456258 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -14,6 +14,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/imu/adis.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/irq.h>
 #include <linux/lcm.h>
@@ -52,6 +53,8 @@
 				FIELD_PREP(ADIS16475_MSG_CTRL_DR_POL_MASK, x)
 #define ADIS16475_SYNC_MODE_MASK	GENMASK(4, 2)
 #define ADIS16475_SYNC_MODE(x)		FIELD_PREP(ADIS16475_SYNC_MODE_MASK, x)
+#define ADIS16475_SYNC_4KHZ_MASK	BIT(11)
+#define ADIS16475_SYNC_4KHZ(x)		FIELD_PREP(ADIS16475_SYNC_4KHZ_MASK, x)
 #define ADIS16475_REG_UP_SCALE		0x62
 #define ADIS16475_REG_DEC_RATE		0x64
 #define ADIS16475_REG_GLOB_CMD		0x68
@@ -66,14 +69,31 @@
 #define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BURST32_MASK, x)
 /* number of data elements in burst mode */
 #define ADIS16475_BURST32_MAX_DATA	32
+#define ADIS16575_BURST32_MAX_DATA	34
 #define ADIS16475_BURST_MAX_DATA	20
 #define ADIS16475_MAX_SCAN_DATA		20
 /* spi max speed in brust mode */
 #define ADIS16475_BURST_MAX_SPEED	1000000
+#define ADIS16575_BURST_MAX_SPEED	8000000
 #define ADIS16475_LSB_DEC_MASK		0
 #define ADIS16475_LSB_FIR_MASK		1
 #define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
 #define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(12, 7)
+#define ADIS16475_MAX_FIFO_WM		511
+#define ADIS16475_REG_FIFO_CTRL		0x5A
+#define ADIS16475_WM_LVL_MASK		GENMASK(15, 4)
+#define ADIS16475_WM_LVL(x)		FIELD_PREP(ADIS16475_WM_LVL_MASK, x)
+#define ADIS16475_WM_POL_MASK		BIT(3)
+#define ADIS16475_WM_POL(x)		FIELD_PREP(ADIS16475_WM_POL_MASK, x)
+#define ADIS16475_WM_EN_MASK		BIT(2)
+#define ADIS16475_WM_EN(x)		FIELD_PREP(ADIS16475_WM_EN_MASK, x)
+#define ADIS16475_OVERFLOW_MASK		BIT(1)
+#define ADIS16475_STOP_ENQUEUE		FIELD_PREP(ADIS16475_OVERFLOW_MASK, 0)
+#define ADIS16475_OVERWRITE_OLDEST	FIELD_PREP(ADIS16475_OVERFLOW_MASK, 1)
+#define ADIS16475_FIFO_EN_MASK		BIT(0)
+#define ADIS16475_FIFO_EN(x)		FIELD_PREP(ADIS16475_FIFO_EN_MASK, x)
+#define ADIS16475_FIFO_FLUSH_CMD	BIT(5)
+#define ADIS16475_REG_FIFO_CNT		0x3C
 
 enum {
 	ADIS16475_SYNC_DIRECT = 1,
@@ -95,6 +115,9 @@ struct adis16475_chip_info {
 	const char *name;
 #define ADIS16475_HAS_BURST32		BIT(0)
 #define ADIS16475_HAS_BURST_DELTA_DATA	BIT(1)
+#define ADIS16475_HAS_TIMESTAMP32	BIT(2)
+#define ADIS16475_NEEDS_BURST_REQUEST	BIT(3)
+#define ADIS16475_HAS_FIFO		BIT(4)
 	const long flags;
 	u32 num_channels;
 	u32 gyro_max_val;
@@ -116,6 +139,7 @@ struct adis16475 {
 	bool burst32;
 	unsigned long lsb_flag;
 	u16 sync_mode;
+	u16 fifo_watermark;
 	/* Alignment needed for the timestamp */
 	__be16 data[ADIS16475_MAX_SCAN_DATA] __aligned(8);
 };
@@ -310,6 +334,9 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	u16 dec;
 	int ret;
 	u32 sample_rate = st->clk_freq;
+	/* The optimal sample rate for the supported IMUs is between int_clk - 100 and int_clk + 100. */
+	u32 max_sample_rate =  st->info->int_clk * 1000 + 100000;
+	u32 min_sample_rate =  st->info->int_clk * 1000 - 100000;
 
 	if (!freq)
 		return -EINVAL;
@@ -317,8 +344,9 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	adis_dev_lock(&st->adis);
 	/*
 	 * When using sync scaled mode, the input clock needs to be scaled so that we have
-	 * an IMU sample rate between (optimally) 1900 and 2100. After this, we can use the
-	 * decimation filter to lower the sampling rate in order to get what the user wants.
+	 * an IMU sample rate between (optimally) int_clk - 100 and int_clk + 100.
+	 * After this, we can use the decimation filter to lower the sampling rate in order
+	 * to get what the user wants.
 	 * Optimally, the user sample rate is a multiple of both the IMU sample rate and
 	 * the input clock. Hence, calculating the sync_scale dynamically gives us better
 	 * chances of achieving a perfect/integer value for DEC_RATE. The math here is:
@@ -336,23 +364,25 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 		 * solution. In this case, we get the highest multiple of the input clock
 		 * lower than the IMU max sample rate.
 		 */
-		if (scaled_rate > 2100000)
-			scaled_rate = 2100000 / st->clk_freq * st->clk_freq;
+		if (scaled_rate > max_sample_rate)
+			scaled_rate = max_sample_rate / st->clk_freq * st->clk_freq;
+
 		else
-			scaled_rate = 2100000 / scaled_rate * scaled_rate;
+			scaled_rate = max_sample_rate / scaled_rate * scaled_rate;
 
 		/*
 		 * This is not an hard requirement but it's not advised to run the IMU
-		 * with a sample rate lower than 1900Hz due to possible undersampling
-		 * issues. However, there are users that might really want to take the risk.
-		 * Hence, we provide a module parameter for them. If set, we allow sample
-		 * rates lower than 1.9KHz. By default, we won't allow this and we just roundup
-		 * the rate to the next multiple of the input clock bigger than 1.9KHz. This
-		 * is done like this as in some cases (when DEC_RATE is 0) might give
-		 * us the closest value to the one desired by the user...
+		 * with a sample rate lower than internal clock frequency, due to possible
+		 * undersampling issues. However, there are users that might really want
+		 * to take the risk. Hence, we provide a module parameter for them. If set,
+		 * we allow sample rates lower than internal clock frequency.
+		 * By default, we won't allow this and we just roundup the rate to the next
+		 *  multiple of the input clock. This is done like this as in some cases
+		 * (when DEC_RATE is 0) might give us the closest value to the one desired
+		 * by the user...
 		 */
-		if (scaled_rate < 1900000 && !low_rate_allow)
-			scaled_rate = roundup(1900000, st->clk_freq);
+		if (scaled_rate < min_sample_rate && !low_rate_allow)
+			scaled_rate = roundup(min_sample_rate, st->clk_freq);
 
 		sync_scale = scaled_rate / st->clk_freq;
 		ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_UP_SCALE, sync_scale);
@@ -437,6 +467,130 @@ static int adis16475_set_filter(struct adis16475 *st, const u32 filter)
 	return 0;
 }
 
+static ssize_t adis16475_get_fifo_enabled(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adis16475 *st = iio_priv(indio_dev);
+	int ret;
+	u16 val;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIFO_CTRL, &val);
+	if (ret)
+		return ret;
+	val = FIELD_GET(ADIS16475_FIFO_EN_MASK, val);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static ssize_t adis16475_get_fifo_watermark(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adis16475 *st = iio_priv(indio_dev);
+
+	int ret;
+	u16 val;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIFO_CTRL, &val);
+	if (ret)
+		return ret;
+	val = FIELD_GET(ADIS16475_WM_LVL_MASK, val) + 1;
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static ssize_t hwfifo_watermark_min_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "1");
+}
+
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", __stringify(ADIS16475_MAX_FIFO_WM));
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       adis16475_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       adis16475_get_fifo_enabled, NULL, 0);
+
+static const struct attribute *adis16475_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static int adis16475_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	u16 val;
+
+	val = ADIS16475_FIFO_EN(1);
+	return adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_FIFO_EN_MASK, val);
+}
+
+static int adis16475_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	int ret;
+	u16 val;
+
+	adis_dev_lock(&st->adis);
+
+	val = ADIS16475_FIFO_EN(0);
+	ret = __adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_FIFO_EN_MASK, val);
+	if (ret)
+		goto unlock;
+
+	ret = __adis_write_reg_16(adis, ADIS16475_REG_GLOB_CMD,
+				  ADIS16475_FIFO_FLUSH_CMD);
+
+unlock:
+	adis_dev_unlock(&st->adis);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops adis16475_buffer_ops = {
+	.postenable = adis16475_buffer_postenable,
+	.postdisable = adis16475_buffer_postdisable,
+};
+
+static int adis16475_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct adis16475 *st  = iio_priv(indio_dev);
+	int ret;
+	u16 wm_lvl;
+
+	adis_dev_lock(&st->adis);
+
+	if (val > ADIS16475_MAX_FIFO_WM)
+		val = ADIS16475_MAX_FIFO_WM;
+
+	wm_lvl = ADIS16475_WM_LVL(val - 1);
+	ret = __adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_WM_LVL_MASK, wm_lvl);
+	if (ret)
+		goto unlock;
+
+	st->fifo_watermark = val;
+
+unlock:
+	adis_dev_unlock(&st->adis);
+	return ret;
+}
+
 static const u32 adis16475_calib_regs[] = {
 	[ADIS16475_SCAN_GYRO_X] = ADIS16475_REG_X_GYRO_BIAS_L,
 	[ADIS16475_SCAN_GYRO_Y] = ADIS16475_REG_Y_GYRO_BIAS_L,
@@ -668,6 +822,12 @@ enum adis16475_variant {
 	ADIS16507_1,
 	ADIS16507_2,
 	ADIS16507_3,
+	ADIS16575_2,
+	ADIS16575_3,
+	ADIS16576_2,
+	ADIS16576_3,
+	ADIS16577_2,
+	ADIS16577_3,
 };
 
 enum {
@@ -725,6 +885,12 @@ static const struct adis16475_sync adis16475_sync_mode[] = {
 	{ ADIS16475_SYNC_PULSE, 1000, 2100 },
 };
 
+static const struct adis16475_sync adis16575_sync_mode[] = {
+	{ ADIS16475_SYNC_OUTPUT },
+	{ ADIS16475_SYNC_DIRECT, 1900, 4100 },
+	{ ADIS16475_SYNC_SCALED, 1, 400 },
+};
+
 static const struct adis_timeout adis16475_timeouts = {
 	.reset_ms = 200,
 	.sw_reset_ms = 200,
@@ -1156,6 +1322,150 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 					    ADIS16475_BURST32_MAX_DATA,
 					    ADIS16475_BURST_MAX_SPEED),
 	},
+	[ADIS16575_2] = {
+		.name = "adis16575-2",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 8,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(450),
+		.deltvel_max_val = 100,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32 |
+			 ADIS16475_HAS_FIFO,
+		.adis_data = ADIS16475_DATA(16575, &adis16475_timeouts,
+					    ADIS16575_BURST32_MAX_DATA,
+					    ADIS16575_BURST_MAX_SPEED),
+	},
+	[ADIS16575_3] = {
+		.name = "adis16575-3",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 8,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2000),
+		.deltvel_max_val = 100,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32 |
+			 ADIS16475_HAS_FIFO,
+		.adis_data = ADIS16475_DATA(16575, &adis16475_timeouts,
+					    ADIS16575_BURST32_MAX_DATA,
+					    ADIS16575_BURST_MAX_SPEED),
+	},
+	[ADIS16576_2] = {
+		.name = "adis16576-2",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 40,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(450),
+		.deltvel_max_val = 125,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32 |
+			 ADIS16475_HAS_FIFO,
+		.adis_data = ADIS16475_DATA(16576, &adis16475_timeouts,
+					    ADIS16575_BURST32_MAX_DATA,
+					    ADIS16575_BURST_MAX_SPEED),
+	},
+	[ADIS16576_3] = {
+		.name = "adis16576-3",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 40,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2000),
+		.deltvel_max_val = 125,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32 |
+			 ADIS16475_HAS_FIFO,
+		.adis_data = ADIS16475_DATA(16576, &adis16475_timeouts,
+					    ADIS16575_BURST32_MAX_DATA,
+					    ADIS16575_BURST_MAX_SPEED),
+	},
+	[ADIS16577_2] = {
+		.name = "adis16577-2",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 40,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(450),
+		.deltvel_max_val = 400,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32 |
+			 ADIS16475_HAS_FIFO,
+		.adis_data = ADIS16475_DATA(16577, &adis16475_timeouts,
+					    ADIS16575_BURST32_MAX_DATA,
+					    ADIS16575_BURST_MAX_SPEED),
+	},
+	[ADIS16577_3] = {
+		.name = "adis16577-3",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
+		.accel_max_val = 40,
+		.accel_max_scale = IIO_M_S_2_TO_G(32000 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(2000),
+		.deltvel_max_val = 400,
+		.int_clk = 4000,
+		.max_dec = 3999,
+		.sync = adis16575_sync_mode,
+		.num_sync = ARRAY_SIZE(adis16575_sync_mode),
+		.flags = ADIS16475_HAS_BURST32 |
+			 ADIS16475_HAS_BURST_DELTA_DATA |
+			 ADIS16475_NEEDS_BURST_REQUEST |
+			 ADIS16475_HAS_TIMESTAMP32 |
+			 ADIS16475_HAS_FIFO,
+		.adis_data = ADIS16475_DATA(16577, &adis16475_timeouts,
+					    ADIS16575_BURST32_MAX_DATA,
+					    ADIS16575_BURST_MAX_SPEED),
+	},
 };
 
 static int adis16475_update_scan_mode(struct iio_dev *indio_dev,
@@ -1188,17 +1498,14 @@ static const struct iio_info adis16475_info = {
 	.write_raw = &adis16475_write_raw,
 	.update_scan_mode = adis16475_update_scan_mode,
 	.debugfs_reg_access = adis_debugfs_reg_access,
+	.hwfifo_set_watermark = adis16475_set_watermark,
 };
 
 static bool adis16475_validate_crc(const u8 *buffer, u16 crc,
-				   const bool burst32)
+				   u16 burst_size, u16 start_idx)
 {
 	int i;
-	/* extra 6 elements for low gyro and accel */
-	const u16 sz = burst32 ? ADIS16475_BURST32_MAX_DATA :
-		ADIS16475_BURST_MAX_DATA;
-
-	for (i = 0; i < sz - 2; i++)
+	for (i = start_idx; i < burst_size - 2; i++)
 		crc -= buffer[i];
 
 	return crc == 0;
@@ -1226,8 +1533,11 @@ static void adis16475_burst32_check(struct adis16475 *st)
 		 * In 32-bit mode we need extra 2 bytes for all gyro
 		 * and accel channels.
 		 */
-		adis->burst_extra_len = 6 * sizeof(u16);
-		adis->xfer[1].len += 6 * sizeof(u16);
+		adis->burst_extra_len = (6 + !!(st->info->flags & ADIS16475_HAS_TIMESTAMP32)) *
+					sizeof(u16);
+		adis->xfer[1].len += (6 + !!(st->info->flags & ADIS16475_HAS_TIMESTAMP32)) *
+				     sizeof(u16);
+
 		dev_dbg(&adis->spi->dev, "Enable burst32 mode, xfer:%d",
 			adis->xfer[1].len);
 
@@ -1243,7 +1553,8 @@ static void adis16475_burst32_check(struct adis16475 *st)
 
 		/* Remove the extra bits */
 		adis->burst_extra_len = 0;
-		adis->xfer[1].len -= 6 * sizeof(u16);
+		adis->xfer[1].len -= (6 + !!(st->info->flags & ADIS16475_HAS_TIMESTAMP32)) *
+				     sizeof(u16);
 		dev_dbg(&adis->spi->dev, "Disable burst32 mode, xfer:%d\n",
 			adis->xfer[1].len);
 	}
@@ -1258,20 +1569,31 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
 	__be16 *buffer;
 	u16 crc;
 	bool valid;
+	u8 crc_offset = 9;
+	u16 burst_size = ADIS16475_BURST_MAX_DATA;
+	u16 start_idx = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 2 : 0;
+
 	/* offset until the first element after gyro and accel */
 	const u8 offset = st->burst32 ? 13 : 7;
 
+	if (st->burst32) {
+		crc_offset = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 16 : 15;
+		burst_size = (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ?
+			     ADIS16575_BURST32_MAX_DATA : ADIS16475_BURST32_MAX_DATA;
+	}
+
 	ret = spi_sync(adis->spi, &adis->msg);
 	if (ret)
-		goto check_burst32;
+		return ret;
 
 	buffer = adis->buffer;
 
-	crc = be16_to_cpu(buffer[offset + 2]);
-	valid = adis16475_validate_crc(adis->buffer, crc, st->burst32);
+	crc = be16_to_cpu(buffer[crc_offset]);
+	valid = adis16475_validate_crc(adis->buffer, crc, burst_size, start_idx);
+
 	if (!valid) {
 		dev_err(&adis->spi->dev, "Invalid crc\n");
-		goto check_burst32;
+		return ret;
 	}
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
@@ -1332,22 +1654,111 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, st->data, pf->timestamp);
-check_burst32:
+
+	return 0;
+}
+
+static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16475 *st = iio_priv(indio_dev);
+
+	adis16475_push_single_sample(pf);
 	/*
 	 * We only check the burst mode at the end of the current capture since
 	 * it takes a full data ready cycle for the device to update the burst
 	 * array.
 	 */
 	adis16475_burst32_check(st);
-	return ret;
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
 }
 
-static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+static int adis16575_custom_burst_read(struct iio_poll_func *pf, u8 burst_req)
+{
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	unsigned int burst_length, burst_max_length;
+	u8 *tx;
+
+	burst_length = adis->data->burst_len + adis->burst_extra_len;
+
+	if (adis->data->burst_max_len)
+		burst_max_length = adis->data->burst_max_len;
+	else
+		burst_max_length = burst_length;
+
+	tx = adis->buffer + burst_max_length;
+	tx[0] = ADIS_READ_REG(burst_req);
+
+	if (burst_req)
+		return spi_sync(adis->spi, &adis->msg);
+
+	return adis16475_push_single_sample(pf);
+}
+
+/*
+ * This handler is meant to be used for devices which support burst readings
+ * from FIFO (namely devices from adis1657x family).
+ * In order to pop the FIFO the 0x68 0x00 FIFO pop burst request has to be sent.
+ * If the previous device command was not a FIFO pop burst request, the FIFO pop
+ * burst request will simply pop the FIFO without returning valid data.
+ * For the nth consecutive burst request, the
+ * device will send the data popped with the (n-1)th consecutive burst request.
+ * In order to read the data which was popped previously, without popping the FIFO,
+ * the 0x00 0x00 burst request has to be sent.
+ * If after a 0x68 0x00 FIFO pop burst request, there is any other device access
+ * different from a 0x68 0x00 or a 0x00 0x00 burst request, the FIFO data popped
+ * previously will be lost.
+ */
+static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16475 *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	int ret;
+	u16 fifo_cnt, i;
 
-	adis16475_push_single_sample(pf);
+	adis_dev_lock(&st->adis);
+
+	ret = __adis_read_reg_16(adis, ADIS16475_REG_FIFO_CNT, &fifo_cnt);
+	if (ret || fifo_cnt < 2)
+		goto unlock;
+
+	if (fifo_cnt > st->fifo_watermark)
+		fifo_cnt = st->fifo_watermark;
+
+	/*
+	 * First burst request - FIFO pop: popped data will be returned in the
+	 * next burst request.
+	 */
+	ret = adis16575_custom_burst_read(pf, adis->data->burst_reg_cmd);
+	if (ret)
+		goto unlock;
+
+	for (i = 0; i < fifo_cnt - 1; i++) {
+		ret = adis16475_push_single_sample(pf);
+		if (ret)
+			goto unlock;
+	}
+
+	/* FIFO read without popping */
+	ret = adis16575_custom_burst_read(pf, 0);
+	if (ret)
+		goto unlock;
+
+unlock:
+	/*
+	 * We only check the burst mode at the end of the current capture since
+	 * reading data from registers will impact the FIFO reading.
+	 */
+	adis16475_burst32_check(st);
+	adis_dev_unlock(&st->adis);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -1359,6 +1770,17 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	struct device *dev = &st->adis.spi->dev;
 	const struct adis16475_sync *sync;
 	u32 sync_mode;
+	u16 max_sample_rate =  st->info->int_clk + 100;
+	u16 val;
+
+	/* if available, enable 4khz internal clock */
+	if (st->info->int_clk == 4000) {
+		val = ADIS16475_SYNC_4KHZ(1);
+		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
+					 ADIS16475_SYNC_4KHZ_MASK, val);
+		if (ret)
+			return ret;
+	}
 
 	/* default to internal clk */
 	st->clk_freq = st->info->int_clk * 1000;
@@ -1398,10 +1820,9 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 			/*
 			 * In sync scaled mode, the IMU sample rate is the clk_freq * sync_scale.
 			 * Hence, default the IMU sample rate to the highest multiple of the input
-			 * clock lower than the IMU max sample rate. The optimal range is
-			 * 1900-2100 sps...
+			 * clock lower than the IMU max sample rate.
 			 */
-			up_scale = 2100 / st->clk_freq;
+			up_scale = max_sample_rate / st->clk_freq;
 
 			ret = __adis_write_reg_16(&st->adis,
 						  ADIS16475_REG_UP_SCALE,
@@ -1467,7 +1888,23 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 	 */
 	usleep_range(250, 260);
 
-	return 0;
+	/*
+	 * If the device has FIFO support, configure the watermark polarity
+	 * pin as well.
+	 */
+	if (st->info->flags & ADIS16475_HAS_FIFO) {
+		val = ADIS16475_WM_POL(polarity);
+		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
+				       ADIS16475_WM_POL_MASK, val);
+		if (ret)
+			return ret;
+
+		/* Enable watermark interrupt pin. */
+		val = ADIS16475_WM_EN(1);
+		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_WM_EN_MASK, val);
+	}
+
+	return ret;
 }
 
 
@@ -1509,8 +1946,21 @@ static int adis16475_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
-						 adis16475_trigger_handler);
+	if (st->info->flags & ADIS16475_HAS_FIFO) {
+		ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
+								    adis16475_trigger_handler_with_fifo,
+								    &adis16475_buffer_ops,
+								    adis16475_fifo_attributes);
+		if (ret)
+			return ret;
+		/* Update overflow behavior to always overwrite the oldest sample. */
+		u16 val = ADIS16475_OVERWRITE_OLDEST;
+
+		ret = adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16475_OVERFLOW_MASK, val);
+	} else {
+		ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
+							 adis16475_trigger_handler);
+	}
 	if (ret)
 		return ret;
 
@@ -1566,6 +2016,18 @@ static const struct of_device_id adis16475_of_match[] = {
 		.data = &adis16475_chip_info[ADIS16507_2] },
 	{ .compatible = "adi,adis16507-3",
 		.data = &adis16475_chip_info[ADIS16507_3] },
+	{ .compatible = "adi,adis16575-2",
+		.data = &adis16475_chip_info[ADIS16575_2] },
+	{ .compatible = "adi,adis16575-3",
+		.data = &adis16475_chip_info[ADIS16575_3] },
+	{ .compatible = "adi,adis16576-2",
+		.data = &adis16475_chip_info[ADIS16576_2] },
+	{ .compatible = "adi,adis16576-3",
+		.data = &adis16475_chip_info[ADIS16576_3] },
+	{ .compatible = "adi,adis16577-2",
+		.data = &adis16475_chip_info[ADIS16577_2] },
+	{ .compatible = "adi,adis16577-3",
+		.data = &adis16475_chip_info[ADIS16577_3] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adis16475_of_match);
-- 
2.34.1


