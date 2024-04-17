Return-Path: <linux-kernel+bounces-148221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C5F8A7F80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA4B20BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A312EBE2;
	Wed, 17 Apr 2024 09:21:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77152F516;
	Wed, 17 Apr 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345669; cv=none; b=aAXyaoYhD00yCPGOI4rmWllbCDWz5nK87GFtvR4gfdRryFPoiDbZaILhn4QatNGoUCMCE2BSqGrEC4yOcgxCEmSO6uNM+kiY1CDaLdOH9e0mUprckx07I36zuXlEx5NI1ImcJIUTgf0frUA76rp+EeZsBXEBuUkgkk3sTotNPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345669; c=relaxed/simple;
	bh=ywsN3ggstkBDL7MooDKikdbSvYUjUsxtghPnqKNym48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KUHqwLlAPsodbWv6NekF+VVfO8INPKUOxCjpjW2qtL/BfAc8AGAsESeLh1Urg4dPIwx8z4ogDW8nSxxpImr85Rm0PshwQxSRJCwwApvDLz7WpRCf9AIdYe/wtKL6ybX+72XraTqZqTrGStZz+C+3BiEZt8c3/kq6sBMjgsiF0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cc993a36fc9b11ee9305a59a3cc225df-20240417
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_HamU
X-CID-O-INFO: VERSION:1.1.37,REQID:61c24f1a-98c9-4119-b296-d7c8a6f0907b,IP:20,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:3
X-CID-INFO: VERSION:1.1.37,REQID:61c24f1a-98c9-4119-b296-d7c8a6f0907b,IP:20,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTIO
	N:release,TS:3
X-CID-META: VersionHash:6f543d0,CLOUDID:ba8cf38c25e9dc103cf64083a088bcb5,BulkI
	D:2404171720588EJWUJGL,BulkQuantity:0,Recheck:0,SF:19|44|66|24|16|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: cc993a36fc9b11ee9305a59a3cc225df-20240417
X-User: jiangyunshui@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 490147603; Wed, 17 Apr 2024 17:20:57 +0800
From: yunshui <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	yunshui <jiangyunshui@kylinos.cn>,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] platform/x86: thinkpad_acpi: change sprintf() to sysfs_emit()
Date: Wed, 17 Apr 2024 17:20:55 +0800
Message-Id: <20240417092055.1170586-1-jiangyunshui@kylinos.cn>
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
 drivers/platform/x86/thinkpad_acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 82429e59999d..1ed27fc21a7d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -817,7 +817,7 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
 	}
 
 	ibm->acpi->device->driver_data = ibm;
-	sprintf(acpi_device_class(ibm->acpi->device), "%s/%s",
+	sysfs_emit(acpi_device_class(ibm->acpi->device), "%s/%s",
 		TPACPI_ACPI_EVENT_PREFIX,
 		ibm->name);
 
@@ -857,7 +857,7 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 		return -ENOMEM;
 	}
 
-	sprintf(ibm->acpi->driver->name, "%s_%s", TPACPI_NAME, ibm->name);
+	sysfs_emit(ibm->acpi->driver->name, "%s_%s", TPACPI_NAME, ibm->name);
 	ibm->acpi->driver->ids = ibm->acpi->hid;
 
 	ibm->acpi->driver->ops.add = &tpacpi_device_add;
@@ -2679,7 +2679,7 @@ static ssize_t hotkey_bios_enabled_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static DEVICE_ATTR_RO(hotkey_bios_enabled);
@@ -9789,7 +9789,7 @@ static ssize_t tpacpi_battery_show(int what,
 		battery = BAT_PRIMARY;
 	if (tpacpi_battery_get(what, battery, &ret))
 		return -ENODEV;
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 static ssize_t charge_control_start_threshold_show(struct device *device,
-- 
2.34.1


