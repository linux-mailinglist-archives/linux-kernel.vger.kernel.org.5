Return-Path: <linux-kernel+bounces-83827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97C869EED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A979BB23568
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD23158D8F;
	Tue, 27 Feb 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="phSOurph"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78111487D8;
	Tue, 27 Feb 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057848; cv=none; b=iYbLcmIK7ElVQkEmpAVpa181efoU0T0jtH2ec0JBWH9ci0/0xRlWqnO4cvXuw16SAPOjy4ddqx495bgJ/Bhi5ArnZNeeR5BXgIzFoBE1/LrgTP6hK77tGguS9DJz5hIguOeKh0e+pGssiT8uLIIOQQjYqfxE268FUEA19hTcrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057848; c=relaxed/simple;
	bh=zAsfk+v4hJQHezpar3y9bfxnsJGJOGSKx2JbFHeCxXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLlHk+I5c6QFAQrkyV+v/Cp/M+XNGmvpnAErszNo+cSzaetdM0ECd+396V8pdcIXZ5pvDx/5j/EjHJLyl4QIy+XY1io06shPop9rZysh10CPXRe2Tjsd7QFgk5g9++z83oqw/Ahh5p8IUjNQZqXEZYgLMqNk1YN+Lk7WR4i8yoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=phSOurph; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9Y43L004484;
	Tue, 27 Feb 2024 18:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ornixnyEGdWMbFwNeDMGNQb9hYIkJYlnDtUaJ6GrfQ8=; b=ph
	SOurphNJeuGw3Lsf1A0AT6CsAzIuey4z21gIpqJ4hErPFuknPAGR5pPbhjqemBnR
	8IEPKqjhxlxbiIfXDoQ+vAZ4bHBrIQjYh9F5vIJ0a01XN0icou2fIzm3o3VrdQAV
	DGWwL4veU0Gaq6RDF0/4pHcUIJXrqvtU3wB82laHU868aYPvJEzNu7r9Ycu9Ahz9
	/EWAmLLe7jjfgacAPbTkDKuf7HEpwCuZNtH+HhCOQOH0nruIfkBes/qV8mGvV2aZ
	Deu65RpXf1kKd67vYMFPi0ONr4eNf+rwbpvl55cd52NpNKLl6Dz2r83FUs2H+U0D
	EH4FJMYhUYimpMHIrf5w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whd7b18t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:17:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RIH3Ae010219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:17:03 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 10:16:59 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 2/2] cpufreq: scmi: Register for limit change notifications
Date: Tue, 27 Feb 2024 23:46:32 +0530
Message-ID: <20240227181632.659133-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227181632.659133-1-quic_sibis@quicinc.com>
References: <20240227181632.659133-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: ZEb7q_z4kIURjHSXm1GTUsykMg-r9OjA
X-Proofpoint-ORIG-GUID: ZEb7q_z4kIURjHSXm1GTUsykMg-r9OjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270142

Register for limit change notifications if supported and use the throttled
frequency from the notification to apply HW pressure.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
* Sanitize range_max received from the notifier. [Pierre]
* Update commit message.

 drivers/cpufreq/scmi-cpufreq.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 76a0ddbd9d24..78b87b72962d 100644
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
 static struct cpufreq_driver scmi_cpufreq_driver;
@@ -151,6 +155,20 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
 	NULL,
 };
 
+static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
+	struct scmi_perf_limits_report *limit_notify = data;
+	struct cpufreq_policy *policy = priv->policy;
+
+	policy->max = clamp(limit_notify->range_max_freq/HZ_PER_KHZ, policy->cpuinfo.min_freq,
+			    policy->cpuinfo.max_freq);
+
+	cpufreq_update_pressure(policy);
+
+	return NOTIFY_OK;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -269,6 +287,15 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		}
 	}
 
+	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
+	ret = handle->notify_ops->devm_event_notifier_register(scmi_dev, SCMI_PROTOCOL_PERF,
+							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
+							&domain,
+							&priv->limit_notify_nb);
+	if (ret)
+		dev_warn(cpu_dev,
+			 "failed to register for limits change notifier for domain %d\n", domain);
+
 	priv->policy = policy;
 
 	return 0;
@@ -342,8 +369,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
 	struct device *dev = &sdev->dev;
-	const struct scmi_handle *handle;
 
+	scmi_dev = sdev;
 	handle = sdev->handle;
 
 	if (!handle)
-- 
2.34.1


