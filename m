Return-Path: <linux-kernel+bounces-127744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ACF895053
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C301F2708E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A87F462;
	Tue,  2 Apr 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BH6Vhh6D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735307A158;
	Tue,  2 Apr 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054087; cv=none; b=JO7kR7JScA0KsKkF5dg63DOxDpQUdmT2WldEWwIr/vS9jZwhXseqNDuyeFdO05flJxp8avXzGlLDVh4LqDX1eELUUujT1HU0m9Lh8+k/jUkDvYXT90mUDDVW1lNcuNDN1FYZ3f08SHNcmJLStYwGWZ98UyPJbZA+GFopxqPLunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054087; c=relaxed/simple;
	bh=IsHGAC/a4AfxW7HAYylRod3GFoL8Dtn6zIFUyqdBu/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJkOkcWG2gHpFUPtOd8aW6zOTSB3yfGpEydWjWxpK8XpIHSD5+LdIhgGXcj9X9Rs55kW3LYWjZSn1REzqe7fEYwjs7mUKC7YQxZWL36ub9Z7DUO8JX3zwuc6EerJyXb40fgWKtMx2gO+RJQvpAPzDiaBLzon15RrJYC7zn7kOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BH6Vhh6D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4321kxl2019378;
	Tue, 2 Apr 2024 10:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ru5AXWrm9k2bxeHJpQZgzgwCH4paww6MPSYb+UW6WOI=; b=BH
	6Vhh6D/pf7aBGQ0Qpb5w3T8eLzvZ4eaDxBmAOmzuHddbFkJimwMyVNyBuvjx8ql6
	nl1INFS/qG8sbQt9woytVHsQNCQ+ELYrsPOlolTbIv8qKFAsWdHj7mpiTkX5Shmv
	GRfNnsWe5q5tmyYGp+Tzxa5RSHHDhz7+gGcKYd2lS7NFDxLxgibfEJf51lYfP3Zx
	yU1lVn5EkGIbHf4WJpHSY28sPGK1PEL1GThDY2eg+4MRHUKekB60oI/fk2pArbnX
	UvE2kZB1KGAcRiOPAGw8TEfSQc/1wZRRNsbU8s4IJ005vhrIyVzdBzkLKWqctS4F
	ZZii7NFWKTGrOgphW4Wg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x88eh92gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:34:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432AYekg013411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 10:34:40 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 03:34:35 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_varada@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
Date: Tue, 2 Apr 2024 16:04:03 +0530
Message-ID: <20240402103406.3638821-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402103406.3638821-1-quic_varada@quicinc.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qfj_QEkYfzIA0ZNR5JKDz9mdrfs7jbFP
X-Proofpoint-ORIG-GUID: Qfj_QEkYfzIA0ZNR5JKDz9mdrfs7jbFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020076

Wrap icc_clk_register to create devm_icc_clk_register to be
able to release the resources properly.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Introduced devm_icc_clk_register
---
 drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
 include/linux/interconnect-clk.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index d787f2ea36d9..89f11fed8820 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -148,6 +148,35 @@ struct icc_provider *icc_clk_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(icc_clk_register);
 
+static void devm_icc_release(struct device *dev, void *res)
+{
+	icc_clk_unregister(res);
+}
+
+struct icc_provider *devm_icc_clk_register(struct device *dev,
+				      unsigned int first_id,
+				      unsigned int num_clocks,
+				      const struct icc_clk_data *data)
+{
+	struct icc_provider *prov, **provp;
+
+	provp = devres_alloc(devm_icc_release, sizeof(*provp), GFP_KERNEL);
+	if (!provp)
+		return ERR_PTR(-ENOMEM);
+
+	prov = icc_clk_register(dev, first_id, num_clocks, data);
+
+	if (!IS_ERR(prov)) {
+		*provp = prov;
+		devres_add(dev, provp);
+	} else {
+		devres_free(provp);
+	}
+
+	return prov;
+}
+EXPORT_SYMBOL_GPL(devm_icc_clk_register);
+
 /**
  * icc_clk_unregister() - unregister a previously registered clk interconnect provider
  * @provider: provider returned by icc_clk_register()
diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
index 0cd80112bea5..cb7b648eb1c0 100644
--- a/include/linux/interconnect-clk.h
+++ b/include/linux/interconnect-clk.h
@@ -17,6 +17,10 @@ struct icc_provider *icc_clk_register(struct device *dev,
 				      unsigned int first_id,
 				      unsigned int num_clocks,
 				      const struct icc_clk_data *data);
+struct icc_provider *devm_icc_clk_register(struct device *dev,
+					   unsigned int first_id,
+					   unsigned int num_clocks,
+					   const struct icc_clk_data *data);
 void icc_clk_unregister(struct icc_provider *provider);
 
 #endif
-- 
2.34.1


