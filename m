Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFEE761009
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjGYKA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjGYKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:00:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56227172A;
        Tue, 25 Jul 2023 03:00:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P88Wev015782;
        Tue, 25 Jul 2023 10:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Ekn3TqHQniq/36e5s2h2nS/CCNaLzCB3O+wU2OaQis8=;
 b=Phi8vMG8WfJQW8TOimhqtpjCnzNHYrARJqqJfuNg8TjzDdAZCAIcJ6MIed6GqH3n1SCY
 d0pn00EWGb9R1VweDSAedqS+LEfR1jVXhBT9D5BOIjMUKMVs+DKDZrte7XKbndY6rC3u
 kbht4yN5daYtTDbKvzpVz5XeyZf7r+mcJwqUUxPzJJQrpRGUHNeEKMu0mrCPbJJ7RHbc
 Oa6p3NUaoLPdXcPLcwwjfx0cywkiAegjhesSCdhVN1HCS+lM8nIzTQcfLpkO17wVrNXH
 PI6YWnun8uOz4oAxYkIJW2GEHo0UBaRp1TrZUX0XYHld/NRUyCJUc+MNytzsY+rf8lY0 Pg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s29j5gc6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 10:00:13 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36PA0AjK016294;
        Tue, 25 Jul 2023 10:00:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s086ktn6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Jul 2023 10:00:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PA0A1M016226;
        Tue, 25 Jul 2023 10:00:10 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-narepall-hyd.qualcomm.com [10.213.107.70])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36PA0AEx016094;
        Tue, 25 Jul 2023 10:00:10 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3995025)
        id 908005000AA; Tue, 25 Jul 2023 15:30:09 +0530 (+0530)
From:   Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
To:     quic_nitirawa@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Remove min and max voltages for L8A
Date:   Tue, 25 Jul 2023 15:30:07 +0530
Message-Id: <20230725100007.14775-1-quic_narepall@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sYqXMdFskVAXmbqn72ydL9f1CBury8_8
X-Proofpoint-GUID: sYqXMdFskVAXmbqn72ydL9f1CBury8_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=668 phishscore=0 clxscore=1011
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250086
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L8A is the supply for UFS VCC, UFS specification allows different VCC
configurations for UFS devices.
-UFS 2.x devices: 2.70V - 3.60V
-UFS 3.x devices: 2.40V - 2.70V

As sa8775p-ride supports both ufs 2.x and ufs 3.x devices, remove min/max
voltages for L8A regulator. Initial voltage of L8A will be set to 2.504v
or 2.952v during PON depending on the UFS device type. On sa8775, UFS is
the only client in Linux for L8A and this regulator will be voted only
for enabling/disabling.

Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index ed76680410b4..6f3891a09e59 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -98,8 +98,6 @@
 
 		vreg_l8a: ldo8 {
 			regulator-name = "vreg_l8a";
-			regulator-min-microvolt = <2504000>;
-			regulator-max-microvolt = <3300000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-allow-set-load;
 			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
-- 
2.17.1

