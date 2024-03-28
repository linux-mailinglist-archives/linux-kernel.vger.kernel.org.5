Return-Path: <linux-kernel+bounces-122727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104988FC23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004041F2B0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006E7D080;
	Thu, 28 Mar 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nK8luy4b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED01657BD;
	Thu, 28 Mar 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619500; cv=none; b=gxoAKDWAi7RDLNc/9256TTLoDBtfhXnocMv3aI2KMbqBq5tfcRhEayhhwXrt7JIhxoxB24uBXaU6LvroBEj5XlQv1gPWpfAIZmAFYb50ypG5mym+tybOktzJfbrwRvh+8aWSCYApsElzQIlVmokDRUGzEU1pme66X5O34E0NWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619500; c=relaxed/simple;
	bh=vrXx/Czr7/UZqjjpiCjikNTGzt4PYPsJkGEktDov+a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwOwavlnKq+YlSAcmlM6PpKTGDGBeETVokjYdI1KSfZVwMUupyqH/ilzFIyHNXRAsVeTpGl7yr66faHzW/h/3PUCtSsreusfcKa7QeDIhm2gplWvpQhtSVgk2SvCjPitRUwtUtQoX2A6d7BOw8R4pesn+q1J0CpTL4XbslfJy1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nK8luy4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S9p89n016787;
	Thu, 28 Mar 2024 09:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=EbotbkzJ2yDd6Ap6hUOa+Nkth3h8cS9gm4/cZSnoSUA=; b=nK
	8luy4bJoPtMyS/bAxSxDYTAi7irHkOVEm1zpSk5KUaUtZV2fWe/TCMdEA+9Gy7jg
	yyRdf2xIZxCAond7PldcgJ41IiSxWoXy8njlRwxh32+a0w7BoOTBGcTDk5WMMu7/
	ttWl0+pcjsIxvCKL5+MVY6xaCWHkd/8kDChx//81D8t00w2Ukg+8mznXBavCN6Rr
	w1HXLFErsTfV/RwK6fNyHXHFOs0RdZ0jvh7iayXRGid/hlqWfGBJRM6tjyBJxwLi
	n8aKgynn17E3z/r48O8937dRW7dQjGw0iNIvhj0DiawtO8ZF7GAjx8EhvAdxHOQ5
	j2DwM64qTd+zVSwsmpGg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wju45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S9pVxk020792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:51:31 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 02:51:25 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH 4/5] arm64: dts: qcom: x1e80100: Add cpucp mailbox and sram nodes
Date: Thu, 28 Mar 2024 15:20:43 +0530
Message-ID: <20240328095044.2926125-5-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328095044.2926125-1-quic_sibis@quicinc.com>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GoNXGEhfwzBg5qrD-gEF6zzLFMtXBROu
X-Proofpoint-ORIG-GUID: GoNXGEhfwzBg5qrD-gEF6zzLFMtXBROu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=988 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280066

Add the cpucp mailbox and sram nodes required by SCMI perf protocol
on X1E80100 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 28f65296781d..4e0ec859ed61 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4974,6 +4974,13 @@ gic_its: msi-controller@17040000 {
 			};
 		};
 
+		cpucp_mbox: mailbox@17430000 {
+			compatible = "qcom,x1e80100-cpucp-mbox";
+			reg = <0 0x17430000 0 0x10000>, <0 0x18830000 0 0x10000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		apps_rsc: rsc@17500000 {
 			compatible = "qcom,rpmh-rsc";
 			reg = <0 0x17500000 0 0x10000>,
@@ -5157,6 +5164,25 @@ frame@1780d000 {
 			};
 		};
 
+		sram: sram@18b4e000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x18b4e000 0x0 0x400>;
+			ranges = <0x0 0x0 0x18b4e000 0x400>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			cpu_scp_lpri0: scmi-shmem@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x0 0x200>;
+			};
+
+			cpu_scp_lpri1: scmi-shmem@200 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x200 0x200>;
+			};
+		};
+
 		system-cache-controller@25000000 {
 			compatible = "qcom,x1e80100-llcc";
 			reg = <0 0x25000000 0 0x200000>,
-- 
2.34.1


