Return-Path: <linux-kernel+bounces-83828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6A869EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E703028FE70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA2C158D87;
	Tue, 27 Feb 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DXFGhH+D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655F14900A;
	Tue, 27 Feb 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057848; cv=none; b=N9xYvX/dx8O7/jzJ1nGDYPyDq2+YC/x+X1UfoZXHXdDO9bB+H3oFkMmBFs2DWVklFfBmgkceJCroy7WbcogtMgJLdJqll3hiPogfZTtKqqonrz5gqMeM70wVOSScaNgNO62MD3uPdXPI5x/uIsMQaAhfHxRRFNKxLW5YQ4Umw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057848; c=relaxed/simple;
	bh=soFbcjoCMKHiXlrF0ZQPg4FHkybdwxlXBqaSN5M+K2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ar6AvSYoPurJVYF8yYr+5AeQ4M3M+tJLtq0ZbMO/xIdGeM/ze7LOU0+FXm8IdLYjAGFaZdQMv7RhonpXfcZF8REQY94NuZOxuj4TAT72RHpPL7VoYvh0fKRrbe7Hn9tGpm/AIuFm7CyivtxBU2eInvtd797IP9YOF+DQYiOv7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DXFGhH+D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41REtsiv000632;
	Tue, 27 Feb 2024 18:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Ys14KMU
	3oPL3LFpr7OW5dhv3rtV7a6GsUM3wxhdIW0k=; b=DXFGhH+D6S1kxFJI9PODwv8
	1s1XKIsI5H9BTq2zg2cwdNj7VJfQBCYZscWyQItG5pRjTUNlUD131q3IfMvm1Kyl
	7LmxSowCAdkTk/v3JZgFigwEUgyXbb0WhZaWXfGxyxKKyuihYkbxHwt2qc68nNy/
	yUH+N2AH4jGjbVuu41UlFb+0xA0DY/ov0sAMNNsWso5zJGeZsch2bej7MhpnIC00
	8swAC48k5ifvU0uM8QQDdOgGCUMY/xVN44oOOCxwGm0xtzT0Eqqfl+afoHG5zivz
	+kurhrDtLh662/StlV57DKPYJEYqyns8SPn13w43rS9IzcPJ8S3YYP+vWTXiW2w=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8auhwng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:17:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RIGsSd010056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:16:54 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 10:16:50 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 0/2] firmware: arm_scmi: Register and handle limits change notification
Date: Tue, 27 Feb 2024 23:46:30 +0530
Message-ID: <20240227181632.659133-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 07iWVyjgIa2u2zJb_dWB6XGTugUnQELX
X-Proofpoint-GUID: 07iWVyjgIa2u2zJb_dWB6XGTugUnQELX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=753 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270142

This series registers for scmi limits change notifications to determine
the throttled frequency and apply HW pressure.

V3:
* Sanitize range_max received from the notifier. [Pierre]
* Drop patches 1/2 from v2. [Cristian]
* Update commit message in patch 2.

V2:
* Rename opp_xlate -> freq_xlate [Viresh]
* Export cpufreq_update_pressure and use it directly [Lukasz]

Depends on:
HW pressure v5: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240220145947.1107937-1-vincent.guittot@linaro.org/
boost frequency support: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240227173434.650334-1-quic_sibis@quicinc.com/

Sibi Sankar (2):
  cpufreq: Export cpufreq_update_pressure
  cpufreq: scmi: Register for limit change notifications

 drivers/cpufreq/cpufreq.c      |  3 ++-
 drivers/cpufreq/scmi-cpufreq.c | 29 ++++++++++++++++++++++++++++-
 include/linux/cpufreq.h        |  2 ++
 3 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.34.1


