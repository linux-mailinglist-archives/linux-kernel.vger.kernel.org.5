Return-Path: <linux-kernel+bounces-66915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399CC85638E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA22B288D10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2812E1E0;
	Thu, 15 Feb 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kbTsGR/p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70712DD85;
	Thu, 15 Feb 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001107; cv=none; b=oG7+IiOSecGS84ui61lAbDert6++l0TPyHy3MmQHtKxMhMMK92o5QK8CEn0pB+7BsQXedKHSkkeDnJ7/qkW2Pf3TuJMrrprqwUZgsiM/f7g8lFN8QwNixLGZCw+vMferb4sVeT90ojEhCMXGy1/La0EK40UJ2aw0ytiSkcR53nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001107; c=relaxed/simple;
	bh=r1qCmEfG9TOJIeTRiTy4CJ/2RXzY6FXSnyuokA3WHn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiC4qv26j6shfdoslTdOd1E0rCFvrLo8LVn7VJOprgWqhdlXQBqLF73GSGBd52btxpslEkStrKZkMyUfzSW9lP32nabRqFsKm0AlrwWKd/3bPwnQygcecjIlwBhk1llu8SO92fBT+rBANPfb9/A9xJTAt/2NqTiADj03jVnNoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kbTsGR/p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FBi3VN009426;
	Thu, 15 Feb 2024 12:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=4IHe2eNrOxuBbvyn8W0GTqyrfuds0kMln3z9TSBgCGo=; b=kb
	TsGR/pw8p3NuTQWJ/O4DNiPNu0cJQSWyTe8hfdUtcpytAUA6CdXh8xupaqtYX4CG
	Dk8lkiFekgHP5hU+W3X/FrBkBjGsxdV0M+mmncoukPZt67CQU0lUilaiqWH+Pye2
	8VRpz7NK1JPvqvtHasJz6esjciiPDA443OS/JQ7nLdFCY9ginemH41njuuQ+v7Lb
	6XFK7i26HRSISpRp5BhdaynMGC9wfq0WZhvpJPf/knw8eXpqZWWLsib+5juqgZUp
	5VhztktkCdvasroi5gLLfSBQGrNVE1WrEp0rGPE2G61LCvhktmqhuyEyGyQ/4Tdi
	oqzzAwy2K9HbzaJthL4Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w96c3sgf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 12:44:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FCipVU028580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 12:44:51 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 04:44:51 -0800
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
Subject: [PATCH v2 2/2] coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits
Date: Thu, 15 Feb 2024 04:44:37 -0800
Message-ID: <20240215124439.30037-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215124439.30037-1-quic_jinlmao@quicinc.com>
References: <20240215124439.30037-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uzAGRWWQWwkUy8tJU8yoqbV6LScbyqo5
X-Proofpoint-GUID: uzAGRWWQWwkUy8tJU8yoqbV6LScbyqo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=948 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150102

Change qcom,dsb-element-size to qcom,dsb-elem-bits as the unit is bit.

Fixes: 57e7235aa1d1 ("coresight-tpda: Add DSB dataset support")
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


