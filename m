Return-Path: <linux-kernel+bounces-125918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31720892E34
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9628D1F218A0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA110FA;
	Sun, 31 Mar 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="y/mcPyJM"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946487E9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711848707; cv=none; b=ihwgDM2KbaASM/ym5p7sF1LWlS8KG1HYNLlqwdEGnC0NXL4WptwIebf5yrRxk3+Bi5fltSXCvTp+j49j7HR46TaadqN/TpfBr3l+EH/HOfHfV4Op2RZu8HG8kJEC0QVEgRMND0kn1/AJhImH4DemkAqwYxSH4oEUvz1G5KRmb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711848707; c=relaxed/simple;
	bh=+Rq/WGVMfaAaENb1dfR0qroMqXD7ZO67MAafXubZalE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Pk4kelAN0Jyaxmas7bvDqUlPWGWtBVBTf2vhqkMfGG4QPGPwo7yi9+QFjFRzB2MdbZQ+zrBPeGmbbLR38lQYlChBGz4Q3rbpHMEmPGTPoF1x7h8f6izok030yxWTFd9iQ/9RSTnWYHxEgXSW5HaUxH9fXTyWOuWNPHwTb7izibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=y/mcPyJM; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711848702; bh=rMYFnHJQ1YF4qyTAPas1uqvbpFRkQTmxzFOLJyQXG6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y/mcPyJMewBDjZnGW4g0WLbd5Jjlwwr5/mZJwg2FVhWbHoOpZfd+vMrixJEB9PEAq
	 TVBfW5NcwzUPWh698WSf9TDqxWRNRPu4lgSJmL4sjL8ORW+IyLEZ0lXA9Ug/QgbNHr
	 0WlRUt0AJ0FKzln1Cp2jlC91s8OZyIc5+9Di00PM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 7E880EA9; Sun, 31 Mar 2024 09:31:40 +0800
X-QQ-mid: xmsmtpt1711848700t9bmd44mv
Message-ID: <tencent_3B1966563C69363897A236A64A4E74437709@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSGKrmfDl+FNKZaJYwJtMcbTiYZlA0cW0aS8gPMg1LwVK5FesNXJ
	 7PpcvEC5AVKLBJImb8XlQTnuke3ZQbCMxk8delXf+cxY0D30Dau3Rb9Pih7hflJC0jUK3+Gxcylv
	 pGAyRLRiCzAXBDYL11p8bpXKgNpwQbTDQxjNHEJqjiADzvo4lQU3XsxRboBHubWt00sWc1TcYLns
	 V4I8Cxq/Lieoz+KJ6tz4CF+BqlPIoq4xTihxegY19vckFLZC78hr1tJU5dVTEyTC/49CLBhSDSuN
	 VO2WdT+pP7g6glum6l9S0ZoUcUdV5/te4Hv47//Eddy+ltaH4R39L+U+XfOixp9ciHLgQjFWBrAo
	 J9Rrotizl8m3P/tr1p2aG8lL2cxF63O3kJ2tjU9uRw5bLrxHaMHsJb+OFUoFSam1/I1OBHMPdF85
	 eyUHiwZMyHp22IQiK/NUv34VviDN56hrC799jMOfVeXh5Bwd/TT/QiY2RAw8okeXl+tra3wY1SwR
	 QCdt9GdR8tZMpAaKrcGfOWpZBv5vKd/2zu8xjYnLZYmxs/I7+xrCkY+Wpt0H7/NXEOPkqLc357oG
	 cEEnI3uQJCxWgblFn61aQaCE2w2vv3JcX3DAIA9dzvde8Wf7oDdYb8XW4Q44qAfWbrrdKSg5Wub2
	 YNVky58RxUGtWfvvJrSpOzkCnGitP0xbDKzOWGaCBlmJFXLyX77fzcw1eJM5GHmLzfSh5VadtbXc
	 6lAA6YnUcHJEqdUG387pARF7QKlevFlngIXBQ9uPSB4Gj/GFn92de8psUyNpbjBjGy61zMJ1npjX
	 pbDuGBjkmQ5XxIyEdfCXZgUw2g4mPS2DhNg//WV943AVhboyWAqq+UcxHJGfhaPxpAbhGiOLjWZC
	 98lSJtvup5k/6C0H3MmYl9o7WdKUpG1dLjW+esxNiD78CkfWiLUeqbBXhWEbnMaVPrM0JaD2jF
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
Date: Sun, 31 Mar 2024 09:31:41 +0800
X-OQ-MSGID: <20240331013140.719556-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000069ee1a06149ff00c@google.com>
References: <00000000000069ee1a06149ff00c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr deref in dev_map_enqueue

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 443574b03387

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 4e2cdbb5629f..ef20de14154a 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -86,6 +86,7 @@ struct bpf_dtab {
 static DEFINE_PER_CPU(struct list_head, dev_flush_list);
 static DEFINE_SPINLOCK(dev_map_lock);
 static LIST_HEAD(dev_map_list);
+static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame *xdpf);
 
 static struct hlist_head *dev_map_create_hash(unsigned int entries,
 					      int numa_node)
@@ -536,7 +537,10 @@ int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx)
 {
-	struct net_device *dev = dst->dev;
+	struct net_device *dev;
+	if (!is_valid_dst(dst, xdpf))
+		return -EINVAL;
+	dev = dst->dev;
 
 	return __xdp_enqueue(dev, xdpf, dev_rx, dst->xdp_prog);
 }


