Return-Path: <linux-kernel+bounces-76495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D750D85F7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CDBB22C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871151031;
	Thu, 22 Feb 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT18rqCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6345FBA2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604338; cv=none; b=CxHBmeRcM4Sf/PkDCtm0w6uTYlsnnrlj0wUdGE40uRxYzZNc6RKInU0k8aufNIL3jdixJtXXfyI2t3Jp5dnbjuF0Dl9SfdmN66SLozg55vUZ/QtJCB/eITGsoTzI6EThlYMAhbHtwjDJ1GtiuhU6AotOVz64D1lp7UHyKRxGN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604338; c=relaxed/simple;
	bh=hBevzcQ0912uhBWtG4E7Up+PFldcF2IwczOHh20Evtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qP/FIZv3VojAM3heMePkaCyWPc6bNFGmQWBVTJFYRH8T+sB7FrVlVsCByynuX65gQOXaARVZcooVSvqyENjugPXdMKvOAtG4Ne6bhMV7hU2FKGYDlk/djjsGaM3g7FOcWXBm3ClByW9F7IdQkXfZI1InCj/HpHpwPgWKCvSH8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT18rqCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF62C433F1;
	Thu, 22 Feb 2024 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604337;
	bh=hBevzcQ0912uhBWtG4E7Up+PFldcF2IwczOHh20Evtc=;
	h=From:To:Cc:Subject:Date:From;
	b=bT18rqCLQzC7YSmZJAXDveVoZqPTAt+O/d3Ye19a9zklautaxeoKEXQO7eWGIEKVj
	 eN84vFJ8FaO43JUq90P4gF+oabMZlJujN2Q4njfa9qQbqJmalW5EAEjNzIZJOG1RLd
	 u3epzZPURBhSezX3nA2z7UGiaGNmRoS5sLXp8aMzf1JkDJ4RO/ZbYGm0FsZnQddXl6
	 9/GiVQv1eAgOKAFqfX2nI1s++S8PGQMXSPEPAPbL3l17HnLYU99Lu/ZQYbtV1GrEPJ
	 hgK9pUyPxvZJ8szMAoZPQAa6KdGSWXqOitm7anO/ztW5I9HeLvixbtlxTyJ4nJaU3N
	 FkyaaBqAsMJ0g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] f2fs: delete f2fs_get_new_segment() declaration
Date: Thu, 22 Feb 2024 20:18:48 +0800
Message-Id: <20240222121851.883141-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 093749e296e2 ("f2fs: support age threshold based garbage
collection") added this declaration, but w/ definition, delete
it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8a6fd4352a0e..fbbe9a0a4221 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3701,8 +3701,6 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_get_new_segment(struct f2fs_sb_info *sbi,
-			unsigned int *newseg, bool new_sec, int dir);
 void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
-- 
2.40.1


