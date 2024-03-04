Return-Path: <linux-kernel+bounces-89976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62286F884
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DD2B20517
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17081854;
	Mon,  4 Mar 2024 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="edPBqe2m"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18937138A;
	Mon,  4 Mar 2024 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709519073; cv=none; b=O0tY3Tca7yMBGoAmY+PEtNKYGQ0vcsaysJIP26B5hqZ3xp8p7WhGHrtxuq50je4wF3YtiwEVu/6E0WcfF/3cxy9otqlSqF/chck3ZVFy2DxGVSqp6Hh9k9N8Nztn9n6jEii3Yk35QJk1Nl/Ry4QJr3tjyBxLpiBikQnhUAFQ7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709519073; c=relaxed/simple;
	bh=6dx0WkWKPKfJ3nfjQDNWvDbFkyoOPz7MtMv0UUN8qKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=omXcjrNKcms6eaN/xk2nrdKvxrPgqEsphiSvC1qeQNyJNRbQOAjY8nU0T3VXzF8tCI2Jk3PKl4yNGzpahxcGx+FUdXF6Xpz6jx/xDMc9VGrzGN1AT/I1feBmQldDpTgVz6kwada/rxLIhZjiup+v1FqdG/EvdWODJPcm4xfS2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=edPBqe2m; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709519062; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rr5iEELkVH1nkAfnANQ3oH2px8Us2h4/A/3A6YnanP4=;
	b=edPBqe2mpHfzgT5yaUQmpCSI5wccxPmKO5Vh2mOJaG21KnikpC3oRwL5chKT4i1A3u/aCvUpSMiEFl+wUKnzF7ecSopwp/Q8nktJfEVBVWEa186i9t1YRolsa7m0Y1XhkLlQcsfV55f6gLVw/Z2/RuVLDFSYazK4E4hKUFo1GtU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1i0JZ6_1709519050;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1i0JZ6_1709519050)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 10:24:21 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chandan.babu@oracle.com
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] xfs: Remove unused function is_rt_data_fork
Date: Mon,  4 Mar 2024 10:24:08 +0800
Message-Id: <20240304022408.111558-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the rmap_repair.c file, but not called
elsewhere, so delete the unused function.

fs/xfs/scrub/rmap_repair.c:436:1: warning: unused function 'is_rt_data_fork'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8425
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/xfs/scrub/rmap_repair.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/xfs/scrub/rmap_repair.c b/fs/xfs/scrub/rmap_repair.c
index e8e07b683eab..7e73ddfb3d44 100644
--- a/fs/xfs/scrub/rmap_repair.c
+++ b/fs/xfs/scrub/rmap_repair.c
@@ -432,14 +432,6 @@ xrep_rmap_scan_iroot_btree(
 	return error;
 }
 
-static inline bool
-is_rt_data_fork(
-	struct xfs_inode	*ip,
-	int			whichfork)
-{
-	return XFS_IS_REALTIME_INODE(ip) && whichfork == XFS_DATA_FORK;
-}
-
 /*
  * Iterate the block mapping btree to collect rmap records for anything in this
  * fork that matches the AG.  Sets @mappings_done to true if we've scanned the
-- 
2.20.1.7.g153144c


