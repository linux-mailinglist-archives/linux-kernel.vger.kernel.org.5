Return-Path: <linux-kernel+bounces-104130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82C87C980
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2CE1F22BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06D14A85;
	Fri, 15 Mar 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ACNKUY6E"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B72514280
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489486; cv=none; b=iLJIjOZnvc2j6o9VJiBrlxzJzpKVyt+eBUPBR/mO3FLttLh0DCM75BlQizxpiWkSTLKbn9k9wbl+Pp4Z3QIonZIf/UxkQwCwcEHrYzU5YWFe0AjWOnujz6/lmnAX8EMFRubxQ7loHJFZ6+vxH6UotUnFO9R5OdGJzEujUUFrMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489486; c=relaxed/simple;
	bh=81XSfEgLxlFeq8/X8aED3TZ7ruO0mOShtVUqNrx19kM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E0rT/kKoIGQKWEXjc1ul9l4n7QGlppR9UbNjIOOWHicbsSgi6T8uWz953RKYXHgPuDdABH9fCxroOv4T0SDY2QdYAD074zPwSxwdPE7eBgb7MZMzEzCLBaBRK5FUMMcOkJ1cGGisDUal8PjKzL0iup7XBg9vfAnxQM++r0ep+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ACNKUY6E; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710489482; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GfzLZvVTB66l3CV8s0w+Yyt+PN5Qeom7/J1D8rdHZiU=;
	b=ACNKUY6EX4eTP3nKhM+Z6ueIg9GORr7khnzgprSlI29lSbjEU+9JIB19/8fjN0q9vdg8tHHoxSneKvLyy31s46Ye/2IlyHcRsWfvqDxiZqaepKizwiLIPTiYM0m+yIcaBipjWEmEamoPFgVVqvBABfexeDPKbw1yoZxi/1gtHGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W2VavpW_1710489169;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W2VavpW_1710489169)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 15:52:50 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Add kernel-doc comments to fat_parse_long()
Date: Fri, 15 Mar 2024 15:52:49 +0800
Message-Id: <20240315075249.111059-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function fat_parse_long.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/fat/dir.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 00235b8a1823..8236807eb7f7 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -269,6 +269,16 @@ enum { PARSE_INVALID = 1, PARSE_NOT_LONGNAME, PARSE_EOF, };
 /**
  * fat_parse_long - Parse extended directory entry.
  *
+ * @dir: Pointer to the inode that represents the directory.
+ * @pos: On input, contains the starting position to read from.
+ *       On output, updated with the new position.
+ * @bh: Pointer to the buffer head that may be used for reading directory entries.
+ *      May be updated.
+ * @de: On input, points to the current directory entry.
+ *      On output, points to the next directory entry.
+ * @unicode: Pointer to a buffer where the parsed Unicode long filename will be stored.
+ * @nr_slots: Pointer to a variable that will store the number of longname slots found.
+ *
  * This function returns zero on success, negative value on error, or one of
  * the following:
  *
-- 
2.20.1.7.g153144c


