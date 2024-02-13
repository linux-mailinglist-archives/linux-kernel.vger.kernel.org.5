Return-Path: <linux-kernel+bounces-62586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0D852350
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793B41C221A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836B225D5;
	Tue, 13 Feb 2024 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUdB6qs4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBA225A2;
	Tue, 13 Feb 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783539; cv=none; b=PANx3ZcZ4WhBR+dTxfO3VqXXyAornYsv/yrUhWyXAKHKQBTN8fAc3j2jXAwrEKGanIEoSuqcx54Y9eN5yCco6igAMpExIjkzHnYAGlYiNf4gG4ygR/5lTnb/IV8ruf3p4p25h7gjx6gdQmphXK+fEQkWwhtDBcenYcSm5fqmLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783539; c=relaxed/simple;
	bh=GS66KHa41765rPFp+oZZAY5NOOw0OtyS2g8BAzVaBi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOoSqPn0HfCyX3z/nB1NqZwUASzgCdoELi2SrlNVbFu92MwRi5BXVU43QH/409Z3PGxMEoCEkmpj4jxdQ1/oDn5Mp6RuW52tMhGOJ6FmJZRcnjarVFVS8ixZ3Gk7mey+3aXQ5MuvnA4CJGGXZ6vWWbcLlfytrZxFsBOci4NwOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUdB6qs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A882C433F1;
	Tue, 13 Feb 2024 00:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783538;
	bh=GS66KHa41765rPFp+oZZAY5NOOw0OtyS2g8BAzVaBi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUdB6qs40+GJhw7onLH350EG4vDy15jeR1jf3X1P8ioY5qOPcb233qiIgk26AwunC
	 X//fv4dMivTKGUeEVAZpGIAXoV2yIp0lm2lJzPRkSBLc6tp2tqWDtnlHixt2WSFq72
	 oU9pMLFXk1PT0w2xab4qTbOAbMexeC9oYU6x400doAC6aES7x6jVqE5mIrUBfU+80W
	 +dCluEfPdenw7wU129p4ZSFrd6F8UNeOk/tB0WXoEDxM8N+XgTgdQ7mP5Er0uihzmk
	 BQ2KX0COguybgr2c10uduSG968RwhOOT1K/YZ/0HDogKXud9UnyTAudspNXQeAS+Yj
	 PImb/hjW2j9IA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 17/58] fs/ntfs3: Disable ATTR_LIST_ENTRY size check
Date: Mon, 12 Feb 2024 19:17:23 -0500
Message-ID: <20240213001837.668862-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 4cdfb6e7bc9c80142d33bf1d4653a73fa678ba56 ]

The use of sizeof(struct ATTR_LIST_ENTRY) has been replaced with le_size(0)
due to alignment peculiarities on different platforms.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312071005.g6YrbaIe-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrlist.c | 8 ++++----
 fs/ntfs3/ntfs.h     | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 7c01735d1219..48e7da47c6b7 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -127,12 +127,13 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 {
 	size_t off;
 	u16 sz;
+	const unsigned le_min_size = le_size(0);
 
 	if (!le) {
 		le = ni->attr_list.le;
 	} else {
 		sz = le16_to_cpu(le->size);
-		if (sz < sizeof(struct ATTR_LIST_ENTRY)) {
+		if (sz < le_min_size) {
 			/* Impossible 'cause we should not return such le. */
 			return NULL;
 		}
@@ -141,7 +142,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 
 	/* Check boundary. */
 	off = PtrOffset(ni->attr_list.le, le);
-	if (off + sizeof(struct ATTR_LIST_ENTRY) > ni->attr_list.size) {
+	if (off + le_min_size > ni->attr_list.size) {
 		/* The regular end of list. */
 		return NULL;
 	}
@@ -149,8 +150,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 	sz = le16_to_cpu(le->size);
 
 	/* Check le for errors. */
-	if (sz < sizeof(struct ATTR_LIST_ENTRY) ||
-	    off + sz > ni->attr_list.size ||
+	if (sz < le_min_size || off + sz > ni->attr_list.size ||
 	    sz < le->name_off + le->name_len * sizeof(short)) {
 		return NULL;
 	}
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index c8981429c721..9c7478150a03 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -527,8 +527,6 @@ struct ATTR_LIST_ENTRY {
 
 }; // sizeof(0x20)
 
-static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
-
 static inline u32 le_size(u8 name_len)
 {
 	return ALIGN(offsetof(struct ATTR_LIST_ENTRY, name) +
-- 
2.43.0


