Return-Path: <linux-kernel+bounces-122518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED20D88F8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2797AB211A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107D54775;
	Thu, 28 Mar 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EmTDRioE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18742C6B8;
	Thu, 28 Mar 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611731; cv=none; b=J0KgemkZn+FFhIIx+zsFDO7BYTVQsGoBHzhJD673KHvacUyWURFZXnpo417aSiNLJHfT+u67lW6Cr9n6RxyyZDLazKlgupwGAagTYV8nOpj4qtu63LgEBN1j+owT4faJ3P7kgM9TxKFMKQLudjYbHkAJlaN51tRJSEPBDIfUj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611731; c=relaxed/simple;
	bh=9w+u06Ne9bTYaw8N9m2xkt2JdE5GVM2iH3eX3tvb+Pg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsEW25ssh6Z/Ef2JKv6zYA+NYfOE+CfoYCSTTv8r6KjuQLHhjuqoKvW/Oq3/kkS3CH2bypwQ6WlgIvyKLLGTw5BesFN6bLA+Du9oPylaGiKbKDuwW+dVIhc1b9yuhdbYU/s2G19ERNVoZj5y7Eoyg2nhQgjK0TDoQXGwTvzf+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EmTDRioE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S3k7s1008187;
	Thu, 28 Mar 2024 07:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ZTCmRJJHcy1tol4M64HRgmOzY2FEmp5fnD9GMFI6ZQc=; b=Em
	TDRioEddvg9JSuz+Hgh5avE6CiwD47wNRRNnI7NYiDPO81zJrAH3JAaWzt3Wjexk
	tPFFleNp3MiIhJmEpY74rx4tzYv+emT9MvoOwtt3/edo7aT5S4hSOXwMdgoCOsFa
	rKpxbQpnFDmRnu/0Hu09ASJHULdU4sAQZabBalhyOaj4JPO9hIsjMu4W8bSR3k8N
	fQ5yln5iUWyCMNJrm71BYv44uYAZOCIliAznceu610mYp7RRrlQKoS/0q9nlSyCP
	UxxW6F+Mm27ApUtSiQKKtzCdjzA/b645gyLrpOfh0FHhyL8/PRYyvNLw+FxxX6Lv
	BYOTHsHycZCqyS2ptl7Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u20acgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:42:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7fxp1016704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:41:59 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:41:55 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 2/2] cpufreq: scmi: Register for limit change notifications
Date: Thu, 28 Mar 2024 13:11:31 +0530
Message-ID: <20240328074131.2839871-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328074131.2839871-1-quic_sibis@quicinc.com>
References: <20240328074131.2839871-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NlwpuC1ladQDIM-Y7RJSncSwwAOXEFAh
X-Proofpoint-GUID: NlwpuC1ladQDIM-Y7RJSncSwwAOXEFAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

Register for limit change notifications if supported and use the throttled
frequency from the notification to apply HW pressure.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
* Use a interim variable to show the khz calc. [Lukasz]
* Use driver_data to pass on the handle and scmi_dev instead of using
  global variables. Dropped Lukasz's Rb due to adding these minor
  changes.

 drivers/cpufreq/scmi-cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 3b4f6bfb2f4c..d946b7a08258 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -21,11 +21,18 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
+struct scmi_cpufreq_driver_data {
+	struct scmi_device *sdev;
+	const struct scmi_handle *handle;
+};
+
 struct scmi_data {
 	int domain_id;
 	int nr_opp;
 	struct device *cpu_dev;
+	struct cpufreq_policy *policy;
 	cpumask_var_t opp_shared_cpus;
+	struct notifier_block limit_notify_nb;
 };
 
 static struct scmi_protocol_handle *ph;
@@ -174,6 +181,22 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
 	NULL,
 };
 
+static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
+	struct scmi_perf_limits_report *limit_notify = data;
+	struct cpufreq_policy *policy = priv->policy;
+	unsigned int limit_freq_khz;
+
+	limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
+
+	policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
+
+	cpufreq_update_pressure(policy);
+
+	return NOTIFY_OK;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -181,6 +204,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
+	struct scmi_cpufreq_driver_data *data = cpufreq_get_driver_data();
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -294,6 +318,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
+	ret = data->handle->notify_ops->devm_event_notifier_register(data->sdev, SCMI_PROTOCOL_PERF,
+							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+							&domain,
+							&priv->limit_notify_nb);
+	if (ret)
+		dev_warn(cpu_dev,
+			 "failed to register for limits change notifier for domain %d\n", domain);
+
+	priv->policy = policy;
+
 	return 0;
 
 out_free_opp:
@@ -366,12 +401,21 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 	int ret;
 	struct device *dev = &sdev->dev;
 	const struct scmi_handle *handle;
+	struct scmi_cpufreq_driver_data *data;
 
 	handle = sdev->handle;
 
 	if (!handle)
 		return -ENODEV;
 
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->sdev = sdev;
+	data->handle = handle;
+	scmi_cpufreq_driver.driver_data = data;
+
 	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
 	if (IS_ERR(perf_ops))
 		return PTR_ERR(perf_ops);
-- 
2.34.1


