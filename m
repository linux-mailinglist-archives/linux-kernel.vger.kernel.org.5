Return-Path: <linux-kernel+bounces-83739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E3869DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26C028E462
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6AE14AD22;
	Tue, 27 Feb 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MhnvY/Iw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD5149DF2;
	Tue, 27 Feb 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055324; cv=none; b=ArYT5oi+LHbTMyFVyH2WSUsPU76Wx4woLWhd9cjUmF7/zdrWSt6HutgTDdrvIuyf6ImgPjGkktrjGY5Qdu45Ajfzq1clt4IbYLqhnLh6u5nJemWBJUfO198OZUZkScUr9Mcc1TgLUImaSq2h4drDI7dW2fktqA9Yxawo62IP1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055324; c=relaxed/simple;
	bh=Z5k2hix+Fr7+hFF9XlR19tkcXSwIfZLoKyOcbeHHkBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+k6u/Bcz7u9AFtndU1FDJq7P0HYFTF0Laf85X39v93cQSXGVkobsMw3UVagFAygBCR0hLdYBYK2+MNPTgMlqwCwN634t3QlC8ChVyYMjLmTSUatTD7bnFnAtSQZpWFsKTRO9eSem0x2dF6yyfDC8fUTCG3GTKj7ixKESmLtMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MhnvY/Iw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9YUO1007412;
	Tue, 27 Feb 2024 17:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=3DVviJxlVwNwJ3tgr3xc9D3SdLGkFfeDO3OWztz/lP0=; b=Mh
	nvY/Iw1tO+NOxDIQYGcO+52fRBjG8UGGCk+Dv8XTgqvDGwt0VUcXcMKvLWVu8v17
	oFawAwPNgZhpLlsP7srAagog3NF+/KLqS1IzWp5kWR9GMOvQiXd5Ykv8fIh6xyD9
	Nn13axSbm5R+Uw8oY3xU0LDmR9xCWbgsCyYf8yU18S55QPzyW4mBND92XsgUf4jq
	7uidfan8d24LDYFVtTkTcLmg58+XzkBmIUuDNl8rTCV4JVcqql3uCSviLULswgrw
	nPlm44rL7btjL3/z/FwpCRn4Ng7Ih7+h20P5ehBlrbF9S9DeDBuNyyCcjt9LZ3zj
	or7FyS5fhK97rhHEyr2A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8auhtj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:35:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RHZC95029837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:35:12 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 09:35:07 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH V2 2/3] firmware: arm_scmi: Add support for marking certain frequencies as boost
Date: Tue, 27 Feb 2024 23:04:33 +0530
Message-ID: <20240227173434.650334-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227173434.650334-1-quic_sibis@quicinc.com>
References: <20240227173434.650334-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9dE-JkPRBvVKzooJpGHXh_vlnrL04KbW
X-Proofpoint-GUID: 9dE-JkPRBvVKzooJpGHXh_vlnrL04KbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270135

All opps above the sustained level/frequency are treated as boost, so mark
them accordingly.

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Remove sustained_freq check. [Pierre]
* simplify sustained_freq_khz calculation. [Sudeep]

 drivers/firmware/arm_scmi/perf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 981e327e63e3..caf6191df300 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -850,7 +850,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 				     struct device *dev, u32 domain)
 {
 	int idx, ret;
-	unsigned long freq;
+	unsigned long freq, sustained_freq;
 	struct dev_pm_opp_data data = {};
 	struct perf_dom_info *dom;
 
@@ -858,12 +858,18 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
+	sustained_freq = dom->sustained_freq_khz * 1000UL;
+
 	for (idx = 0; idx < dom->opp_count; idx++) {
 		if (!dom->level_indexing_mode)
 			freq = dom->opp[idx].perf * dom->mult_factor;
 		else
 			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
 
+		/* All opps above the sustained level/frequency are treated as boost */
+		if (freq > sustained_freq)
+			data.turbo = true;
+
 		data.level = dom->opp[idx].perf;
 		data.freq = freq;
 
-- 
2.34.1


