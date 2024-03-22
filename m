Return-Path: <linux-kernel+bounces-111067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02D886788
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9269B1F21450
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715401426C;
	Fri, 22 Mar 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h5YlsAXT"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94FB12B6F;
	Fri, 22 Mar 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092768; cv=none; b=Hr27yln6JbUYdnFx6oipz7UBkDmIgrwzDb9yBbg/VfG3zibMzPlN64PsRCyjsy0jXcjeH8ZbDwLBvmvwVloQIAuakpyxZAMDTgpDmgEhnemaOMG0AKp2iTOYc0UTOhre7UhYK1G0OQRoPG8lcxGgoCCKHZqT+7XcdQmDX9lgpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092768; c=relaxed/simple;
	bh=SpJNp4FZJ2wVNsBY04etLE4sSqpuxggaD1VjFRdci4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ri85BuzpM+uApLbK1wiydu+933DCWXOtGumHgnv1qF8efYkY7W69P10w8QI78VoHSk4QIJaURF7ptrEYmaL/lpmB9kN5qrrGgZoDBpmQzU+IbPLP3Buukquzt127/8C3oIlFgtOqc1f8AwufdVZbJqERtZG4RrGHKkwV01i1QnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h5YlsAXT; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711092762; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NsGwjmS7lKzet/4eE6wMv0q95qekO9BK+DKoBWyW8Qs=;
	b=h5YlsAXT0XGxZ1IZXGzDXtykXa1K/JWbhJIdv//AVXfOTKtzkrrTm8WzFaJQFym4mlkKcpzB3H2zab3FSfpTetRrGcXRFTjfXYr6wS6kTCmUbn56A3KCEJa4aNdxrH3Ko0L8Yjypn+ewb0VU3EbPJBcT8n13VJBAJr2Is2jR9IA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W31EMhT_1711092761;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W31EMhT_1711092761)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 15:32:42 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: konishi.ryusuke@gmail.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/3] fs: Add kernel-doc comments to nilfs_do_roll_forward()
Date: Fri, 22 Mar 2024 15:32:38 +0800
Message-Id: <20240322073240.91639-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function nilfs_do_roll_forward.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/nilfs2/recovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 49a70c68bf3c..e48372618ac4 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -563,6 +563,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
  * checkpoint
  * @nilfs: nilfs object
  * @sb: super block instance
+ * @root: NILFS root instance
  * @ri: pointer to a nilfs_recovery_info
  */
 static int nilfs_do_roll_forward(struct the_nilfs *nilfs,
-- 
2.20.1.7.g153144c


