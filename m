Return-Path: <linux-kernel+bounces-144498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60228A471E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34008B21EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A818C31;
	Mon, 15 Apr 2024 02:52:55 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90D5695
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149574; cv=none; b=h+cwULrRGf4j21uV8MTjfq2bTYq7vvV4T2Qkhkb7+gOD3K40H8//ZXISRMa00ihCPR8sHfpbJR53y0zjqiIzKd5GfjvfeJRQEUyyIkchESSqzEiOKxIhPwysyGYRwjarh1pvKXTGYLIp6vSwkj8uhAkyH9FizSGAKpPxbYO9eeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149574; c=relaxed/simple;
	bh=o5CHhM+14xj/jyQmjSBVKJlACQMvNVbR0GOdf8ccj/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TwNRg1Loz5ow/nVhPHgsYALYghZ0yiXQdGGMIe/7HU+zY0caXcvQYSb94naFMUyY/KOs9QsPLbxarqyuK+qqHUa7vIahzH+mI2szyN1gssgZAxhNd2ibqvQx0ymCYiP5i+Lzwh5H8j5aMLs0hoPG199m8pr+rNOMQ43WjkgSDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 325194bafad311eeaf09c5092e5928d1-20240415
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:02117ba6-a9a5-4e51-b790-ad657f0da0a4,IP:10,
	URL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-21
X-CID-INFO: VERSION:1.1.37,REQID:02117ba6-a9a5-4e51-b790-ad657f0da0a4,IP:10,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-1,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-21
X-CID-META: VersionHash:6f543d0,CLOUDID:ac8ec112b8a1349a46baf061f9423a61,BulkI
	D:240415104546ICIJYRA7,BulkQuantity:1,Recheck:0,SF:44|66|38|25|72|19|102,T
	C:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS, ZHF_RECV_LOCALHOST
X-UUID: 325194bafad311eeaf09c5092e5928d1-20240415
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 246354815; Mon, 15 Apr 2024 10:52:28 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: lucas.demarchi@intel.com,
	ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/xe: select X86_PLATFORM_DEVICES when ACPI_WMI is selected
Date: Mon, 15 Apr 2024 10:52:15 +0800
Message-Id: <20240415025215.15811-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI_WMI is a subitem of X86_PLATFORM_DEVICES. And X86_PLATFORM_DEVICES
is not selected in the current Kconfig, and may cause Kconfig warnings:

WARNING: unmet direct dependencies detected for ACPI_WMI
  Depends on [n]: X86_PLATFORM_DEVICES [=n] && ACPI [=y]
  Selected by [m]:
  - DRM_XE [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] &&
    (m && MODULES [=y] || y && KUNIT [=y]=y) && X86 [=y] && ACPI [=y]

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/xe/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 1a556d087e63..f483e69a5d0f 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -26,6 +26,7 @@ config DRM_XE
 	select INPUT if ACPI
 	select ACPI_VIDEO if X86 && ACPI
 	select ACPI_BUTTON if ACPI
+	select X86_PLATFORM_DEVICES if X86 && ACPI
 	select ACPI_WMI if X86 && ACPI
 	select SYNC_FILE
 	select IOSF_MBI
-- 
2.25.1


