Return-Path: <linux-kernel+bounces-151064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB68AA885
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFA41F2119F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A483A1A8;
	Fri, 19 Apr 2024 06:41:35 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951FC8FF;
	Fri, 19 Apr 2024 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508895; cv=none; b=ZFlYwgIKvXqJZhCmplyY4zkEPErnDGmmCIRayauhwZZ1SOGUg0D0+RDtVsWVX6DJrX5s+3gjdqz28axLC42MsQTs4oSMORoeDaGqDS5SAayOTGCcFZa1AEcqVIw/JllOmDMZxHzRx0gWeKj4m4uiJ9eXpHmHCwPGtCgFkgfI0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508895; c=relaxed/simple;
	bh=b+I0QSWibV+wR3NqEOCaNhKLaX5vwY122N/x63UAFqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=efda1a3CqJMN+DqEP6/V4LNPiCjxXT6srpZ2qHNsVHGsSXdgc9D2gmcqBU26kQrsXLxAjZxJy2+3RSMRdz+9GK3oVPdLX1VxOWFM/JpQGMIeVl5vL11zlc4/SrzvCWBLglWR2Tt4HXcuDvaktbonivtOZCK2uLo5CJc3D4TD7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d427d5befe1711ee9305a59a3cc225df-20240419
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:40dc1449-fbfe-471a-adc1-b15cb8368061,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.37,REQID:40dc1449-fbfe-471a-adc1-b15cb8368061,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6f543d0,CLOUDID:a99f88e938a93f73469ca5e8354668c8,BulkI
	D:2404191441216BZ1JA99,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: d427d5befe1711ee9305a59a3cc225df-20240419
X-User: jiangyunshui@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 260057207; Fri, 19 Apr 2024 14:41:19 +0800
From: yunshui <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	yunshui <jiangyunshui@kylinos.cn>,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v2] platform/x86: samsung-laptop: Use sysfs_emit() to replace the old interface sprintf()
Date: Fri, 19 Apr 2024 14:41:06 +0800
Message-Id: <20240419064106.2396705-1-jiangyunshui@kylinos.cn>
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
Reviewed-by: Ai Chao <aichao@kylinos.cn>
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


