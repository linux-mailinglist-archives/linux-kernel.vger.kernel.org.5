Return-Path: <linux-kernel+bounces-96865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD087625D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0D71C2138E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E956442;
	Fri,  8 Mar 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YxCGjH+i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83B55E7F;
	Fri,  8 Mar 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894684; cv=none; b=MhPe37Z5yzTFrPS+kZhiMyDU9USXdAyIRSsSGyFOBj2HncqTWa0FXkavUr9dPemtuNzCHMIK81By08xHGEuzLOPPNvFYKt9MaXE2kDX1rm6rtrt4ARhplosSuVD+LQ4lxeDJd70MHVAtlMj0GLQDAjwLYCzqxrvmJO9uKHxif5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894684; c=relaxed/simple;
	bh=gAe0pcZUVaevDBhA3QRadyH5XevFjPm3rg7pQUFFEFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEC3WGBqUF4fYhq2NG5JjNFcwlDCDYGESkhYjflvoABuzmeNEUizEjOLmm8PYL8jXbKLT49PWav6WizNNXANOGoN0QELjKraS2Y9HF8itKjd2ljg/wkoMcHo+F+rzDdAWB8+EqoxYNxv1hjZaZaNtq1FrJtNtLM6rpJ2VYnfAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YxCGjH+i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4289GHoH005419;
	Fri, 8 Mar 2024 10:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=d344LokFw21DJ9Lbpn/kI0fNPTZBlloPOPgr9EjnZR0=; b=Yx
	CGjH+iGEWyxtSHNsqC5tO978sChNgfTYifJRitUHIQkEUPIOmQDNhKm8zZp/UIqO
	9/r+Xn/hgDDklqIixriV8+1U9OJ/RGWV4T+8otbeX6wSehUi5+LGLGS+Lrq1PeqY
	1f15xwQeTNslsfgRX3mt10sxvsu5IndaIUyOtujZsvJOpm94tdmeCWok8vYW+TH5
	Kof5WTZVnndxNBmBZyxzLfhnsQUirCtUJqrF8sf5tDR76FR04zARmenwXMwzxShe
	8C8yoIP/vmEEmRtp0MrRKXLWfXj5l1UwSIPhtrV/fZQr1TojMYZtvYHqUGjQYTEO
	HYn4wXzxnv+EC4wZbcBA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8m1gqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 10:44:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428AiXCi016061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 10:44:33 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 02:44:29 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH V3 1/2] firmware: arm_scmi: Add support for marking certain frequencies as boost
Date: Fri, 8 Mar 2024 16:14:09 +0530
Message-ID: <20240308104410.385631-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308104410.385631-1-quic_sibis@quicinc.com>
References: <20240308104410.385631-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: NGfTKoolwkDAB1FLJfho2DJcLiAlbU7x
X-Proofpoint-ORIG-GUID: NGfTKoolwkDAB1FLJfho2DJcLiAlbU7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080085

All opps above the sustained level/frequency are treated as boost, so mark
them accordingly.

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 8e832d1ad825..64d9a90bf443 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -857,7 +857,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 				     struct device *dev, u32 domain)
 {
 	int idx, ret;
-	unsigned long freq;
+	unsigned long freq, sustained_freq;
 	struct dev_pm_opp_data data = {};
 	struct perf_dom_info *dom;
 
@@ -865,12 +865,18 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
+	sustained_freq = dom->sustained_freq_khz * 1000UL;
+
 	for (idx = 0; idx < dom->opp_count; idx++) {
 		if (!dom->level_indexing_mode)
 			freq = dom->opp[idx].perf * dom->mult_factor;
 		else
 			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
 
+		/* All opps above the sustained level/frequency are treated as boost */
+		if (freq > sustained_freq)
+			data.turbo = true;
+
 		data.level = dom->opp[idx].perf;
 		data.freq = freq;
 
-- 
2.34.1


