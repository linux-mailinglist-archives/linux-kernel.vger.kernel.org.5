Return-Path: <linux-kernel+bounces-108013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070B8804CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE042852FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6B3A1B0;
	Tue, 19 Mar 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NnSppDL6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00625374D1;
	Tue, 19 Mar 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872798; cv=none; b=gj9vGUTUXCfmCy3L1V/IPI+C2rzWu4xQLfa5I+gzJtxoHQPwWoRVl+ZoYBO0o0Hi1PuBhp0ciTKAmXzPqF5ZZtL6XmXSMh6t+s259uQmMldlpZYXeHR4dlltlLpRMploHCwmgSTKRR+kq5p+E0FmEOvkB5wABuqwaPtESeBWI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872798; c=relaxed/simple;
	bh=9T2PXyIg3HiX45BkI0qzlOYAVooAgqStjOaoiSGJU+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OvM1C96qJm3BAEoZ2gFl1rORHBoJMC6ZpdrJby5e5rqij4m2Pb+qdWcyuzGTA6fmE75U8Nwc3+U6tUZYtxUiLsiC+bKWong7ASptngYwB07WupiYklILQiViNt1448AH5WLr9PkhEQMMZlgQUXev9uhTQ7R1sSnhy+qHqcnZ6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NnSppDL6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGsq6016714;
	Tue, 19 Mar 2024 18:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=I+ctJ7x5JpycnkSxzjrFU680P72eJvY58CHxP/eMBm4
	=; b=NnSppDL65/n50hVt5pXEmufymO+b4pFn1UYGtVennT81lOP/KhD6SUtV3+z
	yJXs7qvCHbbDXv+19ua1Wsm7iowTwQ/Ybz/M1Ws1ZJqhpL5ZlI3iqjxTV1rDUvtz
	W7FZWvbOU6Himv11wNHK8TrdBiKaPI0gb/mWENTRsEpI0x9SrPCW/bMxDSn8lube
	NEO5vmm/W4syOulCf4J3V5YFqTqzfwPunnpJze1W87A1WyqNv13Gd1vJFv//go3Y
	U8dzy0uAH8JrL6ViDZQie0xihAxu9pjw6fat675sABMtVmzsDlqV0mv4BVjrVl0Q
	YPupC8mFyqLVY/MOyAqxo8tlyug==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy553hse9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:26:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JIQT8T002402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:26:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 11:26:29 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 19 Mar 2024 11:26:23 -0700
Subject: [PATCH 1/3] wifi: nl80211: rename enum plink_actions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240319-kdoc-nl80211-v1-1-549e09d52866@quicinc.com>
References: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
In-Reply-To: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZJRHwTQKhWDHoO1PhhXSs89aMg0gXICw
X-Proofpoint-ORIG-GUID: ZJRHwTQKhWDHoO1PhhXSs89aMg0gXICw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=706 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190137

kernel-doc flagged the following issue:
include/uapi/linux/nl80211.h:6081: warning: expecting prototype for enum nl80211_plink_action. Prototype was for enum plink_actions instead

This is because the documentation doesn't match the code. Normally the
correct fix for such an issue is to modify the documentation to match
the code. However, in this case, since the actual name plink_actions
is not referenced by any code, rename it to nl80211_plink_action to
give it a proper prefix and match the documentation.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/uapi/linux/nl80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f23ecbdd84a2..9397c61a48dc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6077,7 +6077,7 @@ enum nl80211_plink_state {
  * @NL80211_PLINK_ACTION_BLOCK: block traffic from this mesh peer
  * @NUM_NL80211_PLINK_ACTIONS: number of possible actions
  */
-enum plink_actions {
+enum nl80211_plink_action {
 	NL80211_PLINK_ACTION_NO_ACTION,
 	NL80211_PLINK_ACTION_OPEN,
 	NL80211_PLINK_ACTION_BLOCK,

-- 
2.42.0


