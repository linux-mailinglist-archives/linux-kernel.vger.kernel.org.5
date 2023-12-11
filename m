Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4365580BFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjLKDiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 22:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjLKDh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 22:37:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D99F1;
        Sun, 10 Dec 2023 19:38:02 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB3BPuE029183;
        Mon, 11 Dec 2023 03:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:date:subject:mime-version:content-type
        :content-transfer-encoding:message-id:references:in-reply-to:to
        :cc; s=qcppdkim1; bh=UUKLt13C9tDbno9DR5Kvl/4aK/hJZvVVCUTzBufJzOE
        =; b=AEvwJO/6tHZMrFKeEKUdbTZFlIR6yKHBBIAE/OStQTcEiFd290RW6SgIpUS
        Vgjrw7swhrTMx6dig0Ux7Je1M2LzdcC4ujacrpy/7YUlRCSDiSl0DRvnn6BLAphf
        O/dFCbkYZGqjOOKNEdDXvfBO7to0JQQTyyiQvuJrGRPce1yCcDjteu8HhuajUsBU
        zJg3FAfAUT5VitFcTzJwRKUL98/vYquFyaFrZ8RKXh9xX9wgPw1NlIBPRk2xOkIF
        eofxVMP0C6CIW5THKwtXf5ccAbMBMQbdyVBCjyqSXDEoxad8ncAn8zdXzKxx0mW8
        W/lHh+kjFfeIzu1T0+UiqkuLcZQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnfja5s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:37:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB3bq2A026357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 03:37:52 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 19:37:47 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Mon, 11 Dec 2023 09:07:25 +0530
Subject: [PATCH v3 3/8] dt-bindings: clock: ipq5332: add definition for
 GPLL0_OUT_AUX clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231211-ipq5332-nsscc-v3-3-ad13bef9b137@quicinc.com>
References: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
In-Reply-To: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702265852; l=785;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=r0GgMzb0IwLYew1hPy8O6BwVhCfjMR033KqRmaNeDb0=;
 b=ngb4Gvj7YGuVF0je0CfSV/RchQBdoJ0KuOifZznpb5rQ7vSvfOgfpNRTpHQH9/kptkLZY7TeG
 U/S7awkKSywDmyhOTCf4RjpYk1QONDcFvcGiqcjutcagbLsgw6KQ9m2
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s2TKjvEeuOGi7dcInbTP50hto4kRw-tu
X-Proofpoint-GUID: s2TKjvEeuOGi7dcInbTP50hto4kRw-tu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=965 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the definition for GPLL0_OUT_AUX clock.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 include/dt-bindings/clock/qcom,ipq5332-gcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,ipq5332-gcc.h b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
index 8a405a0a96d0..24486eb47ed8 100644
--- a/include/dt-bindings/clock/qcom,ipq5332-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
@@ -179,6 +179,7 @@
 #define GCC_PCIE3X1_0_PIPE_CLK_SRC			170
 #define GCC_PCIE3X1_1_PIPE_CLK_SRC			171
 #define GCC_USB0_PIPE_CLK_SRC				172
+#define GPLL0_OUT_AUX					173
 
 #define GCC_ADSS_BCR					0
 #define GCC_ADSS_PWM_CLK_ARES				1

-- 
2.34.1

