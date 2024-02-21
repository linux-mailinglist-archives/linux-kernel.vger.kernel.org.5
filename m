Return-Path: <linux-kernel+bounces-75640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6039185ECC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C851F23B31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A212C809;
	Wed, 21 Feb 2024 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="THqXg8nE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F08663D;
	Wed, 21 Feb 2024 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557568; cv=none; b=knmLHfvRJy0WeEKVmwFx6aZ3i5m6VxkXWdZjcoshQK21sSLO3WmNRh5cf07Zf9Dnxg7qxAPHJGCGUzdDZR2Ht1x0RWwIl0zGIo4JVJeNuVd66t0FmAMwsoSvUMN+jaP9pn6vDHxeew/Bdwndi1coO4ie9akZI0C8tDSdkeDIvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557568; c=relaxed/simple;
	bh=UawKxY/wNEpZe/K6ZSBOrWoORz1ZeMn1m4HSMFS0WhU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bJgqVDmFlIyTn2U9J2LNAH2F08HsHoKvtiE+F5TVicSL9sxYC+orK+lrZWSPTZYryhMLZQPzJQlnAZeSxqHRO1a+4WtR/WLHMuh+8fiT8e1jORkkYaGcMFJqa5cA8BIC/8Rlw0BfQq3+h/k7xNNpr3kngHDRsTat9JUyjiWjDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=THqXg8nE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LNEoYG028626;
	Wed, 21 Feb 2024 23:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=CelsGDIFSPLJqy
	fTWpBCJuduVZTYRQTelZocddmgQHE=; b=THqXg8nE2G+HwdHynohBH/K53Zm95a
	L3p8ffLBH29wrdHUk4cScjB8uYh/dS/oDKncmYlTa0pBNdzDFJ3zTwhNZneTpzq+
	ppEeu1N7yd7WYzj8o6XU8Av/lq9Uv7XSrspjrJfsDdT+5KMPDF19XI9hEaEnd/6M
	PrB0+KgUHKe7pdzboJ7eq9ERLjXFrs9ly+dt3yOPX/spFodD27Os3qvtVeHkB9qN
	1ZhJ3pJ9WVWCuPBY13K1flu4EiMgFqyou1xFJT3HBCgLRJVUO7936i8C8zoTKq4P
	bseTt6ONdybGVXpA0z55EngPsgcUSIYAF3rRvjxA7Pc/RBZkZIEbcdsg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfx4hmpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LNJDok020290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:19:13 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:19:13 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH 0/9] arm64: dts: qcom: qcs6490-rb3gen2: Enable two displays
Date: Wed, 21 Feb 2024 15:19:08 -0800
Message-ID: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOyE1mUC/x3MQQqEMAxA0atI1hOo0YV6FXExbVPNJpVUhgHp3
 S0u3+L/GwqbcIGlu8H4J0WyNvSfDsLx1Z1RYjOQo9GRm9H8sLMSxhNDVuVwZUMfY/LTTCmRg5a
 exkn+73bdan0AX5LCMGYAAAA=
To: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708557553; l=1606;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=UawKxY/wNEpZe/K6ZSBOrWoORz1ZeMn1m4HSMFS0WhU=;
 b=VgHOPv2y0TUisMlKhdQwzFNj5emloYz3HorglSQbNjzyMT9whYMj6lmIabHBG2z6g66EgDik7
 LYpk2ossgV5CnDvwjylGFbmrNVdkMoKcSOFYoQ3jE1FCHk+GxvdbYh9
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V37K1f2kbY2gyjU0XptpF_1ASXcal3l1
X-Proofpoint-GUID: V37K1f2kbY2gyjU0XptpF_1ASXcal3l1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=544 clxscore=1011 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210184

RB3Gen2 is capable of producing DisplayPort output on a dedicated
mini-DP connector and USB Type-C.

Utilize Abel's work for DP vs eDP selection to allow configuring both
controllers in DP-mode, then enable the two output paths.

Tested by driving fbcon to 4k@60 + 4k@30 concurrently.

Depends on https://lore.kernel.org/linux-arm-msm/20240220-x1e80100-display-v4-0-971afd9de861@linaro.org/

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Bjorn Andersson (9):
      drm/msm/dp: Add DP support to combo instance in SC7280
      arm64: dts: qcom: sc7280: Make eDP/DP controller default DP
      arm64: dts: qcom: sc7280: Enable MDP turbo mode
      arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
      arm64: dts: qcom: qcs6490-rb3gen2: Enable adsp and cdsp
      arm64: dts: qcom: qcs6490-rb3gen2: Enable USB role switching
      arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB redriver
      arm64: dts: qcom: qcs6490-rb3gen2: Enable USB Type-C display
      arm64: defconfig: Enable sc7280 display and gpu clock controllers

 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 154 ++++++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi   |   2 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi         |   7 +-
 arch/arm64/configs/defconfig                 |   2 +
 drivers/gpu/drm/msm/dp/dp_display.c          |   9 +-
 5 files changed, 170 insertions(+), 4 deletions(-)
---
base-commit: aba508318eec7acad2373296279d6447fd35f83f
change-id: 20240209-rb3gen2-dp-connector-bddfb892ff20

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


