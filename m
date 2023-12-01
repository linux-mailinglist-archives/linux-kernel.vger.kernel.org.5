Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5A7FFFED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjLAALX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLAALV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:11:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B62196;
        Thu, 30 Nov 2023 16:11:28 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUNbKau026777;
        Fri, 1 Dec 2023 00:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=x8ZaBzDXo9RnM8FSoL8MO657zArSEWDN6QPepXwp/VM=;
 b=G8fEjdvIXly47rXWJ7Nv8sPKS8G/5Jt2/Cgfdz8jnBa9K8iPx0acz/loar2naJt21hDE
 tCN12S/VB5l6M/GIOJKIO+DRa+0yjO3RS/rr7GhD2jrl5r+BoKVFOjwjWfpUxEfi9oXa
 fbc0nMQot2z57TazTW3SmZBoP2rvY7V490GATXLytLfDz/HZXPVOPphS76whf6i2/ayA
 wCO9l8Im4i867/oD0P6BZTSjDomYz6RFCxxVLwnRhSN7W2YcLkvUb29rakXiObhWmW+n
 xNUv4uL12ngDHXY0s3LKRjJeeo2uH0aid1aHk5nuwmFX/+nugpdY35nz8qA2fJtDmXbF AA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uprhdsy90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 00:11:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B10BMrx004020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 00:11:22 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 30 Nov
 2023 16:11:21 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Thu, 30 Nov 2023 16:11:10 -0800
Subject: [PATCH] arm64: dts: qcom: sc8180x-primus: Fix HALL_INT polarity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231130-sc8180x-primus-lid-polarity-v1-1-da917b59604b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJ0kaWUC/x2NywqDMBAAf0X23IXEF9JfKT2syVoX0ii7Wiziv
 zf0OHOYOcFYhQ3u1QnKHzFZcgF/qyDMlF+MEgtD7erG+8ahhcEP7sBV5b0bJom4LolUti92LVH
 fum7qfYRSGMkYR6Uc5tLIe0pFrsqTHP/l43ldP6YQVmKCAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701389481; l=1151;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=hcvBx54O8Bz7zZ8nn5xY8JomAWV5QZKJZJGauXpUmo4=;
 b=1H7LvLa2c4X4b4X18kJh/M9QCWbLPEDMKD5Ycsg2OBPZuCBpeYkEshhXf5fEdJDDRzrvZsIkeKio
 hnayN/86Dzr3vNxaSsl6JBHaodojXjWKOrKj4SDpmRlaTyTv34iR
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FoUtAkvhBIGJYePSoixuM-oTueLruztk
X-Proofpoint-GUID: FoUtAkvhBIGJYePSoixuM-oTueLruztk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_24,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=580
 clxscore=1011 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hall sensor interrupt on the Primus is active low, which means that
with the current configuration the device attempts to suspend when the
LID is open.

Fix the polarity of the HALL_INT GPIO to avoid this.

Fixes: 2ce38cc1e8fe ("arm64: dts: qcom: sc8180x: Introduce Primus")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index fd2fab4895b3..a40ef23a2a4f 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -43,7 +43,7 @@ gpio-keys {
 		pinctrl-0 = <&hall_int_active_state>;
 
 		lid-switch {
-			gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>;
+			gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			wakeup-source;

---
base-commit: 3cd3fe06ff81cfb3a969acb12a56796cff5af23d
change-id: 20231130-sc8180x-primus-lid-polarity-54aa6405f61d

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

