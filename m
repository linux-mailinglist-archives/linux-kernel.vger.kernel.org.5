Return-Path: <linux-kernel+bounces-28860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85A8303DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F011C24C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FB1DFFB;
	Wed, 17 Jan 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjkEUpgY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FF1E89F;
	Wed, 17 Jan 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488344; cv=none; b=Xmp+CCEDa71qEAv/8+pXoSep2M4Q/mUwdHU2cVXSgR4gXCc0slrKrzKDGx+Yw+C63SHZloCRKST8g4Yp/4kMsbAPqcUN2IDglt8QJ9HxcV+GKXLHVlJqj5loSTwRSw1Omw2jLA4I3ng3IUTNBRv6Ocjd0N1dwEA2kdYRYma2s7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488344; c=relaxed/simple;
	bh=Ev/G7YkqVnj6LyyIzJAKaxRPGl6XNLa62IS6wWs+0/o=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=SU7rUsL1DqkW3ew0VfuKkre5QAzuVBaNonda2aeEskZUlyCQijC1av1ZZxRMn/BXNl6x5BxEfupTjdv1oYpI277RZzIoysG4/pY6zTRMaKHe2Lk07XjUs2pW3kwv6le0PSvgaod2wF07VqOsQbPKqQXS8Hj9kuhkqcVRrC+JaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FjkEUpgY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H79vY6006351;
	Wed, 17 Jan 2024 10:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jOlwglCt4leERfiObcjYf6erEXXX2+qP0gHWqy5dMHg=; b=Fj
	kEUpgYLLOEXzW8uh2Ez7uSGemIKa6RyHJh0TwGOlgROf0Ba2Q8Txmj6OaQscLJu6
	fSF5dJCTG9zWML5bzc3NHvZ9rrKQ8TSyb2XBT4JlAqZabKkYGhaPSYqgriw5IBuS
	QS7Oz/tJbf8RLZoX1QZYVhzo/BWuI6/amOsTgDrwz7uMZoSHnKztKz1/LiJ6T771
	NSuIR9BlU0TcARoWdZw3bKbJig+S58+JNdwZffxi+kfHwW+zoeSclLT/JmZm5/x+
	O7w6vCJ1+KhdtmJsVkR5bAAdlvLcPG5BN45fi60GBBaxhEVt4nUplFWhYro/Y94Q
	sj4kTQM4cn9LbdLVGTzg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpa1erer1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HAjXe3023691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:33 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 02:45:29 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 4/4] cpufreq: scmi: Register for limit change notifications
Date: Wed, 17 Jan 2024 16:11:16 +0530
Message-ID: <20240117104116.2055349-5-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: v8jC1YldiZ1CpvO-ai1XGUi5OZ9oVPeJ
X-Proofpoint-ORIG-GUID: v8jC1YldiZ1CpvO-ai1XGUi5OZ9oVPeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_05,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170075

Register for limit change notifications if supported with the help of
perf_notify_support interface and determine the throttled frequency
using the perf_freq_xlate to apply HW pressure.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Export cpufreq_update_pressure and use it directly [Lukasz]

 drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4ee23f4ebf4a..e0aa85764451 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -25,9 +25,13 @@ struct scmi_data {
 	int domain_id;
 	int nr_opp;
 	struct device *cpu_dev;
+	struct cpufreq_policy *policy;
 	cpumask_var_t opp_shared_cpus;
+	struct notifier_block limit_notify_nb;
 };
 
+const struct scmi_handle *handle;
+static struct scmi_device *scmi_dev;
 static struct scmi_protocol_handle *ph;
 static const struct scmi_perf_proto_ops *perf_ops;
 
@@ -144,6 +148,22 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	return 0;
 }
 
+static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	unsigned long freq_hz;
+	struct scmi_perf_limits_report *limit_notify = data;
+	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
+	struct cpufreq_policy *policy = priv->policy;
+
+	if (perf_ops->perf_freq_xlate(ph, priv->domain_id, limit_notify->range_max, &freq_hz))
+		return NOTIFY_OK;
+
+	policy->max = freq_hz / HZ_PER_KHZ;
+	cpufreq_update_pressure(policy);
+
+	return NOTIFY_OK;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -151,6 +171,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
+	struct scmi_perf_notify_info info = {};
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -250,6 +271,25 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		perf_ops->fast_switch_possible(ph, domain);
 
+	ret = perf_ops->perf_notify_support(ph, domain, &info);
+	if (ret)
+		dev_warn(cpu_dev, "failed to get supported notifications: %d\n", ret);
+
+	if (info.perf_limit_notify) {
+		priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
+		ret = handle->notify_ops->devm_event_notifier_register(scmi_dev, SCMI_PROTOCOL_PERF,
+							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+							&domain,
+							&priv->limit_notify_nb);
+		if (ret) {
+			dev_err(cpu_dev, "Error in registering limit change notifier for domain %d\n",
+				domain);
+			return ret;
+		}
+	}
+
+	priv->policy = policy;
+
 	return 0;
 
 out_free_opp:
@@ -321,8 +361,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
 	struct device *dev = &sdev->dev;
-	const struct scmi_handle *handle;
 
+	scmi_dev = sdev;
 	handle = sdev->handle;
 
 	if (!handle)
-- 
2.34.1


