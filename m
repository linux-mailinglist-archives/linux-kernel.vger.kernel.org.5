Return-Path: <linux-kernel+bounces-75643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6285ECC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24EAFB2483F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0712DD84;
	Wed, 21 Feb 2024 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="av3ybLCG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2E128380;
	Wed, 21 Feb 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557568; cv=none; b=THiZhSW888hcAJADRPOAgHjl+/pElRIA3G7UV+ZBFeaamoFw4zYalTK/jU9N4DWL107cErIJuAAQg98qCniX3FuBE5jXzWfnwoXkVOClvpto6mqcmgGK3X6s+DqOE/E6AA4HUtyfdhkU4qwmpYfl2P/RIeExEM8WPZFltk5RzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557568; c=relaxed/simple;
	bh=Wdb3bw5S4Ft62crWKdT0nvE7FRKEthctMFQHwfbHq5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J0iPkvqiQCEEk4ciJQMZJcq2h2AjvSXGOD//jEWWzp8E27SvxqSzrhgZRD5zBO+KH1MgYbfPzHRv3pml/uWgbFdmCJ5seJydlR0fVa9yWjpD9patQcVmuU5IJUaLURvfP+PoWUV+h5a6SLXX4ZKQG+nRoYDl0z4D5BlW0U+gtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=av3ybLCG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LMoo39028933;
	Wed, 21 Feb 2024 23:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=xmn8Evf13kcBccHXDWA5BY7RVq8NiRYpblmyINXaRzg
	=; b=av3ybLCGBZcl1PCXWPYK9dMRdt5bPdw2D4QaLLJvwvB/QyPrdMS5Zb/RL2I
	2KbLAzm7alI3XjoiNYiUDj0FNqGcRFilI1YWq+kFlKBEw9Io4SLSMMIkqf+8P0tU
	6K7cWkOFdWhPvALHrDz7qs+UxBvkZLeHtrtyoNcGV6NNmArAK3bWOdNqHvrGwjjk
	QdTXWGXqfYCa/Ncj1+sgURuA4DXHNe5qvaQqid5ChvbONstul1rVEHgBZLV1nucH
	fKbKcnwEo39q3lvfm1xAyPycGYnzbY3v8JYYei23sgAsAmQSOFLPedwxQ7YCse99
	eDICeZq0BcwPMBVEnkTfy7I06oA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdpe6rhvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LNJEY0028451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:14 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:19:14 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 21 Feb 2024 15:19:12 -0800
Subject: [PATCH 4/9] arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240221-rb3gen2-dp-connector-v1-4-dc0964ef7d96@quicinc.com>
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708557553; l=1137;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Wdb3bw5S4Ft62crWKdT0nvE7FRKEthctMFQHwfbHq5w=;
 b=9sqxt5cS0mygDPgorDsj2AMQ7xgjv3DF1eCYJpuYUH5fGml5cH/YBG9RPr2LPDLrCEJ02iLjr
 J9mOnl2w1E7ArLw8iQ9La9HVAONFQn0gXHtLVHwYduchylWGlds/AUf
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kPRcMZiw2yQAu_J-_-hgT3CVfeP6QZ6Q
X-Proofpoint-ORIG-GUID: kPRcMZiw2yQAu_J-_-hgT3CVfeP6QZ6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 mlxlogscore=997 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210183

The RB3Gen2 board comes with a mini DP connector, describe this, enable
MDSS, DP controller and the PHY that drives this.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index ac4579119d3b..32313f47602a 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -430,6 +430,23 @@ &gcc {
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_edp {
+	status = "okay";
+};
+
+&mdss_edp_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
+&mdss_edp_phy {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -470,3 +487,9 @@ &usb_1_qmpphy {
 &wifi {
 	memory-region = <&wlan_fw_mem>;
 };
+
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+&edp_hot_plug_det {
+	bias-disable;
+};

-- 
2.25.1


