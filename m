Return-Path: <linux-kernel+bounces-28880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FC8830424
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44021C20C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E7B1DFC9;
	Wed, 17 Jan 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HV+qRTAY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421281DDD0;
	Wed, 17 Jan 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489521; cv=none; b=AlsZSAWhRTObyYMvwJ9ZZxYbsxJRX4jN31nvVlzYxtXppChl9Wj6IG0btEt1q+lcko2J1QVVfijpkMDuH9XuD9Ju2SR6D0C5lYMg3kptbPG5N14hP4XY+d4MbWRmTmpS+Tdi0XNwrh7GhUOhaGqji+qDywjiUt3J1ZCdYMnzvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489521; c=relaxed/simple;
	bh=c5guYM91XoFNjujIpuHVo1R+5gRDWhNhSzRhNFsUU6Q=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=X5EetDMH3WyRc59s9wVOsqHufzP6s7Z54zbmMAXAw7NJYvioINQmV78GJmjqoIKH70fseoQpiaQvhX5Loz+gku0jbQ2H5AQfQUro2Ca+mCI53BQFO3hdUaZ75v9qgP7wUJtP2hR+23cezWXPJDhmAGJ1SRcD22GHek1izKR3T4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HV+qRTAY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HAmiPl016006;
	Wed, 17 Jan 2024 11:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HsxiSsCFdmIbg8BYHbMzFgtmOiVLc8AZK3LlDrMztDA=; b=HV
	+qRTAY2ukThgT+dPMBxpOFTj36EHTl2jJxWHs+fER9zMHBcdNrqHXEnVVEBg0GEW
	ay5TXBCcSGPo7pHk/OcUfP/q0sWvz5IcvSCNPcwOE7uTFZYZk/3HORnDjaCsmksm
	CgAUda43RMjlMbadw6PQPUiU1VzOAMXHQm8cUjXn6/9B0wATSG67nLsLD7pJgi8g
	Zmn2HCzr+c/GJ+1DtlGM/tsCHOC+vGdC7jpitHMpTWXTsTRlHTmFfM2IOnxUsyAY
	O9Dpu1Z5SS/1u7ajOW3EGaRBWWzBfTsh6FOTz9qPH5Qw1Ig8Hyok9AbQutl4eahJ
	SADQY1UTl513I+KzumEg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpdfgr0wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 11:05:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HB57v4007804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 11:05:07 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 03:05:02 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH 1/3] OPP: Extend dev_pm_opp_data with turbo support
Date: Wed, 17 Jan 2024 16:34:41 +0530
Message-ID: <20240117110443.2060704-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117110443.2060704-1-quic_sibis@quicinc.com>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: 8kTFpV05Rzz1uffd1YDmDEF69leh9Xqd
X-Proofpoint-ORIG-GUID: 8kTFpV05Rzz1uffd1YDmDEF69leh9Xqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401170078

Let's extend the dev_pm_opp_data with a turbo variable, to allow users to
specify if it's a boost frequency for a dynamically added OPP.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/opp/core.c     | 1 +
 include/linux/pm_opp.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c4e0432ae42a..e233734b7220 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2065,6 +2065,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	/* populate the opp table */
 	new_opp->rates[0] = data->freq;
 	new_opp->level = data->level;
+	new_opp->turbo = data->turbo;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 76dcb7f37bcd..a08a1fb1ca2a 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -93,6 +93,7 @@ struct dev_pm_opp_config {
  * @u_volt: The voltage in uV for the OPP.
  */
 struct dev_pm_opp_data {
+	bool turbo;
 	unsigned int level;
 	unsigned long freq;
 	unsigned long u_volt;
-- 
2.34.1


