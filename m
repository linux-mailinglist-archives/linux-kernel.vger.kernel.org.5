Return-Path: <linux-kernel+bounces-28858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79F8303D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D57E1C245AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEF41DDF1;
	Wed, 17 Jan 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uj/WFvS3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E71CD0F;
	Wed, 17 Jan 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488334; cv=none; b=NrzoQHZWCdWF+V6Hf2QEaUxs5NArONhFYkDYNliYTSSCKrJtRJDimS+vEkO8Nw5i+vMmfiFhTxEbUI0UH7RzASJfLptmbv0CphLxwHbzoHndH0vKGZDgkueodWM+JqDgHX9ggNaAXCr7SZ68rfFbEaAsDdkfDC57P8bGcN6k0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488334; c=relaxed/simple;
	bh=XcfLDOJO0KheGlrqed/VY433fhHBdiZrnxl+NAWu0Uk=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=iEginncWW1emutUwaKKjnqOhAJbX29BLLSa6ln3b3r7S82451ImSWtJXAq4WIZT7IBPHZaXULanXuTtAVPzupapP1Vkop87uatdJBhZv/NezfveL4aklaA7XTuMy+vB/3NyCFXLgaxVVWv6V1wJ9LIopfb6IwhiCfyesSiIg9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uj/WFvS3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8qVfD001973;
	Wed, 17 Jan 2024 10:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=t5KP79QWXsw25d4MuM/1hHxIP2v8PSUSFp5/Jfqbles=; b=Uj
	/WFvS3qToQSj3ctD0/ojxmr2vh+Lksjm6gCih179kGUhOfTOkyKD0Mh4I7b+MnSN
	qQYyeOpvB6JNsBnnlvT8IPEZDuK/m+wwkun7Fa5QafmGjgmyxF+Tc7xv6CE6wwG3
	awsaQddYzWB4TO2vFDSi+uImqk/NAsUZxiaEKCTJkradE7OnUcCmZBdnmKlUXt0x
	gH88ZAFYCE0oF8pfWEIQV+2tYKnVU7al78y3TMHeYwnk9Jqw6DoKwX4+8J+gq34X
	PfK9tA1PBOB7id4rGHllio8nsosQIsg8AmSL/yrlnFOkKu+GbjrxpE7aUVZgiPkH
	RhmOsqUlKYkFCea8Hmjw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp83frnsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HAjOxk021761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:24 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 02:45:20 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 2/4] firmware: arm_scmi: Add perf_freq_xlate interface
Date: Wed, 17 Jan 2024 16:11:14 +0530
Message-ID: <20240117104116.2055349-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117104116.2055349-1-quic_sibis@quicinc.com>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VGrwATozEGT5m7ahFDPsXj_aDfhyd3KC
X-Proofpoint-GUID: VGrwATozEGT5m7ahFDPsXj_aDfhyd3KC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_05,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170075

Add a new perf_freq_xlate interface to the existing perf_ops to translate
a given perf index to frequency.

This can be used by the cpufreq driver and framework to determine the
throttled frequency from a given perf index and apply HW pressure
accordingly.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Rename opp_xlate -> freq_xlate [Viresh]

 drivers/firmware/arm_scmi/perf.c | 21 +++++++++++++++++++++
 include/linux/scmi_protocol.h    |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ae7681eda276..e286f04ee6e3 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -977,6 +977,26 @@ static int scmi_notify_support(const struct scmi_protocol_handle *ph, u32 domain
 	return 0;
 }
 
+static int scmi_perf_freq_xlate(const struct scmi_protocol_handle *ph, u32 domain,
+				int idx, unsigned long *freq)
+{
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
+
+	if (idx >= dom->opp_count)
+		return -ERANGE;
+
+	if (!dom->level_indexing_mode)
+		*freq = dom->opp[idx].perf * dom->mult_factor;
+	else
+		*freq = dom->opp[idx].indicative_freq * dom->mult_factor;
+
+	return 0;
+}
+
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.num_domains_get = scmi_perf_num_domains_get,
 	.info_get = scmi_perf_info_get,
@@ -992,6 +1012,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.fast_switch_possible = scmi_fast_switch_possible,
 	.power_scale_get = scmi_power_scale_get,
 	.perf_notify_support = scmi_notify_support,
+	.perf_freq_xlate = scmi_perf_freq_xlate,
 };
 
 static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b0947d004826..6221d391386c 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -145,6 +145,7 @@ struct scmi_perf_notify_info {
  * @power_scale_mw_get: indicates if the power values provided are in milliWatts
  *	or in some other (abstract) scale
  * @perf_notify_support: indicates if limit and level change notification is supported
+ * @perf_freq_xlate: translates the given perf index to frequency in Hz
  */
 struct scmi_perf_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
@@ -173,6 +174,8 @@ struct scmi_perf_proto_ops {
 	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
 	int (*perf_notify_support)(const struct scmi_protocol_handle *ph, u32 domain,
 				   struct scmi_perf_notify_info *info);
+	int (*perf_freq_xlate)(const struct scmi_protocol_handle *ph, u32 domain,
+			       int idx, unsigned long *freq);
 };
 
 /**
-- 
2.34.1


