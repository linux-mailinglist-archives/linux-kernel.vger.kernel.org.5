Return-Path: <linux-kernel+bounces-167591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670EA8BABAE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA061C22466
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EC1527BD;
	Fri,  3 May 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ld3QoGyS"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5B152180;
	Fri,  3 May 2024 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736160; cv=none; b=UTBJvQVamfzWxLNmdq4u58x97VoHAP6dVV/J+0ZQvsY00H08x3t/ERz+0HYnIA/rCfzyI8iPZJBAiunrew6nseTtaueHzTpSANfUZr3AN5ZQYgGJRX5aL8f9uaLc8VT8EvjSLQ6x8YY/23IQ51oq+iwKrqO6FOFRNej0UV367aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736160; c=relaxed/simple;
	bh=ypwfenohYs5/BL5XItPbndcHSZruV5YSn8gwJyQHoo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwUKFxqETxheSs30EyCMmnop80yxf/trNU8sSmReTWfv6nD9TYeMSSUf7mWmeMbt3di590oJ9hrDVM41wn+O7JliyJqy0i/UX8G4RsKj1B/Gimf8t7HpaoJY8Xnd06/sKGn24r5ZlN1HpCEXT1pipOjmDJAj6N3jN8zToD9ckGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ld3QoGyS; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714736158; x=1746272158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ypwfenohYs5/BL5XItPbndcHSZruV5YSn8gwJyQHoo0=;
  b=Ld3QoGyS64stJV8tgBz1BItJf7f/lo++cTEJTv384s4qP91cRQW7YeIZ
   mQ0aY/eFieZ4ZWNnun+rD82HaQvGbDL8iXwQgbid0YNcXiYW9IqZ1m4tM
   1Y5xxjJ1Mwd6XpNSnZZrQ1LQ13pgzkH/001bNMeVs8yqizRwELNbCxV+Y
   /TsAGX2FONdB6f/G24iiIz/PCmRSG6JmG73eJqi8+Dqm+WA/2/ETotnlr
   fjmi8fwRo2GOTVeh/tBzXUZ2V5brrwGOs7iPpB9w8opl6igmwwT0xKv39
   GpkZWcnRxWAQL4H5eeEj+fQtVateG6Zlc8O/OcjGzcsdshQqhXMJyYY8/
   Q==;
X-CSE-ConnectionGUID: BQuYb8ezTl2ndWpwkHD+rw==
X-CSE-MsgGUID: D1eitS8zQfq8FQncT0OmPA==
X-IronPort-AV: E=Sophos;i="6.07,251,1708358400"; 
   d="scan'208";a="16253413"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2024 19:34:45 +0800
IronPort-SDR: t1Ddt0WGoFUq78daPjWte9BpFI3BsGwSn0mPvgRlEje5LnkamwPxFrVFof7cvVFv+QIvpidqKm
 cuKlzT5LHgXxJ2qP7gmuxs1qhatL6krRMtfYUx8MdkytkawaST9zZjYs7OCiV6MzrYn+uh5qzN
 63Q3Kmv7+Hf3Hycyve5qnE5WMu0Do8kyFUe+wP6FxkmxzjFSVP0ufDv7EQNpBjLfBocEhMv7P6
 wKomTNxjgGiluqd9q87FcSYJEgzazCOVACarpaGsa/UYSRfxLPGzMIrx7vr4DbUotnQBHk3QUE
 kF0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 May 2024 03:42:41 -0700
IronPort-SDR: 7Al3XXRLnUZ6oOFHuW70cf2UeRZQwpFexmhEWPnNY4tXqhWMVwcdxx1CXdaovDu1Rss01YZoK5
 6Fg/BWCbxw6CoPOfHsv3hhD7bxPZ5n6D4diRS9r8MC26fjZgeNIeI9IdtkDX/Eke+VpyV0jieO
 RvdrcO/RA58iUef11M0XsqT7Rrbc61o4NXXZRTQDeayQlE43T/GWakjfZZXmRnpYXMtsAqiSKw
 eifQbF3W9EHPVtXakuGGUa0jTTQhhJZ0VbxFQyZtjI18ymkhT88mc0Us51hREuR9/GKanrbg5T
 Hv8=
WDCIronportException: Internal
Received: from 5cg1421g9c.ad.shared (HELO BXYGM33.ad.shared) ([10.225.33.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 May 2024 04:34:40 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2] scsi: ufs: Allow RTT negotiation
Date: Fri,  3 May 2024 14:34:29 +0300
Message-ID: <20240503113429.7220-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtt-upiu packets precede any data-out upiu packets, thus
synchronizing the data input to the device: this mostly applies to write
operations, but there are other operations that requires rtt as well.

There are several rules binding this rtt - data-out dialog, specifically
There can be at most outstanding bMaxNumOfRTT such packets.  This might
have an effect on write performance (sequential write in particular), as
each data-out upiu must wait for its rtt sibling.

UFSHCI expects bMaxNumOfRTT to be min(bDeviceRTTCap, NORTT). However,
as of today, there does not appears to be no-one who sets it: not the
host controller nor the driver.  It wasn't an issue up to now:
bMaxNumOfRTT is set to 2 after manufacturing, and wasn't limiting the
write performance.

UFS4.0, and specifically gear 5 changes this, and requires the device to
be more attentive.  This doesn't come free - the device has to allocate
more resources to that end, but the sequential write performance
improvement is significant. Early measurements shows 25% gain when
moving from rtt 2 to 9. Therefore, set bMaxNumOfRTT to be
min(bDeviceRTTCap, NORTT) as UFSHCI expects.

Signed-off-by: Avri Altman <avri.altman@wdc.com>

---
Changes since v1:
- bMaxNumOfRTT is a Persistent attribute - do not override if it was
  written (Bean)
---
 drivers/ufs/core/ufshcd.c | 36 ++++++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h      |  2 ++
 include/ufs/ufshci.h      |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0819ddafe7a6..c472bfdf071e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -102,6 +102,9 @@
 /* Default RTC update every 10 seconds */
 #define UFS_RTC_UPDATE_INTERVAL_MS (10 * MSEC_PER_SEC)
 
+/* bMaxNumOfRTT is equal to two after device manufacturing */
+#define DEFAULT_MAX_NUM_RTT 2
+
 /* UFSHC 4.0 compliant HC support this mode. */
 static bool use_mcq_mode = true;
 
@@ -2405,6 +2408,8 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 	((hba->capabilities & MASK_TASK_MANAGEMENT_REQUEST_SLOTS) >> 16) + 1;
 	hba->reserved_slot = hba->nutrs - 1;
 
+	hba->nortt = FIELD_GET(MASK_NUMBER_OUTSTANDING_RTT, hba->capabilities) + 1;
+
 	/* Read crypto capabilities */
 	err = ufshcd_hba_init_crypto_capabilities(hba);
 	if (err) {
@@ -8119,6 +8124,35 @@ static void ufshcd_ext_iid_probe(struct ufs_hba *hba, u8 *desc_buf)
 	dev_info->b_ext_iid_en = ext_iid_en;
 }
 
+static void ufshcd_rtt_set(struct ufs_hba *hba, u8 *desc_buf)
+{
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	u32 rtt = 0;
+	u32 dev_rtt = 0;
+
+	/* RTT override makes sense only for UFS-4.0 and above */
+	if (dev_info->wspecversion < 0x400)
+		return;
+
+	if (ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				    QUERY_ATTR_IDN_MAX_NUM_OF_RTT, 0, 0, &dev_rtt)) {
+		dev_err(hba->dev, "failed reading bMaxNumOfRTT\n");
+		return;
+	}
+
+	/* do not override if it was already written */
+	if (dev_rtt != DEFAULT_MAX_NUM_RTT)
+		return;
+
+	rtt = min_t(int, desc_buf[DEVICE_DESC_PARAM_RTT_CAP], hba->nortt);
+	if (rtt == dev_rtt)
+		return;
+
+	if (ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+				    QUERY_ATTR_IDN_MAX_NUM_OF_RTT, 0, 0, &rtt))
+		dev_err(hba->dev, "failed writing bMaxNumOfRTT\n");
+}
+
 void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
 			     const struct ufs_dev_quirk *fixups)
 {
@@ -8278,6 +8312,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	if (hba->ext_iid_sup)
 		ufshcd_ext_iid_probe(hba, desc_buf);
 
+	ufshcd_rtt_set(hba, desc_buf);
+
 	/*
 	 * ufshcd_read_string_desc returns size of the string
 	 * reset the error value
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index bad88bd91995..d74bd2d67b06 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -819,6 +819,7 @@ enum ufshcd_mcq_opr {
  * @capabilities: UFS Controller Capabilities
  * @mcq_capabilities: UFS Multi Circular Queue capabilities
  * @nutrs: Transfer Request Queue depth supported by controller
+ * @nortt - Max outstanding RTTs supported by controller
  * @nutmrs: Task Management Queue depth supported by controller
  * @reserved_slot: Used to submit device commands. Protected by @dev_cmd.lock.
  * @ufs_version: UFS Version to which controller complies
@@ -957,6 +958,7 @@ struct ufs_hba {
 
 	u32 capabilities;
 	int nutrs;
+	int nortt;
 	u32 mcq_capabilities;
 	int nutmrs;
 	u32 reserved_slot;
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 385e1c6b8d60..c50f92bf2e1d 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -68,6 +68,7 @@ enum {
 /* Controller capability masks */
 enum {
 	MASK_TRANSFER_REQUESTS_SLOTS		= 0x0000001F,
+	MASK_NUMBER_OUTSTANDING_RTT		= 0x0000FF00,
 	MASK_TASK_MANAGEMENT_REQUEST_SLOTS	= 0x00070000,
 	MASK_EHSLUTRD_SUPPORTED			= 0x00400000,
 	MASK_AUTO_HIBERN8_SUPPORT		= 0x00800000,
-- 
2.42.0


