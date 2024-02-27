Return-Path: <linux-kernel+bounces-83825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED8869EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06021F2C95D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D8514831E;
	Tue, 27 Feb 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZbdMD4Rv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BE14E2C6;
	Tue, 27 Feb 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057835; cv=none; b=JpcpGXpuEWELkGtD0P9wi3+jU1Fl/HH1xZ2Q9OSKeuZvHAJlVO5a+9x9iH7Yqvsiz81/naR4X4bDAUHzZ1fFSoPqvNpLPYAzBTmx4YavblU8zmxeb0szpKUvr5BJEQj8oExoBlJcozlrsiNAPiyf9vU/ArDz1yr3OC0bMDZ87Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057835; c=relaxed/simple;
	bh=VhS2marpAJhmzwdzG68V9UDfvaq1+yzWiwULi+fnfkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcimZDnG3ovzIHj82YdkDOsNwyEfSw8j4h65+nXBvtTYgTAvu3eSGXEuh0E22cM8Kt5EWg7v4hvxdTv48mo8bnWb6Gqv8+KoO7g+oulTf3qlewfBQAquQexvaMOY0UEDsc0CVCnp9KdmrSIuPCUihd+Vlt0SbUau5r/i+YIzUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZbdMD4Rv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RCcQNQ009100;
	Tue, 27 Feb 2024 18:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+XisjrXej/qF+2/kx+HyeD/Uy0VYfx0bpvsKDHSd6lA=; b=Zb
	dMD4RvD6nb6rkgW1n4gxAqDnsi/PZWRqi6PJqdjoKJm5aMfPUd0AojNycK8zS2KW
	NusQ4tXpmoV14nwG1oG4kDFqkU/n5ce86H+k9PD4LEx/xB6XbWwnVgtC8HXStPBW
	CrIxO88EafVxsZ2w68ojAj9kXDVShgemwWasAjOLrPvnlTnIQciR2lNlwMEKid7B
	WDt8K7AzwiSg6UaFolvtZ5uZnKoWPpb7h9e5eRn/NsAXHBepTxzmW0qVxkWhgTsX
	qzXaWb5wQxpKfQAmtSLScdMIXilY8Mqa7JkZNwg5BF+BmVVAoIBTYRmHFdapbsMH
	Rt0RoXk+q7RIaiWnRIKg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wha079q6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:17:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RIGxUm024172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:16:59 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 10:16:55 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 1/2] cpufreq: Export cpufreq_update_pressure
Date: Tue, 27 Feb 2024 23:46:31 +0530
Message-ID: <20240227181632.659133-2-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OKKZYQF4HsyUUVpDTKFWW-lj4JxdRgk3
X-Proofpoint-GUID: OKKZYQF4HsyUUVpDTKFWW-lj4JxdRgk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=925 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402270141

The SCMI cpufreq driver doesn't require any additional signal
smoothing provided by arch_update_hw_pressure interface, export
cpufreq_update_pressure so that it can be called upon directly
instead.

Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 include/linux/cpufreq.h   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 76002aa3d12d..bdec2dfd77eb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2573,7 +2573,7 @@ DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
  *
  * Update the value of cpufreq pressure for all @cpus in the policy.
  */
-static void cpufreq_update_pressure(struct cpufreq_policy *policy)
+void cpufreq_update_pressure(struct cpufreq_policy *policy)
 {
 	unsigned long max_capacity, capped_freq, pressure;
 	u32 max_freq;
@@ -2598,6 +2598,7 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
 	for_each_cpu(cpu, policy->related_cpus)
 		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
 }
+EXPORT_SYMBOL(cpufreq_update_pressure);
 
 /**
  * cpufreq_set_policy - Modify cpufreq policy parameters.
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 414bfc976b30..957bf8e4ca0d 100644
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


