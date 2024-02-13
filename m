Return-Path: <linux-kernel+bounces-63859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068685359B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2CD28A0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178315FDAD;
	Tue, 13 Feb 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M27NMc0V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD895F551;
	Tue, 13 Feb 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840355; cv=none; b=DJmy0Si37kYdunjchwSLsP2ovNpewn7ElwQ+tj5oDgK8lUJ0kAQbIKI6U4n5ClV7YY3PKpHIcntJbIWy+Ldm/B1V1jv1zI4CCe11cQOX10NHVy+rD1vaywHi7yw2TWBSo/o9XAAaWxSMqaEFi9+mav7OH5Skms2j7c/TolfZZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840355; c=relaxed/simple;
	bh=R5OqQlwm1gJrptArHJQoznpC8GUEoN8HtVLvYRGUPW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe6X0vlVxi8bkjpeGQKULS8NUlXOwE/8pyjUKR+xh0a1x6AeGapnuPxd/0P0hqrnq7Vt7CPJHRsKEqvL4cmLzRQ6UvBgMPCHbk74fd5O96gRHSK2gReaGmT0ali5aayfhMwMjhPAtrmfx8nAKGIZwG4vnw87aQ/S7UMRu7xEY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M27NMc0V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D6l76A001857;
	Tue, 13 Feb 2024 16:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=UB3xM6USck96OqG9tOdvYX2yQdhLN/2nHrb7y6U1ogg=; b=M2
	7NMc0V4b946GgmKFm2F+XSFHb3/etKn5waejqMrQMs+OPPQLFGqgmiSTraHRLbLV
	GX+kBo7IxzObdrMyUXWbBd0YTaBkZFGdILtkm2u5sZz21kIn+a1xjULlIcAtmpOR
	zTcgqFW30pFoqRjx72l7J1qhIVkPB+Eip36D6acevUuk8OVu0MczWNS8vMaW4JJk
	dZtZIwfndxzSN3dqsMFPvhJH6bW5zms6rMEnhZhYF6Fgn/2Rb3hy0e8PV/hgFDTK
	ub21n+IffCol+TViofZ46jEN7X/N8zqvIFsDzkd5v2wK1zDgOiFsknkwC9ofJ946
	urd1I+Qr764vi41GbM0w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7wfy9mdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:05:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DG5XoQ000928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:05:33 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 08:05:33 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Mao
 Jinlong" <quic_jinlmao@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits
Date: Tue, 13 Feb 2024 08:05:18 -0800
Message-ID: <20240213160521.15925-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BIIMg7W3gGkU3C2K0dxbwELTM3mlDzE_
X-Proofpoint-ORIG-GUID: BIIMg7W3gGkU3C2K0dxbwELTM3mlDzE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=963
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130126

Change qcom,dsb-element-size to qcom,dsb-elem-bits as the unit is bit.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 6863afe7ca94..5d20e10be24b 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -70,7 +70,7 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 
 	if (tpdm_has_dsb_dataset(tpdm_data)) {
 		rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
-				"qcom,dsb-element-size", &drvdata->dsb_esize);
+				"qcom,dsb-element-bits", &drvdata->dsb_esize);
 	}
 	if (tpdm_has_cmb_dataset(tpdm_data)) {
 		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
-- 
2.41.0


