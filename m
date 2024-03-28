Return-Path: <linux-kernel+bounces-123652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105BB890C41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327041C26C99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64713AD3B;
	Thu, 28 Mar 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z9AbJH6g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033313AA5F;
	Thu, 28 Mar 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660114; cv=none; b=j+rZd78t14F6jvdhht9fMfxmK3WyWl9UItlUbxm/EiSzPFG/kommxuZvu1J4lZOC1woZpNjHfGl3raG2ai2ldKlIdQEUe14GwQfHmtapt7dh9RbnZeDFpcuWfG+q+iLNi2As4CVI0hcR/iUIsbbo+lmQpVJYtHSgHuHmpmmyH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660114; c=relaxed/simple;
	bh=7nBpC+ZQDDjgWAiXHx2Dnp9F7qfeWRyKrR0L8kcTm+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ZUyM0NcLT2PmBRGD6aKVqQJNAn5Lyf9445ptci6fhVesT1iDK/j0oItM6w91080yoR8SXRPkHuQRcLsG+6vI0BoRcrICbw3xb9yzl21r48G5y+ShnnaYWBRAZ6MfTWMyj+58Vk5ogAq8XFO5Csg9mDURw3N9UUM35MPB5TiKFZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z9AbJH6g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SJsU0T025706;
	Thu, 28 Mar 2024 21:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=C6u
	J8bKPl3Ejk7cVp0J1A3lZipXuKjyCmUAO09Yk2R0=; b=Z9AbJH6gblrSqefCJwm
	F0PqiNLlMLCbcAl1EzS6c/g10KXDdGL02bc0T3cHBHdJIoVUZwEouYmUggefJ7S+
	aVdfebC5OLBNpU+2vioiNIrgoWTpF5NOME2IZjAY+caT2sSTRWmtxjyv0fJX02Ck
	io3LbHc/0TWEA2uOsSXzWgbCicc7Sl3AvR5+175gO86dwbjytLLkUwPfvN5X6tfS
	98jT4zctEJ4W2Aolng+aki3YonJ8JCkULrzhqMUcTorMo3gOCqV8l+MPHznfVuOu
	5kOpa00VpHQhe5Mjl0fo/u+Cpe25daPapo6VlB7eOKdq4pMwhlCe3xIzF3eS8aNR
	5bg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x575m9jn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:08:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SL8JHg031875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:08:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 14:08:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 28 Mar 2024 14:08:18 -0700
Subject: [PATCH] wifi: mac80222: Fix ieee80211_i.h kernel-doc issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240328-ieee80211_i-kerneldoc-v1-1-e848bdec58f3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEHcBWYC/x3MQQqDMBBG4avIrA0kEwOpVxEpJfPbDpUoCYgg3
 r2hy2/x3kUVRVFp7C4qOLTqlhtc31H6vPIbRqWZ2PJgPUejAKJl555qvigZq2zJCEd5hCWkIJ5
 auxcsev6/03zfP7s+tptnAAAA
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UExPF2-IgkRs6AVdZn0HSU9qCAHPWbXp
X-Proofpoint-GUID: UExPF2-IgkRs6AVdZn0HSU9qCAHPWbXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=775 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280151

kernel-doc flagged the following issues:

net/mac80211/ieee80211_i.h:146: warning: expecting prototype for enum ieee80211_corrupt_data_flags. Prototype was for enum ieee80211_bss_corrupt_data_flags instead
net/mac80211/ieee80211_i.h:163: warning: expecting prototype for enum ieee80211_valid_data_flags. Prototype was for enum ieee80211_bss_valid_data_flags instead

Correct the documentation to match the code.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
This file is being modified by a quicinc.com patch and my review
process flagged these pre-existing kernel-doc issues.
---
 net/mac80211/ieee80211_i.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index def611e4e55f..458f63ce9a32 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -132,7 +132,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -145,7 +145,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE

---
base-commit: b68b2beadfd30907faae944358de3a17acf6fdb6
change-id: 20240328-ieee80211_i-kerneldoc-d28d95f5c5d3


