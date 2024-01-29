Return-Path: <linux-kernel+bounces-42448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D784017A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0658D2817FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B175A0FD;
	Mon, 29 Jan 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hbFSHvBd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8F59165;
	Mon, 29 Jan 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520350; cv=none; b=EmhNmJOlz+5jsDV9Q1hbDnRXkhOGnnKKIW13IiwfyMXaB/8xQUaiPvJQWix7sYdPpgOSxPWHyMn8vW9HtijReAumku8LV85rPMh2rr5vm2FHN/LqxkWCch9vhiOS0DMFIpS5Vz7coRngJbMJslVoVsx7VJWv4dDRyAvQa1p6WJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520350; c=relaxed/simple;
	bh=t7s1FSCOXG2rdiLCX/W18lRx2RplcCqZsRP3SaL2aTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdKpBxQrVvf9Gjs5yzRN0qMOCX7zGbAALMt2xYEVGJe6MUSMdONmJOgNv1JWYmUA/Vgb0k+bN2TM7f+rAgG2W9b9XiAaH9noGMHBRJnLmUfUd2V/3B8gIPYo91k4hVAgfs+zMzHEGdxupUX54NGHkaJRkGzMA7T6l3AAcwiBxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hbFSHvBd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T6vwbo003097;
	Mon, 29 Jan 2024 09:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=4k90eqRYN+e0unFDtNdP
	xTfyh1xGz9iE/pfPQG5Npj0=; b=hbFSHvBdMxxRq4Gbns+1CBEHUryXFgRbxPWc
	qHm20fZYjHmwIxbDFSxFLD4PyKZg5ZQwbLW1i22AnOCVd5pV63eMllEwlIbrbmCm
	MDoQbWYKsd8rMkCmXLDtsDIMVdVNq7DLl0e1/mqNnwcozrAf9o1tPBP4rOxTw7Dw
	V5TvimR9n4nP0hnqTKaR6HOVvobY/mb2xoVIq98JD4doomyfS+bvN6VHYxzQmOK5
	C1GhwXpPZJSA1EfPJeY9M8JuAJJojtWjaNQyBe77mztoVt7ry59mrhQj5D6S7dqC
	jyp35VT68QilQieLGQFVRvQRvOH/BS5EsuV6TYGK0oppsuTaNg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t9rkph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:25:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T9Ph4r028750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:25:43 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 01:25:37 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 2/2] dt-bindings: pinctrl: qcom: consolidate functions to match with driver
Date: Mon, 29 Jan 2024 17:25:12 +0800
Message-ID: <20240129092512.23602-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129092512.23602-1-quic_tengfan@quicinc.com>
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0VrvvDuWnd0pwK0FgHka1QIOgDKMVY7U
X-Proofpoint-ORIG-GUID: 0VrvvDuWnd0pwK0FgHka1QIOgDKMVY7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_04,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401290065

Consolidate functions to match with SM4450 pinctrl driver, because
consolidate functions are being used in SM4450 pinctrl driver.

Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 51 +++++++------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
index bb675c8ec220..4109104de054 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
@@ -72,40 +72,23 @@ $defs:
         description:
           Specify the alternative function to be configured for the specified
           pins.
-        enum: [ gpio, atest_char, atest_char0, atest_char1, atest_char2,
-                atest_char3, atest_usb0, atest_usb00, atest_usb01, atest_usb02,
-                atest_usb03, audio_ref, cam_mclk, cci_async, cci_i2c,
-                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
-                cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, cri_trng,
-                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
-                dp0_hot, gcc_gp1, gcc_gp2, gcc_gp3, host2wlan_sol, ibi_i3c,
-                jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
-                mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws,
-                mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, mi2s_mclk0,
-                mi2s_mclk1, nav_gpio0, nav_gpio1, nav_gpio2, pcie0_clk,
-                phase_flag0, phase_flag1, phase_flag10, phase_flag11,
-                phase_flag12, phase_flag13, phase_flag14, phase_flag15,
-                phase_flag16, phase_flag17, phase_flag18, phase_flag19,
-                phase_flag2, phase_flag20, phase_flag21, phase_flag22,
-                phase_flag23, phase_flag24, phase_flag25, phase_flag26,
-                phase_flag27, phase_flag28, phase_flag29, phase_flag3,
-                phase_flag30, phase_flag31, phase_flag4, phase_flag5,
-                phase_flag6, phase_flag7, phase_flag8, phase_flag9,
-                pll_bist, pll_clk, prng_rosc0, prng_rosc1, prng_rosc2,
-                prng_rosc3, qdss_cti, qdss_gpio, qdss_gpio0, qdss_gpio1,
-                qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
-                qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5,
-                qdss_gpio6, qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink0_enable,
-                qlink0_request, qlink0_wmss, qlink1_enable, qlink1_request,
-                qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss,
-                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4, qup0_se5,
-                qup0_se6, qup0_se7, qup1_se0, qup1_se1, qup1_se2, qup1_se3,
-                qup1_se4, qup1_se5, qup1_se6, sd_write, tb_trig, tgu_ch0,
-                tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
-                tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk,
-                uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
-                uim1_present, uim1_reset, usb0_hs, usb0_phy, vfr_0, vfr_1,
-                vsense_trigger ]
+        enum: [ gpio, atest_char, atest_usb0, audio_ref_clk, cam_mclk,
+                cci_async_in0, cci_i2c, cci, cmu_rng, coex_uart1_rx,
+                coex_uart1_tx, cri_trng, dbg_out_clk, ddr_bist,
+                ddr_pxi0_test, ddr_pxi1_test, gcc_gp1_clk, gcc_gp2_clk,
+                gcc_gp3_clk, host2wlan_sol, ibi_i3c_qup0, ibi_i3c_qup1,
+                jitter_bist_ref, mdp_vsync0_out, mdp_vsync1_out,
+                mdp_vsync2_out, mdp_vsync3_out, mdp_vsync, nav,
+                pcie0_clk_req, phase_flag, pll_bist_sync, pll_clk_aux,
+                prng_rosc, qdss_cti_trig0, qdss_cti_trig1, qdss_gpio,
+                qlink0_enable, qlink0_request, qlink0_wmss_reset,
+                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4,
+                qup1_se0, qup1_se1, qup1_se2, qup1_se2_l2, qup1_se3,
+                qup1_se4, sd_write_protect, tb_trig_sdc1, tb_trig_sdc2,
+                tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout,
+                tgu_ch3_trigout, tmess_prng, tsense_pwm1_out,
+                tsense_pwm2_out, uim0, uim1, usb0_hs_ac, usb0_phy_ps,
+                vfr_0_mira, vfr_0_mirb, vfr_1, vsense_trigger_mirnat ]
 
         required:
           - pins
-- 
2.17.1


