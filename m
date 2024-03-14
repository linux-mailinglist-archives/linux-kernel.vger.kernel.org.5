Return-Path: <linux-kernel+bounces-103804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E324F87C4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E9B1C2167D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8B2768F3;
	Thu, 14 Mar 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O0l5V/9x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979D7351E;
	Thu, 14 Mar 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710451392; cv=none; b=cVLkjqhPseCqztg5/XWf3l7YmFhK2s4P4j2smq8C8+cHhAYBVA6mfKjUfekus43iUP/hkad28lpIxBPSxYJOpWH4zL60jR6sG5dLn1VKu4NaxLkE0DxulTgjl5qrsGY2fapSYl5ccw732TbeQestrkzhj46sri8Isvvd5ujzzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710451392; c=relaxed/simple;
	bh=hYJrU2J6p32htXqnma2iNBASIUiMkBEvYwQKnOgxtys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SnfS03sXmVkWuuD4k3+4b3j9xV/Row5sjfhZG5A16gzhizWOQOv9/5uWJh4j2923UVOsGUZbvlB/TdFcqs0D8z2YhqDTwZskwKdX2DCwHvh910Y2cGE2QVEMdT7St7EHh3IKoAp1czc0k2/su1UM+c4ACvYFN/9wUwLQYFi0Sp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O0l5V/9x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EJo0uf023824;
	Thu, 14 Mar 2024 21:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=BQe
	++yJkxQ8pGxa4Gxw7WzFWkIVLRYyZRZ6c3OPJJ6A=; b=O0l5V/9xBhyJSNYiqHv
	SXhsLVcBJsV2GiAxX6OxslpHD5aB+1rJCcdRrbf11y0Lm/HzAsxCMbT/XqFdPV9/
	D1yMeO6Bu8TeRWxQBzjI3ml+TFkVIL1+wWKOKTrGFcx7ahXQEbQfpouGjSXGtn+6
	ucgIS15o5QJBQDVXUTWBxAUK9LY2cSMHUlyjxWMqkLxE/vG1659FyNT8jW5gK/s3
	O/w6NaDeHVgTeugZdy+NPfDavnnwMGRwgF7dUahAS7+Y4vbqP4FJGo+ecRTRGwj0
	bXumBTH6uWkdtsuBU8d1EPcmA54PXDIkUcYjbhZdhwDxNk8x9GX+phtfu4NvqEaZ
	Wsg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv1njs31u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 21:23:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42ELN0U4007019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 21:23:00 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 14:23:00 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 14 Mar 2024 14:23:00 -0700
Subject: [PATCH] wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240314-kdoc-ieee80211_i-v1-1-72b91b55b257@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALNq82UC/x3MWwqAIBBG4a3IPCc4ZnTZSkSI/dUQVChEEO096
 fF7OOehhChI1KmHIi5JcuwZXCgKq98XaJmyyRrrTMlOb9MRtABojGUeRbOvMaP2vuKWcnZGzHL
 /y3543w9u4KJjYgAAAA==
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
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PkDuVwM3FD5O8Tnl69D9DqXLSVj0aMmz
X-Proofpoint-GUID: PkDuVwM3FD5O8Tnl69D9DqXLSVj0aMmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=749 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140164

Running kernel-doc on ieee80211_i.h flagged the following:
net/mac80211/ieee80211_i.h:145: warning: expecting prototype for enum ieee80211_corrupt_data_flags. Prototype was for enum ieee80211_bss_corrupt_data_flags instead
net/mac80211/ieee80211_i.h:162: warning: expecting prototype for enum ieee80211_valid_data_flags. Prototype was for enum ieee80211_bss_valid_data_flags instead

Fix these warnings.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 net/mac80211/ieee80211_i.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b6fead612b66..bd507d6b65e3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -131,7 +131,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -144,7 +144,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE

---
base-commit: a368b0a9854ee2a466a55f95c0ce2208e4aaf0b0
change-id: 20240314-kdoc-ieee80211_i-1a7efe7aa519


