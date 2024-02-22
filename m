Return-Path: <linux-kernel+bounces-75885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 444DE85F04B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82B71F24AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6C017755;
	Thu, 22 Feb 2024 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="UVIb7hVQ"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53BFBF2;
	Thu, 22 Feb 2024 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708574479; cv=none; b=VIr3kveVb1hmE9OlexbmrDspSQzoUluTvmmVfg7E3XdvSSkYXIb/MMZJvzdx2GF6q/FBAeVUKBNI8jcgGyM3B5r2MZ5+wNbLWTnADvfGbaFst1eR/acbBbMVK2Hu7JHgo/d8tvyxU4/HDZccABRH7mlaX29GSw0EJfULCwiLEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708574479; c=relaxed/simple;
	bh=OJZtJeG9oFC0CHpkLX/+q6CW2oV5Xm1b7Y/agkt23OU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2ixyQBF3O18GxYOZDbO+MyaA0nip3psTNjSrso7GLqjdG/4ikjvDfnBcRejwmFIkaEEUC+TG+F/u0vrpLJQ7VONu83yJrQyWh6kPTkWT6YJRgBWKWKnoZ1rvhO2Id91WH4o7dL5Ih6OqJ6Eqmo+hpjm0EO73epZ9nEVmWW6bdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=UVIb7hVQ; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M2JpOs008937;
	Thu, 22 Feb 2024 04:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=7MhjdBIzVbtJC+qrWqwmXmRz5gU4c1bPbqnR2zTbpeE=; b=
	UVIb7hVQI1QU1gxPmSCLwsc1C1zChrc3VTuPstp5OAIdDxWofg4iV4BTbMeK1SDK
	mweU9Q0EWco3IgGMecMXSIadmzwq5xUkkU6nG2KZvYVn9J9ne6/BA7I376RGFYds
	Z0w+xk55+AHLQ9Y1D8evNwCzidBDersq4SyeGEdxM1OlxRjiZ4fJ/DbugC+mb1q+
	SUpuHVX7Wqik0AZjSggAy0Qd5xnctCZpu6YLuyF8YD5fLckSqOfMHMGITIduno+Q
	x5Jb/MQJdNmhodVGPJqgCr2VcVLMFuzLh+YnaQmlh1T00vp9o6cIBOXnjEznOpva
	SqmI8Dk9uUm7BELKXRkHlQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wd218hjn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Feb 2024 04:00:51 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 20:00:50 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 20:00:47 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <fw@strlen.de>, <horms@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH net-next] net/mpls: fix WARNING in mpls_gso_segment
Date: Thu, 22 Feb 2024 12:00:45 +0800
Message-ID: <20240222040046.2568269-1-lizhi.xu@windriver.com>
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
X-Proofpoint-GUID: yxP3AvRov-tsgP_uT6gijPle0aFETzCU
X-Proofpoint-ORIG-GUID: yxP3AvRov-tsgP_uT6gijPle0aFETzCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=922 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220028

When the network header pointer is greater than the inner network header, the
difference between the two can cause mpls_hlen overflow.

Reported-and-tested-by: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 net/mpls/mpls_gso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.43.0


