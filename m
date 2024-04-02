Return-Path: <linux-kernel+bounces-127740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B85C89503E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CE71F26D84
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671B2604D5;
	Tue,  2 Apr 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aU+AJi5M"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C35FDD3;
	Tue,  2 Apr 2024 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054072; cv=none; b=ODC730hv/heg3kUTBskHQl0887nSs4kaOzV5l9x7BcYT0cLMxpwVoyQvWdVHzKQXm+WiiUar8Qu2rngIK2Lw/mEJ4mY1+ziMyn30v3pqGprFwS1hPIzO0hinSILqiseDIV4PRV6pan38LWoXnt4wQJfZKMM4/EmKhDejDkV1+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054072; c=relaxed/simple;
	bh=MtHCuL1dh9NAzjU2nv4D1ZXmRiiRxmcJ91zi476pkWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jn0teP5PZn1FvRs2G6NJP7xh36xHyS2X/0RZMNCOA8aC7T9bw4cyvYerINLUGTUd2t/X+q1RCReMtZsDrhHinsDKzzSLI8uhVNRjeWszglGEpJ8n0UnOt7ptO9qGJzUcgAVLwTvhAn9q8toTsLFf+cAnOt5RQ/FmBWplzpLRlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aU+AJi5M; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4327iiOs004794;
	Tue, 2 Apr 2024 10:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=doURrX6cOIUJ979xtncnfOLcxqEuol0zMJzFfxCbUk4=;
 b=aU+AJi5MFCodAk/sE0HwPxZduCE1+urSGSR7GQB3QWmLFxnI9TNyzhteQjRqx2V4z4rg
 5VWPZ6uNo7+Yr6BCQC+xIKw5SxRQa8b3gHAJsI0UV/emKu05CWwCUFy9dRQJcpgR9ZIg
 TR3pEaR09yw0+rT7Dd2+/X4XEVFQq/Iy5d+eYrcevzUmQGlWPlMqYRX+jag9exft4sdP
 1ew653avEVE6amuk2YgsQgOJSTLVDVdjwOXK0cvBiTzKl4BakSz+RHNe2VD3sm1AOQYa
 cKRbBMDp+Xy/BZzfPoa/aznsmbW1c/9iZUokQpZU9QpCcVlfvAbjlDetPzdNZHbV4/j2 tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6ambcap8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 10:34:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432AIud9018642;
	Tue, 2 Apr 2024 10:34:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696cv055-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 10:34:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432ATveP027893;
	Tue, 2 Apr 2024 10:34:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x696cv03w-1;
	Tue, 02 Apr 2024 10:34:02 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
        Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] drm/panthor: Fix NULL vs IS_ERR() bug in panthor_ioctl_tiler_heap_destroy()
Date: Tue,  2 Apr 2024 03:33:58 -0700
Message-ID: <20240402103358.1689379-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020076
X-Proofpoint-ORIG-GUID: eNjiaX-TyA1zHTP2tDJYuaKaSAl0CL5e
X-Proofpoint-GUID: eNjiaX-TyA1zHTP2tDJYuaKaSAl0CL5e

panthor_vm_get_heap_pool() returns ERR_PTR on failure.

Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is spotted by smatch and the patch is only compile tested
---
 drivers/gpu/drm/panthor/panthor_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 11b3ccd58f85..050b905b0453 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1090,8 +1090,8 @@ static int panthor_ioctl_tiler_heap_destroy(struct drm_device *ddev, void *data,
 		return -EINVAL;
 
 	pool = panthor_vm_get_heap_pool(vm, false);
-	if (!pool) {
-		ret = -EINVAL;
+	if (IS_ERR(pool)) {
+		ret = PTR_ERR(pool);
 		goto out_put_vm;
 	}
 
-- 
2.39.3


