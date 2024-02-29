Return-Path: <linux-kernel+bounces-86190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3EB86C136
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B851F24BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190647768;
	Thu, 29 Feb 2024 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="elo/ByeJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C3446B3;
	Thu, 29 Feb 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189125; cv=none; b=c1yWNiV7OAAlUl6vlTqTN/22ie0wVdr2zQFEA9YCIikcIxMcT+HRQ/Q937WwBpr/sLhnrBem5WbE39sPnrVzeuVT2vDFgkbUT3/drRNrO8me4JE7rOBi5aGnmX38aferWIFgJXKYMhIXDiT1d+wWm529IaKSjBjNuDlan0hoJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189125; c=relaxed/simple;
	bh=0buapzlXS8Ejb7a/3Ux3/lyjLsR/FLcFCfrhtlks/tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=sxEvfG2Vqmy0BhEfbZ0oH5jvT3MXYxr2MMwaNqM8LsGPaJYfjanAWCDNiKzLUEm9QjbT8bfXX3oJEXa7MS4dIcXryGQzLmkOy2xi3IV8QN2Phf0MlRj1ysZtlTKWWA8ial/3mDfwWAgO0HIHinJMpk04FO0Rw3w0S8dlz1omGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=elo/ByeJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T62Plr015559;
	Thu, 29 Feb 2024 06:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=emc
	n0d2LH07w89hcfQ+HA5r9ZWQUNqouPMcNxEHPBB8=; b=elo/ByeJupaMlKELTh4
	t6f2i8E30mKBpVoKUEZA62qXVvPl0LVp9KUZ+1Q09r96h+DBGje3+318b1npk0Mt
	xcLBrmKMAiza6d6A5azgh7SlQxE6A1uZhzyt2HuafSHcyUXN/c0bV2cBA1LrGSJS
	Fbwe7OpIjBXWwopk57Buy47FjsUM/PLCJfsmV8CdXYgSYgs7ZnYwjvBbDCed00z4
	o3umJ7JVqw8hwPX7cbyiEnT4+GWP+baZJr6rRUGZ9u9l4lHX+Gmd5hKmhK9IUmKq
	OCNFyw4PktM0WC99rFD6Z4QJ3jZ7LAHotuJmqyP+MR1Pmpsg5e2PZIO5ktTVMrgm
	O5g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjm9mg2xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 06:45:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T6j6gU005435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 06:45:06 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 22:45:02 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Thu, 29 Feb 2024 12:14:59 +0530
Subject: [PATCH v2] PM: suspend: Set mem_sleep_current during kernel
 command line setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-suspend_ops_late_init-v2-1-34852c61a5fa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOon4GUC/4WNQQ6CMBBFr0JmbU1bRIIr72EIKWUqk2iLHSAa0
 rtbuYDL95L//gaMkZDhUmwQcSWm4DPoQwF2NP6OgobMoKU+Sa0awQtP6IcuTNw9zIwdeZqFrl0
 ve1X1BhHydoro6L13b23mkXgO8bPfrOpn/xVXJZQ4l6W0pqma2pnrayFL3h5teEKbUvoCbD7iE
 LwAAAA=
To: Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>, <andersson@kernel.org>,
        <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Sudeep Holla <Sudeep.Holla@arm.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <quic_lsrao@quicinc.com>, <stable@vger.kernel.org>,
        Maulik Shah
	<quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709189102; l=1510;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=0buapzlXS8Ejb7a/3Ux3/lyjLsR/FLcFCfrhtlks/tU=;
 b=WWcHkAudwd4SllibZe3KiNF+5OlTg+CorqCafl88Xb10qD5gu73SIPuDLX/G7i4dzhCejW1rl
 gCqKo4QakZGBYg1eDJbm4ci+XfsDEWoMYGzmqnH4tOGkOl5+5fgAtex
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MCNXFFn5pYu6e0fJ6Ok17OiI1CT3bNnd
X-Proofpoint-ORIG-GUID: MCNXFFn5pYu6e0fJ6Ok17OiI1CT3bNnd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 adultscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290051

psci_init_system_suspend() invokes suspend_set_ops() very early during
bootup even before kernel command line for mem_sleep_default is setup.
This leads to kernel command line mem_sleep_default=s2idle not working
as mem_sleep_current gets changed to deep via suspend_set_ops() and never
changes back to s2idle.

Set mem_sleep_current along with mem_sleep_default during kernel command
line setup as default suspend mode.

Fixes: faf7ec4a92c0 ("drivers: firmware: psci: add system suspend support")
CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
Changes in v2:
- Set mem_sleep_current during mem_sleep_default kernel command line setup
- Update commit message accordingly
- Retain Fixes: tag
- Link to v1: https://lore.kernel.org/r/20240219-suspend_ops_late_init-v1-1-6330ca9597fa@quicinc.com
---
 kernel/power/suspend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 742eb26618cc..e3ae93bbcb9b 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -192,6 +192,7 @@ static int __init mem_sleep_default_setup(char *str)
 		if (mem_sleep_labels[state] &&
 		    !strcmp(str, mem_sleep_labels[state])) {
 			mem_sleep_default = state;
+			mem_sleep_current = state;
 			break;
 		}
 

---
base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
change-id: 20240219-suspend_ops_late_init-27fb0b15baee

Best regards,
-- 
Maulik Shah <quic_mkshah@quicinc.com>


