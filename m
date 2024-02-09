Return-Path: <linux-kernel+bounces-60145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F28500B6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0355E1C2113A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861D38DDD;
	Fri,  9 Feb 2024 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aty1sJbu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6636AEF;
	Fri,  9 Feb 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520917; cv=none; b=Hz1u5iTQ+YqCxdGKUVDw00KNOlXHECtR2jqf6+xSHbYfAwLKjOERrdIXwe6drLqKhMCE3y4I179fpkXdIjHeb3VYgI6atd8ZPfv4hikgQhA7Gv0cSwAPZUTGMh4YrQ75T+I8zoThRn3w63OYxJU2poqwhWnBJ9kr479x0ikadBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520917; c=relaxed/simple;
	bh=JIhHPCLub+GIlJ4MJ6tsKD5RtbEyFnsXJnH4vNKqDqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=bRojCzv4YrCaDTTBbyMo7C1lOOIyP+Crm4NgYPpvPm8ybmD7dZT60s1zo7w1Rm2n5KkmizUrv+Xc6awLlzlRKk/D700BtAJ3dkfc8Tas8VRDjMJy2rJ0sJ8TDvVwmQU6jV5jQzNERxb/ygQqCjt7NORK+gC3L2q2BoqqY3oNVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aty1sJbu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419NGKCY018192;
	Fri, 9 Feb 2024 23:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=cv5
	SkJuNqt3ewpDLnxOENQWIUMdt2pVQ9B0+/buE1X4=; b=aty1sJbu/a8RHThCtxx
	zSdhunB9uZ69YCWA2LY8jnjFdhRCjQn99V+SopdNZzZeSgbV1c1gTQKkNN2ytSqL
	r46f8+vSGbIH2xw8sF1nkoiHWBMV3aOZhLzc9aA8ZsWzqRhOlNY/7QidoThI69dL
	p8/9h9jsVJexHF+yZiBzt3X6f2CbekB42PXy0Uxmg/TyJKZ/vxOjXTGgUOV7FQyW
	hhJ1qFXbTlt3irW3ZBs7aA+wvIcmtKmiMzhWaOj/tlJjYiRsrfCCNKd+YbyKVY37
	1NuLZVs6WD6yNFiLMihkm5B91LjxowSMZkqnhKMuE5js5Y1VPHXcy7MNcCtFYemv
	DwQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5pgprwjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 23:21:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419NLnel028427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 23:21:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 15:21:48 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Fri, 9 Feb 2024 15:21:48 -0800
Subject: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks
 protected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240209-qcm6490-gcc-protected-clocks-v2-1-11cd5fc13bd0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIuzxmUC/43NQQ6CMBCF4auQrh3TFgRh5T0MCzodYKJQaJFoC
 He3cgKX31v8bxOBPFMQVbIJTysHdmOEPiUC+2bsCNhGCy11JrUsYcYhz0oJHSJM3i2EC1nAp8N
 HAKJL27TWFLlJRUxMnlp+H/l7Hd1zWJz/HG+r+q1/hlcFCoxNs2thNBVG3eYXI494RjeIet/3L
 4WuG37KAAAA
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
        <linux-kernel@vger.kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707520908; l=2379;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=JIhHPCLub+GIlJ4MJ6tsKD5RtbEyFnsXJnH4vNKqDqA=;
 b=oxOaWPD9bzFyxLTLusdZS7WLGJXt3FT5Z2Nzp9WkCleMwZRAuH0qbFAIDg8vUmHkJkomB/zzP
 49pO8QvI9h+Di8RnisP2Bd2hMlLtk8YjDHB4F8hjxLHZMJTFHKoY8m7
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y3XU2iUZMLsYXCszu7rQ59-sa0ONYbD9
X-Proofpoint-GUID: y3XU2iUZMLsYXCszu7rQ59-sa0ONYbD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_19,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=775 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090171

The SC7280 GCC binding describes clocks which, due to the difference in
security model, are not accessible on the RB3gen2 - in the same way seen
on QCM6490.

Mark these clocks as protected, to allow the board to boot. In contrast
to the present QCM6490 boards GCC_EDP_CLKREF_EN is left out, as this
does not need to be "protected" and is used on the RB3Gen2 board.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
I did notice Taniya's patch [1] after writing this patch. I'd prefer to
merge this minimal set asap, to make the board boot, unless there's a
strong argument for including those other clocks in the protected list.

[1] https://lore.kernel.org/linux-arm-msm/20240208062836.19767-6-quic_tdas@quicinc.com/
---
Changes in v2:
- Dropped GCC_EDP_CLKREF_EN from the list and expanded the commit
  message to cover this descrepancy from QCM6490 devices.
- Corrected SC7180 to SC7280 in commit message.
- Link to v1: https://lore.kernel.org/r/20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 8bb7d13d85f6..ebbe2c1123f6 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -413,6 +413,23 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&gcc {
+	protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
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


