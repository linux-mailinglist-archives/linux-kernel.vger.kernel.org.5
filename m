Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225747B0027
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjI0JcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0JcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:32:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61396EB;
        Wed, 27 Sep 2023 02:32:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9AAOp014722;
        Wed, 27 Sep 2023 09:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=R6S9lb9E5gfXv/deHo8OReGIPDdJ5e4iD2Mod97pwj4=;
 b=HhJZ7hc5PBVoCv/yuTZww8XV3l1N713GeOKwJTHKbqZNYCBl0wN2Ht37ttavaJGw+Ol1
 A80L8DPXZcdcVTMO91ErtkifgKZTEmVr2fOa2aaLFPzVpu6yuI79Eop1KaX3d5CYUmkY
 X+AarhyeDo1RWNxZwYb5d27E6r1PbeBX4vUfDDpLZdkJt7Fjpf4DrSlhduHctaoXIIGX
 6uf46KiflcIjsOrT0qhkOuTsaLa7BTfdHNFYlP1B2BlHCk63SCTyINgANrZxWxeXYRkN
 Z/XiAIQZ8rYl2b7ejK1kAS/r1mLwu5j3yUUyuJMmUHYqPESkX9ZrWtpuqmMqrlU8BrFT zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc43msf6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 09:32:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R9W0eW027458
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 09:32:00 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 27 Sep 2023 02:31:56 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH] dt-bindings: arm: qcom: drop the IPQ board types
Date:   Wed, 27 Sep 2023 15:01:30 +0530
Message-ID: <20230927093130.4098385-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l-y6uhcWbfaJDNPW8dCd5lV2Nm16Qlah
X-Proofpoint-GUID: l-y6uhcWbfaJDNPW8dCd5lV2Nm16Qlah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_04,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=818 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ bootloaders do not need these information to select the
the DTB blob. So dropping the board names from board section.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7f80f48a0954..5b56f3d90d4d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -91,24 +91,10 @@ description: |
   The 'board' element must be one of the following strings:
 
         adp
-        ap-al02-c2
-        ap-al02-c6
-        ap-al02-c7
-        ap-al02-c8
-        ap-al02-c9
-        ap-mi01.2
-        ap-mi01.3
-        ap-mi01.6
-        ap-mi01.9
         cdp
-        cp01-c1
         dragonboard
-        hk01
-        hk10-c1
-        hk10-c2
         idp
         liquid
-        rdp432-c2
         mtp
         qrd
         rb2
-- 
2.34.1

