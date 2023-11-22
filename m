Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92A7F4E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbjKVRZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344130AbjKVRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:25:40 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B46E11F;
        Wed, 22 Nov 2023 09:25:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700673929; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L7WFrYebsKHoUGrR1I1AnrhXx43r66fniToUVGhpiG1yTxFPw0MYuimgZ4Squ+ClHW
    X6jaXfoOvLccEA/oPO7NiPwaVV/cJ80qq/UpscPLDc1IlAe9zIBFG/aC1kkwfdeLfcwP
    9CyF5QB9eCvWUjzMzBLMsUxydr3U5uFPZT6qXgDjWA2qsyMHLE13WlbBUbRShP+hKIhm
    Ck/lh4Q7tCFI9T6uz2knWdtbkmpQ7J4LMwUBdqLoEeDoOx7QoH/oZxWew163cPPXa7Re
    2mnOvwXvYaelgt/zrA20CcgEv5Y70IvdVF0kQi5xqq7uEAydvzvE6BQZ0Czjhq2T7g3U
    gtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1700673929;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vZpZ9NKXUQd/HeAYhjZFf4m71jUoBcZvjlDIhfX51No=;
    b=jVtXAN2Ue+JUsFFZUDqooVnxp2YjrErfvxFChRTLqR7iJb0YNq2jCDWTL6qvhpgtUh
    pzIdllwANKd86jHjtdfbH66XyCVoo3OQVMDVWbqx71+Dht+xBXi2CEu3bwlWb2qUuddx
    vUcPdoN6fP527IB+Wea6sAow9hw+LzaoTwwZeMnnrt3tFKFIYreEcN0kCDT3vpqzDWwx
    IsL8PDMYlqFDaUc91yMIbx7cvJMKM0VLe2sByHsba6gAMga56u8tLvIg7axq6+r5OfuN
    +CwDI2NVHf0JK5po9e8nEBpme/GWAsKgxRBVqy8aT/GjRKgEpZGRr+G4UTc2+XKNbKVC
    hnMA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1700673929;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vZpZ9NKXUQd/HeAYhjZFf4m71jUoBcZvjlDIhfX51No=;
    b=tmkqyx1ZPFvm9gGyfWwMoEofS1DdYUQaRl6LJQrjUxJqnjR/fB4ex76ZsOKGEgahoY
    hhNeiU8HVlaoLvpWKlvBEaBqeU6PmHHz94McXnE897Ri1Tjxzrij9V/9RI3el3bzBp3H
    zW1emX36yRhicdUZGdlo9NhoTfx7OTPlpoRNrt4Vtqdu9xO+keoArpY35sbYcQlp1Cg5
    TzZP6nUr/I/uJZN9PL1vNcduPMbkAjOthzi263gw3GoxgBHYSQYf/Gn4oOHSltPP1HoE
    e6VAHgJk+KoKtYcdwnQvGxUg6sZ/mTJX6eRDZqpVNDmugVQmyS7C2bXYkb8dwUGeAfbz
    HyaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1700673929;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vZpZ9NKXUQd/HeAYhjZFf4m71jUoBcZvjlDIhfX51No=;
    b=SkDr8bksm3TNE4WuBF4Cj5eiTXNfrzcq2TtVMVuzsZY6y9r4Zdqbd4YYy/WY7O1u76
    JS96XsU21T6869eK70Ag==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id z758a5zAMHPStqM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 22 Nov 2023 18:25:28 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: [PATCH v2 3/3] scsi: ufs: core: Add sysfs node for UFS RTC update
Date:   Wed, 22 Nov 2023 18:25:12 +0100
Message-Id: <20231122172512.103748-4-beanhuo@iokpp.de>
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

Introduce a sysfs node named 'rtc_update_ms' within the kernel, enabling user to
adjust the RTC periodic update frequency to suit the specific requirements of the
system and UFS. Also, this patch allows the user to disable/enable periodic update RTC
in the UFS idle time.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  7 +++++
 drivers/ufs/core/ufs-sysfs.c               | 31 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  | 11 ++++++--
 include/ufs/ufs.h                          |  1 +
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 0c7efaf62de0..ef1e27584fff 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1474,3 +1474,10 @@ Description:	Indicates status of Write Booster.
 
 		The file is read only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/rtc_update_ms
+What:		/sys/bus/platform/devices/*.ufs/rtc_update_ms
+Date:		November 2023
+Contact:	Bean Huo <beanhuo@micron.com>
+Description:
+		rtc_update_ms indicates how often the host should synchronize or update the
+		UFS RTC. If set to 0, this will disable UFS RTC periodic update.
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index c95906443d5f..bb6b540ccd8e 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -255,6 +255,35 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	return res < 0 ? res : count;
 }
 
+static ssize_t rtc_update_ms_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->dev_info.rtc_update_period);
+}
+
+static ssize_t rtc_update_ms_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
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
+						msecs_to_jiffies(hba->dev_info.rtc_update_period));
+	return count;
+}
+
 static ssize_t enable_wb_buf_flush_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -339,6 +368,7 @@ static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
 static DEVICE_ATTR_RW(wb_flush_threshold);
+static DEVICE_ATTR_RW(rtc_update_ms);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -351,6 +381,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
 	&dev_attr_wb_flush_threshold.attr,
+	&dev_attr_rtc_update_ms.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4d349eff24c4..53b4c96f4279 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8223,9 +8223,9 @@ static void ufshcd_rtc_work(struct work_struct *work)
 	if (!is_busy)
 		ufshcd_update_rtc(hba);
 
-	if (ufshcd_is_ufs_dev_active(hba))
+	if (ufshcd_is_ufs_dev_active(hba) && hba->dev_info.rtc_update_period)
 		schedule_delayed_work(&hba->ufs_rtc_update_work,
-			msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
+			msecs_to_jiffies(hba->dev_info.rtc_update_period));
 }
 
 static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
@@ -8247,6 +8247,13 @@ static void  ufs_init_rtc(struct ufs_hba *hba, u8 *desc_buf)
 		dev_info->rtc_time_baseline = 0;
 	}
 
+	/*
+	 * We ignore TIME_PERIOD defined in wPeriodicRTCUpdate because Spec does not clearly state
+	 * how to calculate the specific update period for each time unit. Here we disable periodic
+	 * update work, and let user configure by sysfs node according to specific circumstance.
+	 */
+	hba->dev_info.rtc_update_period = 0;
+
 	INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
 }
 
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 8022d267fe8a..288724d3be90 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -592,6 +592,7 @@ struct ufs_dev_info {
 	/* UFS RTC */
 	enum ufs_rtc_time rtc_type;
 	time64_t rtc_time_baseline;
+	u32 rtc_update_period;
 };
 
 /*
-- 
2.34.1

