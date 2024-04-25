Return-Path: <linux-kernel+bounces-157978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8453F8B19B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95491C21341
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8C72B9DB;
	Thu, 25 Apr 2024 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KefoZEXI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4C199BC;
	Thu, 25 Apr 2024 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016764; cv=none; b=CTrzML0XM8ZtlGc0DcxwluoQNOrEjmGxsiOmX041sx2Xq81b3BbQvXGNCGt8bhPK+vEpSwYF6KbEJd152RYbEX3ovRAKUwWxnnTzdHuob0PcER4s4FGYGQbMg+1LEeVvaqzS6jlsa51jGf6ULYumf9Aw2CWqbHhhmitPi9IikiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016764; c=relaxed/simple;
	bh=JY3AmVLcwPO1P6DoNmmLgo63YdF0tdPmQSHA95BBAXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nYMrb4jA6llwi2etzBJyxKjM01HNVu0Oi/aa4gzvAXG/PyWU5enE6IUQnCES2ui2uWP5rqMIzLLvgULKs4hDH5ClTjiu+wZUf0gSvoQSjpHbAzKtRPYpwvzrJG77EqB9M/1lV7z5JACBEB5LKDu9qRY/sLMPspEk7WwnNn00gbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KefoZEXI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P3c3Lm023790;
	Thu, 25 Apr 2024 03:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=VSc
	e5Ya3ivoLCJKezzC7iicBkP/C98XpzDxSDFxnQrw=; b=KefoZEXI5fcCxOoxfIx
	ZjdH+kUyqxQoIAsSCOY5UNEp8y0ilvj6nsWwLzdNn2LGiub3Fnu6Ae2tnYfxHCTZ
	TMNfNqu6PQrWtm+BiopuH4g+t0+DIybr7/cXFveEmQ3GBCw/6VpHZjzyK37ixGU+
	6ExOET7iCnPBSly1k1E50JlNgSoI1ib9It7L0Kxn7fOc/xZt+VXC+kGbVWLgljzG
	wIHdyIAhn8XyODCkYG7UibqTgljXBGqY0SVA/ERZ22OjiSQkwqmuTkEuYAYmS3yo
	WlerUOq22BOWxB0oZpfrTibqiVXQ0y8Hq8zI6EiXz39NYbB6X59eAOLSRLrPiltV
	vEg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhr43e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:45:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P3jV6R004556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:45:31 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 20:45:31 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 24 Apr 2024 20:45:31 -0700
Subject: [PATCH] pinctrl: qcom: Fix behavior in abscense of open-drain
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANrRKWYC/x3MQQqAIBBA0avIrBtQmUV0lWhhNtZAqWhEEN09a
 fkW/z9QuQhXGNQDhS+pkmKD6RT4zcWVUZZmsNqSJkt47seBKXPEpTiJ2M/akDc+OOOgVblwkPs
 /jtP7fhQTmpRhAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Jaiganesh Narayanan <njaigane@codeaurora.org>
CC: Johan Hovold <johan@kernel.org>, Doug Anderson <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714016731; l=2745;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=JY3AmVLcwPO1P6DoNmmLgo63YdF0tdPmQSHA95BBAXc=;
 b=DgZjfTY8hxgg+sMTt8VV8lSZA5iAiK/lYZ/iWzcIWEP81S7lK5zyYOzmW0p0s9OGPOxp8IPYU
 IuctO/21nrVBNeJH8bFK2L0ENXmW50xJZji0PtUGMaFGx+hauBLoWN9
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2FbXZ2uIL-MpoqbqOa-QYvGOdC7pKBb0
X-Proofpoint-GUID: 2FbXZ2uIL-MpoqbqOa-QYvGOdC7pKBb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_02,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250025

When a GPIO is configured as OPEN_DRAIN gpiolib will in
gpiod_direction_output() attempt to configure the open-drain property of
the hardware and if this fails fall back to software emulation of this
state.

The TLMM block in most Qualcomm platform does not implement such
functionality, so this call would be expected to fail. But due to lack
of checks for this condition, the zero-initialized od_bit will cause
this request to silently corrupt the lowest bit in the config register
(which typically is part of the bias configuration) and happily continue
on.

Fix this by checking if the od_bit value is unspecified and if so fail
the request to avoid the unexpected state, and to make sure the software
fallback actually kicks in.

It is assumed for now that no implementation will come into existence
with BIT(0) being the open-drain bit, simply for convenience sake.

Fixes: 13355ca35cd1 ("pinctrl: qcom: ipq4019: add open drain support")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 ++
 drivers/pinctrl/qcom/pinctrl-msm.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index aeaf0d1958f5..329474dc21c0 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -313,6 +313,8 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
 			*mask |= BIT(g->i2c_pull_bit) >> *bit;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (!g->od_bit)
+			return -EOPNOTSUPP;
 		*bit = g->od_bit;
 		*mask = 1;
 		break;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 63852ed70295..7b8cd1832112 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -51,7 +51,8 @@ struct pinctrl_pin_desc;
  * @mux_bit:              Offset in @ctl_reg for the pinmux function selection.
  * @pull_bit:             Offset in @ctl_reg for the bias configuration.
  * @drv_bit:              Offset in @ctl_reg for the drive strength configuration.
- * @od_bit:               Offset in @ctl_reg for controlling open drain.
+ * @od_bit:               Offset in @ctl_reg for controlling open drain. 0 if
+ *                        not supported by target.
  * @oe_bit:               Offset in @ctl_reg for controlling output enable.
  * @in_bit:               Offset in @io_reg for the input bit value.
  * @out_bit:              Offset in @io_reg for the output bit value.

---
base-commit: 5e4f84f18c4ee9b0ccdc19e39b7de41df21699dd
change-id: 20240424-tlmm-open-drain-8b014c1cfa1a

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


