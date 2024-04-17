Return-Path: <linux-kernel+bounces-148581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FD8A84B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02CCB26685
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B671428ED;
	Wed, 17 Apr 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jur4hjDb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8014265A;
	Wed, 17 Apr 2024 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360594; cv=none; b=tKFJt7rN+4xqXPejpn4f2vo+nO3GuGELwyhB2zIdJn6StcsA/Y9r7p2V/ARlxFbTGIdR7OmDzR/HzIdHF3UbYv2KhBUgs5hWZLrf8nii8ccC9JzZKLf8jlpv7VmaxOdtSy0Lz23nwfBuMewQ90BCAvvTItD6bH44grUwZpz+kKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360594; c=relaxed/simple;
	bh=ap3yETWhGdlTMXDScP3bro/G7/DpwrWrEKfFg/0SGOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhTjY2+TtN8ozpOnLFU/xmWezk9rjQeOrc4/1muCwnJKwBW8Efq4CLjTIPyceaYuV2pGXEI0VhLAMNLtDR9npdXXIuF9mmyuwSsMnFeYs/D8sAzBFo8bd6IskfrHrusPrydyPmq226suoSWcus9so0ndpu9kcfbXt0br7Q+GYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jur4hjDb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H5hNBa004220;
	Wed, 17 Apr 2024 13:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ttOE1QysXenid3EZheVP4upwox/+1teWi3FjMmvzemg=; b=Ju
	r4hjDbcQtXdTZNL1niNuAy8/lDEQealEDtqbtzlGSjgqMHfsivV273e/We/8WIOc
	SWxijPFfk2L6ZOlLdyOnamHfDGPbUB42sFllm1Qo6SYSsElVX1UXgj27TXPla8km
	1rSZjrgqIXZg0dnoTGxBHepMSZTlKBQOvzmp50cSJu8IFOi2EmSrV55S7dEOz5sm
	OKWBJqubl3mpFUD+ikC2YV0/l4dLi3iPSQVhe+xjgjOHBRJ6QmaEap9zAMwZ22Ce
	BPdneaeQirC6CLB9CTfCpyM+FgLOlthrf1N+n4M14BNR2vepOVV2er7Xt4BhyiDi
	HzD/cJTy5lHZcGT9qJww==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8h791t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:29:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HDTjJD017209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:29:45 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 06:29:39 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH V3 4/5] arm64: dts: qcom: x1e80100: Add cpucp mailbox and sram nodes
Date: Wed, 17 Apr 2024 18:58:55 +0530
Message-ID: <20240417132856.1106250-5-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417132856.1106250-1-quic_sibis@quicinc.com>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hHjtGQt8AYh5NAWLeGTtZOj0l6gA70Gu
X-Proofpoint-ORIG-GUID: hHjtGQt8AYh5NAWLeGTtZOj0l6gA70Gu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=990
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170093

Add the cpucp mailbox and sram nodes required by SCMI perf protocol
on X1E80100 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Rename sram sub-nodes according to schema. [Dmitry]

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 28f65296781d..f40e95d49370 100644
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
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x18b4e000 0x400>;
+
+			cpu_scp_lpri0: scp-sram-section@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x0 0x200>;
+			};
+
+			cpu_scp_lpri1: scp-sram-section@200 {
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


