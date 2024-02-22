Return-Path: <linux-kernel+bounces-75840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8020D85EFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76CAB23C14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF5168BD;
	Thu, 22 Feb 2024 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="l4LvchXu"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34F12E4A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571751; cv=none; b=td7hWbiZq5F2U2PiAeNw3ZQQK1/imGqX3SYkGyj6Iy4YzHiXcZcmhFC28uPPwKEfLQlslV9ks1queUBZDln1lYxUKXknAO71rjYhxpb1R3rn7GJbx+LM+DPTLg/j20XQnkNEpxHaykVEDcb+HEqrJaWSzBPrRl1Ce9WIWDdwuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571751; c=relaxed/simple;
	bh=8Ebf60YgQFc6nl1iB9fJx8bOTjo/YRpxJSkjf/BLdl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIvmXHi3Tj306zcEJKcmgAXp8tpSC0vMrF29jCXMBcRgL8DLVPoZp7mXgS0O1dFx+8Xn3Lxxrtxsdr8D48y9K+rVrlZOFjMSEkh8SWI9N5ceVgk8FvhYPpqMJdA/cSRpnPVSBj+7SHg/WQihn8SO5nOUVabMtajRi9esDPi9w4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=l4LvchXu; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M2hoBo008848;
	Thu, 22 Feb 2024 03:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=IoXHM+O4hDWnOg96B/lgZGtFkIfBFZzCbK7uno8KvXI=; b=
	l4LvchXu8RmafomJad5t3oSZ0hxXwGn2LcoU12wAZauTL7qWXOkNdmN8hb95guXO
	unX6t3X5yDsVyI9ZKeQcynSrWxJJuuPenDaI6RGO0QPBUudb8EphLOtr8Jg6zaqc
	M/2KpBXht0C5CvW1zjVfIgkSXY7hAR+64Fm7+EWJyQVzcVFyOs0d4imAdhDb7s0C
	5/P6pKC7sSIUOR2tokYLDtni1NL53USYRkUs4PcetVP7yhjDliIesXYWKYElcXM7
	pOI0n3xmAS07s4EPowClP2HwHdMQxY5XruZ1qRTeyOuzwqYK9M6UBPuxde09sxfd
	Ce9Qc3e4EOdwWqc2h3f3OA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wd218hhqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Feb 2024 03:15:42 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 19:15:41 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 19:15:40 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [net?] WARNING in mpls_gso_segment
Date: Thu, 22 Feb 2024 11:15:39 +0800
Message-ID: <20240222031539.2038610-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000043b1310611e388aa@google.com>
References: <00000000000043b1310611e388aa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 17T5v8jlnImoTHc9Nq1SXYX4L3LS2uR1
X-Proofpoint-ORIG-GUID: 17T5v8jlnImoTHc9Nq1SXYX4L3LS2uR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=807 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220024

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index 533d082f0701..2ab24b2fd90f 100644
--- a/net/mpls/mpls_gso.c
+++ b/net/mpls/mpls_gso.c
@@ -25,11 +25,11 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
 	netdev_features_t mpls_features;
 	u16 mac_len = skb->mac_len;
 	__be16 mpls_protocol;
-	unsigned int mpls_hlen;
+	int mpls_hlen;
 
 	skb_reset_network_header(skb);
 	mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
-	if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
+	if (unlikely(mpls_hlen <= 0 || mpls_hlen % MPLS_HLEN))
 		goto out;
 	if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
 		goto out;

