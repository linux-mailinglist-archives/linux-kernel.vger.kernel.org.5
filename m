Return-Path: <linux-kernel+bounces-49293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35794846849
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C9B1C24AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6692482CA;
	Fri,  2 Feb 2024 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eJ6aqHIm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937B481A5;
	Fri,  2 Feb 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856088; cv=none; b=jvRGiG9imlAqpO7UpHot6urrnYUX0RKYebkjmOYOBLK/E2f/APm0Zih56LdkYfz5VMOv+sjh6ApnLzioJ+egPSIEu/PrOccmMQJHKv1grs7ID7929+3xQEK7+md3Bnr8jS/T5vyf6Hd3xJBHQ7hxSwcZlQlvRkxf2E/crMFSQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856088; c=relaxed/simple;
	bh=ZDnGKGfbR/v3Yx+LWz4vHfhF/MSvu7CCgdFnaeoJrQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afUb2iRpfBuQkrP+2w4mWMSR1dulfosAdPVl35eqY65uV06rzIPh2+tjo5Xs0L8lXbbgH52M5jrjldUrFpoevrao+FEPZTLGPs3Co9j2dVq9EDXLpXJf3jgX0Gsz0eQM9sPbItp9awcdyRxZIGGGGteC5zt908syrzObGWuXm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eJ6aqHIm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124aHeJ005911;
	Fri, 2 Feb 2024 06:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=joizP/oCmG0LM1+iiXJ4
	kYTWEPaLDXDLpePwjwt1kV0=; b=eJ6aqHIm1IZ+4TntyRvYcDjEH6HLcT+fKvrH
	tXp2HOnjDOdHbkOza6lqfc3ji4jfHbgzJqPsy5ZqnvCvkkFN/rMBWRkSIIDUgF+d
	ahlQ9DUCneog5qj8as2WAiNiK3zrN0/nh0+UwL/1IVIefr9NwhzLFeAREs2QmIpe
	xDT4Ri3/7EpyeO1pH9+7mvTHQjrgOzggXYe2lU2sXS4eX+bSclZkNoEOUWa+bwWO
	lgWYmSh0UzPQwceL1J1PPiLlj9ahc/ae+iOb617UwlbRP4bMMQmxaX/ogK7NYi/W
	USFFyuDiApIQUxXcKvMxRg52w3bE6sLuVYSqpe1rxBnJHvX3YQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptu0nya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126fNxW004876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:23 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:21 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 16/16] misc: fastrpc: Add system unsigned PD support
Date: Fri, 2 Feb 2024 12:10:39 +0530
Message-ID: <20240202064039.15505-17-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7oMHNIU_IpdEdGw41FrG_bnTeYlAvhMN
X-Proofpoint-ORIG-GUID: 7oMHNIU_IpdEdGw41FrG_bnTeYlAvhMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Trusted CPU applications currently offload to signed PDs on CDSP to
gain some additional services provided by root PD. Unsigned PDs have
access to limited root PD services that may not be sufficient for
all use-cases. Signed PDs have a higher dynamic loading latency
which impacts the performance of applications. Limited root PD
services could be opened up for unsigned PDs but that should be
restricted for untrusted processes. For this requirement, System
unsigned PD is introduced which will be same as Unsigned PD for
most part but will have access to more root PD services. Add
changes to offload trusted applications to System unsigned PD
when unsigned offload is requested.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 7 +++++++
 include/uapi/misc/fastrpc.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4aa4e36bebc3..2f893c94dcc8 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2002,11 +2002,18 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
 		fl->is_unsigned_pd = true;
 
+	/* Disregard any system unsigned PD attribute from userspace */
+	init.attrs &= (~FASTRPC_MODE_SYSTEM_UNSIGNED_PD);
+
 	if (is_session_rejected(fl, fl->is_unsigned_pd)) {
 		err = -EACCES;
 		goto err;
 	}
 
+	/* Trusted apps will be launched as system unsigned PDs */
+	if (!fl->untrusted_process && fl->is_unsigned_pd)
+		init.attrs |= FASTRPC_MODE_SYSTEM_UNSIGNED_PD;
+
 	if (init.filelen > INIT_FILELEN_MAX) {
 		err = -EINVAL;
 		goto err;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 7053a5b6b16b..d0fb01e7277d 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -63,6 +63,8 @@ enum fastrpc_proc_attr {
 	FASTRPC_MODE_SYSTEM_PROCESS	= (1 << 5),
 	/* Macro for Prvileged Process */
 	FASTRPC_MODE_PRIVILEGED		= (1 << 6),
+	/* Macro for system unsigned PD */
+	FASTRPC_MODE_SYSTEM_UNSIGNED_PD	= (1 << 17),
 };
 
 /* Fastrpc attribute for memory protection of buffers */
-- 
2.17.0


