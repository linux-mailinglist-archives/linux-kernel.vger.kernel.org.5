Return-Path: <linux-kernel+bounces-83227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D82869080
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91D8B25165
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A1146007;
	Tue, 27 Feb 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ksrij+U8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01913B2BE;
	Tue, 27 Feb 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036716; cv=none; b=I2FAJZGnNZaq8L8QlkhaZyL0KYPsRyte9K7bCbhHNEVQ5yqFsFzxP4Olaz2UgcU27H7r1eWRyOsuzQuvV6RNc328/r9L7D64uxBS/NjrDa5VT1dc+oy5NkTuk4p447iDoL7JyvaKKhy+Y/au6jcMOvSCP5s+eClxvePe36lKuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036716; c=relaxed/simple;
	bh=A3hEtv4nzQIvISWTrx5mPfcc1VbsK/y66rk0Z5IcGKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tetLfMrYr0gO7xTnYShtdosMTrjpXGN2r1i9f7txkw5D4DM+0V4TuU+7AWOM7VLcNuvBEWJCxAd6wbi0nqHZ8YBV9tM5bTOi0tu3o9LedEyoU+gxN7Jqs9YtwAromkXhddTQcz9L9W4loii4TB6YQH34MZJmDec+7f1fKo+iwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ksrij+U8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9Xs3r001292;
	Tue, 27 Feb 2024 12:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=CMT6xSqpB/zSKkSjg9BbqEZg5VC0/ZeO2OqSy+JWKz0=; b=Ks
	rij+U8cmJg+SbxE0wz8bi9okGnDw20cA79ddQKtGMxXIN66zB5JhyvSElaQAAM3M
	LW3R3TB+tRAcuZpQO5l98Z9hg2oELiLLK3BP+a+Bubl1rwnr7X52mapS4iRbUAmr
	U/FuEZwP3R/3qweaaMu7AGSvpV6kjmPRO2vM1GkhY0EnwzDZb9v4kHEfYfR9SpQf
	DF0typmVhDXEvBzF2H56182pyf8AivzKkNydYgmd0LwfVI69iGT3j7fiOlstA/dg
	2OL+ADB3BJgJ87GgChviJ0D/JeielrQjjEOhp8utIx5uS5QbpCS38/8BRLxYhgom
	DWhdi6nHjjeeVz3yG3oQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64qh8b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:25:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RCP7Gr013108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:25:07 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 04:25:04 -0800
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH 8/9] media: qcom: camss: Decompose register and link operations
Date: Tue, 27 Feb 2024 14:24:14 +0200
Message-ID: <20240227122415.491-9-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227122415.491-1-quic_grosikop@quicinc.com>
References: <20240227122415.491-1-quic_grosikop@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -aodAE1is8MmR_XMSDvPvd-Qdru0uZHm
X-Proofpoint-GUID: -aodAE1is8MmR_XMSDvPvd-Qdru0uZHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270097

From: Atanas Filipov <quic_afilipov@quicinc.com>

Split link and register operations.
Add dedicated link callback according to SoC identifier.

Signed-off-by: Atanas Filipov <quic_afilipov@quicinc.com>
Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss.c | 140 ++++++++++++----------
 drivers/media/platform/qcom/camss/camss.h |   1 +
 2 files changed, 80 insertions(+), 61 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index fc9940e883c5..244849db39dc 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1452,72 +1452,30 @@ static int camss_init_subdevices(struct camss *camss)
 }
 
 /*
- * camss_register_entities - Register subdev nodes and create links
+ * camss_link_entities - Register subdev nodes and create links
  * @camss: CAMSS device
  *
  * Return 0 on success or a negative error code on failure
  */
-static int camss_register_entities(struct camss *camss)
+static int camss_link_entities(struct camss *camss)
 {
 	int i, j, k;
 	int ret;
 
-	for (i = 0; i < camss->res->csiphy_num; i++) {
-		ret = msm_csiphy_register_entity(&camss->csiphy[i],
-						 &camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to register csiphy%d entity: %d\n",
-				i, ret);
-			goto err_reg_csiphy;
-		}
-	}
-
-	for (i = 0; i < camss->res->csid_num; i++) {
-		ret = msm_csid_register_entity(&camss->csid[i],
-					       &camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to register csid%d entity: %d\n",
-				i, ret);
-			goto err_reg_csid;
-		}
-	}
-
-	ret = msm_ispif_register_entities(camss->ispif,
-					  &camss->v4l2_dev);
-	if (ret < 0) {
-		dev_err(camss->dev, "Failed to register ispif entities: %d\n",
-		ret);
-		goto err_reg_ispif;
-	}
-
-	for (i = 0; i < camss->res->vfe_num; i++) {
-		ret = msm_vfe_register_entities(&camss->vfe[i],
-						&camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to register vfe%d entities: %d\n",
-				i, ret);
-			goto err_reg_vfe;
-		}
-	}
-
 	for (i = 0; i < camss->res->csiphy_num; i++) {
 		for (j = 0; j < camss->res->csid_num; j++) {
-			ret = media_create_pad_link(
-				&camss->csiphy[i].subdev.entity,
-				MSM_CSIPHY_PAD_SRC,
-				&camss->csid[j].subdev.entity,
-				MSM_CSID_PAD_SINK,
-				0);
+			ret = media_create_pad_link(&camss->csiphy[i].subdev.entity,
+						    MSM_CSIPHY_PAD_SRC,
+						    &camss->csid[j].subdev.entity,
+						    MSM_CSID_PAD_SINK,
+						    0);
 			if (ret < 0) {
 				dev_err(camss->dev,
 					"Failed to link %s->%s entities: %d\n",
 					camss->csiphy[i].subdev.entity.name,
 					camss->csid[j].subdev.entity.name,
 					ret);
-				goto err_link;
+				return ret;
 			}
 		}
 	}
@@ -1525,19 +1483,18 @@ static int camss_register_entities(struct camss *camss)
 	if (camss->ispif) {
 		for (i = 0; i < camss->res->csid_num; i++) {
 			for (j = 0; j < camss->ispif->line_num; j++) {
-				ret = media_create_pad_link(
-					&camss->csid[i].subdev.entity,
-					MSM_CSID_PAD_SRC,
-					&camss->ispif->line[j].subdev.entity,
-					MSM_ISPIF_PAD_SINK,
-					0);
+				ret = media_create_pad_link(&camss->csid[i].subdev.entity,
+							    MSM_CSID_PAD_SRC,
+							    &camss->ispif->line[j].subdev.entity,
+							    MSM_ISPIF_PAD_SINK,
+							    0);
 				if (ret < 0) {
 					dev_err(camss->dev,
 						"Failed to link %s->%s entities: %d\n",
 						camss->csid[i].subdev.entity.name,
 						camss->ispif->line[j].subdev.entity.name,
 						ret);
-					goto err_link;
+					return ret;
 				}
 			}
 		}
@@ -1559,7 +1516,7 @@ static int camss_register_entities(struct camss *camss)
 							ispif->entity.name,
 							vfe->entity.name,
 							ret);
-						goto err_link;
+						return ret;
 					}
 				}
 	} else {
@@ -1580,15 +1537,67 @@ static int camss_register_entities(struct camss *camss)
 							csid->entity.name,
 							vfe->entity.name,
 							ret);
-						goto err_link;
+						return ret;
 					}
 				}
 	}
 
+	return 0;
+}
+
+/*
+ * camss_register_entities - Register subdev nodes and create links
+ * @camss: CAMSS device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int camss_register_entities(struct camss *camss)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < camss->res->csiphy_num; i++) {
+		ret = msm_csiphy_register_entity(&camss->csiphy[i],
+						 &camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to register csiphy%d entity: %d\n",
+				i, ret);
+			goto err_reg_csiphy;
+		}
+	}
+
+	for (i = 0; i < camss->res->csid_num; i++) {
+		ret = msm_csid_register_entity(&camss->csid[i],
+					       &camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to register csid%d entity: %d\n",
+				i, ret);
+			goto err_reg_csid;
+		}
+	}
+
+	ret = msm_ispif_register_entities(camss->ispif,
+					  &camss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(camss->dev, "Failed to register ispif entities: %d\n", ret);
+		goto err_reg_ispif;
+	}
+
+	for (i = 0; i < camss->res->vfe_num; i++) {
+		ret = msm_vfe_register_entities(&camss->vfe[i],
+						&camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to register vfe%d entities: %d\n",
+				i, ret);
+			goto err_reg_vfe;
+		}
+	}
+
 	return 0;
 
-err_link:
-	i = camss->res->vfe_num;
 err_reg_vfe:
 	for (i--; i >= 0; i--)
 		msm_vfe_unregister_entities(&camss->vfe[i]);
@@ -1908,6 +1917,10 @@ static int camss_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_v4l2_device_unregister;
 
+	ret = camss->res->link_entities(camss);
+	if (ret < 0)
+		goto err_register_subdevs;
+
 	if (num_subdevs) {
 		camss->notifier.ops = &camss_subdev_notifier_ops;
 
@@ -1987,6 +2000,7 @@ static const struct camss_resources msm8916_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8x16),
 	.csid_num = ARRAY_SIZE(csid_res_8x16),
 	.vfe_num = ARRAY_SIZE(vfe_res_8x16),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources msm8996_resources = {
@@ -1998,6 +2012,7 @@ static const struct camss_resources msm8996_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8x96),
 	.csid_num = ARRAY_SIZE(csid_res_8x96),
 	.vfe_num = ARRAY_SIZE(vfe_res_8x96),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sdm660_resources = {
@@ -2009,6 +2024,7 @@ static const struct camss_resources sdm660_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_660),
 	.csid_num = ARRAY_SIZE(csid_res_660),
 	.vfe_num = ARRAY_SIZE(vfe_res_660),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sdm845_resources = {
@@ -2019,6 +2035,7 @@ static const struct camss_resources sdm845_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_845),
 	.csid_num = ARRAY_SIZE(csid_res_845),
 	.vfe_num = ARRAY_SIZE(vfe_res_845),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sm8250_resources = {
@@ -2032,6 +2049,7 @@ static const struct camss_resources sm8250_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8250),
 	.csid_num = ARRAY_SIZE(csid_res_8250),
 	.vfe_num = ARRAY_SIZE(vfe_res_8250),
+	.link_entities = camss_link_entities
 };
 
 static const struct of_device_id camss_dt_match[] = {
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 5abde7481caf..fb997b94fd70 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -105,6 +105,7 @@ struct camss_resources {
 	const unsigned int csiphy_num;
 	const unsigned int csid_num;
 	const unsigned int vfe_num;
+	int (*link_entities)(struct camss *camss);
 };
 
 struct camss {
-- 
2.17.1


