Return-Path: <linux-kernel+bounces-100066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA6287915A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77960B230E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7F77F09;
	Tue, 12 Mar 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WAjKeaUF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675678680;
	Tue, 12 Mar 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236883; cv=none; b=eLQBxKIMT7O4jHepKd8fn9E6w5QGPrrkGU8qQvqnyr8nOei58i1BBQMi4L80ZPCdTzCCRqbEzWNAbAavezqlU5hO5mtRwqzg07xrzh2ZIaJ46GeLLgCwm+zfsrOPBcIS265FsCF+vTeg7NbvcRC/R8dKHpn9VZ1fWifpcInr7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236883; c=relaxed/simple;
	bh=wlQ6wLPmrWdLXk8Lj9AH4ic07N+uD6OIwVN6qj7nLAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdO8upoF2529jZXolSdmAMTjNxCwvCx6m+uXFNVLnPAnEJvr0jruvJgUZMgCGZaDkfVmVqNJC7vX1ZtHE6ciogGv7F9MGBy7WXE1SYJ3am7UWjbU+RbwBvuegaCmGC6xcge2B5EbW5eaklQHjIZu4AA0LdbMKyM87wxA4bC+h6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WAjKeaUF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C9SPTo030392;
	Tue, 12 Mar 2024 09:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=D5LZWiLOWQpngWGT4bXQc0SDCzUoOfCGQlV5TPWe1FQ=; b=WA
	jKeaUF5K4Wr258dFytnXDVO4O9kj9ZHZ4IMvaRaFym2YVG0whcL6xLF27i+FtOLU
	nT92PtlzZj9uisT871RxHkh23GdDrC2YZo/ktrKl7iYE2NHyWv6EHyrowcn7e3kj
	HYiUgoh/xxWJ5GxxNzzzmscScSwp6+s875NsBT3ovZpAkFLbs7lwV3Cva8L5Bkif
	RBOfxR1PifZBBRcblajtHe/AVXyqVjAggTTe08HXMxbz6CooRLRxPgrAFOMyaJbe
	4xLj9Cs1Aj75+dSUcxG2z+VY8U5LPRYE1YR1bIRqchcDBZmclu7ZyM7bWTRPNhmI
	PXYUwYAufqQVGwQTlM1g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtmewg1f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:47:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C9lpwd024214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:47:51 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 02:47:46 -0700
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
Subject: [PATCH V4 1/2] firmware: arm_scmi: Add support for marking certain frequencies as turbo
Date: Tue, 12 Mar 2024 15:17:25 +0530
Message-ID: <20240312094726.3438322-2-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: uCkPitqaQXqNm7KZTWNlLOK02cdsjCQi
X-Proofpoint-GUID: uCkPitqaQXqNm7KZTWNlLOK02cdsjCQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120074

All opps above the sustained frequency are treated as turbo, so mark them
accordingly.

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
* Pickup Rbs
* Use turbo and simplify setting turbo. [Dhruva/Viresh]

 drivers/firmware/arm_scmi/perf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 8e832d1ad825..345fff167b52 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -871,6 +871,9 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 		else
 			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
 
+		/* All OPPs above the sustained frequency are treated as turbo */
+		data.turbo = freq > dom->sustained_freq_khz * 1000;
+
 		data.level = dom->opp[idx].perf;
 		data.freq = freq;
 
-- 
2.34.1


