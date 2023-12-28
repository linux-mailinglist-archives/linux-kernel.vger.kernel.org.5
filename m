Return-Path: <linux-kernel+bounces-12694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C8381F8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF5228465A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C08832;
	Thu, 28 Dec 2023 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L2D9Nbmb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FC8829
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703771960; bh=ryV+AQarpijjX7rKTmkroStr/FfmPosOvIHTYFtCWK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L2D9NbmbViCgWFYnhTMB0j3l2l7R8OuwvaQ89VOlF1xeEtG/7dwBy0mNQscw7Guld
	 +4dxkqzpT2tt9cHR2/OEVHvCrE3U2glmDAOggEpLEP4tv/rQoVqm7bIzj+GfqK1UEH
	 d0JRq/AS5Y2XLNoa6SeJu12P0Gf0+0VEtRydx/yY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id ED328080; Thu, 28 Dec 2023 21:59:19 +0800
X-QQ-mid: xmsmtpt1703771959t621j00sg
Message-ID: <tencent_0EAD9E2C1B704B1D1B102519BA6EBB593308@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6a68qvbgUUYQLFR6tiG64/LroklBV8BEl0fz1t97ZixfyWbM47E
	 1x8/h+etXfaPboVaW9i4O3l/bAyVbfpkcZjk36tC9c02XUqZhgnQuV99cz3OiZBMZYBOKGOgHRZA
	 YOqTGs7wOGleB4R0bZ9pvwXaNJ2UF2LCYVqAwye7Iv4snSTfUuyNQgR1kTij9uOw/Zx2BPYHJPE1
	 yKYn7EjA/2wqrofzdpO9xJQEGAMPndo8P7/cFcYwb0jumTS3oUGbfGtgrceSqysNbamK5QTZ5vD+
	 A2ifmtcFlfv0OXPNglhCZZT5nZ3ycYr+xY6OVWaRrwXuwGtAE7A2wiGMZ1edzXMxn2eQaZzont/u
	 cAbMa//K/uVRtYaUGuV6tSvrRiklVk53jsVnXo9olXgTjucKSgETIPp6H6rX5mS0zf28Y1bRCG1O
	 uM9ykcl+UXl0IHtCKoODZTp1RidIIaJbGfSVud2FIcnPbqggYVFSBYOt0EhHQkHuv7HqbylVTDSF
	 xz1dTYR76P1OV3N1FaGQuIoQqkeAwbw1uSnLqDoA/70xU9iwi56MaLXmmH9PNmh+5zYd8jtBWSQ4
	 PHqohNS7gHpQMPhLiqvRvzqNypcsch7LmUzI5vuTteV40G8ayL/fHn+nfokViyvhqNcFxIGKn8sF
	 8NM/hB+tSzsQmIlNgcngA/W836aHNlWnmvldnH0hN+yS8uz1QMg6I/8Zd+Jpl309FP1Oa870pvEM
	 18WLBWXj30BCdFtTzJBlRgiTBUcKuttMqAHiJWLiTUlDKIq4Lr49QsYDmnYNZjHPgz95bQomGcoX
	 oeCJ6zPQBfG8V++VE1Tw9LAqiear51mToYGWT7MzUk2Pha8IG/h3r60h8kesUSB45Wl4OA+C97mR
	 C+M5sPQmciM4XZcAp6ttppUOqVTP/weATtvzivIcO77G4jcQ/K5402lqgCn3PiwSd4l29a43KGpO
	 Tp1zs7jeWL/gLQPDfHtsMeR5TBAvQMi2k6pyGnK+teRhitKb4IuQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfsplus_ext_cache_extent
Date: Thu, 28 Dec 2023 21:59:19 +0800
X-OQ-MSGID: <20231228135919.56669-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002cf943060d8f4e3c@google.com>
References: <0000000000002cf943060d8f4e3c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in __hfsplus_ext_cache_extent

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..9d4ffff6d42e 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -23,6 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 		return -ENOMEM;
 	fd->search_key = ptr;
 	fd->key = ptr + tree->max_key_len + 2;
+	fd->key->ext.fork_type = 0;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
 	switch (tree->cnid) {
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 3c572e44f2ad..6681e3a24f29 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -206,7 +206,7 @@ static inline int __hfsplus_ext_cache_extent(struct hfs_find_data *fd,
 static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 {
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	struct hfs_find_data fd;
+	struct hfs_find_data fd = {};
 	int res;
 
 	if (block >= hip->cached_start &&


