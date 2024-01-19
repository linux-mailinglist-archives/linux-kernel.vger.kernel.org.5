Return-Path: <linux-kernel+bounces-30729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139408323AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366D31C22003
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62824A15;
	Fri, 19 Jan 2024 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lg5KFo7V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2C17F5;
	Fri, 19 Jan 2024 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634658; cv=none; b=bdWyjPNXM0XQm7ZG4RWjR5pEIaaCxF/oFivYSI8ptg0CcoQ8pv3DxH+soivCoRAVLpNXK76cBHnwbvlQwCrMCWzD6VrKA2Hy6pnPv/yC39tQavfaf+BR4S+iF5nTJs210tYPFfChLAAZ0Qi9uc8ECXdNNHJrY6IgiCE9tuTajpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634658; c=relaxed/simple;
	bh=gnF6cbnM3yALw1/dC1rX0j/7eWAmbqyO+/vKrJPKLaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLkxP8b+c+CcIPEKqMFoPxC3GnCQfSxQKV5gBX2GBvilaxE1os5oo7ca46ieFBuH8avDMqNgrhKJdbVnGYOB7fnz+luNDv4poKJPJghOEL5kYkrIXUg/B99JPhKGKv3ZEsu+nH6q7Td5/VBJB+BXZuTfA2q7h5GB3AM6PgYCJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lg5KFo7V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J310H0006192;
	Fri, 19 Jan 2024 03:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Etc+nHsYbHNrOvqmZww3
	IuA9p/rkmTZ094LlxTxm4eY=; b=Lg5KFo7VBF5DwPFJ1yYpSOUn5eSdRrhXUlVz
	WUnumjeV0a566S5pedl6nSrKW6Jbo2YlXfStAvakT+3xdg5yRt683rZZ5k+xR1j2
	EGYDkBKbbVFL1Dw1Bnjd557V2EBq1r3hXOjG5rugzNkdEKX0sKaO8XKhbmFnU4UI
	g4JzZ4jF7oF/dVCdWfxc/kFzR0u5EDwxq0WVTcEQSUaLIhABUh+cALAZ7mntPraG
	cDvKD085gqJejpyUfYAq6jRDmfqV4Un0x7PF4s0lGB7qxjRuIsqaYeNzUKyGkGME
	J+oCV9oisQcp3yUFxwBdHPeIrIVt6GNpWtDe/OhK4hNX1GNIYw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq1s7a9d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J3NlYo025417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:47 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 19:23:42 -0800
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
Subject: [PATCH v4 04/10] coresight-tpdm: Add CMB dataset support
Date: Fri, 19 Jan 2024 11:22:57 +0800
Message-ID: <1705634583-17631-5-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dV8XkT9bOtb57KBvREnVNHcGNIl6Su2s
X-Proofpoint-GUID: dV8XkT9bOtb57KBvREnVNHcGNIl6Su2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=993 mlxscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190012

CMB (continuous multi-bit) is one of TPDM's dataset type. CMB subunit
can be enabled for data collection by writing 1 to the first bit of
CMB_CR register. This change is to add enable/disable function for
CMB dataset by writing CMB_CR register.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 28 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h | 13 +++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 6549f71ba150..424a2f724d82 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -262,6 +262,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 	}
 }
 
+static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	if (tpdm_has_cmb_dataset(drvdata)) {
+		val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
+		val |= TPDM_CMB_CR_ENA;
+
+		/* Set the enable bit of CMB control register to 1 */
+		writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
+	}
+}
+
 /*
  * TPDM enable operations
  * The TPDM or Monitor serves as data collection component for various
@@ -275,6 +288,7 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 	CS_UNLOCK(drvdata->base);
 
 	tpdm_enable_dsb(drvdata);
+	tpdm_enable_cmb(drvdata);
 
 	CS_LOCK(drvdata->base);
 }
@@ -310,12 +324,26 @@ static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
 	}
 }
 
+static void tpdm_disable_cmb(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	if (tpdm_has_cmb_dataset(drvdata)) {
+		val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
+		val &= ~TPDM_CMB_CR_ENA;
+
+		/* Set the enable bit of CMB control register to 0 */
+		writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
+	}
+}
+
 /* TPDM disable operations */
 static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
 	tpdm_disable_dsb(drvdata);
+	tpdm_disable_cmb(drvdata);
 
 	CS_LOCK(drvdata->base);
 }
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index ddaf333fa1c2..a442d9c6e4ac 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -9,6 +9,12 @@
 /* The max number of the datasets that TPDM supports */
 #define TPDM_DATASETS       7
 
+/* CMB Subunit Registers */
+#define TPDM_CMB_CR		(0xA00)
+
+/* Enable bit for CMB subunit */
+#define TPDM_CMB_CR_ENA		BIT(0)
+
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
@@ -79,10 +85,12 @@
  *
  * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
  * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
+ * PERIPHIDR0[2] : Fix to 1 if CMB subunit present, else 0
  */
 
 #define TPDM_PIDR0_DS_IMPDEF	BIT(0)
 #define TPDM_PIDR0_DS_DSB	BIT(1)
+#define TPDM_PIDR0_DS_CMB	BIT(2)
 
 #define TPDM_DSB_MAX_LINES	256
 /* MAX number of EDCR registers */
@@ -224,4 +232,9 @@ static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
 {
 	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
 }
+
+static bool tpdm_has_cmb_dataset(struct tpdm_drvdata *drvdata)
+{
+	return (drvdata->datasets & TPDM_PIDR0_DS_CMB);
+}
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.17.1


