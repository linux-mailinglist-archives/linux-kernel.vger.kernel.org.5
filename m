Return-Path: <linux-kernel+bounces-26268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26EA82DDC5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C733EB2147A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FA317C6F;
	Mon, 15 Jan 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kvKgOCD2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFF17BBB;
	Mon, 15 Jan 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FFEAou013227;
	Mon, 15 Jan 2024 16:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XQ3H4RdNiU0Y9LkxGU2rkxr9v9+0ZdUQnvDha20T3co=; b=kv
	KgOCD2WG/2zuC5p2/qEnwrpbzCAR+r7eZkHocGQ65DwpQhsCKb1lf8Sku68ztrvF
	zEaif62vT/ogPDstFeIGL2pHS5YA8m9em6/7q7s9o9GWwekw5rTlJN5hAJ6QSja1
	BgC7HYZDQ9X204nHNkeTwgXSr94gafir4hQrZp5pBLlyWwr4S+IYMNbyOTQ3s3gy
	bj5g1EK5qKaqiPNuYt2+B01Zw2HXJtdNi8BvXJzpaNosi0NODQ17PJlGHaWEJrFs
	yBH7dtL+0VSdAFFPgu7fngnQpFr74Mu1kDIUFu9RKlHCST1v5ZpxfVkDc+XLFrs5
	2XdXDpIWEP0X9RIY5RPw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vmyhk13x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:43:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40FGh7OS020778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 16:43:07 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 08:43:06 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mathieu
 Poirier" <mathieu.poirier@linaro.org>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 1/2] coresight: core: Add device name support
Date: Mon, 15 Jan 2024 08:42:47 -0800
Message-ID: <20240115164252.26510-2-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240115164252.26510-1-quic_jinlmao@quicinc.com>
References: <20240115164252.26510-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0WzKVXlY4KZ-01oudJV35_jYPjqFx9fi
X-Proofpoint-GUID: 0WzKVXlY4KZ-01oudJV35_jYPjqFx9fi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401150122

For some coresight components like CTI and TPDM, there could be
numerous of them. From the node name, we can only get the type and
register address of the component. We can't identify the HW or the
system the component belongs to. Add the device-name support for
adding the intuitive name of the device.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 33 ++++++++++---------
 .../hwtracing/coresight/coresight-platform.c  | 31 +++++++++++++++++
 include/linux/coresight.h                     |  1 +
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fabe00a40d6..b85fc5cc3807 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1772,24 +1772,27 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 
 	mutex_lock(&coresight_mutex);
 
-	idx = coresight_search_device_idx(dict, dev_fwnode(dev));
-	if (idx < 0) {
-		/* Make space for the new entry */
-		idx = dict->nr_idx;
-		list = krealloc_array(dict->fwnode_list,
-				      idx + 1, sizeof(*dict->fwnode_list),
-				      GFP_KERNEL);
-		if (ZERO_OR_NULL_PTR(list)) {
-			idx = -ENOMEM;
-			goto done;
+	name = coresight_get_device_name(dev);
+	if (!name) {
+		idx = coresight_search_device_idx(dict, dev_fwnode(dev));
+		if (idx < 0) {
+			/* Make space for the new entry */
+			idx = dict->nr_idx;
+			list = krealloc_array(dict->fwnode_list,
+					      idx + 1, sizeof(*dict->fwnode_list),
+					      GFP_KERNEL);
+			if (ZERO_OR_NULL_PTR(list)) {
+				idx = -ENOMEM;
+				goto done;
+			}
+
+			list[idx] = dev_fwnode(dev);
+			dict->fwnode_list = list;
+			dict->nr_idx = idx + 1;
 		}
 
-		list[idx] = dev_fwnode(dev);
-		dict->fwnode_list = list;
-		dict->nr_idx = idx + 1;
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
 	}
-
-	name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
 done:
 	mutex_unlock(&coresight_mutex);
 	return name;
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 9d550f5697fa..c6c68fc9f787 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -183,6 +183,22 @@ static int of_coresight_get_cpu(struct device *dev)
 	return cpu;
 }
 
+static const char *of_coresight_get_device_name(struct device *dev)
+{
+	const char *name = NULL;
+
+	if (!dev->of_node)
+		return NULL;
+
+	/*
+	 * Get the device name from DT. The name describes the HW or
+	 * system the device is for.
+	 */
+	of_property_read_string(dev->of_node, "device-name", &name);
+
+	return name;
+}
+
 /*
  * of_coresight_parse_endpoint : Parse the given output endpoint @ep
  * and fill the connection information in @pdata->out_conns
@@ -315,6 +331,12 @@ static inline int of_coresight_get_cpu(struct device *dev)
 {
 	return -ENODEV;
 }
+
+static inline const char *of_coresight_get_device_name(struct device *dev)
+{
+	return NULL;
+}
+
 #endif
 
 #ifdef CONFIG_ACPI
@@ -794,6 +816,15 @@ int coresight_get_cpu(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(coresight_get_cpu);
 
+const char *coresight_get_device_name(struct device *dev)
+{
+	if (is_of_node(dev->fwnode))
+		return of_coresight_get_device_name(dev);
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_get_device_name);
+
 struct coresight_platform_data *
 coresight_get_platform_data(struct device *dev)
 {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a269fffaf991..caa17c8af865 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -675,6 +675,7 @@ static inline void coresight_write64(struct coresight_device *csdev, u64 val, u3
 #endif		/* IS_ENABLED(CONFIG_CORESIGHT) */
 
 extern int coresight_get_cpu(struct device *dev);
+extern const char *coresight_get_device_name(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
 struct coresight_connection *
-- 
2.41.0


