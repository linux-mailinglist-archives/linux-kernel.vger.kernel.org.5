Return-Path: <linux-kernel+bounces-15025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BDC822651
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F721F2288A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509E10EE;
	Wed,  3 Jan 2024 01:07:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE15808;
	Wed,  3 Jan 2024 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VzrtB.y_1704244041;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VzrtB.y_1704244041)
          by smtp.aliyun-inc.com;
          Wed, 03 Jan 2024 09:07:22 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: kent.overstreet@linux.dev,
	bfoster@redhat.com
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] bcachefs: Remove unneeded semicolon
Date: Wed,  3 Jan 2024 09:07:20 +0800
Message-Id: <20240103010720.39784-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./fs/bcachefs/super.c:1093:59-60: Unneeded semicolon
./fs/bcachefs/super.c:1097:59-60: Unneeded semicolon

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/bcachefs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 64ff7da49860..bc254d69b596 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1090,11 +1090,11 @@ static int bch2_dev_in_fs(struct bch_sb_handle *fs,
 		prt_newline(&buf);
 
 		prt_printf(&buf, "%pg ", fs->bdev);
-		bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));;
+		bch2_prt_datetime(&buf, le64_to_cpu(fs->sb->write_time));
 		prt_newline(&buf);
 
 		prt_printf(&buf, "%pg ", sb->bdev);
-		bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));;
+		bch2_prt_datetime(&buf, le64_to_cpu(sb->sb->write_time));
 		prt_newline(&buf);
 
 		prt_printf(&buf, "Not using older sb");
-- 
2.20.1.7.g153144c


