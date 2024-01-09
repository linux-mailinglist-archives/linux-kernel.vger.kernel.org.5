Return-Path: <linux-kernel+bounces-21203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16D828BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AF71C247CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE843C684;
	Tue,  9 Jan 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drgB2zRV"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67F3BB4C;
	Tue,  9 Jan 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704823222; x=1736359222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1ovR6+O75gSajU4QJ+Ao6qPau2jMgalmF2X5drMR4I=;
  b=drgB2zRVjmXqL2vyEt4AwYvpIBX2cquGG9a0s//4YzDWwfTF1kfNzQ2x
   C6FY1lBkzlr+iC6TZbRZd92MSNSsoj9C0CBQB/tvQnPbrhd2ri4mYjAmw
   Z4d6WyOiW4J3K4ZKt0m+sPrWhzWCu2UkeziwlUPHGmMdeby+i3tG8HYfy
   jeVTUAhyPNmBJbT3VWhJKgAmijEJVK6iv4KYo5uRj19pESmrHvvAjGKlD
   o6YJfMKT6Y9toI61eB6AUtsqCAyL+04QlCUUtT03Pk4VPswHhTTLneE6V
   2rIJWRpG2NJ7sRlCnLa2fofcZr1SZo0goQXWhL2PDp7ejSfTCLxHBikPm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429458624"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="429458624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 10:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="852269567"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="852269567"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2024 10:00:19 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 3/4] iio: hid-sensor-als: Add light color temperature support
Date: Tue,  9 Jan 2024 10:00:06 -0800
Message-Id: <20240109180007.3373784-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
References: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

On some platforms, ambient color sensors also support light color
temperature. Add support of light color temperature.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

I don't have a system to test this patch.
Hi Basavraj,
Please test.

v3:
Simplilified as no special processing is required in als_parse_report()
v2:
Original patch from Basavaraj Natikar <Basavaraj.Natikar@amd.com> is
modified to prevent failure when the new usage id is not found in the
descriptor.

 drivers/iio/light/hid-sensor-als.c | 22 ++++++++++++++++++++++
 include/linux/hid-sensor-ids.h     |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index a7bde6b68102..0d54eb59e47d 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -16,6 +16,7 @@
 enum {
 	CHANNEL_SCAN_INDEX_INTENSITY,
 	CHANNEL_SCAN_INDEX_ILLUM,
+	CHANNEL_SCAN_INDEX_COLOR_TEMP,
 	CHANNEL_SCAN_INDEX_MAX
 };
 
@@ -43,6 +44,7 @@ struct als_state {
 static const u32 als_usage_ids[] = {
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
 	HID_USAGE_SENSOR_LIGHT_ILLUM,
+	HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
 };
 
 static const u32 als_sensitivity_addresses[] = {
@@ -74,6 +76,16 @@ static const struct iio_chan_spec als_channels[] = {
 		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	},
+	{
+		.type = IIO_COLORTEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
+		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
@@ -112,6 +124,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			min = als_state->als[chan->scan_index].logical_minimum;
 			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
+		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
+			report_id = als_state->als[chan->scan_index].report_id;
+			min = als_state->als[chan->scan_index].logical_minimum;
+			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
+			break;
 		default:
 			report_id = -1;
 			break;
@@ -235,6 +252,11 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 		als_state->scan.illum[scan_index] = sample_data;
 		ret = 0;
 		break;
+	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
+		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_COLOR_TEMP];
+		als_state->scan.illum[scan_index] = sample_data;
+		ret = 0;
+		break;
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 13b1e65fbdcc..8af4fb3e0254 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -21,6 +21,7 @@
 #define HID_USAGE_SENSOR_ALS					0x200041
 #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
+#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
 
 /* PROX (200011) */
 #define HID_USAGE_SENSOR_PROX                                   0x200011
-- 
2.43.0


