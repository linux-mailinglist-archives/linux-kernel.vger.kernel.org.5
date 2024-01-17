Return-Path: <linux-kernel+bounces-28859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B48B8303DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A9B28AA46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929C413FF5;
	Wed, 17 Jan 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ew1B2G7H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D851DFE3;
	Wed, 17 Jan 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488338; cv=none; b=r4odsnrNB8ZyVuMMFTd5jOdrTsPvoQx9lqDLs1N+lAOlR5o1ibPV76pzUIoXUg8CMhvnGtN4WRHX2lIz7leHeRKl36XUlc51PHcncakqrBf1qEe6d2tySCxrUUDQNBRMWxBZ2ksZc7J8ZGGWcL9zvLE3jawVv7w3htwhQEKyu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488338; c=relaxed/simple;
	bh=Fz3iaZzzJ7//KORWCiTXcEASDzK0xI8KU8CRn/qrt7M=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=MBEP4l34Hj1yCwwbHHiSvUyc9ggybbb9nM2RWmRmIg2XblxDYW/LQdbLHqW+clqUKQH83qQ7bltFSOnFABbF57WHPSLIeRVhypqCKCCKTIpgtiLr/PPESJpuylR5/eCe08FdvOfiSNKBIKBzDVaYwyhviLmJYuYGiYnQR70As4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ew1B2G7H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H9rfUo006335;
	Wed, 17 Jan 2024 10:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tl+tO8RuoXRoEWn+uAJ3Ru+OjYumeFt2x5eT73JhPPM=; b=Ew
	1B2G7HtaYG9q+FCoKxACEKjsfUAwSDwOgeW2yRODCHp4ryukTRBiQRfbRESTOH4K
	fJfsY+h8ximsd9TmPC8ue9R3+AO9+3QhVhrKcqLbhtERukMlLy/wZSRH9kWzv/ms
	vzYP71CHbcZIb7W8ex9m0AVrLLMYg0/swnKP8m0P/PmoUetPgz6RzdwnFbHPEK3T
	ajMPOX+rik0fcNjjf2AdmbQ+Tcj8RX1y2aITGmGBfz1rYvuyoh/r0AOtbUa1t++6
	hnT9Xg5cP+mBunSqqEyHSaiG46X2Lgqlh08aEJZCZaWXYfExvRd1NIWh3Hvz4uTR
	8qwmDDyLaRtt0iz5vYlw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnrndb1nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HAjTAF021810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:29 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 02:45:24 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 3/4] cpufreq: Export cpufreq_update_pressure
Date: Wed, 17 Jan 2024 16:11:15 +0530
Message-ID: <20240117104116.2055349-4-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: eRomCy9t0CtFfzHtYworNelut6eGK2XQ
X-Proofpoint-ORIG-GUID: eRomCy9t0CtFfzHtYworNelut6eGK2XQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_05,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=695 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170075

The SCMI cpufreq driver doesn't require any additional signal
smoothing provided by arch_update_hw_pressure interface, export
cpufreq_update_pressure so that it can be called upon directly
instead.

Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Export cpufreq_update_pressure and use it directly [Lukasz]

 drivers/cpufreq/cpufreq.c | 3 ++-
 include/linux/cpufreq.h   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f4eee3d107f1..c051d1719a06 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2571,7 +2571,7 @@ DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
  *
  * Update the value of cpufreq pressure for all @cpus in the policy.
  */
-static void cpufreq_update_pressure(struct cpufreq_policy *policy)
+void cpufreq_update_pressure(struct cpufreq_policy *policy)
 {
 	unsigned long max_capacity, capped_freq, pressure;
 	u32 max_freq;
@@ -2596,6 +2596,7 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
 	for_each_cpu(cpu, policy->related_cpus)
 		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
 }
+EXPORT_SYMBOL(cpufreq_update_pressure);
 
 /**
  * cpufreq_set_policy - Modify cpufreq policy parameters.
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index b1d97edd3253..c6395b698863 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -241,6 +241,7 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
 bool has_target_index(void);
+void cpufreq_update_pressure(struct cpufreq_policy *policy);
 
 DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
 static inline unsigned long cpufreq_get_pressure(int cpu)
@@ -269,6 +270,7 @@ static inline bool cpufreq_supports_freq_invariance(void)
 	return false;
 }
 static inline void disable_cpufreq(void) { }
+static inline void cpufreq_update_pressure(struct cpufreq_policy *policy) { }
 static inline unsigned long cpufreq_get_pressure(int cpu)
 {
 	return 0;
-- 
2.34.1


