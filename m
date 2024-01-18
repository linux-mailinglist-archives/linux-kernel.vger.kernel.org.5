Return-Path: <linux-kernel+bounces-30342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADC831D51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DA31F2408C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EC42D05B;
	Thu, 18 Jan 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E7t0IQ4K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9362C197;
	Thu, 18 Jan 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594383; cv=none; b=iJvGXFv03xVxJv3GGTX8o51eRVIB+xOqjRKSaZap6cI0/8p+VZWaD0d1UU6799voUUknalqsw+Tc+9gRgezDzI9bQ0JXNIzdOJBl3nongOz6rGO03OhSH4HUhCnZecu/MxUfnpKa4kW4N95DsqZH//1GKbUXam59w4ftL59K8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594383; c=relaxed/simple;
	bh=cVq8KIc6KbMwS94GCq0XE4YIyPj2j38EsV1T7oPH1cI=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=svBWjGbYZ+un6keSML62rsJ3oWPfz5vw8zUDVqhOJaZgPK+J2/mRzFZ/U4paJpPyKK1xAx6eRwDEAbm+JEFCGS2GvTjFCWp6W8y4Mkvu0y0kXgyWg1e3niluw6c9sDTb4fJUXUNEr5e+R+cDpw4uHe0Uybbvs6sdXRmiKRaF8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E7t0IQ4K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IFtoLh003667;
	Thu, 18 Jan 2024 16:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=xu6LTZd46of4ubV1T8bkdLfUORCXmE/Vrh+3G16Hzgg
	=; b=E7t0IQ4KKRqP66W1QzCTrCfwySqO2uRoRHfyYx1R7c10FkgKCA/6RcBaYWg
	7dNocXha1JYlhxg8kUWUC0DbZ/c3d1DgdOuXQndh9PwbrSoMHx6QZQ35qwvKxSlj
	0KOj330oiLtGbkT4RlGjlE6QXTDk6HdQ3801Y/HbcZPlXB6FOpbuNzOtljcDspSB
	Ir+NJG1dmtP15mkeILniSpbZKnWL+UWD/ZObXM9MnruNmuazQdFw/ZkSVRW4LzuX
	KJI+FXqvQpYigq/taxLSqIuFbIdOWrfCf3WW17LmnpxczaezSHQxj2hjswvRC4ji
	F2YXsGrjs6tfMcV8FFj13SP/8xw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq00116p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:12:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IGCuR1007130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:12:56 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 08:12:56 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 18 Jan 2024 08:12:57 -0800
Subject: [PATCH 5/5] wifi: ath10k: Fix enum ath10k_fw_crash_dump_type
 kernel-doc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240118-ath10k-kerneldoc-v1-5-99c7e8d95aad@quicinc.com>
References: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
In-Reply-To: <20240118-ath10k-kerneldoc-v1-0-99c7e8d95aad@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jYp6qPk_ZYAK8Non6zY-kJVaTpyo4p0X
X-Proofpoint-ORIG-GUID: jYp6qPk_ZYAK8Non6zY-kJVaTpyo4p0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=894 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180118

The kernel-doc script currently reports:
drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Enum value 'ATH10K_FW_CRASH_DUMP_REGISTERS' not described in enum 'ath10k_fw_crash_dump_type'
drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Enum value 'ATH10K_FW_CRASH_DUMP_CE_DATA' not described in enum 'ath10k_fw_crash_dump_type'
drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Enum value 'ATH10K_FW_CRASH_DUMP_RAM_DATA' not described in enum 'ath10k_fw_crash_dump_type'
drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Enum value 'ATH10K_FW_CRASH_DUMP_MAX' not described in enum 'ath10k_fw_crash_dump_type'
drivers/net/wireless/ath/ath10k/coredump.h:27: warning: Excess enum value 'ATH10K_FW_CRASH_DUMP_REGDUMP' description in 'ath10k_fw_crash_dump_type'

Fix these issues with the enum ath10k_fw_crash_dump_type kernel-doc.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/coredump.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/coredump.h b/drivers/net/wireless/ath/ath10k/coredump.h
index e5ef0352e319..8d274e0f374b 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.h
+++ b/drivers/net/wireless/ath/ath10k/coredump.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _COREDUMP_H_
@@ -13,7 +13,11 @@
 
 /**
  * enum ath10k_fw_crash_dump_type - types of data in the dump file
- * @ATH10K_FW_CRASH_DUMP_REGDUMP: Register crash dump in binary format
+ * @ATH10K_FW_CRASH_DUMP_REGISTERS: Register crash dump in binary format
+ * @ATH10K_FW_CRASH_DUMP_CE_DATA: Copy Engine crash dump data
+ * @ATH10K_FW_CRASH_DUMP_RAM_DATA: RAM crash dump data, contains multiple
+ *				   struct ath10k_dump_ram_data_hdr
+ * @ATH10K_FW_CRASH_DUMP_MAX: Maximum enumeration
  */
 enum ath10k_fw_crash_dump_type {
 	ATH10K_FW_CRASH_DUMP_REGISTERS = 0,

-- 
2.42.0


