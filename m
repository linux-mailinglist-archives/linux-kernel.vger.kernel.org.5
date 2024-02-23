Return-Path: <linux-kernel+bounces-77716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380B860966
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7FF1F260CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD81DDBB;
	Fri, 23 Feb 2024 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="V962kKE5"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BAD29B;
	Fri, 23 Feb 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659049; cv=none; b=ME3930GpvP/b1cnL66qQGDD9ILeftliVT65LKqZcSPKmgaszQPNMB7AdDIV3bn84dqHfDqrgsQaskO4NUkfZ/bumHJmzSEqRAH3krX5LxD8dGq8RaS0IhupFu6pgk7go+JvrvnMVpsIf9Xk1mDGeENfhPiutVT+jwPs7XRnWv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659049; c=relaxed/simple;
	bh=xtgmmrwGf4oCx/Nion/tAMuKrudQc0Vc/AnG9TkdKSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uf4k2NpwA/0KLW84QSRW+x9jaAWUcDOnD1EDmPl9zlEDT8nETgfM+0JJGkBeDumLklN/hG5w62CzzTzwZ+T9kVviJ9TuyCK8XkBp00J7kj+bKnOp8SyFGGPG4S7rcn6bldqhx2KOgLqtSZQo+Rfum9boj22TDljffoRm+/M/ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=V962kKE5; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N3J0Gi028738;
	Thu, 22 Feb 2024 19:30:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=ruGkPXveDhQO3x9RTueUQtvKLkpPdHwXZoTwyUXISRI=; b=
	V962kKE50vz43a/OnTCpR1JXuu3wJMYQa7SZ1soJ4Rbf7HSQ1wJqYisygk4LYl49
	XqhKGwn7wJxVuOojoRGxqwn6h3O9JZ1JLnXODh+shaGLk5JnvwDSUqCbSNj/kGB0
	cgcLjIS/SrExi2uGFFFCD7nMSy7BtB+8tjjjspgm5m6IhlkComTPQsPeBjnWs2T1
	X1BKatjzkSGpIW1lEOp97Z6bDojg/wCV4RwDnZlx1O39zT4o/7M698L3QUB5I2lx
	49WTu9mA8/2FQiw5ZOrXeN3zg7bDqLEhWprLZK77p34fKltBW/YYabaTAStgdY61
	iLksmheeBeo6QMKIc9j/xg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wd20ctq8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Feb 2024 19:30:18 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 19:30:17 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 19:30:14 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <fw@strlen.de>,
        <horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <lizhi.xu@windriver.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>,
        <syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH net-next] net/mpls: fix WARNING in mpls_gso_segment
Date: Fri, 23 Feb 2024 11:30:13 +0800
Message-ID: <20240223033013.3547161-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iKJ=-V7xS2PqpkwrqF=kg7FJdTqYgVEsnvR5hie24aqZg@mail.gmail.com>
References: <CANn89iKJ=-V7xS2PqpkwrqF=kg7FJdTqYgVEsnvR5hie24aqZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rYk5XstyqiKgieUCz1qTh2fr5n7DvZ7k
X-Proofpoint-ORIG-GUID: rYk5XstyqiKgieUCz1qTh2fr5n7DvZ7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230022

On Thu, 22 Feb 2024 09:11:14 +0100, Eric Dumazet <edumazet@google.com> wrote:
> > When the network header pointer is greater than the inner network header, the
> > difference between the two can cause mpls_hlen overflow.
> >
> > Reported-and-tested-by: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > ---
> >  net/mpls/mpls_gso.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
> > index 533d082f0701..2ab24b2fd90f 100644
> > --- a/net/mpls/mpls_gso.c
> > +++ b/net/mpls/mpls_gso.c
> > @@ -25,11 +25,11 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
> >         netdev_features_t mpls_features;
> >         u16 mac_len = skb->mac_len;
> >         __be16 mpls_protocol;
> > -       unsigned int mpls_hlen;
> > +       int mpls_hlen;
> >
> >         skb_reset_network_header(skb);
> >         mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
> > -       if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
> > +       if (unlikely(mpls_hlen <= 0 || mpls_hlen % MPLS_HLEN))
> >                 goto out;
> >         if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
> >                 goto out;
> > --
> > 2.43.0
> >
> 
> I think Florian posted this patch, right ?
After you mentioned it, I discovered it. 
I forgot to check the email details before sending the patch.
> 
> We must add a Fixes: tag
> 
> Also we should ask ourselves :
> Why are we even looking at skb_inner_network_header(skb) if this was not set ?

__sys_sendto()->
   __sock_sendmsg()->
      netlink_sendmsg()->
         netlink_broadcast_filtered()->
            netlink_trim()->
	       1323         pskb_expand_head(skb, 0, -delta, 
                  1                          (allocation & ~__GFP_DIRECT_RECLAIM) |
                  2                          __GFP_NOWARN | __GFP_NORETRY);
               pskb_expand_head()->
                 skb_headers_offset_update()->
		 1977         skb->inner_network_header += off;

The root cause is: 
Initialize inner_network_header to 0 in network_trim(), and without any other
assignment operations.

