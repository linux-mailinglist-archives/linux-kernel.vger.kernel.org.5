Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398777EC4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344169AbjKOOJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbjKOOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:09:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F0E1;
        Wed, 15 Nov 2023 06:09:04 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCl9sr010182;
        Wed, 15 Nov 2023 14:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CLpJvxEOJWPI/XnaXTlnX9ueptBWpRe+/Nh9WcXUebo=;
 b=pzgMqZRHdTH4zesatPOn1DDfwgH9HPRT0f1Xuvcwx1CqhIKQ0cHk7CVgRsBJM4xsF/z6
 g9InLKJtUgYDX28Hg3QHsOG1y8XIy9xQ20Q8IK2M92WlvnYGnjFKQbuGQiq3AU5DDXa+
 RX2l81E/DbzpuGAuIWJjQBYSVdTD8BC0hBv/Q+q5pMAo24oR1kg1X38WFAZwP9BTzvI4
 vrQ6cODMwhv0Zx2c9Pwdltny7PqgWQPhRblKHZB/5u6DVer1hUFcX90733DNAiEeYcv9
 iUe8qqmMO4eN1J00yPN7IJbz9AMWr3v4XxSPif6lTebl3c7LjpoT+mBJySDVOYYEwFgL CA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucmbahfhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:08:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFE8ruu006542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:08:53 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 06:08:50 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 4/6] net: phy: at803x: add the function phydev_id_is_qca808x
Date:   Wed, 15 Nov 2023 22:06:28 +0800
Message-ID: <20231115140630.10858-5-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115140630.10858-1-quic_luoj@quicinc.com>
References: <20231115140630.10858-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sh-CiTriMk7_fEjN6zzPUIsH1Ys5wuH2
X-Proofpoint-ORIG-GUID: sh-CiTriMk7_fEjN6zzPUIsH1Ys5wuH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_12,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=965 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function phydev_id_is_qca808x is applicable to the
PHY qca8081 and qca8084.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 471d5c13d76d..f56202f5944d 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1165,6 +1165,12 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 	}
 }
 
+static inline bool phydev_id_is_qca808x(struct phy_device *phydev)
+{
+	return phydev_id_compare(phydev, QCA8081_PHY_ID) ||
+		phydev_id_compare(phydev, QCA8084_PHY_ID);
+}
+
 static int at803x_read_specific_status(struct phy_device *phydev)
 {
 	int ss;
@@ -1184,8 +1190,8 @@ static int at803x_read_specific_status(struct phy_device *phydev)
 		if (sfc < 0)
 			return sfc;
 
-		/* qca8081 takes the different bits for speed value from at803x */
-		if (phydev->drv->phy_id == QCA8081_PHY_ID)
+		/* qca808x takes the different bits for speed value from at803x */
+		if (phydev_id_is_qca808x(phydev))
 			speed = FIELD_GET(QCA808X_SS_SPEED_MASK, ss);
 		else
 			speed = FIELD_GET(AT803X_SS_SPEED_MASK, ss);
@@ -1316,7 +1322,7 @@ static int at803x_config_aneg(struct phy_device *phydev)
 	 */
 	ret = 0;
 
-	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
+	if (phydev_id_is_qca808x(phydev)) {
 		int phy_ctrl = 0;
 
 		/* The reg MII_BMCR also needs to be configured for force mode, the
@@ -1470,8 +1476,8 @@ static int at803x_cdt_start(struct phy_device *phydev, int pair)
 {
 	u16 cdt;
 
-	/* qca8081 takes the different bit 15 to enable CDT test */
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
+	/* qca808x takes the different bit 15 to enable CDT test */
+	if (phydev_id_is_qca808x(phydev))
 		cdt = QCA808X_CDT_ENABLE_TEST |
 			QCA808X_CDT_LENGTH_UNIT |
 			QCA808X_CDT_INTER_CHECK_DIS;
@@ -1487,7 +1493,7 @@ static int at803x_cdt_wait_for_completion(struct phy_device *phydev)
 	int val, ret;
 	u16 cdt_en;
 
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
+	if (phydev_id_is_qca808x(phydev))
 		cdt_en = QCA808X_CDT_ENABLE_TEST;
 	else
 		cdt_en = AT803X_CDT_ENABLE_TEST;
-- 
2.42.0

