Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048E0793499
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbjIFE53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbjIFE51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:57:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904DE4F;
        Tue,  5 Sep 2023 21:57:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864ePtJ027910;
        Wed, 6 Sep 2023 04:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=ni4Sul8TP5U8j1FTmbKPEIrfH2nVChMHgvoKNoFs0us=;
 b=XkEz/DpOoNyXptBm76Tptv0z7l1HArdrnd80Mkeui8QEY805tp7edKlBILSqxeBp4bOj
 /kRW0ZE22zZRmxf+FVJ4wvqlBvDd7wuErNf89vHlZXK50R4Szd9RpXCMBCYMp3O14d9i
 JotJ0Ndj+eJw88Y1Opr9h1PYRgSiFzgvRhgAKaZhR1OkcLNp6NlW0X/zPIkIeiDSWcw5
 m+4Z6wq/WHfoXV9f7S5vHLbd4Eh/5JHmMhxNnqvMMci1/Mw5xyANzzBDvyzui2BfdZyN
 or78M/96lV1BEJsMFhOuR2AHFDBufUnQMORzAYgZiZ2Y0i2gHH+W9NUJ3F8g5kPoZMPm BQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxgmc07w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 04:57:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3864uxlg027440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 04:56:59 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 5 Sep 2023 21:56:55 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date:   Wed, 6 Sep 2023 10:26:24 +0530
Subject: [PATCH RESEND 5/7] dt-bindings: mailbox: qcom: add one more clock
 provider for IPQ mailbox
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230904-gpll_cleanup-v1-5-de2c448f1188@quicinc.com>
References: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
In-Reply-To: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693976190; l=1019;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=cAkbsEB56Chic7kbQsVFXNcpAy3AXkFiFcYnXKfyUak=;
 b=4rJCJxOshwmrJUH1HvQH4HFYIBgluxewrsWD+cqFwkQkq2y/G88YT+VlpZ+Jnt2GMOfjnlTK4
 Wl6gvl4NMnGD4dF0bEcLKEBqb8FR894qxkOn4seELJkqh+YweMVlPTM
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6XQWahrcn3M_1ZTqThq_4czp0TU4ZAXR
X-Proofpoint-ORIG-GUID: 6XQWahrcn3M_1ZTqThq_4czp0TU4ZAXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=987 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mailbox controller present in the IPQ SoCs takes the GPLL0 clock also as
an input. Document the same.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index d2e25ff6db7f..a38413f8d132 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -125,10 +125,12 @@ allOf:
           items:
             - description: primary pll parent of the clock driver
             - description: XO clock
+            - description: GCC GPLL0 clock source
         clock-names:
           items:
             - const: pll
             - const: xo
+            - const: gpll0
 
   - if:
       properties:

-- 
2.34.1

