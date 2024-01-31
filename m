Return-Path: <linux-kernel+bounces-45735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290298434C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B287A285E94
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BDD168C6;
	Wed, 31 Jan 2024 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GE+YHipP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2C1642A;
	Wed, 31 Jan 2024 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674578; cv=none; b=CLt1mAeC0zrz8IEEf+/IrYyujl8JhUymBxUdck8+4r66YoroiYW3ZrGG9WVF3w7YRF+HzoT2ExqEZZietpbiRMJKFriugIYAm/uYk9i4D0xgDoLd8JeRyzQ7RF6deet2TQ2FEa6IbKfPz7WLLY+NtrcbrxCFn8if1vFg8Yc+AYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674578; c=relaxed/simple;
	bh=7UqosF6/dQF0CDaGJw9WFy6Rab7GGyn/FKeQvoamwG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=W2SxdBUDJ0W8NAOB9w1KN5kUWNZVIhBqR/t5WGqnMfugpt7VlM/Jv7ptFnGz5mGJ9vJrC8mBHpVNiwA5fzPNBk2kxLTr4zVb5eQu2wB8xy600rT45UPmyXZWkwkGwhuVubmf3qEElU2iRcj70OcW7d5qBf0eQ+1rL62cInTQfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GE+YHipP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V3HgV2003205;
	Wed, 31 Jan 2024 04:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=YHv
	VC7NpPcSbURPZzsXH6yGrnE3u3gKgjl1HSqxfmvs=; b=GE+YHipPs3z6zN8Jval
	4QievWxeUBiROefQR2p6wiMnGsAS8BPW3XjsvelQ2CTWpXVQjlkMfJavzHHlY/jX
	4dwYaKVAzK281R0X4SO9dWoZ3g5tdyigd3ymrFjXn2LG2W2c0N2XgSe/kkAKTDjX
	2kinkER+N4ASUhYWeguBRzCTPzVAenX9HbP/9oKHAvXX6A5170snUfk2adlWqROQ
	QEF7lkVwmCKYESrYXFqNRhbV88KPhEV9o4TDdHdlIwrB9plR4Mi3urKCSVsyj9dV
	jEpoK8ayfuOj/fpGa4PlfttDiRsiiIH/9Ouq3gg7Oj/WFJZtezJRqqmIuXur53tH
	n4A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy9nk8kqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 04:15:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V4FtQD011236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 04:15:55 GMT
Received: from [10.213.108.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 20:15:52 -0800
From: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Date: Wed, 31 Jan 2024 09:45:40 +0530
Subject: [PATCH] watchdog: qcom: Start the watchdog in probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240131-qcom-wdt-start-probe-v1-1-bee0a86e2bba@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGzJuWUC/x3MTQ5AMBBA4avIrE3S+o+riEXpYBaUaYNE3F1j+
 S3ee8CTMHlokweETvbstgidJjAuZpsJ2UZDprJC6VzjMboVLxvQByMBd3ED4dCQKitlaKotxHQ
 Xmvj+t13/vh/luDHAZgAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC: <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Nd7n9wQmaiUB0aaaei3Bi1dxvZV-N77
X-Proofpoint-ORIG-GUID: 9Nd7n9wQmaiUB0aaaei3Bi1dxvZV-N77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=993 clxscore=1011
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310032

When CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is enabled, kernel can pet the
watchdog until user space takes over. Make use of this feature and
start the watchdog in probe.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 drivers/watchdog/qcom-wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 9e790f0c2096..4fb5dbf5faee 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -276,12 +276,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
 	/*
+	 * Kernel can pet the watchdog until user space takes over.
+	 * Start the watchdog here to make use of this feature.
+	 *
 	 * If WDT is already running, call WDT start which
 	 * will stop the WDT, set timeouts as bootloader
 	 * might use different ones and set running bit
 	 * to inform the WDT subsystem to ping the WDT
 	 */
-	if (qcom_wdt_is_running(&wdt->wdd)) {
+	if (IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED) ||
+	    qcom_wdt_is_running(&wdt->wdd)) {
 		qcom_wdt_start(&wdt->wdd);
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	}

---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240131-qcom-wdt-start-probe-b8e0560aef7d

Best regards,
-- 
Pavankumar Kondeti <quic_pkondeti@quicinc.com>


