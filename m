Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B9C7E80FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346196AbjKJSVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjKJSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B297DBB;
        Thu,  9 Nov 2023 22:50:53 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA6H83J016592;
        Fri, 10 Nov 2023 06:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=1wvVMoULHl/lgbEWNrtZQxfhxwa/jlAJpNHciI0yLow=;
 b=FG+CGPVwzAr3E/s47TldN2P+5uvAx9laAedsm5YgFdMJQAnCz0lAAuGz1yA0/XKQYmn5
 QPeDSvGJ2xWKgIZ3sC7e8t/yuIgU0WluQs8aktepQUDWgrd212lTgotfYsbIkbBLTK48
 egoCUST9eXGUbV+pMzMXGWrMGy0gEFtOWFqNT2wyVYQnB/NJDr7Ykz1x2tKI6JH6n+jI
 jcqnNsLfXqQ8w946upteXK3YHD28ggY0U3qfZwmEwTiCsoxutnmcrTjSFz2N0sFw6B3v
 n7cT21TvdkmE5OIdRJPCY3EClAHl+vfqqth+CXrxiBM/8bF9eSBmrUWOEIm/Y2dwtPxo Ew== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93r0hcws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 06:50:50 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA6onQx031859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 06:50:49 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 9 Nov 2023 22:50:45 -0800
From:   Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH 1/4] dt-bindings: clock: Update the videocc resets for sm8150
Date:   Fri, 10 Nov 2023 12:20:26 +0530
Message-ID: <20231110065029.2117212-2-quic_skakitap@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110065029.2117212-1-quic_skakitap@quicinc.com>
References: <20231110065029.2117212-1-quic_skakitap@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h40L10UIvlpNfcpzanL7NSEMqMICZ-NF
X-Proofpoint-ORIG-GUID: h40L10UIvlpNfcpzanL7NSEMqMICZ-NF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=632 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the available resets for the video clock controller
on sm8150.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 include/dt-bindings/clock/qcom,videocc-sm8150.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,videocc-sm8150.h b/include/dt-bindings/clock/qcom,videocc-sm8150.h
index e24ee840cfdb..c557b78dc572 100644
--- a/include/dt-bindings/clock/qcom,videocc-sm8150.h
+++ b/include/dt-bindings/clock/qcom,videocc-sm8150.h
@@ -16,6 +16,10 @@
 
 /* VIDEO_CC Resets */
 #define VIDEO_CC_MVSC_CORE_CLK_BCR	0
+#define VIDEO_CC_INTERFACE_BCR		1
+#define VIDEO_CC_MVS0_BCR		2
+#define VIDEO_CC_MVS1_BCR		3
+#define VIDEO_CC_MVSC_BCR		4
 
 /* VIDEO_CC GDSCRs */
 #define VENUS_GDSC			0
-- 
2.25.1

