Return-Path: <linux-kernel+bounces-69886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533E5858FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075521F22098
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB767C0A5;
	Sat, 17 Feb 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fb0Y7NJg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CA7BAE7;
	Sat, 17 Feb 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178255; cv=none; b=Fkb4YJsKaMPNiF4uPNuEC6+o2v7/pyR6iPeVa5whM/EoCyGzGh5hjtFKHAeGSzRS5NrkFj2Dowy/VW1VSQNePzPu73UlAFVjYmWbFLdxs5wsHC6LCljh0iefpetJsZPfwU9gaMMVnuhLFL7ik/IPNCrLpjj6tjsWl6L3LXk3HzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178255; c=relaxed/simple;
	bh=aWT50lJuEyLuBC6bdjZcLVcVbSSAd/hYVo+Ldw2RS48=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OK/Id1cK4gee6SWhLDXaKUe+QhWaPfBKD3EJu+PwUKkkqxjzuTcGGM7h9OrsPBlgekeU/zQMY0OMLtHq8+CIyZux9mMTWKAALWHbYrksP3E667eirYdzQe0BZtGwAFUxA5lDOZloH3EsNQ+86a4f5Iy0RK/3QIeHZsCPktVh1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fb0Y7NJg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HDfZ9D031770;
	Sat, 17 Feb 2024 13:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=h9VFo0bcfKDSpl
	pfPaeC5cxtTrFf/cuxr3uw/279Q5E=; b=Fb0Y7NJgeUgd5t3bQl2lHK+UPsyH/Q
	2XXA0IdU4SHsZXnK4MrYeIT79LCpflgYOvdc2T4zAYEy2kI7FBpuQgGx7Xwdw7Eo
	XKWO165mpIS2108oz2mqlbioft4xndBKEf/teOBh2GbCAwGdACS5K+OidxVrVzsQ
	h+AFqSmKqjgaEBXhpxXJUQSEzHHNe9j39D1T4647B5WXq54jyFADuuG0DydsNK/y
	US2B+3Ij62tHcQsPTIdtvqR6Z8lzp3eXJtuaoOIwLNn4e0hJbT77uC6aXaN2wvrs
	UsOgjyAxCPRPEt+Q/op/igLdZq2uZgwar1oyp/z5BttI/2KH5rtLQfkg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3waqmdrd27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 13:57:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HDvDgr017266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 13:57:13 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 17 Feb 2024 05:57:09 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 0/2] Update init level for cmd-db, rpmh-rsc and psci
 cpuidle domains
Date: Sat, 17 Feb 2024 19:27:06 +0530
Message-ID: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADK70GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Nz3cy8zJL4nNSy1BzdpNQksxRzE4MUixQjJaCGgqLUtMwKsGHRsbW
 1AHwjxKtcAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_lsrao@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708178229; l=1020;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=aWT50lJuEyLuBC6bdjZcLVcVbSSAd/hYVo+Ldw2RS48=;
 b=NwilpH+Ii+ckIRaRbv4O6V62Z9Yh3Hn/dAEEEcEy7BivZ0UhYrdKagy4w5v/v8LrKn0qf7SEh
 ZmVNgJyOVGvCd1qPl2DXZ79M2JZOGy9BQVC7wl9IuABEtTBaNT4mVzJ
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p3_jVyjRySa_Gq2nBMHJZ2gvULuXLcDD
X-Proofpoint-ORIG-GUID: p3_jVyjRySa_Gq2nBMHJZ2gvULuXLcDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_10,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1011 mlxlogscore=755
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170113

cmd-db and rpmh-rsc are used by clients like regulators, interconnects and
clocks for resource voting. These clients are in core_initcall() while
cmd-db and rpmh-rsc are in arch_initcall(). Update init level for these
drivers also to core_initcall() to avoid unnecessary probe defer during
boot up.

Similarly psci cpuidle psci power domains are used by rpmh-rsc driver and
they are in subsys_initcall(). Update it to core_initcall().

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
Maulik Shah (2):
      soc: qcom: Update init level to core_initcall() for cmd-db and rpmh-rsc
      cpuidle: psci: Update init level to core_initcall()

 drivers/cpuidle/cpuidle-psci-domain.c | 2 +-
 drivers/soc/qcom/cmd-db.c             | 2 +-
 drivers/soc/qcom/rpmh-rsc.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
change-id: 20240217-init_level-beb6d740d8d2

Best regards,
-- 
Maulik Shah <quic_mkshah@quicinc.com>


