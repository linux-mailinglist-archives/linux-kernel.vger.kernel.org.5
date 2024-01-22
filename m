Return-Path: <linux-kernel+bounces-33889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972C9836FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E830928D446
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877F5473F;
	Mon, 22 Jan 2024 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fFO79Rpq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65153E2D;
	Mon, 22 Jan 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946543; cv=none; b=nPIQozJccjTYOqoxa89W2EsdXF+NVKqDkUaYDS3PXqyiPMpxu2P1kTqjJqaSeo6cvYw8kD/lZqquAORFozquko6XKNPa9yurKaTVnevJQbJsBZ5B/hzgR709GImeY0AF0xErC7wwWsoRRjfFI3hvU9ppU+41sB7CbvMnuIWqCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946543; c=relaxed/simple;
	bh=cvxxevqv6ny07B5cj2gMAM8FMiTwyVSwVjN/WbJrQPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wf5QtI3UATObKQhO71OsUuMabpLJ+ARGjDwDsgW23kKVqDno4bTcyM2pzSmrGM/SJ3hWAs4JXfsIi6LTSAK53gr9jakOiLRnBVz/SQ3WlbaL2F/cEzDXEGOVYzqokmjTYlcfZ+AW15NFYexh0p/wfRJbfWCPxHXeptBin4whSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fFO79Rpq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MHxkgT012119;
	Mon, 22 Jan 2024 18:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=iYu1xsxt+0e5tlIQKHHWFm4zqDaVlRpfR6Mt43vuWF4=;
 b=fFO79RpqJ3WaypfBgGKDhSwvmUhNdfKb9qQin52hTyKTxk/8wpqUgIBns0nzVYyYjFGJ
 g7nRxRm61UeBDU6Ww63gTvp4MLgW+An1lTcKBcO33H11hLsyia7QK+EuAW6aMy5yVF8L
 uT7hUhfn5l45MycJmk5dZTKrHZtd9u+bBrhaN7HkZ/PWF/06ZdfzTV060DoVsSTbQZ68
 NZl0lEpX4wByMdBgPfIv2wGfikwh898klw4JlsvX1R1ayhdO9PEYl9rZhUBqbyOxU4HT
 mSeTEAHX/r5DFpNtSBxv26IcdhX127XedLslCgztrl2OS3M34p3eKhzFuXfP70hUP2JC 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79ncaau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 18:01:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MHwY3o033584;
	Mon, 22 Jan 2024 18:01:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3701vdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 18:01:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MI1KSb015780;
	Mon, 22 Jan 2024 18:01:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vs3701vct-1;
	Mon, 22 Jan 2024 18:01:20 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
        Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: apple: mailbox: fix error handling in apple_mbox_get()
Date: Mon, 22 Jan 2024 10:01:16 -0800
Message-ID: <20240122180117.2862027-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220126
X-Proofpoint-GUID: IQsJFR_A9Z8x-hezvrfttRke3Av_0RW4
X-Proofpoint-ORIG-GUID: IQsJFR_A9Z8x-hezvrfttRke3Av_0RW4

When ret is 0 and args.np is not NULL, returning zero is success
which is incorrect.

Also fix error codes

Fixes: 6e1457fcad3f ("soc: apple: mailbox: Add ASC/M3 mailbox driver")
Reported-by: Dan Carpenter <error27@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202311300228.1rvmJjdA-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is only compile tested.
---
 drivers/soc/apple/mailbox.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 780199bf351e..8e8628182ac7 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -289,21 +289,23 @@ struct apple_mbox *apple_mbox_get(struct device *dev, int index)
 
 	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
 					 index, &args);
-	if (ret || !args.np)
+	if (ret)
 		return ERR_PTR(ret);
+	if (!args.np)
+		return ERR_PTR(-EINVAL);
 
 	pdev = of_find_device_by_node(args.np);
 	of_node_put(args.np);
 
 	if (!pdev)
-		return ERR_PTR(EPROBE_DEFER);
+		return ERR_PTR(-EPROBE_DEFER);
 
 	mbox = platform_get_drvdata(pdev);
 	if (!mbox)
-		return ERR_PTR(EPROBE_DEFER);
+		return ERR_PTR(-EPROBE_DEFER);
 
 	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
-		return ERR_PTR(ENODEV);
+		return ERR_PTR(-ENODEV);
 
 	return mbox;
 }
-- 
2.42.0


