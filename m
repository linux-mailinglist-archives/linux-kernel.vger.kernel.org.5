Return-Path: <linux-kernel+bounces-27043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0882E9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC7C28527A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F41119A;
	Tue, 16 Jan 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bgc6ufct"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663A10A11;
	Tue, 16 Jan 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G3w2Vj018625;
	Tue, 16 Jan 2024 06:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=sPUpDtt
	d2+jDFuIIW2GUulBm+G27B1qXZJjmv7tzfYk=; b=Bgc6ufctP1rI96o4lnEgC7q
	ig82ua22vqB1bvdEvFBatvK8p3lFBU4ZLY0xGofVTaTjAqpLa0OxYbctN+/05N1U
	TIfo5eCVIGR0G4wh+NjQd+MZxbZATSpG4RlUXWBEA4xNGCcpWV9Ae+x5UUCvi/Ln
	ATNGWH31itEoEZnswwff9+H8cjwLcmDlldMK6EU5nbw6OwL3DExV1ZLpIyIPjgpw
	KG3aNoLmguR/1RiI/+kqvEZuYZytkoSxSiKPW+9vhjE2j1BGawbl21H7/a2UMA+M
	jgU0rvcYy4jpH66I4kqGi6GRAZvq30FlvME3CZPL6UlYdxG+yiia5T19ziTUI/w=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn8e9s926-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 06:45:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G6jH7W032326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 06:45:17 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 22:45:16 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang
	<quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao
 Zhang" <quic_taozha@quicinc.com>
Subject: [PATCH v2 0/2] arm64: dts: qcom: Add coresight nodes for sm8450 
Date: Mon, 15 Jan 2024 22:45:01 -0800
Message-ID: <20240116064505.487-1-quic_jinlmao@quicinc.com>
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
X-Proofpoint-GUID: djWwqgny08Q8ypm0Ef1Is8d1-TRnUhgC
X-Proofpoint-ORIG-GUID: djWwqgny08Q8ypm0Ef1Is8d1-TRnUhgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=686 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401160051

Add coresight components on Qualcomm SM8450 Soc. The components include
TMC ETF/ETR, ETE, STM, TPDM, CTI. And remove the pattern of ete node
name.

Change since V1:
1. Remove the pattern match of ETE node name.
2. Update the tmc-etr node name in DT.

Mao Jinlong (2):
  dt-bindings: arm: coresight: Remove pattern match of ETE node name
  arm64: dts: qcom: Add coresight nodes for sm8450

 .../arm/arm,embedded-trace-extension.yaml     |   6 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 742 ++++++++++++++++++
 2 files changed, 744 insertions(+), 4 deletions(-)

-- 
2.41.0


