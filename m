Return-Path: <linux-kernel+bounces-126402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6188936D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7F1F215B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0E8C1E;
	Mon,  1 Apr 2024 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JTIMJvHR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DD4683;
	Mon,  1 Apr 2024 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711936636; cv=none; b=VDYp/cCp2wPuJwSGA+k1bOI9AdH4ZPC7VYIzwmstWSCmFJTie7F6wxAuZqnsXwwNX1AFc9Osi5//Fa0GjjHvLi6ftapBeYgwPcXLVIldaWKCyH4/1w2c5AE2OdO4HyVpvLf9mEinKuKMNLdGn+mud9WA9xjHC0rAf+m9nKl8eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711936636; c=relaxed/simple;
	bh=MWWUYfBfJ+W+K7MWTchapqC1K1oEOTbwWXy3pHBvkxw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CfjsHXEWSPY6zvLfNi0MUwuIMq/BLAFxM28PSLCI/aRoP5iWqgsYPTG10Yhj9kzZj1/J/Cy2iXwELVtlL4vdtO8suJm41z+epDgrA+JyACR9/7lJzEAfhE//ZBNUp6qwBWItUcCe8kwPiW+uej8dxkWjvCQZB5MrzkPqL3wqp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JTIMJvHR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4311gHTl031750;
	Mon, 1 Apr 2024 01:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=GAkLdLSYFHmFYC
	lUBJFWkUPMHRmzAIsktPBWFnF+tCY=; b=JTIMJvHRu7WS85OY2hAKshTHYEr8OV
	lVkD0oYp0aD6rEPGuB9wEbhBZpu4z5WlqYEHrCPQSLMMQI2N+PpQ6V++siuM+kwu
	wtZyLyKTb0DoUjse+UNod+DMp41B/VlR1S9K07xRSNgorZ/hNijEK2Ybw4nuFRe1
	l0r1ftu3h8zwhSG0+fI8K53iQdfbHehmvgYl+w/EmdzLErdUWD+fDEcgOQ9N9Y+N
	6oTPwwGvP4+iLfMLaZIpy3KbGAq6ezHNV9Zaxn/+OjhlnztulIylTaPyHsah0Ide
	LtmWIfi6tRuA/SSDKUYeUVriW49iGCTGUjZR7gmFaGyl4HKh/Ik/LdrQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x69pvtx3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 01:56:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4311uuEC009280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 01:56:56 GMT
Received: from jianbinz-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 31 Mar 2024 18:56:53 -0700
From: jianbin zhang <quic_jianbinz@quicinc.com>
Subject: [PATCH v4 0/2] rtc-pm8xxx: fix rtc alarm which fired before driver
 probe not be cleard
Date: Mon, 1 Apr 2024 09:56:28 +0800
Message-ID: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-0-aab2cd6ddab8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0UCmYC/x2NwQ6CMBAFf4Xs2U1KhaB+iBfjobQPuwm2ZEvQh
 PDvNh5nDjM7Faig0K3ZSbFJkZwqtKeGfHTpBZZQmayxnTnbK0/yZV09u9npmz9RfKxOEXjElBU
 cVDYoL5pHcMpr9exnOA1sBm/bi0Hfm4HqYVHU3P/+oHtHz+P4AWgKYvmRAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        jianbin zhang <quic_jianbinz@quicinc.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711936613; l=1607;
 i=quic_jianbinz@quicinc.com; s=20240329; h=from:subject:message-id;
 bh=MWWUYfBfJ+W+K7MWTchapqC1K1oEOTbwWXy3pHBvkxw=;
 b=xZuifqRCbJMCACnTkYoyyYGiltQ0nZfzdGAx7rRLd+j2TWwU0Ox9M0075nxW7SYwDDcsYmg3U
 T16fR98PXRJAdUE1ZCLlpIJyhTI4MdzGHrXUL/47dujNAFcbEsig4Su
X-Developer-Key: i=quic_jianbinz@quicinc.com; a=ed25519;
 pk=8Qm7Xwv+QY8Y3hGEXPGglY/NRmdGYSKQJh+oPGgX+2c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v_cfyh0-Ds5N7P1nEJB0UAqf-foGbg44
X-Proofpoint-GUID: v_cfyh0-Ds5N7P1nEJB0UAqf-foGbg44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_21,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=749 clxscore=1011 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010013

Hi maintainers,

In this v4 patch series include following:
- Fix the issue that rtc alarm interrupt triggered befor driver probe is not cleared
- Correct the value written into PM8xxx_RTC_ALARM_CLEAR register in trigger function

Regarding the issue "Fix the issue that rtc alarm interrupt triggered befor driver probe is not cleared":
- Issue describtion as following
  If the alarm is triggered before the driver gets probed, the alarm interrupt
  will be missed and it won't be detected, and the stale alarm settings will
  be still retained because of not being cleared.
- Issue reproduce step:
  (1) set the alarm and poweroff the device
  (2) alarm happens and the device boots
  (3) poweroff the device again
  (4) alarm irq not be cleard, device boots again

Regarding "Correct the value written into PM8xxx_RTC_ALARM_CLEAR"
- Writing 1 to the register is expected to clear the fired alarm
 register. In patch v2, the value written to the register in the
 trigger function is incorrectly written as 0. So correct the value
 to 1.

Signed-off-by: jianbin zhang <quic_jianbinz@quicinc.com>
---
jianbin zhang (2):
      rtc-pm8xxx: clear the triggered alarm interrupt during driver probe
      rtc-pm8xxx: Correct the value written into the PM8xxx_RTC_ALARM_CLEAR

 drivers/rtc/rtc-pm8xxx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 317c7bc0ef035d8ebfc3e55c5dde0566fd5fb171
change-id: 20240329-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-07c2180e5507

Best regards,
-- 
jianbin zhang <quic_jianbinz@quicinc.com>


