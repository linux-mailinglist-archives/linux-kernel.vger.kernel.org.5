Return-Path: <linux-kernel+bounces-149807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AE78A9616
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DC91C218E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C21607A2;
	Thu, 18 Apr 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c+9DLdFN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8615FD15;
	Thu, 18 Apr 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432234; cv=none; b=hPxZOhEz8P6ZGXYbN4WOB+qrf6jbKf0fBr1BLleFd+KiBahxS5/apmaOvLyUjbEGBWaHo4bxCg2+/DqjJu5Jhotbsbl2p6pRcHvoVeFoAq19AfCraWIu+bxM/XGpDacr7ARBSR44isJlgT2uYKrSJs+NLdQhsw3FIYe5EqWpziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432234; c=relaxed/simple;
	bh=T7Rgau1rzdZt01khVIDbkhoJQLqfaHI/1aq574/2kh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzjCNleWbNtnZgN6Bqu9hMzvrQMrakRVBOVBv4wBm+zKLXZvZQCiI53RyjbPcY4gSpsrz5z1AX2Cmvc6Xgkhe1DKlucAo8kdYM666YXQnBikkQ6yFlSbLM6kML/BPg2xklj5oKzU9Qn1OwBlEtQM1Q78Sku/WNE1Z9wBhtEgYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c+9DLdFN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HNcr5M014398;
	Thu, 18 Apr 2024 09:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=0Xh6KXQvbd4uP5SbqSIAeRt/gx3dC3hjpO/8cGO9rRQ=; b=c+
	9DLdFNxOpj3Id+6tlXJZfqvEPiNfd7S6ghSuSNmNAxnQF7xr5ya/eC5BuntGcANI
	XSS8SxambmzDjgCM+DUc6A8nanI0QxoiJe+iSOr+i7oviWluC4fx4JCINimwPQXp
	0E3TS8deG+ECtm13okz/zdLTJsXsnfXu+c0dwxVliTqeOU2Rm2daxj5PP/0YIiFS
	Nv0NMb018FDXDe4Qq6uNBKgz2QLt6698vKFJdViFGB6oG98yoXQXDgjIGsHC2uyp
	U+vs9rw1nHJs/wwEA3bNU8jspAV72yYwx+UicZhakO7Bd0LHSuCb2kYBeEwt2Fup
	3+ezA7E5VYagbx6SUH8w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjr92hc42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 09:23:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I9Nnxg012767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 09:23:49 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 02:23:44 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v9 3/6] interconnect: icc-clk: Add devm_icc_clk_register
Date: Thu, 18 Apr 2024 14:53:02 +0530
Message-ID: <20240418092305.2337429-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418092305.2337429-1-quic_varada@quicinc.com>
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wZrWsJOJsCIP07Gw5KgHA2dzfszQQMQ5
X-Proofpoint-ORIG-GUID: wZrWsJOJsCIP07Gw5KgHA2dzfszQQMQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_08,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180065

Wrap icc_clk_register to create devm_icc_clk_register to be
able to release the resources properly.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v8: Added Reviewed-by: Dmitry Baryshkov
v7: Simplify devm_icc_clk_register implementation as suggested in review
v5: Introduced devm_icc_clk_register
---
 drivers/interconnect/icc-clk.c   | 18 ++++++++++++++++++
 include/linux/interconnect-clk.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 2be193fd7d8f..f788db15cd76 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -148,6 +148,24 @@ struct icc_provider *icc_clk_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(icc_clk_register);
 
+static void devm_icc_release(void *res)
+{
+	icc_clk_unregister(res);
+}
+
+int devm_icc_clk_register(struct device *dev, unsigned int first_id,
+			  unsigned int num_clocks, const struct icc_clk_data *data)
+{
+	struct icc_provider *prov;
+
+	prov = icc_clk_register(dev, first_id, num_clocks, data);
+	if (IS_ERR(prov))
+		return PTR_ERR(prov);
+
+	return devm_add_action_or_reset(dev, devm_icc_release, prov);
+}
+EXPORT_SYMBOL_GPL(devm_icc_clk_register);
+
 /**
  * icc_clk_unregister() - unregister a previously registered clk interconnect provider
  * @provider: provider returned by icc_clk_register()
diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
index 170898faaacb..9bcee3e9c56c 100644
--- a/include/linux/interconnect-clk.h
+++ b/include/linux/interconnect-clk.h
@@ -19,6 +19,8 @@ struct icc_provider *icc_clk_register(struct device *dev,
 				      unsigned int first_id,
 				      unsigned int num_clocks,
 				      const struct icc_clk_data *data);
+int devm_icc_clk_register(struct device *dev, unsigned int first_id,
+			  unsigned int num_clocks, const struct icc_clk_data *data);
 void icc_clk_unregister(struct icc_provider *provider);
 
 #endif
-- 
2.34.1


