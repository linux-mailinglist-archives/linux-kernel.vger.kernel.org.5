Return-Path: <linux-kernel+bounces-59763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E984FB84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806B91C2501D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA3480C1B;
	Fri,  9 Feb 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqf/GXHK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B180BF5;
	Fri,  9 Feb 2024 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502040; cv=none; b=KGF19STA304lv7RL4V2gbG+oj7p5bNrqRydQ8SJddanSAAuzF5Pqc50hqxYMLXDE83YETRH+06N6vxTlj5jbGbjdCqDiTF/fA9rMHcPnxFq3vniyyfaEEbg/KIDSj2cL2XpTP9xWEoVXuzIMgJU5uvMOfiCaxWGSSKHycu/1pOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502040; c=relaxed/simple;
	bh=/vVHfU4e8VpEUslZI8rvDFAJFug05ANihwQevcdLXQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeguQDkly1PvJeoJUC74Yv4zTbrl/KZ8TafSNJvISfkVGyMLNh6xztXREt2VoLxdqP+1UUqreKiDhuQOR/XAShgIdk0wfcQsduDYPDDdInk0tmOVj1T+A0xyHXlonJ35KMFNXKkfN8+YZbu7oienHLTx0uo3AoU71RFAKNSU9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eqf/GXHK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419H42nH011805;
	Fri, 9 Feb 2024 18:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=6HOUs3KwIxMYByg9Nllb37I2V7KbdMSxVpV5fSt60Z8=;
 b=eqf/GXHKvfNdsi/IJ/lqrq2ZJQF2Rvxl2udzjgMibw75EVx00/oKkLiF0TWllOTYnHeT
 rutaM1E3Dm9RB9ywIndwo7Ss8qU0MIxfYFm3EN6Fl7HUplz/ZfRRjol3d+EGOCPyT9oI
 0hiy2POjXG06wcslOr1O7PE1yf2WFs973hDveK5Rzr8WJdjY/mNCBGPLpO4xTfZvmpoZ
 ROlwgHRS5cqkRQTjNjkdCKzTr1No+sPFuih52RPNFbZkyn/XiFT6AnJgXOWvY8lCLYgt
 Zx1Ov42kVOCkR+XgBWHdBwHHF0tvaxhl75bc/gSeT6Z/InOJaGBjunr/X0ByMUY6O2Hy Zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ur102-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 18:07:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419HgVNm019807;
	Fri, 9 Feb 2024 18:07:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxjtcer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 18:07:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419I77HK003846;
	Fri, 9 Feb 2024 18:07:07 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w1bxjtcdd-1;
	Fri, 09 Feb 2024 18:07:07 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: darren.kenny@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] net: sched: Remove NET_ACT_IPT from Kconfig
Date: Fri,  9 Feb 2024 10:06:56 -0800
Message-ID: <20240209180656.867546-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_15,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090131
X-Proofpoint-ORIG-GUID: qN2dE4OUBodg7SCRNEV7sqwNg7ONaBS3
X-Proofpoint-GUID: qN2dE4OUBodg7SCRNEV7sqwNg7ONaBS3

After this commit ba24ea129126 ("net/sched: Retire ipt action")
NET_ACT_IPT is not needed anymore as the action is retired and the code
is removed.

Clean the Kconfig part as well.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is just based on observation.

 net/sched/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 470c70deffe2..8180d0c12fce 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -737,16 +737,6 @@ config NET_ACT_SAMPLE
 	  To compile this code as a module, choose M here: the
 	  module will be called act_sample.
 
-config NET_ACT_IPT
-	tristate "IPtables targets"
-	depends on NET_CLS_ACT && NETFILTER && NETFILTER_XTABLES
-	help
-	  Say Y here to be able to invoke iptables targets after successful
-	  classification.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called act_ipt.
-
 config NET_ACT_NAT
 	tristate "Stateless NAT"
 	depends on NET_CLS_ACT
-- 
2.39.3


