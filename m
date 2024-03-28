Return-Path: <linux-kernel+bounces-122555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B688F963
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC5D1F2DFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A69A5F873;
	Thu, 28 Mar 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GomPNtKs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00C5B1E3;
	Thu, 28 Mar 2024 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612869; cv=none; b=NDT6AxmL6/H6b8yO7wjxrKAOvao4KT4voPX2nRvBRprf4gGkry4GwS8tVtwdrhrBMErwX6ovt04GSlFgYdn230T2qyuGY6jJcu0IdkgIAscfOgCf1r0bvQZEIjmh8UPz3uPd5/uBk63Ms5x41ffo8kl62ZyvltAKB+C6LuViXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612869; c=relaxed/simple;
	bh=IsHGAC/a4AfxW7HAYylRod3GFoL8Dtn6zIFUyqdBu/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQhcCgC+UW0+Ddv4Y2I+8BEg4D4uWGW7U5EDwCSOrpzrptW2nGsLxoG18pNGOnc1iVdQ53EL5dObyr5075Qu1LHFxuLyB5bgWby3p35xZYTUERs11EhlHQyYnyaVTpFjsCuvT71pG4IJZBfVz6dN9Ag6V2NoesZROBUWEQxt6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GomPNtKs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S70HXg021752;
	Thu, 28 Mar 2024 08:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ru5AXWrm9k2bxeHJpQZgzgwCH4paww6MPSYb+UW6WOI=; b=Go
	mPNtKsNmaF/7mIOhGFZxWVBdZXncHfmvWj8cOcIMoM6b43fufPVdWeiQMW/vSpNU
	nVtTVubnMr727bRqLhsSnZvSLtlVpqxgkBUBhx+7OLKXTRhrmaqJEoNmjAqGcHWu
	kX6RKmTjFy7S3WqqPAfoItSEFP45Lf3Nnjtpq6lb7xTcTuC6/C9YR9g4DuuGQ4Xk
	mjkD2Vr/kMeGOJf8AVhp33DzTbJtqEsZsjzhuXRhJX0L9JDA0s3l3YEWtEkdEScA
	usMYCUh4LhSBKoPqpdaYPgQEKGC8tTH/VCYN/wUGEchDmJsh4D3cTqGaYrpiL/js
	j5mEM8XMwp4toFjfFGYg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wjeye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:01:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S810Jb010255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 08:01:00 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 01:00:55 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_varada@quicinc.com>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v5 2/5] interconnect: icc-clk: Add devm_icc_clk_register
Date: Thu, 28 Mar 2024 13:29:33 +0530
Message-ID: <20240328075936.223461-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328075936.223461-1-quic_varada@quicinc.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: A6GY7qLP0aFWgDQ8C7uB-b_9kFnCVgIZ
X-Proofpoint-ORIG-GUID: A6GY7qLP0aFWgDQ8C7uB-b_9kFnCVgIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280051

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


