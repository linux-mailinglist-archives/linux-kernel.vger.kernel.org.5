Return-Path: <linux-kernel+bounces-111071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142C88678E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91795B212B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA712E58;
	Fri, 22 Mar 2024 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hDI4vY3w"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E48F51
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093050; cv=none; b=Rb4ltkSXViMW9vJdrcOovROB3xXz/2EmZFv/Qq0s6Mrdv9SYpTp+Ar2ZaJvkAP/oa3GE3zWblyvYaim4x3zeMa2Nyhfyh1LrwJDJwheAgEtJipuu6x3cIhla36Gp4j1H35zmww93jkbbdUlJMpx7gXGsrN7h48bgPcuqyiWlyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093050; c=relaxed/simple;
	bh=CRUuQDO3gosr+5zVZOZygAhbr0SjBX3YXVzK+A5bteg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyREHKjEO/+RTqr0Fc+85Y3SpdlL/k14nmtAaovWA4m9LkukvR5zsHwIUEi6PZRT7nlrsaZWSxVj1hYpwKKXrDd348G+YlwD9v/ZgKyuKaXmbCG1I4xnSFmnAIOhWNBilNdJbgPudn5HlScH155l7cOxyfika0Oo8YGzfaY7m9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hDI4vY3w; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711093046; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+MJuteRwkg0VsnJEaRGWcNPsIdgpqOG+jFcL7QBZ5kU=;
	b=hDI4vY3wgZtCz4w7djqjKUqi4xcN+L+C1CNjozlMaZmWoqjTd9otShF6wf/3pEzLOxKAJ8+txYzwFBG/tIyGpjyaDUeCK8Wzf6k0ounAqpvAph2NpXTePa1S0ix+r0hfnhOEcqR8cC9D0tXJDGVl8oM2IQFImwjbsGjkGUw+5mk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W31EOg2_1711093045;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W31EOg2_1711093045)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 15:37:25 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] fs: Add kernel-doc comments to fat_parse_long()
Date: Fri, 22 Mar 2024 15:37:24 +0800
Message-Id: <20240322073724.102332-1-yang.lee@linux.alibaba.com>
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
+ * @bh: Pointer to the buffer head that may be used for reading directory
+ *	 entries. May be updated.
+ * @de: On input, points to the current directory entry.
+ *      On output, points to the next directory entry.
+ * @unicode: Pointer to a buffer where the parsed Unicode long filename will be
+ *	      stored.
+ * @nr_slots: Pointer to a variable that will store the number of longname
+ *	       slots found.
+ *
  * This function returns zero on success, negative value on error, or one of
  * the following:
  *
-- 
2.20.1.7.g153144c


