Return-Path: <linux-kernel+bounces-69884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1D858FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9477A1F22029
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B47B3C9;
	Sat, 17 Feb 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aisT4pG6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5E7AE44;
	Sat, 17 Feb 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178250; cv=none; b=aDMAEM6kIeCwHgjxrgVPVP6GNm4s4v9GxWzryireJl19gnAnYLuSuPpYz6kbwzHaHWGjIZ/DiTtYaYkr9WB7SHJwesux08v6GwKmOdWvzKZJZQPRNxhbVL2Bcz1n5ba6L9yUYvmz/5gW1gSVD91JQWesJxpFA9FRHZzd3HwoM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178250; c=relaxed/simple;
	bh=wftFHk4jzES9vDs2ANiZtphQYDYENKzFBUmfNJ9pR/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SYCUvimf92ZEYCeY62tbfzfoD2EYQF7RXnWAMY+RaN2xi/57dP3ZIQWboZEO3TJbD95W0Ddw2ldeXtYQK5HLa3dtRcdGpoJ/w/voUAIdQ1k/TOGecxzVczrLn25oz0iM/rbP0UBFzhogD2yv5iDPGHQQFtt2IbBaX73h5BTI9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aisT4pG6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HDbBoc004255;
	Sat, 17 Feb 2024 13:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=mwzABwdWNWrkewwBO37WiJFPjz8OwxhXknYoD7FSgk4
	=; b=aisT4pG6J1bI8Rfm8vUKbuZ0ZFmYt93GC5p3i6e9Bv8RWhhIiUYmm8TnM/w
	oKQRgLNOOuqP30zYw7cKZQKA2+KOYajElq6WXJqCE4G2ifP+ADBWPk8gwi6qIOtQ
	OLg7ev+5sRDwV1lOwPRUMhBUO5Qm4wZQ7JA14+5ppeKxDjXbD6uJ4DOq9/Fej33y
	LyA4wf0OwdMrxzZhcOOxnxChCGtXevQ+c3mdPuBPDhA0B1xuw842boBis7plGK/K
	MlT+ozultcT/bXXztEgDwilq+bAYA0gGbISJOMfI9eTxjmfHvDh7kPOKIOJCi1qJ
	/nbOtrVksoAo4qr+7aMmczPHwkg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wav1ar4e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 13:57:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HDvGgS026943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 13:57:16 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 17 Feb 2024 05:57:13 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Sat, 17 Feb 2024 19:27:07 +0530
Subject: [PATCH 1/2] soc: qcom: Update init level to core_initcall() for
 cmd-db and rpmh-rsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240217-init_level-v1-1-bde9e11f8317@quicinc.com>
References: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com>
In-Reply-To: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_lsrao@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708178229; l=1457;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=wftFHk4jzES9vDs2ANiZtphQYDYENKzFBUmfNJ9pR/c=;
 b=H6gcB0VQ3OIGQtfx4U/KwYbyMeci9KevvJ/GCFxh95BvZ4Qo1hlK36f3btRnaohmomxLLZVlP
 2UwvK8HDLtzB8VASaJW1zfuU7QS0yLFJfxgMOZ8hXHwWLa7xuT+aGZD
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2X7MUvLR_4MB3vVm877mBC0mP43YJjHZ
X-Proofpoint-GUID: 2X7MUvLR_4MB3vVm877mBC0mP43YJjHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_10,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170113

cmd-db and rpmh-rsc are used by clients like regulators, interconnects and
clocks for resource voting. These clients are in core_initcall() while
cmd-db and rpmh-rsc are in arch_initcall(). Update init level for these
drivers also to core_initcall() to avoid unnecessary probe defer during
boot up.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/soc/qcom/cmd-db.c   | 2 +-
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a5fd68411bed..c344107bc36c 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -362,7 +362,7 @@ static int __init cmd_db_device_init(void)
 {
 	return platform_driver_register(&cmd_db_dev_driver);
 }
-arch_initcall(cmd_db_device_init);
+core_initcall(cmd_db_device_init);
 
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Command DB Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index a021dc71807b..c4c7aad957e6 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1154,7 +1154,7 @@ static int __init rpmh_driver_init(void)
 {
 	return platform_driver_register(&rpmh_driver);
 }
-arch_initcall(rpmh_driver_init);
+core_initcall(rpmh_driver_init);
 
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
 MODULE_LICENSE("GPL v2");

-- 
2.22.0


