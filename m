Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5A376CF8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjHBOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjHBOHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:07:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475A82726;
        Wed,  2 Aug 2023 07:07:11 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372BxMAF018801;
        Wed, 2 Aug 2023 14:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=AW+wqYJCg3c29eW5nkwAjW7O7kz7t/NApN8tt/lrsok=;
 b=Pka7OTrBQYlcONWgwAgtn8yyEGPlKwcYTzuQQFyJt1fSj7A9hcFfE/i0IIQGqCTVuQtJ
 ec4WCFFO/HX6cf1dJ9UkOpj3UtHuGLfF3+uVJ+OLxUwjm8KGDCzDIQbpvHNA8ICeKvy1
 09PbRitnI7OL3JH2oUSD4E3D7wGO2A8r2S1isxoruULn3akXaTprVNyUKKYqH0kF23xj
 +TlOPoVa6jbhibmIKiK7bAdSDXVZQaJvpgA8P2dlR4wfz0Pt6070ssaAfqZmWz7askV1
 htzh0oNOFx9uH95t4q37J58obinJ9HyK1c5VmRkRRUwG+ZKhYraPpzjBZ862QsTWsTLZ vQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75dgak5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 14:07:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372E76bo009405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 14:07:06 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 07:06:59 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>,
        <quic_gurus@quicinc.com>, <kvalo@kernel.org>,
        <quic_mmanikan@quicinc.com>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v5 05/11] dt-bindings: clock: qcom: gcc-ipq9574: remove q6 bring up clock macros
Date:   Wed, 2 Aug 2023 19:36:00 +0530
Message-ID: <20230802140606.2041889-6-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
References: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zVfZVp48ZgLhtpBy315S-n7o5gGXhZau
X-Proofpoint-ORIG-GUID: zVfZVp48ZgLhtpBy315S-n7o5gGXhZau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In multipd model Q6 firmware takes care of bringup clocks,
so remove them.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v5:
	- No changes

Changes in v4:
	- Pick up R-b tag

Changes in v3:
	- Rebased on linux-next

 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 08fd3a37acaa..9217b90f6847 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -132,16 +132,8 @@
 #define GCC_NSSNOC_SNOC_1_CLK				123
 #define GCC_QDSS_ETR_USB_CLK				124
 #define WCSS_AHB_CLK_SRC				125
-#define GCC_Q6_AHB_CLK					126
-#define GCC_Q6_AHB_S_CLK				127
-#define GCC_WCSS_ECAHB_CLK				128
-#define GCC_WCSS_ACMT_CLK				129
-#define GCC_SYS_NOC_WCSS_AHB_CLK			130
 #define WCSS_AXI_M_CLK_SRC				131
-#define GCC_ANOC_WCSS_AXI_M_CLK				132
 #define QDSS_AT_CLK_SRC					133
-#define GCC_Q6SS_ATBM_CLK				134
-#define GCC_WCSS_DBG_IFC_ATB_CLK			135
 #define GCC_NSSNOC_ATB_CLK				136
 #define GCC_QDSS_AT_CLK					137
 #define GCC_SYS_NOC_AT_CLK				138
@@ -154,27 +146,18 @@
 #define QDSS_TRACECLKIN_CLK_SRC				145
 #define GCC_QDSS_TRACECLKIN_CLK				146
 #define QDSS_TSCTR_CLK_SRC				147
-#define GCC_Q6_TSCTR_1TO2_CLK				148
-#define GCC_WCSS_DBG_IFC_NTS_CLK			149
 #define GCC_QDSS_TSCTR_DIV2_CLK				150
 #define GCC_QDSS_TS_CLK					151
 #define GCC_QDSS_TSCTR_DIV4_CLK				152
 #define GCC_NSS_TS_CLK					153
 #define GCC_QDSS_TSCTR_DIV8_CLK				154
 #define GCC_QDSS_TSCTR_DIV16_CLK			155
-#define GCC_Q6SS_PCLKDBG_CLK				156
-#define GCC_Q6SS_TRIG_CLK				157
-#define GCC_WCSS_DBG_IFC_APB_CLK			158
-#define GCC_WCSS_DBG_IFC_DAPBUS_CLK			159
 #define GCC_QDSS_DAP_CLK				160
 #define GCC_QDSS_APB2JTAG_CLK				161
 #define GCC_QDSS_TSCTR_DIV3_CLK				162
 #define QPIC_IO_MACRO_CLK_SRC				163
 #define GCC_QPIC_IO_MACRO_CLK                           164
 #define Q6_AXI_CLK_SRC					165
-#define GCC_Q6_AXIM_CLK					166
-#define GCC_WCSS_Q6_TBU_CLK				167
-#define GCC_MEM_NOC_Q6_AXI_CLK				168
 #define Q6_AXIM2_CLK_SRC				169
 #define NSSNOC_MEMNOC_BFDCD_CLK_SRC			170
 #define GCC_NSSNOC_MEMNOC_CLK				171
@@ -199,7 +182,6 @@
 #define GCC_UNIPHY2_SYS_CLK				190
 #define GCC_CMN_12GPLL_SYS_CLK				191
 #define GCC_NSSNOC_XO_DCD_CLK				192
-#define GCC_Q6SS_BOOT_CLK				193
 #define UNIPHY_SYS_CLK_SRC				194
 #define NSS_TS_CLK_SRC					195
 #define GCC_ANOC_PCIE0_1LANE_M_CLK			196
-- 
2.34.1

