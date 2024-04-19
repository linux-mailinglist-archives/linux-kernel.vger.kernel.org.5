Return-Path: <linux-kernel+bounces-151061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A928AA87D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33231C210DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B33717D;
	Fri, 19 Apr 2024 06:37:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FFC8FF;
	Fri, 19 Apr 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508640; cv=none; b=qWnmNNZw0xCHLdb5rmWPHyIhe1fFYJ8vXmHN2pnjp9XlmpG7ap4IbkptoXmzo5tKK3JWIBWOmKAL1roatwiNJvQFhc03+FtNb95slI5H2q0+7DkHdafwf47v+Vs8lvyUseRu1azp9654BOUd6H1lhiRft1IWSBVtERGnpY/CRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508640; c=relaxed/simple;
	bh=3oYCuss00Y6lx1rb6rmfOuFKrVofZ2I84/mqMog/L08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1lFWCbEPiFsO7N3wYJiwZfOnnlBThJJP7GTnmrxdRoc192LffOVObGBtCtPZdy9xWH1HGoDjnEAILv022lxbeD8/nD7Qrzrpq5UgjyIM2v006qRW6g1D0Ec6qNngeUwxXyptEtBs/DNT7fDjiZaBwtUVlJSTFAbsKRu7mpyFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3e3735b8fe1711ee9305a59a3cc225df-20240419
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:1705c060-9662-448e-81b3-0577d938b5a1,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.37,REQID:1705c060-9662-448e-81b3-0577d938b5a1,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6f543d0,CLOUDID:4c9709fb7963b8f6370dcae612ec3098,BulkI
	D:2404191437099U4E0B0B,BulkQuantity:0,Recheck:0,SF:66|24|72|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
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
X-UUID: 3e3735b8fe1711ee9305a59a3cc225df-20240419
X-User: jiangyunshui@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1349409102; Fri, 19 Apr 2024 14:37:07 +0800
From: yunshui <jiangyunshui@kylinos.cn>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	yunshui <jiangyunshui@kylinos.cn>,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH -v2] platform/x86: msi-laptop: Use sysfs_emit() to replace sprintf()
Date: Fri, 19 Apr 2024 14:36:49 +0800
Message-Id: <20240419063649.2396461-1-jiangyunshui@kylinos.cn>
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
 drivers/platform/x86/msi-laptop.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index f4c6c36e05a5..e5391a37014d 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -317,7 +317,7 @@ static ssize_t show_wlan(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%i\n", enabled);
+	return sysfs_emit(buf, "%i\n", enabled);
 }
 
 static ssize_t store_wlan(struct device *dev,
@@ -341,7 +341,7 @@ static ssize_t show_bluetooth(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%i\n", enabled);
+	return sysfs_emit(buf, "%i\n", enabled);
 }
 
 static ssize_t store_bluetooth(struct device *dev,
@@ -364,7 +364,7 @@ static ssize_t show_threeg(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%i\n", threeg_s);
+	return sysfs_emit(buf, "%i\n", threeg_s);
 }
 
 static ssize_t store_threeg(struct device *dev,
@@ -383,7 +383,7 @@ static ssize_t show_lcd_level(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%i\n", ret);
+	return sysfs_emit(buf, "%i\n", ret);
 }
 
 static ssize_t store_lcd_level(struct device *dev,
@@ -413,7 +413,7 @@ static ssize_t show_auto_brightness(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%i\n", ret);
+	return sysfs_emit(buf, "%i\n", ret);
 }
 
 static ssize_t store_auto_brightness(struct device *dev,
@@ -443,7 +443,7 @@ static ssize_t show_touchpad(struct device *dev,
 	if (result < 0)
 		return result;
 
-	return sprintf(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_TOUCHPAD_MASK));
+	return sysfs_emit(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_TOUCHPAD_MASK));
 }
 
 static ssize_t show_turbo(struct device *dev,
@@ -457,7 +457,7 @@ static ssize_t show_turbo(struct device *dev,
 	if (result < 0)
 		return result;
 
-	return sprintf(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_TURBO_MASK));
+	return sysfs_emit(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_TURBO_MASK));
 }
 
 static ssize_t show_eco(struct device *dev,
@@ -471,7 +471,7 @@ static ssize_t show_eco(struct device *dev,
 	if (result < 0)
 		return result;
 
-	return sprintf(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_ECO_MASK));
+	return sysfs_emit(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_ECO_MASK));
 }
 
 static ssize_t show_turbo_cooldown(struct device *dev,
@@ -485,7 +485,7 @@ static ssize_t show_turbo_cooldown(struct device *dev,
 	if (result < 0)
 		return result;
 
-	return sprintf(buf, "%i\n", (!!(rdata & MSI_STANDARD_EC_TURBO_MASK)) |
+	return sysfs_emit(buf, "%i\n", (!!(rdata & MSI_STANDARD_EC_TURBO_MASK)) |
 		(!!(rdata & MSI_STANDARD_EC_TURBO_COOLDOWN_MASK) << 1));
 }
 
@@ -500,7 +500,7 @@ static ssize_t show_auto_fan(struct device *dev,
 	if (result < 0)
 		return result;
 
-	return sprintf(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_AUTOFAN_MASK));
+	return sysfs_emit(buf, "%i\n", !!(rdata & MSI_STANDARD_EC_AUTOFAN_MASK));
 }
 
 static ssize_t store_auto_fan(struct device *dev,
-- 
2.34.1


