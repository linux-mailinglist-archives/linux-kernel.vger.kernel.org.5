Return-Path: <linux-kernel+bounces-66914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCA685638D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AAB1F26076
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00512D76C;
	Thu, 15 Feb 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fu8GgC2M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8458ABC;
	Thu, 15 Feb 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001107; cv=none; b=muMaOqtEx6LbfZMPu3vfGQsXkNX6wFe0uuTlEtlN7UZFFIHjr5HufkvNAgoCZK5qDJLNlFr7UL/fToVdLDq9BLu+IdBxEocwDH0XETVyyNnSevCVYro3zpFI8s9YvFXY5a2zJc/lcbWN6OZn1atFgqACJ14/WINn6AebNAd5q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001107; c=relaxed/simple;
	bh=Mgp00C5UQtSRyPwSCiGeC8fFaUThfqgMHNgJPSY/Oug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2L3UEPY+f7ZxsYY2Ftc9Ui1PGDJd+7BK5da1J92cshDHMaWdJmVipvYeJoCJ2uKPOHPUVOHkJsese3ppmKSNHQk43TN3kuWAtGZsxduMiAj31ZsZnsvrg/2HoWfuy/rYtW31HGHWCFOGtUMETsm2UFSSQiwDDv/hVRLc75+K7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fu8GgC2M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FBe9Wx029250;
	Thu, 15 Feb 2024 12:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=jss1n6W
	RXgUmgKBvDKm6RZxp/HrIA3PlBrDIIsPb8r4=; b=Fu8GgC2Myp/wKqd/1mJ7MPl
	xWPAyQj1+wBv8xs3BkdVqVbSdGzTO6vBY62AnwhWqFPSOXbl9Ky9ouUA0Y+1QIeE
	SWqHGtLokC///C2mjmMhC5NdPUN9mgBcTHFHkzXLhOVXWgktDwD52nRU1mXq4jRG
	fMWduXx0gbB9f1j0c7Ryj8MrTqacdvK1Smn9dqedQPUjGNDWhaQAhOwl9uzDqhW4
	x5CylQCCHXt4DOgo/8k4tr5rOvgtWXy07ggR7G+C/JPK1ENOKqj4AJ/jwcKad89j
	nsxvgU995KXlYTTqMh2L2WfabzKIwApFxQF05IhZa5ZBdAjCZO5MHJyMvhUzKwA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9435sru2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 12:44:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FCiond026387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 12:44:51 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 04:44:50 -0800
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
Subject: [PATCH v2 0/2] coresight: tpdm: Change qcom,dsb-element-size to qcom,dsb-elem-bits
Date: Thu, 15 Feb 2024 04:44:35 -0800
Message-ID: <20240215124439.30037-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
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
X-Proofpoint-GUID: Mt0kXIpjqrmyvXPsQYZAt2pEM1q6xtcN
X-Proofpoint-ORIG-GUID: Mt0kXIpjqrmyvXPsQYZAt2pEM1q6xtcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=713
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150100

As unit of dsb element size is bit, change qcom,dsb-element-size to
qcom,dsb-elem-bits. And CMB uses -bits suffix as well. There is no
TPDM node in any DT now. Make such change before any TPDM node is added
to DT. 

Change since V1:
1. Update the commit message for dt-binding.
2. Fix the dt_binding_check error for dt-binding change.

Mao Jinlong (2):
  dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
  coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits

 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml         | 5 ++---
 drivers/hwtracing/coresight/coresight-tpda.c                 | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.41.0


