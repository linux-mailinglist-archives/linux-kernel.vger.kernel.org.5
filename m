Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFBF7F30E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjKUOcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjKUOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:32:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B91810CF;
        Tue, 21 Nov 2023 06:31:59 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE28dY030673;
        Tue, 21 Nov 2023 14:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=BskTKg7bjJwUbywnO6hqoJyv7Sqc6PQkw8i1ACSRrkc=;
 b=giPbUB03x2TM5EshPduPzxlTCtJ3XfPPHq00TPqUYnMmo/QXTVooDvO9TLlL1TzeZeQe
 MqJwBHA9WW5Elag7IlJfI5eqoWF17XpNesg5hdXQaT1fdVLdWZAQ3KQgb/nKwKS6SkHv
 mAQydbwL0m/eV6idTLIysXJCgb1TvJvf9k4YBcZm0FQ+KoDSudpKyYU373O2FHKwkmbf
 auRSDohp9gAd3uMK8zEWlAfIfcTvsFOdDjLEZEXB3GrtlGYlBd7mm9tbdfEJWDV2eLSn
 7UH0x8jdJx/JHmlq/cMn8YoDdlcT8UxjW5ypuy2jMUKHS0D+IGHtk4Az36mXY46KqrV+ WQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug7eabps7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALEVOvi027441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:24 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 06:31:18 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Tue, 21 Nov 2023 20:00:45 +0530
Subject: [PATCH v2 3/9] dt-bindings: clock: ipq5332: drop the few nss
 clocks definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231121-ipq5332-nsscc-v2-3-a7ff61beab72@quicinc.com>
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
In-Reply-To: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700577061; l=1337;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=pqduzhZaHeCV7j9kVmg9wiQQH0ixzsxoMBso//t3Mdk=;
 b=AB4Sr7MUMK8RN0i2Jln/VtEBE1OW7jFmY9eRCjKU3g1TSlI5c6NW0QmFqQn6N8O97CHQoNX0+
 CPr35vWsxLxApIE/hes/qKuN1PjJHMRfneRfjEho7xPNmRBwaOuFzQU
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aa_TJ_eNJ2XAhN2o794W46TEkvO_FyOq
X-Proofpoint-ORIG-GUID: aa_TJ_eNJ2XAhN2o794W46TEkvO_FyOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=793 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 0dd3f263c810 ("clk: qcom: ipq5332: enable few nssnoc clocks in
driver probe"), gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk,
gcc_nssnoc_nsscc_clk are enabled in driver probe to keep it always-on.

So let's drop the binding definition as well.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V2:
	- No changes
---
 include/dt-bindings/clock/qcom,ipq5332-gcc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/dt-bindings/clock/qcom,ipq5332-gcc.h b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
index 8a405a0a96d0..4649026da332 100644
--- a/include/dt-bindings/clock/qcom,ipq5332-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
@@ -55,7 +55,6 @@
 #define GCC_NSSCC_CLK					46
 #define GCC_NSSCFG_CLK					47
 #define GCC_NSSNOC_ATB_CLK				48
-#define GCC_NSSNOC_NSSCC_CLK				49
 #define GCC_NSSNOC_QOSGEN_REF_CLK			50
 #define GCC_NSSNOC_SNOC_1_CLK				51
 #define GCC_NSSNOC_SNOC_CLK				52
@@ -124,8 +123,6 @@
 #define GCC_SDCC1_APPS_CLK_SRC				115
 #define GCC_SLEEP_CLK_SRC				116
 #define GCC_SNOC_LPASS_CFG_CLK				117
-#define GCC_SNOC_NSSNOC_1_CLK				118
-#define GCC_SNOC_NSSNOC_CLK				119
 #define GCC_SNOC_PCIE3_1LANE_1_M_CLK			120
 #define GCC_SNOC_PCIE3_1LANE_1_S_CLK			121
 #define GCC_SNOC_PCIE3_1LANE_M_CLK			122

-- 
2.34.1

