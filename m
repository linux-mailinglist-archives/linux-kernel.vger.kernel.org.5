Return-Path: <linux-kernel+bounces-15368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D6822AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23F2285080
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F9018AE5;
	Wed,  3 Jan 2024 10:00:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DB18650;
	Wed,  3 Jan 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T4lY52bCqz1Q7TY;
	Wed,  3 Jan 2024 17:58:49 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C872140258;
	Wed,  3 Jan 2024 18:00:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Jan
 2024 18:00:15 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kent.overstreet@linux.dev>, <bfoster@redhat.com>
CC: <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>, <ruanjinjie@huawei.com>
Subject: [PATCH -next] bcachefs: extra semicolon
Date: Wed, 3 Jan 2024 17:59:42 +0800
Message-ID: <20240103095942.3982021-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Remove extra semicolon in fs/bcachefs/btree_update.c

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/bcachefs/btree_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_update.c b/fs/bcachefs/btree_update.c
index c3ff365acce9..a9c980a8eef2 100644
--- a/fs/bcachefs/btree_update.c
+++ b/fs/bcachefs/btree_update.c
@@ -138,7 +138,7 @@ int __bch2_insert_snapshot_whiteouts(struct btree_trans *trans,
 	       !(ret = bkey_err(old_k)) &&
 	       bkey_eq(old_pos, old_k.k->p)) {
 		struct bpos whiteout_pos =
-			SPOS(new_pos.inode, new_pos.offset, old_k.k->p.snapshot);;
+			SPOS(new_pos.inode, new_pos.offset, old_k.k->p.snapshot);
 
 		if (!bch2_snapshot_is_ancestor(c, old_k.k->p.snapshot, old_pos.snapshot) ||
 		    snapshot_list_has_ancestor(c, &s, old_k.k->p.snapshot))
-- 
2.34.1


