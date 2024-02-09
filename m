Return-Path: <linux-kernel+bounces-59596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE7A84F984
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFE81C21474
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EF7AE5A;
	Fri,  9 Feb 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jVz/5lvq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1438DFC;
	Fri,  9 Feb 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495708; cv=none; b=MRspJXZzAgyRkMQwS2ITevM+sVOLxT4G2B5EaniNTz5DT0bfM4S7GBSHdea4az1/1Rj8FjduDnzpfYNQY+JcEGOSdq+sJRppfi/qejs52QjCYIhevPCTvgCkkDaZah1HN/B5iK60CkzUbp/RvMcCfVhBU3tGeNKtduwLc0JYPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495708; c=relaxed/simple;
	bh=hqjchC5NtI3mMK21Kso1MhP15+mHLJImbn68cgBfHxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=C8xjewykjHvltUV4KTQj+BfUZuSKCXSPDLPd5H0AJQ6US9W7w3Bx3e0L4QA6vNNJd7dFzr3FV9Ou6JAzwhkj1AGMFVvt95lCB02skZcXUS2zFyPunDdA1q34fA7d1ZpNHa6zjnjETGeeU4ESVyS/35BYlpCn19CR3j57vw/LO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jVz/5lvq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419FF4lK011811;
	Fri, 9 Feb 2024 16:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=YmX
	eaovgq9gr9BjuRmCIS4CvTnAi9h5R7HzHHoe65jY=; b=jVz/5lvq1lBvZmtnDKy
	BTiIuMSF4/mlderWUWevyvP7TQsVRmZafCuu3ZrcghInLT/UlLzykaqPmb5zY0Yz
	5IT7UHnibny4jawMHNCCqxJc2vVfXr5CYq3P2VL5PCbyZQJx6+uIod/OmXWd/rXQ
	OgCoH4twjo9WdiPTk9Hm6qWt3hc9U7LobSuuoYsTlhuQBqN4+KkVdbeRoW9Yrcjv
	zKmuPQGKcLlY7PLitqxC65/CfZygkcgxrQNNkffTG6etuORODgy5E86UhlM7P50V
	bU3fqoyM/PqKMFpBPPubOs0fp5/jOBl+MgFKN4TZCfvjSptWtnSkD2NzpmHBHFTc
	Nzg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5pgpr4uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 16:21:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419GLg4t008928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 16:21:42 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 08:21:42 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Fri, 9 Feb 2024 08:21:39 -0800
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks
 protected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABJRxmUC/x3MQQqDMBAF0KvIrDsQo7XYqxQXOvmxQ63RREQQ7
 97Q5du8kxKiItGzOCli16RhzihvBcm7n0ewumyyxtbGmpZX+TZ1a3gU4SWGDbLBsUxBPomBu++
 9Gx7NUFEulgivx79/ddf1A7U5t31uAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707495702; l=1787;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=hqjchC5NtI3mMK21Kso1MhP15+mHLJImbn68cgBfHxg=;
 b=SHuHi8dxsOvDQAo1kJxth8iidY/egijXsIEMMy0DvVv7YNKEAADAoHc9DFLjIRYGO8jzmlC4k
 sEOukJY6+KyCDqTdUwJAWddRLrbIMtNYCQUYAlXsmYtyHpzaZ77WeZU
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NBGohk0F4lz-O5S7VrtAiNq1WvGz2koP
X-Proofpoint-GUID: NBGohk0F4lz-O5S7VrtAiNq1WvGz2koP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_14,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=496 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090120

The SC7180 GCC binding describes clocks which, due to the difference in
security model, are not accessible on the RB3gen2 - in the same way seen
on QCM6490.

Mark these clocks as protected, to allow the board to boot.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
I did notice Taniya's patch [1] after writing this patch. I'd prefer to
merge this minimal set asap, to make the board boot, unless there's a
strong argument for including those other clocks in the protected list.

[1] https://lore.kernel.org/linux-arm-msm/20240208062836.19767-6-quic_tdas@quicinc.com/
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 8bb7d13d85f6..97b1586f9f19 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -413,6 +413,24 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&gcc {
+	protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
+			   <GCC_EDP_CLKREF_EN>,
+			   <GCC_MSS_CFG_AHB_CLK>,
+			   <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
+			   <GCC_MSS_OFFLINE_AXI_CLK>,
+			   <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
+			   <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+			   <GCC_MSS_SNOC_AXI_CLK>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_SEC_CTRL_CLK_SRC>,
+			   <GCC_WPSS_AHB_BDG_MST_CLK>,
+			   <GCC_WPSS_AHB_CLK>,
+			   <GCC_WPSS_RSCP_CLK>;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

---
base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
change-id: 20240209-qcm6490-gcc-protected-clocks-ee5fafdb76b3

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


