Return-Path: <linux-kernel+bounces-163946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23DD8B766A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58B2B2365E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E401171E69;
	Tue, 30 Apr 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZO2BY4xL"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF2172767
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481754; cv=none; b=eUK5xM+qdJrxmNYn3xo/0MBPCml8hHoTEhV2Om/t6sAegN2gGX1pyW2X89GGKwu6pj24YKf/lbsArJtyvKR5vHkTZrrn7IhO199zuVmDp2ls589xezKuBePDKL9YlQLfUrI50R3Dmhoj88vMJxv6JNPKdcY8R2Oauz5z7FfZvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481754; c=relaxed/simple;
	bh=Im0i0nSeZTVU1ukqye2O2p/hIKmI9wUUQGfLF9dIgdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mo5c/fYpFSwaK1h4H/MygsN+YwVctIYnSlTaag5Ks215IT0bpEAh4EoCCa2vHXyh4hGAwdI+3IjeWnMoR0RFfO2OrV/bjYr1o629vIxPEeCDxLAgSE9BerHEqgRsUU4tTH8KQ9nZg7J2lgZrYuZlHXBM1Mzn703dBaYdZD2XivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZO2BY4xL; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea2f95ec67so2298409a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714481750; x=1715086550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3aDGh51WrAJ8PgiOFsXpuERP1GOnupX3ZgEurXatu8=;
        b=ZO2BY4xLX64F0HVKthqggR/ATljB/BjPLhoKhd9b6K5WJb6WkQdipGG8mf6cW4MXaV
         dTY4PiedgcXCmdNyTXcCdE96dlgeHj5zauIyNVIgbeIjX2xE9tWM74/U4fu6l9A0zn/J
         OtrMVbgubNt/5uCK2wAaovBy9srvRNj5sQNWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481750; x=1715086550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3aDGh51WrAJ8PgiOFsXpuERP1GOnupX3ZgEurXatu8=;
        b=xSxEBN/uDH7TyqRWcbPIxxLLKFXoehXADB+70MWqVt09W6UpZClkwqknh/LTT4LivE
         RrmbPzLdnz89/L0LT/tDXoknknmd0VBLnNsou+k5mu897wWrR56dbUlRFkNP7YWfeTXx
         mzFUUJPYwfNhDVUuzqo/cjkuDEq/nkl8sfdZlZojmYkgzYf6Vugg/3gQHdBbAiIZZLrp
         szYk669IGPN4Yk2aKbNpJfsql+BWRJ7DWyd9nLbKBsruTBcOqSMiRryP47Dx8ZQr8rAm
         fkbBiQBTtqjbK2stw/NFtMgP3e/+wutwgGZ6LN+VebFD/zW3GT6WuhV69kQfXrLTqL65
         LYCA==
X-Forwarded-Encrypted: i=1; AJvYcCXvrmuBfHcmqEhmjPJsUf9/cZJnlJLZqBEcHKDthbhJsRRxvHBb1snS3v9KLjkzdXZLcFgJ0d8PsrvWqosu83Q4URzQ1HH8zkTejRMl
X-Gm-Message-State: AOJu0YzPTkooIdkO1Rn8XdjMmoceON0FShY/6vRNQBSyOmrEQcrU02tm
	yeaaBysN67fHcplwykRHBOjtLA0xDz2w4yKhDeNawNKPAWJQpieUfIPrGJvkMQ==
X-Google-Smtp-Source: AGHT+IE8F+k3g5uPOihti5THP9s3MwDIIlO9hpY6CvqxL5rmWFHHurCg96j6xwnb0ZfdYm2sA2WP/g==
X-Received: by 2002:a9d:6e0f:0:b0:6ee:3720:aaec with SMTP id e15-20020a9d6e0f000000b006ee3720aaecmr8448773otr.16.1714481750570;
        Tue, 30 Apr 2024 05:55:50 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a111000b00790f90ffc32sm1553667qkk.22.2024.04.30.05.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:55:49 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Apr 2024 12:55:36 +0000
Subject: [PATCH 4/4] media: intel/ipu6: Fix build with !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240430-fix-ipu6-v1-4-9b31fbbce6e4@chromium.org>
References: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
In-Reply-To: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Modify the code so it can be compiled tested in configurations that do
not have ACPI enabled.

Fixes:
drivers/media/pci/intel/ipu-bridge.c:103:30: error: implicit declaration of function ‘acpi_device_handle’; did you mean ‘acpi_fwnode_handle’? [-Werror=implicit-function-declaration]
drivers/media/pci/intel/ipu-bridge.c:103:30: warning: initialization of ‘acpi_handle’ {aka ‘void *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
drivers/media/pci/intel/ipu-bridge.c:110:17: error: implicit declaration of function ‘for_each_acpi_dev_match’ [-Werror=implicit-function-declaration]
drivers/media/pci/intel/ipu-bridge.c:110:74: error: expected ‘;’ before ‘for_each_acpi_consumer_dev’
drivers/media/pci/intel/ipu-bridge.c:104:29: warning: unused variable ‘consumer’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:103:21: warning: unused variable ‘handle’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:166:38: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:185:43: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:191:30: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:196:30: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:202:30: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:223:31: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:236:18: error: implicit declaration of function ‘acpi_get_physical_device_location’ [-Werror=implicit-function-declaration]
drivers/media/pci/intel/ipu-bridge.c:236:56: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:238:31: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:256:31: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:275:31: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:280:30: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:469:26: error: implicit declaration of function ‘acpi_device_hid’; did you mean ‘dmi_device_id’? [-Werror=implicit-function-declaration]
drivers/media/pci/intel/ipu-bridge.c:468:74: warning: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Wformat=]
drivers/media/pci/intel/ipu-bridge.c:637:58: error: expected ‘;’ before ‘{’ token
drivers/media/pci/intel/ipu-bridge.c:696:1: warning: label ‘err_put_adev’ defined but not used [-Wunused-label]
drivers/media/pci/intel/ipu-bridge.c:693:1: warning: label ‘err_put_ivsc’ defined but not used [-Wunused-label]
drivers/media/pci/intel/ipu-bridge.c:691:1: warning: label ‘err_free_swnodes’ defined but not used [-Wunused-label]
drivers/media/pci/intel/ipu-bridge.c:632:40: warning: unused variable ‘primary’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:632:31: warning: unused variable ‘fwnode’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:733:73: error: expected ‘;’ before ‘{’ token
drivers/media/pci/intel/ipu-bridge.c:725:24: warning: unused variable ‘csi_dev’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:724:43: warning: unused variable ‘adev’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:599:12: warning: ‘ipu_bridge_instantiate_ivsc’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu-bridge.c:444:13: warning: ‘ipu_bridge_create_connection_swnodes’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu-bridge.c:297:13: warning: ‘ipu_bridge_create_fwnode_properties’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu-bridge.c:155:12: warning: ‘ipu_bridge_check_ivsc_dev’ defined but not used [-Wunused-function]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 66 +++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index e994db4f4d91..61750cc98d70 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -15,6 +15,8 @@
 #include <media/ipu-bridge.h>
 #include <media/v4l2-fwnode.h>
 
+#define ADEV_DEV(adev) ACPI_PTR(&((adev)->dev))
+
 /*
  * 92335fcf-3203-4472-af93-7b4453ac29da
  *
@@ -87,6 +89,7 @@ static const char * const ipu_vcm_types[] = {
 	"lc898212axb",
 };
 
+#if IS_ENABLED(CONFIG_ACPI)
 /*
  * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
  * instead of device and driver match to probe IVSC device.
@@ -100,13 +103,13 @@ static const struct acpi_device_id ivsc_acpi_ids[] = {
 
 static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
 {
-	acpi_handle handle = acpi_device_handle(adev);
-	struct acpi_device *consumer, *ivsc_adev;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ivsc_acpi_ids); i++) {
 		const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
+		struct acpi_device *consumer, *ivsc_adev;
 
+		acpi_handle handle = acpi_device_handle(adev);
 		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
 			/* camera sensor depends on IVSC in DSDT if exist */
 			for_each_acpi_consumer_dev(ivsc_adev, consumer)
@@ -118,6 +121,12 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 
 	return NULL;
 }
+#else
+static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
+{
+	return NULL;
+}
+#endif
 
 static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
 {
@@ -163,7 +172,7 @@ static int ipu_bridge_check_ivsc_dev(struct ipu_sensor *sensor,
 		csi_dev = ipu_bridge_get_ivsc_csi_dev(adev);
 		if (!csi_dev) {
 			acpi_dev_put(adev);
-			dev_err(&adev->dev, "Failed to find MEI CSI dev\n");
+			dev_err(ADEV_DEV(adev), "Failed to find MEI CSI dev\n");
 			return -ENODEV;
 		}
 
@@ -182,24 +191,25 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 	acpi_status status;
 	int ret = 0;
 
-	status = acpi_evaluate_object(adev->handle, id, NULL, &buffer);
+	status = acpi_evaluate_object(ACPI_PTR(adev->handle),
+				      id, NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
 	obj = buffer.pointer;
 	if (!obj) {
-		dev_err(&adev->dev, "Couldn't locate ACPI buffer\n");
+		dev_err(ADEV_DEV(adev), "Couldn't locate ACPI buffer\n");
 		return -ENODEV;
 	}
 
 	if (obj->type != ACPI_TYPE_BUFFER) {
-		dev_err(&adev->dev, "Not an ACPI buffer\n");
+		dev_err(ADEV_DEV(adev), "Not an ACPI buffer\n");
 		ret = -ENODEV;
 		goto out_free_buff;
 	}
 
 	if (obj->buffer.length > size) {
-		dev_err(&adev->dev, "Given buffer is too small\n");
+		dev_err(ADEV_DEV(adev), "Given buffer is too small\n");
 		ret = -EINVAL;
 		goto out_free_buff;
 	}
@@ -220,7 +230,7 @@ static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
 	case IPU_SENSOR_ROTATION_INVERTED:
 		return 180;
 	default:
-		dev_warn(&adev->dev,
+		dev_warn(ADEV_DEV(adev),
 			 "Unknown rotation %d. Assume 0 degree rotation\n",
 			 ssdb->degree);
 		return 0;
@@ -230,12 +240,14 @@ static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
 static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_device *adev)
 {
 	enum v4l2_fwnode_orientation orientation;
-	struct acpi_pld_info *pld;
-	acpi_status status;
+	struct acpi_pld_info *pld = NULL;
+	acpi_status status = AE_ERROR;
 
+#if IS_ENABLED(CONFIG_ACPI)
 	status = acpi_get_physical_device_location(adev->handle, &pld);
+#endif
 	if (ACPI_FAILURE(status)) {
-		dev_warn(&adev->dev, "_PLD call failed, using default orientation\n");
+		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
 	}
 
@@ -253,7 +265,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
 		break;
 	default:
-		dev_warn(&adev->dev, "Unknown _PLD panel val %d\n", pld->panel);
+		dev_warn(ADEV_DEV(adev), "Unknown _PLD panel val %d\n",
+			 pld->panel);
 		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
 		break;
 	}
@@ -272,12 +285,12 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
 		return ret;
 
 	if (ssdb.vcmtype > ARRAY_SIZE(ipu_vcm_types)) {
-		dev_warn(&adev->dev, "Unknown VCM type %d\n", ssdb.vcmtype);
+		dev_warn(ADEV_DEV(adev), "Unknown VCM type %d\n", ssdb.vcmtype);
 		ssdb.vcmtype = 0;
 	}
 
 	if (ssdb.lanes > IPU_MAX_LANES) {
-		dev_err(&adev->dev, "Number of lanes in SSDB is invalid\n");
+		dev_err(ADEV_DEV(adev), "Number of lanes in SSDB is invalid\n");
 		return -EINVAL;
 	}
 
@@ -465,8 +478,14 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 						sensor->ipu_properties);
 
 	if (sensor->csi_dev) {
+		const char *device_hid = "";
+
+#if IS_ENABLED(CONFIG_ACPI)
+		device_hid = acpi_device_hid(sensor->ivsc_adev);
+#endif
+
 		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
-			 acpi_device_hid(sensor->ivsc_adev), sensor->link);
+			 device_hid, sensor->link);
 
 		nodes[SWNODE_IVSC_HID] = NODE_SENSOR(sensor->ivsc_name,
 						     sensor->ivsc_properties);
@@ -631,11 +650,15 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 {
 	struct fwnode_handle *fwnode, *primary;
 	struct ipu_sensor *sensor;
-	struct acpi_device *adev;
+	struct acpi_device *adev = NULL;
 	int ret;
 
+#if IS_ENABLED(CONFIG_ACPI)
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-		if (!adev->status.enabled)
+#else
+	while (true) {
+#endif
+		if (!ACPI_PTR(adev->status.enabled))
 			continue;
 
 		if (bridge->n_sensors >= IPU_MAX_PORTS) {
@@ -671,7 +694,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 			goto err_free_swnodes;
 		}
 
-		sensor->adev = acpi_dev_get(adev);
+		sensor->adev = ACPI_PTR(acpi_dev_get(adev));
 
 		primary = acpi_fwnode_handle(adev);
 		primary->secondary = fwnode;
@@ -727,11 +750,16 @@ static int ipu_bridge_ivsc_is_ready(void)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
+#if IS_ENABLED(CONFIG_ACPI)
 		const struct ipu_sensor_config *cfg =
 			&ipu_supported_sensors[i];
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
-			if (!sensor_adev->status.enabled)
+#else
+		while (true) {
+			sensor_adev = NULL;
+#endif
+			if (!ACPI_PTR(sensor_adev->status.enabled))
 				continue;
 
 			adev = ipu_bridge_get_ivsc_acpi_dev(sensor_adev);

-- 
2.44.0.769.g3c40516874-goog


