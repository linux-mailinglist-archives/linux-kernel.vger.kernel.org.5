Return-Path: <linux-kernel+bounces-89642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBCA86F37C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE34C283A52
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974555CB5;
	Sun,  3 Mar 2024 03:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="C8UF+y9x"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A787F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709435663; cv=none; b=HLK0sMAXZtIdfl/yuELgx4/JgCONmK3ma5Vck3LXQMRtqseYu4lujwpFt3Bxvzvxoco7qlLDGxL7wf+vvC7DbSat+bCOvspNVxyUb3Ak4HbANA1+3sbSkaEk+VNoJuS9jHOGXZ8URE4vfwmofWwxUaXiLfOjTTQvacfliYo0vf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709435663; c=relaxed/simple;
	bh=5OCH4ubpafnoDYSK1m9V4em9FxgzMYJjrO1TpLlSxS4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZQsRrSbtVJeXS+qzUuQmkb7/a8yxyqfMxVOr2+rO1HSd/HrXRgHdLfbDQi8v6LRD2eFMs2oVWgsG6aTf8Vb/Yyw9T/aIzWOzc/I+gGYPFKWZbQftz2weS36/3zeXGGphekQT4ouuG/1Qn/n7XKzAj/vxS9vdG1sVNRI0oIDp/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=C8UF+y9x; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709435351; bh=v3WpzfiMBJXywrT2erFA2ns2yDgHUiWRul3btSHpFJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8UF+y9xFH8wmeXc9Ki2hzIEYByIK0j2CJL0JQTyH4uKs7yjKFALQMxRvUAEIwh+f
	 /cLodqG7cu79k9oBSJ8hlA8EpKvb0f14Xe/g6WEBOtEeM5LVrQo5k6mnXCDiXb+QEx
	 pqlZ6IIgTOiKy40dzJuZxbsYtY+IASDDwuydSWuY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 249A4A0D; Sun, 03 Mar 2024 11:09:09 +0800
X-QQ-mid: xmsmtpt1709435349t4qjp5ka6
Message-ID: <tencent_8C9B67BC3CDF3618963837324B3874D17709@qq.com>
X-QQ-XMAILINFO: NojR6Ao/DkEDVDit6y81s9TWIncZk1a8zeWyLZjjfhzjFG9K8fpSUnX3uBhXWB
	 3AYB8wuFAy6KxP9JsS0YBqdH/IuI6ClMCsUeN5gwPDlFzI+XUC8S92TkFfL9CDR8KMvd97BTg1Ja
	 xQ1ftGERyst92+xi9LBv91GpXaIwDSSbHMOU5WE+Rrtjyg9TZ1UYfAJdyMmsdgz9dYwRf/Nthd1/
	 jeK3Bzu26G6hqVmdcegiOaDtPAbRlBIZj0SNQqGSj5bv7FLc5gW8iq7UBLUhCfBNLOXD1pEoGrJC
	 agw0wjSWef5enjDHK2hvnoGhPrTvdzXqi7S78M429E8j/PMDrLgzZgCQRdGwNQ9cTlhXbhvOh7Pp
	 IEwg14QTuLizM/qGrrUR8Psv9nSEgDh0SA+YiMNYDgRreURTP80dmVLmJXl5oxqpET5yEjOX/jT/
	 5YDiS4p+uq2rkL8hntJJpme2+ajdnuHkeO8kGXZ7ICX3VX4hr2d7o0bS10Pg6SYQOcxWUDin87MO
	 FPTeyJVwT0XCciJ6HdEx7tXeHWorV4+KMrxUXMv63P42xKmMEWTpyIP4tSKs3k2uXeST4CSASmwa
	 9U4cqhe20Ea1Z4F6/7Hq/Da7tEUH7iCF8veH6S8AKXGZgC/Cru4G/8Uo8rpljh09/n5LUMG/nM7o
	 U15FUHbCCL7N/uWWdZF/eZ9F4WWf/45haPvissOoql3Gq2NlJP+GhE4fviyp7wO7KSWf+jHnk+xr
	 iNgVN2vli4knbpbHnqVAjOK5zsMyzwPC5gf/wApWAjinK3LFGf3GKLhgFGUp+yDhFMy2A9b9aUuX
	 y+NhOWG/UFmm7qchyC9Vp8bQ208qehNt44xxjPS40WFr2iiEQsT0LAYLINF8qOCKgPRoCuzqSQ1c
	 pZbzcRSZ/a74n/uCCypTaicgXf8G6k8/D9/TGswfKYhLJcMonK4JVzax3F+VmGr8nQJq8MgYKcXs
	 dA9VgHXH80fpDUgVk95AITPnQc3/ISLd91NvfnF9c=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_cat_keycmp (2)
Date: Sun,  3 Mar 2024 11:09:10 +0800
X-OQ-MSGID: <20240303030909.4147285-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000098b3700612b5ee0f@google.com>
References: <00000000000098b3700612b5ee0f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in hfs_cat_keycmp

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..c74d864bc29e 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;


