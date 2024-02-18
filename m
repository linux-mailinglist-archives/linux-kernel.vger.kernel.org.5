Return-Path: <linux-kernel+bounces-70324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3F859614
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73830B2205C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4231BF26;
	Sun, 18 Feb 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dJpFaYii"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE08149E15;
	Sun, 18 Feb 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708249429; cv=none; b=kV0FPHqtux1dynEI+cqIdqnjzdcs7vrZSNaSJfuFKKaKUtQGGAFYe3iWuBc1IlG/HdS9sVF38jdo1c5TRCFrqMeNWdCZpYtch062r+9Wp+UUWAw3sDoYSsBIUsl51Cyvi+rgwB32vK2vAm6vWgLqNVsnbsQSp0Lc9fEOnNipIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708249429; c=relaxed/simple;
	bh=NWlow1lDx5LyEzRo3c0aTeQMycufCm4lICqSCvV7zes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sF001ijCWc2Q9YTahPuIlg6R3AdOWd9pstjtIfymmLVk+DlfQnfaWKSuvODpdvLf0EH4neLkg1zT2WkdCYx1++8cMNLoKT3ufWeWQ05n0HYf3cIpSpA4STbSAgMr9v4x5GIjF1XJqYiqbnAlmsbLLRu4Aw2RyelIkYXfa4z7XDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dJpFaYii; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41I9DC8q008219;
	Sun, 18 Feb 2024 09:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=NYMxL+/
	0EkAb3ridYEVejY2Pqg5ME5B7neyQY/A1CJo=; b=dJpFaYii3xESn6YPWeuz8wf
	iLoxuCFfh6N1wop2csY9736YN4SkGg9P8Bj/BUY8AIPp4vQ+RC3BwwvgikpApT5s
	iE568Nb6l15L204cnoxV1St37+iI9fLJxAx8kTHD9HxEmNnrF0BUrWToz6kLiNRH
	tQZ1RNnFWAQ4xx34x98YvxPAfjGuYC1muB7M6BZ1LNMm49kVj9ZYs3QtIeOU95Oi
	pf4ZmOyDEVvLs0wLky0kgFpykiW5fMt4lip8C37bQVcw80nsml8686lMrP2dOxNR
	Q9e8QEu1OTaE5pVYX/zS2tFVRFJBLNNHJNusRSeugvgQ/QIsB2wwGMcslwwLNPg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wakrwhp49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:43:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41I9hYid022414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:43:34 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 18 Feb 2024 01:43:34 -0800
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
Subject: [PATCH v3 0/2] coresight: tpdm: Change qcom,dsb-element-size to qcom,dsb-elem-bits
Date: Sun, 18 Feb 2024 01:43:18 -0800
Message-ID: <20240218094322.22470-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
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
X-Proofpoint-GUID: tNhDdvA4f3C7jAvGlDtCnVsez__rX5Pr
X-Proofpoint-ORIG-GUID: tNhDdvA4f3C7jAvGlDtCnVsez__rX5Pr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_07,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=820 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402180073

As unit of dsb element size is bit, change qcom,dsb-element-size to
qcom,dsb-elem-bits. And CMB uses -bits suffix as well. There is no
TPDM node in any DT now. Make such change before any TPDM node is added
to DT.

Change since V2:
1. Use fwnode_property_read_u32 to read the proprety value.

Change since V1:
1. Update the commit message for dt-binding.
2. Fix the dt_binding_check error for dt-binding change.

Mao Jinlong (2):
  dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
  coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits

 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml         | 5 ++---
 drivers/hwtracing/coresight/coresight-tpda.c                 | 4 ++--
 drivers/hwtracing/coresight/coresight-tpda.h                 | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.41.0


