Return-Path: <linux-kernel+bounces-100065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E11879157
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03E5283BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB2378660;
	Tue, 12 Mar 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZyngT2Ap"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4D7826B;
	Tue, 12 Mar 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236880; cv=none; b=hyWcc7VtVfR0HMcunWXtGMPxmGzHzVM8hRALe1HuHg+7Ry7wpV0HEpY2aRwXF/vVTvtTc/V5LBXEJlHMh9n2AMwA74egQzpISXEy5J3XlmB9sNSv6qIkoHMCCH3xubDCKb6nrynzulL9p4uOkT4UOLF5wrNzDWokL/J+IvoAJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236880; c=relaxed/simple;
	bh=6v0caSEmR/LW+2CLvMAdGxJ1CbcQQPnew73q91mOjmA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RKk06ciKKaNnCdyhwGKnJM/lT6VDfDe42hCg+rA3qXJZQ0D+rhiK2Y3A+SL6/nlTN2LcsnlfudB8DXvKgSVtxs35qfLzjM/lK7oEXStZBl/XSg1u4FSQeyyK+kvsWLYng2CCrKXfm+F2r9xKk5oG03eHCSY1vYIh8tkxPYAIIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZyngT2Ap; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C8DcNW015337;
	Tue, 12 Mar 2024 09:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=GS8a44E
	ElKT1iKb4VOxwYSGBj1195LrzjcOpeKyOEEU=; b=ZyngT2ApdQdSLberTbOXPwM
	YH0NaT7OFsFeDq7N6W30Gtf0nwAyS6kbuOXUqQrLVhOQL5mDcfvOzRclPbGGUNfP
	EX9FtV6a90/CvNigKBnbd4NhaMMnpU0QmKig1IGmRkouFYrjCmqIx7cDJRZi5JzR
	/t72U/o8QrOdEI6DLOl+YpSyGWlG2TwT8boQir0AuLrUqj478b0fEbylOr7LlA2X
	e4yGVmOhobLpKA52JcDepIhxOyu8mTBTSMW2h4i2fluJQ4LIU5d2qdZkVmShYTvZ
	og4cv3TIcaEFNRfMwdz/wmkxmaK1BRSXGXKELivkkfLh0T3ZTlqOOFsnudC16Xw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wte5d0sa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:47:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C9lkjf024150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:47:46 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 02:47:41 -0700
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
Subject: [PATCH V4 0/2] cpufreq: scmi: Add boost frequency support
Date: Tue, 12 Mar 2024 15:17:24 +0530
Message-ID: <20240312094726.3438322-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: oLbu48V99Eu6XMJNSOURVjCRJ_8wUKfl
X-Proofpoint-GUID: oLbu48V99Eu6XMJNSOURVjCRJ_8wUKfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120074

This series adds provision to mark dynamic opps as turbo capable and adds
boost frequency support to the scmi cpufreq driver.

V4:
* Pickup Rbs
* Use turbo and simplify setting turbo. [Dhruva/Viresh]
* Update commit message of patch 2 with more info. [Sudeep]

V3:
* Don't set per-policy boost flags from the cpufreq driver. [Viresh]
* Drop patch 1 since Viresh already pulled it in.
* Drop depends on bug link. [Viresh]

V2:
* Document boost flag. [Lukasz]
* Remove sustained_freq check. [Pierre]
* simplify sustained_freq_khz calculation. [Sudeep]
* fix default per-policy state. [Dietmar]
* fix typo in commit message in patch 3.

Sibi Sankar (2):
  firmware: arm_scmi: Add support for marking certain frequencies as
    turbo
  cpufreq: scmi: Enable boost support

 drivers/cpufreq/scmi-cpufreq.c   | 20 +++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.34.1


