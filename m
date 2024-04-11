Return-Path: <linux-kernel+bounces-140466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6B8A1501
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC7F287A09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC17114F9F4;
	Thu, 11 Apr 2024 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O5IsH8Gl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883314F12E;
	Thu, 11 Apr 2024 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839613; cv=none; b=MLJgl7lQFiGEQkecW/xvf2nZ4fNWKR6ups+H0FT/VrBGdK7Z8MXPvsTnfUDznu6Ua2hvFhTJxd0ffCpH4AgpCClyhSVv0qpT7d4yzFul6Ct0H2ClCM0qS+9sWE5DRTboSL+LSbJ3VuLXX7VwTDLRnQHj3cVM04CbRQbNM1+wKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839613; c=relaxed/simple;
	bh=RSOJGtO6BR2UMj8bCDctwIDhEW7LJmJnk8q/eA/Q7A4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2tvfbahbkZFFprcryb2M6YD+E1xUonRtYUJUcJN2ESdsxv/N5fXwIa26cynjt7pNklM+H0Hmzs69MogzTUBHzTW07SxbwyqJWWtiB2JH9EieIlhr5WWfXYCPMOPBsP1VjdItqLFFIndKuBzmr/AdmKzSzYaNILukVUu0e+H3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O5IsH8Gl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BBvEVA026116;
	Thu, 11 Apr 2024 12:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yxxX504SH2pM8o/T+MNJC+WIBvBAN8ME0Ew0/cwMKSs=; b=O5
	IsH8GlEaN6Ai9/UvQ7lYdOnGC25g5DY3zlgRjBcwoch9oSLyamvjcWupKx0fFwgg
	Wd7q+qX3zip8du6pgEj6p3c/1R/zjFwDMSuh7umIkiV9aFCttCWx3xDUfnhCX6PE
	VUwwocsRJ89jeU4eY/mBNb0sPw7f0UFsiQ7pniQXiah8PMf6KngkiqJbIEqPASDU
	p34njBPNYA9+OYM4y6e4jP4nY2BSPfRB61BI9w/8kRDEQXpOW5n9vzB6xpiNEYrB
	JylDv8wiLLKpAMLcE8WNFnn6RKaMy74kohOXAbz3+KcTaab53WE5m29shCyBRuE3
	jNZ8YLCWQQlKMHx2otfA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe9js9vnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 12:46:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BCkiEJ027699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 12:46:44 GMT
Received: from grosikop.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 05:46:41 -0700
From: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <hverkuil-cisco@xs4all.nl>, <quic_hariramp@quicinc.com>
Subject: [PATCH v3 8/8] media: qcom: camss: Decouple VFE from CSID
Date: Thu, 11 Apr 2024 15:45:43 +0300
Message-ID: <20240411124543.199-9-quic_grosikop@quicinc.com>
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
X-Proofpoint-ORIG-GUID: nGk9UKk-iOAZevs6_EuU-KIK6qr80Tcy
X-Proofpoint-GUID: nGk9UKk-iOAZevs6_EuU-KIK6qr80Tcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110093

From: Milen Mitkov <quic_mmitkov@quicinc.com>

Decouple the direct calls to VFE's vfe_get/put in the CSID subdev
in order to prepare for the introduction of IFE subdev.

Also decouple CSID base address from VFE since on the Titan platform
CSID register base address resides within VFE's base address.

Signed-off-by: Milen Mitkov <quic_mmitkov@quicinc.com>
Signed-off-by: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
---
 .../media/platform/qcom/camss/camss-csid.c    | 16 +++--
 .../media/platform/qcom/camss/camss-csid.h    |  1 +
 drivers/media/platform/qcom/camss/camss.c     | 69 +++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h     |  8 +++
 4 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 5b23f5b8746d..858db5d4ca75 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -602,7 +602,6 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 	struct csid_device *csid = v4l2_get_subdevdata(sd);
 	struct camss *camss = csid->camss;
 	struct device *dev = camss->dev;
-	struct vfe_device *vfe = &camss->vfe[csid->id];
 	int ret = 0;
 
 	if (on) {
@@ -611,7 +610,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 		 * switching on the CSID. Do so unconditionally, as there is no
 		 * drawback in following the same powering order on older SoCs.
 		 */
-		ret = vfe_get(vfe);
+		ret = csid->res->parent_dev_ops->get(camss, csid->id);
 		if (ret < 0)
 			return ret;
 
@@ -663,7 +662,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 		regulator_bulk_disable(csid->num_supplies,
 				       csid->supplies);
 		pm_runtime_put_sync(dev);
-		vfe_put(vfe);
+		csid->res->parent_dev_ops->put(camss, csid->id);
 	}
 
 	return ret;
@@ -1021,6 +1020,11 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 	csid->id = id;
 	csid->res = &res->csid;
 
+	if (dev_WARN_ONCE(dev, !csid->res->parent_dev_ops,
+			  "Error: CSID depends on VFE/IFE device ops!\n")) {
+		return -EINVAL;
+	}
+
 	csid->res->hw_ops->subdev_init(csid);
 
 	/* Memory */
@@ -1031,9 +1035,11 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 		 * VFE to be initialized before CSID
 		 */
 		if (id >= 2) /* VFE/CSID lite */
-			csid->base = camss->vfe[id].base + VFE_480_LITE_CSID_OFFSET;
+			csid->base = csid->res->parent_dev_ops->get_base_address(camss, id)
+				+ VFE_480_LITE_CSID_OFFSET;
 		else
-			csid->base = camss->vfe[id].base + VFE_480_CSID_OFFSET;
+			csid->base = csid->res->parent_dev_ops->get_base_address(camss, id)
+				 + VFE_480_CSID_OFFSET;
 	} else {
 		csid->base = devm_platform_ioremap_resource_byname(pdev, res->reg[0]);
 		if (IS_ERR(csid->base))
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index 0e385d17c250..8cdae98e4dca 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -157,6 +157,7 @@ struct csid_hw_ops {
 struct csid_subdev_resources {
 	bool is_lite;
 	const struct csid_hw_ops *hw_ops;
+	const struct parent_dev_ops *parent_dev_ops;
 	const struct csid_formats *formats;
 };
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 37060eaa0ba5..4d625ef59cf7 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -32,6 +32,8 @@
 #define CAMSS_CLOCK_MARGIN_NUMERATOR 105
 #define CAMSS_CLOCK_MARGIN_DENOMINATOR 100
 
+static const struct parent_dev_ops vfe_parent_dev_ops;
+
 static const struct camss_subdev_resources csiphy_res_8x16[] = {
 	/* CSIPHY0 */
 	{
@@ -87,6 +89,7 @@ static const struct camss_subdev_resources csid_res_8x16[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_1,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_1
 		}
 	},
@@ -109,6 +112,7 @@ static const struct camss_subdev_resources csid_res_8x16[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_1,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_1
 		}
 	},
@@ -226,6 +230,7 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -248,6 +253,7 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -270,6 +276,7 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -292,6 +299,7 @@ static const struct camss_subdev_resources csid_res_8x96[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	}
@@ -445,6 +453,7 @@ static const struct camss_subdev_resources csid_res_660[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -470,6 +479,7 @@ static const struct camss_subdev_resources csid_res_660[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -495,6 +505,7 @@ static const struct camss_subdev_resources csid_res_660[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	},
@@ -520,6 +531,7 @@ static const struct camss_subdev_resources csid_res_660[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_4_7,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_4_7
 		}
 	}
@@ -714,6 +726,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -739,6 +752,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -765,6 +779,7 @@ static const struct camss_subdev_resources csid_res_845[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	}
@@ -957,6 +972,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -974,6 +990,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.type = CAMSS_SUBDEV_TYPE_CSID,
 		.csid = {
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -991,6 +1008,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1008,6 +1026,7 @@ static const struct camss_subdev_resources csid_res_8250[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	}
@@ -1212,6 +1231,7 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 		.interrupt = { "csid0" },
 		.csid = {
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1227,6 +1247,7 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 		.interrupt = { "csid1" },
 		.csid = {
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1242,6 +1263,7 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 		.interrupt = { "csid2" },
 		.csid = {
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1257,6 +1279,7 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 		.interrupt = { "csid3" },
 		.csid = {
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1272,6 +1295,7 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1287,6 +1311,7 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1302,6 +1327,7 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	},
@@ -1317,6 +1343,7 @@ static const struct camss_subdev_resources csid_res_sc8280xp[] = {
 		.csid = {
 			.is_lite = true,
 			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
 			.formats = &csid_formats_gen2
 		}
 	}
@@ -1661,6 +1688,48 @@ void camss_pm_domain_off(struct camss *camss, int id)
 	}
 }
 
+static int vfe_parent_dev_ops_get(struct camss *camss, int id)
+{
+	int ret = -EINVAL;
+
+	if (id < camss->res->vfe_num) {
+		struct vfe_device *vfe = &camss->vfe[id];
+
+		ret = vfe_get(vfe);
+	}
+
+	return ret;
+}
+
+static int vfe_parent_dev_ops_put(struct camss *camss, int id)
+{
+	if (id < camss->res->vfe_num) {
+		struct vfe_device *vfe = &camss->vfe[id];
+
+		vfe_put(vfe);
+	}
+
+	return 0;
+}
+
+static void __iomem
+*vfe_parent_dev_ops_get_base_address(struct camss *camss, int id)
+{
+	if (id < camss->res->vfe_num) {
+		struct vfe_device *vfe = &camss->vfe[id];
+
+		return vfe->base;
+	}
+
+	return NULL;
+}
+
+static const struct parent_dev_ops vfe_parent_dev_ops = {
+	.get = vfe_parent_dev_ops_get,
+	.put = vfe_parent_dev_ops_put,
+	.get_base_address = vfe_parent_dev_ops_get_base_address
+};
+
 /*
  * camss_of_parse_endpoint_node - Parse port endpoint node
  * @dev: Device
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index a5be9e872992..b3c967bcf8a9 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -143,6 +143,12 @@ struct camss_clock {
 	u32 nfreqs;
 };
 
+struct parent_dev_ops {
+	int (*get)(struct camss *camss, int id);
+	int (*put)(struct camss *camss, int id);
+	void __iomem *(*get_base_address)(struct camss *camss, int id);
+};
+
 void camss_add_clock_margin(u64 *rate);
 int camss_enable_clocks(int nclocks, struct camss_clock *clock,
 			struct device *dev);
@@ -153,6 +159,8 @@ s64 camss_get_link_freq(struct media_entity *entity, unsigned int bpp,
 int camss_get_pixel_clock(struct media_entity *entity, u64 *pixel_clock);
 int camss_pm_domain_on(struct camss *camss, int id);
 void camss_pm_domain_off(struct camss *camss, int id);
+int camss_vfe_get(struct camss *camss, int id);
+void camss_vfe_put(struct camss *camss, int id);
 void camss_delete(struct camss *camss);
 
 #endif /* QC_MSM_CAMSS_H */
-- 
2.17.1


