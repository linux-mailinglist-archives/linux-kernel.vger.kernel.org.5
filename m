Return-Path: <linux-kernel+bounces-83657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE27869CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F154F1F253D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526583839E;
	Tue, 27 Feb 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RK26RgBc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788E1DA37;
	Tue, 27 Feb 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052852; cv=none; b=iWHFTbalanI8oawGqskdAf4ZXthU81yLYqHJStINpbrhKC9RJYoCUlBfLOwO1Kq+XReGJ18pM2dBT/rqTii9daXAOwkuJd1WfzxWKk8GJxBu/PMSwlAdVss4/wkk7izDrjvx7CU0DDTHLVcPUarX/W1iq8RnodGQcgsfv/vGRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052852; c=relaxed/simple;
	bh=AtI4DP0azihNEpN7fUHfrc9BC3U3/Ohts7IOMx4dGOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCXxwdn6++aFsfm7gZPljheS2TqhRu+KYc3/LeWfVtfh10pGKUrDugD/LvFIWnuCmEOfqOVCejD2CkKehUdxZre4o0FPBs//M+ijV4fcuYkP9r5XjUs7EID/sM7hOQMrkjsArXHlLOJmTLno41nZkCuEtkUGSB1kGD7JOGdDTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RK26RgBc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RGbNYp020484;
	Tue, 27 Feb 2024 16:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=1ukAByU/Y6XIpyYRk5+z3AWPCyZlxizj7T5qOMn6Q/k=; b=RK
	26RgBcBggnl9gsxZouO/v1vknWSgHRBq8j+/wbit20e+HNroM2B5ptMH3LZvBBsx
	PNeeTK3R5ts0GTSckge0KdqGL9wgi5I2QY+rrFC47WNNo3ru3ek80SlsGRDoAbcN
	LfJtuO8f8fBx5HMajUDmfX4pHUBvQoHQNYEgZWF1BmxcS+nl7p8K8OSbizsGWx5c
	vrL3dJDYMN5SzUtxUmVzu5Ted/0FuR1HWe6FBsQv8qjK+EQX2PB/PvFQ4HhAOt9c
	gtIhJSuSgPeFYyNWnD8udf0LS03dfrwyYCMUVixUvlnqRiQE+xrV0CgPLPE/YfCO
	bkica+39w4bDQ/YUgMjw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whkd5g1e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:53:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RGrjSg028353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:53:45 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 08:53:39 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <dietmar.eggemann@arm.com>, <marcan@marcan.st>, <sven@svenpeter.dev>,
        <alyssa@rosenzweig.io>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <xuwei5@hisilicon.com>, <zhanjie9@hisilicon.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <asahi@lists.linux.dev>, <linux-pm@vger.kernel.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH 1/2] cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw
Date: Tue, 27 Feb 2024 22:23:08 +0530
Message-ID: <20240227165309.620422-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227165309.620422-1-quic_sibis@quicinc.com>
References: <20240227165309.620422-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: K89-2LrXOKUphU7Q81xYmYKPS4TaY0_6
X-Proofpoint-ORIG-GUID: K89-2LrXOKUphU7Q81xYmYKPS4TaY0_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270130

Incorporate per-policy boost flag in the policy->max calculus used in
cpufreq_frequency_table_cpuinfo. This fixes the per-policy boost
behavior on SoCs using cpufreq_boost_set_sw callback.

Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/cpufreq/cpufreq.c    | 15 +++++++++------
 drivers/cpufreq/freq_table.c |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ff69e9335645..76002aa3d12d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -644,14 +644,16 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
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
@@ -2791,11 +2793,12 @@ int cpufreq_boost_trigger_state(int state)
 
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


