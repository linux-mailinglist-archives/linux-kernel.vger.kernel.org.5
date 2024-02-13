Return-Path: <linux-kernel+bounces-63277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9721852D25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52F128C534
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0EB22638;
	Tue, 13 Feb 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ct2nbt0W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6A22615;
	Tue, 13 Feb 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818141; cv=none; b=XFBXYx5UMFNkuBIZF/DLhrCp6h/wqE7tQB2FgwzTUWmB5BxwFCVeSMj2HRtV59EuBshllROr/NrazthMOkJgTH0zqafWphh2uVOfx4fgDltoWlmgGYbuhARBjDzaI9gzo1otusECeuvJrNb2jgSYe7Ag4iKiwx4eCOkrpLxXtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818141; c=relaxed/simple;
	bh=C4iNBZPrjL46Oaov232LSgom1YmPp5ylrGEfTx2JReM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTHwAI2zgy54NGh+8jHA8cWd+WaYSRNSX5iUBLzrJMRCwHKoE7YF5++b24ZIEUD7XpQX1MTXlH8hrlZZmzVLu4OrSAa/gXmf/hSS8asgyA06c64tBMdUofusLVNdMkFf4VDGC6dufMDwSdSoo2cVssC846PU0Ex14YaOUNs3djg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ct2nbt0W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D5mNa6010919;
	Tue, 13 Feb 2024 09:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=C4iNBZP
	rjL46Oaov232LSgom1YmPp5ylrGEfTx2JReM=; b=Ct2nbt0Wyxotfy1d6oQQ9E1
	j20woGh1x52AdSJM7HayKn5UrJB1xCMOWPw+saFARYgqmfRs+/QEySHA7yUqmiLb
	Mjp2x4xl1vWUGB3bX3+gz6onbotCRUrluJ9zUJ+IeaVtDSKjhC+a3S35jrOwUlc/
	yE4kbpTUwgSWGgTE1jGUsf8ly19eoh8jhE6zmypeGUDVsIiBYDePuktEh5DBA+2g
	xAcT/+PRWOCHcArI3U4fjoX3NmtcvF+H9WS5S8ospNWoLxFXTR71GwVSbmxKAr2n
	KRcAvr06wkboZBj4oxGxDslsypmzYhlgHpZ5SI7XP9KzfHnGveGpedBKux4jF3Q=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7hewaj1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:55:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D9tLUN017535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 09:55:21 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 01:55:17 -0800
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        Udit Kumar <u-kumar1@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v2] arm64: defconfig: Enable GCC and interconnect for QDU1000/QRU1000
Date: Tue, 13 Feb 2024 15:24:59 +0530
Message-ID: <20240213095459.18402-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BReBCKfLj1rHPq_nItU412pvFvLwtLlo
X-Proofpoint-ORIG-GUID: BReBCKfLj1rHPq_nItU412pvFvLwtLlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=625 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130077

Add the QDU1000/QRU1000 GCC and interconnect drivers as built-in.
These are necessary for the Qualcomm QDU1000/QRU1000 platform to boot
to shell.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Rebased on top of 6.8-rc4
- Collected acked by tag
- Link to v1: https://lore.kernel.org/all/20230822132333.17580-1-quic_kbajaj@quicinc.com/
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..f121716cd883 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1265,6 +1265,7 @@ CONFIG_MSM_MMCC_8998=m
 CONFIG_QCM_GCC_2290=y
 CONFIG_QCM_DISPCC_2290=m
 CONFIG_QCS_GCC_404=y
+CONFIG_QDU_GCC_1000=y
 CONFIG_SC_CAMCC_8280XP=m
 CONFIG_SC_DISPCC_8280XP=m
 CONFIG_SA_GCC_8775P=y
@@ -1552,6 +1553,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8996=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_QCM2290=m
 CONFIG_INTERCONNECT_QCOM_QCS404=m
+CONFIG_INTERCONNECT_QCOM_QDU1000=y
 CONFIG_INTERCONNECT_QCOM_SA8775P=y
 CONFIG_INTERCONNECT_QCOM_SC7180=y
 CONFIG_INTERCONNECT_QCOM_SC7280=y
--
2.42.0


