Return-Path: <linux-kernel+bounces-120201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3E88D457
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DF92E4933
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603FD2561B;
	Wed, 27 Mar 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C71Y1+jP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F2219F6;
	Wed, 27 Mar 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505089; cv=none; b=AFP3gEhTmSj/k4qYGP86p50YbUMgpTjlvfCxsbIU/mjF0oA3agMgbFhF6il/W9bgBo1gVTogmp0JSpkDZjaYsdL/zaIRmDP6vFrt8DBLP7bjahXW2f9qQj+4JmJNbUqEYcCWDWCZsT2zWOc/cOrntS20NixjQlQ3iuRilnZI7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505089; c=relaxed/simple;
	bh=OKTKIthIDQQf06SqD0MNjujVknz9TSdxHZprwgsnYDM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=JnlFou+fsl0hb/4BAB2PX03XL+tqWiATnb7VCrrQnGHZ0a7BDkC5jT1DluJSshIwUr05fOx6u9GssIcPLE+77cD7cb9cWcqXZF8ikQ/qG+DApl4kKkww/ExXiZ77vymHvomn1LfmYMFfAnyNlfeadxQ38zIj6HwNaNaKlS3RClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C71Y1+jP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R1jmkA031435;
	Wed, 27 Mar 2024 02:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=pumF8/CEiZB+py
	7958IjlNaJcqnjB/1lUgfZdXwoqsI=; b=C71Y1+jPIiofjl+SYu29mGUiyfChQu
	FDZoDglqJftUIUxvf6hpyWGl71Dw98Et03PBTm60OzkQsftKdkfqt2cpwU6y1jrF
	uWmZxUv8YlF9O2uR+YYjB2jDbUoX6aUCfWEmaF1eIKTj0DFfMSdUSxSAIh030eD1
	iRL56a9ZkTXPDhLAksUa90MvqQwSTnHSN/6lXSJLSbTbF1z6jQ2+xJuKeLN0TD/B
	3WGPrGUSutZHcl5roy72b7LhqCZo0ryS4h/kRRGeQNA1JqaEnFNFgsSQTb1Qe0IS
	gSdSlM8zIxlCAAHn7IEEKiE0SXBVAicjiw5A7J1EQq649giSoISkhq8Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x47800c3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R24TID027971
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 02:04:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 19:04:29 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v2 0/6] arm64: dts: qcom: qcs6490-rb3gen2: Enable two
 displays
Date: Tue, 26 Mar 2024 19:04:17 -0700
Message-ID: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKF+A2YC/22NsQ7CMAxEf6XyjFFqqkKY+A/UgTpO64EEEqhAV
 f+dUDEyvtPduxmyJJUMx2qGJJNmjaEAbSrg8RIGQXWFgQw1hozF1O8GCYTuhhxDEH7EhL1zvj9
 Y8p4MlOktidfXqj13hUfNpfZeX6b6m/6EVP8XTjUadGxs24jfO9ue7k9lDbzleIVuWZYPhVWTn
 roAAAA=
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krishna Kurapati PSSNV
	<quic_kriskura@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711505069; l=1681;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=OKTKIthIDQQf06SqD0MNjujVknz9TSdxHZprwgsnYDM=;
 b=nFUdQn+OuOYp+YEi3klyxJSR/ncwuS+7ccsMkhKHn1004weE42qrzsczxdO8S5sciI1OvIpyh
 r3bas56z9z4CSD4n2lGxV9WcTV6Jt/CTf3ci8RPR9eb+/+RW2iJtIdU
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IeyL_UaxBoHyRjWeZ39n5cWsS5KNoUuB
X-Proofpoint-GUID: IeyL_UaxBoHyRjWeZ39n5cWsS5KNoUuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=537 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270012

RB3Gen2 is capable of producing DisplayPort output on a dedicated
mini-DP connector and USB Type-C.

Utilize Abel's work for DP vs eDP selection to allow configuring both
controllers in DP-mode, then enable the two output paths.

Tested by driving fbcon to 4k@60 + 4k@30 concurrently.

Depends on 20240324-x1e80100-display-refactor-connector-v4-0-e0ebaea66a78@linaro.org

---
Changes in v2:
- Rebased on Abel's updated implementation
- Dropped DP driver changes, as Abel's new DP/eDP selection mechanism
  obsoleted these.
- Squashed the two separate patches adding pmic-glink
- Corrected remoteproc firmware-name paths
- Described the mini-DP connector in DT, and hence no longer use the
  internal HPD handler in DP driver
- Link to v1: https://lore.kernel.org/r/20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com

---
Bjorn Andersson (6):
      arm64: dts: qcom: sc7280: Enable MDP turbo mode
      arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
      arm64: dts: qcom: qcs6490-rb3gen2: Enable adsp and cdsp
      arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB redriver
      arm64: dts: qcom: qcs6490-rb3gen2: Enable USB Type-C display
      arm64: defconfig: Enable sc7280 display and gpu clock controllers

 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 171 ++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi         |   5 +
 arch/arm64/configs/defconfig                 |   2 +
 3 files changed, 177 insertions(+), 1 deletion(-)
---
base-commit: f27830a6a17b722f9dbbccfaae1f3bae8700c672
change-id: 20240209-rb3gen2-dp-connector-bddfb892ff20

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


