Return-Path: <linux-kernel+bounces-83737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F32869DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B521F24000
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B2149DEE;
	Tue, 27 Feb 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HmSeXu1R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8664F1F6;
	Tue, 27 Feb 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055316; cv=none; b=k2b16MG09lwG16IBuah4+9MRlBoTr6txhwYVuWTielIloHZyHKZZvs9+R2kinBuT8yJm0dEIXz7FaQG5HZiP47uNPzg0jYtO6rSPblHHj5Fa+UhnINPsJlX0LVC8E9Bir5FC0anMS9l5FYpt2xBxtpU9W4mfqwy/FOXdNJyWulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055316; c=relaxed/simple;
	bh=dqsTbryoapTyNINiG8Zoxt825Zz1wlKoATwOTdkD1UY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LMpbwPNY891hw8niVGqKQLOHfzSrpJfmKoHqD9xn2xayZZcNnu2OzSNjpnPEH1lQn5GQLcY/73OE/16uHh0umjHH3bX9KHLIOOTIbQq6vpa2GTvdDEtVb0EDvxHsaQFW7IlKqU2vnKFNHAAyooB8ulNxAbNEavaeaTJWGAEmipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HmSeXu1R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RB6Rlp031968;
	Tue, 27 Feb 2024 17:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=gnOLM//
	6oup31n4aELkO7s8/iurVHdTwK3gYW1UY2N8=; b=HmSeXu1RFJ+8okktZLJhKsA
	/NXzCnTE/5IFv96XTHXxApI066mYMOr5Y5CIZF/5OkbtmRayLNYJBO3KEgurg4Xu
	X3W911pMPazWpgRWbU8rpTAkGAmqymNaIV3EdCL03LvvBDX2+kDAUWVnD7A1WYsQ
	9jR6o1MJ6Bp5zQnZnRxyVzLlZ8mcKCKHkwcEr0NBEurQ9a3Z4FlbV4ja+qkYE/BH
	rJaY1zKzHWrI03VRcqAPkRvBlYpVODrdcdbOru17+uVvGH2OmIaAWj5hIWfYxgGV
	ADbgvsDnsXNnJO+anDrNRTZi+prZkVWoBI9QzFNr16rzB7VYJnx6Z6lIaOkN4qg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whedvs0h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:35:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RHZ206004614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:35:02 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 09:34:57 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH V2 0/3] cpufreq: scmi: Add boost frequency support
Date: Tue, 27 Feb 2024 23:04:31 +0530
Message-ID: <20240227173434.650334-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: 3LwUWkYHFY7hKFllv9JJ5o5uw8NVJm_7
X-Proofpoint-ORIG-GUID: 3LwUWkYHFY7hKFllv9JJ5o5uw8NVJm_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270135

This series adds provision to mark dynamic opps as boost capable and adds
boost frequency support to the scmi cpufreq driver.

V2:
* Document boost flag. [Lukasz]
* Remove sustained_freq check. [Pierre]
* simplify sustained_freq_khz calculation. [Sudeep]
* fix default per-policy state. [Dietmar]
* fix typo in commit message in patch 3.

Depends on:
per-policy boost: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240227165309.620422-1-quic_sibis@quicinc.com/

Sibi Sankar (3):
  OPP: Extend dev_pm_opp_data with turbo support
  firmware: arm_scmi: Add support for marking certain frequencies as
    boost
  cpufreq: scmi: Enable boost support

 drivers/cpufreq/scmi-cpufreq.c   | 23 ++++++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c |  8 +++++++-
 drivers/opp/core.c               |  1 +
 include/linux/pm_opp.h           |  2 ++
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.34.1


