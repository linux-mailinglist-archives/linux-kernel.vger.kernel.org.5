Return-Path: <linux-kernel+bounces-102751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794EF87B6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2AD283F58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1FA523C;
	Thu, 14 Mar 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P4WKLS75"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9975382;
	Thu, 14 Mar 2024 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387320; cv=none; b=WG+5DfUY4ZPnaq6pCHPaEKd0GbTqjU333hOdJ8afmxNSSC3OkJ5aN3kr5uqf7CMlWkXaGZgl9MBv6c+lZZaXs+8PwJGBCcvUA4HEpk5YTnbSB8s7OsTSaoC4j5BGUF8z+q9b9BZcNZ/MLWJ8Y8k6NXr/mGrS+RIh7rPIWrka+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387320; c=relaxed/simple;
	bh=NuDzEDNYx6YKKpBICkTZyYKSx1sK/Y/xy3RKoL8Jb6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fro24aE3A6lG27wdh8WLTzyGU65nciIQuBgQ6894mzGkmTGwOxPGvGlAderYsm+SHjCaLRfkew4gLWwDMinqDnKjt4lfOYvUJtpRrtd33+CoUjwL4bEVrZsu23n+2zSA0YyNgFxoyDCYaW4Yl3OJcT0X3f2Y4WvOUUY2D4GTSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P4WKLS75; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E2t1hT019312;
	Thu, 14 Mar 2024 03:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=xTD/5k4skNhdlRysNb4xXP9Vxfsw5BHAK7h7rBCm8ww=; b=P4
	WKLS75xIp5fckK4ZLrDSdfpVLdI8gSCH5IbJcUWInuLidHAziYd5cQ1jxziWW9QJ
	27X9QYathkRdX7mAbFnyjQyXzazeXPf6ia9DAKn7tIKUWbptoCyFdfLYM9xqCHpa
	god69ZqVCi1uNBxTcK9a363DTfY9o7BxgyrwrSrWeIQbkasktNs0FeeFDb61N+24
	/7WlVEfcSbvpy4AbX0QM45rTh5WrazL8M35jptLP5kppK7iqFTNWpBO4OSka3qnN
	WzdwoFyuRcIvKrU+DGUhLbNLKIfWaWWCBLfmiFsWL+myAdEUCAZLFxwCKiA6d5aQ
	kfZ6Pm242NkN+GYQKEDw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuam5j134-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 03:35:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E3Z6ZF030324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 03:35:06 GMT
Received: from jianbinz-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 20:35:04 -0700
From: jianbinz <quic_jianbinz@quicinc.com>
To: <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC: jianbinz <quic_jianbinz@quicinc.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] rtc: rtc-pm8xxx: Correct the PM8xxx_RTC_ALARM_CLEAR vaule in trigger
Date: Thu, 14 Mar 2024 11:34:49 +0800
Message-ID: <20240314033449.10872-1-quic_jianbinz@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IIDOZQm7jgEEmchZa-fnSImiZ_j_w69_
X-Proofpoint-ORIG-GUID: IIDOZQm7jgEEmchZa-fnSImiZ_j_w69_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=861 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140020

Change in v3:
*Correct the vaule that writed into the PM8xxx_RTC_ALARM_CLEAR to 1.

Change in v2:
*Switch to using regmap_update_bits() instead of open coding
read-modify-write accesses.
Link to v2: https://lore.kernel.org/lkml/20230202155448.6715-4-johan+linaro@kernel.org/

Signed-off-by: jianbinz <quic_jianbinz@quicinc.com>
---
 drivers/rtc/rtc-pm8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 1b5a96924e57..8a9be78d0b0b 100644
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
2.17.1


