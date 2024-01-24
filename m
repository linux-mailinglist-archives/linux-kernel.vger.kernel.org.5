Return-Path: <linux-kernel+bounces-36312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5645839F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EBA2853E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4AC2D5;
	Wed, 24 Jan 2024 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AgbnsIy8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAE441B;
	Wed, 24 Jan 2024 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063627; cv=none; b=MFxKHnJPOkOHIbdQY0MyoT7sd9ipGWaS2KLz1cFxEKRrV0r/TdejCYup0NIXBG4htPqU5krZLzkcSHy3rxN1UfbqvrvFYhN2c1PKxiRmluk92cTnkrSjBp8SLUIdSf3xzQKdV7UeNaNoHnk9L+FxJLhYTmg1IpiJ4gHv6gG5vuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063627; c=relaxed/simple;
	bh=YU9+wroalOLdMvzmldfqEmWkmf1soj4hQyRF2NROHkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPjT/nStMSyZcMAECituZjfeq615qvIbD6yq30IDE5aQe+dZ3eyG8owt5bbnEjinAJ4vgxMYNIb0zGsbjmXjBNNi5njG5l6JGmYlswoYZOJjXwFybD9NOTH4LyBTJSqnVF2n3WFjTQAyjxATnKi+02g2s636NtEM/BukU3LsxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AgbnsIy8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O1nulA005028;
	Wed, 24 Jan 2024 02:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=vfBm3wWuombKn41PnIOC
	2MsGqxybU5Z0ee5Y/Fq3+L4=; b=AgbnsIy8hs2sBITdplhGq7vyPP8YbrQBpLsY
	Gumx9s0bGnJVDq9xjal0jZJbdBppO9I0ji2qp0jw0zyfRpAJKrlOVkfEMCSLtnnb
	MqpG7BDjqQCDyEQZtmm+0ATBr35AWurbKMo7uOwZMP3a82Jlb7FtjNbkR527anaq
	8a0jn/egVujAByBrcuRoZXBCfUb0+oxt79UIrbmxAM9gxhg7FKfvx3GzGDzbKevR
	PooZXY8gc2kcY0OAS3pUcZnlHCkHrdMRZzooU4u1KDtXsFHUixZBeMk9nkBT3keC
	E1r9LflJ0osj0ICFYgDJz+k64EvM03JqtvdUINdK39CYmZ5Kvg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmhr0k0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:33:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O2XecK011230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:33:40 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 18:33:35 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 2/2] dt-bindings: pinctrl: qcom: consolidate functions
Date: Wed, 24 Jan 2024 10:33:05 +0800
Message-ID: <20240124023305.15755-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124023305.15755-1-quic_tengfan@quicinc.com>
References: <20240124023305.15755-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EAM-BDHOUDLE6HSa_-IA-y4ZzTmrP92w
X-Proofpoint-GUID: EAM-BDHOUDLE6HSa_-IA-y4ZzTmrP92w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401240018

Functions are consolidated in SM4450 tlmm driver, also consolidate these
functions in SM4450 tlmm binding file.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 51 +++++++------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
index bb675c8ec220..449fe442d3b2 100644
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
+                prng_rosc, qdss_cti_trig0, qdss_cti_trig1,  qdss_gpio,
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


