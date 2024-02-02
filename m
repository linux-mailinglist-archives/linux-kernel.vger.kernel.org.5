Return-Path: <linux-kernel+bounces-49588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C40D846C1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A69F28122A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AFB7C095;
	Fri,  2 Feb 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ePKWFEPf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC397C093;
	Fri,  2 Feb 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866433; cv=none; b=ABnZIk9VyG895xcqrIe/9uUyYHiKB2dS7QpeSS7xIe504fcLIgrw4/doclHKVGYRFksNykIoPVSDogePr+1UHxBzkfcqbHxhjOaKwRI54iWiaarZ7kxREo7F4mnzZqJqja8yYrqgb9S3qC4pe7QHaQQR/DNvduI6Zm2ZCIsAtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866433; c=relaxed/simple;
	bh=IOPP1hnlhd0FKbhG8aIJhG8rQG9mege+e7LkrOvlmXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syeOadTjpgbAqS8RuPIA5H+jGGKvTn2cPdrfdit2eWCyAECvsJFKnbOg1zfXqdR2od/Askiq4Ftay/tYsH8+sNw61mrHC/uJhXpJckCkGntD5uEXIFqmZYFrYzVa0jhFVhM1hh+avGUfUkevejvE3e90Y1mO0odygqfLyFw3dkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ePKWFEPf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4126eV3x013665;
	Fri, 2 Feb 2024 09:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=fOPAmsy/dC7mODE/30IB
	nRw8k2AYw3ycEku1cIzKACk=; b=ePKWFEPfGKel/90S0mX8THpe1nOiYtr/R8oZ
	lbm6henPUZIgnxn2LTI7XphEQYSX6tlptTlLdUPJwZh4C/AryYLli9RtBroyVMsC
	nxjdOBs81nOXipTWIhY17/sldS21TjyjZxkqkyLZ1houSFj3uNzK13Co5jJhhXHz
	Ty/P+XY9LJ2eoRVIQ1A7vF7R/BXyH715/irLER6cCnPEK2cuXoLlLeDf87hW8xyG
	cWYbIdsBCAoBXgrhh8uZL9O1GA8xRHqCbwmaKSh29EdexkMvdN/UWS45QTS03onh
	2J2QTjBHbgp3jN2wvpZ3En+axQaVExCP0k1ssm/iAQ4iHWtylA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu010dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 09:33:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4129XdN8010230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 09:33:39 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 01:33:34 -0800
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
Subject: [PATCH v6 05/10] coresight-tpda: Add support to configure CMB element
Date: Fri, 2 Feb 2024 17:32:39 +0800
Message-ID: <1706866364-19861-6-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1706866364-19861-1-git-send-email-quic_taozha@quicinc.com>
References: <1706866364-19861-1-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-GUID: oI_1HkMDTWUt5JuVaP6k6GpssDdR1mpT
X-Proofpoint-ORIG-GUID: oI_1HkMDTWUt5JuVaP6k6GpssDdR1mpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=840 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020068

Read the CMB element size from the device tree. Set the register
bit that controls the CMB element size of the corresponding port.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 125 +++++++++++--------
 drivers/hwtracing/coresight/coresight-tpda.h |   6 +
 2 files changed, 81 insertions(+), 50 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 4ac954f4bc13..27d567f4c8bf 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -18,6 +18,7 @@
 #include "coresight-priv.h"
 #include "coresight-tpda.h"
 #include "coresight-trace-id.h"
+#include "coresight-tpdm.h"
 
 DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
 
@@ -28,24 +29,59 @@ static bool coresight_device_is_tpdm(struct coresight_device *csdev)
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
+	/* Clear all relevant fields */
+	*val &= ~(TPDA_Pn_CR_DSBSIZE | TPDA_Pn_CR_CMBSIZE);
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
+		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
+				"qcom,cmb-element-bits", &drvdata->cmb_esize);
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
@@ -56,11 +92,12 @@ static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
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
@@ -69,30 +106,26 @@ static int tpda_get_element_size(struct coresight_device *csdev,
 			continue;
 
 		/* Ignore the paths that do not match port */
-		if (inport > 0 &&
+		if (inport >= 0 &&
 		    csdev->pdata->in_conns[i]->dest_port != inport)
 			continue;
 
 		if (coresight_device_is_tpdm(in)) {
-			size = tpdm_read_dsb_element_size(in);
+			if (drvdata->dsb_esize || drvdata->cmb_esize)
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
@@ -109,7 +142,7 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
 {
 	u32 val;
-	int size;
+	int rc;
 
 	val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
 	/*
@@ -117,29 +150,21 @@ static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
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
+	if (!rc && (drvdata->dsb_esize || drvdata->cmb_esize)) {
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
+			      "Detected multiple TPDMs on port %d", port);
+	else
+		dev_warn_once(&drvdata->csdev->dev,
+			      "Didn't find TPDM element size");
 
-	return 0;
+	return rc;
 }
 
 static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index b3b38fd41b64..19af64120fcf 100644
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
+	u32			cmb_esize;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
-- 
2.17.1


