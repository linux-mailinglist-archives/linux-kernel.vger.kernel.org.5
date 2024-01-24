Return-Path: <linux-kernel+bounces-36304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68FD839F20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8761128E77B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D088440A;
	Wed, 24 Jan 2024 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AuaFqQcd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447C1FDC;
	Wed, 24 Jan 2024 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063125; cv=none; b=LYjVpLr6V3O7Il58yyYWFQl8tKZNp4x7cvF9GW/xw2UoqYbDjB262Qng4+T9Qllc0HHkfQwqBbvbFld1qVwFR6ICM1OlIy0hHdefRhTTGJ6FWTTZltuCFuPt3PI7Q88spNHYyZckjhQKO1/p70aZQFf/bhI2+JjW9pgSUEbIs6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063125; c=relaxed/simple;
	bh=hFIfrzWCPj9nLt0OgteJJNKztr2flUthH/Xr/Prkdyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OlAsRHA8gR6Ce3ah6BWMxJ1KfXs5zD8nmJ9vmKSuFJoyhKKQenSHFvB4uGz4dt4pz92LGEWfMo9lNhjoPwTYsN4QvbV9hmtzflkF2Xa7sunL9qpIRpHPPVyZsipIb0U1QpIkJbT0+xgcTN0nwx6R0HWyTT1PM59Jb13yOSHuiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AuaFqQcd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O05vYi005756;
	Wed, 24 Jan 2024 02:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=huc3944qrFK6MGxccYFPxDHeN84EgsRy740zHLv+jlE=; b=Au
	aFqQcdEzgY5Msweg0QGAnrON2S8w2ag4kDduobPbzUdRbZJ8euz983IRMsV8zI99
	x9/JY+Yw3MPlCSKcQQoaP3LsviinAxTFSBtetOnGXxsjvn0rEA75jJkNNRWB+O7m
	fEXX31+L/VcrZgqJtzTG/ma6RbSRDgiUBns5Kltt89jRj5GchP+mMfWnumKrJWYN
	AL+ez+qgQJgWn0BIDi23Xtx3IrqbkGwiVdPedt3QGr/wiAPAff+5QjWXeREj8MbO
	taKR90zDeMZIssbESNNsUP+reFhzRVhqH5N680+u3AKhqpKdgYhH3igu7UEZibbS
	rIFAXPc+bSkj3ZGfTt6g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmhr0jj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:25:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O2PCZU032565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:25:12 GMT
Received: from jianbinz-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 18:25:10 -0800
From: jianbinz <quic_jianbinz@quicinc.com>
To: <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC: jianbinz <quic_jianbinz@quicinc.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [Resend PATCH v2 1/1] rtc: rtc-pm8xxx: Retrigger RTC alarm if it's fired
Date: Wed, 24 Jan 2024 10:24:43 +0800
Message-ID: <20240124022443.21867-1-quic_jianbinz@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ISgVKRBqUTPj8h1EtrpYLOcxhF2j_Sxv
X-Proofpoint-GUID: ISgVKRBqUTPj8h1EtrpYLOcxhF2j_Sxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=898 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401240016

If the alarm is triggered before the driver gets probed, the alarm
interrupt will be missed and it won't be detected, and the stale
alarm settings will be still retained because of not being cleared.
Check this condition during driver probe, retrigger the alarm and
clear the settings manually if it's such case.

Changes in v2:
*Adapt the V1 patch according to the newest rtc-pm8xxx

Changes in v1:
*During driver probe: read ALARM_EN, read ALARM_DATA, read RTC_RDATA,
if (ALARM_DATA < RTC_DATA), Trigger the alarm event and clear the alarm settins
Link to v1:https://lore.kernel.org/linux-rtc/20220321090514.4523-1-quic_jianbinz@quicinc.com/

Signed-off-by: jianbinz <quic_jianbinz@quicinc.com>
---
 drivers/rtc/rtc-pm8xxx.c | 57 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index f6b779c12ca7..eac4e7f23aaa 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -309,21 +309,33 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	return 0;
 }
 
+static int pm8xxx_rtc_read_alarm_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
+{
+	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+	u8 value[NUM_8_BIT_RTC_REGS];
+	int rc;
+
+	rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value, sizeof(value));
+	if (rc)
+		return rc;
+
+	*secs = get_unaligned_le32(value);
+
+	return 0;
+}
+
 static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
-	u8 value[NUM_8_BIT_RTC_REGS];
 	unsigned int ctrl_reg;
 	u32 secs;
 	int rc;
 
-	rc = regmap_bulk_read(rtc_dd->regmap, regs->alarm_rw, value,
-			      sizeof(value));
+	rc = pm8xxx_rtc_read_alarm_raw(rtc_dd, &secs);
 	if (rc)
 		return rc;
 
-	secs = get_unaligned_le32(value);
 	secs += rtc_dd->offset;
 	rtc_time64_to_tm(secs, &alarm->time);
 
@@ -398,6 +410,39 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Trigger the alarm event and clear the alarm settings
+ * if the alarm data has been behind the RTC data which
+ * means the alarm has been triggered before the driver
+ * is probed.
+ */
+static int pm8xxx_rtc_init_alarm(struct pm8xxx_rtc *rtc_dd)
+{
+	int rc;
+	u32 alarm_sec, rtc_sec;
+	unsigned int ctrl_reg, alarm_en;
+	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+
+	rc = pm8xxx_rtc_read_raw(rtc_dd, &rtc_sec);
+	if (rc)
+		return rc;
+
+	rc = pm8xxx_rtc_read_alarm_raw(rtc_dd, &alarm_sec);
+	if (rc)
+		return rc;
+
+	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
+	if (rc)
+		return rc;
+
+	alarm_en = !!(ctrl_reg & PM8xxx_RTC_ALARM_ENABLE);
+
+	if (alarm_en && rtc_sec >= alarm_sec)
+		pm8xxx_alarm_trigger(0, rtc_dd);
+
+	return 0;
+}
+
 static int pm8xxx_rtc_enable(struct pm8xxx_rtc *rtc_dd)
 {
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
@@ -527,6 +572,10 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = pm8xxx_rtc_init_alarm(rtc_dd);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
-- 
2.17.1


