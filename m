Return-Path: <linux-kernel+bounces-52125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE807849464
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC6B1F24EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42E10A28;
	Mon,  5 Feb 2024 07:20:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46E12E41;
	Mon,  5 Feb 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117636; cv=none; b=cI0hwLaX5efNnk9ygmf6udXXuNnhu5BxtaPKXUj0IKK6K9pr7AEJUKPQ1G/Vl2Y6foW8Wb1fsLWSAUFwHQqY5q8lVsNXizKHwbUU/4H/kADj/Q8vyBbRmhRCQ9w0PhAQ4OOsPO45hchNGJyV/xN5/n7sqTG2gRxxszWcXPC+YD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117636; c=relaxed/simple;
	bh=MpcPCJ8OHa62mqT71EVPPtiJjVXg/FDaluxqvC/Xmig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RGdyKse9TDkfds3GTE8aHYxtAHqGpYP+aEYaVHoSaI7atonJNmvtKbFkqPUER4RYxPkVi1ZlgdNfd4Jm18F0ZcmG5LPTLBNFgxrn0Zb2jDMI4oAcO14J6MfJEcHzHenidx4lsdXo19Ze7U4lOyIbgZT0LJpn/ibKE9aVcwxbm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7950df2b733046b096c9b10a8937474a-20240205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b00c66d4-7f23-45fb-b9e4-111d85d19326,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:b00c66d4-7f23-45fb-b9e4-111d85d19326,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:5eb0a083-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240205152027ELQR4QSH,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 7950df2b733046b096c9b10a8937474a-20240205
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1184000622; Mon, 05 Feb 2024 15:20:25 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E4C99E000EBC;
	Mon,  5 Feb 2024 15:20:24 +0800 (CST)
X-ns-mid: postfix-65C08C38-73805272
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 85FCBE000EBC;
	Mon,  5 Feb 2024 15:20:22 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next 0/6] Use KMEM_CACHE instead of kmem_cache_create
Date: Mon,  5 Feb 2024 15:20:07 +0800
Message-Id: <20240205072013.427639-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As Jiri Pirko suggests,=20
I'm using a patchset to cleanup the same issues in the 'net' module.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Some cache names are changed to be the same as struct names.=20
This change is recorded in the changelog for easy reference.
It's harmless cause it's used in /proc/slabinfo to identify this cache.

Kunwu Chan (6):
  net: kcm: Simplify the allocation of slab caches
  ip6mr: Simplify the allocation of slab caches in ip6_mr_init
  ipmr: Simplify the allocation of slab caches
  ipv4: Simplify the allocation of slab caches in ip_rt_init
  tcp: Simplify the allocation of slab caches
  ipv6: Simplify the allocation of slab caches

 net/ipv4/ipmr.c    |  5 +----
 net/ipv4/route.c   |  5 ++---
 net/ipv4/tcp.c     | 14 ++++----------
 net/ipv6/ip6_fib.c |  6 ++----
 net/ipv6/ip6mr.c   |  5 +----
 net/kcm/kcmsock.c  |  8 ++------
 6 files changed, 12 insertions(+), 31 deletions(-)

--=20
2.39.2


