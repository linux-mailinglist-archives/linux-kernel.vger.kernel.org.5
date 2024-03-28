Return-Path: <linux-kernel+bounces-122516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EC88F8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4208297929
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5C5381E;
	Thu, 28 Mar 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H8Px2FPr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EE1EF0E;
	Thu, 28 Mar 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611729; cv=none; b=eiV8UJKLB4CjdeF2E/84v9J1GlxrB6qZqNnbcDyNt/nM7UhWkf9k3kZOrErJw8Kbm0c7lzDBhDhLVLrgjaZvonH/nX33wYcgt4hYmQj+19U32NCkeUrdCf2DJjLAmBMjIrpnxe++FtBxdkULLxmReZl+UEDGpa6MmECe79LqZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611729; c=relaxed/simple;
	bh=B2NQLnfrMKDnXljb6AV2F1GcYBsPOWnJ1u4ulbgQ+jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4bQBzgGNHYPbG886pJJ8Vc8KFkYWvC+mJaqL3sNmBkp/kToetl6SCp4xEna5Z2PRXcsCvQOx9sSiVwC308/NOnf9PZxfcZmkNyePsCEcbRk6xgm4+/RLs8368gF2TrrVcxkbcDtxyRASV+eiuVg13KgGm9ljbs5pQqbXaJyM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H8Px2FPr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S4BphL029571;
	Thu, 28 Mar 2024 07:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=drb69SBwlfCleDTP31exbb1vs06Ku/JLJT2ZasNqYfs=; b=H8
	Px2FPr9HcEQkEbWeKZhwFMrq36rWgqxf4zcwno5pQSSuzgcXVoBwawe3beoJlAdr
	S2Ar8ry5v28kSOxYDiQfvs9IFeoV2q0fzsVYVcXMEt/aF+L5GZg2GBYqeu6EjODL
	EROk71+llThmwU6+oXT+njiSug0MCEkRR2ZzY+uqv0u7HqhH1hEUmgLLDwIBMjpZ
	F921L6OyJktEYRBVxbv8R+5yR6mmQCZZTIiy7I1D1uNHUF50Q+x6ZBBHJ0s77zpj
	S6CM9dQurWgpaR+IlxNslcAyp0FjfQPZOl+3UliX8QYUjG6IcsG6eslC+XErUvjF
	Zf4JhHIUyVr3wR1TKtDg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wjcfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:41:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7ftTF028054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:41:55 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:41:50 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 1/2] cpufreq: Export cpufreq_update_pressure
Date: Thu, 28 Mar 2024 13:11:30 +0530
Message-ID: <20240328074131.2839871-2-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: BZM9InMquIEwRtoy6xJDTrS08nxiFq-U
X-Proofpoint-ORIG-GUID: BZM9InMquIEwRtoy6xJDTrS08nxiFq-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=938 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

The SCMI cpufreq driver doesn't require any additional signal
smoothing provided by arch_update_hw_pressure interface, export
cpufreq_update_pressure so that it can be called upon directly
instead.

Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
* Use EXPORT_SYMBOL_GPL instead. [Trilok]

 drivers/cpufreq/cpufreq.c | 3 ++-
 include/linux/cpufreq.h   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1de8bd105934..656320554bb7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2590,7 +2590,7 @@ DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
  *
  * Update the value of cpufreq pressure for all @cpus in the policy.
  */
-static void cpufreq_update_pressure(struct cpufreq_policy *policy)
+void cpufreq_update_pressure(struct cpufreq_policy *policy)
 {
 	unsigned long max_capacity, capped_freq, pressure;
 	u32 max_freq;
@@ -2615,6 +2615,7 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
 	for_each_cpu(cpu, policy->related_cpus)
 		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
 }
+EXPORT_SYMBOL_GPL(cpufreq_update_pressure);
 
 /**
  * cpufreq_set_policy - Modify cpufreq policy parameters.
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20f7e98ee8af..7410a1bade23 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -241,6 +241,7 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
 bool has_target_index(void);
+void cpufreq_update_pressure(struct cpufreq_policy *policy);
 
 DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
 static inline unsigned long cpufreq_get_pressure(int cpu)
@@ -270,6 +271,7 @@ static inline bool cpufreq_supports_freq_invariance(void)
 }
 static inline void disable_cpufreq(void) { }
 static inline void cpufreq_update_limits(unsigned int cpu) { }
+static inline void cpufreq_update_pressure(struct cpufreq_policy *policy) { }
 static inline unsigned long cpufreq_get_pressure(int cpu)
 {
 	return 0;
-- 
2.34.1


