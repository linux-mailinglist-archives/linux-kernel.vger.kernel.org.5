Return-Path: <linux-kernel+bounces-69885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D723A858FD8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E265E1C21222
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3C87A72E;
	Sat, 17 Feb 2024 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g/evDHYN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC17B3E4;
	Sat, 17 Feb 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178253; cv=none; b=B612d+m+KncNCVeHqULa8fD+gko5guD5/ruOtd8jADMy3leRj9v3j61lJQXPGUEXV9XY+0QUtjnhcwMOjQrpHUOavH37P+stUOx4hqh/RGYxxYIegs7+uWMvxp5IH9yHFgLx55VGKW6OKltxYCyir8KsihyLP8j07HZlpC0YdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178253; c=relaxed/simple;
	bh=7qmGheqPGtrRm9XkxLHVtbZRPp+g36a8JHthsGpdo4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NBrZzzLRZQjbetTchNOF1q+5yjB/dxu5zHDR8nCcKFKo7E8WjqLM2kdtJ9jgnhx161yqRF8fdsS4I9ePh9hrDITUKLHHDJBPNXmdBcr1SKMoZCrdlk3/h2+GP9f/GEzxwg6YOCyhgz9zeDdiIrj2UAMXIk6BDHlgdPLQiMtfgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g/evDHYN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HDqDLo022802;
	Sat, 17 Feb 2024 13:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=2YrdYcZv+dIJ5bWHgiBTkNoQ6lNI0HsM73CCnoKmjvg
	=; b=g/evDHYNb6yHCUm/lN4VMj8QzrYxq/Jn28MkrIJd18rOMAz77d1l6nnUqt7
	VGBbAtFS0m9K4PyzyG6FZZkWhcpU+CR3HvujSYdnuvJJcKjojL3Gorch7jO/A0Ak
	CVgXgjimf6IigjTiOHpiB/T1IGJ/2KUj3c2TgYxdcPuvyRa04E/JzjUqqWku2A2V
	h3gNCv/TMKng+LmCNKtbQtR5oDQPd1HAMfASpnofvU++Vf6xgsKG3io7l3wHfZ/K
	DVCxHbt8bf1l8XGeKSAbwlNbNhwZ3PbVQ2MwKf/jC3vRmb3MH3MqTIAu2lc90iYz
	lgqBEeM8PBUWpWXT4T2wTurklCA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wakrwgmw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 13:57:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HDvKn9019429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 13:57:20 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 17 Feb 2024 05:57:16 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Sat, 17 Feb 2024 19:27:08 +0530
Subject: [PATCH 2/2] cpuidle: psci: Update init level to core_initcall()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240217-init_level-v1-2-bde9e11f8317@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708178229; l=909;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=7qmGheqPGtrRm9XkxLHVtbZRPp+g36a8JHthsGpdo4c=;
 b=2dWdy/rhbxVvmO2bUDvggyr4vmus8Oy+A0CB5dkNCdWcohQUF1T/HxmLCmOv91VrbRvZU7Ww4
 +UG7RNYg6WDD7tO4gPi9KfP4NzaSJvNFAVr27hR7v8TlnNCEATykn4A
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CIXOiEz7zKmPGgSzRwt8Jz2QURxnGL86
X-Proofpoint-ORIG-GUID: CIXOiEz7zKmPGgSzRwt8Jz2QURxnGL86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_10,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170113

Clients like regulators, interconnects and clocks depend on rpmh-rsc to
vote on resources and rpmh-rsc depends on psci power-domains to complete
probe. All of them are in core_initcall().

Change psci domain init level to core_initcall() to avoid probe defer from
all of the above.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b88af1262f1a..3e5b1150f75b 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -200,4 +200,4 @@ static int __init psci_idle_init_domains(void)
 {
 	return platform_driver_register(&psci_cpuidle_domain_driver);
 }
-subsys_initcall(psci_idle_init_domains);
+core_initcall(psci_idle_init_domains);

-- 
2.22.0


