Return-Path: <linux-kernel+bounces-81723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B8867967
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86962871F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF95130AC2;
	Mon, 26 Feb 2024 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P0Igz8a1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6DB12AAC5;
	Mon, 26 Feb 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958425; cv=none; b=tpzcGrrAaU8sewnT1b+2Ka1EGVlieRvQfKH0k0FI3M1HuWYJA8oxZO3wpFsz95W92TMFPNycfW20YNAlLFF0TX9TTBagDSSQtlOfKmKdwWHcMLWfkQ8V+jnQUlxPk74Ptjb9ZxolFbIVSju9jVp9d2cdbq6raNxiIdUB/yEMj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958425; c=relaxed/simple;
	bh=XvQEtwLAKWGhgBGarB0Wr7PB20ORxGBoZaxk/dpNHoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poEwsmoPwPeh57o7q9Dc7HZWAhVG6B8+Hd893uj5ENXt+c5zK7h7i+EFddDw7SQTojga8OSwHCa8qAbhY8+bAgprFuXIxcXjyfuV2TZEeLfAWQf55DAFCt0C+yz76ASREwx4upaTeA6L+SK824pVLs6Dc6k9j8gGKr+TBThXNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P0Igz8a1; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QDKxnB024671;
	Mon, 26 Feb 2024 14:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=PTxvjhul145awLzkBxJam1t2BqjccVZh9EDCquswOoY=;
 b=P0Igz8a1yW+3uPXed8+DqynuwvtvJZ+qYT5WYjag0clIgCLSovk1madVXhtfNX2nKtiL
 2XU0lrnppHN/lB5A5joHDrL5SJO7m72uJN/T3T4McoZQ7Mlfmw+Eymg+r9Ektg/A/83r
 l18gI8fgMVbIIBPIaGGtQu2UszXM2W9vGyD0DPrXlYzKyHpEXGbWkN08jE+oTKBKum8G
 7ZMetjcmZEsKYHsZFxuGTGu9wb8QivC7BHVsX9BR53i+87aoaJP2T+wcRARdM9rCEfA2
 b+RlDgKPkvY33/A0k0AAdv8vBLa5JnM1CrXxi9/o88sY/+St8LHInFOeI0PO5Z3SUgjU iA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7cccq00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 14:40:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QEUvlN019220;
	Mon, 26 Feb 2024 14:40:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdhfsr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 14:40:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QEeEMA040203;
	Mon, 26 Feb 2024 14:40:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wgbdhfspg-1;
	Mon, 26 Feb 2024 14:40:14 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, dan.carpenter@linaro.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] platform/x86/amd/pmf: Fix missing error code in amd_pmf_init_smart_pc()
Date: Mon, 26 Feb 2024 06:40:10 -0800
Message-ID: <20240226144011.2100804-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-02-26_10,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260111
X-Proofpoint-ORIG-GUID: G1Uc1xhAlbV6aCXUu4JMFiz46PnnPrZj
X-Proofpoint-GUID: G1Uc1xhAlbV6aCXUu4JMFiz46PnnPrZj

On the error path, assign -ENOMEM to ret when memory allocation of
"dev->prev_data" fails.

Fixes: e70961505808 ("platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested
---
 drivers/platform/x86/amd/pmf/tee-if.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 8527dca9cf56..dcbe8f85e122 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -458,8 +458,10 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 	amd_pmf_hex_dump_pb(dev);
 
 	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
-	if (!dev->prev_data)
+	if (!dev->prev_data) {
+		ret = -ENOMEM;
 		goto error;
+	}
 
 	ret = amd_pmf_start_policy_engine(dev);
 	if (ret)
-- 
2.39.3


