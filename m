Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80F7F30F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjKUOc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbjKUOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:32:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC810C1;
        Tue, 21 Nov 2023 06:32:07 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE1vW7001454;
        Tue, 21 Nov 2023 14:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=lKNJ2NGqgcTSmiaNvFQy7vJnLz7xIii1mepwcE2VVDI=;
 b=KBnYgtroA2tkzL+22s38Pxof7U4zdsiKIFUqW3zXN1aiTICkshGO17z0tOkBGqnz0DkL
 8wk82e0uWIzfgr2e/6UZ+VYdZt58xBG5DGEUkv7fEXZw/pmnwjRkPgnI/ANHew89Xgke
 Ls95xcOSQbR2yQ01xzXFRWe2jScAY/ey1EBagpL/QCWUiIqc0ljDzLPNsh6MSnr4WT58
 7gLFnihec/Ordy1UsYL45qk04DKg7pczr7qjZPaCxX1r3nu/Ey2UzCfCNCAfrSH6ryDf
 ej0YnQpGVLpz9jas46ZYBh7DEFOl+fXUmXuuQ3CwHNVJ/vOdCAC6HYFHtm7SPa34dRnE jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugcqs2te2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALEVwxD008435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:58 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 06:31:53 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Tue, 21 Nov 2023 20:00:51 +0530
Subject: [PATCH v2 9/9] arm64: defconfig: build NSS Clock Controller driver
 for Qualcomm IPQ5332
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231121-ipq5332-nsscc-v2-9-a7ff61beab72@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700577061; l=805;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=54GjomXoINQC2+jck1NY8lQcoGQ3H3dg5VLy6r9f7v8=;
 b=qtiSiG6/ytLPi4jSYosubQcrYCO/OjmO+6XTNRYmPucsoe41vg0IbI/fzwE8K3PLv+OS+SkKm
 6qA6vBMLHK1B3n3m9/oLhyFhRYzSRgvNflBnuYQPnAXuFPoNcsmqviW
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: efM3ZfnufRw-eUs0oOtmqjB7JaQES_8s
X-Proofpoint-GUID: efM3ZfnufRw-eUs0oOtmqjB7JaQES_8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_07,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=851
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NSSCC driver is needed to enable the ethernet interfaces and not
necessary for the bootup of the SoC, hence build it as a module.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Repharse the commit message to indicate why driver should be
	  built as m.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..c075202d255d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1223,6 +1223,7 @@ CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_QCOM_CLK_RPMH=y
 CONFIG_IPQ_APSS_6018=y
 CONFIG_IPQ_GCC_5332=y
+CONFIG_IPQ_NSSCC_5332=m
 CONFIG_IPQ_APSS_5018=y
 CONFIG_IPQ_GCC_5018=y
 CONFIG_IPQ_GCC_6018=y

-- 
2.34.1

