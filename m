Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5A7A90F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjIUCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIUCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:37:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A915D7;
        Wed, 20 Sep 2023 19:37:51 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L1kmST024787;
        Thu, 21 Sep 2023 02:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=nBccwF1AJjDJHOkO9saAtELKx+a1Lz8POTJOCADT7jA=;
 b=UAxV89vHiCNO9eYM5jXfkK40wREPFI2WhWcpV9gSe24KEYlG0NU0PbMJ/7aJiVnmeifF
 QoqjfneCoi3N4UOguC+D0GdklAPHEHAdrRewhx6Re3KQm5v/NqkUgjCSKv5mejPIG0aZ
 4vX/jTsmJJAZdK1r8OqOzcmdo9MayEJj+ru2o3HV2mOIYHag53pnTA7sZjDIvJoyAr0Z
 qLiLxaYzn5EfMJjGjHP7TDJX55/9ZMKeeGy07T4x4M3HbDP4EeC1whI9iIHPoAJmO3Sb
 6EaskQhq+MQplH6XRI7Opohzeu4c1tTAVcaWXrzj42WkNKvdyvqbtGOm5FOQPq3tmhxa 4w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t891c0cre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 02:37:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38L2bi9i020704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 02:37:44 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 20 Sep 2023 19:37:44 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Wed, 20 Sep 2023 19:37:30 -0700
Subject: [PATCH v3 1/3] dt-bindings: reserved-memory: rmtfs: Allow guard
 pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230920-rmtfs-mem-guard-pages-v3-1-305b37219b78@quicinc.com>
References: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
In-Reply-To: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695263863; l=1847;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=xlRIelsN06YllMR6zQavDKa2EffnSwCF78u2DTrHj0w=;
 b=GyA4H0nGIEhcJOitilg5PSb/hOQlK+YMuj77kq8z5ef+diag1/IpNh1iG9+b0y2GTeJcpeMTbE9R
 KU4I732mCOfUBVGkBBZEdClKIEHyO2rhCWTdAwGp1qO9ZhsoCXi0
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A4RG7nEGIcse6EKfjJv7rMQW7vhGoffc
X-Proofpoint-ORIG-GUID: A4RG7nEGIcse6EKfjJv7rMQW7vhGoffc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=814 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qualcomm platforms the firwmare, or hardware, does not
gracefully handle memory protection of the rmtfs memory region when
placed adjacent to other protected region. Some DeviceTree authors have
worked around this issue by explicitly reserving the space around the
region, but this prevents such author to use rely on the OS to place the
region, through the use of "size" (instead of a fixed location).

Introduce a flag to indicate that guard pages need be carved at the
beginning and end of the memory region. The user shall account for the
two 4k blocks in the defined size.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
index bab982f00485..2d7be508c5a0 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
@@ -26,6 +26,17 @@ properties:
     description: >
       identifier of the client to use this region for buffers
 
+  qcom,use-guard-pages:
+    type: boolean
+    description: >
+      Indicates that the firmware, or hardware, does not gracefully handle
+      memory protection of this region when placed adjacent to other protected
+      memory regions, and that padding around the used portion of the memory
+      region is necessary.
+
+      When this is set, the first and last 4kB should be left unused, and the
+      effective size of the region will thereby shrink with 8kB.
+
   qcom,vmid:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: >

-- 
2.25.1

