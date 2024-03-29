Return-Path: <linux-kernel+bounces-124167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A347891352
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB123288FED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C83D0A4;
	Fri, 29 Mar 2024 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RgO3vYVm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C22232A;
	Fri, 29 Mar 2024 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691083; cv=none; b=o3oq4KJB8iJ73gsxUY9Y+ssfwd2JwrgegOSzUflMjAQpdyhMloX7J5arakpU3mniSlDafNR2R6Tm4MBLqgZmGJMEceBf8JY81POo92GE0SiZsEJtHe2Ju9rglz/hDRhtVRTD+eSgxYpA6ZQna1tWQriuOj0jycEooCzHKY3JjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691083; c=relaxed/simple;
	bh=38KMRfI89ZrY3PEuXOBb0T9854grl5dkmHeXd43cZf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Dnf79qCY6XJ9ZsORKbQFgjEExBKR3LZI+UGaDsfktTQBkz3CsiOKhRSLcRTGE30wBwZphTqEGZBnYwXvYQzfESo/OkMLLI7okXjactDyfs1Vt+J3cRqJ7AW8o+KtkK323H7/u5v9ndZAqb9UHhySsOCieI75AeO5LrpUy0FPKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RgO3vYVm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T5gh9B025814;
	Fri, 29 Mar 2024 05:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=MAw
	NgM10bZWkhq9ut0z5aUokVTCPHLtp9okCypZLUCA=; b=RgO3vYVm/mIwfFYdLRz
	kby7FJgcsM5Dpi14yVJFeNToFfqoKejpCQ5q838inez7kcViY6tkjSLJ0P80dZQ8
	aiPGdWCKjL8J1nL+xp8WNMZU2Dt3B8TlxSyQkvrmBnVa2B9BLB/s8G0YinuWMo7y
	UM84bwESCB8lJ2uqEOHXni1UoSTdCLJ6pdAJxS6HyJ8gbkNOtVz2ERuMgthNtRTA
	F2KyDZ2HtecSS1Ao34W/T+dxPwzPgZK3j86v3pzUHxlcPSXwtJGEW83Kto7OFgHJ
	TUS37VUR4O6Xjfyc7oAvTk21Nc6/Fp5NnL3/+VH8SqAcCB/NQ0RYlUFMb39F4inD
	Gkg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5qqn0044-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 05:44:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T5iFLG025161
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 05:44:15 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 22:44:14 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 28 Mar 2024 22:44:13 -0700
Subject: [PATCH] wifi: mac80211: correctly document struct mesh_table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240328-mesh_table-kerneldoc-v1-1-174c4df341b1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACxVBmYC/x3MQQrCMBBG4auUWTuQpkGqVxGRJP01g2kqGVGh9
 O5Gl9/ivZUUVaB07FaqeInKUhr6XUcx+XIDy9RM1lhnBjvyDE2Xpw8ZfEctyNMSeR96GH/AODh
 HLX1UXOXz357OzcErOFRfYvrN3lKRocqzl0Lb9gUGfqN/hgAAAA==
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
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IxLy9ROgPNO2-E9CuGD-5ow-R9MWikEn
X-Proofpoint-ORIG-GUID: IxLy9ROgPNO2-E9CuGD-5ow-R9MWikEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_04,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=704 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290046

Currently kernel-doc -Wall reports:

net/mac80211/ieee80211_i.h:687: warning: missing initial short description on line:
 * struct mesh_table

So add a short description.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/linux-wireless/a009a21a-56d7-4a1a-aaf9-feefa5acc561@infradead.org/
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 net/mac80211/ieee80211_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index bd507d6b65e3..3b3eb3162441 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -684,7 +684,7 @@ struct mesh_csa_settings {
 };
 
 /**
- * struct mesh_table
+ * struct mesh_table - mesh hash table
  *
  * @known_gates: list of known mesh gates and their mpaths by the station. The
  * gate's mpath may or may not be resolved and active.

---
base-commit: 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c
change-id: 20240328-mesh_table-kerneldoc-6b1e0a9e8344


