Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E6E801DA5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjLBQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjLBQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:02:40 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A42124;
        Sat,  2 Dec 2023 08:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701532957; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jzagTXn7LX9mEsgVnfiH6X/SiVFfCmM3poZPx8XDNay4c04+pXaMICM4wDCNpgLhiA
    lqb6hiJ5AFXOr9IcOOjI0Tmep8S3nDXkAlPvoefBXYxegK3v3aJ90W//SuTjcDVQ1ugU
    AdB3FbVZMcFhuYc8mG2ZkhMHCkldMATl8Hn6QRP6RDW23WspNizHu6SEi1F67pggfki1
    BEWwBQ8ceyQD/gUjq+R/MeWN4CL8VDuJkPXQE137lzzP442C1qZEw2F4FSqK+m5zaK6G
    ULjn0kzuBkaqGLL9zcX/r3qQlxFX1SWToXMvTi/OYmJB/iOI0bvcPi0+uoFfCcVoUM37
    KK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701532957;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bi41PBpmirH7gK/94LvAmCfOWqfkeZER0pCr8pvmRi0=;
    b=JtigCenPhm05+mZUx5EwE7Bdzp3NK0j8iUHF6uZyG5F29eL0ucD83JmM9yOeCmx0dV
    BvQ2yyaRhlFj0gucUHH4muHIuEkThOhVjNSgERphDjSMJLk+wb63HDcdcvi9j6G6ZgBP
    d7Sfl97lW7i0pcCtplgXZJ1gf5OhZFc600TIh+BEo9q0ENW2rAliy98uxBVuypEynjG0
    WB2IjiWZ7EAgHWt9+VTaAEO0drBsYXX7Vcpg49kNnp5y53y0oLV/VO36ztbiEMEedZhW
    Hv3r5lgm75hCiCDZSAtO42Gb7+tLDLX5w7MwfU0IwP8TUHYpoXzqp75KwKMCq/6FLdKG
    TWvQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701532957;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bi41PBpmirH7gK/94LvAmCfOWqfkeZER0pCr8pvmRi0=;
    b=MwBugEDfq8tydrfnlM5vY2v2XJNwPcq050rgYp2/ocCYLbkI4u0Sy9TMhz0vyUv+QQ
    9ld6gyJHtqpemr7CCMqAcq6o6N8ThfcsyD+0NZkTHtL8vQFnxJLS68XzBZ3DCCFHhMht
    PW/+DMXrJ/Jr3FxtkXlt89P5DFDVujSB24EgprqPQw9OPMuyk8LXlLP0w9a/1jeMdCJg
    IQhIX4ffN7sXxlubYrhsshNVi6N0/efzSOc4jQerka2wSrzU4nyZvtURosMA0k/nnI1X
    KT25XpfNS/8LwBDaWOfTt2wdI8/afMmCkRmNb2OOiti7PhW3Rv3wLeQzhCxk/3qvDjM+
    67mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701532957;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bi41PBpmirH7gK/94LvAmCfOWqfkeZER0pCr8pvmRi0=;
    b=8WIdxme16b9Y7sau1bfydlb1SDxTt42ugOYC7pblEZf0r2D6GRauF3wn/myPwYmPb/
    hWLB8/UmEwiK9muQMoDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U0BfWsYLe+bQusZClHgu6POSIuOZDSGI3MA01fA=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 49.9.7 AUTH)
    with ESMTPSA id z8d451zB2G2b5CK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 2 Dec 2023 17:02:37 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: [PATCH v3 2/3] scsi: ufs: core: Add UFS RTC support
Date:   Sat,  2 Dec 2023 17:02:26 +0100
Message-Id: <20231202160227.766529-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202160227.766529-1-beanhuo@iokpp.de>
References: <20231202160227.766529-1-beanhuo@iokpp.de>
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

Add Real Time Clock (RTC) support for UFS device. This enhancement is crucial
for the internal maintenance operations of the UFS device. The patch enables
the device to handle both absolute and relative time information. Furthermore,
it includes periodic task to update the RTC in accordance with the UFS Spec,
ensuring the accuracy of RTC information for the device's internal processes.

RTC and qTimestamp serve distinct purposes. The RTC provides a coarse level
of granularity with, at best, approximate single-second resolution. This makes
the RTC well-suited for the device to determine the approximate age of programmed
blocks after being updated by the host. On the other hand, qTimestamp offers
nanosecond granularity and is specifically designed for synchronizing Device
Error Log entries with corresponding host-side logs.

Given that the RTC has been a standard feature since UFS Spec 2.0, and qTimestamp
was introduced in UFS Spec 4.0, the majority of UFS devices currently on the
market rely on RTC. Therefore, it is advisable to continue supporting RTC in
the Linux kernel. This ensures compatibility with the prevailing UFS device
implementations and facilitates seamless integration with existing hardware.
By maintaining support for RTC, we ensure broad compatibility and avoid potential
issues arising from deviations in device specifications across different UFS
versions.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Mike Bi <mikebi@micron.com>
Signed-off-by: Luca Porzio <lporzio@micron.com>
---
 drivers/ufs/core/ufshcd.c | 77 +++++++++++++++++++++++++++++++++++++++
 include/ufs/ufs.h         | 14 +++++++
 include/ufs/ufshcd.h      |  4 ++
 3 files changed, 95 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f88f20f27f93..dfc660de656f 100644
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
 
@@ -684,6 +687,8 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
 			hba->dev_info.wb_enabled = false;
 			hba->dev_info.wb_buf_flush_enabled = false;
 		}
+		if (hba->dev_info.rtc_type == UFS_RTC_RELATIVE)
+			hba->dev_info.rtc_time_baseline = 0;
 	}
 	if (err != -EOPNOTSUPP)
 		ufshcd_update_evt_hist(hba, UFS_EVT_DEV_RESET, err);
@@ -8189,6 +8194,70 @@ static void ufs_fixup_device_setup(struct ufs_hba *hba)
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
@@ -8241,6 +8310,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
 
+	ufs_init_rtc(hba, desc_buf);
+
 	if (hba->ext_iid_sup)
 		ufshcd_ext_iid_probe(hba, desc_buf);
 
@@ -8794,6 +8865,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_force_reset_auto_bkops(hba);
 
 	ufshcd_set_timestamp_attr(hba);
+	schedule_delayed_work(&hba->ufs_rtc_update_work,
+				msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
 
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
@@ -9750,6 +9823,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	ret = ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
 	if (ret)
 		goto set_link_active;
+
+	cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
 	goto out;
 
 set_link_active:
@@ -9844,6 +9919,8 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
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
index 7f0b2c5599cd..7bdda92fcb1c 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -911,6 +911,8 @@ enum ufshcd_mcq_opr {
  * @mcq_base: Multi circular queue registers base address
  * @uhq: array of supported hardware queues
  * @dev_cmd_queue: Queue for issuing device management commands
+ * @mcq_opr: MCQ operation and runtime registers
+ * @ufs_rtc_update_work: A work for UFS RTC periodic update
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -1071,6 +1073,8 @@ struct ufs_hba {
 	struct ufs_hw_queue *uhq;
 	struct ufs_hw_queue *dev_cmd_queue;
 	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
+
+	struct delayed_work ufs_rtc_update_work;
 };
 
 /**
-- 
2.34.1

