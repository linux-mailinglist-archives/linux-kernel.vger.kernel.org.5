Return-Path: <linux-kernel+bounces-96856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0C876242
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9B41F2343E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061B55646B;
	Fri,  8 Mar 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dMmPAl+l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80FDF5B;
	Fri,  8 Mar 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894273; cv=none; b=WLv6VdHoP8mnqykjZjOWIsUHcsiuYyUHuyYweb/H6EJ5grx4H1DmL9Tn507Xw95u9Um6c+/pfeoPnP4e85l25+wzPvCUEaEp6R5tZYefYUALV49HB1h+F+/PTtmhFgPoFDL5LxPn1PJZ52+aqKTMXXC2BkLGRuJggWuiLHvSA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894273; c=relaxed/simple;
	bh=2OOYinqQguwiPejd5+g4NRefKtsTDeVSgMjb59dLdhs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hRwrTwFAG3HIWILx8jDw+A40p4CQeUIXXo9DUbPM3DddpexrNX233d2y7fUINNhYF8ikAFtILPaRCfHD/B7yRJrvrFDQ9aogAVh80E9ASGNT6PpSPS45pJSzQUGFrhmdvfQAw38dg+v5nItirzoyr/Sa/qBZSI7mUZwGjJ8A98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dMmPAl+l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4288TreX031056;
	Fri, 8 Mar 2024 10:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=fOaAGlo
	rcscPHZrP5cXo/S0ZQgVM5JGxqbGP2Yy7Gak=; b=dMmPAl+l/lxWYxkNXKdPa/u
	DsMS1qNQ/e3z5A+qsEcjQAKxD/AF2Qi5EGs8TqhUZUocO9IYZCCKfCI/rZxeDPVG
	kRQV/eSMFPij0zJcNiW81syi17O7VW2WXSYPx/9Bp0FSjFMelS+ASMuye+PT7obP
	JaQh5esYtbLBgKPr1xf+syInCKHrOOhN7qWiCJLrzgQIyB/ZRYVzl1+Y+atA0YxF
	TZPOMqdqprHBk3xMmHjUrli8DNA0VtL7PknjMInVPnNrQXrLgGQCtOXY34M0PnOi
	5614jupznHc5b/YLJwFKHoRZ2N322hrwjqJvTiz/wwDBtPvcyI3uz3zPibJwL3w=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8s1fnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 10:36:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428AaoWT005454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 10:36:50 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 02:36:45 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <dietmar.eggemann@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <xuwei5@hisilicon.com>, <zhanjie9@hisilicon.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2] cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw
Date: Fri, 8 Mar 2024 16:06:30 +0530
Message-ID: <20240308103630.383371-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: 7YvgX_hv4skigzOnySS8XvpEfAVqega5
X-Proofpoint-GUID: 7YvgX_hv4skigzOnySS8XvpEfAVqega5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080084

In the existing code, per-policy flags doesn't have any impact i.e.
if cpufreq_driver boost is enabled and one or more of the per-policy
boost is disabled, the cpufreq driver will behave as if boost is
enabled. Fix this by incorporating per-policy boost flag in the policy->max
calculus used in cpufreq_frequency_table_cpuinfo and setting the default
per-policy boost to mirror the cpufreq_driver boost flag.

Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Enable per-policy boost flag in the core instead. [Viresh]
* Add more details regarding the bug. [Viresh]
* Drop cover-letter and patch 2.

Logs reported-by Dietmar Eggemann:
https://lore.kernel.org/lkml/265e5f2c-9b45-420f-89b1-44369aeb8418@arm.com/

 drivers/cpufreq/cpufreq.c    | 19 +++++++++++++------
 drivers/cpufreq/freq_table.c |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f6f8d7f450e7..c04b2ba2993a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -653,14 +653,16 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
 	if (policy->boost_enabled == enable)
 		return count;
 
+	policy->boost_enabled = enable;
+
 	cpus_read_lock();
 	ret = cpufreq_driver->set_boost(policy, enable);
 	cpus_read_unlock();
 
-	if (ret)
+	if (ret) {
+		policy->boost_enabled = !policy->boost_enabled;
 		return ret;
-
-	policy->boost_enabled = enable;
+	}
 
 	return count;
 }
@@ -1428,6 +1430,10 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
+		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
+		if (cpufreq_driver->boost_enabled)
+			policy->boost_enabled = policy_has_boost_freq(policy) ? true : false;
+
 		/*
 		 * The initialization has succeeded and the policy is online.
 		 * If there is a problem with its frequency table, take it
@@ -2769,11 +2775,12 @@ int cpufreq_boost_trigger_state(int state)
 
 	cpus_read_lock();
 	for_each_active_policy(policy) {
+		policy->boost_enabled = state;
 		ret = cpufreq_driver->set_boost(policy, state);
-		if (ret)
+		if (ret) {
+			policy->boost_enabled = !policy->boost_enabled;
 			goto err_reset_state;
-
-		policy->boost_enabled = state;
+		}
 	}
 	cpus_read_unlock();
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index c4d4643b6ca6..c17dc51a5a02 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -40,7 +40,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 	cpufreq_for_each_valid_entry(pos, table) {
 		freq = pos->frequency;
 
-		if (!cpufreq_boost_enabled()
+		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
 		    && (pos->flags & CPUFREQ_BOOST_FREQ))
 			continue;
 
-- 
2.34.1


