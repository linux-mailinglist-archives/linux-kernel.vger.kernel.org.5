Return-Path: <linux-kernel+bounces-28857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D10D8303D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A571C245A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE661DDEB;
	Wed, 17 Jan 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WrAl0nkd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF91C6BA;
	Wed, 17 Jan 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488334; cv=none; b=Bc8J2GiA4UQldNVmspEW6IHJXf9MhHyCMknUkCnbaGg1HuUfxxgMd3dcis99CdkVN6cCAF47opZQvkSzz2pcZHzOMDdTPXYBLK1Vq03jQnOcWZC6gBp6GVS2E0Hv8S1+jov/kz08JyeGyiMEgxpBTd/QD+nuN76edgLsnK/XseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488334; c=relaxed/simple;
	bh=BpCA0vwZl69dRLI4dnWA0LBDKY4aswlh97aPkxwupXA=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=T4HzUuWe5M6w6FVPAzQyvVZvhVwDEw6jaKHI0YSnPcCyJXiRwS/pi64WptdivkeqIMLq+iFKaf9meIfboV/YhjtL87NUPiggWhyqH//BMG7FhmPppw9jNMa8WWRLBOoKIxfAfXbkCZ+ECrt7Wv8F9Lz5hhywFkvVrHu95e6uLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WrAl0nkd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H4rENU010679;
	Wed, 17 Jan 2024 10:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=de9oS+lk9gffGLo4TJesF3FDP09M3GDm6E7fNkq1Fho=; b=Wr
	Al0nkd45aamSUGML21bLuMoa+zLZwDPsBGGHtxVVVNw2ic5WHlaVsgOm+oKCPD5a
	H2evsuU8z1xj1srqfV4wq/JNAqEl94WD9luhQRnnvklQLPpZjiS+8ZX/XEKOiINU
	5lKDRQt/W8YmIwuJKJvYOV5oDdBc/VbVnrnK7viKRdhPGEtVxi9jpAX79FxQANjc
	a/f9A/whPkklZ/pONO4JqRaghqXjtcif3lji/Ufj4B9fRcEzPG2r62C3GeWmlM6+
	ptov0FNaymZ3of1begb5deR0URe6y+xSlBDw0CBL+Gvus9gBxkKeQfhuc0+DyyJb
	FJume9MoAn+2RrjuYCCw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnrndb1nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HAjKd1021085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:20 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 02:45:15 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 1/4] firmware: arm_scmi: Add perf_notify_support interface
Date: Wed, 17 Jan 2024 16:11:13 +0530
Message-ID: <20240117104116.2055349-2-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: zwZn1dXK8tA7kGj5gSfKLVlGr8oSVcfK
X-Proofpoint-ORIG-GUID: zwZn1dXK8tA7kGj5gSfKLVlGr8oSVcfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_05,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170075

Add a new perf_notify_support interface to the existing perf_ops to export
info regarding limit/level change notification support.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 16 ++++++++++++++++
 include/linux/scmi_protocol.h    |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 211e8e0aef2c..ae7681eda276 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -962,6 +962,21 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 	return pi->power_scale;
 }
 
+static int scmi_notify_support(const struct scmi_protocol_handle *ph, u32 domain,
+			       struct scmi_perf_notify_info *info)
+{
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return -EINVAL;
+
+	info->perf_limit_notify = dom->perf_limit_notify;
+	info->perf_level_notify = dom->perf_level_notify;
+
+	return 0;
+}
+
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.num_domains_get = scmi_perf_num_domains_get,
 	.info_get = scmi_perf_info_get,
@@ -976,6 +991,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.est_power_get = scmi_dvfs_est_power_get,
 	.fast_switch_possible = scmi_fast_switch_possible,
 	.power_scale_get = scmi_power_scale_get,
+	.perf_notify_support = scmi_notify_support,
 };
 
 static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..b0947d004826 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -117,6 +117,11 @@ struct scmi_perf_domain_info {
 	bool set_perf;
 };
 
+struct scmi_perf_notify_info {
+	bool perf_limit_notify;
+	bool perf_level_notify;
+};
+
 /**
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
@@ -139,6 +144,7 @@ struct scmi_perf_domain_info {
  *	for a given device
  * @power_scale_mw_get: indicates if the power values provided are in milliWatts
  *	or in some other (abstract) scale
+ * @perf_notify_support: indicates if limit and level change notification is supported
  */
 struct scmi_perf_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
@@ -165,6 +171,8 @@ struct scmi_perf_proto_ops {
 	bool (*fast_switch_possible)(const struct scmi_protocol_handle *ph,
 				     u32 domain);
 	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
+	int (*perf_notify_support)(const struct scmi_protocol_handle *ph, u32 domain,
+				   struct scmi_perf_notify_info *info);
 };
 
 /**
-- 
2.34.1


