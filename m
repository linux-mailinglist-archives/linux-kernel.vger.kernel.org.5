Return-Path: <linux-kernel+bounces-30727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948AA83239F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09436B21F88
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A8979F2;
	Fri, 19 Jan 2024 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iwghuIRZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9346AF;
	Fri, 19 Jan 2024 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705634632; cv=none; b=LET1z+khF0asmWlbaE1bMK1OrYLfPBPuBCpIorzs2LFPgKTn5R76cjAYW7IwJ3Hm6kay9T90GZr8ojAYGtVjrAw4rI0SSPtmG9nWXQYD0RVmtevL6oUXD3fbRnVyF8ZrhIb5VSYPq2V+Kn06FRCzmvz/Ms7OI77VEpzUNbgVY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705634632; c=relaxed/simple;
	bh=qLQB9k26oR+IScPEzv6X7+91xejOJzboL/jMlWcez1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDGsjIQhefAnbR5rlY++7tqR0jjAuFWcfFMc2huXIvirdREwFBxfytaYXJgnJpjF2/wtdhQil9lbbz5s6OGoz/LXAzoC0zuETRbpc0GKe0fXKp9GJLVrJXgtHuimzEArQahf1mVYw/xzyuOX7xNeGLG7QjyUOJ9i+Gn1uZeWV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iwghuIRZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J0ceft012159;
	Fri, 19 Jan 2024 03:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=SlLsolxfibKN7YPEJh0r
	t7k+Vkp+rc+4xFO7sZZVkQM=; b=iwghuIRZxJT28tswxSl6kShAnNcf8IY5DsnV
	LtAsPtc0XG9O2c+BlrgOJHjlOywNEigcI7Zu3TgxpGvGAz98WcAhLGq9J8LUqvBS
	EHWosEE0wRcFSvvjgX63OVGINseoKj662TcKbDnwGsOt+oPD5wDvunR62sBvC7ZA
	ZiWa4Haq9DMlZEfy5qhHO2ZVEb5u/CVPX70LVbPJJTjaPj89axkSwCtYSUkazVii
	xzToDfydpKkgD+YjCN75+76WFmul8FoyCM6b5Zrqk/2QkU+gwf50gnnrUKTAXA2S
	BUEoOp8gZ2LOYVtv0CMXOMJcFLLjvCMV7j4dONDuDHCNYs21eA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpxcytsds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J3NbaG005474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 03:23:37 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 19:23:32 -0800
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
Subject: [PATCH v4 02/10] coresight-tpdm: Optimize the useage of tpdm_has_dsb_dataset
Date: Fri, 19 Jan 2024 11:22:55 +0800
Message-ID: <1705634583-17631-3-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-GUID: f5gS4_gH0DDIlFLu9-YNT77bDMjWbbpc
X-Proofpoint-ORIG-GUID: f5gS4_gH0DDIlFLu9-YNT77bDMjWbbpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190012

Since the function tpdm_has_dsb_dataset will be called by TPDA
driver in subsequent patches, it is moved to the header file.
And move this judgement form the function __tpdm_{enable/disable}
to the beginning of the function tpdm_{enable/disable}_dsb.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 82 ++++++++++----------
 drivers/hwtracing/coresight/coresight-tpdm.h |  4 +
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 0427c0fc0bf3..6549f71ba150 100644
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
@@ -232,38 +227,39 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val, i;
 
-	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
-		writel_relaxed(drvdata->dsb->edge_ctrl[i],
-			   drvdata->base + TPDM_DSB_EDCR(i));
-	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
-		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
-			   drvdata->base + TPDM_DSB_EDCMR(i));
-	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
-		writel_relaxed(drvdata->dsb->patt_val[i],
-			   drvdata->base + TPDM_DSB_TPR(i));
-		writel_relaxed(drvdata->dsb->patt_mask[i],
-			   drvdata->base + TPDM_DSB_TPMR(i));
-		writel_relaxed(drvdata->dsb->trig_patt[i],
-			   drvdata->base + TPDM_DSB_XPR(i));
-		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
-			   drvdata->base + TPDM_DSB_XPMR(i));
-	}
-
-	set_dsb_tier(drvdata);
+	if (tpdm_has_dsb_dataset(drvdata)) {
+		for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
+			writel_relaxed(drvdata->dsb->edge_ctrl[i],
+				       drvdata->base + TPDM_DSB_EDCR(i));
+		for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
+			writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
+				       drvdata->base + TPDM_DSB_EDCMR(i));
+		for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+			writel_relaxed(drvdata->dsb->patt_val[i],
+				       drvdata->base + TPDM_DSB_TPR(i));
+			writel_relaxed(drvdata->dsb->patt_mask[i],
+				       drvdata->base + TPDM_DSB_TPMR(i));
+			writel_relaxed(drvdata->dsb->trig_patt[i],
+				       drvdata->base + TPDM_DSB_XPR(i));
+			writel_relaxed(drvdata->dsb->trig_patt_mask[i],
+				       drvdata->base + TPDM_DSB_XPMR(i));
+		}
 
-	set_dsb_msr(drvdata);
+		set_dsb_tier(drvdata);
+		set_dsb_msr(drvdata);
 
-	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
-	/* Set the mode of DSB dataset */
-	set_dsb_mode(drvdata, &val);
-	/* Set trigger type */
-	if (drvdata->dsb->trig_type)
-		val |= TPDM_DSB_CR_TRIG_TYPE;
-	else
-		val &= ~TPDM_DSB_CR_TRIG_TYPE;
-	/* Set the enable bit of DSB control register to 1 */
-	val |= TPDM_DSB_CR_ENA;
-	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+		val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+		/* Set the mode of DSB dataset */
+		set_dsb_mode(drvdata, &val);
+		/* Set trigger type */
+		if (drvdata->dsb->trig_type)
+			val |= TPDM_DSB_CR_TRIG_TYPE;
+		else
+			val &= ~TPDM_DSB_CR_TRIG_TYPE;
+		/* Set the enable bit of DSB control register to 1 */
+		val |= TPDM_DSB_CR_ENA;
+		writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+	}
 }
 
 /*
@@ -278,8 +274,7 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	if (tpdm_has_dsb_dataset(drvdata))
-		tpdm_enable_dsb(drvdata);
+	tpdm_enable_dsb(drvdata);
 
 	CS_LOCK(drvdata->base);
 }
@@ -307,10 +302,12 @@ static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
 
-	/* Set the enable bit of DSB control register to 0 */
-	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
-	val &= ~TPDM_DSB_CR_ENA;
-	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+	if (tpdm_has_dsb_dataset(drvdata)) {
+		/* Set the enable bit of DSB control register to 0 */
+		val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+		val &= ~TPDM_DSB_CR_ENA;
+		writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+	}
 }
 
 /* TPDM disable operations */
@@ -318,8 +315,7 @@ static void __tpdm_disable(struct tpdm_drvdata *drvdata)
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


