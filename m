Return-Path: <linux-kernel+bounces-51439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60F848B3C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D452841F7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF48BF3;
	Sun,  4 Feb 2024 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JK0ZkIxS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05919473;
	Sun,  4 Feb 2024 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707024695; cv=none; b=FjBcPYTlzOOe6rqIuSVSAzLLWttz7h18E3t9so277xmxs7ep3tjX7TRCakqQyBOYpunnSaZ6hXZ0erUxUnGNw7Ol3OR4oJbl0aFUKP2S2ZmG6SRyq+ok4gTuErW8zjbgQJtxO1y/wQ2cW04tTqI7nwgsHKIdWgSBlp2ZcyX0/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707024695; c=relaxed/simple;
	bh=J1Fav46yfrrutQMhpx/1SaeAe0GyBKrRvn7bgXcLCOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpLVsd9aqEljhybU7sLRpJBqxizv/CP9NJ8Q0HCdOavXPG27VQfbXJUaidGJuHXsPNZO80tEaDg5ipjMScXD7DwHVq4A2EIltCc1KJ3d13MAiyojIyYEpiAAWBwpVwoXuJHUwvifobBev8Bko8pOZgx7W5LViIPFAG5UYt6T7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JK0ZkIxS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4145Cn7c007976;
	Sun, 4 Feb 2024 05:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=P8AP9xz6DnEBPOR6wXki
	rMpP+grtE6E4DC3kD9VF1M4=; b=JK0ZkIxSrxLWcIYLoXbJbUy2VZA38rwp7470
	lEQ4YQxDfTzpFj4WoyP17HOVpVTxs/LDvhtdw2JxyXUEfc+JTCnRG/DxSEaIJcG/
	Ny18AIBdOMCSw1GQQ9+kqj1nA9trB2di+JdBJ17uFaciZZaXDBe9cxRSKc8a1roD
	ol13JcLg4GSLHFFgUuhdrdsnw4iqEx1hNstI5ogWIpBmiea7pKffuW37oNgFKHZQ
	Fvk/l8jP2Mt3fEKStAvfKcTjf+juEL4YDRSS3byZejk/KA6xWUUOEcPwR1Z9mbvQ
	XooAafvvpu/us+6nvmouMxNP7z6kwvXNJlKwv2YiGI2R/oFcbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1gd1h7ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Feb 2024 05:31:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4145VM4r002977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 05:31:22 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 21:31:17 -0800
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
Subject: [PATCH v7 02/10] coresight-tpdm: Optimize the useage of tpdm_has_dsb_dataset
Date: Sun, 4 Feb 2024 13:30:33 +0800
Message-ID: <1707024641-22460-3-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1707024641-22460-1-git-send-email-quic_taozha@quicinc.com>
References: <1707024641-22460-1-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-GUID: EsIfyqqVkjwBWmeUF4NwyzGK7T9Y4fNu
X-Proofpoint-ORIG-GUID: EsIfyqqVkjwBWmeUF4NwyzGK7T9Y4fNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402040039

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


