Return-Path: <linux-kernel+bounces-144492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB37B8A470A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C8E282A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30A179AE;
	Mon, 15 Apr 2024 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W9sSTuDB"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76AEEBB;
	Mon, 15 Apr 2024 02:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148570; cv=none; b=sKtzkC2tt6lc+qOcdSm0/5TrlmGiDANk5gcGRPQL6x9sylaCcOuIEgmS1O5oIRPQ9HSWnRUQTjx3fKIOQBYuqWAyvoUGgqzY+3dYb4ycZLCaJVG9f1BcAODXZpYRkZF+/mGOrTU3Ptr5DvI/gwMS5TC86FH2UsRjjVYftfRiVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148570; c=relaxed/simple;
	bh=dbzr0d3uw93R8sYczA87dg45wWEMVdoUDx3xH9kEPPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CBj8sFg2swkPl1PmL1pfV7D11hYSfVJTY7mV/n5J/H++ExYCb2eYERhq4gsVSeOsPu2gpeQZD27ypTL6vsiQyXNy/77rtouHrgNK8FOi/3mWPogDmRgZABGMxKDxKLyE4kNskSn6OoyNbj4RqzeJYkgRJcaYfT3hIJbb3bwzv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W9sSTuDB; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713148566; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jXj9IyjFEQKk7sQGSRZQTX/9hn7/xp4LmkOm86YK5Fo=;
	b=W9sSTuDBw9xpbmOEPkYWmX2y8aYjizNUUCKpWZmzgTWqVxexyrP50XKNVTiEW7Lz8ib/PKTks1rzA1BwqC7vj0AVImNM0f9+JTwepPH8ySOVgQjqWu13psTX64we2jvZtwNkC8iy0IoOKpQhoq57qvqtJKjy2H3qwGUe/i+9S78=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W4TyvUo_1713148559;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4TyvUo_1713148559)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 10:36:05 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] bcachefs: remove unneeded semicolon
Date: Mon, 15 Apr 2024 10:35:57 +0800
Message-Id: <20240415023557.5851-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

/fs/bcachefs/super.c:1128:59-60: Unneeded semicolon.
/fs/bcachefs/super.c:1133:59-60: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8755
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/bcachefs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 8daf80a38d60..234f19ea8f30 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1125,12 +1125,12 @@ static int bch2_dev_in_fs(struct bch_sb_handle *fs,
 
 		prt_bdevname(&buf, fs->bdev);
 		prt_char(&buf, ' ');
-		bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));;
+		bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));
 		prt_newline(&buf);
 
 		prt_bdevname(&buf, sb->bdev);
 		prt_char(&buf, ' ');
-		bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));;
+		bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));
 		prt_newline(&buf);
 
 		if (!opts->no_splitbrain_check)
-- 
2.20.1.7.g153144c


