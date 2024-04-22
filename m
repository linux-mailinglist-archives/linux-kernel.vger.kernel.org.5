Return-Path: <linux-kernel+bounces-152788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866818AC436
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4BFB2180E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593243ADD;
	Mon, 22 Apr 2024 06:29:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD8405F9;
	Mon, 22 Apr 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767367; cv=none; b=q69LoSD7vsMMQ/7sjwOurUv6BH6LxZo8qaRZrOmB4aW5Ucls+qtPhp8RJ4KUKVWEhmH/qKDNrSJ/+CDRXVuAo7qZjNy7blmYaQbwjNWTHpuf8NEihWlRLF7SHtNny49g1FlLQ9Eg6snJjtgNhnWUGMgCBEJRB0Rg+upYzTCGCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767367; c=relaxed/simple;
	bh=HlzQh948S8sIzvNyBVPCB6monqUovoXIO4DHiPWGYRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jYmXwQP+HKX1VN5859K5NaQSA8s/tbN/pA7oz9pzjXC3vnqLTMLoxmKxEUDq81oveZx0Lqnkgs8aE95bfjlxpu0/zoaTEuR46XCouPTZVNejCVP24PWqsmtiWPVEoytf3CIUeDqEVG4H504RndlI5PJSfTGbtQSEqo6DMAPpzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a51326be007111ef9305a59a3cc225df-20240422
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d05a343c-c0ca-4f1c-8c97-b7c21f260929,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-30
X-CID-INFO: VERSION:1.1.37,REQID:d05a343c-c0ca-4f1c-8c97-b7c21f260929,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6f543d0,CLOUDID:75c230c35f4886e2cece48bf194582e1,BulkI
	D:240422142917Q175OXDX,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: a51326be007111ef9305a59a3cc225df-20240422
X-User: jiangyunshui@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1917057899; Mon, 22 Apr 2024 14:29:17 +0800
From: yunshui <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	luke@ljones.dev,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	yunshui <jiangyunshui@kylinos.cn>,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v2] platform/x86: asus-laptop: Use sysfs_emit() and sysfs_emit_at() to replace sprintf()
Date: Mon, 22 Apr 2024 14:29:15 +0800
Message-Id: <20240422062915.3393480-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Documentation/filesystems/sysfs.rst suggested,
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/platform/x86/asus-laptop.c | 44 +++++++++++++++---------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 78c42767295a..ccb33d034e2a 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -852,8 +852,8 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
 	 * so we don't set eof to 1
 	 */
 
-	len += sprintf(page, ASUS_LAPTOP_NAME " " ASUS_LAPTOP_VERSION "\n");
-	len += sprintf(page + len, "Model reference    : %s\n", asus->name);
+	len += sysfs_emit_at(page, len, ASUS_LAPTOP_NAME " " ASUS_LAPTOP_VERSION "\n");
+	len += sysfs_emit_at(page, len, "Model reference    : %s\n", asus->name);
 	/*
 	 * The SFUN method probably allows the original driver to get the list
 	 * of features supported by a given model. For now, 0x0100 or 0x0800
@@ -862,7 +862,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
 	 */
 	rv = acpi_evaluate_integer(asus->handle, "SFUN", NULL, &temp);
 	if (ACPI_SUCCESS(rv))
-		len += sprintf(page + len, "SFUN value         : %#x\n",
+		len += sysfs_emit_at(page, len, "SFUN value         : %#x\n",
 			       (uint) temp);
 	/*
 	 * The HWRS method return informations about the hardware.
@@ -874,7 +874,7 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
 	 */
 	rv = acpi_evaluate_integer(asus->handle, "HWRS", NULL, &temp);
 	if (ACPI_SUCCESS(rv))
-		len += sprintf(page + len, "HWRS value         : %#x\n",
+		len += sysfs_emit_at(page, len, "HWRS value         : %#x\n",
 			       (uint) temp);
 	/*
 	 * Another value for userspace: the ASYM method returns 0x02 for
@@ -885,25 +885,25 @@ static ssize_t infos_show(struct device *dev, struct device_attribute *attr,
 	 */
 	rv = acpi_evaluate_integer(asus->handle, "ASYM", NULL, &temp);
 	if (ACPI_SUCCESS(rv))
-		len += sprintf(page + len, "ASYM value         : %#x\n",
+		len += sysfs_emit_at(page, len, "ASYM value         : %#x\n",
 			       (uint) temp);
 	if (asus->dsdt_info) {
 		snprintf(buf, 16, "%d", asus->dsdt_info->length);
-		len += sprintf(page + len, "DSDT length        : %s\n", buf);
+		len += sysfs_emit_at(page, len, "DSDT length        : %s\n", buf);
 		snprintf(buf, 16, "%d", asus->dsdt_info->checksum);
-		len += sprintf(page + len, "DSDT checksum      : %s\n", buf);
+		len += sysfs_emit_at(page, len, "DSDT checksum      : %s\n", buf);
 		snprintf(buf, 16, "%d", asus->dsdt_info->revision);
-		len += sprintf(page + len, "DSDT revision      : %s\n", buf);
+		len += sysfs_emit_at(page, len, "DSDT revision      : %s\n", buf);
 		snprintf(buf, 7, "%s", asus->dsdt_info->oem_id);
-		len += sprintf(page + len, "OEM id             : %s\n", buf);
+		len += sysfs_emit_at(page, len, "OEM id             : %s\n", buf);
 		snprintf(buf, 9, "%s", asus->dsdt_info->oem_table_id);
-		len += sprintf(page + len, "OEM table id       : %s\n", buf);
+		len += sysfs_emit_at(page, len, "OEM table id       : %s\n", buf);
 		snprintf(buf, 16, "%x", asus->dsdt_info->oem_revision);
-		len += sprintf(page + len, "OEM revision       : 0x%s\n", buf);
+		len += sysfs_emit_at(page, len, "OEM revision       : 0x%s\n", buf);
 		snprintf(buf, 5, "%s", asus->dsdt_info->asl_compiler_id);
-		len += sprintf(page + len, "ASL comp vendor id : %s\n", buf);
+		len += sysfs_emit_at(page, len, "ASL comp vendor id : %s\n", buf);
 		snprintf(buf, 16, "%x", asus->dsdt_info->asl_compiler_revision);
-		len += sprintf(page + len, "ASL comp revision  : 0x%s\n", buf);
+		len += sysfs_emit_at(page, len, "ASL comp revision  : 0x%s\n", buf);
 	}
 
 	return len;
@@ -933,7 +933,7 @@ static ssize_t ledd_show(struct device *dev, struct device_attribute *attr,
 {
 	struct asus_laptop *asus = dev_get_drvdata(dev);
 
-	return sprintf(buf, "0x%08x\n", asus->ledd_status);
+	return sysfs_emit(buf, "0x%08x\n", asus->ledd_status);
 }
 
 static ssize_t ledd_store(struct device *dev, struct device_attribute *attr,
@@ -993,7 +993,7 @@ static ssize_t wlan_show(struct device *dev, struct device_attribute *attr,
 {
 	struct asus_laptop *asus = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", asus_wireless_status(asus, WL_RSTS));
+	return sysfs_emit(buf, "%d\n", asus_wireless_status(asus, WL_RSTS));
 }
 
 static ssize_t wlan_store(struct device *dev, struct device_attribute *attr,
@@ -1022,7 +1022,7 @@ static ssize_t bluetooth_show(struct device *dev, struct device_attribute *attr,
 {
 	struct asus_laptop *asus = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", asus_wireless_status(asus, BT_RSTS));
+	return sysfs_emit(buf, "%d\n", asus_wireless_status(asus, BT_RSTS));
 }
 
 static ssize_t bluetooth_store(struct device *dev,
@@ -1052,7 +1052,7 @@ static ssize_t wimax_show(struct device *dev, struct device_attribute *attr,
 {
 	struct asus_laptop *asus = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", asus_wireless_status(asus, WM_RSTS));
+	return sysfs_emit(buf, "%d\n", asus_wireless_status(asus, WM_RSTS));
 }
 
 static ssize_t wimax_store(struct device *dev, struct device_attribute *attr,
@@ -1081,7 +1081,7 @@ static ssize_t wwan_show(struct device *dev, struct device_attribute *attr,
 {
 	struct asus_laptop *asus = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", asus_wireless_status(asus, WW_RSTS));
+	return sysfs_emit(buf, "%d\n", asus_wireless_status(asus, WW_RSTS));
 }
 
 static ssize_t wwan_store(struct device *dev, struct device_attribute *attr,
@@ -1151,7 +1151,7 @@ static ssize_t ls_switch_show(struct device *dev, struct device_attribute *attr,
 {
 	struct asus_laptop *asus = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", asus->light_switch);
+	return sysfs_emit(buf, "%d\n", asus->light_switch);
 }
 
 static ssize_t ls_switch_store(struct device *dev,
@@ -1182,7 +1182,7 @@ static ssize_t ls_level_show(struct device *dev, struct device_attribute *attr,
 {
 	struct asus_laptop *asus = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", asus->light_level);
+	return sysfs_emit(buf, "%d\n", asus->light_level);
 }
 
 static ssize_t ls_level_store(struct device *dev, struct device_attribute *attr,
@@ -1228,7 +1228,7 @@ static ssize_t ls_value_show(struct device *dev, struct device_attribute *attr,
 	if (!err)
 		err = pega_int_read(asus, PEGA_READ_ALS_L, &lo);
 	if (!err)
-		return sprintf(buf, "%d\n", 10 * hi + lo);
+		return sysfs_emit(buf, "%d\n", 10 * hi + lo);
 	return err;
 }
 static DEVICE_ATTR_RO(ls_value);
@@ -1264,7 +1264,7 @@ static ssize_t gps_show(struct device *dev, struct device_attribute *attr,
 {
 	struct asus_laptop *asus = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", asus_gps_status(asus));
+	return sysfs_emit(buf, "%d\n", asus_gps_status(asus));
 }
 
 static ssize_t gps_store(struct device *dev, struct device_attribute *attr,
-- 
2.34.1


