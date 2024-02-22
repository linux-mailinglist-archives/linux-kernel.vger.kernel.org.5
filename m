Return-Path: <linux-kernel+bounces-77034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F086004A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27F9286274
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90605158D95;
	Thu, 22 Feb 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jiNxN660"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3B1586F8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624882; cv=none; b=izYc3XUDbOUS2/s7WmCyv7C/x9bw0FYGuWEv86tYmsjU10GD23zW5dotPDwGuytlv6OQ4S9tAbI0wYeC53mmmR0vrPn0fi1cck6uwnpaeCOTmrYMPZWLBI5EhgOWeZeNP76kJCrQVsp62cBwMK0+kijMdj4Pau7XH2yh+fdqBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624882; c=relaxed/simple;
	bh=th9s6yw/+ZCI+/RwbKrTbxk+HzgJy20Rh4Mafx057bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhVy2TLRQTIGgn3hRx2IaMnBq/yNq4QfImVYm9zYoFlHeWDcOzHsnaV4uXylds7PL9M4iePyyk9Rdg3IbEW8AIGsNWjNDHaEOscIqVBOQ9asLcROqRskvFoa3U1wmFkfp0lJrs4xT6p79T3cm8jAk0LIKx066FxSxZ8hANCzRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jiNxN660; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MEp3Bg028257;
	Thu, 22 Feb 2024 18:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yzfPZ40K2EM64idCJvQoRhRLo+OrI7ETQVCz/2ZJqpE=; b=ji
	NxN660k3g7wv7cPg3MnD2GI2PkMjx+GFExSHagUYGougOTytTZE1hv5F47abDzhv
	680I06OTRXwHK6AahYiau5bp6GBzFi1qi7d1wUUAgCQIBTJ47ySuCjzoRUG4/FL/
	T0346yAM8ZxSst78FeKcAgdVSTvky4r045QGjhwGNK33e3O2yCwnJdT8tw9Z9bzm
	9Ev/gXI2JgPKhnYXiDf9mLFyRibY+uHG4ys7kCu8YzcWeOmq3b7Dp/BeIJWHpMXs
	lVS4KqZn9LkkLyovMSB1jh0WGSPLqfn4fV6e9C+dQ1GORREbIG0eM/BxCBEXw99Q
	nMZVEnRyYanjYKZp1feQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdvwwagr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI111a006299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:01 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:00:59 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 2/8] treewide: rename firmware_request_nowarn()
Date: Thu, 22 Feb 2024 23:30:27 +0530
Message-ID: <20240222180033.23775-3-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240222180033.23775-1-quic_mojha@quicinc.com>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Pdgh1tnGUlPnY_xse7YC_5nrFtnY64_X
X-Proofpoint-GUID: Pdgh1tnGUlPnY_xse7YC_5nrFtnY64_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402220140

Rename firmware_request_nowarn() to align with
other request_firmware family functions.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/driver-api/firmware/request_firmware.rst      | 4 ++--
 drivers/accel/ivpu/ivpu_fw.c                                | 2 +-
 drivers/base/firmware_loader/main.c                         | 6 +++---
 drivers/bluetooth/btbcm.c                                   | 2 +-
 drivers/bluetooth/btintel.c                                 | 4 ++--
 drivers/bluetooth/hci_bcm4377.c                             | 4 ++--
 drivers/crypto/ccp/sev-dev.c                                | 6 +++---
 drivers/crypto/inside-secure/safexcel.c                     | 4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c                    | 2 +-
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c                | 2 +-
 drivers/input/touchscreen/silead.c                          | 2 +-
 drivers/media/tuners/si2157.c                               | 2 +-
 drivers/memory/brcmstb_dpfe.c                               | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                   | 2 +-
 drivers/net/wireless/ath/ath10k/core.c                      | 2 +-
 drivers/net/wireless/ath/ath10k/testmode.c                  | 2 +-
 drivers/net/wireless/ath/ath11k/core.c                      | 2 +-
 drivers/net/wireless/ath/ath12k/core.c                      | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c                | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c            | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c             | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c         | 2 +-
 drivers/net/wireless/realtek/rtw89/fw.c                     | 2 +-
 drivers/net/wireless/silabs/wfx/fwio.c                      | 2 +-
 drivers/usb/host/xhci-pci-renesas.c                         | 2 +-
 include/linux/firmware.h                                    | 4 ++--
 sound/pci/hda/cs35l41_hda.c                                 | 2 +-
 sound/pci/hda/cs35l56_hda.c                                 | 2 +-
 sound/soc/codecs/wm_adsp.c                                  | 2 +-
 sound/soc/sof/fw-file-profile.c                             | 4 ++--
 31 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index 0d6ea0329995..0201334bc308 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -20,10 +20,10 @@ request_firmware
 .. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware
 
-firmware_request_nowarn
+request_firmware_nowarn
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_nowarn
+   :functions: request_firmware_nowarn
 
 firmware_request_platform
 -------------------------
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 6576232f3e67..11c27fe860f2 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -76,7 +76,7 @@ static int ivpu_fw_request(struct ivpu_device *vdev)
 		if (fw_names[i].gen != ivpu_hw_gen(vdev))
 			continue;
 
-		ret = firmware_request_nowarn(&vdev->fw->file, fw_names[i].name, vdev->drm.dev);
+		ret = request_firmware_nowarn(&vdev->fw->file, fw_names[i].name, vdev->drm.dev);
 		if (!ret) {
 			vdev->fw->name = fw_names[i].name;
 			return 0;
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 645d658facae..cb681f4069b8 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -975,7 +975,7 @@ request_firmware(const struct firmware **firmware_p, const char *name,
 EXPORT_SYMBOL(request_firmware);
 
 /**
- * firmware_request_nowarn() - request for an optional fw module
+ * request_firmware_nowarn() - request for an optional fw module
  * @firmware: pointer to firmware image
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
@@ -987,13 +987,13 @@ EXPORT_SYMBOL(request_firmware);
  * therefore up to the driver to check for the return value of this call and to
  * decide when to inform the users of errors.
  **/
-int firmware_request_nowarn(const struct firmware **firmware, const char *name,
+int request_firmware_nowarn(const struct firmware **firmware, const char *name,
 			    struct device *device)
 {
 	return _request_firmware(firmware, name, device, NULL, 0, 0,
 				 FW_OPT_UEVENT | FW_OPT_NO_WARN);
 }
-EXPORT_SYMBOL_GPL(firmware_request_nowarn);
+EXPORT_SYMBOL_GPL(request_firmware_nowarn);
 
 /**
  * request_firmware_direct() - load firmware directly without usermode helper
diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0a5445ac5e1b..94ebf6113c44 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -672,7 +672,7 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done, bool use_autobaud
 	fw_name_count++;
 
 	for (i = 0; i < fw_name_count; i++) {
-		err = firmware_request_nowarn(&fw, fw_name[i], &hdev->dev);
+		err = request_firmware_nowarn(&fw, fw_name[i], &hdev->dev);
 		if (err == 0) {
 			bt_dev_info(hdev, "%s '%s' Patch",
 				    hw_name ? hw_name : "BCM", fw_name[i]);
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cdc5c08824a0..6ec90754a76f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2057,7 +2057,7 @@ static int btintel_download_fw(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
+	err = request_firmware_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		if (!btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
 			/* Firmware has already been loaded */
@@ -2246,7 +2246,7 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	}
 
 	btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
-	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
+	err = request_firmware_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		if (!btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
 			/* Firmware has already been loaded */
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 9a7243d5db71..fd06707a6709 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -1207,10 +1207,10 @@ static const struct firmware *bcm4377_request_blob(struct bcm4377_data *bcm4377,
 	dev_dbg(&bcm4377->pdev->dev, "Trying to load firmware: '%s' or '%s'\n",
 		name0, name1);
 
-	ret = firmware_request_nowarn(&fw, name0, &bcm4377->pdev->dev);
+	ret = request_firmware_nowarn(&fw, name0, &bcm4377->pdev->dev);
 	if (!ret)
 		return fw;
-	ret = firmware_request_nowarn(&fw, name1, &bcm4377->pdev->dev);
+	ret = request_firmware_nowarn(&fw, name1, &bcm4377->pdev->dev);
 	if (!ret)
 		return fw;
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e4d3f45242f6..a2ded1f9d940 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -761,9 +761,9 @@ static int sev_get_firmware(struct device *dev,
 	 *
 	 * Fall-back to using generic name: sev.fw
 	 */
-	if ((firmware_request_nowarn(firmware, fw_name_specific, dev) >= 0) ||
-	    (firmware_request_nowarn(firmware, fw_name_subset, dev) >= 0) ||
-	    (firmware_request_nowarn(firmware, SEV_FW_FILE, dev) >= 0))
+	if ((request_firmware_nowarn(firmware, fw_name_specific, dev) >= 0) ||
+	    (request_firmware_nowarn(firmware, fw_name_subset, dev) >= 0) ||
+	    (request_firmware_nowarn(firmware, SEV_FW_FILE, dev) >= 0))
 		return 0;
 
 	return -ENOENT;
diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index f5c1912aa564..791a7ff25371 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -429,7 +429,7 @@ static int eip197_load_firmwares(struct safexcel_crypto_priv *priv)
 retry_fw:
 	for (i = 0; i < FW_NB; i++) {
 		snprintf(fw_path, 37, "inside-secure/%s/%s", dir, fw_name[i]);
-		ret = firmware_request_nowarn(&fw[i], fw_path, priv->dev);
+		ret = request_firmware_nowarn(&fw[i], fw_path, priv->dev);
 		if (ret) {
 			if (minifw || priv->data->version != EIP197B_MRVL)
 				goto release_fw;
@@ -437,7 +437,7 @@ static int eip197_load_firmwares(struct safexcel_crypto_priv *priv)
 			/* Fallback to the old firmware location for the
 			 * EIP197b.
 			 */
-			ret = firmware_request_nowarn(&fw[i], fw_name[i],
+			ret = request_firmware_nowarn(&fw[i], fw_name[i],
 						      priv->dev);
 			if (ret)
 				goto release_fw;
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
index 362639162ed6..205cf027870f 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
@@ -785,7 +785,7 @@ static int try_firmware_load(struct intel_uc_fw *uc_fw, const struct firmware **
 	struct device *dev = gt->i915->drm.dev;
 	int err;
 
-	err = firmware_request_nowarn(fw, uc_fw->file_selected.path, dev);
+	err = request_firmware_nowarn(fw, uc_fw->file_selected.path, dev);
 
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
index adc60b25f8e6..febfabb17405 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
@@ -91,7 +91,7 @@ nvkm_firmware_get(const struct nvkm_subdev *subdev, const char *fwname, int ver,
 	else
 		snprintf(f, sizeof(f), "nvidia/%s/%s.bin", cname, fwname);
 
-	if (!firmware_request_nowarn(fw, f, device->dev)) {
+	if (!request_firmware_nowarn(fw, f, device->dev)) {
 		nvkm_debug(subdev, "firmware \"%s\" loaded - %zu byte(s)\n",
 			   f, (*fw)->size);
 		return 0;
diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 62f562ad5026..52477e450b02 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -426,7 +426,7 @@ static int silead_ts_load_fw(struct i2c_client *client)
 	 * succeeds we apply an (optional) set of alternative min/max values from the
 	 * "silead,efi-fw-min-max" property.
 	 */
-	error = firmware_request_nowarn(&fw, data->fw_name, dev);
+	error = request_firmware_nowarn(&fw, data->fw_name, dev);
 	if (error) {
 		error = firmware_request_platform(&fw, data->fw_name, dev);
 		if (error) {
diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index def06c262ea2..64fbb24c0758 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -98,7 +98,7 @@ static int si2157_load_firmware(struct dvb_frontend *fe,
 	struct si2157_cmd cmd;
 
 	/* request the firmware, this will block and timeout */
-	ret = firmware_request_nowarn(&fw, fw_name, &client->dev);
+	ret = request_firmware_nowarn(&fw, fw_name, &client->dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 5028467b2dc9..a6e6412416d8 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -648,7 +648,7 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
 	if (!priv->dpfe_api->fw_name)
 		return -ENODEV;
 
-	ret = firmware_request_nowarn(&fw, priv->dpfe_api->fw_name, dev);
+	ret = request_firmware_nowarn(&fw, priv->dpfe_api->fw_name, dev);
 	/*
 	 * Defer the firmware download if the firmware file couldn't be found.
 	 * The root file system may not be available yet.
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dd4a9bc0dfdc..46d9e0f1bbf4 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4428,7 +4428,7 @@ static void ice_request_fw(struct ice_pf *pf)
 	 * and warning messages for other errors.
 	 */
 	if (opt_fw_filename) {
-		err = firmware_request_nowarn(&firmware, opt_fw_filename, dev);
+		err = request_firmware_nowarn(&firmware, opt_fw_filename, dev);
 		if (err) {
 			kfree(opt_fw_filename);
 			goto dflt_pkg_load;
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 0032f8aa892f..dc57a4319ae7 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -943,7 +943,7 @@ static const struct firmware *ath10k_fetch_fw_file(struct ath10k *ar,
 		dir = ".";
 
 	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
-	ret = firmware_request_nowarn(&fw, filename, ar->dev);
+	ret = request_firmware_nowarn(&fw, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
 		   filename, ret);
 
diff --git a/drivers/net/wireless/ath/ath10k/testmode.c b/drivers/net/wireless/ath/ath10k/testmode.c
index 7a9b9bbcdbfc..b9f976786a7c 100644
--- a/drivers/net/wireless/ath/ath10k/testmode.c
+++ b/drivers/net/wireless/ath/ath10k/testmode.c
@@ -146,7 +146,7 @@ static int ath10k_tm_fetch_utf_firmware_api_1(struct ath10k *ar,
 		 ar->hw_params.fw.dir, ATH10K_FW_UTF_FILE);
 
 	/* load utf firmware image */
-	ret = firmware_request_nowarn(&fw_file->firmware, filename, ar->dev);
+	ret = request_firmware_nowarn(&fw_file->firmware, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "testmode fw request '%s': %d\n",
 		   filename, ret);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 0c6ecbb9a066..9d800a8415d4 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1084,7 +1084,7 @@ const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 
 	ath11k_core_create_firmware_path(ab, file, path, sizeof(path));
 
-	ret = firmware_request_nowarn(&fw, path, ab->dev);
+	ret = request_firmware_nowarn(&fw, path, ab->dev);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 6c01b282fcd3..d160791019c8 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -137,7 +137,7 @@ const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 
 	ath12k_core_create_firmware_path(ab, file, path, sizeof(path));
 
-	ret = firmware_request_nowarn(&fw, path, ab->dev);
+	ret = request_firmware_nowarn(&fw, path, ab->dev);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 83f8ed7d00f9..b0451d97b8e2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -659,7 +659,7 @@ static int brcmf_fw_request_firmware(const struct firmware **fw,
 		if (!alt_path)
 			goto fallback;
 
-		ret = firmware_request_nowarn(fw, alt_path, fwctx->dev);
+		ret = request_firmware_nowarn(fw, alt_path, fwctx->dev);
 		kfree(alt_path);
 		if (ret == 0)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 650e4bde9c17..8b3676e87e07 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -231,7 +231,7 @@ static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 
 	iwl_pnvm_get_fs_name(trans, pnvm_name, sizeof(pnvm_name));
 
-	ret = firmware_request_nowarn(&pnvm, pnvm_name, trans->dev);
+	ret = request_firmware_nowarn(&pnvm, pnvm_name, trans->dev);
 	if (ret) {
 		IWL_DEBUG_FW(trans, "PNVM file %s not found %d\n",
 			     pnvm_name, ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 3b14f6476743..dc139849454f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -503,7 +503,7 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 	    trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_8000)
 		return;
 
-	res = firmware_request_nowarn(&fw, yoyo_bin, dev);
+	res = request_firmware_nowarn(&fw, yoyo_bin, dev);
 	IWL_DEBUG_FW(trans, "%s %s\n", res ? "didn't load" : "loaded", yoyo_bin);
 
 	if (res)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index ae34d019e588..eceaee233993 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1224,7 +1224,7 @@ static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 	const struct firmware *fw = NULL;
 	int len, ret, sem;
 
-	ret = firmware_request_nowarn(&fw, name, dev->mt76.dev);
+	ret = request_firmware_nowarn(&fw, name, dev->mt76.dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
index 6dc1f51f5658..3e1b0db7fd10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
@@ -72,7 +72,7 @@ static int mt76x0_get_firmware(struct mt76x02_dev *dev,
 	/* try to load mt7610e fw if available
 	 * otherwise fall back to mt7610u one
 	 */
-	err = firmware_request_nowarn(fw, MT7610E_FIRMWARE, dev->mt76.dev);
+	err = request_firmware_nowarn(fw, MT7610E_FIRMWARE, dev->mt76.dev);
 	if (err) {
 		dev_info(dev->mt76.dev, "%s not found, switching to %s",
 			 MT7610E_FIRMWARE, MT7610U_FIRMWARE);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 09684cea9731..d3b103419862 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1206,7 +1206,7 @@ static int rtw89_load_firmware_req(struct rtw89_dev *rtwdev,
 	}
 
 	if (nowarn)
-		ret = firmware_request_nowarn(&req->firmware, fw_name, rtwdev->dev);
+		ret = request_firmware_nowarn(&req->firmware, fw_name, rtwdev->dev);
 	else
 		ret = request_firmware(&req->firmware, fw_name, rtwdev->dev);
 
diff --git a/drivers/net/wireless/silabs/wfx/fwio.c b/drivers/net/wireless/silabs/wfx/fwio.c
index 52c7f560b062..3cdc8548a619 100644
--- a/drivers/net/wireless/silabs/wfx/fwio.c
+++ b/drivers/net/wireless/silabs/wfx/fwio.c
@@ -105,7 +105,7 @@ static int get_firmware(struct wfx_dev *wdev, u32 keyset_chip,
 
 	snprintf(filename, sizeof(filename), "%s_%02X.sec",
 		 wdev->pdata.file_fw, keyset_chip);
-	ret = firmware_request_nowarn(fw, filename, wdev->dev);
+	ret = request_firmware_nowarn(fw, filename, wdev->dev);
 	if (ret) {
 		dev_info(wdev->dev, "can't load %s, falling back to %s.sec\n",
 			 filename, wdev->pdata.file_fw);
diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 93f8b355bc70..1335e92b76fa 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -603,7 +603,7 @@ int renesas_xhci_check_request_fw(struct pci_dev *pdev,
 		return has_rom ? 0 : err;
 
 	pci_dev_get(pdev);
-	err = firmware_request_nowarn(&fw, fw_name, &pdev->dev);
+	err = request_firmware_nowarn(&fw, fw_name, &pdev->dev);
 	pci_dev_put(pdev);
 	if (err) {
 		if (has_rom) {
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 0311858b46ce..5523c9fdc92d 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -97,7 +97,7 @@ static inline bool firmware_request_builtin(struct firmware *fw,
 #if IS_REACHABLE(CONFIG_FW_LOADER)
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
-int firmware_request_nowarn(const struct firmware **fw, const char *name,
+int request_firmware_nowarn(const struct firmware **fw, const char *name,
 			    struct device *device);
 int firmware_request_platform(const struct firmware **fw, const char *name,
 			      struct device *device);
@@ -122,7 +122,7 @@ static inline int request_firmware(const struct firmware **fw,
 	return -EINVAL;
 }
 
-static inline int firmware_request_nowarn(const struct firmware **fw,
+static inline int request_firmware_nowarn(const struct firmware **fw,
 					  const char *name,
 					  struct device *device)
 {
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d3fa6e136744..a93dcae244ac 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -164,7 +164,7 @@ static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
 		s++;
 	}
 
-	ret = firmware_request_nowarn(firmware, *filename, cs35l41->dev);
+	ret = request_firmware_nowarn(firmware, *filename, cs35l41->dev);
 	if (ret != 0) {
 		dev_dbg(cs35l41->dev, "Failed to request '%s'\n", *filename);
 		kfree(*filename);
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index b61e1de8c4bf..0390fd6b6eaa 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -422,7 +422,7 @@ static int cs35l56_hda_request_firmware_file(struct cs35l56_hda *cs35l56,
 		s++;
 	}
 
-	ret = firmware_request_nowarn(firmware, *filename, cs35l56->base.dev);
+	ret = request_firmware_nowarn(firmware, *filename, cs35l56->base.dev);
 	if (ret) {
 		dev_dbg(cs35l56->base.dev, "Failed to request '%s'\n", *filename);
 		kfree(*filename);
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c01e31175015..072e3e3606e7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -772,7 +772,7 @@ static int wm_adsp_request_firmware_file(struct wm_adsp *dsp,
 		s++;
 	}
 
-	ret = firmware_request_nowarn(firmware, *filename, cs_dsp->dev);
+	ret = request_firmware_nowarn(firmware, *filename, cs_dsp->dev);
 	if (ret != 0) {
 		adsp_dbg(dsp, "Failed to request '%s'\n", *filename);
 		kfree(*filename);
diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
index 138a1ca2c4a8..819fc846d498 100644
--- a/sound/soc/sof/fw-file-profile.c
+++ b/sound/soc/sof/fw-file-profile.c
@@ -26,7 +26,7 @@ static int sof_test_firmware_file(struct device *dev,
 	if (!fw_filename)
 		return -ENOMEM;
 
-	ret = firmware_request_nowarn(&fw, fw_filename, dev);
+	ret = request_firmware_nowarn(&fw, fw_filename, dev);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to open firmware file: %s\n", fw_filename);
 		kfree(fw_filename);
@@ -78,7 +78,7 @@ static int sof_test_topology_file(struct device *dev,
 	if (!tplg_filename)
 		return -ENOMEM;
 
-	ret = firmware_request_nowarn(&fw, tplg_filename, dev);
+	ret = request_firmware_nowarn(&fw, tplg_filename, dev);
 	if (!ret)
 		release_firmware(fw);
 	else
-- 
2.43.0.254.ga26002b62827


