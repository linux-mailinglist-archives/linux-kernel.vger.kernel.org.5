Return-Path: <linux-kernel+bounces-82316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A32868251
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43CE28E2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451A131732;
	Mon, 26 Feb 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cMu+rolQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCC12FF76;
	Mon, 26 Feb 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981226; cv=none; b=Fzu6AiKMKJDzuquaA+V0lCq/CDr4snWzBuSE8NuT/CoXsJf47d99iMoysfw2WopfcslRvIYo8kUsUMnX5pBfIR+opRVIC66kG1RjzwAxhU98c1Kt/ItXadfamABrY13mKm/Bb87eSmdhIqpoZ8RvFuOUzl+eI/7fS2C0pqvdlfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981226; c=relaxed/simple;
	bh=CqKAgfhqWCkAN+Yh8guEy+nGyezIKAsMe8pLF3konyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=LHVzXU0eqPMbitdpKM2hx85eX439Ar7gAFk7YmiTFNBuYbkFH3+k7cdpNwg6oqZeppjH1hX14/Mj5ryh9nS2DZjS3Rdt5I5tiizvh/I9MH1saNUDrlbMEsbEzIYBtgDyU3M2VdHZY4mw/MtPCl0jOakN0/dnmA4voM+fqvGyJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cMu+rolQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QKmSva025052;
	Mon, 26 Feb 2024 21:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=Wea
	JlfCOZBzhWyoVmlZIsOgCFhwZIxr59P1NauudU7g=; b=cMu+rolQSiIcUcSNjV8
	EeZoeQFutc5gb5bzCEJcfIAm9kilSsZ6aI7fV8AmKubdn+bKicbI79YwnfIpYR/I
	396+UOF5+mupe0+z/2xY7sUD3jQ6m01rGlYGnk8LidW2KRm33KtH/D/FZa7rfKar
	M3q0LaEvb8XbZVUrkcjOEGZE+T92a82hN476tyLKH1lwKHSV8DsgovJk/Cpk0XA/
	XPE6qPnojelMWAW7CqAQlJCTTIZ71Fo/3LjNODbrfagRxp6es9w6O9jVdVvxln8F
	YNqURGkNFMRx4rEn1yYhpkZZG3lER2kk3T9t999y1fZL2M4HzM+drwZo5XvDowEW
	xYA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxq22db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 21:00:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QL0H7W025119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 21:00:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 13:00:11 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 26 Feb 2024 13:00:11 -0800
Subject: [PATCH] wifi: ath12k: remove obsolete struct wmi_start_scan_arg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240226-ath12k-obsolete-wmi_start_scan_arg-v1-1-07b0b563cb27@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANr73GUC/5WNQQ6CMBAAv0J6toauVIWT/zCElLrARmm1W1FD+
 LuVH3icOczMgjEQsqiyWQSciMm7BGqTCTsY16OkS2IBORQ5wF6aOCi4St+yv2FE+Rqp4WhCbNg
 a15jQS4RjbtruAEWpRQrdA3b0XifnOvFAHH34rM9J/exf+UlJJVsDoHVX6p0uTo8nWXJ2a/0o6
 mVZvu73GDLWAAAA
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TrbdV0NSdXW-UtzuAIEDeyJEVqPfAic8
X-Proofpoint-GUID: TrbdV0NSdXW-UtzuAIEDeyJEVqPfAic8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=665 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260161

ath12k inherited struct wmi_start_scan_arg from ath11k. However, in
ath12k, this struct is unused -- struct ath12k_wmi_scan_req_arg is
used for this functionality. So remove the unused struct.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 103462feb935..2492082b4524 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3357,34 +3357,6 @@ struct wmi_bssid_arg {
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
 #define WMI_SCAN_STOP_VAP_ALL   0x01000000
 #define WMI_SCAN_STOP_ALL       0x04000000

---
base-commit: 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5
change-id: 20240226-ath12k-obsolete-wmi_start_scan_arg-e280abf72495


