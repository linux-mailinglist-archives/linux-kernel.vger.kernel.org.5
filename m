Return-Path: <linux-kernel+bounces-119828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061488CD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1834CB253F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2854713D255;
	Tue, 26 Mar 2024 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zunIod8J"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790113D515
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482177; cv=none; b=ljF7/Sj+t/NRdbIgK6K4KvLA/dNqP8yvaRulTH5MBCNY9bjknFaklj5BdEXIBecHPvjpooSxyBo4RlpOmhR2B2rae4gKsq8Qz0un6o2mO0XEcBN0sylbpPZrbgkw0DFG4IB9BvQx3KnuoFE9tZwHYxQuWEzRGYO4pILV8Ew+G0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482177; c=relaxed/simple;
	bh=IGA2kr6iYwiZ6daPNgPlctmKJXfc6Zbtkzx4IhqzjSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDhuvov33xQci6tr04oXU239ErlIzfz/JQwvA3xoc+GeAgSS6f/XZEpj0xDzZXjQMS+apvRlmf+dIxmkONDZLeRNMNq2DNTLB13X1rHP+FaZdX1gXg2y/7YkUNymRuH7XG0dl2nC1oNo6Nxq2ajSrlD0AQ6uAj86r3ldExa2qdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zunIod8J; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4a39ab1a10so338906666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711482167; x=1712086967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+F6K/QF4XPqgP7DjCC7bqZMW3nnSueZMAF4mu4XwKEg=;
        b=zunIod8JOFaXHUk1RWuiDp7KbM3MMBxf0fND4dzmxGa6WjNnuzB7k7tVXcUemqzv5n
         Oxa6JeBMpjEY9sNl/+qRnWpWwCFOzR7A2QJiRs29qWCG/57DucX6yue/Q4tNg2nTMZUI
         IHh3tEkXBsv9O+G+qikj82DyYZWah0mAsJlL1/uxgqSvnSU0bFYWEUyhXSKkMBuiY/EU
         FqwLRPp3YAGN3qwmHZeagErdaMnd3CsO/mu2FcXTz6giGOpIqDiX49LSiTegJNVaOKmB
         t8PyIAoV1q493IH/c5LWDM6oiin47kIkLlwiSa9MZkOa6wvXar+Kk68Pqn2DkAozu03V
         Kf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482167; x=1712086967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+F6K/QF4XPqgP7DjCC7bqZMW3nnSueZMAF4mu4XwKEg=;
        b=szqV+yPmZDA4VNCmOEVyJBbP0ji5GOvA6y0gA8h2IaAr+MSMHFg/+kPkTlrbk0AbuJ
         xxYp3Kn3mbUU4KJWjHO6rGO7D7nQKKOomv7sCQ1FP2U1kJXjihwJ8YvhDKgj7jTH9hHu
         Dup9yFhJk1RVRjt5DnCpr12q4jUcUoxgCkOdIu5lXH7cSMwgSIFxbtMspQ6Hl8HwXiJS
         CL3W2kz4oa3CdA/3U7L337c7p3fawqpRLe6bHPZ7W7fSwlMFuO7hDJOdRCOIpjBMSI9l
         jd5Zm72cKirJJPLDVgFUuvr503+Jn0dnDQSs0xVHc1PkoFX53Jwf8AMJmDdydXsB+2BV
         38PA==
X-Forwarded-Encrypted: i=1; AJvYcCX/tfZX5T/CG8urL5xqe+daUke05R87kZbyas/2AP0e+G0jDvD+Yf9ZpzgbzbOQMuK3WcU90I+XjBCoBGCn/G2GPQ5Ptu6ZvoPN9/kW
X-Gm-Message-State: AOJu0YzqoywxE8k743v4VyLsz8hmi1ueGFhVOFHLEfp81F3l0rCYMl+F
	U/bTwECQuYY/CWo6cmIGPJia/SM7ifF4R0hfw+ISC62jMUs4jgPlz8ci5ccCKPE=
X-Google-Smtp-Source: AGHT+IFvd4SVSoNtdpNzVA/cBiy16tT+46LK/SwH1GXoW/kgQ08/hZuNDo2xqGJYcUWzUMTPNuITRA==
X-Received: by 2002:a17:906:538b:b0:a46:d978:bf02 with SMTP id g11-20020a170906538b00b00a46d978bf02mr467325ejo.34.1711482166571;
        Tue, 26 Mar 2024 12:42:46 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b00a46d4e26301sm4523807ejk.27.2024.03.26.12.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:42:46 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 26 Mar 2024 20:42:35 +0100
Subject: [PATCH 4/4] interconnect: qcom: icc-rpm: Remodel how QoS settings
 are stored
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org>
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711482160; l=149876;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IGA2kr6iYwiZ6daPNgPlctmKJXfc6Zbtkzx4IhqzjSI=;
 b=Hjg2lTrUinZykdcIgqPLzaGq3ViQPJSarihJxxXqAqVaXhoKmI1S2sUarx5hk/CT+Kt4WoSE2
 ELmBeH3YaQWD/J0E/61j89S+yOvctGAdiScXQIE5FQSUH4MHfAhWm1i
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently, the QoS settings are stored in the node data, even though
they're a property of the bus/provider instead. Moreover, they are only
needed during the probe step, so they can be easily moved into struct
qcom_icc_desc.

Reshuffle things around to make it anywhere near readable & comparable
with a reference. As a nice bonus, a lot of bytes are shaved off and
a few miliseconds are shaved off here and there.

As an example, bloat-o-meter reports this on sm6115.o:
Total: Before=14799, After=13263, chg -10.38%

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 123 +++++----
 drivers/interconnect/qcom/icc-rpm.h |  13 +-
 drivers/interconnect/qcom/msm8909.c | 268 ++++++++++---------
 drivers/interconnect/qcom/msm8916.c | 153 ++++++-----
 drivers/interconnect/qcom/msm8939.c | 157 ++++++-----
 drivers/interconnect/qcom/msm8996.c | 517 +++++++++++++++++-------------------
 drivers/interconnect/qcom/qcm2290.c | 416 +++++++++++++++++------------
 drivers/interconnect/qcom/sdm660.c  | 393 +++++++++++++--------------
 drivers/interconnect/qcom/sm6115.c  | 239 ++++++++++++-----
 9 files changed, 1224 insertions(+), 1055 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 0169de588a46..3f71a18af7db 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -50,26 +50,24 @@
 
 #define ICC_BUS_CLK_MIN_RATE		19200ULL /* kHz */
 
-static void qcom_icc_set_qnoc_qos(struct icc_node *src)
+static void qcom_icc_set_qnoc_qos(struct qcom_icc_provider *qp,
+				  const struct qcom_icc_qos_data *qos,
+				  unsigned int qos_off)
 {
-	struct icc_provider *provider = src->provider;
-	struct qcom_icc_provider *qp = to_qcom_provider(provider);
-	struct qcom_icc_node *qn = src->data;
-	struct qcom_icc_qos *qos = &qn->qos;
-
 	regmap_update_bits(qp->regmap,
-			   qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
+			   qos_off + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
 			   QNOC_QOS_MCTL_DFLT_PRIO_MASK,
 			   qos->areq_prio << QNOC_QOS_MCTL_DFLT_PRIO_SHIFT);
 
 	regmap_update_bits(qp->regmap,
-			   qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
+			   qos_off + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
 			   QNOC_QOS_MCTL_URGFWD_EN_MASK,
 			   !!qos->urg_fwd_en << QNOC_QOS_MCTL_URGFWD_EN_SHIFT);
 }
 
 static void qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
-					 struct qcom_icc_qos *qos,
+					 const struct qcom_icc_qos_data *qos,
+					 unsigned int qos_off,
 					 int regnum)
 {
 	u32 val;
@@ -88,108 +86,105 @@ static void qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
 	}
 
 	regmap_update_bits(qp->regmap,
-			   qp->qos_offset + M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
+			   qos_off + M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
 			   mask, val);
 }
 
-static void qcom_icc_set_bimc_qos(struct icc_node *src)
+static void qcom_icc_set_bimc_qos(struct qcom_icc_provider *qp,
+				  const struct qcom_icc_qos_data *qos,
+				  unsigned int qos_off)
 {
-	struct qcom_icc_provider *qp;
-	struct qcom_icc_node *qn;
-	struct icc_provider *provider;
-	u32 mode = NOC_QOS_MODE_BYPASS;
+	u32 mode = qos->qos_mode;
 	u32 val = 0;
 
-	qn = src->data;
-	provider = src->provider;
-	qp = to_qcom_provider(provider);
-
-	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
-		mode = qn->qos.qos_mode;
-
 	/* QoS Priority: The QoS Health parameters are getting considered
 	 * only if we are NOT in Bypass Mode.
 	 */
 	if (mode != NOC_QOS_MODE_BYPASS) {
-		qcom_icc_bimc_set_qos_health(qp, &qn->qos, 3);
-		qcom_icc_bimc_set_qos_health(qp, &qn->qos, 2);
-		qcom_icc_bimc_set_qos_health(qp, &qn->qos, 1);
-		qcom_icc_bimc_set_qos_health(qp, &qn->qos, 0);
+		qcom_icc_bimc_set_qos_health(qp, qos, qos_off, 3);
+		qcom_icc_bimc_set_qos_health(qp, qos, qos_off, 2);
+		qcom_icc_bimc_set_qos_health(qp, qos, qos_off, 1);
+		qcom_icc_bimc_set_qos_health(qp, qos, qos_off, 0);
 
 		/* Set BKE_EN to 1 when Fixed, Regulator or Limiter Mode */
 		val = 1;
 	}
 
 	regmap_update_bits(qp->regmap,
-			   qp->qos_offset + M_BKE_EN_ADDR(qn->qos.qos_port),
+			   qos_off + M_BKE_EN_ADDR(qos->qos_port),
 			   M_BKE_EN_EN_BMASK, val);
 }
 
 static void qcom_icc_noc_set_qos_priority(struct qcom_icc_provider *qp,
-					 struct qcom_icc_qos *qos)
+					  const struct qcom_icc_qos_data *qos,
+					  unsigned int qos_off)
 {
 	u32 val;
 
 	/* Must be updated one at a time, P1 first, P0 last */
 	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
 	regmap_update_bits(qp->regmap,
-			   qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
+			   qos_off + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
 			   NOC_QOS_PRIORITY_P1_MASK, val);
 
 	regmap_update_bits(qp->regmap,
-			   qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
+			   qos_off + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
 			   NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);
 }
 
-static void qcom_icc_set_noc_qos(struct icc_node *src)
+static void qcom_icc_set_noc_qos(struct qcom_icc_provider *qp,
+				 const struct qcom_icc_qos_data *qos,
+				 unsigned int qos_off,
+				 int idx)
 {
-	struct qcom_icc_provider *qp;
-	struct qcom_icc_node *qn;
-	struct icc_provider *provider;
 	u32 mode = NOC_QOS_MODE_BYPASS_VAL;
 
-	qn = src->data;
-	provider = src->provider;
-	qp = to_qcom_provider(provider);
-
-	if (qn->qos.qos_port < 0) {
-		dev_dbg(src->provider->dev,
-			"NoC QoS: Skipping %s: vote aggregated on parent.\n",
-			qn->name);
+	if (qos->qos_port < 0) {
+		dev_dbg(qp->provider.dev,
+			"NoC QoS: Skipping setting[%i] aggregated on parent.\n",
+			idx);
 	}
 
-	if (qn->qos.qos_mode == NOC_QOS_MODE_FIXED) {
-		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n", qn->name);
+	if (qos->qos_mode == NOC_QOS_MODE_FIXED) {
+		dev_dbg(qp->provider.dev, "NoC QoS[%i] (port %i): Set Fixed mode\n",
+			idx, qos->qos_port);
 		mode = NOC_QOS_MODE_FIXED_VAL;
-		qcom_icc_noc_set_qos_priority(qp, &qn->qos);
-	} else if (qn->qos.qos_mode == NOC_QOS_MODE_BYPASS) {
-		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode\n", qn->name);
+		qcom_icc_noc_set_qos_priority(qp, qos, qos_off);
+	} else if (qos->qos_mode == NOC_QOS_MODE_BYPASS) {
+		dev_dbg(qp->provider.dev, "NoC QoS[%i] (port %i): Set Bypass mode\n",
+			idx, qos->qos_port);
 		mode = NOC_QOS_MODE_BYPASS_VAL;
 	} else {
 		/* How did we get here? */
 	}
 
 	regmap_update_bits(qp->regmap,
-			   qp->qos_offset + NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
+			   qos_off + NOC_QOS_MODEn_ADDR(qos->qos_port),
 			   NOC_QOS_MODEn_MASK, mode);
 }
 
-static void qcom_icc_qos_set(struct icc_node *node)
+static void qcom_icc_qos_set(struct qcom_icc_provider *qp,
+			     const struct qcom_icc_desc *desc,
+			     int idx)
 {
-	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
-	struct qcom_icc_node *qn = node->data;
+	const struct qcom_icc_qos_data *qos = &desc->qos_data[idx];
+	unsigned int qos_off = desc->qos_offset;
 
-	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
+	dev_dbg(qp->provider.dev, "Setting QoS data[%i] (port %i)\n", idx, qos->qos_port);
+
+	/* Sanity check the QoS settings data */
+	if (WARN_ON_ONCE(qos->qos_mode == NOC_QOS_MODE_INVALID))
+		return;
 
 	switch (qp->type) {
 	case QCOM_ICC_BIMC:
-		qcom_icc_set_bimc_qos(node);
+		qcom_icc_set_bimc_qos(qp, qos, qos_off);
 		break;
 	case QCOM_ICC_QNOC:
-		qcom_icc_set_qnoc_qos(node);
+		qcom_icc_set_qnoc_qos(qp, qos, qos_off);
 		break;
 	default:
-		qcom_icc_set_noc_qos(node);
+		qcom_icc_set_noc_qos(qp, qos, qos_off, idx);
 		break;
 	}
 }
@@ -199,7 +194,8 @@ static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
 	int ret, rpm_ctx = 0;
 	u64 bw_bps;
 
-	if (qn->qos.ap_owned)
+	/* Some nodes are managed by another IP block(s) */
+	if (qn->ap_owned)
 		return 0;
 
 	for (rpm_ctx = 0; rpm_ctx < QCOM_SMD_RPM_STATE_NUM; rpm_ctx++) {
@@ -500,7 +496,6 @@ int qnoc_probe(struct platform_device *pdev)
 
 	qp->keep_alive = desc->keep_alive;
 	qp->type = desc->type;
-	qp->qos_offset = desc->qos_offset;
 
 	if (desc->regmap_cfg) {
 		struct resource *res;
@@ -574,15 +569,19 @@ int qnoc_probe(struct platform_device *pdev)
 		for (j = 0; j < qnodes[i]->num_links; j++)
 			icc_link_create(node, qnodes[i]->links[j]);
 
-		/* Set QoS registers (we only need to do it once, generally) */
-		if (qnodes[i]->qos.ap_owned &&
-		    qnodes[i]->qos.qos_mode != NOC_QOS_MODE_INVALID)
-			qcom_icc_qos_set(node);
-
 		data->nodes[i] = node;
 	}
 	data->num_nodes = num_nodes;
 
+	/*
+	 * Set QoS registers (we only need to do it once, generally).
+	 * Porting note: if a node has QoS data, but it's not marked as
+	 * ap_owned, it's likely an erronous artifact of some autogen tools,
+	 * ignore such config entries.
+	 */
+	for (i = 0; i < desc->qos_data_num; i++)
+		qcom_icc_qos_set(qp, desc, i);
+
 	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 
 	ret = icc_provider_register(provider);
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index f4883d43eae4..ecce8f8a75e6 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -43,7 +43,6 @@ struct rpm_clk_resource {
  * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
- * @qos_offset: offset to QoS registers
  * @ab_coeff: a percentage-based coefficient for compensating the AB calculations
  * @ib_coeff: an inverse-percentage-based coefficient for compensating the IB calculations
  * @bus_clk_rate: bus clock rate in Hz
@@ -58,7 +57,6 @@ struct qcom_icc_provider {
 	int num_intf_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
-	unsigned int qos_offset;
 	u16 ab_coeff;
 	u16 ib_coeff;
 	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
@@ -70,20 +68,18 @@ struct qcom_icc_provider {
 };
 
 /**
- * struct qcom_icc_qos - Qualcomm specific interconnect QoS parameters
+ * struct qcom_icc_qos_data - Qualcomm specific interconnect QoS parameters
  * @areq_prio: node requests priority
  * @prio_level: priority level for bus communication
  * @limit_commands: activate/deactivate limiter mode during runtime
- * @ap_owned: indicates if the node is owned by the AP or by the RPM
  * @qos_mode: default qos mode for this node
  * @qos_port: qos port number for finding qos registers of this node
  * @urg_fwd_en: enable urgent forwarding
  */
-struct qcom_icc_qos {
+struct qcom_icc_qos_data {
 	u32 areq_prio;
 	u32 prio_level;
 	bool limit_commands;
-	bool ap_owned;
 	int qos_mode;
 	int qos_port;
 	bool urg_fwd_en;
@@ -106,6 +102,7 @@ struct qcom_icc_qos {
  * @ab_coeff: a percentage-based coefficient for compensating the AB calculations
  * @ib_coeff: an inverse-percentage-based coefficient for compensating the IB calculations
  * @bus_clk_rate: a pointer to an array containing bus clock rates in Hz
+ * @ap_owned: indicates if the AP is expected to manage bandwidth on this node
  */
 struct qcom_icc_node {
 	unsigned char *name;
@@ -119,10 +116,10 @@ struct qcom_icc_node {
 	u64 max_peak[QCOM_SMD_RPM_STATE_NUM];
 	int mas_rpm_id;
 	int slv_rpm_id;
-	struct qcom_icc_qos qos;
 	u16 ab_coeff;
 	u16 ib_coeff;
 	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
+	bool ap_owned;
 };
 
 struct qcom_icc_desc {
@@ -134,6 +131,8 @@ struct qcom_icc_desc {
 	bool keep_alive;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
+	const struct qcom_icc_qos_data * const qos_data;
+	const u16 qos_data_num;
 	unsigned int qos_offset;
 	u16 ab_coeff;
 	u16 ib_coeff;
diff --git a/drivers/interconnect/qcom/msm8909.c b/drivers/interconnect/qcom/msm8909.c
index 0d0cd7282f5b..83460b3b6f1b 100644
--- a/drivers/interconnect/qcom/msm8909.c
+++ b/drivers/interconnect/qcom/msm8909.c
@@ -107,11 +107,7 @@ static struct qcom_icc_node mas_apps_proc = {
 	.buswidth = 8,
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_apps_proc_links),
 	.links = mas_apps_proc_links,
 };
@@ -127,11 +123,7 @@ static struct qcom_icc_node mas_oxili = {
 	.buswidth = 8,
 	.mas_rpm_id = 6,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_oxili_links),
 	.links = mas_oxili_links,
 };
@@ -146,10 +138,6 @@ static struct qcom_icc_node mas_snoc_bimc_0 = {
 	.buswidth = 8,
 	.mas_rpm_id = 3,
 	.slv_rpm_id = -1,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 3,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_0_links),
 	.links = mas_snoc_bimc_0_links,
 };
@@ -164,11 +152,7 @@ static struct qcom_icc_node mas_snoc_bimc_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = 76,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 4,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_1_links),
 	.links = mas_snoc_bimc_1_links,
 };
@@ -184,11 +168,7 @@ static struct qcom_icc_node mas_tcu_0 = {
 	.buswidth = 8,
 	.mas_rpm_id = 102,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 2,
-	.qos.qos_port = 5,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_tcu_0_links),
 	.links = mas_tcu_0_links,
 };
@@ -204,11 +184,7 @@ static struct qcom_icc_node mas_tcu_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = 103,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 2,
-	.qos.qos_port = 6,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_tcu_1_links),
 	.links = mas_tcu_1_links,
 };
@@ -307,11 +283,7 @@ static struct qcom_icc_node mas_crypto = {
 	.buswidth = 8,
 	.mas_rpm_id = 23,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_crypto_links),
 	.links = mas_crypto_links,
 };
@@ -326,10 +298,6 @@ static struct qcom_icc_node mas_sdcc_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = 33,
 	.slv_rpm_id = -1,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 7,
 	.num_links = ARRAY_SIZE(mas_sdcc_1_links),
 	.links = mas_sdcc_1_links,
 };
@@ -344,10 +312,6 @@ static struct qcom_icc_node mas_sdcc_2 = {
 	.buswidth = 8,
 	.mas_rpm_id = 35,
 	.slv_rpm_id = -1,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 8,
 	.num_links = ARRAY_SIZE(mas_sdcc_2_links),
 	.links = mas_sdcc_2_links,
 };
@@ -362,10 +326,6 @@ static struct qcom_icc_node mas_snoc_pcnoc = {
 	.buswidth = 8,
 	.mas_rpm_id = 77,
 	.slv_rpm_id = -1,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 9,
 	.num_links = ARRAY_SIZE(mas_snoc_pcnoc_links),
 	.links = mas_snoc_pcnoc_links,
 };
@@ -380,11 +340,7 @@ static struct qcom_icc_node mas_qdss_bam = {
 	.buswidth = 4,
 	.mas_rpm_id = 19,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 11,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
 	.links = mas_qdss_bam_links,
 };
@@ -415,11 +371,7 @@ static struct qcom_icc_node mas_mdp = {
 	.buswidth = 16,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 7,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mdp_links),
 	.links = mas_mdp_links,
 	.ab_coeff = 167,
@@ -437,10 +389,6 @@ static struct qcom_icc_node mas_pcnoc_snoc = {
 	.buswidth = 8,
 	.mas_rpm_id = 29,
 	.slv_rpm_id = -1,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 5,
 	.num_links = ARRAY_SIZE(mas_pcnoc_snoc_links),
 	.links = mas_pcnoc_snoc_links,
 };
@@ -456,11 +404,7 @@ static struct qcom_icc_node mas_venus = {
 	.buswidth = 16,
 	.mas_rpm_id = 9,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 8,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_venus_links),
 	.links = mas_venus_links,
 	.ab_coeff = 167,
@@ -477,11 +421,7 @@ static struct qcom_icc_node mas_vfe = {
 	.buswidth = 16,
 	.mas_rpm_id = 11,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 9,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_vfe_links),
 	.links = mas_vfe_links,
 	.ab_coeff = 167,
@@ -497,11 +437,7 @@ static struct qcom_icc_node mas_qdss_etr = {
 	.buswidth = 8,
 	.mas_rpm_id = 31,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 10,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
 	.links = mas_qdss_etr_links,
 };
@@ -516,10 +452,6 @@ static struct qcom_icc_node pcnoc_m_0 = {
 	.buswidth = 8,
 	.mas_rpm_id = 87,
 	.slv_rpm_id = 116,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 5,
 	.num_links = ARRAY_SIZE(pcnoc_m_0_links),
 	.links = pcnoc_m_0_links,
 };
@@ -534,10 +466,6 @@ static struct qcom_icc_node pcnoc_m_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = 88,
 	.slv_rpm_id = 117,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 6,
 	.num_links = ARRAY_SIZE(pcnoc_m_1_links),
 	.links = pcnoc_m_1_links,
 };
@@ -657,8 +585,7 @@ static struct qcom_icc_node pcnoc_s_4 = {
 	.buswidth = 4,
 	.mas_rpm_id = 93,
 	.slv_rpm_id = 122,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(pcnoc_s_4_links),
 	.links = pcnoc_s_4_links,
 };
@@ -704,8 +631,7 @@ static struct qcom_icc_node mm_int_0 = {
 	.buswidth = 16,
 	.mas_rpm_id = 79,
 	.slv_rpm_id = 108,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_0_links),
 	.links = mm_int_0_links,
 	.ab_coeff = 167,
@@ -721,8 +647,7 @@ static struct qcom_icc_node mm_int_1 = {
 	.buswidth = 16,
 	.mas_rpm_id = 80,
 	.slv_rpm_id = 109,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_1_links),
 	.links = mm_int_1_links,
 	.ab_coeff = 167,
@@ -738,8 +663,7 @@ static struct qcom_icc_node mm_int_2 = {
 	.buswidth = 16,
 	.mas_rpm_id = 81,
 	.slv_rpm_id = 110,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_2_links),
 	.links = mm_int_2_links,
 	.ab_coeff = 167,
@@ -755,8 +679,7 @@ static struct qcom_icc_node mm_int_bimc = {
 	.buswidth = 16,
 	.mas_rpm_id = 82,
 	.slv_rpm_id = 111,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_bimc_links),
 	.links = mm_int_bimc_links,
 	.ab_coeff = 167,
@@ -773,8 +696,7 @@ static struct qcom_icc_node qdss_int = {
 	.buswidth = 8,
 	.mas_rpm_id = 98,
 	.slv_rpm_id = 128,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(qdss_int_links),
 	.links = qdss_int_links,
 };
@@ -807,8 +729,7 @@ static struct qcom_icc_node snoc_int_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = 100,
 	.slv_rpm_id = 131,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(snoc_int_1_links),
 	.links = snoc_int_1_links,
 };
@@ -879,8 +800,7 @@ static struct qcom_icc_node slv_crypto_0_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 52,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_message_ram = {
@@ -905,8 +825,7 @@ static struct qcom_icc_node slv_prng = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 44,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_usb_hs = {
@@ -987,8 +906,7 @@ static struct qcom_icc_node slv_camera_ss_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 3,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_disp_ss_cfg = {
@@ -997,8 +915,7 @@ static struct qcom_icc_node slv_disp_ss_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_venus_cfg = {
@@ -1007,8 +924,7 @@ static struct qcom_icc_node slv_venus_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 10,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_tlmm = {
@@ -1025,8 +941,7 @@ static struct qcom_icc_node slv_gpu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 11,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_imem_cfg = {
@@ -1059,8 +974,7 @@ static struct qcom_icc_node slv_tcu = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 133,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static const u16 slv_pcnoc_snoc_links[] = {
@@ -1083,8 +997,7 @@ static struct qcom_icc_node slv_kpss_ahb = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 20,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static const u16 slv_snoc_bimc_0_links[] = {
@@ -1111,8 +1024,7 @@ static struct qcom_icc_node slv_snoc_bimc_1 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 104,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_snoc_bimc_1_links),
 	.links = slv_snoc_bimc_1_links,
 };
@@ -1153,8 +1065,7 @@ static struct qcom_icc_node slv_cats_0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 106,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_cats_1 = {
@@ -1163,8 +1074,7 @@ static struct qcom_icc_node slv_cats_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 107,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node * const msm8909_bimc_nodes[] = {
@@ -1178,6 +1088,44 @@ static struct qcom_icc_node * const msm8909_bimc_nodes[] = {
 	[SLV_BIMC_SNOC] = &slv_bimc_snoc,
 };
 
+static const struct qcom_icc_qos_data bimc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 5,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 2,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 2,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8909_bimc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -1192,6 +1140,8 @@ static const struct qcom_icc_desc msm8909_bimc = {
 	.num_nodes = ARRAY_SIZE(msm8909_bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8909_bimc_regmap_config,
+	.qos_data = bimc_qos_data,
+	.qos_data_num = ARRAY_SIZE(bimc_qos_data),
 	.qos_offset = 0x8000,
 	.ab_coeff = 154,
 };
@@ -1246,6 +1196,48 @@ static struct qcom_icc_node * const msm8909_pcnoc_nodes[] = {
 	[SLV_PCNOC_SNOC] = &slv_pcnoc_snoc,
 };
 
+static const struct qcom_icc_qos_data pcnoc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 5,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 7,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 8,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 9,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8909_pcnoc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -1260,6 +1252,8 @@ static const struct qcom_icc_desc msm8909_pcnoc = {
 	.num_nodes = ARRAY_SIZE(msm8909_pcnoc_nodes),
 	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8909_pcnoc_regmap_config,
+	.qos_data = pcnoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(pcnoc_qos_data),
 	.qos_offset = 0x7000,
 };
 
@@ -1289,6 +1283,40 @@ static struct qcom_icc_node * const msm8909_snoc_nodes[] = {
 	[SLV_CATS_1] = &slv_cats_1,
 };
 
+static const struct qcom_icc_qos_data snoc_qos_data[] = {
+	{
+		.qos_port = 5,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 7,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 8,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 9,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 10,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 11,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8909_snoc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -1303,6 +1331,8 @@ static const struct qcom_icc_desc msm8909_snoc = {
 	.num_nodes = ARRAY_SIZE(msm8909_snoc_nodes),
 	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8909_snoc_regmap_config,
+	.qos_data = snoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(snoc_qos_data),
 	.qos_offset = 0x7000,
 };
 
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 499b1a9ac413..7a8597824876 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -114,8 +114,7 @@ static struct qcom_icc_node bimc_snoc_mas = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(bimc_snoc_mas_links),
 	.links = bimc_snoc_mas_links,
 };
@@ -131,8 +130,7 @@ static struct qcom_icc_node bimc_snoc_slv = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(bimc_snoc_slv_links),
 	.links = bimc_snoc_slv_links,
 };
@@ -149,11 +147,7 @@ static struct qcom_icc_node mas_apss = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_apss_links),
 	.links = mas_apss_links,
 };
@@ -212,11 +206,7 @@ static struct qcom_icc_node mas_gfx = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_gfx_links),
 	.links = mas_gfx_links,
 };
@@ -232,11 +222,7 @@ static struct qcom_icc_node mas_jpeg = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 6,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_jpeg_links),
 	.links = mas_jpeg_links,
 };
@@ -252,11 +238,7 @@ static struct qcom_icc_node mas_mdp = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 7,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mdp_links),
 	.links = mas_mdp_links,
 };
@@ -313,11 +295,7 @@ static struct qcom_icc_node mas_qdss_bam = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 11,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
 	.links = mas_qdss_bam_links,
 };
@@ -332,11 +310,7 @@ static struct qcom_icc_node mas_qdss_etr = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 10,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
 	.links = mas_qdss_etr_links,
 };
@@ -381,11 +355,7 @@ static struct qcom_icc_node mas_tcu0 = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
-	.qos.prio_level = 2,
-	.qos.qos_port = 5,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_tcu0_links),
 	.links = mas_tcu0_links,
 };
@@ -402,11 +372,7 @@ static struct qcom_icc_node mas_tcu1 = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
-	.qos.prio_level = 2,
-	.qos.qos_port = 6,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_tcu1_links),
 	.links = mas_tcu1_links,
 };
@@ -436,11 +402,7 @@ static struct qcom_icc_node mas_vfe = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 9,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_vfe_links),
 	.links = mas_vfe_links,
 };
@@ -456,11 +418,7 @@ static struct qcom_icc_node mas_video = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 8,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_video_links),
 	.links = mas_video_links,
 };
@@ -475,8 +433,7 @@ static struct qcom_icc_node mm_int_0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_0_links),
 	.links = mm_int_0_links,
 };
@@ -491,8 +448,7 @@ static struct qcom_icc_node mm_int_1 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_1_links),
 	.links = mm_int_1_links,
 };
@@ -507,8 +463,7 @@ static struct qcom_icc_node mm_int_2 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_2_links),
 	.links = mm_int_2_links,
 };
@@ -523,8 +478,7 @@ static struct qcom_icc_node mm_int_bimc = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_bimc_links),
 	.links = mm_int_bimc_links,
 };
@@ -753,8 +707,7 @@ static struct qcom_icc_node qdss_int = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(qdss_int_links),
 	.links = qdss_int_links,
 };
@@ -1093,8 +1046,7 @@ static struct qcom_icc_node snoc_bimc_1_mas = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(snoc_bimc_1_mas_links),
 	.links = snoc_bimc_1_mas_links,
 };
@@ -1109,8 +1061,7 @@ static struct qcom_icc_node snoc_bimc_1_slv = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(snoc_bimc_1_slv_links),
 	.links = snoc_bimc_1_slv_links,
 };
@@ -1218,6 +1169,36 @@ static struct qcom_icc_node * const msm8916_snoc_nodes[] = {
 	[SNOC_QDSS_INT] = &qdss_int,
 };
 
+static const struct qcom_icc_qos_data snoc_qos_data[] = {
+	{
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 7,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 8,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 9,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 10,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 11,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8916_snoc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1232,6 +1213,8 @@ static const struct qcom_icc_desc msm8916_snoc = {
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
 	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8916_snoc_regmap_config,
+	.qos_data = snoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(snoc_qos_data),
 	.qos_offset = 0x7000,
 };
 
@@ -1247,6 +1230,38 @@ static struct qcom_icc_node * const msm8916_bimc_nodes[] = {
 	[SNOC_BIMC_1_SLV] = &snoc_bimc_1_slv,
 };
 
+static const struct qcom_icc_qos_data bimc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 5,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 2,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 2,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8916_bimc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1261,6 +1276,8 @@ static const struct qcom_icc_desc msm8916_bimc = {
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8916_bimc_regmap_config,
+	.qos_data = bimc_qos_data,
+	.qos_data_num = ARRAY_SIZE(bimc_qos_data),
 	.qos_offset = 0x8000,
 };
 
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index 8ff2c23b1ca0..b9de8d61a1f4 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -119,8 +119,7 @@ static struct qcom_icc_node bimc_snoc_mas = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(bimc_snoc_mas_links),
 	.links = bimc_snoc_mas_links,
 };
@@ -152,11 +151,7 @@ static struct qcom_icc_node mas_apss = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_apss_links),
 	.links = mas_apss_links,
 };
@@ -215,11 +210,7 @@ static struct qcom_icc_node mas_gfx = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_gfx_links),
 	.links = mas_gfx_links,
 };
@@ -235,11 +226,7 @@ static struct qcom_icc_node mas_jpeg = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 6,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_jpeg_links),
 	.links = mas_jpeg_links,
 };
@@ -255,11 +242,7 @@ static struct qcom_icc_node mas_mdp0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 7,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mdp0_links),
 	.links = mas_mdp0_links,
 };
@@ -275,11 +258,7 @@ static struct qcom_icc_node mas_mdp1 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 13,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mdp1_links),
 	.links = mas_mdp1_links,
 };
@@ -295,11 +274,7 @@ static struct qcom_icc_node mas_cpp = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 12,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_cpp_links),
 	.links = mas_cpp_links,
 };
@@ -356,11 +331,7 @@ static struct qcom_icc_node mas_qdss_bam = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 11,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
 	.links = mas_qdss_bam_links,
 };
@@ -375,11 +346,7 @@ static struct qcom_icc_node mas_qdss_etr = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 10,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
 	.links = mas_qdss_etr_links,
 };
@@ -424,11 +391,7 @@ static struct qcom_icc_node mas_tcu0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
-	.qos.prio_level = 2,
-	.qos.qos_port = 6,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_tcu0_links),
 	.links = mas_tcu0_links,
 };
@@ -472,11 +435,7 @@ static struct qcom_icc_node mas_vfe = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 9,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_vfe_links),
 	.links = mas_vfe_links,
 };
@@ -492,11 +451,7 @@ static struct qcom_icc_node mas_video = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 8,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_video_links),
 	.links = mas_video_links,
 };
@@ -511,8 +466,7 @@ static struct qcom_icc_node mm_int_0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_0_links),
 	.links = mm_int_0_links,
 };
@@ -527,8 +481,7 @@ static struct qcom_icc_node mm_int_1 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_1_links),
 	.links = mm_int_1_links,
 };
@@ -543,8 +496,7 @@ static struct qcom_icc_node mm_int_2 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mm_int_2_links),
 	.links = mm_int_2_links,
 };
@@ -773,8 +725,7 @@ static struct qcom_icc_node qdss_int = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(qdss_int_links),
 	.links = qdss_int_links,
 };
@@ -1093,8 +1044,7 @@ static struct qcom_icc_node snoc_bimc_0_mas = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(snoc_bimc_0_mas_links),
 	.links = snoc_bimc_0_mas_links,
 };
@@ -1109,8 +1059,7 @@ static struct qcom_icc_node snoc_bimc_0_slv = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(snoc_bimc_0_slv_links),
 	.links = snoc_bimc_0_slv_links,
 };
@@ -1153,8 +1102,7 @@ static struct qcom_icc_node snoc_bimc_2_mas = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(snoc_bimc_2_mas_links),
 	.links = snoc_bimc_2_mas_links,
 };
@@ -1169,8 +1117,7 @@ static struct qcom_icc_node snoc_bimc_2_slv = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(snoc_bimc_2_slv_links),
 	.links = snoc_bimc_2_slv_links,
 };
@@ -1271,6 +1218,24 @@ static struct qcom_icc_node * const msm8939_snoc_nodes[] = {
 	[SNOC_QDSS_INT] = &qdss_int,
 };
 
+static const struct qcom_icc_qos_data snoc_qos_data[] = {
+	{
+		.qos_port = 10,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 11,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8939_snoc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1285,6 +1250,8 @@ static const struct qcom_icc_desc msm8939_snoc = {
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
 	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8939_snoc_regmap_config,
+	.qos_data = snoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(snoc_qos_data),
 	.qos_offset = 0x7000,
 };
 
@@ -1300,12 +1267,36 @@ static struct qcom_icc_node * const msm8939_snoc_mm_nodes[] = {
 	[SNOC_MM_INT_2] = &mm_int_2,
 };
 
+static const struct qcom_icc_qos_data snoc_mm_qos_data[] = {
+	{
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 7,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 8,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 9,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 12,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 13,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	},
+};
+
 static const struct qcom_icc_desc msm8939_snoc_mm = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_mm_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
 	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &msm8939_snoc_regmap_config,
+	.qos_data = snoc_mm_qos_data,
+	.qos_data_num = ARRAY_SIZE(snoc_mm_qos_data),
 	.qos_offset = 0x7000,
 };
 
@@ -1321,6 +1312,24 @@ static struct qcom_icc_node * const msm8939_bimc_nodes[] = {
 	[SNOC_BIMC_2_SLV] = &snoc_bimc_2_slv,
 };
 
+static const struct qcom_icc_qos_data bimc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 2,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8939_bimc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1335,6 +1344,8 @@ static const struct qcom_icc_desc msm8939_bimc = {
 	.num_nodes = ARRAY_SIZE(msm8939_bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8939_bimc_regmap_config,
+	.qos_data = bimc_qos_data,
+	.qos_data_num = ARRAY_SIZE(bimc_qos_data),
 	.qos_offset = 0x8000,
 };
 
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 788131400cd1..96c8ea8edd7a 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -43,11 +43,7 @@ static struct qcom_icc_node mas_pcie_0 = {
 	.buswidth = 8,
 	.mas_rpm_id = 65,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a0noc_common_links),
 	.links = mas_a0noc_common_links
 };
@@ -58,11 +54,7 @@ static struct qcom_icc_node mas_pcie_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = 66,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a0noc_common_links),
 	.links = mas_a0noc_common_links
 };
@@ -73,11 +65,7 @@ static struct qcom_icc_node mas_pcie_2 = {
 	.buswidth = 8,
 	.mas_rpm_id = 119,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a0noc_common_links),
 	.links = mas_a0noc_common_links
 };
@@ -92,8 +80,7 @@ static struct qcom_icc_node mas_cnoc_a1noc = {
 	.buswidth = 8,
 	.mas_rpm_id = 116,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a1noc_common_links),
 	.links = mas_a1noc_common_links
 };
@@ -104,11 +91,7 @@ static struct qcom_icc_node mas_crypto_c0 = {
 	.buswidth = 8,
 	.mas_rpm_id = 23,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a1noc_common_links),
 	.links = mas_a1noc_common_links
 };
@@ -119,11 +102,7 @@ static struct qcom_icc_node mas_pnoc_a1noc = {
 	.buswidth = 8,
 	.mas_rpm_id = 117,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 1,
+	.ap_owned = false,
 	.num_links = ARRAY_SIZE(mas_a1noc_common_links),
 	.links = mas_a1noc_common_links
 };
@@ -138,11 +117,7 @@ static struct qcom_icc_node mas_usb3 = {
 	.buswidth = 8,
 	.mas_rpm_id = 32,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 3,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a2noc_common_links),
 	.links = mas_a2noc_common_links
 };
@@ -153,11 +128,7 @@ static struct qcom_icc_node mas_ipa = {
 	.buswidth = 8,
 	.mas_rpm_id = 59,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a2noc_common_links),
 	.links = mas_a2noc_common_links
 };
@@ -168,11 +139,7 @@ static struct qcom_icc_node mas_ufs = {
 	.buswidth = 8,
 	.mas_rpm_id = 68,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a2noc_common_links),
 	.links = mas_a2noc_common_links
 };
@@ -189,11 +156,7 @@ static struct qcom_icc_node mas_apps_proc = {
 	.buswidth = 8,
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_apps_proc_links),
 	.links = mas_apps_proc_links
 };
@@ -211,11 +174,7 @@ static struct qcom_icc_node mas_oxili = {
 	.buswidth = 8,
 	.mas_rpm_id = 6,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_oxili_common_links),
 	.links = mas_oxili_common_links
 };
@@ -226,11 +185,7 @@ static struct qcom_icc_node mas_mnoc_bimc = {
 	.buswidth = 8,
 	.mas_rpm_id = 2,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_oxili_common_links),
 	.links = mas_oxili_common_links
 };
@@ -246,11 +201,7 @@ static struct qcom_icc_node mas_snoc_bimc = {
 	.buswidth = 8,
 	.mas_rpm_id = 3,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = false,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = -1,
+	.ap_owned = false,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_links),
 	.links = mas_snoc_bimc_links
 };
@@ -352,8 +303,7 @@ static struct qcom_icc_node mas_qdss_dap = {
 	.buswidth = 8,
 	.mas_rpm_id = 49,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_dap_links),
 	.links = mas_qdss_dap_links
 };
@@ -388,8 +338,7 @@ static struct qcom_icc_node mas_cnoc_mnoc_mmss_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = 4,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_cnoc_mnoc_mmss_cfg_links),
 	.links = mas_cnoc_mnoc_mmss_cfg_links
 };
@@ -404,8 +353,7 @@ static struct qcom_icc_node mas_cnoc_mnoc_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = 5,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_cnoc_mnoc_cfg_links),
 	.links = mas_cnoc_mnoc_cfg_links
 };
@@ -420,11 +368,7 @@ static struct qcom_icc_node mas_cpp = {
 	.buswidth = 32,
 	.mas_rpm_id = 115,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 5,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_common_links),
 	.links = mas_mnoc_bimc_common_links
 };
@@ -435,11 +379,7 @@ static struct qcom_icc_node mas_jpeg = {
 	.buswidth = 32,
 	.mas_rpm_id = 7,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 7,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_common_links),
 	.links = mas_mnoc_bimc_common_links
 };
@@ -451,11 +391,7 @@ static struct qcom_icc_node mas_mdp_p0 = {
 	.ib_coeff = 25,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_common_links),
 	.links = mas_mnoc_bimc_common_links
 };
@@ -467,11 +403,7 @@ static struct qcom_icc_node mas_mdp_p1 = {
 	.ib_coeff = 25,
 	.mas_rpm_id = 61,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_common_links),
 	.links = mas_mnoc_bimc_common_links
 };
@@ -482,11 +414,7 @@ static struct qcom_icc_node mas_rotator = {
 	.buswidth = 32,
 	.mas_rpm_id = 120,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_common_links),
 	.links = mas_mnoc_bimc_common_links
 };
@@ -497,11 +425,7 @@ static struct qcom_icc_node mas_venus = {
 	.buswidth = 32,
 	.mas_rpm_id = 9,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 3,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_common_links),
 	.links = mas_mnoc_bimc_common_links
 };
@@ -512,11 +436,7 @@ static struct qcom_icc_node mas_vfe = {
 	.buswidth = 32,
 	.mas_rpm_id = 11,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 6,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_common_links),
 	.links = mas_mnoc_bimc_common_links
 };
@@ -531,8 +451,7 @@ static struct qcom_icc_node mas_snoc_vmem = {
 	.buswidth = 32,
 	.mas_rpm_id = 114,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_vmem_common_links),
 	.links = mas_vmem_common_links
 };
@@ -543,8 +462,7 @@ static struct qcom_icc_node mas_venus_vmem = {
 	.buswidth = 32,
 	.mas_rpm_id = 121,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_vmem_common_links),
 	.links = mas_vmem_common_links
 };
@@ -656,11 +574,7 @@ static struct qcom_icc_node mas_hmss = {
 	.buswidth = 8,
 	.mas_rpm_id = 118,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 4,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_hmss_links),
 	.links = mas_hmss_links
 };
@@ -679,11 +593,7 @@ static struct qcom_icc_node mas_qdss_bam = {
 	.buswidth = 16,
 	.mas_rpm_id = 19,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_common_links),
 	.links = mas_qdss_common_links
 };
@@ -698,8 +608,7 @@ static struct qcom_icc_node mas_snoc_cfg = {
 	.buswidth = 16,
 	.mas_rpm_id = 20,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_snoc_cfg_links),
 	.links = mas_snoc_cfg_links
 };
@@ -722,8 +631,7 @@ static struct qcom_icc_node mas_bimc_snoc_0 = {
 	.buswidth = 16,
 	.mas_rpm_id = 21,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_bimc_snoc_0_links),
 	.links = mas_bimc_snoc_0_links
 };
@@ -740,8 +648,7 @@ static struct qcom_icc_node mas_bimc_snoc_1 = {
 	.buswidth = 16,
 	.mas_rpm_id = 109,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_bimc_snoc_1_links),
 	.links = mas_bimc_snoc_1_links
 };
@@ -760,8 +667,7 @@ static struct qcom_icc_node mas_a0noc_snoc = {
 	.buswidth = 16,
 	.mas_rpm_id = 110,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_a0noc_snoc_links),
 	.links = mas_a0noc_snoc_links
 };
@@ -823,11 +729,7 @@ static struct qcom_icc_node mas_qdss_etr = {
 	.buswidth = 16,
 	.mas_rpm_id = 31,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 3,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_common_links),
 	.links = mas_qdss_common_links
 };
@@ -842,8 +744,7 @@ static struct qcom_icc_node slv_a0noc_snoc = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 141,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_a0noc_snoc_links),
 	.links = slv_a0noc_snoc_links
 };
@@ -902,8 +803,7 @@ static struct qcom_icc_node slv_bimc_snoc_0 = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 2,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_bimc_snoc_0_links),
 	.links = slv_bimc_snoc_0_links
 };
@@ -918,8 +818,7 @@ static struct qcom_icc_node slv_bimc_snoc_1 = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 138,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_bimc_snoc_1_links),
 	.links = slv_bimc_snoc_1_links
 };
@@ -934,8 +833,7 @@ static struct qcom_icc_node slv_cnoc_a1noc = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 75,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_cnoc_a1noc_links),
 	.links = slv_cnoc_a1noc_links
 };
@@ -970,8 +868,7 @@ static struct qcom_icc_node slv_crypto0_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 52,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_mpm = {
@@ -980,8 +877,7 @@ static struct qcom_icc_node slv_mpm = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 62,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pimem_cfg = {
@@ -990,8 +886,7 @@ static struct qcom_icc_node slv_pimem_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 167,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_imem_cfg = {
@@ -1000,8 +895,7 @@ static struct qcom_icc_node slv_imem_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 54,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_message_ram = {
@@ -1018,8 +912,7 @@ static struct qcom_icc_node slv_bimc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 56,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pmic_arb = {
@@ -1036,8 +929,7 @@ static struct qcom_icc_node slv_prng = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 127,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_dcc_cfg = {
@@ -1046,8 +938,7 @@ static struct qcom_icc_node slv_dcc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 155,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_rbcpr_mx = {
@@ -1056,8 +947,7 @@ static struct qcom_icc_node slv_rbcpr_mx = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 170,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_qdss_cfg = {
@@ -1066,8 +956,7 @@ static struct qcom_icc_node slv_qdss_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 63,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_rbcpr_cx = {
@@ -1076,8 +965,7 @@ static struct qcom_icc_node slv_rbcpr_cx = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 169,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_cpu_apu_cfg = {
@@ -1086,8 +974,7 @@ static struct qcom_icc_node slv_cpu_apu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 168,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static const u16 slv_cnoc_mnoc_cfg_links[] = {
@@ -1100,8 +987,7 @@ static struct qcom_icc_node slv_cnoc_mnoc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 66,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_cfg_links),
 	.links = slv_cnoc_mnoc_cfg_links
 };
@@ -1112,8 +998,7 @@ static struct qcom_icc_node slv_snoc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 70,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_snoc_mpu_cfg = {
@@ -1122,8 +1007,7 @@ static struct qcom_icc_node slv_snoc_mpu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 67,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_ebi1_phy_cfg = {
@@ -1132,8 +1016,7 @@ static struct qcom_icc_node slv_ebi1_phy_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 73,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a0noc_cfg = {
@@ -1142,8 +1025,7 @@ static struct qcom_icc_node slv_a0noc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 144,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pcie_1_cfg = {
@@ -1152,8 +1034,7 @@ static struct qcom_icc_node slv_pcie_1_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 89,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pcie_2_cfg = {
@@ -1162,8 +1043,7 @@ static struct qcom_icc_node slv_pcie_2_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 165,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pcie_0_cfg = {
@@ -1172,8 +1052,7 @@ static struct qcom_icc_node slv_pcie_0_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 88,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pcie20_ahb2phy = {
@@ -1182,8 +1061,7 @@ static struct qcom_icc_node slv_pcie20_ahb2phy = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 163,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a0noc_mpu_cfg = {
@@ -1192,8 +1070,7 @@ static struct qcom_icc_node slv_a0noc_mpu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 145,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_ufs_cfg = {
@@ -1202,8 +1079,7 @@ static struct qcom_icc_node slv_ufs_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 92,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a1noc_cfg = {
@@ -1212,8 +1088,7 @@ static struct qcom_icc_node slv_a1noc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 147,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a1noc_mpu_cfg = {
@@ -1222,8 +1097,7 @@ static struct qcom_icc_node slv_a1noc_mpu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 148,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a2noc_cfg = {
@@ -1232,8 +1106,7 @@ static struct qcom_icc_node slv_a2noc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 150,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a2noc_mpu_cfg = {
@@ -1242,8 +1115,7 @@ static struct qcom_icc_node slv_a2noc_mpu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 151,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_ssc_cfg = {
@@ -1252,8 +1124,7 @@ static struct qcom_icc_node slv_ssc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 177,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a0noc_smmu_cfg = {
@@ -1262,8 +1133,7 @@ static struct qcom_icc_node slv_a0noc_smmu_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 146,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a1noc_smmu_cfg = {
@@ -1272,8 +1142,7 @@ static struct qcom_icc_node slv_a1noc_smmu_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 149,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a2noc_smmu_cfg = {
@@ -1282,8 +1151,7 @@ static struct qcom_icc_node slv_a2noc_smmu_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 152,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_lpass_smmu_cfg = {
@@ -1292,8 +1160,7 @@ static struct qcom_icc_node slv_lpass_smmu_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 161,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static const u16 slv_cnoc_mnoc_mmss_cfg_links[] = {
@@ -1306,8 +1173,7 @@ static struct qcom_icc_node slv_cnoc_mnoc_mmss_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 58,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_mmss_cfg_links),
 	.links = slv_cnoc_mnoc_mmss_cfg_links
 };
@@ -1318,8 +1184,7 @@ static struct qcom_icc_node slv_mmagic_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 162,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_cpr_cfg = {
@@ -1328,8 +1193,7 @@ static struct qcom_icc_node slv_cpr_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 6,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_misc_cfg = {
@@ -1338,8 +1202,7 @@ static struct qcom_icc_node slv_misc_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 8,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_venus_throttle_cfg = {
@@ -1348,8 +1211,7 @@ static struct qcom_icc_node slv_venus_throttle_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 178,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_venus_cfg = {
@@ -1358,8 +1220,7 @@ static struct qcom_icc_node slv_venus_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 10,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_vmem_cfg = {
@@ -1368,8 +1229,7 @@ static struct qcom_icc_node slv_vmem_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 180,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_dsa_cfg = {
@@ -1378,8 +1238,7 @@ static struct qcom_icc_node slv_dsa_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 157,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_mnoc_clocks_cfg = {
@@ -1388,8 +1247,7 @@ static struct qcom_icc_node slv_mnoc_clocks_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 12,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_dsa_mpu_cfg = {
@@ -1398,8 +1256,7 @@ static struct qcom_icc_node slv_dsa_mpu_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 158,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_mnoc_mpu_cfg = {
@@ -1408,8 +1265,7 @@ static struct qcom_icc_node slv_mnoc_mpu_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 14,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_display_cfg = {
@@ -1418,8 +1274,7 @@ static struct qcom_icc_node slv_display_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_display_throttle_cfg = {
@@ -1428,8 +1283,7 @@ static struct qcom_icc_node slv_display_throttle_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 156,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_camera_cfg = {
@@ -1438,8 +1292,7 @@ static struct qcom_icc_node slv_camera_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 3,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_camera_throttle_cfg = {
@@ -1448,8 +1301,7 @@ static struct qcom_icc_node slv_camera_throttle_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 154,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_oxili_cfg = {
@@ -1458,8 +1310,7 @@ static struct qcom_icc_node slv_oxili_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 11,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_smmu_mdp_cfg = {
@@ -1468,8 +1319,7 @@ static struct qcom_icc_node slv_smmu_mdp_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 173,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_smmu_rot_cfg = {
@@ -1478,8 +1328,7 @@ static struct qcom_icc_node slv_smmu_rot_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 174,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_smmu_venus_cfg = {
@@ -1488,8 +1337,7 @@ static struct qcom_icc_node slv_smmu_venus_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 175,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_smmu_cpp_cfg = {
@@ -1498,8 +1346,7 @@ static struct qcom_icc_node slv_smmu_cpp_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 171,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_smmu_jpeg_cfg = {
@@ -1508,8 +1355,7 @@ static struct qcom_icc_node slv_smmu_jpeg_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 172,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_smmu_vfe_cfg = {
@@ -1518,8 +1364,7 @@ static struct qcom_icc_node slv_smmu_vfe_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 176,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static const u16 slv_mnoc_bimc_links[] = {
@@ -1532,8 +1377,7 @@ static struct qcom_icc_node slv_mnoc_bimc = {
 	.buswidth = 32,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 16,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_mnoc_bimc_links),
 	.links = slv_mnoc_bimc_links
 };
@@ -1544,8 +1388,7 @@ static struct qcom_icc_node slv_vmem = {
 	.buswidth = 32,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 179,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_srvc_mnoc = {
@@ -1554,8 +1397,7 @@ static struct qcom_icc_node slv_srvc_mnoc = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 17,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static const u16 slv_pnoc_a1noc_links[] = {
@@ -1642,8 +1484,7 @@ static struct qcom_icc_node slv_ahb2phy = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 153,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_hmss = {
@@ -1652,8 +1493,7 @@ static struct qcom_icc_node slv_hmss = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 20,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_lpass = {
@@ -1662,8 +1502,7 @@ static struct qcom_icc_node slv_lpass = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 21,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_usb3 = {
@@ -1672,8 +1511,7 @@ static struct qcom_icc_node slv_usb3 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 22,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static const u16 slv_snoc_bimc_links[] = {
@@ -1730,8 +1568,7 @@ static struct qcom_icc_node slv_snoc_vmem = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 140,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_snoc_vmem_links),
 	.links = slv_snoc_vmem_links
 };
@@ -1764,8 +1601,7 @@ static struct qcom_icc_node slv_pcie_0 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 84,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pcie_1 = {
@@ -1774,8 +1610,7 @@ static struct qcom_icc_node slv_pcie_1 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 85,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pcie_2 = {
@@ -1784,8 +1619,7 @@ static struct qcom_icc_node slv_pcie_2 = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 164,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_srvc_snoc = {
@@ -1794,8 +1628,7 @@ static struct qcom_icc_node slv_srvc_snoc = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 29,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node * const a0noc_nodes[] = {
@@ -1804,6 +1637,31 @@ static struct qcom_icc_node * const a0noc_nodes[] = {
 	[MASTER_PCIE_2] = &mas_pcie_2
 };
 
+static const struct qcom_icc_qos_data a0noc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8996_a0noc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1818,7 +1676,9 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
 	.intf_clocks = a0noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
-	.regmap_cfg = &msm8996_a0noc_regmap_config
+	.regmap_cfg = &msm8996_a0noc_regmap_config,
+	.qos_data = a0noc_qos_data,
+	.qos_data_num = ARRAY_SIZE(a0noc_qos_data),
 };
 
 static struct qcom_icc_node * const a1noc_nodes[] = {
@@ -1827,6 +1687,24 @@ static struct qcom_icc_node * const a1noc_nodes[] = {
 	[MASTER_PNOC_A1NOC] = &mas_pnoc_a1noc
 };
 
+static const struct qcom_icc_qos_data a1noc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8996_a1noc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1840,7 +1718,9 @@ static const struct qcom_icc_desc msm8996_a1noc = {
 	.nodes = a1noc_nodes,
 	.num_nodes = ARRAY_SIZE(a1noc_nodes),
 	.bus_clk_desc = &aggre1_branch_clk,
-	.regmap_cfg = &msm8996_a1noc_regmap_config
+	.regmap_cfg = &msm8996_a1noc_regmap_config,
+	.qos_data = a1noc_qos_data,
+	.qos_data_num = ARRAY_SIZE(a1noc_qos_data),
 };
 
 static struct qcom_icc_node * const a2noc_nodes[] = {
@@ -1849,6 +1729,24 @@ static struct qcom_icc_node * const a2noc_nodes[] = {
 	[MASTER_UFS] = &mas_ufs
 };
 
+static const struct qcom_icc_qos_data a2noc_qos_data[] = {
+	{
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8996_a2noc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1864,7 +1762,9 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.bus_clk_desc = &aggre2_branch_clk,
 	.intf_clocks = a2noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
-	.regmap_cfg = &msm8996_a2noc_regmap_config
+	.regmap_cfg = &msm8996_a2noc_regmap_config,
+	.qos_data = a2noc_qos_data,
+	.qos_data_num = ARRAY_SIZE(a2noc_qos_data),
 };
 
 static struct qcom_icc_node * const bimc_nodes[] = {
@@ -1878,6 +1778,23 @@ static struct qcom_icc_node * const bimc_nodes[] = {
 	[SLAVE_BIMC_SNOC_1] = &slv_bimc_snoc_1
 };
 
+static const struct qcom_icc_qos_data bimc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	},
+};
+
 static const struct regmap_config msm8996_bimc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1892,6 +1809,8 @@ static const struct qcom_icc_desc msm8996_bimc = {
 	.num_nodes = ARRAY_SIZE(bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8996_bimc_regmap_config,
+	.qos_data = bimc_qos_data,
+	.qos_data_num = ARRAY_SIZE(bimc_qos_data),
 	.ab_coeff = 154,
 };
 
@@ -1992,6 +1911,31 @@ static struct qcom_icc_node * const mnoc_nodes[] = {
 	[SLAVE_SMMU_VFE_CFG] = &slv_smmu_vfe_cfg
 };
 
+static const struct qcom_icc_qos_data mnoc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 5,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 7,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	},
+};
+
 static const struct regmap_config msm8996_mnoc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -2008,6 +1952,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &msm8996_mnoc_regmap_config,
+	.qos_data = mnoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(mnoc_qos_data),
 	.ab_coeff = 154,
 };
 
@@ -2077,6 +2023,31 @@ static struct qcom_icc_node * const snoc_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &slv_srvc_snoc
 };
 
+static const struct qcom_icc_qos_data snoc_qos_data[] = {
+	{
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config msm8996_snoc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -2090,7 +2061,9 @@ static const struct qcom_icc_desc msm8996_snoc = {
 	.nodes = snoc_nodes,
 	.num_nodes = ARRAY_SIZE(snoc_nodes),
 	.bus_clk_desc = &bus_1_clk,
-	.regmap_cfg = &msm8996_snoc_regmap_config
+	.regmap_cfg = &msm8996_snoc_regmap_config,
+	.qos_data = snoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(snoc_qos_data),
 };
 
 static const struct of_device_id qnoc_of_match[] = {
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index ba4cc08684d6..4b43b24e7f58 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -107,11 +107,7 @@ static struct qcom_icc_node mas_appss_proc = {
 	.id = QCM2290_MASTER_APPSS_PROC,
 	.name = "mas_apps_proc",
 	.buswidth = 16,
-	.qos.ap_owned = true,
-	.qos.qos_port = 0,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.prio_level = 0,
-	.qos.areq_prio = 0,
+	.ap_owned = true,
 	.bus_clk_desc = &mem_1_clk,
 	.ab_coeff = 159,
 	.ib_coeff = 96,
@@ -129,9 +125,7 @@ static struct qcom_icc_node mas_snoc_bimc_rt = {
 	.id = QCM2290_MASTER_SNOC_BIMC_RT,
 	.name = "mas_snoc_bimc_rt",
 	.buswidth = 16,
-	.qos.ap_owned = true,
-	.qos.qos_port = 2,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.ap_owned = true,
 	.mas_rpm_id = 163,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_rt_links),
@@ -146,9 +140,7 @@ static struct qcom_icc_node mas_snoc_bimc_nrt = {
 	.id = QCM2290_MASTER_SNOC_BIMC_NRT,
 	.name = "mas_snoc_bimc_nrt",
 	.buswidth = 16,
-	.qos.ap_owned = true,
-	.qos.qos_port = 3,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.ap_owned = true,
 	.mas_rpm_id = 164,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_nrt_links),
@@ -163,9 +155,7 @@ static struct qcom_icc_node mas_snoc_bimc = {
 	.id = QCM2290_MASTER_SNOC_BIMC,
 	.name = "mas_snoc_bimc",
 	.buswidth = 16,
-	.qos.ap_owned = true,
-	.qos.qos_port = 6,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.ap_owned = true,
 	.mas_rpm_id = 164,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_bimc_links),
@@ -181,11 +171,7 @@ static struct qcom_icc_node mas_tcu_0 = {
 	.id = QCM2290_MASTER_TCU_0,
 	.name = "mas_tcu_0",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 4,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.prio_level = 6,
-	.qos.areq_prio = 6,
+	.ap_owned = true,
 	.mas_rpm_id = 102,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_tcu_0_links),
@@ -232,8 +218,7 @@ static struct qcom_icc_node mas_snoc_cnoc = {
 	.id = QCM2290_MASTER_SNOC_CNOC,
 	.name = "mas_snoc_cnoc",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = 52,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_cnoc_links),
@@ -280,8 +265,7 @@ static struct qcom_icc_node mas_qdss_dap = {
 	.id = QCM2290_MASTER_QDSS_DAP,
 	.name = "mas_qdss_dap",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = 49,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_qdss_dap_links),
@@ -296,10 +280,7 @@ static struct qcom_icc_node mas_crypto_core0 = {
 	.id = QCM2290_MASTER_CRYPTO_CORE0,
 	.name = "mas_crypto_core0",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 22,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 23,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_crypto_core0_links),
@@ -328,10 +309,7 @@ static struct qcom_icc_node mas_camnoc_sf = {
 	.id = QCM2290_MASTER_CAMNOC_SF,
 	.name = "mas_camnoc_sf",
 	.buswidth = 32,
-	.qos.ap_owned = true,
-	.qos.qos_port = 4,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 3,
+	.ap_owned = true,
 	.mas_rpm_id = 172,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_camnoc_sf_links),
@@ -346,11 +324,7 @@ static struct qcom_icc_node mas_camnoc_hf = {
 	.id = QCM2290_MASTER_CAMNOC_HF,
 	.name = "mas_camnoc_hf",
 	.buswidth = 32,
-	.qos.ap_owned = true,
-	.qos.qos_port = 10,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 3,
-	.qos.urg_fwd_en = true,
+	.ap_owned = true,
 	.mas_rpm_id = 173,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_camnoc_hf_links),
@@ -365,11 +339,7 @@ static struct qcom_icc_node mas_mdp0 = {
 	.id = QCM2290_MASTER_MDP0,
 	.name = "mas_mdp0",
 	.buswidth = 16,
-	.qos.ap_owned = true,
-	.qos.qos_port = 5,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 3,
-	.qos.urg_fwd_en = true,
+	.ap_owned = true,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_mdp0_links),
@@ -384,11 +354,7 @@ static struct qcom_icc_node mas_video_p0 = {
 	.id = QCM2290_MASTER_VIDEO_P0,
 	.name = "mas_video_p0",
 	.buswidth = 16,
-	.qos.ap_owned = true,
-	.qos.qos_port = 9,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 3,
-	.qos.urg_fwd_en = true,
+	.ap_owned = true,
 	.mas_rpm_id = 9,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_video_p0_links),
@@ -403,10 +369,7 @@ static struct qcom_icc_node mas_video_proc = {
 	.id = QCM2290_MASTER_VIDEO_PROC,
 	.name = "mas_video_proc",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 13,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 4,
+	.ap_owned = true,
 	.mas_rpm_id = 168,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_video_proc_links),
@@ -421,8 +384,7 @@ static struct qcom_icc_node mas_snoc_cfg = {
 	.id = QCM2290_MASTER_SNOC_CFG,
 	.name = "mas_snoc_cfg",
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = 20,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_snoc_cfg_links),
@@ -443,10 +405,7 @@ static struct qcom_icc_node mas_tic = {
 	.id = QCM2290_MASTER_TIC,
 	.name = "mas_tic",
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_port = 8,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 51,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_tic_links),
@@ -501,10 +460,7 @@ static struct qcom_icc_node mas_pimem = {
 	.id = QCM2290_MASTER_PIMEM,
 	.name = "mas_pimem",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 20,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 113,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_pimem_links),
@@ -519,10 +475,7 @@ static struct qcom_icc_node mas_qdss_bam = {
 	.id = QCM2290_MASTER_QDSS_BAM,
 	.name = "mas_qdss_bam",
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_port = 2,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 19,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
@@ -537,10 +490,7 @@ static struct qcom_icc_node mas_qup_0 = {
 	.id = QCM2290_MASTER_QUP_0,
 	.name = "mas_qup_0",
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_port = 0,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 166,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_qup_0_links),
@@ -555,10 +505,7 @@ static struct qcom_icc_node mas_ipa = {
 	.id = QCM2290_MASTER_IPA,
 	.name = "mas_ipa",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 3,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 59,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_ipa_links),
@@ -573,10 +520,7 @@ static struct qcom_icc_node mas_qdss_etr = {
 	.id = QCM2290_MASTER_QDSS_ETR,
 	.name = "mas_qdss_etr",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 12,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 31,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
@@ -591,10 +535,7 @@ static struct qcom_icc_node mas_sdcc_1 = {
 	.id = QCM2290_MASTER_SDCC_1,
 	.name = "mas_sdcc_1",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 17,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 33,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_sdcc_1_links),
@@ -609,10 +550,7 @@ static struct qcom_icc_node mas_sdcc_2 = {
 	.id = QCM2290_MASTER_SDCC_2,
 	.name = "mas_sdcc_2",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 23,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 35,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_sdcc_2_links),
@@ -627,10 +565,7 @@ static struct qcom_icc_node mas_qpic = {
 	.id = QCM2290_MASTER_QPIC,
 	.name = "mas_qpic",
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_port = 1,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 58,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_qpic_links),
@@ -645,10 +580,7 @@ static struct qcom_icc_node mas_usb3_0 = {
 	.id = QCM2290_MASTER_USB3_0,
 	.name = "mas_usb3_0",
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_port = 24,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
+	.ap_owned = true,
 	.mas_rpm_id = 32,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_usb3_0_links),
@@ -663,11 +595,7 @@ static struct qcom_icc_node mas_gfx3d = {
 	.id = QCM2290_MASTER_GFX3D,
 	.name = "mas_gfx3d",
 	.buswidth = 32,
-	.qos.ap_owned = true,
-	.qos.qos_port = 1,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.prio_level = 0,
-	.qos.areq_prio = 0,
+	.ap_owned = true,
 	.mas_rpm_id = 6,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_gfx3d_links),
@@ -702,8 +630,7 @@ static struct qcom_icc_node slv_bimc_cfg = {
 	.name = "slv_bimc_cfg",
 	.id = QCM2290_SLAVE_BIMC_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 56,
 };
@@ -712,8 +639,7 @@ static struct qcom_icc_node slv_camera_nrt_throttle_cfg = {
 	.name = "slv_camera_nrt_throttle_cfg",
 	.id = QCM2290_SLAVE_CAMERA_NRT_THROTTLE_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 271,
 };
@@ -722,8 +648,7 @@ static struct qcom_icc_node slv_camera_rt_throttle_cfg = {
 	.name = "slv_camera_rt_throttle_cfg",
 	.id = QCM2290_SLAVE_CAMERA_RT_THROTTLE_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 279,
 };
@@ -732,8 +657,7 @@ static struct qcom_icc_node slv_camera_cfg = {
 	.name = "slv_camera_cfg",
 	.id = QCM2290_SLAVE_CAMERA_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 3,
 };
@@ -742,8 +666,7 @@ static struct qcom_icc_node slv_clk_ctl = {
 	.name = "slv_clk_ctl",
 	.id = QCM2290_SLAVE_CLK_CTL,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 47,
 };
@@ -752,8 +675,7 @@ static struct qcom_icc_node slv_crypto_0_cfg = {
 	.name = "slv_crypto_0_cfg",
 	.id = QCM2290_SLAVE_CRYPTO_0_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 52,
 };
@@ -762,8 +684,7 @@ static struct qcom_icc_node slv_display_cfg = {
 	.name = "slv_display_cfg",
 	.id = QCM2290_SLAVE_DISPLAY_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 4,
 };
@@ -772,8 +693,7 @@ static struct qcom_icc_node slv_display_throttle_cfg = {
 	.name = "slv_display_throttle_cfg",
 	.id = QCM2290_SLAVE_DISPLAY_THROTTLE_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 156,
 };
@@ -782,8 +702,7 @@ static struct qcom_icc_node slv_gpu_cfg = {
 	.name = "slv_gpu_cfg",
 	.id = QCM2290_SLAVE_GPU_CFG,
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 275,
 };
@@ -792,8 +711,7 @@ static struct qcom_icc_node slv_hwkm = {
 	.name = "slv_hwkm",
 	.id = QCM2290_SLAVE_HWKM,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 280,
 };
@@ -802,8 +720,7 @@ static struct qcom_icc_node slv_imem_cfg = {
 	.name = "slv_imem_cfg",
 	.id = QCM2290_SLAVE_IMEM_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 54,
 };
@@ -812,8 +729,7 @@ static struct qcom_icc_node slv_ipa_cfg = {
 	.name = "slv_ipa_cfg",
 	.id = QCM2290_SLAVE_IPA_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 183,
 };
@@ -822,8 +738,7 @@ static struct qcom_icc_node slv_lpass = {
 	.name = "slv_lpass",
 	.id = QCM2290_SLAVE_LPASS,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 21,
 };
@@ -832,8 +747,7 @@ static struct qcom_icc_node slv_message_ram = {
 	.name = "slv_message_ram",
 	.id = QCM2290_SLAVE_MESSAGE_RAM,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 55,
 };
@@ -842,8 +756,7 @@ static struct qcom_icc_node slv_pdm = {
 	.name = "slv_pdm",
 	.id = QCM2290_SLAVE_PDM,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 41,
 };
@@ -852,8 +765,7 @@ static struct qcom_icc_node slv_pimem_cfg = {
 	.name = "slv_pimem_cfg",
 	.id = QCM2290_SLAVE_PIMEM_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 167,
 };
@@ -862,8 +774,7 @@ static struct qcom_icc_node slv_pka_wrapper = {
 	.name = "slv_pka_wrapper",
 	.id = QCM2290_SLAVE_PKA_WRAPPER,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 281,
 };
@@ -872,8 +783,7 @@ static struct qcom_icc_node slv_pmic_arb = {
 	.name = "slv_pmic_arb",
 	.id = QCM2290_SLAVE_PMIC_ARB,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 59,
 };
@@ -882,8 +792,7 @@ static struct qcom_icc_node slv_prng = {
 	.name = "slv_prng",
 	.id = QCM2290_SLAVE_PRNG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 44,
 };
@@ -892,8 +801,7 @@ static struct qcom_icc_node slv_qdss_cfg = {
 	.name = "slv_qdss_cfg",
 	.id = QCM2290_SLAVE_QDSS_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 63,
 };
@@ -902,8 +810,7 @@ static struct qcom_icc_node slv_qm_cfg = {
 	.name = "slv_qm_cfg",
 	.id = QCM2290_SLAVE_QM_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 212,
 };
@@ -912,8 +819,7 @@ static struct qcom_icc_node slv_qm_mpu_cfg = {
 	.name = "slv_qm_mpu_cfg",
 	.id = QCM2290_SLAVE_QM_MPU_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 231,
 };
@@ -922,8 +828,7 @@ static struct qcom_icc_node slv_qpic = {
 	.name = "slv_qpic",
 	.id = QCM2290_SLAVE_QPIC,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 80,
 };
@@ -932,8 +837,7 @@ static struct qcom_icc_node slv_qup_0 = {
 	.name = "slv_qup_0",
 	.id = QCM2290_SLAVE_QUP_0,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 261,
 };
@@ -942,8 +846,7 @@ static struct qcom_icc_node slv_sdcc_1 = {
 	.name = "slv_sdcc_1",
 	.id = QCM2290_SLAVE_SDCC_1,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 31,
 };
@@ -952,8 +855,7 @@ static struct qcom_icc_node slv_sdcc_2 = {
 	.name = "slv_sdcc_2",
 	.id = QCM2290_SLAVE_SDCC_2,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 33,
 };
@@ -966,8 +868,7 @@ static struct qcom_icc_node slv_snoc_cfg = {
 	.name = "slv_snoc_cfg",
 	.id = QCM2290_SLAVE_SNOC_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 70,
 	.num_links = ARRAY_SIZE(slv_snoc_cfg_links),
@@ -978,8 +879,7 @@ static struct qcom_icc_node slv_tcsr = {
 	.name = "slv_tcsr",
 	.id = QCM2290_SLAVE_TCSR,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 50,
 };
@@ -988,8 +888,7 @@ static struct qcom_icc_node slv_usb3 = {
 	.name = "slv_usb3",
 	.id = QCM2290_SLAVE_USB3,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 22,
 };
@@ -998,8 +897,7 @@ static struct qcom_icc_node slv_venus_cfg = {
 	.name = "slv_venus_cfg",
 	.id = QCM2290_SLAVE_VENUS_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 10,
 };
@@ -1008,8 +906,7 @@ static struct qcom_icc_node slv_venus_throttle_cfg = {
 	.name = "slv_venus_throttle_cfg",
 	.id = QCM2290_SLAVE_VENUS_THROTTLE_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 178,
 };
@@ -1018,8 +915,7 @@ static struct qcom_icc_node slv_vsense_ctrl_cfg = {
 	.name = "slv_vsense_ctrl_cfg",
 	.id = QCM2290_SLAVE_VSENSE_CTRL_CFG,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 263,
 };
@@ -1028,8 +924,7 @@ static struct qcom_icc_node slv_service_cnoc = {
 	.name = "slv_service_cnoc",
 	.id = QCM2290_SLAVE_SERVICE_CNOC,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 76,
 };
@@ -1038,8 +933,7 @@ static struct qcom_icc_node slv_qup_core_0 = {
 	.name = "slv_qup_core_0",
 	.id = QCM2290_SLAVE_QUP_CORE_0,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 264,
 };
@@ -1052,8 +946,7 @@ static struct qcom_icc_node slv_snoc_bimc_nrt = {
 	.name = "slv_snoc_bimc_nrt",
 	.id = QCM2290_SLAVE_SNOC_BIMC_NRT,
 	.buswidth = 16,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 259,
 	.num_links = ARRAY_SIZE(slv_snoc_bimc_nrt_links),
@@ -1068,8 +961,7 @@ static struct qcom_icc_node slv_snoc_bimc_rt = {
 	.name = "slv_snoc_bimc_rt",
 	.id = QCM2290_SLAVE_SNOC_BIMC_RT,
 	.buswidth = 16,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 260,
 	.num_links = ARRAY_SIZE(slv_snoc_bimc_rt_links),
@@ -1080,8 +972,7 @@ static struct qcom_icc_node slv_appss = {
 	.name = "slv_appss",
 	.id = QCM2290_SLAVE_APPSS,
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 20,
 };
@@ -1112,8 +1003,7 @@ static struct qcom_icc_node slv_pimem = {
 	.name = "slv_pimem",
 	.id = QCM2290_SLAVE_PIMEM,
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 166,
 };
@@ -1136,8 +1026,7 @@ static struct qcom_icc_node slv_service_snoc = {
 	.name = "slv_service_snoc",
 	.id = QCM2290_SLAVE_SERVICE_SNOC,
 	.buswidth = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 29,
 };
@@ -1154,8 +1043,7 @@ static struct qcom_icc_node slv_tcu = {
 	.name = "slv_tcu",
 	.id = QCM2290_SLAVE_TCU,
 	.buswidth = 8,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 133,
 };
@@ -1186,6 +1074,40 @@ static struct qcom_icc_node * const qcm2290_bimc_nodes[] = {
 	[SLAVE_BIMC_SNOC] = &slv_bimc_snoc,
 };
 
+static const struct qcom_icc_qos_data bimc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 6,
+		.prio_level = 6,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	},
+};
+
 static const struct regmap_config qcm2290_bimc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1202,6 +1124,8 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.regmap_cfg = &qcm2290_bimc_regmap_config,
 	.keep_alive = true,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
+	.qos_data = bimc_qos_data,
+	.qos_data_num = ARRAY_SIZE(bimc_qos_data),
 	.qos_offset = 0x8000,
 	.ab_coeff = 153,
 };
@@ -1287,6 +1211,95 @@ static struct qcom_icc_node * const qcm2290_snoc_nodes[] = {
 	[SLAVE_ANOC_SNOC] = &slv_anoc_snoc,
 };
 
+static const struct qcom_icc_qos_data snoc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+	/* Port 4 -> MMnRT */
+	/* Port 5 -> MMRT */
+	{
+		.qos_port = 8,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+	/* Port 9 -> MMnRT */
+	/* Port 10 -> MMRT */
+	{
+		.qos_port = 12,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+	/* Port 13 -> MMnRT */
+	{
+		.qos_port = 17,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 20,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 22,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 23,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 24,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config qcm2290_snoc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1302,6 +1315,8 @@ static const struct qcom_icc_desc qcm2290_snoc = {
 	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.keep_alive = true,
+	.qos_data = snoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(snoc_qos_data),
 	/* Vendor DT node fab-sys_noc property 'qcom,base-offset' */
 	.qos_offset = 0x15000,
 };
@@ -1326,6 +1341,31 @@ static struct qcom_icc_node * const qcm2290_mmnrt_virt_nodes[] = {
 	[SLAVE_SNOC_BIMC_NRT] = &slv_snoc_bimc_nrt,
 };
 
+static const struct qcom_icc_qos_data mmnrt_qos_data[] = {
+	{
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 3,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 9,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 3,
+		.prio_level = 0,
+		.urg_fwd_en = true,
+		.limit_commands = false,
+	}, {
+		.qos_port = 13,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 4,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmnrt_virt_nodes,
@@ -1333,6 +1373,8 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.bus_clk_desc = &mmaxi_0_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.keep_alive = true,
+	.qos_data = mmnrt_qos_data,
+	.qos_data_num = ARRAY_SIZE(mmnrt_qos_data),
 	.qos_offset = 0x15000,
 	.ab_coeff = 142,
 };
@@ -1343,6 +1385,24 @@ static struct qcom_icc_node * const qcm2290_mmrt_virt_nodes[] = {
 	[SLAVE_SNOC_BIMC_RT] = &slv_snoc_bimc_rt,
 };
 
+static const struct qcom_icc_qos_data mmrt_qos_data[] = {
+	{
+		.qos_port = 5,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 3,
+		.prio_level = 0,
+		.urg_fwd_en = true,
+		.limit_commands = false,
+	}, {
+		.qos_port = 10,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 3,
+		.prio_level = 0,
+		.urg_fwd_en = true,
+		.limit_commands = false,
+	},
+};
+
 static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmrt_virt_nodes,
@@ -1350,6 +1410,8 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.bus_clk_desc = &mmaxi_1_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.keep_alive = true,
+	.qos_data = mmrt_qos_data,
+	.qos_data_num = ARRAY_SIZE(mmrt_qos_data),
 	.qos_offset = 0x15000,
 	.ab_coeff = 139,
 };
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index ab91de446da8..0b58874d0d8c 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -146,11 +146,7 @@ static struct qcom_icc_node mas_ipa = {
 	.buswidth = 8,
 	.mas_rpm_id = 59,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 3,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_ipa_links),
 	.links = mas_ipa_links,
 };
@@ -165,8 +161,7 @@ static struct qcom_icc_node mas_cnoc_a2noc = {
 	.buswidth = 8,
 	.mas_rpm_id = 146,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_cnoc_a2noc_links),
 	.links = mas_cnoc_a2noc_links,
 };
@@ -237,11 +232,7 @@ static struct qcom_icc_node mas_ufs = {
 	.buswidth = 8,
 	.mas_rpm_id = 68,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 4,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_ufs_links),
 	.links = mas_ufs_links,
 };
@@ -256,11 +247,7 @@ static struct qcom_icc_node mas_usb_hs = {
 	.buswidth = 8,
 	.mas_rpm_id = 42,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_usb_hs_links),
 	.links = mas_usb_hs_links,
 };
@@ -275,11 +262,7 @@ static struct qcom_icc_node mas_usb3 = {
 	.buswidth = 8,
 	.mas_rpm_id = 32,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_usb3_links),
 	.links = mas_usb3_links,
 };
@@ -294,11 +277,7 @@ static struct qcom_icc_node mas_crypto = {
 	.buswidth = 8,
 	.mas_rpm_id = 23,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 11,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_crypto_links),
 	.links = mas_crypto_links,
 };
@@ -313,11 +292,7 @@ static struct qcom_icc_node mas_gnoc_bimc = {
 	.buswidth = 4,
 	.mas_rpm_id = 144,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_gnoc_bimc_links),
 	.links = mas_gnoc_bimc_links,
 };
@@ -334,11 +309,7 @@ static struct qcom_icc_node mas_oxili = {
 	.buswidth = 4,
 	.mas_rpm_id = 6,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_oxili_links),
 	.links = mas_oxili_links,
 };
@@ -355,11 +326,7 @@ static struct qcom_icc_node mas_mnoc_bimc = {
 	.buswidth = 4,
 	.mas_rpm_id = 2,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 2,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mnoc_bimc_links),
 	.links = mas_mnoc_bimc_links,
 };
@@ -390,11 +357,7 @@ static struct qcom_icc_node mas_pimem = {
 	.buswidth = 4,
 	.mas_rpm_id = 113,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 4,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_pimem_links),
 	.links = mas_pimem_links,
 };
@@ -441,8 +404,7 @@ static struct qcom_icc_node mas_snoc_cnoc = {
 	.buswidth = 8,
 	.mas_rpm_id = 52,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_snoc_cnoc_links),
 	.links = mas_snoc_cnoc_links,
 };
@@ -490,8 +452,7 @@ static struct qcom_icc_node mas_qdss_dap = {
 	.buswidth = 8,
 	.mas_rpm_id = 49,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_dap_links),
 	.links = mas_qdss_dap_links,
 };
@@ -507,8 +468,7 @@ static struct qcom_icc_node mas_apss_proc = {
 	.buswidth = 16,
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_apss_proc_links),
 	.links = mas_apss_proc_links,
 };
@@ -534,8 +494,7 @@ static struct qcom_icc_node mas_cnoc_mnoc_mmss_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = 4,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_cnoc_mnoc_mmss_cfg_links),
 	.links = mas_cnoc_mnoc_mmss_cfg_links,
 };
@@ -550,8 +509,7 @@ static struct qcom_icc_node mas_cnoc_mnoc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = 5,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_cnoc_mnoc_cfg_links),
 	.links = mas_cnoc_mnoc_cfg_links,
 };
@@ -566,11 +524,7 @@ static struct qcom_icc_node mas_cpp = {
 	.buswidth = 16,
 	.mas_rpm_id = 115,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 4,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_cpp_links),
 	.links = mas_cpp_links,
 };
@@ -585,11 +539,7 @@ static struct qcom_icc_node mas_jpeg = {
 	.buswidth = 16,
 	.mas_rpm_id = 7,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 6,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_jpeg_links),
 	.links = mas_jpeg_links,
 };
@@ -605,11 +555,7 @@ static struct qcom_icc_node mas_mdp_p0 = {
 	.ib_coeff = 50,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mdp_p0_links),
 	.links = mas_mdp_p0_links,
 };
@@ -625,11 +571,7 @@ static struct qcom_icc_node mas_mdp_p1 = {
 	.ib_coeff = 50,
 	.mas_rpm_id = 61,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_mdp_p1_links),
 	.links = mas_mdp_p1_links,
 };
@@ -644,11 +586,7 @@ static struct qcom_icc_node mas_venus = {
 	.buswidth = 16,
 	.mas_rpm_id = 9,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_venus_links),
 	.links = mas_venus_links,
 };
@@ -663,11 +601,7 @@ static struct qcom_icc_node mas_vfe = {
 	.buswidth = 16,
 	.mas_rpm_id = 11,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
-	.qos.qos_port = 5,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_vfe_links),
 	.links = mas_vfe_links,
 };
@@ -685,11 +619,7 @@ static struct qcom_icc_node mas_qdss_etr = {
 	.buswidth = 8,
 	.mas_rpm_id = 31,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 1,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
 	.links = mas_qdss_etr_links,
 };
@@ -707,11 +637,7 @@ static struct qcom_icc_node mas_qdss_bam = {
 	.buswidth = 4,
 	.mas_rpm_id = 19,
 	.slv_rpm_id = -1,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 1,
-	.qos.prio_level = 1,
-	.qos.qos_port = 0,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
 	.links = mas_qdss_bam_links,
 };
@@ -851,8 +777,7 @@ static struct qcom_icc_node slv_cnoc_a2noc = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 208,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_cnoc_a2noc_links),
 	.links = slv_cnoc_a2noc_links,
 };
@@ -863,8 +788,7 @@ static struct qcom_icc_node slv_mpm = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 62,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pmic_arb = {
@@ -873,8 +797,7 @@ static struct qcom_icc_node slv_pmic_arb = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 59,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_tlmm_north = {
@@ -883,8 +806,7 @@ static struct qcom_icc_node slv_tlmm_north = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 214,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_tcsr = {
@@ -893,8 +815,7 @@ static struct qcom_icc_node slv_tcsr = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 50,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pimem_cfg = {
@@ -903,8 +824,7 @@ static struct qcom_icc_node slv_pimem_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 167,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_imem_cfg = {
@@ -913,8 +833,7 @@ static struct qcom_icc_node slv_imem_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 54,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_message_ram = {
@@ -923,8 +842,7 @@ static struct qcom_icc_node slv_message_ram = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 55,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_glm = {
@@ -933,8 +851,7 @@ static struct qcom_icc_node slv_glm = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 209,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_bimc_cfg = {
@@ -943,8 +860,7 @@ static struct qcom_icc_node slv_bimc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 56,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_prng = {
@@ -953,8 +869,7 @@ static struct qcom_icc_node slv_prng = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 44,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_spdm = {
@@ -963,8 +878,7 @@ static struct qcom_icc_node slv_spdm = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 60,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_qdss_cfg = {
@@ -973,8 +887,7 @@ static struct qcom_icc_node slv_qdss_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 63,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static const u16 slv_cnoc_mnoc_cfg_links[] = {
@@ -987,8 +900,7 @@ static struct qcom_icc_node slv_cnoc_mnoc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 66,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_cfg_links),
 	.links = slv_cnoc_mnoc_cfg_links,
 };
@@ -999,8 +911,7 @@ static struct qcom_icc_node slv_snoc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 70,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_qm_cfg = {
@@ -1009,8 +920,7 @@ static struct qcom_icc_node slv_qm_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 212,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_clk_ctl = {
@@ -1019,8 +929,7 @@ static struct qcom_icc_node slv_clk_ctl = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 47,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_mss_cfg = {
@@ -1029,8 +938,7 @@ static struct qcom_icc_node slv_mss_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 48,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_tlmm_south = {
@@ -1039,8 +947,7 @@ static struct qcom_icc_node slv_tlmm_south = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 217,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_ufs_cfg = {
@@ -1049,8 +956,7 @@ static struct qcom_icc_node slv_ufs_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 92,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a2noc_cfg = {
@@ -1059,8 +965,7 @@ static struct qcom_icc_node slv_a2noc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 150,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_a2noc_smmu_cfg = {
@@ -1069,8 +974,7 @@ static struct qcom_icc_node slv_a2noc_smmu_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 152,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_gpuss_cfg = {
@@ -1079,8 +983,7 @@ static struct qcom_icc_node slv_gpuss_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 11,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_ahb2phy = {
@@ -1089,8 +992,7 @@ static struct qcom_icc_node slv_ahb2phy = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 163,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_blsp_1 = {
@@ -1099,8 +1001,7 @@ static struct qcom_icc_node slv_blsp_1 = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 39,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_sdcc_1 = {
@@ -1109,8 +1010,7 @@ static struct qcom_icc_node slv_sdcc_1 = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 31,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_sdcc_2 = {
@@ -1119,8 +1019,7 @@ static struct qcom_icc_node slv_sdcc_2 = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 33,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_tlmm_center = {
@@ -1129,8 +1028,7 @@ static struct qcom_icc_node slv_tlmm_center = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 218,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_blsp_2 = {
@@ -1139,8 +1037,7 @@ static struct qcom_icc_node slv_blsp_2 = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 37,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_pdm = {
@@ -1149,8 +1046,7 @@ static struct qcom_icc_node slv_pdm = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 41,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static const u16 slv_cnoc_mnoc_mmss_cfg_links[] = {
@@ -1163,8 +1059,7 @@ static struct qcom_icc_node slv_cnoc_mnoc_mmss_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 58,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_mmss_cfg_links),
 	.links = slv_cnoc_mnoc_mmss_cfg_links,
 };
@@ -1175,8 +1070,7 @@ static struct qcom_icc_node slv_usb_hs = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 40,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_usb3_0 = {
@@ -1185,8 +1079,7 @@ static struct qcom_icc_node slv_usb3_0 = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 22,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_srvc_cnoc = {
@@ -1195,8 +1088,7 @@ static struct qcom_icc_node slv_srvc_cnoc = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 76,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static const u16 slv_gnoc_bimc_links[] = {
@@ -1209,8 +1101,7 @@ static struct qcom_icc_node slv_gnoc_bimc = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 210,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_gnoc_bimc_links),
 	.links = slv_gnoc_bimc_links,
 };
@@ -1225,8 +1116,7 @@ static struct qcom_icc_node slv_gnoc_snoc = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 211,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_gnoc_snoc_links),
 	.links = slv_gnoc_snoc_links,
 };
@@ -1237,8 +1127,7 @@ static struct qcom_icc_node slv_camera_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 3,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_camera_throttle_cfg = {
@@ -1247,8 +1136,7 @@ static struct qcom_icc_node slv_camera_throttle_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 154,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_misc_cfg = {
@@ -1257,8 +1145,7 @@ static struct qcom_icc_node slv_misc_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 8,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_venus_throttle_cfg = {
@@ -1267,8 +1154,7 @@ static struct qcom_icc_node slv_venus_throttle_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 178,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_venus_cfg = {
@@ -1277,8 +1163,7 @@ static struct qcom_icc_node slv_venus_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 10,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_mmss_clk_xpu_cfg = {
@@ -1287,8 +1172,7 @@ static struct qcom_icc_node slv_mmss_clk_xpu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 13,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_mmss_clk_cfg = {
@@ -1297,8 +1181,7 @@ static struct qcom_icc_node slv_mmss_clk_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 12,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_mnoc_mpu_cfg = {
@@ -1307,8 +1190,7 @@ static struct qcom_icc_node slv_mnoc_mpu_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 14,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_display_cfg = {
@@ -1317,8 +1199,7 @@ static struct qcom_icc_node slv_display_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 4,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_csi_phy_cfg = {
@@ -1327,8 +1208,7 @@ static struct qcom_icc_node slv_csi_phy_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 224,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_display_throttle_cfg = {
@@ -1337,8 +1217,7 @@ static struct qcom_icc_node slv_display_throttle_cfg = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 156,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_smmu_cfg = {
@@ -1347,8 +1226,7 @@ static struct qcom_icc_node slv_smmu_cfg = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 205,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static const u16 slv_mnoc_bimc_links[] = {
@@ -1361,8 +1239,7 @@ static struct qcom_icc_node slv_mnoc_bimc = {
 	.buswidth = 16,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 16,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 	.num_links = ARRAY_SIZE(slv_mnoc_bimc_links),
 	.links = slv_mnoc_bimc_links,
 };
@@ -1373,8 +1250,7 @@ static struct qcom_icc_node slv_srvc_mnoc = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 17,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_hmss = {
@@ -1383,8 +1259,7 @@ static struct qcom_icc_node slv_hmss = {
 	.buswidth = 8,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 20,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_lpass = {
@@ -1393,8 +1268,7 @@ static struct qcom_icc_node slv_lpass = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 21,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_wlan = {
@@ -1411,8 +1285,7 @@ static struct qcom_icc_node slv_cdsp = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 221,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static struct qcom_icc_node slv_ipa = {
@@ -1421,8 +1294,7 @@ static struct qcom_icc_node slv_ipa = {
 	.buswidth = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 183,
-	.qos.ap_owned = true,
-	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.ap_owned = true,
 };
 
 static const u16 slv_snoc_bimc_links[] = {
@@ -1499,6 +1371,45 @@ static struct qcom_icc_node * const sdm660_a2noc_nodes[] = {
 	[SLAVE_A2NOC_SNOC] = &slv_a2noc_snoc,
 };
 
+static const struct qcom_icc_qos_data a2noc_qos_data[] = {
+	{
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 11,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config sdm660_a2noc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1515,6 +1426,8 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.intf_clocks = a2noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
+	.qos_data = a2noc_qos_data,
+	.qos_data_num = ARRAY_SIZE(a2noc_qos_data),
 };
 
 static struct qcom_icc_node * const sdm660_bimc_nodes[] = {
@@ -1528,6 +1441,30 @@ static struct qcom_icc_node * const sdm660_bimc_nodes[] = {
 	[SLAVE_BIMC_SNOC] = &slv_bimc_snoc,
 };
 
+static const struct qcom_icc_qos_data bimc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config sdm660_bimc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1542,6 +1479,8 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
+	.qos_data = bimc_qos_data,
+	.qos_data_num = ARRAY_SIZE(bimc_qos_data),
 	.ab_coeff = 153,
 };
 
@@ -1646,6 +1585,28 @@ static struct qcom_icc_node * const sdm660_mnoc_nodes[] = {
 	[SLAVE_MNOC_BIMC] = &slv_mnoc_bimc,
 };
 
+
+static const struct qcom_icc_qos_data mnoc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 5,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	},
+};
 static const struct regmap_config sdm660_mnoc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1662,6 +1623,8 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
+	.qos_data = mnoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(mnoc_qos_data),
 	.ab_coeff = 153,
 };
 
@@ -1685,6 +1648,24 @@ static struct qcom_icc_node * const sdm660_snoc_nodes[] = {
 	[SLAVE_SRVC_SNOC] = &slv_srvc_snoc,
 };
 
+static const struct qcom_icc_qos_data snoc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 1,
+		.prio_level = 1,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config sdm660_snoc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1699,6 +1680,8 @@ static const struct qcom_icc_desc sdm660_snoc = {
 	.num_nodes = ARRAY_SIZE(sdm660_snoc_nodes),
 	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &sdm660_snoc_regmap_config,
+	.qos_data = snoc_qos_data,
+	.qos_data_num = ARRAY_SIZE(snoc_qos_data),
 };
 
 static const struct of_device_id sdm660_noc_of_match[] = {
diff --git a/drivers/interconnect/qcom/sm6115.c b/drivers/interconnect/qcom/sm6115.c
index 271b07c74862..9e8be6fbc23b 100644
--- a/drivers/interconnect/qcom/sm6115.c
+++ b/drivers/interconnect/qcom/sm6115.c
@@ -129,10 +129,6 @@ static struct qcom_icc_node apps_proc = {
 	.id = SM6115_MASTER_AMPSS_M0,
 	.channels = 1,
 	.buswidth = 16,
-	.qos.qos_port = 0,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.prio_level = 0,
-	.qos.areq_prio = 0,
 	.mas_rpm_id = 0,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(slv_ebi_slv_bimc_snoc_links),
@@ -148,10 +144,6 @@ static struct qcom_icc_node mas_snoc_bimc_rt = {
 	.id = SM6115_MASTER_SNOC_BIMC_RT,
 	.channels = 1,
 	.buswidth = 16,
-	.qos.qos_port = 2,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_ebi),
@@ -163,10 +155,6 @@ static struct qcom_icc_node mas_snoc_bimc_nrt = {
 	.id = SM6115_MASTER_SNOC_BIMC_NRT,
 	.channels = 1,
 	.buswidth = 16,
-	.qos.qos_port = 3,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_ebi),
@@ -178,10 +166,6 @@ static struct qcom_icc_node mas_snoc_bimc = {
 	.id = SM6115_MASTER_SNOC_BIMC,
 	.channels = 1,
 	.buswidth = 16,
-	.qos.qos_port = 6,
-	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
-	.qos.areq_prio = 0,
-	.qos.prio_level = 0,
 	.mas_rpm_id = 3,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_ebi),
@@ -193,10 +177,6 @@ static struct qcom_icc_node qnm_gpu = {
 	.id = SM6115_MASTER_GRAPHICS_3D,
 	.channels = 1,
 	.buswidth = 32,
-	.qos.qos_port = 1,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.prio_level = 0,
-	.qos.areq_prio = 0,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(slv_ebi_slv_bimc_snoc_links),
@@ -208,10 +188,6 @@ static struct qcom_icc_node tcu_0 = {
 	.id = SM6115_MASTER_TCU_0,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 4,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.prio_level = 6,
-	.qos.areq_prio = 6,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(slv_ebi_slv_bimc_snoc_links),
@@ -242,9 +218,6 @@ static struct qcom_icc_node crypto_c0 = {
 	.id = SM6115_MASTER_CRYPTO_CORE0,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 22,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = 23,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_anoc_snoc),
@@ -332,9 +305,6 @@ static struct qcom_icc_node qnm_camera_nrt = {
 	.id = SM6115_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
-	.qos.qos_port = 4,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 3,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_snoc_bimc_nrt),
@@ -346,10 +316,6 @@ static struct qcom_icc_node qxm_venus0 = {
 	.id = SM6115_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 16,
-	.qos.qos_port = 9,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 3,
-	.qos.urg_fwd_en = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_snoc_bimc_nrt),
@@ -361,9 +327,6 @@ static struct qcom_icc_node qxm_venus_cpu = {
 	.id = SM6115_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 13,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 4,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_snoc_bimc_nrt),
@@ -379,10 +342,6 @@ static struct qcom_icc_node qnm_camera_rt = {
 	.id = SM6115_MASTER_CAMNOC_HF,
 	.channels = 1,
 	.buswidth = 32,
-	.qos.qos_port = 10,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 3,
-	.qos.urg_fwd_en = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_snoc_bimc_rt),
@@ -394,10 +353,6 @@ static struct qcom_icc_node qxm_mdp0 = {
 	.id = SM6115_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 16,
-	.qos.qos_port = 5,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 3,
-	.qos.urg_fwd_en = true,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_snoc_bimc_rt),
@@ -434,9 +389,6 @@ static struct qcom_icc_node qhm_tic = {
 	.id = SM6115_MASTER_TIC,
 	.channels = 1,
 	.buswidth = 4,
-	.qos.qos_port = 8,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_tic_links),
@@ -484,9 +436,6 @@ static struct qcom_icc_node qxm_pimem = {
 	.id = SM6115_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 20,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(mas_pimem_links),
@@ -498,9 +447,6 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.id = SM6115_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.qos.qos_port = 2,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_anoc_snoc),
@@ -523,9 +469,6 @@ static struct qcom_icc_node qhm_qup0 = {
 	.id = SM6115_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.qos.qos_port = 0,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = 166,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_anoc_snoc),
@@ -537,9 +480,6 @@ static struct qcom_icc_node qxm_ipa = {
 	.id = SM6115_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 3,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = 59,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_anoc_snoc),
@@ -551,9 +491,6 @@ static struct qcom_icc_node xm_qdss_etr = {
 	.id = SM6115_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 12,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_anoc_snoc),
@@ -565,9 +502,6 @@ static struct qcom_icc_node xm_sdc1 = {
 	.id = SM6115_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 17,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = 33,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_anoc_snoc),
@@ -579,9 +513,6 @@ static struct qcom_icc_node xm_sdc2 = {
 	.id = SM6115_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 23,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = 35,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_anoc_snoc),
@@ -593,9 +524,6 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.id = SM6115_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.qos.qos_port = 24,
-	.qos.qos_mode = NOC_QOS_MODE_FIXED,
-	.qos.areq_prio = 2,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = -1,
 	.num_links = ARRAY_SIZE(link_slv_anoc_snoc),
@@ -1204,6 +1132,40 @@ static struct qcom_icc_node * const bimc_nodes[] = {
 	[BIMC_SNOC_SLV] = &slv_bimc_snoc,
 };
 
+static const struct qcom_icc_qos_data bimc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 1,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 0,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	}, {
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 6,
+		.prio_level = 6,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 6,
+		.qos_mode = NOC_QOS_MODE_BYPASS,
+	},
+};
+
 static const struct regmap_config bimc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1219,6 +1181,8 @@ static const struct qcom_icc_desc sm6115_bimc = {
 	.regmap_cfg = &bimc_regmap_config,
 	.bus_clk_desc = &bimc_clk,
 	.keep_alive = true,
+	.qos_data = bimc_qos_data,
+	.qos_data_num = ARRAY_SIZE(bimc_qos_data),
 	.qos_offset = 0x8000,
 	.ab_coeff = 153,
 };
@@ -1320,6 +1284,88 @@ static struct qcom_icc_node * const sys_noc_nodes[] = {
 	[SLAVE_ANOC_SNOC] = &slv_anoc_snoc,
 };
 
+static const struct qcom_icc_qos_data sys_noc_qos_data[] = {
+	{
+		.qos_port = 0,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 2,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 3,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+	/* Port 4 -> MMnRT */
+	/* Port 5 -> MMRT */
+	{
+		.qos_port = 8,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+	/* Port 9 -> MMnRT */
+	/* Port 10 -> MMRT */
+	{
+		.qos_port = 12,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+	/* Port 13 -> MMnRT */
+	{
+		.qos_port = 17,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 20,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 22,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 23,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 24,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 2,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct regmap_config sys_noc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1336,6 +1382,8 @@ static const struct qcom_icc_desc sm6115_sys_noc = {
 	.intf_clocks = snoc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(snoc_intf_clocks),
 	.bus_clk_desc = &bus_2_clk,
+	.qos_data = sys_noc_qos_data,
+	.qos_data_num = ARRAY_SIZE(sys_noc_qos_data),
 	.qos_offset = 0x15000,
 	.keep_alive = true,
 };
@@ -1361,6 +1409,31 @@ static struct qcom_icc_node * const mmnrt_virt_nodes[] = {
 	[SLAVE_SNOC_BIMC_NRT] = &slv_snoc_bimc_nrt,
 };
 
+static const struct qcom_icc_qos_data mmnrt_qos_data[] = {
+	{
+		.qos_port = 4,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 3,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	}, {
+		.qos_port = 9,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 3,
+		.prio_level = 0,
+		.urg_fwd_en = true,
+		.limit_commands = false,
+	}, {
+		.qos_port = 13,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 4,
+		.prio_level = 0,
+		.urg_fwd_en = false,
+		.limit_commands = false,
+	},
+};
+
 static const struct qcom_icc_desc sm6115_mmnrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = mmnrt_virt_nodes,
@@ -1368,6 +1441,8 @@ static const struct qcom_icc_desc sm6115_mmnrt_virt = {
 	.regmap_cfg = &sys_noc_regmap_config,
 	.bus_clk_desc = &mmaxi_0_clk,
 	.keep_alive = true,
+	.qos_data = mmnrt_qos_data,
+	.qos_data_num = ARRAY_SIZE(mmnrt_qos_data),
 	.qos_offset = 0x15000,
 	.ab_coeff = 142,
 };
@@ -1378,6 +1453,24 @@ static struct qcom_icc_node * const mmrt_virt_nodes[] = {
 	[SLAVE_SNOC_BIMC_RT] = &slv_snoc_bimc_rt,
 };
 
+static const struct qcom_icc_qos_data mmrt_qos_data[] = {
+	{
+		.qos_port = 5,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 3,
+		.prio_level = 0,
+		.urg_fwd_en = true,
+		.limit_commands = false,
+	}, {
+		.qos_port = 10,
+		.qos_mode = NOC_QOS_MODE_FIXED,
+		.areq_prio = 3,
+		.prio_level = 0,
+		.urg_fwd_en = true,
+		.limit_commands = false,
+	},
+};
+
 static const struct qcom_icc_desc sm6115_mmrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = mmrt_virt_nodes,
@@ -1385,6 +1478,8 @@ static const struct qcom_icc_desc sm6115_mmrt_virt = {
 	.regmap_cfg = &sys_noc_regmap_config,
 	.bus_clk_desc = &mmaxi_1_clk,
 	.keep_alive = true,
+	.qos_data = mmrt_qos_data,
+	.qos_data_num = ARRAY_SIZE(mmrt_qos_data),
 	.qos_offset = 0x15000,
 	.ab_coeff = 139,
 };

-- 
2.44.0


