Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D229F768B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjGaFZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjGaFZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:25:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C954E7A;
        Sun, 30 Jul 2023 22:25:20 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V3ICOp026456;
        Mon, 31 Jul 2023 05:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=vvYs32N8wr1qXwzIfkU27kVhG6gHS5j5QXZvfqDPwDw=;
 b=AQZrNy9vLiDmKVq9w7m5+lqUZvcC1xBJovv56GdxI/xDU46cWD2C6wKx0BDPBhiJ6Uxi
 yBXotlL7H5sYwSWhSw2b8WcfNgGXdSvKS1A37c08d/A6OgY3Lcs3axqTiaLTt4Jnfoz4
 vBhPjjlRDosRYRsZucsMJktfRhUmjzqj7IDAy3Wz/1W7CbUM2Rtn+NC1bwBTJ1Bvt5mb
 L7QCmUpKLq0qz8/UG1CXlyOj/BC97nz8inZq+NLx/3xZdtqdoD+HIrw2JTe6WfdH6Kn3
 yI9Xg1jdRdTrjnDKgltDbu29J+v82/m5V0Fxzc3NXWnd7wXH0O+tv97lPGOHzg0qv9sq XQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ugsaq0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:25:14 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36V5PB0T017631;
        Mon, 31 Jul 2023 05:25:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s4uuk6gy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 31 Jul 2023 05:25:11 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36V5PBbt017614;
        Mon, 31 Jul 2023 05:25:11 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36V5PBTW017608;
        Mon, 31 Jul 2023 05:25:11 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 72A051A08; Mon, 31 Jul 2023 10:55:10 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 4/4] dt-bindings: power: qcom,rpmpd: Remove unused SoC specific bindings
Date:   Mon, 31 Jul 2023 10:55:04 +0530
Message-Id: <1690781104-2290-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yQfSdzeQW-0KJIuJp3gUdDaabEXuJyzU
X-Proofpoint-GUID: yQfSdzeQW-0KJIuJp3gUdDaabEXuJyzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=540 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310048
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused bindings as these bindings are moved to a
generic bindings defined in rpmhpd.h. Even the regulator levels
are moved to rpmhpd so that new SoC need to only use rpmhpd.h.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 84 ----------------------------------
 1 file changed, 84 deletions(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 83be996..6447df0 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -99,64 +99,6 @@
 #define SA8155P_MX	SM8150_MX
 #define SA8155P_MX_AO	SM8150_MX_AO
 
-/* SM8250 Power Domain Indexes */
-#define SM8250_CX	0
-#define SM8250_CX_AO	1
-#define SM8250_EBI	2
-#define SM8250_GFX	3
-#define SM8250_LCX	4
-#define SM8250_LMX	5
-#define SM8250_MMCX	6
-#define SM8250_MMCX_AO	7
-#define SM8250_MX	8
-#define SM8250_MX_AO	9
-
-/* SM8350 Power Domain Indexes */
-#define SM8350_CX	0
-#define SM8350_CX_AO	1
-#define SM8350_EBI	2
-#define SM8350_GFX	3
-#define SM8350_LCX	4
-#define SM8350_LMX	5
-#define SM8350_MMCX	6
-#define SM8350_MMCX_AO	7
-#define SM8350_MX	8
-#define SM8350_MX_AO	9
-#define SM8350_MXC	10
-#define SM8350_MXC_AO	11
-#define SM8350_MSS	12
-
-/* SM8450 Power Domain Indexes */
-#define SM8450_CX	0
-#define SM8450_CX_AO	1
-#define SM8450_EBI	2
-#define SM8450_GFX	3
-#define SM8450_LCX	4
-#define SM8450_LMX	5
-#define SM8450_MMCX	6
-#define SM8450_MMCX_AO	7
-#define SM8450_MX	8
-#define SM8450_MX_AO	9
-#define SM8450_MXC	10
-#define SM8450_MXC_AO	11
-#define SM8450_MSS	12
-
-/* SM8550 Power Domain Indexes */
-#define SM8550_CX	0
-#define SM8550_CX_AO	1
-#define SM8550_EBI	2
-#define SM8550_GFX	3
-#define SM8550_LCX	4
-#define SM8550_LMX	5
-#define SM8550_MMCX	6
-#define SM8550_MMCX_AO	7
-#define SM8550_MX	8
-#define SM8550_MX_AO	9
-#define SM8550_MXC	10
-#define SM8550_MXC_AO	11
-#define SM8550_MSS	12
-#define SM8550_NSP	13
-
 /* QDU1000/QRU1000 Power Domain Indexes */
 #define QDU1000_EBI	0
 #define QDU1000_MSS	1
@@ -215,32 +157,6 @@
 #define SC8280XP_QPHY		14
 #define SC8280XP_XO		15
 
-/* SDM845 Power Domain performance levels */
-#define RPMH_REGULATOR_LEVEL_RETENTION		16
-#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
-#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
-#define RPMH_REGULATOR_LEVEL_SVS		128
-#define RPMH_REGULATOR_LEVEL_SVS_L0		144
-#define RPMH_REGULATOR_LEVEL_SVS_L1		192
-#define RPMH_REGULATOR_LEVEL_SVS_L2		224
-#define RPMH_REGULATOR_LEVEL_NOM		256
-#define RPMH_REGULATOR_LEVEL_NOM_L0		288
-#define RPMH_REGULATOR_LEVEL_NOM_L1		320
-#define RPMH_REGULATOR_LEVEL_NOM_L2		336
-#define RPMH_REGULATOR_LEVEL_TURBO		384
-#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
-#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
-#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
-#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
-#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
-#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
-
 /* MDM9607 Power Domains */
 #define MDM9607_VDDCX		0
 #define MDM9607_VDDCX_AO	1
-- 
2.7.4

