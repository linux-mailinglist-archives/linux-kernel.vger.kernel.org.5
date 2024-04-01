Return-Path: <linux-kernel+bounces-126400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CE68936CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61B01F216A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB21FAA;
	Mon,  1 Apr 2024 01:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IEpbQBt5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D1EC2;
	Mon,  1 Apr 2024 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711936632; cv=none; b=KRrKG/7ae4ia7QNYWwguUzEC4HaBadZv4+gYC5XH50rbStxLVEWOTxpumUxfE5L7iZLPNjEYvSUxJqzgjsNimhvu37tJVLe7fvBShWmE6arVmttui4ng9mzbu2T5tNM6MDa4uSam1hhT+d/A9YgR0dlBIYkoFD3ZSucPNehSHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711936632; c=relaxed/simple;
	bh=Mgsmn0QkRnANX9IGLBQCkpG/H6/nbcRJ0fazd1i8ndc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c+No1+LyYtwlnMSZFnEjzGemr8dhVmNSgUX83Yk68GSkFZl7ozwtGcOe9C+EhhfG7ceVBfzhMdXdJ3BFD7EAMZfkFQLZQy/Q/tp60RCuZcgJ9L/ZKBA/PuGqGfUQa4aFOOopWfzwkSYpMaSsUrA5zy0qOvwxYOeQ1QRbXxkq3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IEpbQBt5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4310u8Qj011925;
	Mon, 1 Apr 2024 01:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=eoh/lRifnQuMSAtP56E6LNroMjm6Za7rX4B63b5sQlU
	=; b=IEpbQBt5uBZ4LKqHm7ZLWxoDech45hZXgIARkIoOnnBZu0VyTmLaUY6EnFQ
	LZA6wkoFRi/dD9KsfjbwWT8NnWyi78TEOlmO9DKoNlgejM2A87r7wW5BwArl7RwN
	tRqk7AfmY/jOLzWoYGGQwObOzvevWCxbHZL2ZFcxLBXRB75NKP+CG9BGvR8CCWuo
	u+2eS9Xt3SRwvXlLqvAtJOmGN8D0OHfasOoV4qnlL/u8/yBT31og4abtP3PMkUq1
	/N2XrWDSqu4Zgm7SQPPlFarCJH2UgVBgqYh04ZwbW+wnkiyzrCRyqqwXD5obzIJI
	Q3wXYWqgTAKrrav2yVbAJKbot0Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x683s34t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 01:56:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4311uwRN002892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 01:56:58 GMT
Received: from jianbinz-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 31 Mar 2024 18:56:56 -0700
From: jianbin zhang <quic_jianbinz@quicinc.com>
Date: Mon, 1 Apr 2024 09:56:29 +0800
Subject: [PATCH V4 1/2] rtc-pm8xxx: clear the triggered alarm interrupt
 during driver probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-1-aab2cd6ddab8@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711936613; l=1880;
 i=quic_jianbinz@quicinc.com; s=20240329; h=from:subject:message-id;
 bh=Mgsmn0QkRnANX9IGLBQCkpG/H6/nbcRJ0fazd1i8ndc=;
 b=84SOz1G3c5GpUp2L5Y5t/tB6R6F4IzITjsV/rbVSvza7gNvdBFD3P1yq+Ph8BO/FVAPKFEJFw
 5kN+cUfZYxyAx7n5DLaUkv7f0r49SCgEImx95ujzq0SSE5YppTT139B
X-Developer-Key: i=quic_jianbinz@quicinc.com; a=ed25519;
 pk=8Qm7Xwv+QY8Y3hGEXPGglY/NRmdGYSKQJh+oPGgX+2c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kc0oZ41Q6-bJuCde1dbohptC0BdChzIb
X-Proofpoint-ORIG-GUID: kc0oZ41Q6-bJuCde1dbohptC0BdChzIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_21,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010013

If the alarm is triggered before the driver gets probed, the alarm interrupt
will be missed and it won't be detected, and the stale alarm settings will
be still retained because of not being cleared.

Issue reproduce step:
(1) set the alarm and poweroff the device
(2) alarm happens and the device boots
(3) poweroff the device again
(4) alarm irq not be cleard, device boots again

the fixing here is clear the interrupt during the step(3) unconditionally.

Signed-off-by: jianbin zhang <quic_jianbinz@quicinc.com>
---
Changes in v4:
- add the cover letter
- modify the patch to conform to the specification

Changes in v3:
- clear the interrupt in driver probe unconditionally
- link: https://lore.kernel.org/linux-rtc/20240319191037.GA3796206@hu-bjorande-lv.qualcomm.com/T/#t

Changes in v2:
- Adapt the V1 patch according to the newest rtc-pm8xxx
- link: https://lore.kernel.org/linux-rtc/20240124024023df15ef6e@mail.local/

Changes in v1:
- fixing is as below logic, During driver probe: read ALARM_EN, read ALARM_DATA, read RTC_RDATA,
  if (ALARM_DATA < RTC_DATA), Trigger the alarm event and clear the alarm settins
- link: https://lore.kernel.org/linux-rtc/20220321090514.4523-1-quic_jianbinz@quicinc.com/

Changes in original:
- link to original: https://lore.kernel.org/linux-rtc/YTusgJlMUdXOKQaL@piout.net/
---
 drivers/rtc/rtc-pm8xxx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index f6b779c12ca7..e4e2307445cf 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -527,6 +527,11 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = regmap_update_bits(rtc_dd->regmap, rtc_dd->regs->alarm_ctrl2,
+					  PM8xxx_RTC_ALARM_CLEAR, 1);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 

-- 
2.43.2


