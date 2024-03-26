Return-Path: <linux-kernel+bounces-119154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767488C4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D431C61B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357D1327E4;
	Tue, 26 Mar 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="daK7ZcsG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D01131E3E;
	Tue, 26 Mar 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462419; cv=none; b=n8zTYAryWZag2Ty5nBRDDGxVy3DVYQdXPXjfQYblZGCJ6+v5sQp1LPAtdn4SAs/3ONvMUjUGbG7bSzg5ol92qua457i6wo9YVx4cNCTng/rj/2q7HZ0l3ptRV0s5k2wUWsQBT4kpDPPifrqWPAPSHi0tlc9b0nNvAa34pAVdQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462419; c=relaxed/simple;
	bh=KqSKOgxTMK36b67Iqqg+QPrurFOcjJPhhjGJyJH5mgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8+5+C16LbscB2L2dRQB+mTN2RLqE/JNfDR2285Jc1SO9ITw0UTEtq/BXJpH8tpps7nyOL/sZp/HSQFHxOZbGFrUJHB7uidT/x1aUOYbCvnAwGXMjwtJagC6rYPeN0jYD+f90NSI48q7TGL3cCJlAGR3vKobADcgY4Hs8TqCpRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=daK7ZcsG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q66XqL004610;
	Tue, 26 Mar 2024 14:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=AHk8jQ5ugdJ/NBfqcYqH
	prwfDLFYcrbYHGSGKAWBV1A=; b=daK7ZcsGa9kfbw5iE7t+wzkaT6t/9Gl0fWrt
	AUueL/PUcGA1XN6cJ3UZK2dT8KEnOKgz9Bg+MhQNHJfkolrezGfD1+wBuHkWuLAS
	wqYDcXbIKrgQbtGqN2pxJO7kp32rjb1RjiEh4MT7v5xHvQOvMco14Pl+/NNIfcIc
	fiIHsXAZzRWYT/UpJdqSTN7csgbMZXK542F7rFfxKhwp/eqtYXOh9tlOwU6yjYMX
	1ioRSMM9Lb+DLSNOk+ykT/88y1tQO12LoH1tRApxmcJZLNy3nRxopkbapnp5bwTx
	3VGumTav3JIl1lUDUD+cfLCpExDyB2RT/CH2M6vGQTDlcqrFog==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3rt81ccr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:13:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QEDVsX007386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:13:31 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 07:13:29 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mathieu.poirier@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v9 2/3] remoteproc: qcom_q6v5_pas: Use qcom_rproc_minidump()
Date: Tue, 26 Mar 2024 19:43:13 +0530
Message-ID: <1711462394-21540-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711462394-21540-1-git-send-email-quic_mojha@quicinc.com>
References: <1711462394-21540-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P5unewuXlzHJtcyA6q5pe7OxjNUQIZsS
X-Proofpoint-ORIG-GUID: P5unewuXlzHJtcyA6q5pe7OxjNUQIZsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=901 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403260099

Now, as all the minidump specific data structure is moved to
minidump specific files and implementation wise qcom_rproc_minidump()
and qcom_minidump() exactly same and the name qcom_rproc_minidump
make more sense as it happen to collect the minidump for the
remoteproc processors. So, let's use qcom_rproc_minidump() and
we will be removing qcom_minidump() and minidump related stuff
from driver/remoteproc/qcom_common.c .

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v9:
 - Change in patch order from its last version.
 - Rebased it.

v8: https://lore.kernel.org/lkml/20240131105734.13090-1-quic_mojha@quicinc.com/
v7: https://lore.kernel.org/lkml/20240109153200.12848-1-quic_mojha@quicinc.com/
v6: https://lore.kernel.org/lkml/1700864395-1479-1-git-send-email-quic_mojha@quicinc.com/
v5: https://lore.kernel.org/lkml/1694429639-21484-1-git-send-email-quic_mojha@quicinc.com/
v4: https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/

 drivers/remoteproc/Kconfig         | 1 +
 drivers/remoteproc/qcom_q6v5_pas.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 48845dc8fa85..cea960749e2c 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -166,6 +166,7 @@ config QCOM_PIL_INFO
 
 config QCOM_RPROC_COMMON
 	tristate
+	select QCOM_RPROC_MINIDUMP
 
 config QCOM_Q6V5_COMMON
 	tristate
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 54d8005d40a3..b39f87dfd9c0 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -25,6 +25,7 @@
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <soc/qcom/qcom_minidump.h>
 
 #include "qcom_common.h"
 #include "qcom_pil_info.h"
@@ -141,7 +142,7 @@ static void adsp_minidump(struct rproc *rproc)
 	if (rproc->dump_conf == RPROC_COREDUMP_DISABLED)
 		return;
 
-	qcom_minidump(rproc, adsp->minidump_id, adsp_segment_dump);
+	qcom_rproc_minidump(rproc, adsp->minidump_id, adsp_segment_dump);
 }
 
 static int adsp_pds_enable(struct qcom_adsp *adsp, struct device **pds,
-- 
2.7.4


