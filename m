Return-Path: <linux-kernel+bounces-149633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBAD8A93B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8752838B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA03BB50;
	Thu, 18 Apr 2024 07:06:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD238DD9;
	Thu, 18 Apr 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423984; cv=none; b=kiuyhSQtIgnsCvfbH6+ryfDnNGcl8rftx2wBSYF1huvZ2m7p07RlXo14q0Aq62LNs4FtkRvKxv5NwTqXpGn4RNkFWAMkPTvJeMHoDr9oSmf76UvMKUBid3JbVFf+vehX0PgpxuCptYNPx0FVwkfp5Xe/4hWT133llyfsHwNS9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423984; c=relaxed/simple;
	bh=0cq2KNXJm8olaBiLZ4pdwZRcVn9JY5hk7eaXRwyGEJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CTwmhfzwfcOkpMjwFC0YlY562vWJee0AAZV8HkIDMDA8cxnArAnKWVBVklw/V3lwaz+xrtuEUJSvIkBD4OBYRfESqOzImQ6EQfQIPAsnRGKROg1wPswRAmIX/tk06HinuT/dCVtHULVY4v+1DvtsWRWTmQ1IxPo85EPjb9qbY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1e8c7d88fd5211ee9305a59a3cc225df-20240418
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ac5da2f7-eedb-4fdc-948d-0bc3ae0cfbd4,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:10
X-CID-INFO: VERSION:1.1.37,REQID:ac5da2f7-eedb-4fdc-948d-0bc3ae0cfbd4,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-META: VersionHash:6f543d0,CLOUDID:152c965dcca78d4fb2b481a9159d2bc1,BulkI
	D:24041815060521XOATZ6,BulkQuantity:0,Recheck:0,SF:66|24|72|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
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
X-UUID: 1e8c7d88fd5211ee9305a59a3cc225df-20240418
X-User: jiangyunshui@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 424594125; Thu, 18 Apr 2024 15:06:03 +0800
From: yunshui <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	yunshui <jiangyunshui@kylinos.cn>,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] platform/x86: samsung-laptop: Use sysfs_emit() to replace the old interface sprintf()
Date: Thu, 18 Apr 2024 15:05:50 +0800
Message-Id: <20240418070550.628310-1-jiangyunshui@kylinos.cn>
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
 drivers/platform/x86/samsung-laptop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index b4aa8ba35d2d..3d2f8e758369 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -661,9 +661,9 @@ static ssize_t get_performance_level(struct device *dev,
 	/* The logic is backwards, yeah, lots of fun... */
 	for (i = 0; config->performance_levels[i].name; ++i) {
 		if (sretval.data[0] == config->performance_levels[i].value)
-			return sprintf(buf, "%s\n", config->performance_levels[i].name);
+			return sysfs_emit(buf, "%s\n", config->performance_levels[i].name);
 	}
-	return sprintf(buf, "%s\n", "unknown");
+	return sysfs_emit(buf, "%s\n", "unknown");
 }
 
 static ssize_t set_performance_level(struct device *dev,
@@ -744,7 +744,7 @@ static ssize_t get_battery_life_extender(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 static ssize_t set_battery_life_extender(struct device *dev,
@@ -813,7 +813,7 @@ static ssize_t get_usb_charge(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 static ssize_t set_usb_charge(struct device *dev,
@@ -878,7 +878,7 @@ static ssize_t get_lid_handling(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 static ssize_t set_lid_handling(struct device *dev,
-- 
2.34.1


