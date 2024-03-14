Return-Path: <linux-kernel+bounces-102750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1FD87B6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9F41C21807
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E66522E;
	Thu, 14 Mar 2024 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="im4JxuWT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A22C9E;
	Thu, 14 Mar 2024 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387266; cv=none; b=AtoEHtAiwmBNwmXAZzPZxWcM5hckZ7NjfmOoTGQ1q6sFcPVOLug9kmmEv7+n7FiexZ7Gr2EI+Ac8SORLFjKgYQT1WagErM3jRO6sjm8593t7WrMeNqAXegMYTrlDdcU8TSDmR/tAbR+7GIQkcy8pFQ37ZZgflcO8pM0VZqlQJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387266; c=relaxed/simple;
	bh=sMCI+Eki3k6bMGoPCwpX7UtcUSX85eB7VdABW3sdS88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oByWZhCHydl7TN0wj864rRRzvcwpoEHfa4OCFPvtdjyz52iNzM53E4WeEULrd3v/FpUTEpdNqRrMVsxmOd0PFN2tUf6HhujcUO/fNI5eMVvVFOWyCOvbXQrKYhCpXEtrmW5V0lit0YYP7PTCOsGa8apqwHd8iICGs/maDB6MLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=im4JxuWT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E3ME3L023173;
	Thu, 14 Mar 2024 03:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=V25r6/TDI+6iO9K99zk/ZBZ3Oe1/Km8mgnWrUIzMNsk=; b=im
	4JxuWTgopI3LU1c74HSp0PQ16oeXEIPAnBa1+NRc1p2InAGpSFXvhzku6ZQTqDMP
	2zJqvtpUDLf+DoJCFz65OGEjVLTi57BT81UrhA6U6R2aK4cv9BTsynwbJNqilbCT
	X5iwANRcrozc2eIUnlARkJRR8LqwLml7edORHRMFnwcVz+hmvmUxLGmqIKaLRcdM
	728RDa+Zaj2N/+oqRo1v6kt+xAMOPBoh8SilhLkoh7w2dMvytmY1L52wAYTTVsNe
	CRkwAxLw5i5kBTDQW+sX7DNWbpKl8ekLycUnksZCZzTeEkMs/BVUFqKa/cbkNuPs
	uRn/1f9srWRkkKTHvcfg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuggr15d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 03:34:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E3YDLi029515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 03:34:13 GMT
Received: from jianbinz-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Mar 2024 20:34:11 -0700
From: jianbinz <quic_jianbinz@quicinc.com>
To: <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC: jianbinz <quic_jianbinz@quicinc.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] rtc: rtc-pm8xxx: clear the interrupt in probe
Date: Thu, 14 Mar 2024 11:33:44 +0800
Message-ID: <20240314033344.10775-1-quic_jianbinz@quicinc.com>
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
X-Proofpoint-GUID: GvA417Q_5vJcp1ApofK7cPTS919vEJVB
X-Proofpoint-ORIG-GUID: GvA417Q_5vJcp1ApofK7cPTS919vEJVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=901 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140021

If the alarm is triggered before the driver gets probed, the alarm
interrupt will be missed and it won't be detected, so clear the
stale interrupt in probe.

Changes in v3:
*clear the interrupt in driver probe

Changes in v2:
*Adapt the V1 patch according to the newest rtc-pm8xxx
link to v2: https://lore.kernel.org/linux-rtc/20240124024023df15ef6e@mail.local/

Changes in v1:
*During driver probe: read ALARM_EN, read ALARM_DATA, read RTC_RDATA,
if (ALARM_DATA < RTC_DATA), Trigger the alarm event and clear the alarm settins
Link to v1:https://lore.kernel.org/linux-rtc/20220321090514.4523-1-quic_jianbinz@quicinc.com/

Changes in original:
link to original: https://lore.kernel.org/linux-rtc/YTusgJlMUdXOKQaL@piout.net/

Signed-off-by: jianbinz <quic_jianbinz@quicinc.com>
---
 drivers/rtc/rtc-pm8xxx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index f6b779c12ca7..1b5a96924e57 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -527,6 +527,10 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = regmap_update_bits(rtc_dd->regmap, rtc_dd->regs->alarm_ctrl2, PM8xxx_RTC_ALARM_CLEAR, 1);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
-- 
2.17.1


