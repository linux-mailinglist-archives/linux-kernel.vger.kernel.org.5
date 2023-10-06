Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035097BAFCB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjJFAvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjJFAvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:17 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F1FD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1e1a2e26afcso996630fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553473; x=1697158273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNARt9BjmrL0i7i91yqOdic11DYEv873Ym2j4CCnaQE=;
        b=oew8jL3imJ0c1TFNz9Ft4n+HQImL07kzCK8gGeBewWOxjM3UX/3/4cJDUe+VRKwhkY
         BxzBgvUaQr9cNO9baN4VsyjHrIbCfQ2R9D57ZJ7ppNFYuZDzAw20UfCE/uMf6lVTe7OO
         8khCcDPDc4t4t4OgJRmxwXoZN83vQengF+ZnZPs+RjT9M1j3XjdQt6lj/KrBPJ0kftdK
         nrw6VYd1DeT53hA2KETqaohlhhlgiV3Y49cjMvYLR5CV/DsnknKTXnsGx2PJcZ1NNhFP
         jDxydmaxUBzMmwonKT44zLyoWJ29ZD6vwMhLK2tYTqCMgvFzXzVe6RMclqlSlNEWU1jL
         h7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553473; x=1697158273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNARt9BjmrL0i7i91yqOdic11DYEv873Ym2j4CCnaQE=;
        b=RG/TeW+Due8TeBG/YamHt6bRsu4qDxXmwsEdCriW4+gvJA6moUfh2pJWHaJTUXGOGE
         M4X8DeSLiJ5f9thNbCHK4WoLD2qSU3fLBQocC35EGVbFhd7Y4rGhuaAp7KnOqjW8+DAa
         nXvFJvBA39cSF6mKGRFVEkUPMeR0iI/eHO4TyqN/CKVN9N7Y7C0bFhcVtAMdt+ZvhFQO
         B5X6Kyjrz5RArM58/tOAVUH02Tc5gTEzMwXGcyeq/5IJBnYcIPqRn8r9oXGHjwtXOZUs
         up30tvNjTRBCUv8e0jBGQrpYc2nbhjxhXM3v2KluNFe5swij2Gec1lL9rEb3T3M9xgE8
         +w3Q==
X-Gm-Message-State: AOJu0YyHRyAFxoTEo7li1Nkf5veqjdLsyYQ3stxPrlV9c6LQN8pnN6Un
        fhxK6GIii5kZeCgvxSielDyCZQ==
X-Google-Smtp-Source: AGHT+IEWlShVZMnC6L36T0xQUuEmsgQU0elvkJX/T9h6QQP2eVon50uND5M3j3PJtGm0vC7Dbx4/GA==
X-Received: by 2002:a05:6870:8309:b0:1dc:704c:7c83 with SMTP id p9-20020a056870830900b001dc704c7c83mr7892096oae.30.1696553473491;
        Thu, 05 Oct 2023 17:51:13 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:13 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] staging: iio: resolver: ad2s1210: rename DOS reset min/max attrs
Date:   Thu,  5 Oct 2023 19:50:28 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-11-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD2S1210 has a programmable threshold for the degradation of signal
(DOS) mismatch fault. This fault is triggered when the difference in
amplitude between the sine and cosine inputs exceeds the threshold.

The DOS reset min/max registers on the chip provide initial values
for internal tracking of the min/max of the monitor signal after the
fault register is cleared.

This patch converts the custom device DOS reset min/max threshold
attributes custom event attributes on the monitor signal channel.

The attributes now use millivolts instead of the raw register value in
accordance with the IIO ABI.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Fixed name of attributes in sysfs docs.
* Changed event direction from none to rising.
* Fixed missing static qualifier on attribute definition.

v3 changes: This is a new patch in v3

 .../Documentation/sysfs-bus-iio-resolver-ad2s1210  | 27 ++++++
 drivers/staging/iio/resolver/ad2s1210.c            | 99 ++++++++++++----------
 2 files changed, 82 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210 b/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
new file mode 100644
index 000000000000..f92c79342b93
--- /dev/null
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
@@ -0,0 +1,27 @@
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltage0_mag_rising_reset_max
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Degradation of Signal Reset Maximum
+		Threshold value in millivolts. Writing sets the value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltage0_mag_rising_reset_max_available
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the allowable voltage range for
+		in_altvoltage0_mag_rising_reset_max.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltage0_mag_rising_reset_min
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Degradation of Signal Reset Minimum
+		Threshold value in millivolts. Writing sets the value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/events/in_altvoltage0_mag_rising_reset_min_available
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the allowable voltage range for
+		in_altvoltage0_mag_rising_reset_min.
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 870c4a9a6214..9fac806c2a5f 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -286,41 +286,6 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 	return ret < 0 ? ret : len;
 }
 
-static ssize_t ad2s1210_show_reg(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
-	unsigned int value;
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = regmap_read(st->regmap, iattr->address, &value);
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : sprintf(buf, "%d\n", value);
-}
-
-static ssize_t ad2s1210_store_reg(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned char data;
-	int ret;
-	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret)
-		return -EINVAL;
-
-	mutex_lock(&st->lock);
-	ret = regmap_write(st->regmap, iattr->address, data);
-	mutex_unlock(&st->lock);
-	return ret < 0 ? ret : len;
-}
-
 static int ad2s1210_single_conversion(struct ad2s1210_state *st,
 				      struct iio_chan_spec const *chan,
 				      int *val)
@@ -747,13 +712,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
-static IIO_DEVICE_ATTR(dos_rst_max_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_DOS_RST_MAX_THRD);
-static IIO_DEVICE_ATTR(dos_rst_min_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_DOS_RST_MIN_THRD);
-
 static const struct iio_event_spec ad2s1210_position_event_spec[] = {
 	{
 		/* Tracking error exceeds LOT threshold fault. */
@@ -871,8 +829,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_fault.dev_attr.attr,
-	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
-	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
 	NULL,
 };
 
@@ -880,6 +836,49 @@ static const struct attribute_group ad2s1210_attribute_group = {
 	.attrs = ad2s1210_attributes,
 };
 
+static ssize_t event_attr_voltage_reg_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
+	unsigned int value;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_read(st->regmap, iattr->address, &value);
+	mutex_unlock(&st->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", value * THRESHOLD_MILLIVOLT_PER_LSB);
+}
+
+static ssize_t event_attr_voltage_reg_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
+	u16 data;
+	int ret;
+
+	ret = kstrtou16(buf, 10, &data);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	ret = regmap_write(st->regmap, iattr->address,
+			   data / THRESHOLD_MILLIVOLT_PER_LSB);
+	mutex_unlock(&st->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
 static ssize_t
 in_angl1_thresh_rising_value_available_show(struct device *dev,
 					    struct device_attribute *attr,
@@ -913,6 +912,14 @@ static IIO_CONST_ATTR(in_altvoltage0_thresh_rising_value_available,
 		      THRESHOLD_RANGE_STR);
 static IIO_CONST_ATTR(in_altvoltage0_mag_rising_value_available,
 		      THRESHOLD_RANGE_STR);
+static IIO_DEVICE_ATTR(in_altvoltage0_mag_rising_reset_max, 0644,
+		       event_attr_voltage_reg_show, event_attr_voltage_reg_store,
+		       AD2S1210_REG_DOS_RST_MAX_THRD);
+static IIO_CONST_ATTR(in_altvoltage0_mag_rising_reset_max_available, THRESHOLD_RANGE_STR);
+static IIO_DEVICE_ATTR(in_altvoltage0_mag_rising_reset_min, 0644,
+		       event_attr_voltage_reg_show, event_attr_voltage_reg_store,
+		       AD2S1210_REG_DOS_RST_MIN_THRD);
+static IIO_CONST_ATTR(in_altvoltage0_mag_rising_reset_min_available, THRESHOLD_RANGE_STR);
 static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
 static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
 
@@ -921,6 +928,10 @@ static struct attribute *ad2s1210_event_attributes[] = {
 	&iio_const_attr_in_altvoltage0_thresh_falling_value_available.dev_attr.attr,
 	&iio_const_attr_in_altvoltage0_thresh_rising_value_available.dev_attr.attr,
 	&iio_const_attr_in_altvoltage0_mag_rising_value_available.dev_attr.attr,
+	&iio_dev_attr_in_altvoltage0_mag_rising_reset_max.dev_attr.attr,
+	&iio_const_attr_in_altvoltage0_mag_rising_reset_max_available.dev_attr.attr,
+	&iio_dev_attr_in_altvoltage0_mag_rising_reset_min.dev_attr.attr,
+	&iio_const_attr_in_altvoltage0_mag_rising_reset_min_available.dev_attr.attr,
 	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
 	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
 	NULL,

-- 
2.42.0

