Return-Path: <linux-kernel+bounces-92583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23B87227A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF090B22887
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F25A127B53;
	Tue,  5 Mar 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a2RbLXxW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D51272D6;
	Tue,  5 Mar 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651651; cv=none; b=X+CSyWtanZj1NYN6FkoQ/p+F56e/H8OLa2k5DeDy9ezhEJVQAUUpgvYCNeonemsCDttME2SIVJNGrAlmRjY1sDjzRweiFHtVGuueabbJ8kyFuv0cf4nCJY927iDetqQI7F/+Rgd60nFwPdaPFxJ3Fp0Sk9UFjTwk1RnOmYOtZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651651; c=relaxed/simple;
	bh=bakCZ9es46lRltxeWaCLHG4o29noimUeEJml7VSCSJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=XioINwKEC9rZtUr45otILC4vHAoR+lIGQUPhkAhVfixNCVPeRwAmS+AzZmIR1enOxj3SzSL3SmY/mUlbHtPffQgq+s6nlplg8IzN6bTpY7gGgiP5E3a0NJBuwLOzrTuO/AxXaAzLb8QibnFeFNjLh0RwrmokggMI+R1kiudhzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a2RbLXxW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425AdEe1000832;
	Tue, 5 Mar 2024 15:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=N7k
	a69ojYSj7OycunJLytUg2tzQ0zy2pi+ZfrNUkAOU=; b=a2RbLXxW370pk38Cq/p
	FlGrUByDKBwqC2P1S2NXxRuHitClD9FfKq68xrP7whH1B4NRcWrwYFBNHicfmD2i
	gQtrobK1FPVAzdr9g7NFHQZSQO+Vrb8S9bbb2FiARyK/jELsHJLKt3lw/SmnmdWV
	sIY3WOlAaspZzBadhVC2+MZUvlYTKow9kolqGwauIzCFbZdbhjcU9BLq7L0/KYCD
	ve4ZHePKZ4Fbz52U+lCMi0RY34UqlChM9dj9H2GBPoYBaUe+gkHtEflDpMgOB1Mt
	NmrdF3S56pJuVI989jY7iyubQa1d8QL///E8LeBBkVPO3E6kZl/1SzqEVbsVhBvn
	/Ow==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnx0y130s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 15:14:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425FE1J0005645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 15:14:01 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 07:14:01 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 5 Mar 2024 07:14:00 -0800
Subject: [PATCH] wifi: ath11k: fix soc_dp_stats debugfs file permission
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240305-fix-soc_dp_stats-permission-v1-1-2ec10b42f755@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALc252UC/5XNSw6CMBCA4auQrq3pC6SuvIcxBKZFZgHFFhsN4
 e4WlrqR5T+Z+WYmwXq0gZyzmXgbMaAbUvBDRqCrh7ulaFITwYRikina4osGB5UZqzDVU6Cj9T2
 G9Y4qI8sTgNCgapKE0du0vunXW+oOw+T8e3sW+Tr9z42ccgqCc6Zt0TCVXx5PBBzgCK4nqxzFD
 k0kLZe8FLU2jWDFryZ3aDJpRufMSt4WWn5py7J8AKUcqQdkAQAA
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Sa-JY9xUxJEwV9XCXr4cBwJK4DbyhuH5
X-Proofpoint-ORIG-GUID: Sa-JY9xUxJEwV9XCXr4cBwJK4DbyhuH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050121

Currently the soc_dp_stats debugfs file has the following permissions:

# ls -l /sys/kernel/debug/ath11k/pci-0000:03:00.0/soc_dp_stats
-rw------- 1 root root 0 Mar  4 15:04 /sys/kernel/debug/ath11k/pci-0000:03:00.0/soc_dp_stats

However this file does not actually support write operations -- no .write()
method is registered. Therefore use the correct permissions when creating
the file.

After the change:

# ls -l /sys/kernel/debug/ath11k/pci-0000:03:00.0/soc_dp_stats
-r-------- 1 root root 0 Mar  4 15:15 /sys/kernel/debug/ath11k/pci-0000:03:00.0/soc_dp_stats

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index a48e737ef35d..414a5ce279f7 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/vmalloc.h>
@@ -980,7 +980,7 @@ int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
 			    &fops_simulate_fw_crash);
 
-	debugfs_create_file("soc_dp_stats", 0600, ab->debugfs_soc, ab,
+	debugfs_create_file("soc_dp_stats", 0400, ab->debugfs_soc, ab,
 			    &fops_soc_dp_stats);
 
 	if (ab->hw_params.sram_dump.start != 0)

---
base-commit: 776c9c93bb0511d04e6222546499e5ea20ad51b0
change-id: 20240304-fix-soc_dp_stats-permission-4d387cc29c4a


