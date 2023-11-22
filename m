Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282FC7F4F14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbjKVSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbjKVRZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:25:41 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EACB1B1;
        Wed, 22 Nov 2023 09:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700673928; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O0UQ2RhyE52bR7uRZxHPc7wQmO81xGJWhA5hSqh+JtjsaQwExJGs3OkaASt84Nf20p
    eCGUP9TP0n2ew/yBE193tGLKqfjQRBpimNXu8XcrVXNly08fmyoeccmELRPQ8dMUSUMh
    LW6AUPwsBeu2IPmQFbGZgtYBj4A+weXbYCEAbxomGIPQe3ZQXOGCNPm+hQvYciVyviSY
    LjIlHXSIKRhx2X59PN4MmfU1zX6qZ6N2BaPLw/GYTesESx97JmGIjiAn+vJZCRCSFkxw
    UWbBHudMtroPoRPcVweG4kWxgC1rt/5OX+zt7f2whhlvpY3qhbqmnHg/bn65/nnyMgmo
    5+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1700673928;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TaZk/EmlJ6NGsJH1VYRpJgtVrMW9Q9O+FuvbwbxE6sQ=;
    b=nphAfTZ7CTnhESsDremq3qaXcCKiUsAyTbJb49t8rDXMVtWD7sTWAICzo8HSB7SZb2
    Ny8M8El3S0gLmTfpUDjXB9KD69IRd8FU5S3fJOrPNc8t/4VoSy/MS+RgvKOO8XG3Y7HB
    FSFDTTbXj3heuTfuiw4w+XHBbWPLKpxsYPhbfDjCuvxGYfDDnxeX8NHNQF9IxW/XlVie
    7au4gmv1MIZKrIf/Z+QntDttKf3cPNvgdgJE0qbgaUfy2WLwlxyBfY/Rh0luRRRxE8ZR
    8J21UmoQagnUoYaZ9xXD4gQOa3BgRQw8LtzK6l6/bU5QVxyICqUDRHbdl6QRz5QAydpZ
    Fqrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1700673928;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TaZk/EmlJ6NGsJH1VYRpJgtVrMW9Q9O+FuvbwbxE6sQ=;
    b=euVW+5cmbP8BAkBJ6VtWGNnN+/+GWMqDP9SbpFKV2DPOduvjoitm8puy3VneoMCswJ
    Go5j45qKbidwoleixGynEe1HB3Z4u48z9uzpLs8YstKQybko9a72Fhq+XHxQbi1vUbVg
    tXH1JlMUTiasXvUSSttgB7R9y5KUzj4c8BxYpAhnh/Fvvl4PaobLagbo4cZAye5omr8k
    19MO9WbJob/OKNYLwLlZGCBJJZjfKBNASkHpJ0xpFP7ARfxyvgjpxzmxRGI/jkbOeVZj
    OwB9s7VujZGAdDOIiY9TBilmk+HD2th542TlpA3IU80gxGHTKmA1RmFUksdnw2Mum9xr
    v8SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1700673928;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TaZk/EmlJ6NGsJH1VYRpJgtVrMW9Q9O+FuvbwbxE6sQ=;
    b=xzOm0l8U6KOu6k6s/Oe7TovXfhv9HnHzVj5J6IArNpJDWlzXeh9c3C/qHDUz+ag6sG
    yb/x092DTcZ7wD3ucDAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id z758a5zAMHPRtqL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 22 Nov 2023 18:25:27 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: [PATCH v2 2/3] scsi: ufs: core: Add UFS RTC support
Date:   Wed, 22 Nov 2023 18:25:11 +0100
Message-Id: <20231122172512.103748-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122172512.103748-1-beanhuo@iokpp.de>
References: <20231122172512.103748-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add Real Time Clock (RTC) support for UFS device. This enhancement is crucial for the
internal maintenance operations of the UFS device. The patch enables the device to handle
both absolute and relative time information. Furthermore, it includes periodic task to
update the RTC in accordance with the UFS specification, ensuring the accuracy of RTC
information for the device's internal processes.

RTC and qTimestamp serve distinct purposes. The RTC provides a coarse level of granularity
with, at best, approximate single-second resolution. This makes the RTC well-suited for the
device to determine the approximate age of programmed blocks after being updated by the host.
On the other hand, qTimestamp offers nanosecond granularity and is specifically designed for
synchronizing Device Error Log entries with corresponding host-side logs.

Given that the RTC has been a standard feature since UFS Spec 2.0, and qTimestamp was introduced
in UFS Spec 4.0, the majority of UFS devices currently on the market rely on RTC. Therefore, it
is advisable to continue supporting RTC in the Linux kernel. This ensures compatibility with the
prevailing UFS device implementations and facilitates seamless integration with existing hardware.
By maintaining support for RTC, we ensure broad compatibility and avoid potential issues arising
from deviations in device specifications across different UFS versions.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Mike Bi <mikebi@micron.com>
Signed-off-by: Luca Porzio <lporzio@micron.com>
---
 drivers/ufs/core/ufshcd.c | 77 +++++++++++++++++++++++++++++++++++++++
 include/ufs/ufs.h         | 14 +++++++
 include/ufs/ufshcd.h      |  4 ++
 3 files changed, 95 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5d009d2c34f0..4d349eff24c4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -99,6 +99,9 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* Default RTC update every 10 seconds */
+#define UFS_RTC_UPDATE_INTERVAL_MS (10 * MSEC_PER_SEC)
+
 /* UFSHC 4.0 compliant HC support this mode. */
 static bool use_mcq_mode = true;
 
@@ -677,6 +680,8 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
 			hba->dev_info.wb_enabled = false;
 			hba->dev_info.wb_buf_flush_enabled = false;
 		}
+		if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
+			hba->dev_info.rtc_time_baseline = 0;
 	}
 	if (err != -EOPNOTSUPP)
 		ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, err);
@@ -8181,6 +8186,70 @@ static void ufs_fixup_device_setup(struct ufs_hba *hba)
 	ufshcd_vops_fixup_dev_quirks(hba);
 }
 
+static int ufshcd_update_rtc(struct ufs_hba *hba)
+{
+	int err;
+	u32 val;
+	struct timespec64 ts64;
+
+	ktime_get_real_ts64(&ts64);
+	val = ts64.tv_sec - hba->dev_info.rtc_time_baseline;
+
+	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR, QUERY_ATTR_IDN_SECONDS_PASSED,
+				0, 0, &val);
+	ufshcd_rpm_put_sync(hba);
+
+	if (err)
+		dev_err(hba->dev, "%s: Failed to update rtc %d\n", __func__, err);
+	else if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
+		hba->dev_info.rtc_time_baseline = ts64.tv_sec;
+
+	return err;
+}
+
+static void ufshcd_rtc_work(struct work_struct *work)
+{
+	struct ufs_hba *hba;
+	bool is_busy;
+
+	hba = container_of(to_delayed_work(work), struct ufs_hba, ufs_rtc_update_work);
+
+	is_busy = ufshcd_is_ufs_dev_busy(hba);
+	/*
+	 * RTC updates should not interfere with normal IO requests; we should only update the RTC
+	 * when there are no ongoing requests.
+	 */
+	if (!is_busy)
+		ufshcd_update_rtc(hba);
+
+	if (ufshcd_is_ufs_dev_active(hba))
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+			msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
+}
+
+static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
+{
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	u16 periodic_rtc_update = get_unaligned_be16(&desc_buf[DEVICE_DESC_PARAM_FRQ_RTC]);
+
+	if (periodic_rtc_update & UFS_RTC_TIME_BASELINE) {
+		dev_info->rtc_type = UFS_RTC_ABSOLUTE;
+		/*
+		 * The concept of measuring time in Linux as the number of seconds elapsed since
+		 * 00:00:00 UTC on January 1, 1970, and UFS ABS RTC is elapsed from January 1st
+		 * 2010 00:00, here we need to adjust ABS baseline.
+		 */
+		dev_info->rtc_time_baseline = mktime64(2010, 1, 1, 0, 0, 0) -
+							mktime64(1970, 1, 1, 0, 0, 0);
+	} else {
+		dev_info->rtc_type = UFS_RTC_RELATIVE;
+		dev_info->rtc_time_baseline = 0;
+	}
+
+	INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
+}
+
 static int ufs_get_device_desc(struct ufs_hba *hba)
 {
 	int err;
@@ -8233,6 +8302,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
 
+	ufs_init_rtc(hba, desc_buf);
+
 	if (hba->ext_iid_sup)
 		ufshcd_ext_iid_probe(hba, desc_buf);
 
@@ -8786,6 +8857,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_force_reset_auto_bkops(hba);
 
 	ufshcd_set_timestamp_attr(hba);
+	schedule_delayed_work(&hba->ufs_rtc_update_work,
+				msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
 
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
@@ -9742,6 +9815,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ret = ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
 	if (ret)
 		goto set_link_active;
+
+	cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
 	goto out;
 
 set_link_active:
@@ -9836,6 +9911,8 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		if (ret)
 			goto set_old_link_state;
 		ufshcd_set_timestamp_attr(hba);
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+					msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index e77ab1786856..8022d267fe8a 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <uapi/scsi/scsi_bsg_ufs.h>
+#include <linux/time64.h>
 
 /*
  * Using static_assert() is not allowed in UAPI header files. Hence the check
@@ -551,6 +552,15 @@ struct ufs_vreg_info {
 	struct ufs_vreg *vdd_hba;
 };
 
+/*
+ * UFS device descriptor wPeriodicRTCUpdate bit9 defines RTC time baseline.
+ */
+#define UFS_RTC_TIME_BASELINE BIT(9)
+enum ufs_rtc_time {
+	UFS_RTC_RELATIVE,
+	UFS_RTC_ABSOLUTE
+};
+
 struct ufs_dev_info {
 	bool	f_power_on_wp_en;
 	/* Keeps information if any of the LU is power on write protected */
@@ -578,6 +588,10 @@ struct ufs_dev_info {
 
 	/* UFS EXT_IID Enable */
 	bool	b_ext_iid_en;
+
+	/* UFS RTC */
+	enum ufs_rtc_time rtc_type;
+	time64_t rtc_time_baseline;
 };
 
 /*
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index b0cd6c6591ef..a365ad138eb3 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -910,6 +910,8 @@ enum ufshcd_mcq_opr {
  * @mcq_base: Multi circular queue registers base address
  * @uhq: array of supported hardware queues
  * @dev_cmd_queue: Queue for issuing device management commands
+ * @mcq_opr: MCQ operation and runtime registers
+ * @ufs_rtc_update_work: A work for UFS RTC periodic update
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -1070,6 +1072,8 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+
+	struct delayed_work ufs_rtc_update_work;
 };
 
 /**
-- 
2.34.1

