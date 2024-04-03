Return-Path: <linux-kernel+bounces-129593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68146896CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB521C270CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA50147C8A;
	Wed,  3 Apr 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kSbUqnTG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855D146D5E;
	Wed,  3 Apr 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140971; cv=none; b=t9wC98COIDGgAybsTzBieWyTG/5msqCEDslpYHuLHoYSystxfEvDznq2Xp+ohVeu5yAYewAnxVJ7mzaLECzzySgk17nVzFjav2SfFVVR8p/RgIsa1edUZ4Uy1dCXiWoVnJj7tl/gXjY7ai+RJxcd+M6UZYxEwpAp5iSzzCchKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140971; c=relaxed/simple;
	bh=QT7IGi6vS9P8M9vRUSvueUyuwCOIJiAhi3xVvotuTQg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiO5nUqB0MTM5Im2DKq4oKGsTof75JD1Vag9hiLWrXw8f4RWDnhi7W44nU3ab6eHV6FSOnQoT+Tpzfyfv7i+3URGSBN+FAb7Rt5stsLgGsa2mhM9YwSTswig/X/h8+Uq7Bv1axcr4fV8rGA+wCxxYcsw4/K7nj42Smyku5ckNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kSbUqnTG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4337Dfde027522;
	Wed, 3 Apr 2024 10:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tmLgm9Qq7srg8c2mrdhIjORjGo8nAKOj/ZnxTGPuYos=; b=kS
	bUqnTGO4folVWp3SidSB8ZXNR/00DUiGUt8sdB1U0FysZGUGi3n03nLDSY8IV2/6
	dUZzFX45vtzGGHl3QKdpNR3W9X+MCLOmxOnZ2kEVmT8h8gsEyry/7L0WGBu8oe3R
	KDXjxfuFp/Jdb1tREztH65gFtHLPdpz5CqwyhbdXkaetmBn2RGd4lhh7dQhGz7p3
	bR8dBXXylZfvSTcFmXfi88iZ8m6FbV5lMY0rtQEwg1OGEU3LS9e4LdxWAlH27Tkw
	Vaf50AwHdrryqTYcpyQbSpspBctH5lwDLB6ovEftswu8SqE6Qrdzt4WbBM8iTNV/
	5fSizS6SF/hc3NdiuN0w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x92hb0ea7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:42:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433AgjgQ027513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 10:42:45 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 03:42:40 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v7 2/5] interconnect: icc-clk: Add devm_icc_clk_register
Date: Wed, 3 Apr 2024 16:12:17 +0530
Message-ID: <20240403104220.1092431-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403104220.1092431-1-quic_varada@quicinc.com>
References: <20240403104220.1092431-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: z4_oS6p8iO8l-AOBZ7XDjxS3fytRTS1x
X-Proofpoint-ORIG-GUID: z4_oS6p8iO8l-AOBZ7XDjxS3fytRTS1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030073

Wrap icc_clk_register to create devm_icc_clk_register to be
able to release the resources properly.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v7: Simplify devm_icc_clk_register implementation as suggested in review
v5: Introduced devm_icc_clk_register
---
 drivers/interconnect/icc-clk.c   | 18 ++++++++++++++++++
 include/linux/interconnect-clk.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index d787f2ea36d9..bce946592c98 100644
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
index 0cd80112bea5..5c611a8b0892 100644
--- a/include/linux/interconnect-clk.h
+++ b/include/linux/interconnect-clk.h
@@ -17,6 +17,8 @@ struct icc_provider *icc_clk_register(struct device *dev,
 				      unsigned int first_id,
 				      unsigned int num_clocks,
 				      const struct icc_clk_data *data);
+int devm_icc_clk_register(struct device *dev, unsigned int first_id,
+			  unsigned int num_clocks, const struct icc_clk_data *data);
 void icc_clk_unregister(struct icc_provider *provider);
 
 #endif
-- 
2.34.1


