Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405B07F30D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjKUObq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjKUObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:31:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBF9BA;
        Tue, 21 Nov 2023 06:31:40 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE2Npp011565;
        Tue, 21 Nov 2023 14:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=8uj1/UscyWhxbjLgHwlHvWQOAsq2VNOtxd8jtk3Os7o=;
 b=gjLT1F0MqM87aHH4+PXsZ8CphzW4P/h1NDBMDZ05QKbJMIDsdA/j30fhbw4vFf7ZnTMc
 bBmbPlY9vPkz3ioQDJ45tMi5IDnupQDFf2u1VSeKszTIelKt2GARV5p2+3ygV7tmycU2
 IlFvbWmbB8uhc522r5pJd5mYrhl2GR5CDioHkg8eE9lYs0EWCehM4otawTKi/+9Vo32H
 FfB6pYMpA6kz3l0UuU9+IhcAYUo4NRNW6/IgGfiy4wDNp+GLskwpHPSIxzDll1lsGs60
 1EhFAfTxD43DZ1gABvD1y4/GGzdR5nwUU9Ru5HHjJeiogaC4TlN5JNcE4YPhpbCw6c7z Wg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugvt2gbvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALEVTEr023988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 14:31:29 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 06:31:24 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Tue, 21 Nov 2023 20:00:46 +0530
Subject: [PATCH v2 4/9] dt-bindings: clock: ipq5332: add definition for
 GPLL0_OUT_AUX clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231121-ipq5332-nsscc-v2-4-a7ff61beab72@quicinc.com>
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
        "Kathiravan Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700577061; l=830;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=1OokHmvwteJCUAmVEy95DN2Dhk5e56HSTN8/muz/gOk=;
 b=f7NLeCvivXSUN+FyIo4Bk8dQYW8dOumPnYCXQ9gTJ+05cvzoUW/PkIWmsYASDx0turh7ZGvgt
 n+gnC3k76/JDkkZXL2MaRt9smxUPlRyYVbWFHyON48Qt3w9GFqTq2PO
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WerTszsySi2BF-EnBEVhr2OjVzgVNJGg
X-Proofpoint-ORIG-GUID: WerTszsySi2BF-EnBEVhr2OjVzgVNJGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_07,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the definition for GPLL0_OUT_AUX clock.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Pick up the A-b tag
---
 include/dt-bindings/clock/qcom,ipq5332-gcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,ipq5332-gcc.h b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
index 4649026da332..486b6cf2e916 100644
--- a/include/dt-bindings/clock/qcom,ipq5332-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
@@ -176,6 +176,7 @@
 #define GCC_PCIE3X1_0_PIPE_CLK_SRC			170
 #define GCC_PCIE3X1_1_PIPE_CLK_SRC			171
 #define GCC_USB0_PIPE_CLK_SRC				172
+#define GPLL0_OUT_AUX					173
 
 #define GCC_ADSS_BCR					0
 #define GCC_ADSS_PWM_CLK_ARES				1

-- 
2.34.1

