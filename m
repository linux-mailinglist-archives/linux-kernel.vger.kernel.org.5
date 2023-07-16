Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80A6754DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGPHvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPHvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 03:51:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5771BE;
        Sun, 16 Jul 2023 00:51:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G7kwCt013935;
        Sun, 16 Jul 2023 07:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=ASPznVrkWJ81IidVJm2BlyuiKouytoTiMedJAHW9wcE=;
 b=Btc2rtrRkJwirhN/6/U0HWi9Zi+DIJKLONv2MJI7ju5OunQ1kNE1Iaxi3dMXOz0Vbda4
 GALXzICQZRkU21sDAP2sierrE8s69BVY6xG1SsAHAtfajlzPB98YFfUXGChCQTButF4m
 pRTTQqMrq+rL4p7016OmlkJoAEpNUz+/s5PdrWrX2BBIA8oN0L0a4v2WZZtVH9XAkPJZ
 1jyFrBm4cSFHhVRpQlXbxFOWbDQuej982VW42FahiYWBlFsVWrPfr17U4XIBisUv7siO
 22fK97xtQOschWpmmND9p3EmOMqMmd/WwBfHF2VjtctJAZ/JAHcds2gm4w3P1j3dFxJo wA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1jh839-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 07:49:45 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36G7nGTl002301;
        Sun, 16 Jul 2023 07:49:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3rumhk3epg-1;
        Sun, 16 Jul 2023 07:49:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36G7nGDl002295;
        Sun, 16 Jul 2023 07:49:16 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36G7nFGm002294;
        Sun, 16 Jul 2023 07:49:16 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 47E6D57163E; Sun, 16 Jul 2023 13:19:15 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, quic_cang@quicinc.com, stanley.chu@mediatek.com,
        bvanassche@acm.org, quic_asutoshd@quicinc.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        konrad.dybcio@linaro.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, jejb@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, quic_ziqichen@quicinc.com,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V2] scsi: ufs: ufs-qcom: Update UFS devfreq Parameters
Date:   Sun, 16 Jul 2023 13:19:07 +0530
Message-Id: <20230716074907.12356-1-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hONIiIwDrTPPYY-VHvPSJQXlQIpHPKGt
X-Proofpoint-GUID: hONIiIwDrTPPYY-VHvPSJQXlQIpHPKGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160072
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support the periodic polling mode without stop caused by CPU idle
state, enable delayed timer as default instead of deferrable timer
for qualcomm platforms.
And change UFS devfreq downdifferential threshold to 65 for less
aggressive downscaling.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---

Changes in v2:
- Realigned the commit text

 drivers/ufs/host/ufs-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 82d02e7f3b4f..a15815c951ca 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1388,8 +1388,9 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 					struct devfreq_simple_ondemand_data *d)
 {
 	p->polling_ms = 60;
+	p->timer = DEVFREQ_TIMER_DELAYED;
 	d->upthreshold = 70;
-	d->downdifferential = 5;
+	d->downdifferential = 65;
 }
 #else
 static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
--
2.17.1

