Return-Path: <linux-kernel+bounces-33626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6E836C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20101B30574
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6E60BB8;
	Mon, 22 Jan 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVg/5b11"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5E405EF;
	Mon, 22 Jan 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938613; cv=none; b=JGPyEB9+QoNNOP/6n4FxBEGTPnpYGada7vgGo9a7mFdE/6TA/LgXbOi/J52OVLhhHSQJwKpVFHn6L/MRQWZrI2xcDOF1vnnj6o2kHHdlIAnkBAdJWqf/AujbHDOWln7ZqTlJ9FF7U4XY4bgZXiTm3yCtur3tVG5lLoIpdi5z8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938613; c=relaxed/simple;
	bh=PME5bbv3asP19dSw6d/TnXvufb8ShPW1A+mWkN22bCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SsNiSRRvkAzJ9bD0sHVlMyN8adWRWMS8uVHNv7yGYb5LKel0zzdOgvGxrKr5l9w24mu0vv1mnAQ4Zl319NOTWLQM0CSOE49XSUW6SmsVXh287jHXZ3VubBy0RB0ooOFwrhRIcCV1uG6o+TZtd1GhFC8yaK1TniSBpJIGHUrAM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SVg/5b11; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MAY6eZ000913;
	Mon, 22 Jan 2024 15:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=6+n08baSWoKll1alAdFlutI81OxW5WoCAt0Bwt8+8Rw=;
 b=SVg/5b11X9hsfS0XxUeB8SDt9PCe6LmN+FawiYto8pm6zvpO0yxSQznPLCQXJlb8eDYq
 Em1/QIZ/ZUeoi2ZwmnbGsWjT6qb7HbfB5zuzDEO+qVUCVr53HaUuFkFBMHsK6mU/+MGU
 6uSldCxEaaAk1Ggl3NzZPL+lCgPoncppCSPnqH6+IHnH2n5GNf2Fly9UkX7WnGrqE6g1
 6BV6Apw39gVnvoqS8zNoDm+kkRCnSS3fmvVyGLBNGR1QcdLdrc7E0h+61h1qbAtw8TyX
 Mt3SoHb4i58e2EegnCCETUCYk3oURwHo15Cqz0zm7K9dW0t1B0NM4+Emzii++8qMJgvl ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwbukn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 15:49:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MFZV2Z039341;
	Mon, 22 Jan 2024 15:49:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs36yun01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 15:49:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MFntnC001674;
	Mon, 22 Jan 2024 15:49:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vs36yumye-1;
	Mon, 22 Jan 2024 15:49:55 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Aleksa Savic <savicaleksa83@gmail.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] hwmon: gigabyte_waterforce: Fix locking bug in waterforce_get_status()
Date: Mon, 22 Jan 2024 07:49:52 -0800
Message-ID: <20240122154952.2851934-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-01-22_06,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220107
X-Proofpoint-ORIG-GUID: L-dIc_Sqd8wHUlpEMhIJdMzSKoQ6ulL-
X-Proofpoint-GUID: L-dIc_Sqd8wHUlpEMhIJdMzSKoQ6ulL-

Goto 'unlock_and_return' for unlocking before returning on the error
path.

Fixes: d5939a793693 ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.
---
 drivers/hwmon/gigabyte_waterforce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gigabyte_waterforce.c b/drivers/hwmon/gigabyte_waterforce.c
index 1799377fc2f1..7bccfe2eaa76 100644
--- a/drivers/hwmon/gigabyte_waterforce.c
+++ b/drivers/hwmon/gigabyte_waterforce.c
@@ -146,7 +146,7 @@ static int waterforce_get_status(struct waterforce_data *priv)
 	/* Send command for getting status */
 	ret = waterforce_write_expanded(priv, get_status_cmd, GET_STATUS_CMD_LENGTH);
 	if (ret < 0)
-		return ret;
+		goto unlock_and_return;
 
 	ret = wait_for_completion_interruptible_timeout(&priv->status_report_received,
 							msecs_to_jiffies(STATUS_VALIDITY));
-- 
2.39.3


