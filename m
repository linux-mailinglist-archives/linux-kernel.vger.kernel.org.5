Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4309D7A8FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjITXEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjITXEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:04:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D545F7;
        Wed, 20 Sep 2023 16:04:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KN2bjo006783;
        Wed, 20 Sep 2023 23:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=r83Pxr1SUpSqOzPvtidAYZr6pI6Qnvh3n6wKzu9tLrY=;
 b=lSVuWJB0nFe0uU78hoGdnahtdnyeWQBUxaZbD14Qkm5UullnERwUmrCADyY+5fUJbpLf
 L4J4u9p/xpeZpfSzkJt99q9HMPBc/m1SJqDJ6Xje2f04UHRfa7H2lT3WaZxYWGXBJ/J9
 yNQFfKVANyIwVVhcNATBuqCFqYmq7soqRSv8UBNYDK2M7AXbxBEuZly1qcTIBmPTr/mj
 HO06d9vuiYF6MIB1PgkP9jXwfsu37IcJbjXlBlYwcdS6taeI/AX/mw94a+x9n2NJDv16
 aDmWqVyOcxJ8AkfW8OShi7TNVymxKdtB2pIGBGRC36G5nVS3CGh/bcM824a4B78128zY aw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t88920543-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 23:04:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KN3xH7003268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 23:03:59 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 20 Sep 2023 16:03:59 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Wed, 20 Sep 2023 16:03:57 -0700
Subject: [PATCH] dt-bindings: opp: opp-v2-kryo-cpu: Allow opp-peak-kBps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230920-opp-kbps-binding-cleanup-v1-1-65b059bb4afc@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFx6C2UC/x2N0QrCMAxFf2Xk2UBbmTJ/RXxo2mwLlqw0TISxf
 7f4eC6cew4wbsIGj+GAxh8x2bSDvwyQ1qgLo+TOEFy4uik43GrFN1VDEs2iC6bCUfeK7H2cxxv
 l+zRC1ykaI7Woae0HupfSx9p4lu+/93yd5w8uZLKafwAAAA==
To:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695251039; l=1137;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=P6IA7YPsWYYORtO72lZgkqWUcancyJHyOBVjwpo7ne4=;
 b=eO42j10IijsrPZMxSFpKzIWbptLXWHq2MJXikln+LR4CprnxdusZmie2eiz/zf6qG+FUmjuPEe3C
 7ohpeCcKAnnHGKkE2IyfJs9MQfMgEgh6LvwMZTYV0isXUt73Pv9A
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lLSjAu7mX2qJFEyQACatE1qxzFsxuVs7
X-Proofpoint-ORIG-GUID: lLSjAu7mX2qJFEyQACatE1qxzFsxuVs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=839 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the users of operating-points-v2-kryo-cpu scales interconnect
bandwidth based on the selected opp. Extend the binding to allow the
opp-peak-kBps property, inherited from opp-v2-base.yaml, to be used to
specify the requested bandwidth.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index bbbad31ae4ca..27ea7eca73e5 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -47,6 +47,8 @@ patternProperties:
 
       opp-microvolt: true
 
+      opp-peak-kBps: true
+
       opp-supported-hw:
         description: |
           A single 32 bit bitmap value, representing compatible HW.

---
base-commit: 926f75c8a5ab70567eb4c2d82fbc96963313e564
change-id: 20230920-opp-kbps-binding-cleanup-e11af56bd795

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

