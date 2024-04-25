Return-Path: <linux-kernel+bounces-159350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C019C8B2D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7092824F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBA6155A39;
	Thu, 25 Apr 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BVwmB6G8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062F5B697;
	Thu, 25 Apr 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086461; cv=none; b=WgzdS2zHBdZS0eGADYb/XUwR04/5RlQYqlPypQopcCH56ByMfTAGRk3MiXn/PeqgoiGJ8R/Zqs0iLv6kCeDjh3OY2+zPZpr4F6Pv6aFH2+odEwn2he0EpgS+O+bnf3P+1ASZdbHAGOx1+hZc4ijzaLv1a0rm9O8powBSVzfBmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086461; c=relaxed/simple;
	bh=kJYpqm/gCQ0iz0NW+AYmPRY4ELdBOlpMYuluXkwNCxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=n/Zrph3DyHBuET5BBUxM5tXW0z54HC3na58SPRmVw9RRNjm0LXMHCJo+imNtPD1PhVySxU8jgltduK5KzsB6u6iyWmp3BkNfJp6JrrJ479dMmBVRBFf8GzpknfiRcT/i6TBB0WgKz14slcYQQxw+PP+60tuRkXhKIxvNGx8M9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BVwmB6G8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PMgnDT032316;
	Thu, 25 Apr 2024 23:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=/jY
	1qs5mMC+eRfgrFIRUP6sHK/rSTNm1uWk71fRvDFA=; b=BVwmB6G8O/bWLC3XvYI
	uhMAKkCjM92fnqoCiECihr63oEu3cyvBzwHU/KuZFOAXdZE70IGyNkQR4w4LJHpp
	uUXLJXB+x0EQHOwMe2KPd85n1hC3o6JjdFDPhZ82ODgLBkvYnRfpWyB/1vHEG3Mr
	lLEd3NWLiqZkP7u6nE/1Ph5M/R4ZVmUVlyxXfk/bDDAj7VU4Vp6XCA7Q/zuq83Y7
	qFnytyidrpKJrDO+BWtmpTGc/e79kM0xQOxzHz4QxKbIvFBOUONCrdQDpSdp8OAY
	gxvBGh3xnR8mpwJNFaWdewmqUYexruCe/fJEHCOX7T/0LpfPEyI8nARPiOWnsDBA
	ZGg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqn0wj21v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:07:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PN7Ngg011600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:07:23 GMT
Received: from hu-scheluve-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 16:07:20 -0700
From: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Date: Thu, 25 Apr 2024 16:07:10 -0700
Subject: [PATCH] arm64: dts: qcom: sa8775p: mark ethernet devices as
 DMA-coherent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240425-mark_ethernet_devices_dma_coherent-v1-1-ad0755044e26@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAB3iKmYC/x2NUQrCMBAFr1L220ATkiBeRSTE5GkXaSqbIELp3
 V38nAfzZqcOYXS6TDsJPtx5awr2NFFZcnvCcFUmNzs/exfMmuWVMBZIw0hVlYKe6ppT2XREGya
 WaIO/n72NgfToLXjw9x+53o7jB3il1Kh0AAAA
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Sagar
 Cheluvegowda" <quic_scheluve@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _AMgoMKTSRzr01XZx8sBeP9bPMfdqNFw
X-Proofpoint-GUID: _AMgoMKTSRzr01XZx8sBeP9bPMfdqNFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=594 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250169

Ethernet devices are cache coherent, mark it as such in the dtsi.

Change-Id: Id180fae617f2e348c0a80c6664b131cc57fcb4d6
Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 231cea1f0fa8..5ab4ca978837 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2504,6 +2504,7 @@ ethernet1: ethernet@23000000 {
 			phy-names = "serdes";
 
 			iommus = <&apps_smmu 0x140 0xf>;
+			dma-coherent;
 
 			snps,tso;
 			snps,pbl = <32>;
@@ -2538,6 +2539,7 @@ ethernet0: ethernet@23040000 {
 			phy-names = "serdes";
 
 			iommus = <&apps_smmu 0x120 0xf>;
+			dma-coherent;
 
 			snps,tso;
 			snps,pbl = <32>;

---
base-commit: a93289b830ce783955b22fbe5d1274a464c05acf
change-id: 20240425-mark_ethernet_devices_dma_coherent-6c6154b84165

Best regards,
-- 
Sagar Cheluvegowda <quic_scheluve@quicinc.com>


