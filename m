Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC687A2AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbjIOWvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbjIOWuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:50:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9882723;
        Fri, 15 Sep 2023 15:50:38 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FMnYxI003314;
        Fri, 15 Sep 2023 22:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=Rq+WMV61EQxBRnqNlUYUUkHdDShH4wAOxNrzM71Hi1A=;
 b=CE1rdsukxrXsvhWkCjQ1eh1C/mmTlLsjwKxPAHVl6uItMlL1n9wYEqVLrdsnGj4BVvxF
 fWh4+Wd0sB1QSelJ5dn+qac4xQIh51LX+nYdKbzE/NVA4FuI858a1IdY/0MxuQZN0s9P
 m9xZ2B0KZrNYK9G8dzA+vePgABt3CaDhSH5roLIgHa/gNHVvKZTn32sEWMZBImui0Orr
 ECxuyjfHHQLvlpBlrWpuSQWXIYUoJ2jNvEqEKAgiKUfTLxirFh5Yw6rAxncmkSe6fQ+9
 R2pTeM51SF6px1XxXO6Mo8aWGkIK/K9z+58Sf3K6E55q1LgdXBo5MZp2RAVAxSQmfDMI 3Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g2xje4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 22:50:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FMoPoP004061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 22:50:25 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 15:50:25 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Fri, 15 Sep 2023 15:50:14 -0700
Subject: [PATCH] firmware: qcom: qseecom: Add missing AUXILIARY_BUS
 dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230915-qseecom-auxiliary-fix-v1-1-38a46cfbfdb0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKXfBGUC/x2NQQ6CQAxFr0K6tgkDEsWrGBadsUiTcdA2GAzh7
 jYs38t/+RsYq7DBrdpA+Ssmc3EIpwrSROXJKA9naOqmrfvQ4ceY0/xCWlbJQvrDUVYM3eVMkdu
 Y+it4G8kYo1JJk9dlydnlW9m3x9l92Pc/kbR6anwAAAA=
To:     Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694818225; l=1206;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=3AXZqUE/jJJNCUFli6CzTPo9/6Rt0QhpzCwi99m6qno=;
 b=Ax4uTMO/iuNbDHpLEfHlNzTBn4bi8xwn8CgTLxhtPD/C4N9dd8uZ5tC86rd4zMoAQUFc76oMOqRo
 j5bLz5uqAGo4ofsQIJ6w4CNBehZS3EYPphwI4Ft6lhlnAyoHFK0Q
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hFMD9OpBP_5QXApnKI7KnJ7IYWGHhCPa
X-Proofpoint-ORIG-GUID: hFMD9OpBP_5QXApnKI7KnJ7IYWGHhCPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=962 bulkscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced QSEECOM driver fail to link if the system is built
without CONFIG_AUXILIARY_BUS, make sure it is selected.

Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/r/9f156fa6-e5aa-4cb2-ab2b-b67fd8fc4840%40infradead.org
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index a94202229a71..8c608be30060 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -229,6 +229,7 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 config QCOM_QSEECOM
 	bool "Qualcomm QSEECOM interface driver"
 	depends on QCOM_SCM=y
+	select AUXILIARY_BUS
 	help
 	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
 	  in the Trust Zone. This module provides an interface to that via the

---
base-commit: dfa449a58323de195773cf928d99db4130702bf7
change-id: 20230915-qseecom-auxiliary-fix-1574abe3bc98

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>

