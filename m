Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F976CF87
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjHBOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjHBOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:07:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17D2D74;
        Wed,  2 Aug 2023 07:07:03 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372AHdm1029690;
        Wed, 2 Aug 2023 14:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=yKabx/HHPZMo9RJqp2etmS+u3FEBwUFJzA1LOfPaD6c=;
 b=Ne76IOe/uhBQD11l3Gf1o1FkP7skZMEQamA7hsnAF1XIYLLWxmlVMhrKSNBT3tkw6KvI
 s63M0PE/xVcgSylLjpgi07BOlBqiX8jscc0Yi7ldOyM0buGBtfx0m9Cs1qATecAZKSDA
 WTjPQIqtU6/H+JfIsMcdPqxE9Bfc9+4H9XECc7ZWFoKh/6h8yU2HEGWq8jbNU25D2eNY
 9l3UP3OFSQLVk5fw68zZKOAB0GXMdJ57vNaNshbfZv942bWCNW+zhUsOV8AALGT2fbEl
 WIQLr6TXfGUdJrngrK7FfABzfaPtmS1JhpWCUUj72KBToUptM0k4cwOa5woJEFUtxTlY XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b32jna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 14:07:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372E6xZh028210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 14:06:59 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 07:06:51 -0700
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
Subject: [PATCH v5 04/11] dt-bindings: clock: qcom: gcc-ipq5332: remove q6 bring up clock macros
Date:   Wed, 2 Aug 2023 19:35:59 +0530
Message-ID: <20230802140606.2041889-5-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: KgpsElx3AewPptY4Dkc_UBMQ0MJrP4RO
X-Proofpoint-ORIG-GUID: KgpsElx3AewPptY4Dkc_UBMQ0MJrP4RO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
	- No changes.

Changes in v4:
	- Pick up R-b tag

Changes in v3:
	- Rebased on linux-next

 include/dt-bindings/clock/qcom,ipq5332-gcc.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/dt-bindings/clock/qcom,ipq5332-gcc.h b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
index 8a405a0a96d0..da9b507c30bf 100644
--- a/include/dt-bindings/clock/qcom,ipq5332-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
@@ -96,15 +96,7 @@
 #define GCC_PCNOC_BFDCD_CLK_SRC				87
 #define GCC_PCNOC_LPASS_CLK				88
 #define GCC_PRNG_AHB_CLK				89
-#define GCC_Q6_AHB_CLK					90
-#define GCC_Q6_AHB_S_CLK				91
-#define GCC_Q6_AXIM_CLK					92
 #define GCC_Q6_AXIM_CLK_SRC				93
-#define GCC_Q6_AXIS_CLK					94
-#define GCC_Q6_TSCTR_1TO2_CLK				95
-#define GCC_Q6SS_ATBM_CLK				96
-#define GCC_Q6SS_PCLKDBG_CLK				97
-#define GCC_Q6SS_TRIG_CLK				98
 #define GCC_QDSS_AT_CLK					99
 #define GCC_QDSS_AT_CLK_SRC				100
 #define GCC_QDSS_CFG_AHB_CLK				101
@@ -134,7 +126,6 @@
 #define GCC_SNOC_PCIE3_2LANE_S_CLK			125
 #define GCC_SNOC_USB_CLK				126
 #define GCC_SYS_NOC_AT_CLK				127
-#define GCC_SYS_NOC_WCSS_AHB_CLK			128
 #define GCC_SYSTEM_NOC_BFDCD_CLK_SRC			129
 #define GCC_UNIPHY0_AHB_CLK				130
 #define GCC_UNIPHY0_SYS_CLK				131
@@ -155,17 +146,6 @@
 #define GCC_USB0_PIPE_CLK				146
 #define GCC_USB0_SLEEP_CLK				147
 #define GCC_WCSS_AHB_CLK_SRC				148
-#define GCC_WCSS_AXIM_CLK				149
-#define GCC_WCSS_AXIS_CLK				150
-#define GCC_WCSS_DBG_IFC_APB_BDG_CLK			151
-#define GCC_WCSS_DBG_IFC_APB_CLK			152
-#define GCC_WCSS_DBG_IFC_ATB_BDG_CLK			153
-#define GCC_WCSS_DBG_IFC_ATB_CLK			154
-#define GCC_WCSS_DBG_IFC_NTS_BDG_CLK			155
-#define GCC_WCSS_DBG_IFC_NTS_CLK			156
-#define GCC_WCSS_ECAHB_CLK				157
-#define GCC_WCSS_MST_ASYNC_BDG_CLK			158
-#define GCC_WCSS_SLV_ASYNC_BDG_CLK			159
 #define GCC_XO_CLK					160
 #define GCC_XO_CLK_SRC					161
 #define GCC_XO_DIV4_CLK					162
-- 
2.34.1

