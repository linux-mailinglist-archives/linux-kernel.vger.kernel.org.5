Return-Path: <linux-kernel+bounces-30341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC4831D52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2CEB21FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DA02D05A;
	Thu, 18 Jan 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aqbaR28G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAC29429;
	Thu, 18 Jan 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594382; cv=none; b=LtDIgnRKyCHhdoNJOsvHbR4vcE70fiibb8xOWi5spcWi5mqVXr1co/c7Yak8oqdlXSt8VYkJOlTsehH6gpaXM6jj5P7B5kuVTDrzDYDevhU/SkcIzLPzZXQ2igqB1roKjyVMkYEiv5CnCD73nX3/YO9jCcfUAS1SX5HUWffmYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594382; c=relaxed/simple;
	bh=HIsuhJz2xjOzaNn4dAfL5qjx0UdbR6tCoP9H0Jum8ZU=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=KcN1EIi+9LDEspLz3eWYBoIWsvj/jv7DYFyb6RdJjgjDDSerLLS+MX7+6wk3/8QAXOW8Av/9Uad6CUlO3JadsqcMq+ctArZ5SM1IE2jp7AkmMadOQO9iBROyrcgeHI1EtEAcBMsGZt4b4ezErG3eYhmUDPcocQAt916VYjATQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aqbaR28G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IET6px016240;
	Thu, 18 Jan 2024 16:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=gBb3H3vMQRpyKqlY5i8ArYeJx6IwM8jcS43UCmibO1c
	=; b=aqbaR28Gq4WV3D/zxTdSUoX15fis5yV5IWvxNtcHg1rhYKUPzZ/3hhfdPsx
	2Vel1SCcJbfc5CnzKWq4y3QGXFD/O/oyOyKYa0UHUIthX4BNVc+COkacu8/ebLMG
	c6ox0ePFEyenwZbJrFhxogbnftbcOOLwPsbodkLJglFt1iKRSRQanEYK43zNp1Q3
	EFRFqZYfw4fn9LiqCKckImZ9DaTzngLMC4S7xtslvHRRVaVpmiHn1zSTEmkkUm7n
	O31BK9sOtFbQqPwBgR98Z/SYIyU7kDqQiit9h9wpwrcZWwInde4p3CPw3jdDMWI7
	OBNw+VmC7Oz5s3ZzvTz1doErp2g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpx8shg6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:12:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IGCtC3025424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 16:12:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 08:12:55 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 18 Jan 2024 08:12:55 -0800
Subject: [PATCH 3/5] wifi: ath10k: fix htt_q_state_conf & htt_q_state
 kernel-doc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240118-ath10k-kerneldoc-v1-3-99c7e8d95aad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 25DU34vyzjr2CZfbOjgPkHjPEQdnnPFR
X-Proofpoint-GUID: 25DU34vyzjr2CZfbOjgPkHjPEQdnnPFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180118

Currently kernel-doc reports:
drivers/net/wireless/ath/ath10k/htt.h:1488: warning: cannot understand function prototype: 'struct htt_q_state_conf '
drivers/net/wireless/ath/ath10k/htt.h:1542: warning: cannot understand function prototype: 'struct htt_q_state '

Update the kernel-doc for these two structs to resolve the warnings.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htt.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 4a9270e2a4c8..eb0ce2f49315 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -3,7 +3,7 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021, 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _HTT_H_
@@ -1474,15 +1474,19 @@ enum htt_q_depth_type {
 #define HTT_TX_Q_STATE_ENTRY_MULTIPLIER		0
 
 /**
- * htt_q_state_conf - part of htt_frag_desc_bank_cfg for host q state config
+ * struct htt_q_state_conf - part of htt_frag_desc_bank_cfg for host q state config
  *
  * Defines host q state format and behavior. See htt_q_state.
  *
+ * @paddr: Queue physical address
+ * @num_peers: Number of supported peers
+ * @num_tids: Number of supported TIDs
  * @record_size: Defines the size of each host q entry in bytes. In practice
  *	however firmware (at least 10.4.3-00191) ignores this host
  *	configuration value and uses hardcoded value of 1.
  * @record_multiplier: This is valid only when q depth type is MSDUs. It
  *	defines the exponent for the power of 2 multiplication.
+ * @pad: struct padding for 32-bit alignment
  */
 struct htt_q_state_conf {
 	__le32 paddr;
@@ -1518,7 +1522,7 @@ struct htt_frag_desc_bank_cfg64 {
 #define HTT_TX_Q_STATE_ENTRY_EXP_LSB		6
 
 /**
- * htt_q_state - shared between host and firmware via DMA
+ * struct htt_q_state - shared between host and firmware via DMA
  *
  * This structure is used for the host to expose it's software queue state to
  * firmware so that its rate control can schedule fetch requests for optimized

-- 
2.42.0


