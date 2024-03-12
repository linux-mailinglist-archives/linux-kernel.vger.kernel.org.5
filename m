Return-Path: <linux-kernel+bounces-100067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E766F87915D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3614283C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DFC79B88;
	Tue, 12 Mar 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iKfx6oRJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5307995D;
	Tue, 12 Mar 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236890; cv=none; b=rXYxzRkaX5z8T9a38eo5j24exYiJ3Qv0jbLjJfW+GNk+cAjwKPizglGpEvfqx4BbQkbJw1ikSb6bqP460nLkmyLVIYIYg9PlRBtnIH7AF2yi2U2rt29bXUvhwji6wwDgkOQrfOLEwb0pll2EYd3O2E29pj3HKh8uyb0m70cghCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236890; c=relaxed/simple;
	bh=YdRXJjyZ9k5cIKLFSHJ6Sei3r5fysIoK1tCBvszB80U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjoJ0fPX5m3oCEDixmKv7qhsfnfkV3kq+9S4cs/WMc9Cl1Xw+UItztQC3QyiIF/PveiyXth4GqDvFrTbI6KQbKjw9KBuUaPiVL37mjqQQETtoFJcznBoKFmkzI20CFsohOL3Tsbdg7FmiteaI7AFk1iCK5u/2ZQxv8FT85Ss5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iKfx6oRJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C4nY5R014889;
	Tue, 12 Mar 2024 09:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Of6M/DttNgTJsgPbbwWeINBKqSd2zyB6v3IzZwLrlwU=; b=iK
	fx6oRJYOV4Ggz2yu7CN57to48qsx3MmmpHbsD57t0OGtO7bdMO0ySlRycbQdpHd0
	+Ruq5yehl1AeVZlPMBwZqbAIMvPlFu+fNYhgt/kx6HH3KFNLQxZ5eYsdituVXwYe
	c+2mvR8R4pfE/m6lVlSSH4wuNLU5+HVc4GrS3CwXHptvxhmexhTcaSxSzv9TxRi6
	PL3gdevI+JPg+wOecfyFjdfd4N9kecOBzO4lVqlWolVdiJNggQaV6p03fdQHkqFq
	ao3s2rmPqMqPimsC69zhxqdmRIZEZewndaKY26pmsqaeCVlcnbgca9zN2nLzLIc0
	d/pkmsbjAhYqgHFQFehw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtgc3ghfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:47:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C9lvbn008747
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:47:57 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 02:47:51 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>,
        <d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH V4 2/2] cpufreq: scmi: Enable boost support
Date: Tue, 12 Mar 2024 15:17:26 +0530
Message-ID: <20240312094726.3438322-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312094726.3438322-1-quic_sibis@quicinc.com>
References: <20240312094726.3438322-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: AqvFYyXUI1qEcLyfYnz2XhnS7ELzXnvF
X-Proofpoint-GUID: AqvFYyXUI1qEcLyfYnz2XhnS7ELzXnvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120075

Certain platforms host a number of higher OPPs that are exclusive to
CPUs within specific CPUfreq policies and not all CPUs within that
CPUfreq policy are able to achieve those higher OPPs due to power
constraints. These OPPs are marked as turbo in the freq_table and in
the presence of such OPPs, let's enable boost by default.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
* Pickup Rbs
* Update commit message of patch with more info. [Sudeep]

 drivers/cpufreq/scmi-cpufreq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 0b483bd0d3ca..3b4f6bfb2f4c 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -30,6 +30,7 @@ struct scmi_data {
 
 static struct scmi_protocol_handle *ph;
 static const struct scmi_perf_proto_ops *perf_ops;
+static struct cpufreq_driver scmi_cpufreq_driver;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
@@ -167,6 +168,12 @@ scmi_get_rate_limit(u32 domain, bool has_fast_switch)
 	return rate_limit;
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
@@ -276,6 +283,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->transition_delay_us =
 		scmi_get_rate_limit(domain, policy->fast_switch_possible);
 
+	if (policy_has_boost_freq(policy)) {
+		ret = cpufreq_enable_boost_support();
+		if (ret) {
+			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
+			goto out_free_opp;
+		} else {
+			scmi_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
+			scmi_cpufreq_driver.boost_enabled = true;
+		}
+	}
+
 	return 0;
 
 out_free_opp:
@@ -334,7 +352,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
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


