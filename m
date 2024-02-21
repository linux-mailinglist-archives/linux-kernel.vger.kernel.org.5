Return-Path: <linux-kernel+bounces-74960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C30E85E07C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32ABE288F26
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78280BF3;
	Wed, 21 Feb 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lpr7cSiy"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86757FBBC;
	Wed, 21 Feb 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527927; cv=none; b=jYQmqW0nATMzOPdScOAzm2T4BngJiviKRxpI8kgRcNliqnHfCtZeSW/ffnhP0qwGYDXSKdGBPdWUlduSSeyiAl5wMWi4d4DKQm+m2nqrJ9J11hn/l+m00VN82aG0dH0+rxu1W6+EwFssdVo5mIJRnkLOsAEE8wy4UKrnMWHbdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527927; c=relaxed/simple;
	bh=P1BHzkuWSjIzuWkSow29+n9tVFKJ7V5CgSlp5Ealq+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kn0/xri7VzFLYuPVKO1BBAUSO9CAUFhudSK2H+YsvefFy/uypzGa3CQtnASkySqVjOZd7j1Djr1GDstnibsW1iXRvMv7Rhzx2ODT5cTVt3q/syjSgXAhdzJqBuFKUwECXX0xlf6Fdh2+57ghpvHwO3vJ5Nc0K0vrTY5IsvBzY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lpr7cSiy; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LCUQsI011338;
	Wed, 21 Feb 2024 09:05:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Uo+dEY+Nyt9VJFpgVFoLbOjBVkQZDZkESRiC9k7HK5U=; b=
	lpr7cSiyf9qq8IGE8XXUFAo4hOjjBUrjrjC75FjgpoKMCiypLzb4pNOyF1IlZkkE
	xwc6O1ZORc7cnGuqyvubOn849f0Je2cmiOESURql9mNCCVYy6RTVpQSM+7I8PlL7
	4YsL44ZSQBWvgEERIBgLAwqtv1hsYi0w1zNDLknM7aXedNpBVu0U/jiHev9HHZRD
	dBm/pg40ZzOIY8AVi4/YBl2PDAGD5bv4DhvNTq+OEI0sA/F5fF995fZgD2r/OeMj
	NPhWRilCIz3WB9jvBab8qgPZsGZCxj6imyi3xLh9IYAZBLxH7q29EgUuTM2xS4SO
	WYb888e7TIVixGkdlwcvhg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205h4tk-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:05:11 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:05:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 21 Feb 2024 15:05:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3EC9582024B;
	Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 4/9] ASoC: cs-amp-lib: Add helpers for factory calibration data
Date: Wed, 21 Feb 2024 15:05:02 +0000
Message-ID: <20240221150507.1039979-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240221150507.1039979-1-rf@opensource.cirrus.com>
References: <20240221150507.1039979-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oR4SXLnghigTqPRSKywwA1Fde1o-e8iq
X-Proofpoint-GUID: oR4SXLnghigTqPRSKywwA1Fde1o-e8iq
X-Proofpoint-Spam-Reason: safe

Create a new library for code that is used by multiple Cirrus Logic
amps. This initially implements extracting amp calibration data
from EFI and writing it to firmware controls.

During factory calibration of built-in speakers the firmware
calibration constants are stored in an EFI file. The file contains
an array of calibration constants for each of the speakers.
cs_amp_get_calibration_data() searches for an entry matching the
requested UID stamp, otherwise by array index. If the data is found in
EFI the constants for that speaker are copied back to the caller.

If EFI is not enabled, the cs_amp_get_calibration_data() implementation
will compile to simply return -ENOENT and the linker can drop the code.

The code to write calibration controls uses wm_adsp. Not all drivers
use wm_adsp (notably, HDA drivers do not) so cs-amp-lib does not force
building of wm_adsp. Instead, the code will compile away the call to
wm_adsp_write_ctl() if wm_adsp is not reachable.

This strategy of conditional code allows cs-amp-lib to be shared by
multiple drivers without forcing inclusion of other modules that might
be unnecessary.

The calls to efi.get_variable() and wm_adsp_write_ctl() are in
small wrapper functions. This is so that a KUNIT_STATIC_STUB_REDIRECT
can be added in a future patch to redirect these calls to replacement
functions for KUnit testing.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h    |  52 +++++++
 sound/soc/codecs/Kconfig      |   3 +
 sound/soc/codecs/Makefile     |   2 +
 sound/soc/codecs/cs-amp-lib.c | 256 ++++++++++++++++++++++++++++++++++
 4 files changed, 313 insertions(+)
 create mode 100644 include/sound/cs-amp-lib.h
 create mode 100644 sound/soc/codecs/cs-amp-lib.c

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
new file mode 100644
index 000000000000..35f7bd848276
--- /dev/null
+++ b/include/sound/cs-amp-lib.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef CS_AMP_LIB_H
+#define CS_AMP_LIB_H
+
+#include <linux/efi.h>
+#include <linux/types.h>
+
+struct wm_adsp;
+
+struct cirrus_amp_cal_data {
+	u32 calTarget[2];
+	u32 calTime[2];
+	s8  calAmbient;
+	u8  calStatus;
+	u16 calR;
+} __packed;
+
+struct cirrus_amp_efi_data {
+	u32 size;
+	u32 count;
+	struct cirrus_amp_cal_data data[];
+} __packed;
+
+/**
+ * struct cirrus_amp_cal_controls - definition of firmware calibration controls
+ * @alg_id:	ID of algorithm containing the controls.
+ * @mem_region:	DSP memory region containing the controls.
+ * @ambient:	Name of control for calAmbient value.
+ * @calr:	Name of control for calR value.
+ * @status:	Name of control for calStatus value.
+ * @checksum:	Name of control for checksum value.
+ */
+struct cirrus_amp_cal_controls {
+	unsigned int alg_id;
+	int mem_region;
+	const char *ambient;
+	const char *calr;
+	const char *status;
+	const char *checksum;
+};
+
+int cs_amp_write_cal_coeffs(struct wm_adsp *dsp,
+			    const struct cirrus_amp_cal_controls *controls,
+			    const struct cirrus_amp_cal_data *data);
+int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
+				    struct cirrus_amp_cal_data *out_data);
+#endif /* CS_AMP_LIB_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 027d9da85251..8356bd1256d8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -729,6 +729,9 @@ config SND_SOC_CROS_EC_CODEC
 	  If you say yes here you will get support for the
 	  ChromeOS Embedded Controller's Audio Codec.
 
+config SND_SOC_CS_AMP_LIB
+	tristate
+
 config SND_SOC_CS35L32
 	tristate "Cirrus Logic CS35L32 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 4080646b2dd6..0fc40640e5d0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -59,6 +59,7 @@ snd-soc-chv3-codec-objs := chv3-codec.o
 snd-soc-cpcap-objs := cpcap.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cros-ec-codec-objs := cros_ec_codec.o
+snd-soc-cs-amp-lib-objs := cs-amp-lib.o
 snd-soc-cs35l32-objs := cs35l32.o
 snd-soc-cs35l33-objs := cs35l33.o
 snd-soc-cs35l34-objs := cs35l34.o
@@ -452,6 +453,7 @@ obj-$(CONFIG_SND_SOC_CHV3_CODEC) += snd-soc-chv3-codec.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CPCAP)	+= snd-soc-cpcap.o
 obj-$(CONFIG_SND_SOC_CROS_EC_CODEC)	+= snd-soc-cros-ec-codec.o
+obj-$(CONFIG_SND_SOC_CS_AMP_LIB)	+= snd-soc-cs-amp-lib.o
 obj-$(CONFIG_SND_SOC_CS35L32)	+= snd-soc-cs35l32.o
 obj-$(CONFIG_SND_SOC_CS35L33)	+= snd-soc-cs35l33.o
 obj-$(CONFIG_SND_SOC_CS35L34)	+= snd-soc-cs35l34.o
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
new file mode 100644
index 000000000000..0e1249342a78
--- /dev/null
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Common code for Cirrus Logic Smart Amplifiers
+//
+// Copyright (C) 2024 Cirrus Logic, Inc. and
+//               Cirrus Logic International Semiconductor Ltd.
+
+#include <asm/byteorder.h>
+#include <linux/dev_printk.h>
+#include <linux/efi.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <sound/cs-amp-lib.h>
+#include "wm_adsp.h"
+
+#define CS_AMP_CAL_GUID \
+	EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3)
+
+#define CS_AMP_CAL_NAME	L"CirrusSmartAmpCalibrationData"
+
+static int cs_amp_write_cal_coeff(struct wm_adsp *dsp,
+				  const struct cirrus_amp_cal_controls *controls,
+				  const char *ctl_name, u32 val)
+{
+	__be32 beval = cpu_to_be32(val);
+	int ret;
+
+	if (IS_REACHABLE(CONFIG_SND_SOC_WM_ADSP)) {
+		ret = wm_adsp_write_ctl(dsp, ctl_name, controls->mem_region,
+					controls->alg_id, &beval, sizeof(beval));
+		if (ret)
+			dev_err(dsp->cs_dsp.dev, "Failed to write to '%s': %d\n", ctl_name, ret);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
+static int _cs_amp_write_cal_coeffs(struct wm_adsp *dsp,
+				    const struct cirrus_amp_cal_controls *controls,
+				    const struct cirrus_amp_cal_data *data)
+{
+	int ret;
+
+	dev_dbg(dsp->cs_dsp.dev, "Calibration: Ambient=%#x, Status=%#x, CalR=%d\n",
+		data->calAmbient, data->calStatus, data->calR);
+
+	ret = cs_amp_write_cal_coeff(dsp, controls, controls->ambient, data->calAmbient);
+	if (ret)
+		return ret;
+
+	ret = cs_amp_write_cal_coeff(dsp, controls, controls->calr, data->calR);
+	if (ret)
+		return ret;
+
+	ret = cs_amp_write_cal_coeff(dsp, controls, controls->status, data->calStatus);
+	if (ret)
+		return ret;
+
+	ret = cs_amp_write_cal_coeff(dsp, controls, controls->checksum, data->calR + 1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * cs_amp_write_cal_coeffs - Write calibration data to firmware controls.
+ * @dsp:	Pointer to struct wm_adsp.
+ * @controls:	Pointer to definition of firmware controls to be written.
+ * @data:	Pointer to calibration data.
+ *
+ * Returns: 0 on success, else negative error value.
+ */
+int cs_amp_write_cal_coeffs(struct wm_adsp *dsp,
+			    const struct cirrus_amp_cal_controls *controls,
+			    const struct cirrus_amp_cal_data *data)
+{
+	if (IS_REACHABLE(CONFIG_SND_SOC_WM_ADSP))
+		return _cs_amp_write_cal_coeffs(dsp, controls, data);
+	else
+		return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_write_cal_coeffs, SND_SOC_CS_AMP_LIB);
+
+static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
+					    efi_guid_t *guid,
+					    unsigned long *size,
+					    void *buf)
+{
+	u32 attr;
+
+	if (IS_ENABLED(CONFIG_EFI))
+		return efi.get_variable(name, guid, &attr, size, buf);
+
+	return EFI_NOT_FOUND;
+}
+
+static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
+{
+	struct cirrus_amp_efi_data *efi_data;
+	unsigned long data_size = 0;
+	u8 *data;
+	efi_status_t status;
+	int ret;
+
+	/* Get real size of UEFI variable */
+	status = cs_amp_get_efi_variable(CS_AMP_CAL_NAME, &CS_AMP_CAL_GUID, &data_size, NULL);
+	if (status != EFI_BUFFER_TOO_SMALL)
+		return ERR_PTR(-ENOENT);
+
+	if (data_size < sizeof(*efi_data)) {
+		dev_err(dev, "EFI cal variable truncated\n");
+		return ERR_PTR(-EOVERFLOW);
+	}
+
+	/* Get variable contents into buffer */
+	data = kmalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	status = cs_amp_get_efi_variable(CS_AMP_CAL_NAME, &CS_AMP_CAL_GUID, &data_size, data);
+	if (status != EFI_SUCCESS) {
+		ret = efi_status_to_err(status);
+		goto err;
+	}
+
+	efi_data = (struct cirrus_amp_efi_data *)data;
+	dev_dbg(dev, "Calibration: Size=%d, Amp Count=%d\n", efi_data->size, efi_data->count);
+
+	if ((efi_data->count > 128) ||
+	    offsetof(struct cirrus_amp_efi_data, data[efi_data->count]) > data_size) {
+		dev_err(dev, "EFI cal variable truncated\n");
+		ret = -EOVERFLOW;
+		goto err;
+	}
+
+	return efi_data;
+
+err:
+	kfree(data);
+	dev_err(dev, "Failed to read calibration data from EFI: %d\n", ret);
+
+	return ERR_PTR(ret);
+}
+
+static u64 cs_amp_cal_target_u64(const struct cirrus_amp_cal_data *data)
+{
+	return ((u64)data->calTarget[1] << 32) | data->calTarget[0];
+}
+
+static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
+					    struct cirrus_amp_cal_data *out_data)
+{
+	struct cirrus_amp_efi_data *efi_data;
+	struct cirrus_amp_cal_data *cal = NULL;
+	int i, ret;
+
+	efi_data = cs_amp_get_cal_efi_buffer(dev);
+	if (IS_ERR(efi_data))
+		return PTR_ERR(efi_data);
+
+	if (target_uid) {
+		for (i = 0; i < efi_data->count; ++i) {
+			u64 cal_target = cs_amp_cal_target_u64(&efi_data->data[i]);
+
+			/* Skip entries with unpopulated silicon ID */
+			if (cal_target == 0)
+				continue;
+
+			if (cal_target == target_uid) {
+				cal = &efi_data->data[i];
+				break;
+			}
+		}
+	}
+
+	if (!cal && (amp_index >= 0) && (amp_index < efi_data->count)) {
+		u64 cal_target = cs_amp_cal_target_u64(&efi_data->data[amp_index]);
+
+		/*
+		 * Treat unpopulated cal_target as a wildcard.
+		 * If target_uid != 0 we can only get here if cal_target == 0
+		 * or it didn't match any cal_target value.
+		 * If target_uid == 0 it is a wildcard.
+		 */
+		if ((cal_target == 0) || (target_uid == 0))
+			cal = &efi_data->data[amp_index];
+		else
+			dev_warn(dev, "Calibration entry %d does not match silicon ID", amp_index);
+	}
+
+	if (cal) {
+		memcpy(out_data, cal, sizeof(*out_data));
+		ret = 0;
+	} else {
+		dev_warn(dev, "No calibration for silicon ID %#llx\n", target_uid);
+		ret = -ENOENT;
+	}
+
+	kfree(efi_data);
+
+	return ret;
+}
+
+/**
+ * cs_amp_get_efi_calibration_data - get an entry from calibration data in EFI.
+ * @dev:	struct device of the caller.
+ * @target_uid:	UID to match, or zero to ignore UID matching.
+ * @amp_index:	Entry index to use, or -1 to prevent lookup by index.
+ * @out_data:	struct cirrus_amp_cal_data where the entry will be copied.
+ *
+ * This function can perform 3 types of lookup:
+ *
+ * (target_uid > 0, amp_index >= 0)
+ *	UID search with fallback to using the array index.
+ *	Search the calibration data for a non-zero calTarget that matches
+ *	target_uid, and if found return that entry. Else, if the entry at
+ *	[amp_index] has calTarget == 0, return that entry. Else fail.
+ *
+ * (target_uid > 0, amp_index < 0)
+ *	UID search only.
+ *	Search the calibration data for a non-zero calTarget that matches
+ *	target_uid, and if found return that entry. Else fail.
+ *
+ * (target_uid == 0, amp_index >= 0)
+ *	Array index fetch only.
+ *	Return the entry at [amp_index].
+ *
+ * An array lookup will be skipped if amp_index exceeds the number of
+ * entries in the calibration array, and in this case the return will
+ * be -ENOENT. An out-of-range amp_index does not prevent matching by
+ * target_uid - it has the same effect as passing amp_index < 0.
+ *
+ * If the EFI data is too short to be a valid entry, or the entry count
+ * in the EFI data overflows the actual length of the data, this function
+ * returns -EOVERFLOW.
+ *
+ * Return: 0 if the entry was found, -ENOENT if no entry was found,
+ *	   -EOVERFLOW if the EFI file is corrupt, else other error value.
+ */
+int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
+				    struct cirrus_amp_cal_data *out_data)
+{
+	if (IS_ENABLED(CONFIG_EFI))
+		return _cs_amp_get_efi_calibration_data(dev, target_uid, amp_index, out_data);
+	else
+		return -ENOENT;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_get_efi_calibration_data, SND_SOC_CS_AMP_LIB);
+
+MODULE_DESCRIPTION("Cirrus Logic amplifier library");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
-- 
2.30.2


