Return-Path: <linux-kernel+bounces-44202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B598D841EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D36929053C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6FC58AB6;
	Tue, 30 Jan 2024 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="esSmE/AO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77C60264;
	Tue, 30 Jan 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605446; cv=none; b=awnEfxJebsoyCNmpiW01/rKKWXlcp1RsECScIFxIwwoTxRPI0801LOghgkhZ1OyHs2uvkcEJxxsC4S3f/FxOKRULtYPIFeA2lZFnf4TpYbcQOWdcCxjV/BAO9QiRnRkcsnJ4jKWcGvzvorgWf3+CaMJJB0DUtMrgXyzpFdKrgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605446; c=relaxed/simple;
	bh=kSBLnTSvaJ/pbMhEZz4MmiLTZmWhk2/XJJzDRaDsi+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnMbdUfkWuMBIPuv0IFKXllwXE5Mgwm8ktpZWl/giESQWBzAkKVtC5f9wdLCT+4n7MnbR+rGOXjVh9KGgnOBmQs83x9Jxuj/oUZ/qxT+vL7KGoYhdwAgqMxl8DdLEUq4nMyq/FFg9s+SObf0apHdEaslnYn+hjr2EBxDR938D1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=esSmE/AO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U7g4Ej025400;
	Tue, 30 Jan 2024 09:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=jYJ4DQ14Btotx0/xS+d8
	m6Can58nhTk8aqP80bbHOgg=; b=esSmE/AOznQnynJLw1MP2I0xoS/wpwlG7Ebz
	ri5SddTxVzuw5oZ3MUh9AqlfMXmOwp7mc6O/jkVm5fSFo2DQxrhwSsKXd2okAFBH
	WuwfBEt1OX/RZIYs+I+2jt5IR0UNI5LEzjQmEEkS9kNKtL0VufudmI9LUrSgdI3X
	iUgM8HYrNjhjrQjjRQ6rmdkSFipGXhH1wiXnnry3bWL4YGisBy54cEj8ROS732b7
	EKTqJKvlAuxuSc2cEKjqWAdQenwQbMJQLzCRcOZQVzbkgGoxGrkMQ3QkW3ZPWfuq
	i0F5IijWpQMObKfV2QVFCG2DjHTUPLroSSlsu+bUpn/TJYpJgQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvwqr5b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 09:03:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U93q9A018995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 09:03:52 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 01:03:46 -0800
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
Subject: [PATCH v5 08/10] coresight-tpdm: Add timestamp control register support for the CMB
Date: Tue, 30 Jan 2024 17:02:44 +0800
Message-ID: <1706605366-31705-9-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -re6Ffw6AW4wbdXzMxKEhi7Epnd3XMvc
X-Proofpoint-GUID: -re6Ffw6AW4wbdXzMxKEhi7Epnd3XMvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_03,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300065

CMB_TIER register is CMB subunit timestamp insertion enable register.
Bit 0 is PATT_TSENAB bit. Set this bit to 1 to request a timestamp
following a CMB interface pattern match. Bit 1 is XTRIG_TSENAB bit.
Set this bit to 1 to request a timestamp following a CMB CTI timestamp
request. Bit 2 is TS_ALL bit. Set this bit to 1 to request timestamp
for all packets.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  35 +++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 121 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h  |  31 +++++
 3 files changed, 180 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index b6cf050861ed..e8c76ce4dd15 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -214,3 +214,38 @@ KernelVersion	6.9
 Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
 Description:
 		(RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_patt/enable_ts
+Date:		January 2024
+KernelVersion	6.9
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Set the pattern timestamp of CMB tpdm. Read
+		the pattern timestamp of CMB tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Disable CMB pattern timestamp.
+		1 : Enable CMB pattern timestamp.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_ts
+Date:		January 2024
+KernelVersion	6.9
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get the trigger timestamp of the CMB for tpdm.
+
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Set the CMB trigger type to false
+		1 : Set the CMB trigger type to true
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_ts_all
+Date:		January 2024
+KernelVersion	6.9
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Read or write the status of timestamp upon all interface.
+		Only value 0 and 1  can be written to this node. Set this node to 1 to requeset
+		timestamp to all trace packet.
+		Accepts only one of the 2 values -  0 or 1.
+		0 : Disable the timestamp of all trace packets.
+		1 : Enable the timestamp of all trace packets.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 07587287d9fa..22966d541230 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -322,6 +322,31 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
 
+static void set_cmb_tier(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	val = readl_relaxed(drvdata->base + TPDM_CMB_TIER);
+
+	/* Clear all relevant fields */
+	val &= ~(TPDM_CMB_TIER_PATT_TSENAB | TPDM_CMB_TIER_TS_ALL |
+		 TPDM_CMB_TIER_XTRIG_TSENAB);
+
+	/* Set pattern timestamp type and enablement */
+	if (drvdata->cmb->patt_ts)
+		val |= TPDM_CMB_TIER_PATT_TSENAB;
+
+	/* Set trigger timestamp */
+	if (drvdata->cmb->trig_ts)
+		val |= TPDM_CMB_TIER_XTRIG_TSENAB;
+
+	/* Set all timestamp enablement*/
+	if (drvdata->cmb->ts_all)
+		val |= TPDM_CMB_TIER_TS_ALL;
+
+	writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
+}
+
 static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 {
 	u32 val, i;
@@ -341,6 +366,8 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
 			drvdata->base + TPDM_CMB_XPMR(i));
 	}
 
+	set_cmb_tier(drvdata);
+
 	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
 	/*
 	 * Set to 0 for continuous CMB collection mode,
@@ -687,9 +714,18 @@ static ssize_t enable_ts_show(struct device *dev,
 			      char *buf)
 {
 	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct tpdm_dataset_attribute *tpdm_attr =
+		container_of(attr, struct tpdm_dataset_attribute, attr);
+	ssize_t size = -EINVAL;
 
-	return sysfs_emit(buf, "%u\n",
-			 (unsigned int)drvdata->dsb->patt_ts);
+	if (tpdm_attr->mem == DSB_PATT)
+		size = sysfs_emit(buf, "%u\n",
+				  (unsigned int)drvdata->dsb->patt_ts);
+	else if (tpdm_attr->mem == CMB_PATT)
+		size = sysfs_emit(buf, "%u\n",
+				  (unsigned int)drvdata->cmb->patt_ts);
+
+	return size;
 }
 
 /*
@@ -701,17 +737,23 @@ static ssize_t enable_ts_store(struct device *dev,
 			       size_t size)
 {
 	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct tpdm_dataset_attribute *tpdm_attr =
+		container_of(attr, struct tpdm_dataset_attribute, attr);
 	unsigned long val;
 
 	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
-	drvdata->dsb->patt_ts = !!val;
-	spin_unlock(&drvdata->spinlock);
+	guard(spinlock)(&drvdata->spinlock);
+	if (tpdm_attr->mem == DSB_PATT)
+		drvdata->dsb->patt_ts = !!val;
+	else if (tpdm_attr->mem == CMB_PATT)
+		drvdata->cmb->patt_ts = !!val;
+	else
+		return -EINVAL;
+
 	return size;
 }
-static DEVICE_ATTR_RW(enable_ts);
 
 static ssize_t set_type_show(struct device *dev,
 			     struct device_attribute *attr,
@@ -842,6 +884,68 @@ static ssize_t cmb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(cmb_mode);
 
+static ssize_t cmb_ts_all_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			  (unsigned int)drvdata->cmb->ts_all);
+}
+
+static ssize_t cmb_ts_all_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	if (val)
+		drvdata->cmb->ts_all = true;
+	else
+		drvdata->cmb->ts_all = false;
+
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_ts_all);
+
+static ssize_t cmb_trig_ts_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			  (unsigned int)drvdata->cmb->trig_ts);
+}
+
+static ssize_t cmb_trig_ts_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	if (val)
+		drvdata->cmb->trig_ts = true;
+	else
+		drvdata->cmb->trig_ts = false;
+
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_ts);
+
 static struct attribute *tpdm_dsb_edge_attrs[] = {
 	&dev_attr_ctrl_idx.attr,
 	&dev_attr_ctrl_val.attr,
@@ -910,7 +1014,7 @@ static struct attribute *tpdm_dsb_patt_attrs[] = {
 	DSB_PATT_MASK_ATTR(5),
 	DSB_PATT_MASK_ATTR(6),
 	DSB_PATT_MASK_ATTR(7),
-	&dev_attr_enable_ts.attr,
+	DSB_PATT_ENABLE_TS,
 	&dev_attr_set_type.attr,
 	NULL,
 };
@@ -964,6 +1068,7 @@ static struct attribute *tpdm_cmb_patt_attrs[] = {
 	CMB_PATT_ATTR(1),
 	CMB_PATT_MASK_ATTR(0),
 	CMB_PATT_MASK_ATTR(1),
+	CMB_PATT_ENABLE_TS,
 	NULL,
 };
 
@@ -976,6 +1081,8 @@ static struct attribute *tpdm_dsb_attrs[] = {
 
 static struct attribute *tpdm_cmb_attrs[] = {
 	&dev_attr_cmb_mode.attr,
+	&dev_attr_cmb_ts_all.attr,
+	&dev_attr_cmb_trig_ts.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 8cb8a9b35384..725a35e5893f 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -11,6 +11,8 @@
 
 /* CMB Subunit Registers */
 #define TPDM_CMB_CR		(0xA00)
+/*CMB subunit timestamp insertion enable register*/
+#define TPDM_CMB_TIER		(0xA04)
 /*CMB subunit timestamp pattern registers*/
 #define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
 /*CMB subunit timestamp pattern mask registers*/
@@ -24,6 +26,12 @@
 #define TPDM_CMB_CR_ENA		BIT(0)
 /* Trace collection mode for CMB subunit */
 #define TPDM_CMB_CR_MODE	BIT(1)
+/* Timestamp control for pattern match */
+#define TPDM_CMB_TIER_PATT_TSENAB	BIT(0)
+/* CMB CTI timestamp request */
+#define TPDM_CMB_TIER_XTRIG_TSENAB	BIT(1)
+/* For timestamp fo all trace */
+#define TPDM_CMB_TIER_TS_ALL		BIT(2)
 
 /*Patten register number*/
 #define TPDM_CMB_MAX_PATT		2
@@ -134,6 +142,15 @@
 	   }								\
 	})[0].attr.attr)
 
+#define tpdm_patt_enable_ts(name, mem)				\
+	(&((struct tpdm_dataset_attribute[]) {			\
+	   {							\
+		__ATTR(name, 0644, enable_ts_show,		\
+		enable_ts_store),		\
+		mem,						\
+	   }							\
+	})[0].attr.attr)
+
 #define DSB_EDGE_CTRL_ATTR(nr)					\
 		tpdm_simple_dataset_ro(edcr##nr,		\
 		DSB_EDGE_CTRL, nr)
@@ -158,6 +175,10 @@
 		tpdm_simple_dataset_rw(tpmr##nr,		\
 		DSB_PATT_MASK, nr)
 
+#define DSB_PATT_ENABLE_TS					\
+		tpdm_patt_enable_ts(enable_ts,			\
+		DSB_PATT)
+
 #define DSB_MSR_ATTR(nr)					\
 		tpdm_simple_dataset_rw(msr##nr,			\
 		DSB_MSR, nr)
@@ -178,6 +199,10 @@
 		tpdm_simple_dataset_rw(tpmr##nr,		\
 		CMB_PATT_MASK, nr)
 
+#define CMB_PATT_ENABLE_TS					\
+		tpdm_patt_enable_ts(enable_ts,			\
+		CMB_PATT)
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
@@ -217,6 +242,9 @@ struct dsb_dataset {
  * @patt_mask:        Save value for pattern mask
  * @trig_patt:        Save value for trigger pattern
  * @trig_patt_mask:   Save value for trigger pattern mask
+ * @patt_ts:          Indicates if pattern match for timestamp is enabled.
+ * @trig_ts:          Indicates if CTI trigger for timestamp is enabled.
+ * @ts_all:           Indicates if timestamp is enabled for all packets.
  */
 struct cmb_dataset {
 	u32			trace_mode;
@@ -224,6 +252,9 @@ struct cmb_dataset {
 	u32			patt_mask[TPDM_CMB_MAX_PATT];
 	u32			trig_patt[TPDM_CMB_MAX_PATT];
 	u32			trig_patt_mask[TPDM_CMB_MAX_PATT];
+	bool			patt_ts;
+	bool			trig_ts;
+	bool			ts_all;
 };
 
 /**
-- 
2.17.1


