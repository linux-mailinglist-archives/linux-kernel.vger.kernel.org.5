Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF680F9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377691AbjLLWIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377427AbjLLWIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:08:41 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260DEBC;
        Tue, 12 Dec 2023 14:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702418918; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qnC7nnzpbvNgU8zh8JtzhugnbaXcgeDuSE286EHpQu9KmOq7TnwlZydgcpIr5fK5Cl
    M7r+kTZeoXCOT8smlrvkx1q7N9wdwyCms5fnIce4JIx7XMM6h7efaz1ScdsY1gOIYsIF
    DSxree929bmgpgmICtIM88J+KXw+4O2RBZkZunil0QQsbJnS4kgEDLzICiJWBKtqPrRY
    uqKNFq+bF7gsjy2Fh2VX1yoRxqnmpz2TImlAd+ZD2bQHffUrTJanbOEolspq+zd5Rsvs
    lwoMJUlZ6Pj8fSLwcUXWji5isnVWTAX/ynnJous2sZXeJvzyeE8LKWagb2/3WjMwkTWP
    t4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702418918;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Os9UsUUURWypEi8Tdr5n+BK78P8cj8KZaYdYD1dJztc=;
    b=rQ1d0lYxI/GnIsXAQGtL63gQHQQ9hjCkPNA3UyT4Ygsals1x+BUVyDAmLlXF+Cb+16
    2YbSb5t3oxCOrsdeQmRBC+Pa9bEYU3jNVsWZDwwKzf6A2cMTVZqxFazbRBB59gAQKUqC
    CYUe7uwXzVF0bS3jS0TNWqo6Txs/tV1mo/0ku0G5zToijZnaoM/SN+wkbwx82r4q80d0
    Eej+gtafuP+1MC/GtvmM4EUM0P/qjQDm/Nwyd8EqhRQingoXVuUkMn7ZGZIL0r5nfEap
    PJFu4XjP94SZQAGDATZr1pCYdRPcQD/Ej4H4vbFGvqSfXOr8p8i2MonWXiutgez2RjsG
    S8Aw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702418918;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Os9UsUUURWypEi8Tdr5n+BK78P8cj8KZaYdYD1dJztc=;
    b=lg9Ow90ArEq4RbqZOLkpTKN0SO9mkzlazuBZWb2tAQvmizJ4XJXGpIL6cpzaRuFJp8
    +QkpCDEvHVvfuErFBenRLMTWt+2p3PXb9wewAFDr0zAeivlLCKMNTbYvYmJ12obH4Crc
    Nqz9gEcpU6xDkbJYYQOXc2cNR2iUagSWAISHct3c1wGRymFlc/+3dyQZLWRZe5qqMTkT
    VHDRPObfjOpcvEVscWWn6hD5t/fm0PQC2BoRScp09r+hfTmgYvzd4tiUjQ1MEvgGk3Iv
    CNLyjLBQ8DuhX8YvZgGSAi1Ww/8BA75gCURAFIS9XL9aDFmFJa4/2/tNnnn+HQQ5UrYT
    aWbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702418918;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Os9UsUUURWypEi8Tdr5n+BK78P8cj8KZaYdYD1dJztc=;
    b=tfM9X+CvmRyxXAmQ2ElG5vwXGm3TxKvS3zj3vFiXHVENdXt6kW/GAJgyyWmwVcxdDD
    Wiic+FZw/tjByZDG3+Cg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1krW49WPrbTU8waUHk0CK6S5K43N4UTp8lPg"
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zBCM8cNW1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Dec 2023 23:08:38 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 3/3] scsi: ufs: core: Add sysfs node for UFS RTC update
Date:   Tue, 12 Dec 2023 23:08:25 +0100
Message-Id: <20231212220825.85255-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212220825.85255-1-beanhuo@iokpp.de>
References: <20231212220825.85255-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Introduce a sysfs node named 'rtc_update_ms' within the kernel, enabling
user to adjust the RTC periodic update frequency to suit the specific
requirements of the system and UFS. Also, this patch allows the user to
disable/enable periodic update RTC in the UFS idle time.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  7 +++++
 drivers/ufs/core/ufs-sysfs.c               | 31 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  | 11 ++++++--
 include/ufs/ufs.h                          |  1 +
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index b73067bb5ea2..5bf7073b4f75 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1523,3 +1523,10 @@ Description:	Indicates status of Write Booster.
 
 		The file is read only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/rtc_update_ms
+What:		/sys/bus/platform/devices/*.ufs/rtc_update_ms
+Date:		November 2023
+Contact:	Bean Huo <beanhuo@micron.com>
+Description:
+		rtc_update_ms indicates how often the host should synchronize or update the
+		UFS RTC. If set to 0, this will disable UFS RTC periodic update.
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 05b10ca90b50..e6d12289e017 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -302,6 +302,35 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	return res < 0 ? res : count;
 }
 
+static ssize_t rtc_update_ms_show(struct device *dev, struct device_attribute *attr,
+				  char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->dev_info.rtc_update_period);
+}
+
+static ssize_t rtc_update_ms_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int ms;
+	bool resume_period_update = false;
+
+	if (kstrtouint(buf, 0, &ms))
+		return -EINVAL;
+
+	if (!hba->dev_info.rtc_update_period && ms > 0)
+		resume_period_update =  true;
+	/* Minimum and maximum update frequency should be synchronized with all UFS vendors */
+	hba->dev_info.rtc_update_period = ms;
+
+	if (resume_period_update)
+		schedule_delayed_work(&hba->ufs_rtc_update_work,
+				      msecs_to_jiffies(hba->dev_info.rtc_update_period));
+	return count;
+}
+
 static ssize_t enable_wb_buf_flush_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -386,6 +415,7 @@ static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
+static DEVICE_ATTR_RW(rtc_update_ms);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -398,6 +428,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
 	&dev_attr_wb_flush_threshold.attr,
+	&dev_attr_rtc_update_ms.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index cda1e1080446..5ebc9c957236 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8235,9 +8235,9 @@ static void ufshcd_rtc_work(struct work_struct *work)
 	if (!ufshcd_is_ufs_dev_busy(hba) && hba->ufshcd_state == UFSHCD_STATE_OPERATIONAL)
 		ufshcd_update_rtc(hba);
 
-	if (ufshcd_is_ufs_dev_active(hba))
+	if (ufshcd_is_ufs_dev_active(hba) && hba->dev_info.rtc_update_period)
 		schedule_delayed_work(&hba->ufs_rtc_update_work,
-				      msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
+				      msecs_to_jiffies(hba->dev_info.rtc_update_period));
 }
 
 static void ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
@@ -8259,6 +8259,13 @@ static void ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
 		dev_info->rtc_type = UFS_RTC_RELATIVE;
 		dev_info->rtc_time_baseline = 0;
 	}
+
+	/*
+	 * We ignore TIME_PERIOD defined in wPeriodicRTCUpdate because Spec does not clearly state
+	 * how to calculate the specific update period for each time unit. And we disable periodic
+	 * RTC update work, let user configure by sysfs node according to specific circumstance.
+	 */
+	dev_info->rtc_update_period = 0;
 }
 
 static int ufs_get_device_desc(struct ufs_hba *hba)
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 7e7169d94596..b6003749bc83 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -591,6 +591,7 @@ struct ufs_dev_info {
 	/* UFS RTC */
 	enum ufs_rtc_time rtc_type;
 	time64_t rtc_time_baseline;
+	u32 rtc_update_period;
 };
 
 /*
-- 
2.34.1

