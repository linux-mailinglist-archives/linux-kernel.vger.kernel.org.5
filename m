Return-Path: <linux-kernel+bounces-164387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C204B8B7D11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623781F21380
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CA61836EE;
	Tue, 30 Apr 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A9RdBZHN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A292180A9C;
	Tue, 30 Apr 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494726; cv=none; b=JpUTlXpnr5j3Vb9+OhZDY+GPDEUjXdKQdxcEHbA+spyGQDP71VdfDQkMdFPFhaM42hshtCYJPdgkzvObh75BRAOxs7vqBBsqAwUnkwJJ5OBCHNz/QL3fVYkSsCLHfBk+k2tEL+KbYA4qUmHCSlD48nFkV9MuWghijb0myh0MxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494726; c=relaxed/simple;
	bh=qG3GsTd0IpwBap3hqKmO0EpwtMawAshN9LAhOnrp+SY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lHb+MDOrWwo4oC6KRCiRkJ0FecFnF1PMqGuKt6wY80PSK+cnqp0fDJIXi3SkCVulvbPuulP1dF6d6B/CUwILQO8yNxCHQCIrvbUr0BJAcD+sB7rkSnJ5gQMb/3CTKxuF1EYOmJOWUwpw2igjEBVQb4MxJdofNLILp/DPY6MZUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A9RdBZHN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UBLQ9R005821;
	Tue, 30 Apr 2024 16:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=BVApZpi3cm00qmCTLAAK7bHPM5npIeOaJG2v2/YaX2g=; b=A9
	RdBZHNXMmbJ/0weQLDUcsa535G1JMhrN58MKqp/qixNUmdq4+mBNmK0ePam2D6n7
	GRnn/j1DiywH1E3IlLlazC+XWEP6maey0n4vAe8vTchEJLWDDdSkUQtVmDCf2D/s
	+Lo84sateLRSSk0pr3dt7f9uCjWdPpmdIIQz9u4/KR50QZF+qNU3Qy7l4oagWNZf
	+0xMJm11Qqggx50uau+Bcr80+ZXGYGjTPLq5ztuMpeTCiIsuPVDQ9wqZJbbAAMIk
	j2cbxC5UITs/fSRb2K8euxqBM+AqizErYNwXF/qPd2c+chrl/qoq1oGnXDJVLBHy
	B1VuzIP78GmVT7lqWFUQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtyptgs7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:31:59 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UGVt6O003699;
	Tue, 30 Apr 2024 16:31:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1f83-1;
	Tue, 30 Apr 2024 16:31:55 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UGVtAv003693;
	Tue, 30 Apr 2024 16:31:55 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UGVtjA003692;
	Tue, 30 Apr 2024 16:31:55 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id CBF0B2287; Tue, 30 Apr 2024 22:01:54 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: qcom: sa8775p: Adding iommus property in pcie DT nodes
Date: Tue, 30 Apr 2024 22:01:50 +0530
Message-Id: <1714494711-10322-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714494711-10322-1-git-send-email-quic_msarkar@quicinc.com>
References: <1714494711-10322-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qvNGy0O7bEYfPFxgDqASkWCNr5F8V5jv
X-Proofpoint-ORIG-GUID: qvNGy0O7bEYfPFxgDqASkWCNr5F8V5jv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300118
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

'iommus' is a list of phandle and IOMMU specifier pairs that describe
the IOMMU master interfaces of the device. Specified this property in
PCIe DT nodes so that IOMMU can be used for address translation.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9065645..0c52180 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -3666,6 +3666,7 @@
 				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
 		interconnect-names = "pcie-mem", "cpu-pcie";
 
+		iommus = <&pcie_smmu 0x0000 0x7f>;
 		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
 			    <0x100 &pcie_smmu 0x0001 0x1>;
 
@@ -3822,6 +3823,7 @@
 				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_1 0>;
 		interconnect-names = "pcie-mem", "cpu-pcie";
 
+		iommus = <&pcie_smmu 0x0080 0x7f>;
 		iommu-map = <0x0 &pcie_smmu 0x0080 0x1>,
 			    <0x100 &pcie_smmu 0x0081 0x1>;
 
-- 
2.7.4


