Return-Path: <linux-kernel+bounces-126401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D78936D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9B21F213A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60164A15;
	Mon,  1 Apr 2024 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="emvmUOY7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B4A59;
	Mon,  1 Apr 2024 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711936634; cv=none; b=eHZyhownlA+QsN5oOs4n2YdShGVHM/hF8a6ZUOKLoj+/I61WgLM8S0Z2KuChaJ55X0jqgQF5CO57/fj6jTIYyOXfBOCDZ4RIZATdsgzoI3jK6453keCcMFXDXyWteMsGfK2Dfqey55M/2Ir5ABdyAoa1BWqcYi5BVcALFT+Obmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711936634; c=relaxed/simple;
	bh=FsnJhWLrK6yQEdwItnrbi6ql0DJrxh0BVVewjzzPk9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r5iPmRX4VmBzev9OQXwyhMfj56LplczEBCKlyUVgEbf8/SoSk25pU5hZgi2HsJCZHmDvz23OwM1yIIiMYNKMsW+OzI8EIvx2D9C9+a+fpEtrF5s4FDUK810amOmfKp/q0edrFCV/VPlbKFaIUHnDL+vdduCf4EFJUqcUCqfsoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=emvmUOY7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4311S8mN018479;
	Mon, 1 Apr 2024 01:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=qHa8j0EWQj1Gt7XdFiNVs6P5MImRXRQTEjx+DmfI+yA
	=; b=emvmUOY7c4Vq/VNusYC4rEVAI7Tjcq6x6LrBW37awzQSrGQ8AXQBisUsKQt
	txTOpyEqR+gCzIU8iRaZYU3nB5Q8Cefcpu2TzRv+lGSpDtLrltDr2ahkwc/w/XTA
	j8AzRjketQFKzoN0YWNj80UglVM1FMrFaDuHTye+TEAoTpLIC498Vy0eNAdxu9o2
	Df3bY14YxRtINzui6fU33WNQrYJ9PKoJIykSq04yre7aEsAaSjGTGIX7q0cztnT2
	cHVxCFD/8zduXXbs8kZeuMDK88YPW62/OBqGGSv4bei695IY0GFNflDMw/fs4GkR
	gZFd/aBnaqtImXU2t/PI8ALR4Qw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x6atwjvpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 01:57:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4311v0wV030730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 01:57:00 GMT
Received: from jianbinz-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 31 Mar 2024 18:56:58 -0700
From: jianbin zhang <quic_jianbinz@quicinc.com>
Date: Mon, 1 Apr 2024 09:56:30 +0800
Subject: [PATCH V4 2/2] rtc-pm8xxx: Correct the value written into the
 PM8xxx_RTC_ALARM_CLEAR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-2-aab2cd6ddab8@quicinc.com>
References: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-0-aab2cd6ddab8@quicinc.com>
In-Reply-To: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-0-aab2cd6ddab8@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        jianbin zhang <quic_jianbinz@quicinc.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711936613; l=1502;
 i=quic_jianbinz@quicinc.com; s=20240329; h=from:subject:message-id;
 bh=FsnJhWLrK6yQEdwItnrbi6ql0DJrxh0BVVewjzzPk9A=;
 b=N3voitpGq2saSmwNLvKJ75hp5xELj5ClDQnckOcldhd+UnJLBFwheMvOLBq/S00SNKjzFv8Pj
 ZAsRFdf4W6/CDegIjC0NOkYzv3HQNrnR34tPdiU4n/Fd/eqjFB1BbMo
X-Developer-Key: i=quic_jianbinz@quicinc.com; a=ed25519;
 pk=8Qm7Xwv+QY8Y3hGEXPGglY/NRmdGYSKQJh+oPGgX+2c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jVC1cSD5ZPS3H_TrOTLSRal_UyTELRqQ
X-Proofpoint-ORIG-GUID: jVC1cSD5ZPS3H_TrOTLSRal_UyTELRqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_21,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404010013

Writing 1 to the PM8xxx_RTC_ALARM_CLEAR register is expected to clear
the triggered alarm status. In patch v2, the value written to the
PM8xxx_RTC_ALARM_CLEAR register in the trigger function is incorrectly
written as 0. So correct the value written to PM8xxx_RTC_ALARM_CLEAR
register into 1.

Signed-off-by: jianbin zhang <quic_jianbinz@quicinc.com>
---
Changess in v4:
- add the cover letter
- modify the patch to conform to the specification

Changes in v3:
- Correct the value written into the PM8xxx_RTC_ALARM_CLEAR to 1.
- link: https://lore.kernel.org/linux-rtc/20240319191216.GB3796206@hu-bjorande-lv.qualcomm.com/T/#t

Changes in v2:
- Switch to using regmap_update_bits() instead of open coding
  read-modify-write accesses.
- link: https://lore.kernel.org/lkml/20230202155448.6715-4-johan+linaro@kernel.org/

Changes in v1:
-link: https://lore.kernel.org/linux-rtc/20230126142057.25715-4-johan+linaro@kernel.org/
---
 drivers/rtc/rtc-pm8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index e4e2307445cf..806c99cdac9a 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -391,7 +391,7 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 
 	/* Clear alarm status */
 	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2,
-				PM8xxx_RTC_ALARM_CLEAR, 0);
+				PM8xxx_RTC_ALARM_CLEAR, 1);
 	if (rc)
 		return IRQ_NONE;
 

-- 
2.43.2


