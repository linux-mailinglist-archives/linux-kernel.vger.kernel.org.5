Return-Path: <linux-kernel+bounces-28856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC768303D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002FB1C24AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977F1C6B4;
	Wed, 17 Jan 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GqQomzvm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9E1DDCA;
	Wed, 17 Jan 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488331; cv=none; b=bCnlLnEp6fPjYI6JL06/27W8a97wNUiNke9KSeDxbVxSnB/+6jrxRxpGW8G+7ggdmb8xcMZ7msszjP1pC6x8p5UAxlWcxuye3rGIXCAssVpXQgIW3RbdTZ9u6tHb4kaNr9VQMWbeVGSXRRbbLLLa7fitcFDZkOIZh7h3woBbsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488331; c=relaxed/simple;
	bh=RuPUy2XSZiKHWx6iEoT4QuA2AmyE4oxMJCZepHCUYWA=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=KJdBPUVq3D61TcbtJpCtSMf1NEJxTPuLNDHy0PqcGqJIsT/Km+rTvh7abJAzUpPCjsj7mU22z28wZOpIwGygGn0GzPjl1VoPS7aiL8djIzTFRNI8ysCyiIWkaLOckjuwZN+i/rgWLqMTWaH5SxN8TkkXhQYDQLyX3rqqkwtDQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GqQomzvm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8BoCZ028850;
	Wed, 17 Jan 2024 10:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=eR2p89D
	B47KflmO5NtocpeM6aS35aVOQNOm/cEdQpv8=; b=GqQomzvma6dAtc5wjezIEeN
	5oyF/oui+I03eMqHbgEkDQuoQqphW8MV9TNkmblPhQA4EmQ/5xlLf9bnjl5w4mg8
	0kjGy1Uq7TOdKPV5cWvkCKi6RdeJsmXjxQHCtDbaXxDsPzv09UT8kTUIZVv6XYuk
	oFBZ5KDaJ6XMCAZJBkDvqfPIL1KW/wJXy4t9FUZM/32Ww3xvbEdApQj/g8mTu6UR
	fS2UOZoMqZG9V0uL0r5tPzXoZHoxAgewmKX8yPY/GjmG+GYgoDxeUCLbiTFaFwVL
	BbD3cT6NpBBrKjNuWCO8uT04F6Z0B/cnOggJlWdOtvcbSYILvmsfj6VQooG1ItA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnymj1stt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HAjFT5021941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 10:45:15 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 02:45:11 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 0/4] firmware: arm_scmi: Register and handle limits change notification
Date: Wed, 17 Jan 2024 16:11:12 +0530
Message-ID: <20240117104116.2055349-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: nSwza0vSthEdN_C3-jy8jLUpjdKFAjO4
X-Proofpoint-GUID: nSwza0vSthEdN_C3-jy8jLUpjdKFAjO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_05,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=621
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170075

This series registers for scmi limits change notifications and adds
perf_notify_support/perf_opp_xlate interfaces which are used by the
scmi cpufreq driver to determine the throttled frequency and apply HW
pressure.

V2:
* Rename opp_xlate -> freq_xlate [Viresh]
* Export cpufreq_update_pressure and use it directly [Lukasz]

Depends on:
HW pressure v4: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240109164655.626085-1-vincent.guittot@linaro.org/

Sibi Sankar (4):
  firmware: arm_scmi: Add perf_notify_support interface
  firmware: arm_scmi: Add perf_freq_xlate interface
  cpufreq: Export cpufreq_update_pressure
  cpufreq: scmi: Register for limit change notifications

 drivers/cpufreq/cpufreq.c        |  3 ++-
 drivers/cpufreq/scmi-cpufreq.c   | 42 +++++++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c | 37 ++++++++++++++++++++++++++++
 include/linux/cpufreq.h          |  2 ++
 include/linux/scmi_protocol.h    | 11 +++++++++
 5 files changed, 93 insertions(+), 2 deletions(-)

-- 
2.34.1


