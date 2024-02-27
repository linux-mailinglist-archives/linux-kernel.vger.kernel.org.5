Return-Path: <linux-kernel+bounces-83740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F9869DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F841F228E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2714D423;
	Tue, 27 Feb 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sgn41tWr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8448CFD;
	Tue, 27 Feb 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055331; cv=none; b=Um9B2+Ulg4co/3rWwbkEN3Hh7KdGUeKZemP5tMhDpv0uEhSAJBMKNitnvfoBXNxq08PazrUcFTB8SKg7hMxB6j2jd3h+YNuNIy0QWWWqdx1eJIAm6/3uWnPNmPomr27F9MtnD8J4T+2O5WP23gyjuJnfuYpktzM3v/HdQCEI3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055331; c=relaxed/simple;
	bh=yQ2yvmNTpIXiMFF6tObmjhnIeuhFsU3oxjeYCOtNk0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXhjkMiNgjcfa+jRnKKc0caeLPlVfkPsIGacohEhpGGJjYvLNvpujAYbybVhCCELnmY7Vow7rDonfWYY9eoWEhfy550gyiJCiZi/0h57zO73GkdUO+Ynww6CEjy6UKAB6IUuTQozkbHBXSYdD3HI89cZSfxNRzeDAFiFXjL2B8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sgn41tWr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9ZMe6017235;
	Tue, 27 Feb 2024 17:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=1OY4o7F0FOht28QF76HQLbP3x9dSbq2zNxyAKtI6AO8=; b=Sg
	n41tWrMor3zJZziknelNrIYLX8d/h5CCuCg6GeFrgkpQwr77qTX987vtApfL1hsc
	XdCU1kDWVzuoejiGBOWJFZRgLGRvNPrNNLmj0xCDF3ITEZ/QpuiWBTrMy7HSlnV8
	DfMC/E356zliwcWHdHbHKYBIZnJLgp1sk4wL6hGwAJvkmR7rPTlbmX9gCR0FJPf0
	Wc54diebEttrxsRgblD3UFWrNyPkaVRSzO1fsdm4q1YWS6NpApVo3jylM2NuSOfU
	cZGQZK4lZohHSLTlTIy8drbU1upyhxUgOhEDEwAW4lmcjSiVYwWA51DqHHYMxtco
	78anya4ZH4faQsh5/y7w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64h23kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:35:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RHZHLD029872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:35:17 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 09:35:12 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH V2 3/3] cpufreq: scmi: Enable boost support
Date: Tue, 27 Feb 2024 23:04:34 +0530
Message-ID: <20240227173434.650334-4-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZbU3IqkLuiNQcg-qyN_AWXTb_ccc-Xxl
X-Proofpoint-GUID: ZbU3IqkLuiNQcg-qyN_AWXTb_ccc-Xxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270135

The X1E80100 SoC hosts a number of cpu boost frequencies, so let's enable
boost support if the freq_table has any opps marked as turbo in it.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* fix default per-policy state. [Dietmar]
* fix typo in commit message.

 drivers/cpufreq/scmi-cpufreq.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4ee23f4ebf4a..76a0ddbd9d24 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -30,6 +30,7 @@ struct scmi_data {
 
 static struct scmi_protocol_handle *ph;
 static const struct scmi_perf_proto_ops *perf_ops;
+static struct cpufreq_driver scmi_cpufreq_driver;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
@@ -144,6 +145,12 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	return 0;
 }
 
+static struct freq_attr *scmi_cpufreq_hw_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+	NULL,
+};
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, nr_opp, domain;
@@ -250,6 +257,20 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		perf_ops->fast_switch_possible(ph, domain);
 
+	if (policy_has_boost_freq(policy)) {
+		ret = cpufreq_enable_boost_support();
+		if (ret) {
+			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
+			goto out_free_opp;
+		} else {
+			scmi_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
+			scmi_cpufreq_driver.boost_enabled = true;
+			policy->boost_enabled = true;
+		}
+	}
+
+	priv->policy = policy;
+
 	return 0;
 
 out_free_opp:
@@ -308,7 +329,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
-	.attr	= cpufreq_generic_attr,
+	.attr	= scmi_cpufreq_hw_attr,
 	.target_index	= scmi_cpufreq_set_target,
 	.fast_switch	= scmi_cpufreq_fast_switch,
 	.get	= scmi_cpufreq_get_rate,
-- 
2.34.1


