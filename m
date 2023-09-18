Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB47A5544
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjIRVv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjIRVvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:51:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8FA19A;
        Mon, 18 Sep 2023 14:51:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-404732a0700so50434815e9.0;
        Mon, 18 Sep 2023 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695073870; x=1695678670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IX/RMkHJnCDnK8TJYCgTeXUdofZuW9ckmnp7qQsEb4=;
        b=fWnmYW4Y3p5nZ/6xC+Ey9uu7Pla+y1Mqh29O8qUH2deW0sEDX7C09zSAneEdEItKcT
         oHZJ4JAw1daAOFLNV+5l+fhCk9nQExtLTemqsDs+0OVoUZZ1QkdcQu81NvXu/jd0DnbR
         bT3wmcX9aAKAnzeCl/Pw5CVwB1yVJp/lVoZXnWibdst9oa4QMsj6/7lTUrCtSLqg54D3
         8DlNgB1ntD7HVnw0J/Ak0ZW8tRJ91Vp6evbaarlJnNfxvIX5UKa7huIzmSNomob4A/OH
         epYE0aV2tKFsI8c7LYI9CEMBJYpWSlF3gVBPzenyGTqPKMkwD7DLwyh21D4Oyzt+FOW7
         vvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695073870; x=1695678670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IX/RMkHJnCDnK8TJYCgTeXUdofZuW9ckmnp7qQsEb4=;
        b=I14gBuFWRIHPYXnw4u4xxCzfBE7EEm2vnS4ECugHKdan2KwqQRDbmTyYV2M9A0K6N5
         IxSKwNP3YxHh2bYzmBwAaCfKuX+lpGgMSEAJ8ejxfOu0ihJe/dDUF2pDkH399nltrynV
         9LdBwp0TIBVW1tt1vfquQp8ymB1S+bu2rQr1bWSMbnZBLHDyDVnv+hii+XocX/IJvAMZ
         YYvKV7k16k0YQV7NNKTEuPANhHDnIvfN78VynBnOUV6+OO+5HsqM46cpEDab2QeZxy2r
         Wz43pmpglxUq9DyvfXRdt+flIvSRB3i2NyoucMXZBCe+zQ65y12ly7G8/U5Fi6JEFOOp
         KLPg==
X-Gm-Message-State: AOJu0YwfneaSe620yfUtjg7nK3kkIZxH2X1NFJYxfYDMwSacua5Kd79w
        jhDU38vjmbuO4es0ReEspsyhjyb5dC59Kg==
X-Google-Smtp-Source: AGHT+IEW18n9uzlxWJtNNwhehr6PXLDwuHVXsx0kBbD0t0yRqjbTNIDKZcly43quJucntcyfuw3puQ==
X-Received: by 2002:a05:600c:2103:b0:402:f55e:ac11 with SMTP id u3-20020a05600c210300b00402f55eac11mr8762490wml.20.1695073870284;
        Mon, 18 Sep 2023 14:51:10 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:13e1:e47b:904a:6f81])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003fe23b10fdfsm16323715wmj.36.2023.09.18.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 14:51:09 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisadariana@gmail.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: ad7192: Add fast settling support
Date:   Tue, 19 Sep 2023 00:48:54 +0300
Message-Id: <20230918214854.252781-4-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918214854.252781-1-alisadariana@gmail.com>
References: <20230918214854.252781-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisadariana@gmail.com>

Add fast settling mode support for AD7193.

Add fast_settling_average_factor attribute. Expose to user the current
value of the fast settling average factor. User can change the value by
writing a new one.

Add fast_settling_average_factor_available attribute. Expose to user
possible values for the fast settling average factor.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad7192      |  18 +++
 drivers/iio/adc/ad7192.c                      | 130 ++++++++++++++++--
 2 files changed, 136 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index f8315202c8f0..5790adbb1cc1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -19,6 +19,24 @@ Description:
 		the bridge can be disconnected (when it is not being used
 		using the bridge_switch_en attribute.
 
+What:		/sys/bus/iio/devices/iio:deviceX/fast_settling_average_factor
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, is used to activate or deactivate
+		fast settling mode and set the value of the average factor to
+		1, 2, 8 or 16. If the average factor is set to 1, the fast
+		settling mode is disabled. The data from the sinc filter is
+		averaged by chosen value. The averaging reduces the output data
+		rate for a given FS word, however, the rms noise improves.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fast_settling_average_factor_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible values for the fast
+		settling average factor: 1, 2, 8, 16.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 323e25c3ea30..e2383a3bae87 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -68,6 +68,10 @@
 #define AD7192_MODE_CLKSRC_MASK	GENMASK(19, 18) /* Clock Source Select Mask */
 #define AD7192_MODE_CLKSRC(x)	FIELD_PREP(AD7192_MODE_CLKSRC_MASK, x)
 				  /* Clock Source Select */
+#define AD7192_MODE_AVG_MASK	GENMASK(17, 16)
+		  /* Fast Settling Filter Average Select Mask (AD7193 only) */
+#define AD7192_MODE_AVG(x)	FIELD_PREP(AD7192_MODE_AVG_MASK, x)
+		  /* Fast Settling Filter Average Select (AD7193 only) */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
 #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
 #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
@@ -196,6 +200,7 @@ struct ad7192_state {
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
+	u8				avg_avail[4];
 	u8				gpocon;
 	u8				clock_sel;
 	struct mutex			lock;	/* protect sensor state */
@@ -473,6 +478,13 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 		st->scale_avail[i][0] = scale_uv;
 	}
 
+	if (st->chip_info->chip_id == CHIPID_AD7193) {
+		st->avg_avail[0] = 1;
+		st->avg_avail[1] = 2;
+		st->avg_avail[2] = 8;
+		st->avg_avail[3] = 16;
+	}
+
 	return 0;
 }
 
@@ -497,6 +509,18 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
 			  !!FIELD_GET(AD7192_GPOCON_BPDSW, st->gpocon));
 }
 
+static ssize_t ad7192_show_average_factor(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7192_state *st = iio_priv(indio_dev);
+	u8 avg_factor_index;
+
+	avg_factor_index = FIELD_GET(AD7192_MODE_AVG_MASK, st->mode);
+	return sysfs_emit(buf, "%d\n", st->avg_avail[avg_factor_index]);
+}
+
 static ssize_t ad7192_set(struct device *dev,
 			  struct device_attribute *attr,
 			  const char *buf,
@@ -505,12 +529,10 @@ static ssize_t ad7192_set(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	bool val, ret_einval;
+	u8 val_avg_factor;
+	unsigned int i;
 	int ret;
-	bool val;
-
-	ret = kstrtobool(buf, &val);
-	if (ret < 0)
-		return ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
@@ -518,6 +540,10 @@ static ssize_t ad7192_set(struct device *dev,
 
 	switch ((u32)this_attr->address) {
 	case AD7192_REG_GPOCON:
+		ret = kstrtobool(buf, &val);
+		if (ret < 0)
+			return ret;
+
 		if (val)
 			st->gpocon |= AD7192_GPOCON_BPDSW;
 		else
@@ -526,6 +552,10 @@ static ssize_t ad7192_set(struct device *dev,
 		ad_sd_write_reg(&st->sd, AD7192_REG_GPOCON, 1, st->gpocon);
 		break;
 	case AD7192_REG_CONF:
+		ret = kstrtobool(buf, &val);
+		if (ret < 0)
+			return ret;
+
 		if (val)
 			st->conf |= AD7192_CONF_ACX;
 		else
@@ -533,6 +563,27 @@ static ssize_t ad7192_set(struct device *dev,
 
 		ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
 		break;
+	case AD7192_REG_MODE:
+		ret = kstrtou8(buf, 10, &val_avg_factor);
+		if (ret < 0)
+			return ret;
+
+		ret_einval = true;
+		for (i = 0; i < ARRAY_SIZE(st->avg_avail); i++) {
+			if (val_avg_factor == st->avg_avail[i]) {
+				st->mode &= ~AD7192_MODE_AVG_MASK;
+				st->mode |= AD7192_MODE_AVG(i);
+				ret_einval = false;
+			}
+		}
+
+		if (ret_einval)
+			return -EINVAL;
+
+		ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		if (ret)
+			return ret;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -542,15 +593,22 @@ static ssize_t ad7192_set(struct device *dev,
 	return ret ? ret : len;
 }
 
-static int ad7192_compute_f_order(bool sinc3_en, bool chop_en)
+static int ad7192_compute_f_order(struct ad7192_state *st, bool sinc3_en, bool chop_en)
 {
-	if (!chop_en)
+	u8 avg_factor;
+	u8 avg_factor_selected;
+
+	avg_factor_selected = FIELD_GET(AD7192_MODE_AVG_MASK, st->mode);
+
+	if (!avg_factor_selected && !chop_en)
 		return 1;
 
+	avg_factor = st->avg_avail[avg_factor_selected];
+
 	if (sinc3_en)
-		return AD7192_SYNC3_FILTER;
+		return AD7192_SYNC3_FILTER + avg_factor - 1;
 
-	return AD7192_SYNC4_FILTER;
+	return AD7192_SYNC4_FILTER + avg_factor - 1;
 }
 
 static int ad7192_get_f_order(struct ad7192_state *st)
@@ -560,13 +618,13 @@ static int ad7192_get_f_order(struct ad7192_state *st)
 	sinc3_en = FIELD_GET(AD7192_MODE_SINC3, st->mode);
 	chop_en = FIELD_GET(AD7192_CONF_CHOP, st->conf);
 
-	return ad7192_compute_f_order(sinc3_en, chop_en);
+	return ad7192_compute_f_order(st, sinc3_en, chop_en);
 }
 
 static int ad7192_compute_f_adc(struct ad7192_state *st, bool sinc3_en,
 				bool chop_en)
 {
-	unsigned int f_order = ad7192_compute_f_order(sinc3_en, chop_en);
+	unsigned int f_order = ad7192_compute_f_order(st, sinc3_en, chop_en);
 
 	return DIV_ROUND_CLOSEST(st->fclk,
 				 f_order * AD7192_MODE_RATE(st->mode));
@@ -619,9 +677,29 @@ static ssize_t ad7192_show_filter_avail(struct device *dev,
 	return len;
 }
 
+static ssize_t ad7192_show_avg_factor_avail(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7192_state *st = iio_priv(indio_dev);
+	unsigned int i;
+	size_t len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(st->avg_avail); i++)
+		len += sysfs_emit_at(buf, len, "%d ", st->avg_avail[i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
 static IIO_DEVICE_ATTR(filter_low_pass_3db_frequency_available,
 		       0444, ad7192_show_filter_avail, NULL, 0);
 
+static IIO_DEVICE_ATTR(fast_settling_average_factor_available,
+		       0444, ad7192_show_avg_factor_avail, NULL, 0);
+
 static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 		       ad7192_show_bridge_switch, ad7192_set,
 		       AD7192_REG_GPOCON);
@@ -630,6 +708,10 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       ad7192_show_ac_excitation, ad7192_set,
 		       AD7192_REG_CONF);
 
+static IIO_DEVICE_ATTR(fast_settling_average_factor, 0644,
+		       ad7192_show_average_factor, ad7192_set,
+		       AD7192_REG_MODE);
+
 static struct attribute *ad7192_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
@@ -640,6 +722,18 @@ static const struct attribute_group ad7192_attribute_group = {
 	.attrs = ad7192_attributes,
 };
 
+static struct attribute *ad7193_attributes[] = {
+	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
+	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
+	&iio_dev_attr_fast_settling_average_factor.dev_attr.attr,
+	&iio_dev_attr_fast_settling_average_factor_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7193_attribute_group = {
+	.attrs = ad7193_attributes,
+};
+
 static struct attribute *ad7195_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
@@ -895,6 +989,16 @@ static const struct iio_info ad7192_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
+static const struct iio_info ad7193_info = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.attrs = &ad7193_attribute_group,
+	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
+};
+
 static const struct iio_info ad7195_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -1069,7 +1173,9 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	if (st->chip_info->chip_id == CHIPID_AD7195)
+	if (st->chip_info->chip_id == CHIPID_AD7193)
+		indio_dev->info = &ad7193_info;
+	else if (st->chip_info->chip_id == CHIPID_AD7195)
 		indio_dev->info = &ad7195_info;
 	else
 		indio_dev->info = &ad7192_info;
-- 
2.34.1

