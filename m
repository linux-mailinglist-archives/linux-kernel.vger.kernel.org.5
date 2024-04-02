Return-Path: <linux-kernel+bounces-127759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA81189508C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162B9B2446C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED566626DF;
	Tue,  2 Apr 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XO4n/LgT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A9604C8;
	Tue,  2 Apr 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054471; cv=none; b=gFDJJa6KPSXs/7r+rxq2lrEQq5yLhF8tlnBkP5LylzlmnMnKV63R+LNo3KKnnlcxKFeqk3UtbNdaAL3MupJX9OjJLAPcH6tBabjZwhd59N23A1uAkcSsOIk117VwoSJifkrCj91mB4o05Pr/VaGwmH/+kLNBm/MadSc6Jlf3YUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054471; c=relaxed/simple;
	bh=cxM78pKms/4lwSlDz7hbP/DmZncN6R7RsfyspvuOEmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjL+KgUm4it90yAw7jlq5q4QGSH1zRUhPaSC4B2CrQuElNfcZSKM3Vk/d83wTxNryjfagWRMHu7xCiVLawW77RSn3qFhAB8cW6aLwZftWyW9a12d/leNthlG/S8oWUXhZQhZgb8qDxD1MlQ/z+W58IQ1+VVIzEkahQaiYXsn2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XO4n/LgT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4327hnp8021239;
	Tue, 2 Apr 2024 10:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=KneB49LPzOM38AMQBvSH5d/jF8EAr0Yt5QSa5AJ9wZQ=;
 b=XO4n/LgTzRsCDZWM27SVeuGn5x/8MtGyUc23GGjU6fzDwRF4qnTDQnqdK80MYNggTJ7p
 4DcL66b6b8Yf1Lw+N5e9vmqlSaNEafsF/vkwwg7fElDRUS/NmQXoNvW2ka4/ue7J6uvj
 V3YS0TyymAtQ/R63dGRwatrF2f1NnFc0sTEDQeHugQr1yWM0geziheU8Ss6KG0wnvUH4
 eF3kTwAqBmN7/ocAyk9ry9l/ebtiyEKBcxMA26vnTuXMEPLSCf7lU1nFgD/vk6xQFyLA
 xqLrchDwZwz56gDkGNHFWundyC7W2i95tiSR3zZ78qgDKZYLPWZe06GhOtT8LqV0TL5U zQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abuc9uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 10:40:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432AREFs040407;
	Tue, 2 Apr 2024 10:40:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6966sr8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 10:40:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432Aeqei023453;
	Tue, 2 Apr 2024 10:40:52 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x6966sr8h-1;
	Tue, 02 Apr 2024 10:40:52 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
        Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Grant Likely <grant.likely@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] drm/panthor: Fix NULL vs IS_ERR() bug in panthor_probe()
Date: Tue,  2 Apr 2024 03:40:40 -0700
Message-ID: <20240402104041.1689951-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020077
X-Proofpoint-ORIG-GUID: bRNmNBiqVfRSvrPgK0gLxKD1AqCyVTOC
X-Proofpoint-GUID: bRNmNBiqVfRSvrPgK0gLxKD1AqCyVTOC

The devm_drm_dev_alloc() function returns error pointers.
Update the error handling to check for error pointers instead of NULL.

Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is spotted by smatch and the patch is only compile tested
---
 drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 11b3ccd58f85..1b588b37db98 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1385,7 +1385,7 @@ static int panthor_probe(struct platform_device *pdev)
 
 	ptdev = devm_drm_dev_alloc(&pdev->dev, &panthor_drm_driver,
 				   struct panthor_device, base);
-	if (!ptdev)
+	if (IS_ERR(ptdev))
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, ptdev);
-- 
2.39.3


