Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929A77BAFCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjJFAvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjJFAvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:19 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1152102
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:15 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1dceaa7aeffso1417653fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553475; x=1697158275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=401MuIU8dYTD28dOELCnJF7slIhly00THfZyqPcqV78=;
        b=fZbUuMpFXMrnDDox2L2QhLxQk61FQiGGpOC5hB2XKM5DgDdthcJtJYFAmUQZDQ1seE
         KO4XXvElLT7kk9kX0ZEPzUbHA21mFsYc6nsRcNdkNxHzWqa9R+NLLIrBmcQwOqoXlozW
         9tgF3Q7dq4vc4irtpJv6RvkEeDV519fApasQaEabOU2cDyynWA/YZC5tYDgO9AeIPpHr
         Y6EO9jBYRylNHkPsJmddFKNfDIBb9NOABO3UY7pouryR2WlsYtZfmHVgeLkWWVbrfi44
         q/nqfa4pXMbqJ6jSlM5W4ZjEpJQleoJe1z1A9v5GOuBqZBfz9HrWCCGfTELL5vUNBqsV
         8jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553475; x=1697158275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=401MuIU8dYTD28dOELCnJF7slIhly00THfZyqPcqV78=;
        b=VtY2/psVrEXW9DO+Voc9gNZQVaamMnpRN0ZgSvNu7h7MtEu1dCQNVr5SYzBgxfoaXw
         TYxpY+oLABC5jgWnSuy78oxTzMcRB8jb5Et6fjXz9zSYZFHxh94otDlyeHwTa8ve2ZJR
         JDQN688NZzP4PE3X8RXuEZqiap1Sw18ZBghu4FW+/1oAhRIOEr/xIBIRrxCfnKhQ8k0K
         YWs13VTOhiaZ9qnsbijkSbJHXF7LVqLI6qlWq4NpQkUeyN0nA5lZfK6PWk51ZZnjpxTN
         uiLFJqWETyDho2zl+8v5pNA1zjc1aZfX6FZ9aVs9Zf3veDIdq8nlXX2BcVsBwVDwxUpo
         9ByQ==
X-Gm-Message-State: AOJu0YzX7C4lelOpmUYpHrIZgfj/2S7XCQ5uZVIG94KexqaLCjf2R0RO
        Recw+2ixjd/90xOCEisVpj6tjw==
X-Google-Smtp-Source: AGHT+IGqKRe7Pzu9DJxwolpPtoWPhdYsT/D0nHbFXo5rdQk5FeYxvwjHaxjvfUhBMld4k3SLejTWug==
X-Received: by 2002:a05:6870:610e:b0:1d5:a22d:3020 with SMTP id s14-20020a056870610e00b001d5a22d3020mr1682153oae.3.1696553474965;
        Thu, 05 Oct 2023 17:51:14 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:14 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/17] staging: iio: resolver: ad2s1210: implement fault events
Date:   Thu,  5 Oct 2023 19:50:30 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-13-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the position and velocity on the AD2S1210, there is also a
3rd byte following the two data bytes that contains the fault flag bits.
This patch adds support for reading this byte and generating events when
faults occur.

The faults are mapped to various channels and event type in order to
have a unique event for each fault.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Added sysfs docs for *_label attributes.
* Added implementation of read_event_label.
* Dropped use of IIO_MOD_X_OR_Y.
* Tweaked event type/direction as in previous patches.
* Fixed build error due to st->rx[2].

v3 changes: This is a new patch in v3

 Documentation/ABI/testing/sysfs-bus-iio |  15 +++
 drivers/staging/iio/resolver/ad2s1210.c | 211 +++++++++++++++++++++++++++++---
 2 files changed, 212 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 8e13642bbe23..19cde14f3869 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2239,3 +2239,18 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		The x and y light color coordinate on the CIE 1931 chromaticity
 		diagram.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltageY_mag_either_label
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltageY_mag_rising_label
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltageY_thresh_falling_label
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltageY_thresh_rising_label
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_anglvelY_mag_rising_label
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_anglY_thresh_rising_label
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_phaseY_mag_rising_label
+KernelVersion:	6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Optional symbolic label to a device channel event.
+		If a label is defined for this event add that to the event
+		specific attributes. This is useful for userspace to be able to
+		better identify an individual event.
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 9fac806c2a5f..d9d51bbbade8 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
@@ -35,6 +36,16 @@
 #define AD2S1210_SET_ENRES		GENMASK(3, 2)
 #define AD2S1210_SET_RES		GENMASK(1, 0)
 
+/* fault register flags */
+#define AD2S1210_FAULT_CLIP		BIT(7)
+#define AD2S1210_FAULT_LOS		BIT(6)
+#define AD2S1210_FAULT_DOS_OVR		BIT(5)
+#define AD2S1210_FAULT_DOS_MIS		BIT(4)
+#define AD2S1210_FAULT_LOT		BIT(3)
+#define AD2S1210_FAULT_VELOCITY		BIT(2)
+#define AD2S1210_FAULT_PHASE		BIT(1)
+#define AD2S1210_FAULT_CONFIG_PARITY	BIT(0)
+
 #define AD2S1210_REG_POSITION_MSB	0x80
 #define AD2S1210_REG_POSITION_LSB	0x81
 #define AD2S1210_REG_VELOCITY_MSB	0x82
@@ -71,6 +82,8 @@
 /* max voltage for threshold registers is 0x7F * 38 mV */
 #define THRESHOLD_RANGE_STR "[0 38 4826]"
 
+#define FAULT_ONESHOT(bit, new, old) (new & bit && !(old & bit))
+
 enum ad2s1210_mode {
 	MOD_POS = 0b00,
 	MOD_VEL = 0b01,
@@ -100,8 +113,13 @@ struct ad2s1210_state {
 	int hysteresis_available[2];
 	/** The selected resolution */
 	enum ad2s1210_resolution resolution;
+	/** Copy of fault register from the previous read. */
+	u8 prev_fault_flags;
 	/** For reading raw sample value via SPI. */
-	__be16 sample __aligned(IIO_DMA_MINALIGN);
+	struct {
+		__be16 raw;
+		u8 fault;
+	} sample __aligned(IIO_DMA_MINALIGN);
 	/** Scan buffer */
 	struct {
 		__be16 chan[2];
@@ -160,7 +178,15 @@ static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
 	if (ret < 0)
 		return ret;
 
-	return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
+	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
+	if (ret < 0)
+		return ret;
+
+	/* soft reset also clears the fault register */
+	if (reg == AD2S1210_REG_SOFT_RESET)
+		st->prev_fault_flags = 0;
+
+	return 0;
 }
 
 /*
@@ -203,6 +229,10 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
 	if (ret < 0)
 		return ret;
 
+	/* reading the fault register also clears it */
+	if (reg == AD2S1210_REG_FAULT)
+		st->prev_fault_flags = 0;
+
 	/*
 	 * If the D7 bit is set on any read/write register, it indicates a
 	 * parity error. The fault register is read-only and the D7 bit means
@@ -286,14 +316,101 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 	return ret < 0 ? ret : len;
 }
 
-static int ad2s1210_single_conversion(struct ad2s1210_state *st,
+static void ad2s1210_push_events(struct iio_dev *indio_dev,
+				 u8 flags, s64 timestamp)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+
+	/* Sine/cosine inputs clipped */
+	if (FAULT_ONESHOT(AD2S1210_FAULT_CLIP, flags, st->prev_fault_flags)) {
+		/*
+		 * The chip does not differentiate between fault on sine vs.
+		 * cosine channel so we just send an event on both channels.
+		 */
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ALTVOLTAGE, 1,
+						    IIO_EV_TYPE_MAG,
+						    IIO_EV_DIR_EITHER),
+			       timestamp);
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ALTVOLTAGE, 2,
+						    IIO_EV_TYPE_MAG,
+						    IIO_EV_DIR_EITHER),
+			       timestamp);
+	}
+
+	/* Sine/cosine inputs below LOS threshold */
+	if (FAULT_ONESHOT(AD2S1210_FAULT_LOS, flags, st->prev_fault_flags))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ALTVOLTAGE, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
+
+	/* Sine/cosine inputs exceed DOS overrange threshold */
+	if (FAULT_ONESHOT(AD2S1210_FAULT_DOS_OVR, flags, st->prev_fault_flags))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ALTVOLTAGE, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+
+	/* Sine/cosine inputs exceed DOS mismatch threshold */
+	if (FAULT_ONESHOT(AD2S1210_FAULT_DOS_MIS, flags, st->prev_fault_flags))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ALTVOLTAGE, 0,
+						    IIO_EV_TYPE_MAG,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+
+	/* Tracking error exceeds LOT threshold */
+	if (FAULT_ONESHOT(AD2S1210_FAULT_LOT, flags, st->prev_fault_flags))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ANGL, 1,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+
+	/* Velocity exceeds maximum tracking rate */
+	if (FAULT_ONESHOT(AD2S1210_FAULT_VELOCITY, flags, st->prev_fault_flags))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ANGL_VEL, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+
+	/* Phase error exceeds phase lock range */
+	if (FAULT_ONESHOT(AD2S1210_FAULT_PHASE, flags, st->prev_fault_flags))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PHASE, 0,
+						    IIO_EV_TYPE_MAG,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+
+	/* Configuration parity error */
+	if (FAULT_ONESHOT(AD2S1210_FAULT_CONFIG_PARITY, flags,
+			  st->prev_fault_flags))
+		/*
+		 * Userspace should also get notified of this via error return
+		 * when trying to write to any attribute that writes a register.
+		 */
+		dev_err_ratelimited(&indio_dev->dev,
+				    "Configuration parity error\n");
+
+	st->prev_fault_flags = flags;
+}
+
+static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan,
 				      int *val)
 {
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	s64 timestamp;
 	int ret;
 
 	mutex_lock(&st->lock);
 	gpiod_set_value(st->sample_gpio, 1);
+	timestamp = iio_get_time_ns(indio_dev);
 	/* delay (6 * tck + 20) nano seconds */
 	udelay(1);
 
@@ -310,17 +427,17 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
 	}
 	if (ret < 0)
 		goto error_ret;
-	ret = spi_read(st->sdev, &st->sample, 2);
+	ret = spi_read(st->sdev, &st->sample, 3);
 	if (ret < 0)
 		goto error_ret;
 
 	switch (chan->type) {
 	case IIO_ANGL:
-		*val = be16_to_cpu(st->sample);
+		*val = be16_to_cpu(st->sample.raw);
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_ANGL_VEL:
-		*val = (s16)be16_to_cpu(st->sample);
+		*val = (s16)be16_to_cpu(st->sample.raw);
 		ret = IIO_VAL_INT;
 		break;
 	default:
@@ -328,6 +445,8 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
 		break;
 	}
 
+	ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
+
 error_ret:
 	gpiod_set_value(st->sample_gpio, 0);
 	/* delay (2 * tck + 20) nano seconds */
@@ -611,7 +730,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return ad2s1210_single_conversion(st, chan, val);
+		return ad2s1210_single_conversion(indio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL:
@@ -725,6 +844,14 @@ static const struct iio_event_spec ad2s1210_position_event_spec[] = {
 	},
 };
 
+static const struct iio_event_spec ad2s1210_velocity_event_spec[] = {
+	{
+		/* Velocity exceeds maximum tracking rate fault. */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+	},
+};
+
 static const struct iio_event_spec ad2s1210_phase_event_spec[] = {
 	{
 		/* Phase error fault. */
@@ -758,6 +885,14 @@ static const struct iio_event_spec ad2s1210_monitor_signal_event_spec[] = {
 	},
 };
 
+static const struct iio_event_spec ad2s1210_sin_cos_event_spec[] = {
+	{
+		/* Sine/cosine clipping fault. */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_EITHER,
+	},
+};
+
 static const struct iio_chan_spec ad2s1210_channels[] = {
 	{
 		.type = IIO_ANGL,
@@ -788,6 +923,8 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = ad2s1210_velocity_event_spec,
+		.num_event_specs = ARRAY_SIZE(ad2s1210_velocity_event_spec),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 	{
@@ -824,6 +961,22 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.scan_index = -1,
 		.event_spec = ad2s1210_monitor_signal_event_spec,
 		.num_event_specs = ARRAY_SIZE(ad2s1210_monitor_signal_event_spec),
+	}, {
+		/* sine input */
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.scan_index = -1,
+		.event_spec = ad2s1210_sin_cos_event_spec,
+		.num_event_specs = ARRAY_SIZE(ad2s1210_sin_cos_event_spec),
+	}, {
+		/* cosine input */
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.channel = 2,
+		.scan_index = -1,
+		.event_spec = ad2s1210_sin_cos_event_spec,
+		.num_event_specs = ARRAY_SIZE(ad2s1210_sin_cos_event_spec),
 	},
 };
 
@@ -943,7 +1096,7 @@ static const struct attribute_group ad2s1210_event_attribute_group = {
 
 static int ad2s1210_initial(struct ad2s1210_state *st)
 {
-	unsigned char data;
+	unsigned int data;
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -1043,6 +1196,36 @@ static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad2s1210_read_event_label(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     char *label)
+{
+	if (chan->type == IIO_ANGL)
+		return sprintf(label, "LOT\n");
+	if (chan->type == IIO_ANGL_VEL)
+		return sprintf(label, "max tracking rate\n");
+	if (chan->type == IIO_PHASE)
+		return sprintf(label, "phase lock\n");
+	if (chan->type == IIO_ALTVOLTAGE) {
+		if (chan->channel == 0) {
+			if (type == IIO_EV_TYPE_THRESH &&
+			    dir == IIO_EV_DIR_FALLING)
+				return sprintf(label, "LOS\n");
+			if (type == IIO_EV_TYPE_THRESH &&
+			    dir == IIO_EV_DIR_RISING)
+				return sprintf(label, "DOS overrange\n");
+			if (type == IIO_EV_TYPE_MAG)
+				return sprintf(label, "DOS mismatch\n");
+		}
+		if (chan->channel == 1 || chan->channel == 2)
+			return sprintf(label, "clipped\n");
+	}
+
+	return -EINVAL;
+}
+
 static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 				       unsigned int reg, unsigned int writeval,
 				       unsigned int *readval)
@@ -1080,12 +1263,11 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			goto error_ret;
 
-		/* REVIST: we can read 3 bytes here and also get fault flags */
-		ret = spi_read(st->sdev, st->rx, 2);
+		ret = spi_read(st->sdev, &st->sample, 3);
 		if (ret < 0)
 			goto error_ret;
 
-		memcpy(&st->scan.chan[chan++], st->rx, 2);
+		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
 	}
 
 	if (test_bit(1, indio_dev->active_scan_mask)) {
@@ -1093,14 +1275,14 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			goto error_ret;
 
-		/* REVIST: we can read 3 bytes here and also get fault flags */
-		ret = spi_read(st->sdev, st->rx, 2);
+		ret = spi_read(st->sdev, &st->sample, 3);
 		if (ret < 0)
 			goto error_ret;
 
-		memcpy(&st->scan.chan[chan++], st->rx, 2);
+		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
 	}
 
+	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
 
 error_ret:
@@ -1119,6 +1301,7 @@ static const struct iio_info ad2s1210_info = {
 	.attrs = &ad2s1210_attribute_group,
 	.read_event_value = ad2s1210_read_event_value,
 	.write_event_value = ad2s1210_write_event_value,
+	.read_event_label = ad2s1210_read_event_label,
 	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
 

-- 
2.42.0

