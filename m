Return-Path: <linux-kernel+bounces-85553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7951086B7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC201F2A473
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904871ED4;
	Wed, 28 Feb 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fkJNYAkq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598A79B7A;
	Wed, 28 Feb 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146225; cv=none; b=szsxO/auZjpJl7rv/p4tUB49aqPJ+rcd301oNgI3Xf+M1og9bk9x82owqVFpRsqle1aE7aeIZUmp5nNJQFHotC+BSm2Xa/cMvpG+t3WJ9h7aUQs2gOYQQftexkSR6YxCceO13XnFV3ZqPZHU/ijWGzMnmurS0Gc65DaYL8qLeig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146225; c=relaxed/simple;
	bh=ztBRN8H9cDMaU+euBKWvMiwH9ff2ZLkBxBg/KHOXYYE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=uGLeyq+Sqt4/NqxzVetELerVMmMZZq72vqkgKEL9qDUzHxx+qnMCIftXs7LnMHHIHRFO+W+WzTVMqdZllzhFDvdip1TALK3+U8fG/uztzVx3meMRgWPLQvbk3aaDs4zgpwAusDmk23eT9Mn6IkCxkZP3rGNMaLFPQ9rDZKQKx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fkJNYAkq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SAxLK8014965;
	Wed, 28 Feb 2024 18:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=jEZOciEw7QWJWN
	d6uZ3qYXpZbkzs1CfLSY+lK5A4LEA=; b=fkJNYAkqODqjLdDrd3CQdalYiseYPZ
	zyCPjKNzZplYyYPm9D8AGyp7sbqKEvu7dOpcXjzZ0cpbfjj1vwXa4sHnJ4XM9pUE
	qOwKLSCZd+yZm0ZVEa82uSWcO/cYVueXrMmhANBqaAoWjEWoWYqpmpGcr5ogf23V
	ju3R/PW290eMhpbwDkzXmU/2pfwPdlqe8cYD88PZhCXRyyHyFj3sQEbOO0BXQfBU
	6VLKkUlCNgryb6uwJsd210K91BFO62WLo6SZNrhUHZ8DkFqF/Wm9LuAoPQGm7Keb
	wv4GYJf5shWPSqwZpdEERcsu2nTtmIa/oiA+YVlzR1D1OuZR4jwOvbww==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whw3f232d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:50:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SIoGtE013925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:50:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 10:50:13 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Subject: [PATCH 0/3] SCM: Support latest version of waitq-aware firmware
Date: Wed, 28 Feb 2024 10:49:58 -0800
Message-ID: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaA32UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNj3dzSnJLM+PLEzJJCXRNLEyMTM4uUZBNLCyWgjoKi1LTMCrBp0bG
 1tQBjQOlkXQAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Prasad Sodagudi <quic_psdoagud@quicinc.com>,
        "Murali
 Nalajala" <quic_mnalajal@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Unnathi Chalicheemala <quic_uchalich@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709146213; l=960;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=ztBRN8H9cDMaU+euBKWvMiwH9ff2ZLkBxBg/KHOXYYE=;
 b=wF6h5fOIzi1uPnt1nMji/CsczdySbn43gvG+fGPq9UctMBHkims9V0FnOgT3HVEY39viZl22T
 YG7O4kbWDqHA9wdlEcukPTshA1/ICN80OqyYhPdKdS0SI3B6pJA0LQf
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -YCWjv494SNMppZTNZjw20PhkjcsSIEG
X-Proofpoint-GUID: -YCWjv494SNMppZTNZjw20PhkjcsSIEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=826 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280148

This series adds support for the latest improvements made in SCM
firmware (FW) that allow for multiple wait-queues in FW.

This series has been tested on SA8775P SoC.

P.S. While at Qualcomm, Guru Das Srinagesh authored these patches.
Thanks Guru!

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
Unnathi Chalicheemala (3):
      firmware: qcom-scm: Initialize waitq before setting global __scm
      firmware: qcom-scm: Support multiple waitq contexts
      firmware: qcom-scm: Remove QCOM_SMC_WAITQ_FLAG_WAKE_ALL

 drivers/firmware/qcom/qcom_scm-smc.c |  7 ++-
 drivers/firmware/qcom/qcom_scm.c     | 85 +++++++++++++++++++++++++-----------
 drivers/firmware/qcom/qcom_scm.h     |  3 +-
 3 files changed, 67 insertions(+), 28 deletions(-)
---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240223-multi_waitq-4942468dc498

Best regards,
-- 
Unnathi Chalicheemala <quic_uchalich@quicinc.com>


