Return-Path: <linux-kernel+bounces-125388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F8892542
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DE41C2138C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6EA13C3C2;
	Fri, 29 Mar 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SQcC6e1U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212C1DFD1;
	Fri, 29 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744054; cv=none; b=qpWUhTghtpxAkXbbsMYRpxBq/yFfZys+67c8HI2Hb7K9VWCuTtnEA5gsW+TP2qycXEPW42vwi3Q22OQlgnWt8tI2bxdhT1zcVFCurtZoQo1Dekfz+m2NlpP67Onkr2Y6HdgpQKjI18wD9nNkImPTZw02wUq34lmAxbb9/At2bME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744054; c=relaxed/simple;
	bh=gbGnL0gewmXLZlGj5Y4rOs83fi3Ir5o3AQbVnBS4Upo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pr1PZydC+d9O8PbnD2rgRIeG6nAuZFpfnzbuu+BS+g8Znu+fC+phB6s0omClBmL3ixUlrqkZLLVx0HqIlITXP9PivKtsHf6VJk0VWyG37pCickh0OBDFW7z3AbNSt+Znp+ggr0yr9OGHNmtNH5ub8yiy0OnZyMwZN/DFdSNXWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SQcC6e1U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THerM2001554;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=c1TSAXudN1gCLr4FCS1phZaaFIRMRxVAsvGPnn14IrA
	=; b=SQcC6e1UAWC7yj89VEyEUiVcKXt6/dbMvyFDW9q8hN7lEJtLhpnMI8xpbBM
	LFRSW364+bvcuWU0ee+RPA9rZQM3yMQfvzeN1CNnrmL5rb2UtMPcmaF6YDFhN5nD
	zJaTn4guqrGAXqwAFitMKWzF2SlX/BJMzC2eD8nJKeoaACAjm2a/ovy90NQsm/JM
	b9eYAt4HId7meSF4eguzzB0BinIaaFR4rvkD9xppyaNNyQ/lJ2SsONj7dngep8pY
	PkTyMBKVJ7hawJuXMzQ/DY5c9E+C/OKWlSbJyLx5EA43UEm1JemxQtXxEeBMvXoW
	N70Pka2klGMVEem4I+uRm+gqV0w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5u89heht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 20:27:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRJpW027230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 20:27:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 13:27:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:17 -0700
Subject: [PATCH 1/2] wifi: mac80211: remove ieee80211_set_hw_80211_encap()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-ORIG-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=653 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290183

While fixing kernel-doc issues it was discovered that the
ieee80211_set_hw_80211_encap() prototype doesn't actually have an
implementation, so remove it.

Note the implementation was rmeoved in patch 6aea26ce5a4c ("mac80211:
rework tx encapsulation offload API").

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 353488ab94a2..e6a11a982ca8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7478,18 +7478,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
 			      int len);
-/**
- * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloading.
- *
- * This function is used to notify mac80211 that a vif can be passed raw 802.3
- * frames. The driver needs to then handle the 802.11 encapsulation inside the
- * hardware or firmware.
- *
- * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @enable: indicate if the feature should be turned on or off
- */
-bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
-
 /**
  * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
  * @hw: pointer obtained from ieee80211_alloc_hw().

-- 
2.42.0


