Return-Path: <linux-kernel+bounces-140465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E48A14FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B02861BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC25814AD2C;
	Thu, 11 Apr 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dE7yvvrm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A114EC4C;
	Thu, 11 Apr 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839609; cv=none; b=AVsKgJG6tkU0K4BsIq2MH1v7wsKWODTvVEUJIiyaOODJEZZWXL7PuXFT8KEhj4rpq+xVJNjxxo8x5Hq+NG6+JYg5Rrhg5ttpcnjYtKBz9R43tfqyulB5oS4Ob9hk8IyVDxCb8C5lnjaia4BIyWkG+SREmYB+5zjUy/8HknjeUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839609; c=relaxed/simple;
	bh=xLsE3J0UoeIb6Q/RZwTm88u4Rmx9crVV0hiRI4sNzWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZJdk/AtblcUlNkobDT4w+UYmvHOFS9ioBJJr+VsRiTXpPvk6BpSycSXpbq9RCrZCGS7fBtZ+FQgSmqelYFOmLHVeUZgRyx5leCssqLpZhaZobtKWMYIC5JMKnbpTnnMMKH2AowCSxxzcwoj5+Y2zIsqLc990WXwVo7yAb464B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dE7yvvrm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BBCMmS008800;
	Thu, 11 Apr 2024 12:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=5QOnk8248YSq+LW9XTpUIXurEtwprUfHkZ6vX5xcP5o=; b=dE
	7yvvrmPDtK34u4CKWAycx2ko//XDbT65cy1YhOwuzOvjSGFDS5HU9vjiYaxtrUw4
	1lGgvPADM7q4HSVKL6E33pejv2Ar0p242uxLX1WhaMp3RN5cJtNYVOA2uK34PLag
	uu/VmzFGWoQLyIIcLAUkSMJm9aw5lyse+BY1/W6aMSqr+Yjl7qoYjiBu03ZWcbSH
	2vBNiQckBpJvJRsfOtU4N01mhCS3oRnmsKbEjUGYEXFzFYF/ZtUcp5iy4sSl8rFp
	VUbsuUnXzH8QJrFEixD7C0TpmstOblwdmBBjfEh6MlaGaSQdQKkFw899tJjVN8K3
	Vc7PttgnJxNYjlorGQ1w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xedugrjs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 12:46:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BCkf6W019537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 12:46:41 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 05:46:38 -0700
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH v3 7/8] media: qcom: camss: Decompose register and link operations
Date: Thu, 11 Apr 2024 15:45:42 +0300
Message-ID: <20240411124543.199-8-quic_grosikop@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411124543.199-1-quic_grosikop@quicinc.com>
References: <20240411124543.199-1-quic_grosikop@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fEg2PwRxwPzFuoakAN61JvVE3frZr89c
X-Proofpoint-ORIG-GUID: fEg2PwRxwPzFuoakAN61JvVE3frZr89c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404110093

From: Atanas Filipov <quic_afilipov@quicinc.com>

Split link and register operations.
Add dedicated link callback according to SoC identifier.

Signed-off-by: Atanas Filipov <quic_afilipov@quicinc.com>
Signed-off-by: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss.c | 141 ++++++++++++----------
 drivers/media/platform/qcom/camss/camss.h |   1 +
 2 files changed, 81 insertions(+), 61 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index d57bbea32107..37060eaa0ba5 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1807,72 +1807,30 @@ static int camss_init_subdevices(struct camss *camss)
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
@@ -1880,19 +1838,18 @@ static int camss_register_entities(struct camss *camss)
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
@@ -1914,7 +1871,7 @@ static int camss_register_entities(struct camss *camss)
 							ispif->entity.name,
 							vfe->entity.name,
 							ret);
-						goto err_link;
+						return ret;
 					}
 				}
 	} else {
@@ -1935,15 +1892,67 @@ static int camss_register_entities(struct camss *camss)
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
@@ -2263,6 +2272,10 @@ static int camss_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_v4l2_device_unregister;
 
+	ret = camss->res->link_entities(camss);
+	if (ret < 0)
+		goto err_register_subdevs;
+
 	if (num_subdevs) {
 		camss->notifier.ops = &camss_subdev_notifier_ops;
 
@@ -2342,6 +2355,7 @@ static const struct camss_resources msm8916_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8x16),
 	.csid_num = ARRAY_SIZE(csid_res_8x16),
 	.vfe_num = ARRAY_SIZE(vfe_res_8x16),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources msm8996_resources = {
@@ -2353,6 +2367,7 @@ static const struct camss_resources msm8996_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8x96),
 	.csid_num = ARRAY_SIZE(csid_res_8x96),
 	.vfe_num = ARRAY_SIZE(vfe_res_8x96),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sdm660_resources = {
@@ -2364,6 +2379,7 @@ static const struct camss_resources sdm660_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_660),
 	.csid_num = ARRAY_SIZE(csid_res_660),
 	.vfe_num = ARRAY_SIZE(vfe_res_660),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sdm845_resources = {
@@ -2374,6 +2390,7 @@ static const struct camss_resources sdm845_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_845),
 	.csid_num = ARRAY_SIZE(csid_res_845),
 	.vfe_num = ARRAY_SIZE(vfe_res_845),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sm8250_resources = {
@@ -2387,6 +2404,7 @@ static const struct camss_resources sm8250_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_8250),
 	.csid_num = ARRAY_SIZE(csid_res_8250),
 	.vfe_num = ARRAY_SIZE(vfe_res_8250),
+	.link_entities = camss_link_entities
 };
 
 static const struct camss_resources sc8280xp_resources = {
@@ -2401,6 +2419,7 @@ static const struct camss_resources sc8280xp_resources = {
 	.csiphy_num = ARRAY_SIZE(csiphy_res_sc8280xp),
 	.csid_num = ARRAY_SIZE(csid_res_sc8280xp),
 	.vfe_num = ARRAY_SIZE(vfe_res_sc8280xp),
+	.link_entities = camss_link_entities
 };
 
 static const struct of_device_id camss_dt_match[] = {
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 4b13012940bf..a5be9e872992 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -106,6 +106,7 @@ struct camss_resources {
 	const unsigned int csiphy_num;
 	const unsigned int csid_num;
 	const unsigned int vfe_num;
+	int (*link_entities)(struct camss *camss);
 };
 
 struct camss {
-- 
2.17.1


