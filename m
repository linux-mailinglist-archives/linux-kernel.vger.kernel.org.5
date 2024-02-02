Return-Path: <linux-kernel+bounces-49586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939B846C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E47C1C24B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DFD7866F;
	Fri,  2 Feb 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L5xO5jQK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B864C77653;
	Fri,  2 Feb 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866425; cv=none; b=R2P+MpFtVMMjxDMX0+fMGadr9oeIFXEicfFqjzBYvnSZ4MaA8wdxqJAHxfkkWOK3ilxp0zvcT+mqj/4980FyZmqbHFZiv0wxmzLiS08rPuT4Mp3zhj3HWtqy2qs7Um6zhmilN/tng9GUQ1ou3QMpOUOv3rPlReGSglsByLK8TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866425; c=relaxed/simple;
	bh=J1Fav46yfrrutQMhpx/1SaeAe0GyBKrRvn7bgXcLCOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn0U9Wdx9oa6waYBk3Ah0+Kxy81uOWqYCaKiZCk459B2tZgOh8HLvrAwYjsEsNIXz/HzKxxz3pMrebSNPW/LDgMKlvnObwKWZgb69wq9otkt5GDWViYH6VP8N5FXNIkmbH+eD/daU/WuTPCr92Urp04LQovwUYgxXxVv0jZdh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L5xO5jQK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4123vqnt023671;
	Fri, 2 Feb 2024 09:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=P8AP9xz6DnEBPOR6wXki
	rMpP+grtE6E4DC3kD9VF1M4=; b=L5xO5jQK/11HjoOq46Vw7LDnKVEPCB+MtW+Q
	mVgC1gUtUmiXz67dCs65jM0VUh4dEnDmw3vFxK6Sj5oTDDTzkVPLxdrI6HwD4pjS
	n+C1f41tDcy1HbqHEKoIwffYjy3izYfRxyBQM6Sf/fQBpvX4afypA/QoyEDdaOVQ
	MJCbZJ7CqLE8xfcgAaxi7LWxQ6mF0opt1zO4hBzKdc5tER0rszn03VZwGoTjCzuX
	nrROdl6S2WL3Mb6lY4vQes0dq1Kc3P6IrG7DYrsdV76oxItJMI3af7v7rPcttX4a
	31NQXrnGLv8zClpk4xpm6T8UJZ6js0KnsqtxRBou8TSuxrZmBw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptv11fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 09:33:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4129XP7E032305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 09:33:25 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 01:33:20 -0800
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
Subject: [PATCH v6 02/10] coresight-tpdm: Optimize the useage of tpdm_has_dsb_dataset
Date: Fri, 2 Feb 2024 17:32:36 +0800
Message-ID: <1706866364-19861-3-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jUrSRSAaRZr5Zof-I-qmVZjtFEB39PbS
X-Proofpoint-GUID: jUrSRSAaRZr5Zof-I-qmVZjtFEB39PbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020069

Since the function tpdm_has_dsb_dataset will be called by TPDA
driver in subsequent patches, it is moved to the header file.
And move this judgement form the function __tpdm_{enable/disable}
to the beginning of the function tpdm_{enable/disable}_dsb.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 30 +++++++++-----------
 drivers/hwtracing/coresight/coresight-tpdm.h |  4 +++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 0427c0fc0bf3..4b1296d11360 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -125,11 +125,6 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
 	return ret;
 }
 
-static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
-{
-	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
-}
-
 static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
 				   struct attribute *attr, int n)
 {
@@ -232,25 +227,27 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val, i;
 
+	if (!tpdm_has_dsb_dataset(drvdata))
+		return;
+
 	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
 		writel_relaxed(drvdata->dsb->edge_ctrl[i],
-			   drvdata->base + TPDM_DSB_EDCR(i));
+			       drvdata->base + TPDM_DSB_EDCR(i));
 	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
 		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
-			   drvdata->base + TPDM_DSB_EDCMR(i));
+			       drvdata->base + TPDM_DSB_EDCMR(i));
 	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
 		writel_relaxed(drvdata->dsb->patt_val[i],
-			   drvdata->base + TPDM_DSB_TPR(i));
+			       drvdata->base + TPDM_DSB_TPR(i));
 		writel_relaxed(drvdata->dsb->patt_mask[i],
-			   drvdata->base + TPDM_DSB_TPMR(i));
+			       drvdata->base + TPDM_DSB_TPMR(i));
 		writel_relaxed(drvdata->dsb->trig_patt[i],
-			   drvdata->base + TPDM_DSB_XPR(i));
+			       drvdata->base + TPDM_DSB_XPR(i));
 		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
-			   drvdata->base + TPDM_DSB_XPMR(i));
+			       drvdata->base + TPDM_DSB_XPMR(i));
 	}
 
 	set_dsb_tier(drvdata);
-
 	set_dsb_msr(drvdata);
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
@@ -278,8 +275,7 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	if (tpdm_has_dsb_dataset(drvdata))
-		tpdm_enable_dsb(drvdata);
+	tpdm_enable_dsb(drvdata);
 
 	CS_LOCK(drvdata->base);
 }
@@ -307,6 +303,9 @@ static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
 
+	if (!tpdm_has_dsb_dataset(drvdata))
+		return;
+
 	/* Set the enable bit of DSB control register to 0 */
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
 	val &= ~TPDM_DSB_CR_ENA;
@@ -318,8 +317,7 @@ static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	if (tpdm_has_dsb_dataset(drvdata))
-		tpdm_disable_dsb(drvdata);
+	tpdm_disable_dsb(drvdata);
 
 	CS_LOCK(drvdata->base);
 }
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 4115b2a17b8d..ddaf333fa1c2 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -220,4 +220,8 @@ struct tpdm_dataset_attribute {
 	u32 idx;
 };
 
+static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
+{
+	return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
+}
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.17.1


