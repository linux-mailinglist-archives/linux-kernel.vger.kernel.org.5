Return-Path: <linux-kernel+bounces-82319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1041D86825A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255F31C24BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761CE131E26;
	Mon, 26 Feb 2024 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jUmAv6cT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42E405CE;
	Mon, 26 Feb 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981353; cv=none; b=J5IqeOY3Fv1uMYWjufuWcUk5RBceHyM9Vcv5X6xmVcA3YM+SapbYls/aBYXyQvB+KdXB5fotv5/EgZlHDfesO1KTzwFr2VDOyXW5sDUzFXKpDi/WjEk6hkpAzxgYNBGmvsuI4J8FH6SGG5bYBxVIhFB3Is0c5udZMuG9jum3BD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981353; c=relaxed/simple;
	bh=A7PRublYTk9mFqh5r3xgnvZLW5vvAp5cJyd1arhzfOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=FpfQY/rUF40A/Qt/01jp0Y4kkfz9m2AWohg3ucR55mW1fTEgui2gkNcmAcUrIZo94ECY53Za0GqQZOb7WiuF5ScLrSKfm/njA8y81kMpZ08X+ShdIFb5gFtQG3uyVP7c3YxHl1Cy3J2BdkZwsuDrciYelUEOyM1vVHp0pk0FeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jUmAv6cT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QGhw9s010029;
	Mon, 26 Feb 2024 21:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=iLr
	i/+mCTqTZgvVwhFdKyztQ7pBz1bs9wWlBzJYoMss=; b=jUmAv6cTScKEJe7tE6e
	9L2/OqPOfnItUQpB0RtSwU7OUDK3lnEv0AB93ZC0z7jwqVd2YgwPBmg3+Kv63y2l
	zA6RDUZEmif9wWKtlMF3v2qTeBC8xtbckkygUrbkjTv1rL+a8Xa3w3FEsn+tUEnJ
	ATwxSWVI0lABJyjNlU0/pz8MSBtD5GTlVhjSVQiLvzoCddGSrNoAVNmBh2Vgh/2n
	Q6aCMl6TS2L+7VAn8Mnb6U4GbJmssJO/ihzb8AZ8sGwEfhIi29xWBAQlKztvbUvP
	ENTv3dLlS0ID0Q66sMVFfPxyZZiTL4TRVRgjbbJbqySY4z1XKjn6zOHSy/3AkOa7
	0rA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxpa2sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 21:02:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QL1ujA019544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 21:02:08 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 13:01:56 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 26 Feb 2024 13:01:56 -0800
Subject: [PATCH] wifi: ath11k: remove obsolete struct wmi_start_scan_arg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240226-ath11k-obsolete-wmi_start_scan_arg-v1-1-c0b94c6e191d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEP83GUC/5WNSw7CIBQAr9Kw9hmgH4wr72GaBumjfdGCAlZN0
 7uLvYHLmcXMwiIGwsiOxcICzhTJuwxiVzAzajcgUJ+ZSS4rLmUDOo1CXMFfor9hQnhN1MWkQ+q
 i0a7TYQBVN6q3kltbc5ZD94CW3tvk3GYeKSYfPttzFj/7V34WIKBWtsSyVLo6NKfHkww5szd+Y
 u26rl9CPJ0A1gAAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NnjY68zs3LXtfQYj2si6rPjfB-AGIKm9
X-Proofpoint-GUID: NnjY68zs3LXtfQYj2si6rPjfB-AGIKm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=707 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260162

ath11k inherited struct wmi_start_scan_arg from ath10k. However, in
ath11k, this struct is unused -- struct scan_req_params is used for
this functionality. So remove the unused struct.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index bb419e3abb00..1c980f56bc72 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_WMI_H
@@ -3444,34 +3444,6 @@ struct wmi_bssid_arg {
 	const u8 *bssid;
 };
 
-struct wmi_start_scan_arg {
-	u32 scan_id;
-	u32 scan_req_id;
-	u32 vdev_id;
-	u32 scan_priority;
-	u32 notify_scan_events;
-	u32 dwell_time_active;
-	u32 dwell_time_passive;
-	u32 min_rest_time;
-	u32 max_rest_time;
-	u32 repeat_probe_time;
-	u32 probe_spacing_time;
-	u32 idle_time;
-	u32 max_scan_time;
-	u32 probe_delay;
-	u32 scan_ctrl_flags;
-
-	u32 ie_len;
-	u32 n_channels;
-	u32 n_ssids;
-	u32 n_bssids;
-
-	u8 ie[WLAN_SCAN_PARAMS_MAX_IE_LEN];
-	u32 channels[64];
-	struct wmi_ssid_arg ssids[WLAN_SCAN_PARAMS_MAX_SSID];
-	struct wmi_bssid_arg bssids[WLAN_SCAN_PARAMS_MAX_BSSID];
-};
-
 #define WMI_SCAN_STOP_ONE       0x00000000
 #define WMI_SCN_STOP_VAP_ALL    0x01000000
 #define WMI_SCAN_STOP_ALL       0x04000000

---
base-commit: 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5
change-id: 20240226-ath11k-obsolete-wmi_start_scan_arg-7567df20ff50


