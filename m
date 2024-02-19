Return-Path: <linux-kernel+bounces-71033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72953859FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2C4B21269
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFB2377E;
	Mon, 19 Feb 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mau9Ebr7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7A22EEA;
	Mon, 19 Feb 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335177; cv=none; b=C+RlJKWYt8LxqA16OpyR88rQDig/SkKFWzkrAh+023UrPO+vnK5b3TKRHRKVc5eczzBHGqwAl8iJJQDDsnmILPiBCAg7jF95jc9t8i31wsg45GXFhBtW8EQ769zuaaUGgiPFa5FRNyBXlB6RZ6QrLWuJnyNJ7ZCWjWcw+QKQQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335177; c=relaxed/simple;
	bh=ZS3Y1QYf06xxLXuHZlX8GeM8mB1EJdbog4XFx5iwF3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=uu3N0hJAoHytJzHEa03NJZaVKPf1aICOPVXjkEw4LOwAJrVtPGzanAlusup83nAG1HrBbTuKdL9+S3S4IIg1yVKBrCjH/pDqcfTj0tQW3goZnAlkj+Ubyzq9fgnRWeyR4G/nRbTKeJzHiDhOJQAmn4a4iKPyr85T0+IcNsWYMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mau9Ebr7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J4gbeG026075;
	Mon, 19 Feb 2024 09:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=Y5M
	BezfMip5ZI2S3AI3GTn3PBt+P0Aqqgw6e36T45K0=; b=Mau9Ebr73NxinaOQ8N1
	2uefx3ATph67wMo1f25ggcshmoiMFkK1imrZPbJHijPWQd09xmfHoPFnIte/gHsm
	ejOkIYr+8QkIEU6nyb4ZgoM0lzec1zmVZfnk+hMXwSOC26RjMBt+5XQPrdF+/FPW
	mhj/hTQ1QFK5DIcUdlJkE1C8R8WTYIAlhrW5ehUtEDfDB00bYejM4bEiH3EqzsQm
	WEsrPliZRTcl5T5dfz+iY1ggRl1erTYg443n6lo5Q1PAXL5Ulx5mcqw4k/Ev3A6f
	seUr5HfV5pW8e9t2JPUZ0/rSqw5KmfJBOXfTgKdd4YBk53KTMQn8RlCEvHcTuO5x
	DWA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3waqmdu7s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:32:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41J9WAId011806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:32:10 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 01:32:07 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Mon, 19 Feb 2024 15:02:04 +0530
Subject: [PATCH] firmware/psci: Move psci_init_system_suspend() to
 late_initcall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240219-suspend_ops_late_init-v1-1-6330ca9597fa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABMg02UC/x3MwQqEIBRG4VeJu05QmSHqVSJEp7+6ECbeiiB69
 2SW3+KcmwSZIdRVN2WcLLzFAlNX9Ft8nKF4LCar7Udb0yo5JCGObkviVr/DceRd2WYKOphv8AC
 VNmVMfP2//fA8L5xC05FnAAAA
To: Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>, <andersson@kernel.org>,
        <ulf.hansson@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <quic_lsrao@quicinc.com>, <stable@vger.kernel.org>,
        Maulik Shah
	<quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708335127; l=2024;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=ZS3Y1QYf06xxLXuHZlX8GeM8mB1EJdbog4XFx5iwF3g=;
 b=ga9/v4Ml0Cu9Xh1RUQQdciRkpaIi/1DATfwfjVDzR+/4zC9kR1Plx0cyEDQJz44vnh64RK2K6
 dlNLUFFW8FWBRm2UkuqCIyCb+xGdR1xhYYqJi8BHZkDsynjlxyp3kpO
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CWUXajokXSM3DAXfGqs0J8xUoo4revAs
X-Proofpoint-ORIG-GUID: CWUXajokXSM3DAXfGqs0J8xUoo4revAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_06,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190071

psci_init_system_suspend() invokes suspend_set_ops() very early during
bootup even before kernel command line for mem_sleep_default is setup.
This leads to kernel command line mem_sleep_default=s2idle not working
as mem_sleep_current gets changed to deep via suspend_set_ops() and never
changes back to s2idle.

Move psci_init_system_suspend() to late_initcall() to make sure kernel
command line mem_sleep_default=s2idle sets up s2idle as default suspend
mode.

Fixes: faf7ec4a92c0 ("drivers: firmware: psci: add system suspend support")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/firmware/psci/psci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..655a2db70a67 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -523,18 +523,26 @@ static void __init psci_init_system_reset2(void)
 		psci_system_reset2_supported = true;
 }
 
-static void __init psci_init_system_suspend(void)
+static int __init psci_init_system_suspend(void)
 {
 	int ret;
+	u32 ver;
 
 	if (!IS_ENABLED(CONFIG_SUSPEND))
-		return;
+		return 0;
+
+	ver = psci_0_2_get_version();
+	if (PSCI_VERSION_MAJOR(ver) < 1)
+		return 0;
 
 	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
 
 	if (ret != PSCI_RET_NOT_SUPPORTED)
 		suspend_set_ops(&psci_suspend_ops);
+
+	return ret;
 }
+late_initcall(psci_init_system_suspend)
 
 static void __init psci_init_cpu_suspend(void)
 {
@@ -651,7 +659,6 @@ static int __init psci_probe(void)
 	if (PSCI_VERSION_MAJOR(ver) >= 1) {
 		psci_init_smccc();
 		psci_init_cpu_suspend();
-		psci_init_system_suspend();
 		psci_init_system_reset2();
 		kvm_init_hyp_services();
 	}

---
base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
change-id: 20240219-suspend_ops_late_init-27fb0b15baee

Best regards,
-- 
Maulik Shah <quic_mkshah@quicinc.com>


