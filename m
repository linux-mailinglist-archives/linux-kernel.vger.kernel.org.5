Return-Path: <linux-kernel+bounces-166499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C608B9B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9445A1F2215D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8D84A4F;
	Thu,  2 May 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E6Jkg38m"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FFC8F3;
	Thu,  2 May 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656013; cv=none; b=pHA4wCZeemyKfn1CCia80HEDDMvgNfq1YEGqNtZ54x4dSph3qCPfrFz40uHdtjYn2txFJF5Tp3YMz6fELiWJH7+0FnjbCGeHiga4Jv4HHvqvE82mR1c6VETcYh/ELBFiwJ5ADDi+Y1VeItDazkb40N9XOdoJ0PdnJzTiMiw0KqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656013; c=relaxed/simple;
	bh=AA4eWwm7M7R7Zj0EmoI9NtqgRyKwTzthRF6OuoLjpvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldUNOm5sFMc6B4FjoK1vkob4NKMK2n/R+ZixSrMKldf9pKoZZJ8YFbwyEqgTPhzXGT7u+0UoqSuKYypMJL83hvR+9ITmryiWbZ7rLlPJtKqlPQKRgf3H2C+5xQMtjjsICEPMaIe3YND0xKVYQ5r0mo9DfYiNa9IDFHTIxj/+E88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E6Jkg38m; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714656011; x=1746192011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AA4eWwm7M7R7Zj0EmoI9NtqgRyKwTzthRF6OuoLjpvQ=;
  b=E6Jkg38mUkeaykjBSBpDokWF6nPYSWZmkBzuORKLgZbSHENqDY25iuPT
   m9bv0AM5qhIiWaXyQc8/Z7ptgZSn8zVrxxDX/T9LLrAND62p2eXXPBKp7
   Y3FToFG8hAPuw+zT4gp0yz5v9Fxu39y4nRRzCI3zp9ncF9XuzEgpB+Gie
   DRicKBMs9DvmmFLaDixrRr6EazZlQD531faAWpx6oCd/qUJW0oQhHhvgW
   KWvECOWI0ftUnJeTDl/qYdDqiFkBOPh/UGv4P22PaE/xEHvKi1/MFu/FK
   eCcRxOt6ukjBECjbxWhTSKMXhMryVT0AMWSXA7qsFK28ZN1xtBm/+nSDR
   g==;
X-CSE-ConnectionGUID: B7waFNI+S2anEXb0rt445A==
X-CSE-MsgGUID: 0lQHRHqdQfC3tP+L1WZ+Ew==
X-IronPort-AV: E=Sophos;i="6.07,247,1708358400"; 
   d="scan'208";a="15436514"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2024 21:20:04 +0800
IronPort-SDR: k5yoNH1tFafxO7uyc055PNLzQuXrNiJdZjj0EHgJ9239+NJygSGE8wuDCSl15OsoKkSW8lOjiG
 85iM9jEmZD3pLPGa05EsW21GN97qGduYjSCDU8WWSOQ9qAiYGo6eYDGSnaxdK/zcMIwCe3vyPK
 drYCUGuC6ve/4B6iV+cz7oIo1nNdLjj2lHBLCj3wRaqcxrWHY15PUHP69+re2Wlf/r2slyexzG
 uowZBjH+4h8LaWifaxKeKXSU8ZkKV0xS+PDdokR9E6Kjyay5TL/gFya7ZNYSj6/ccsv+jFbl9v
 Yrg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2024 05:22:24 -0700
IronPort-SDR: /BBtFfkVIysNjyK8F2tkORtio0mi4zl2SAOpz9edGzOFr6rmJJyzkA78BNnXVfrV8mmZIBQ9Py
 QBcot/DuqwEdnbACFAzQhyBNBWwRZiZUiHhsWbYsyGQhXmRYAsJRFvQVrOsE65oMosDApRvZq5
 tEHSo9nGH1r7Rcn92iIpTRSR+tBQY+ldTXo9EIVr50kHs01Vb9cc/7QBJxPELYV/zRSKxP1IoL
 5PFQocHZeA5JZ9EKZVjFv6CU52AdsqFTJcAB2/T105r6evPlBsbjjiFCd8Bqw6kprdOg3rsJ9o
 m/k=
WDCIronportException: Internal
Received: from 5cg1421g9c.ad.shared (HELO BXYGM33.ad.shared) ([10.225.33.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 May 2024 06:19:59 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] scsi: ufs: Allow RTT negotiation
Date: Thu,  2 May 2024 16:19:43 +0300
Message-ID: <20240502131943.7292-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtt-upiu packets preceed any data-out upiu packets, thus
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
 drivers/ufs/core/ufshcd.c | 23 +++++++++++++++++++++++
 include/ufs/ufshcd.h      |  2 ++
 include/ufs/ufshci.h      |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0819ddafe7a6..8db9304eb418 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2405,6 +2405,8 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 	((hba->capabilities & MASK_TASK_MANAGEMENT_REQUEST_SLOTS) >> 16) + 1;
 	hba->reserved_slot = hba->nutrs - 1;
 
+	hba->nortt = FIELD_GET(MASK_NUMBER_OUTSTANDING_RTT, hba->capabilities) + 1;
+
 	/* Read crypto capabilities */
 	err = ufshcd_hba_init_crypto_capabilities(hba);
 	if (err) {
@@ -8119,6 +8121,25 @@ static void ufshcd_ext_iid_probe(struct ufs_hba *hba, u8 *desc_buf)
 	dev_info->b_ext_iid_en = ext_iid_en;
 }
 
+static void ufshcd_rtt_set(struct ufs_hba *hba, u8 *desc_buf)
+{
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	u32 rtt = 0;
+
+	/* RTT override makes sense only for UFS-4.0 and above */
+	if (dev_info->wspecversion < 0x400)
+		return;
+
+	rtt = min_t(int, desc_buf[DEVICE_DESC_PARAM_RTT_CAP], hba->nortt);
+	/* rtt is 2 after manufacturing */
+	if (rtt < 3)
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
@@ -8278,6 +8299,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
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


