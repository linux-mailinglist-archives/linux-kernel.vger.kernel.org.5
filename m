Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F62679E3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbjIMJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIMJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:41:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8256C196;
        Wed, 13 Sep 2023 02:41:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D8bv22011985;
        Wed, 13 Sep 2023 09:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=xMH6E0ikw8twCxXEjJyg8wBsNxtxpjn+yh/+pLjt1PY=;
 b=hv/1H/LIsoDrEzMe2ctyrm0r1icNdgMZxrnPRV0s4BG6FkNOQ5zTLVgQ+OZjLWQoAcNO
 oYYpLj3VQTjWAVq6rUqH8ShuUgf59fcg8UylgiYJkFvkYbMipZMllTmFqfP3shRIPxfu
 7eIr5gglUBabSuyoOCt0ro6eF74l6DlLpkRM5L0UY1g3ZwaDO6Ex7YG2RZvJrQ+n7i7t
 4/f5OYZvFtfDwWAeu9wPrMnf5SmowUrZ8rs+zYyFr/ml8PQjGTUecG2f98z+ihFEBp8K
 3QFBBuycgdQCqu2MZ2oqMdMv2bIQgPp3BjWl+PR9/OCyhxHLeLqN62GqkW4BFesKM78e fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8e184q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:41:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D9fhnT031598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 09:41:44 GMT
Received: from hu-shazhuss-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 13 Sep 2023 02:41:37 -0700
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <bartosz.golaszewski@linaro.org>, <kernel@quicinc.com>,
        <quic_anantg@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] arm64: dts: qcom: sa8775p: pmic: rectify phandle for gpio-ranges used by pmm8654au_1_gpios
Date:   Wed, 13 Sep 2023 15:11:11 +0530
Message-ID: <20230913094111.14744-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uuzfjskoafhHds5RHBb8Nb-6hupyw2mh
X-Proofpoint-GUID: uuzfjskoafhHds5RHBb8Nb-6hupyw2mh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=385 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use correct phandle pmm8654au_1_gpios referred by gpio-ranges for
pmic pmm8654au_1.

Fixes: e5a893a7cec5 ("arm64: dts: qcom: sa8775p: add PMIC GPIO controller nodes")
Reported-by: Anant Goel <quic_anantg@quicinc.com>
Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 3c3b6287cd27..eaa43f022a65 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -173,7 +173,7 @@
 			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
-			gpio-ranges = <&pmm8654au_2_gpios 0 0 12>;
+			gpio-ranges = <&pmm8654au_1_gpios 0 0 12>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.17.1

