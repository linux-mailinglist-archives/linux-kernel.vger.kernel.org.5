Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B687B2C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjI2Fso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjI2Fsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:48:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE4199;
        Thu, 28 Sep 2023 22:48:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T5lX3O009328;
        Fri, 29 Sep 2023 05:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=gHEOCQ+KZd/7IQvR2diOdvIxX/VPJkvjjUCvqh3o2Y8=;
 b=nF8O+DUyuiS9Ym85tgCkmnHY8Zj+cLw0mGAkt/NljwYEH/JbfmRHEfZ+HWRvh8YXLnZD
 FugYfIpqir8wwIetcS7dg8KuuSoxDcsxnsAkm6BvHyZ9wT9dSgAy063LNOIrLFw1jAoz
 EJ/1TRriKZfM6uDzuf6k1RxgAWuiD85TE7c60Vk2dOPoSiNZC/5Hq1atZAghaLY0eu+i
 Oyc2q8qCc5qgzC2DfAf/Q8JuX7VWbN02ELhDGFSKpFL4KXCIMqj35xP6RPAfUFXGobR4
 qUy6lNt4+MGZpwJM1/vOHc+PWtaJS6a/rjHpcpcjgGIVfbTK1CT+QZ0Md+4fQYVwY+a2 nQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td5se26ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 05:48:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T5mVoF010141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 05:48:31 GMT
Received: from hu-rkakarla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 28 Sep 2023 22:48:27 -0700
From:   Raghavendra Kakarla <quic_rkakarla@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raghavendra Kakarla <quic_rkakarla@quicinc.com>
CC:     <quic_mkshah@quicinc.com>, <quic_lsrao@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3] arm64: dts: qcom: sa8775p: Add RPMh sleep stats
Date:   Fri, 29 Sep 2023 11:18:05 +0530
Message-ID: <20230929054805.27847-1-quic_rkakarla@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ToimKoCgccWxl4ncmxJXz7ODGRIh-wuJ
X-Proofpoint-GUID: ToimKoCgccWxl4ncmxJXz7ODGRIh-wuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_04,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxlogscore=675 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for sleep stats driver which provides various
low power mode stats.

Tested-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9f4f58e831a4..2ce5b592616f 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1912,6 +1912,11 @@
 			#clock-cells = <0>;
 		};
 
+		sram@c3f0000 {
+			compatible = "qcom,rpmh-stats";
+			reg = <0x0 0x0c3f0000 0x0 0x400>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x0c440000 0x0 0x1100>,
-- 
2.17.1

