Return-Path: <linux-kernel+bounces-46288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385EE843D80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A91E1C285CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248EB79DA7;
	Wed, 31 Jan 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LiK3Z/RQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC679953;
	Wed, 31 Jan 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698717; cv=none; b=nnsF6EEAsrptTd+MCqjWNcYkTg7Voyo7GxirQohjUQMpc+zNuK+tne289NB2YXF+Jw2K5y9eKlvyxdfZRPRFlfn5VVRk1dIseSl/dLfMHqxH6HMP8f5Ke9/tugXc3iihFQpno7g+Tg2LOG2HoEeKs2nr06GyPJWIB2j6rM/B0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698717; c=relaxed/simple;
	bh=DWW42lRKW8z+XXhJKirfF9qYlmBMqyqEeAo1rAWCeA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuhKcmKNO71DkKMZJvGyAVzqAKEbRCntd40eKK0r5gX3/yMpE1gulWVa8kP+NSb901wkBlOMm6zApHF61ijOM6dm/S4mVjHSJhI5sGRU9hPgkxqak8K6R2cOEOsq1mLjLdDYXtOvJ/VCXIZby2Upr2UKV1ZYrRYNefhMGiSfges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LiK3Z/RQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V77YuF031043;
	Wed, 31 Jan 2024 10:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+iz/KDghEOECmAX5bp6ac8UBJUPavfQUj6HKKlQ4FLY=; b=Li
	K3Z/RQcPkYCi9IOuUAJvIB+OVL3zO+q7HfVdzEHAQ3YbNzezJLyLPAKa1tiUHaGf
	IB79tQkaib8vXeHI3YzM3ng/lAjUPqJnr1Tgkwl13qE3IbMk+hbsF6Sqwn3FBSng
	nTLJQFAPTNM/iCDGxfuXIpLLFrBCXcw7s5G2VCMQVeDBPr6/rVVdROfWOnqw/UgU
	Mhxv+UAuVvKOXWzQTgZ0qjy8Vh9WkvqpL70+w/J8BA/zrL0GZIwjo2dsNh3tjwR5
	qPzXF3Ds/zcLJvEPJNjeGuK3SZPVIpXkKdEkPHDB83ABlnY5th8wylepPURH3fgt
	IbxPGvwMHNVMPyBh1/5g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyfnjrx0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 10:58:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VAwG25011908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 10:58:16 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 02:58:11 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v8 03/10] remoteproc: qcom_q6v5_pas: Use qcom_rproc_minidump()
Date: Wed, 31 Jan 2024 16:27:27 +0530
Message-ID: <20240131105734.13090-4-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240131105734.13090-1-quic_mojha@quicinc.com>
References: <20240131105734.13090-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W8Y3mGYuADYQl0bG60k9ORCYx8LS7eXP
X-Proofpoint-GUID: W8Y3mGYuADYQl0bG60k9ORCYx8LS7eXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=975 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310083

Now, as all the minidump specific data structure is moved to
minidump specific files and implementation wise qcom_rproc_minidump()
and qcom_minidump() exactly same and the name qcom_rproc_minidump
make more sense as it happen to collect the minidump for the
remoteproc processors. So, let's use qcom_rproc_minidump() and
we will be removing qcom_minidump() and minidump related stuff
from driver/remoteproc/qcom_common.c .

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
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
index a9dd58608052..21e2e8eb0b2f 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -25,6 +25,7 @@
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <soc/qcom/qcom_minidump.h>
 
 #include "qcom_common.h"
 #include "qcom_pil_info.h"
@@ -131,7 +132,7 @@ static void adsp_minidump(struct rproc *rproc)
 	if (rproc->dump_conf == RPROC_COREDUMP_DISABLED)
 		return;
 
-	qcom_minidump(rproc, adsp->minidump_id, adsp_segment_dump);
+	qcom_rproc_minidump(rproc, adsp->minidump_id, adsp_segment_dump);
 }
 
 static int adsp_pds_enable(struct qcom_adsp *adsp, struct device **pds,
-- 
2.43.0.254.ga26002b62827


