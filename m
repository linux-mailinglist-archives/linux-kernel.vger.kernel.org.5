Return-Path: <linux-kernel+bounces-28881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03284830427
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EF21C20FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3C1DFD4;
	Wed, 17 Jan 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fFDTp5xj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C411DFD5;
	Wed, 17 Jan 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489525; cv=none; b=Ao+nUD152SEu0bP2H2BY0VPEKFEvsNv4QgEloDceEEFXRoF9lVF7WzD32xW/OZ8pXY1ntxzTV8quSofYJ7nmPWc8w8s6b5bL9Zwbvv38CBqA48blnV/r+yuf0lSH2p14H1FAzvMjIgWpNB4L50Xhhy3kl889dHFUuBbso4QZEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489525; c=relaxed/simple;
	bh=ad/wOoguBLGYvhj5gNQaZt002NeQWHQfD8deCfP5XRM=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=rgoYDwAavSr+CJdTy99PEFHFUjTvvmwEeu+UwgoqpwMBwH+9FWcqRPpcdrytRQTgrLK77walKX56brkqYegn4UQ0WMfXnD9tsIY+mdOnIt0pHHLomv6ncb9UoCU0JWrKsghAlEOm1PkraO5LE32jZALtJtsuk3gt/J7mDePCIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fFDTp5xj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H48Wrl011339;
	Wed, 17 Jan 2024 11:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kIBM+GHgT/wUh9R8cGaTg7wnwnKkMQJIMeU6iA7gLtI=; b=fF
	DTp5xjiWVK9uN/tjubBc6Rrp2/oj801Gk4xFd/vybuWQcnqg1H5qTdDvD+gB8EB3
	K8CfhIvnunncLg04+uvAQwpvl3lK9Z0LDj3cx8g/bNsKkpS/mpjHQueptX0WRqOe
	eYv9CycvULBwTC+rd7XZg87X2aKTGTSHHfc2X8PukzPLF+XI+ILyxDTHpcgQpmNa
	7xwGfeFvzXWoHbpYoCpBE8Fe48Ss/VW1QWVuwiWG5rddVux+hV7BF+J/JUCAiIQx
	HjmyUhBhfGaXtkQXpQJOJm6Qfy+hhE53/jLLQYTVeiuAnKgguqyuOM9aH4XI5M+o
	4Mjb8dcywpl49q1AhVKQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6sqrv3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 11:05:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HB5DAF013494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 11:05:13 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 03:05:08 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH 2/3] firmware: arm_scmi: Add support for marking certain frequencies as boost
Date: Wed, 17 Jan 2024 16:34:42 +0530
Message-ID: <20240117110443.2060704-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117110443.2060704-1-quic_sibis@quicinc.com>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c-LF6AQ3b8-Dre2U12eZ1yB6MKmVYtj4
X-Proofpoint-ORIG-GUID: c-LF6AQ3b8-Dre2U12eZ1yB6MKmVYtj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=984 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170078

All opps above the sustained level/frequency are treated as boost, so mark
them accordingly.

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index e286f04ee6e3..d3fb8c804b3d 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -811,7 +811,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 				     struct device *dev, u32 domain)
 {
 	int idx, ret;
-	unsigned long freq;
+	unsigned long freq, sustained_freq;
 	struct dev_pm_opp_data data = {};
 	struct perf_dom_info *dom;
 
@@ -819,12 +819,21 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
+	if (!dom->level_indexing_mode)
+		sustained_freq = dom->sustained_perf_level * dom->mult_factor;
+	else
+		sustained_freq = dom->sustained_freq_khz * dom->mult_factor;
+
 	for (idx = 0; idx < dom->opp_count; idx++) {
 		if (!dom->level_indexing_mode)
 			freq = dom->opp[idx].perf * dom->mult_factor;
 		else
 			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
 
+		/* All opps above the sustained level/frequency are treated as boost */
+		if (sustained_freq && freq > sustained_freq)
+			data.turbo = true;
+
 		data.level = dom->opp[idx].perf;
 		data.freq = freq;
 
-- 
2.34.1


