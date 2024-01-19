Return-Path: <linux-kernel+bounces-30731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA6A8323AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CEA1F238C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039D4DDA0;
	Fri, 19 Jan 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hjgaYRZt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937401871;
	Fri, 19 Jan 2024 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634659; cv=none; b=FwbsixQ3l6EbAXDN0oJ1FhUsCfwCHcPmLkqoUjQXbMPfQYC0WgCpZpzmFnzfI/g2Y4piqQLLc2PN/ygMZtG4+PEbUmIX7iNLWtJYYxT4K+zlqM9bx9KsCLeZ31e4RfOci1At+bLG1Lr3sbRbGAIjrNjIGF1CNv9oEjxDy/7yysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634659; c=relaxed/simple;
	bh=q3BAwQaLruax6gV3H4LnyOgpi7PP/QnMfK/62uH8xS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX1nHhpNC9a8BvV24RZ63/W4n1eKjFTH2HWCKOdo7BK9ThiJeyW2wuodB0dKl840EgHaLfBfaCcszGpLFSHE00k25UlhtnJDQYTrc99coHy3iiTzZYvFhbaoD8yz/YERzjiZCXbqJECEEJwIsihQ5DO4rRnJwvir9LSukGFlpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hjgaYRZt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40INo94J020152;
	Fri, 19 Jan 2024 03:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=QIca7MaulpDNMwfzHR3x
	O7EG2aOUeN+8nCZFiqJnttU=; b=hjgaYRZt8HRAlfhY5vH4H7KBoGPvUxiqmxAS
	5ubASOudUSQjAQ+VrDQB7EUPN4U2AMkkzcJXpKIyo0b+ETJ7R1w6Onx7r9ayZuc4
	qhs/c1ea02Cr42EMmOIycX/AwWOaCWmttSC1vqOfgfaNjt9lasgCZNWoRdzulElh
	gi9r5isH2VFvYDekShOpfbdoW6GcjO9/ipBr4rFAnu7PKtbAaKc3/+1ksniTz1e6
	pmmm3UrV0m/yf52nVmQK4aJfEFwmPa+V+JdXVtSAtFxywTbHCbbczMH98aPP/fmM
	DuUZqns0cpedOR3KqYT+O9pYUyS7PJ+8W5fktX+F8184FcB9Rg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpx8sjsk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J3NpeH003044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:51 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 19:23:47 -0800
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH v4 05/10] coresight-tpda: Add support to configure CMB element
Date: Fri, 19 Jan 2024 11:22:58 +0800
Message-ID: <1705634583-17631-6-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
References: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HOlpjMKIvAxtsFHZDwbL05fV7Cf55U_D
X-Proofpoint-GUID: HOlpjMKIvAxtsFHZDwbL05fV7Cf55U_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=814 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401190012

Read the CMB element size from the device tree. Set the register
bit that controls the CMB element size of the corresponding port.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 123 +++++++++++--------
 drivers/hwtracing/coresight/coresight-tpda.h |   6 +
 2 files changed, 79 insertions(+), 50 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 4ac954f4bc13..987a69428c93 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -18,6 +18,7 @@
 #include "coresight-priv.h"
 #include "coresight-tpda.h"
 #include "coresight-trace-id.h"
+#include "coresight-tpdm.h"
 
 DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
 
@@ -28,24 +29,57 @@ static bool coresight_device_is_tpdm(struct coresight_device *csdev)
 			CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
 }
 
+static void tpdm_clear_element_size(struct coresight_device *csdev)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	drvdata->dsb_esize = 0;
+	drvdata->cmb_esize = 0;
+}
+
+static void tpda_set_element_size(struct tpda_drvdata *drvdata, u32 *val)
+{
+
+	if (drvdata->dsb_esize == 64)
+		*val |= TPDA_Pn_CR_DSBSIZE;
+	else if (drvdata->dsb_esize == 32)
+		*val &= ~TPDA_Pn_CR_DSBSIZE;
+
+	if (drvdata->cmb_esize == 64)
+		*val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
+	else if (drvdata->cmb_esize == 32)
+		*val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
+	else if (drvdata->cmb_esize == 8)
+		*val &= ~TPDA_Pn_CR_CMBSIZE;
+}
+
 /*
- * Read the DSB element size from the TPDM device
+ * Read the element size from the TPDM device. One TPDM must have at least one of the
+ * element size property.
  * Returns
- *    The dsb element size read from the devicetree if available.
- *    0 - Otherwise, with a warning once.
+ *    0 - The element size property is read
+ *    Others - Cannot read the property of the element size
  */
-static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
+static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
+				  struct coresight_device *csdev)
 {
-	int rc = 0;
-	u8 size = 0;
+	int rc = -EINVAL;
+	struct tpdm_drvdata *tpdm_data = dev_get_drvdata(csdev->dev.parent);
+
+	if (tpdm_has_dsb_dataset(tpdm_data)) {
+		rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
+				"qcom,dsb-element-size", &drvdata->dsb_esize);
+	}
+	if (tpdm_has_cmb_dataset(tpdm_data)) {
+		rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
+				"qcom,cmb-element-size", &drvdata->cmb_esize);
+	}
 
-	rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
-			"qcom,dsb-element-size", &size);
 	if (rc)
 		dev_warn_once(&csdev->dev,
-			"Failed to read TPDM DSB Element size: %d\n", rc);
+			"Failed to read TPDM Element size: %d\n", rc);
 
-	return size;
+	return rc;
 }
 
 /*
@@ -56,11 +90,12 @@ static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
  * Parameter "inport" is used to pass in the input port number
  * of TPDA, and it is set to -1 in the recursize call.
  */
-static int tpda_get_element_size(struct coresight_device *csdev,
+static int tpda_get_element_size(struct tpda_drvdata *drvdata,
+				 struct coresight_device *csdev,
 				 int inport)
 {
-	int dsb_size = -ENOENT;
-	int i, size;
+	int rc = 0;
+	int i;
 	struct coresight_device *in;
 
 	for (i = 0; i < csdev->pdata->nr_inconns; i++) {
@@ -69,30 +104,26 @@ static int tpda_get_element_size(struct coresight_device *csdev,
 			continue;
 
 		/* Ignore the paths that do not match port */
-		if (inport > 0 &&
+		if (inport >= 0 &&
 		    csdev->pdata->in_conns[i]->dest_port != inport)
 			continue;
 
 		if (coresight_device_is_tpdm(in)) {
-			size = tpdm_read_dsb_element_size(in);
+			if ((drvdata->dsb_esize) || (drvdata->cmb_esize))
+				return -EEXIST;
+			rc = tpdm_read_element_size(drvdata, in);
+			if (rc)
+				return rc;
 		} else {
 			/* Recurse down the path */
-			size = tpda_get_element_size(in, -1);
-		}
-
-		if (size < 0)
-			return size;
-
-		if (dsb_size < 0) {
-			/* Found a size, save it. */
-			dsb_size = size;
-		} else {
-			/* Found duplicate TPDMs */
-			return -EEXIST;
+			rc = tpda_get_element_size(drvdata, in, -1);
+			if (rc)
+				return rc;
 		}
 	}
 
-	return dsb_size;
+
+	return rc;
 }
 
 /* Settings pre enabling port control register */
@@ -109,7 +140,7 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 {
 	u32 val;
-	int size;
+	int rc;
 
 	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
 	/*
@@ -117,29 +148,21 @@ static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 	 * Set the bit to 0 if the size is 32
 	 * Set the bit to 1 if the size is 64
 	 */
-	size = tpda_get_element_size(drvdata->csdev, port);
-	switch (size) {
-	case 32:
-		val &= ~TPDA_Pn_CR_DSBSIZE;
-		break;
-	case 64:
-		val |= TPDA_Pn_CR_DSBSIZE;
-		break;
-	case 0:
-		return -EEXIST;
-	case -EEXIST:
+	tpdm_clear_element_size(drvdata->csdev);
+	rc = tpda_get_element_size(drvdata, drvdata->csdev, port);
+	if (!rc && ((drvdata->dsb_esize) || (drvdata->cmb_esize))) {
+		tpda_set_element_size(drvdata, &val);
+		/* Enable the port */
+		val |= TPDA_Pn_CR_ENA;
+		writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
+	} else if (rc == -EEXIST)
 		dev_warn_once(&drvdata->csdev->dev,
-			"Detected multiple TPDMs on port %d", -EEXIST);
-		return -EEXIST;
-	default:
-		return -EINVAL;
-	}
-
-	/* Enable the port */
-	val |= TPDA_Pn_CR_ENA;
-	writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
+			      "Detected multiple TPDMs on port %d", -EEXIST);
+	else
+		dev_warn_once(&drvdata->csdev->dev,
+			      "Didn't find TPDM element size");
 
-	return 0;
+	return rc;
 }
 
 static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index b3b38fd41b64..29164fd9711f 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -10,6 +10,8 @@
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 /* Aggregator port enable bit */
 #define TPDA_Pn_CR_ENA		BIT(0)
+/* Aggregator port CMB data set element size bit */
+#define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
 /* Aggregator port DSB data set element size bit */
 #define TPDA_Pn_CR_DSBSIZE		BIT(8)
 
@@ -25,6 +27,8 @@
  * @csdev:      component vitals needed by the framework.
  * @spinlock:   lock for the drvdata value.
  * @enable:     enable status of the component.
+ * @dsb_esize   Record the DSB element size.
+ * @cmb_esize   Record the CMB element size.
  */
 struct tpda_drvdata {
 	void __iomem		*base;
@@ -32,6 +36,8 @@ struct tpda_drvdata {
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	u8			atid;
+	u8			dsb_esize;
+	u8			cmb_esize;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
-- 
2.17.1


