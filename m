Return-Path: <linux-kernel+bounces-42446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552D6840170
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103572818D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF125645B;
	Mon, 29 Jan 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oG24e5bZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783255E59;
	Mon, 29 Jan 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520344; cv=none; b=l3j2AOeuRpZkJ8YGncg1W5V6AgZJRLuIA9HngLKUS03+orVtHoiP0dhLtiVS12DL2tgfLm2qAkwxFKWW5KzwJkTu0V1kOQSgdktSA6UmM0odgC9FSQac7xA+66k6MjHj0jkQB0+uRu/CgBP3PdtZ+NrqaQl7ReOg82I456bHRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520344; c=relaxed/simple;
	bh=vTXQcys2pfiBXQp9kkz2sFHKc7t+RLM/St6Euk2Ljxo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UNqXUDOx+/EivBfjB1+Dzi7J5z3XGC3IV62Ori/KWyDplQhJuXlJAwB8Xgf0ccG7wIZBOC4ezmLDZht6aSXdnqh/AZN/K+03FXyvXNc3w2JWwh45v0WtwmoPVk0jaUtN3u/82c59NDcOu1xX7UuHs4SOY8gLFj/or7CZF/n1cgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oG24e5bZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T7hJ6B024274;
	Mon, 29 Jan 2024 09:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=GvTpZYbedktBrcPF9cFXdQzFU7WKnC9W5xOhGOM9gms=; b=oG
	24e5bZiUAYb7mSOMdlNmF6HxtBzMejyHpIcFwxbEZqPyj0r2YpKzgG5vnxVaA89W
	yQWaK+ZO/gDeJh39esR58fDtwtSd3VTIyXjURAUYVwAXtqQ2FBHEzdHKzLlNihc0
	ZkUCBx+B5xN7OtpKZqP60V+I99n7i7KryPsfwHA9ODKXrIs6aNHlBhFhM8YBhmL2
	5vyXwWzb0WvIz+EnK7yeB/f1Hc47ka0v1tdR6UMmk1pF/7k4mbWD5Q3PqZTOvqtc
	yRbmtbpfzYSC9RwkpqNe+QFQ5fiSSpOSh4R6FPlUsxeLuLSEQ+AhIsKXHwd+SbS7
	WQIZC7yRw0ZzZd84HsIQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t9rkp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:25:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T9PaLS016171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:25:36 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 01:25:30 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 0/2] update SM4450 pinctrl document
Date: Mon, 29 Jan 2024 17:25:10 +0800
Message-ID: <20240129092512.23602-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Omqnw8GauF4qI7dAFpRyyKDcbVeRTYvB
X-Proofpoint-ORIG-GUID: Omqnw8GauF4qI7dAFpRyyKDcbVeRTYvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_04,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=566 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401290065

Update compatible name and consolidate functions to match with SM4450
driver.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

v1 -> v2:
  - update patches commit message
  - Remove excess Spaces

previous discussion here:
[1] v1: https://lore.kernel.org/linux-arm-msm/20240124023305.15755-1-quic_tengfan@quicinc.com/

Tengfei Fan (2):
  dt-bindings: pinctrl: qcom: update compatible name for match with
    driver
  dt-bindings: pinctrl: qcom: consolidate functions to match with driver

 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 53 +++++++------------
 1 file changed, 18 insertions(+), 35 deletions(-)


base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
-- 
2.17.1


