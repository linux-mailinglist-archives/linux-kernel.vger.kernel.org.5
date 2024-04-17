Return-Path: <linux-kernel+bounces-148359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4058A816C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EBD1F21BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123913D527;
	Wed, 17 Apr 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aPOltpxY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355D13D2AB;
	Wed, 17 Apr 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351421; cv=none; b=lcgbukLQNtN4FpRTTPicyhdPAJQduRBVGBYU5k1i8U17/IwCCMn6FTptzv9beGp9RXTgAyJp01Z/oETkGAaS7w0rOJCCqiFn7YYWmLjiv0rYn94L/ZRVYL+0+LONHG2dtt1YAjzo/hIOb2FIgjqfY2dCn49EiDQmiJXbk+jHuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351421; c=relaxed/simple;
	bh=T7Rgau1rzdZt01khVIDbkhoJQLqfaHI/1aq574/2kh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoK9s+BTG5TXhh4GF5yobl8GLfb9t2/t1zoApFCTW6uDy/IP01D9M4SYM+rEWYUk10opKjmqeInciqbE09EaA+AFGU87W9+ZraDxOGAxRUx3do6aoal2e4WKeUWMCLNF6MWBHt1/OLjrblVY/QFaE85+dPpVK+pJ0o3LZCGs6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aPOltpxY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H4ta9I005435;
	Wed, 17 Apr 2024 10:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=0Xh6KXQvbd4uP5SbqSIAeRt/gx3dC3hjpO/8cGO9rRQ=; b=aP
	OltpxY8YREIp2hnk4FNhlxSBLdDpU9CKCUMWkQfscZEZzkflcEW3BIN8mDGaZ3YX
	vurEMzUkYMKNKUg+H1X+GVuAC6txaFuogDTJLd6RbuNUInVQ04NcEmu5GIoyrbAx
	wzpS5qpWL5riumh8xysbxO/ttHCOctPEj7wkgDL3IumbmOQ7Yse82t0DDRj59NWZ
	bdF4ivGMNKR2p1rgYlNxYzcMJw4FqV1hkEdWVNsBORxH7FYflBypHzSTegXr6h84
	yIl7VV8Qg+IC3fHOG4/eJLtf1RPehQF0Xnfyx8x6qEbxaCbhQTnpj61rTRbVF344
	7ooCIJ/SUfFjfLMcvzqA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7tr0rbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:56:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HAuucI020550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:56:56 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 03:56:50 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v8 4/7] interconnect: icc-clk: Add devm_icc_clk_register
Date: Wed, 17 Apr 2024 16:26:02 +0530
Message-ID: <20240417105605.836705-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417105605.836705-1-quic_varada@quicinc.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: MSmBOlZIeQEY7ji19U2_XwoSRJOv4cXM
X-Proofpoint-GUID: MSmBOlZIeQEY7ji19U2_XwoSRJOv4cXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170075

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


