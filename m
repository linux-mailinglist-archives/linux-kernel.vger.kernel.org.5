Return-Path: <linux-kernel+bounces-28879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBEB830421
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4FA28239D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3436E1DDE3;
	Wed, 17 Jan 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c9mXE4n+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0711CF8C;
	Wed, 17 Jan 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489514; cv=none; b=XV1oaI0nJb8y5+DQCDA+llnZ7sI2fh/SF3eUAuuTQaft9VGM/jGGncYvjA1tqoYfBmPRlgynJdZGsYhKaeHFEaDzm1cUBSzOgR5g56joQKYtq4SU89GwnVwhTSTi3Pflbp0iSUxjO82oHS37qSr12xjhPZLbhrHelbzkIKEW2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489514; c=relaxed/simple;
	bh=PNWBfT3brWnSrGjSLIIJL7jK1tCaLLjMr8MvOaaKuXE=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=IEgYh6q13Cst2v/WlRHfgnd2sRPRGiuvZ09sWSDo4bG6jcRWkvk5gzxHnlvYa1brABWgtzfvTfejyHpLKc1MdnhuHtlVHTfjHWWO5z60atQ5Qkl8TfCIPhQvHglUEYloZ18zZIsj5nooRphNwoBsTA6jKYE1bNstQbRbnkXlAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c9mXE4n+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HAs2sD006655;
	Wed, 17 Jan 2024 11:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=4sA3r5O
	3wj/axNBGa2L0bed+MqSV0LZ+CkNHTof+8sk=; b=c9mXE4n+wOjqTvrxYsEiKFq
	sgukZ/N2QDwzmYLSjpPgv17cjuemYhIaMOSr+e6zsH2graI00zRwQ1TMVzr0MDFu
	nCqmf/wCAaeUbeal4fT0QXrGJ/ToLiNnVID+pORAXOeE71En/mWpFKs9aPxrtB01
	ImUVmCmJNBCYyjG4PLdtXo/H19F7+pofq0YcWi/61cFI2FYepXPtTZK42GFNcf5i
	AzOGJ6Ixqwu9qFbl0buLhCQm6/XENGQp48RvtVTCPSBGuTYa+vOarG1qt8JEeKfr
	Xke2+6IMmCPqiwSGx3fvyQzUYOyWrJPPTiLnVWPw8WK5wNpeIccIEb9fmrJXKlQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp4ak14n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 11:05:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HB520J016233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 11:05:02 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 03:04:57 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Date: Wed, 17 Jan 2024 16:34:40 +0530
Message-ID: <20240117110443.2060704-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: DX8TPyMY3BU8fmpWDuXZ-B4QYiZfjKRL
X-Proofpoint-GUID: DX8TPyMY3BU8fmpWDuXZ-B4QYiZfjKRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxlogscore=924 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170078

This series adds provision to mark dynamic opps as boost capable and adds
boost frequency support to the scmi cpufreq driver.

Depends on:
HW pressure v4: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240109164655.626085-1-vincent.guittot@linaro.org/
scmi notification v2: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240117104116.2055349-1-quic_sibis@quicinc.com/

Sibi Sankar (3):
  OPP: Extend dev_pm_opp_data with turbo support
  firmware: arm_scmi: Add support for marking certain frequencies as
    boost
  cpufreq: scmi: Enable boost support

 drivers/cpufreq/scmi-cpufreq.c   | 20 +++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c | 11 ++++++++++-
 drivers/opp/core.c               |  1 +
 include/linux/pm_opp.h           |  1 +
 4 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.34.1


