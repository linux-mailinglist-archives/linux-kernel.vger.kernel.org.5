Return-Path: <linux-kernel+bounces-113007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21628880B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DC21F261C4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93F130E5F;
	Sun, 24 Mar 2024 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX6z5iYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881B130E46;
	Sun, 24 Mar 2024 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319818; cv=none; b=P3GncP4mLjBYplsRekBoFhUWcJgmHriUt2T4t9Q+jhsx+vBPyxw3wLrv9FOU757SZ4puC7ta9oaXWTTDP5yrNJds5cjZqyay4Hv4KgfrpwEsVxdXyTAMUmySFgr9tJZQUBx1Aj6uPaff7p63gkoXMnzK6V0dWqy6YWQCwEleaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319818; c=relaxed/simple;
	bh=nf1lrAZt+kqjRBVh05F0G23Lf7AHK4xB6OibgOB8eR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qk1FqLgY4EQFexrPK+vodX1a5+054EyCLqHST3BSdGwu60oJf65Q0tDM2A01VqZFxL5Lq8yxeG+IUkr3HC1SQERg3lnGOisHVPkIHVJCsr7fjbuvUDGP/QC9RfQm9d1WM5iW5qYQ5pJiT8eT2QTfPg+ssGLxdb39Z5lxTSxv4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX6z5iYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5318DC433C7;
	Sun, 24 Mar 2024 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319818;
	bh=nf1lrAZt+kqjRBVh05F0G23Lf7AHK4xB6OibgOB8eR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QX6z5iYZ/PcMrI4br4nUGHFRV2BssGaLYEDxe+LR/rqwcboO5Yn/L02ZFvKrO6DZh
	 swoQPCg8ve7A/vqyoKqQ7VJOt0ehpr4vgzdBKwzG2kOqk2QzDqAnzghRoObGi9Fp5Q
	 Adicj9Wj+z2WQspAQEbRPOwjgc/PFx+NF5TY96Ah8wWxOXTuYuVDO9Lz4cRhkI097J
	 eNHISBkcv6iVKiPQv9kyMbtak/tDOJzQirr1I/1eni8X4P0W+SwQYbW6DsD7qks641
	 d01eGLVlmk6gh9iDeqqHIfRFBhI1hOaeI7ctPHvFmTDuhiEFFavCbjgOdPkTn24NPY
	 f2zfqwtliB/jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 120/715] libbpf: Add btf__new_split() API that was declared but not implemented
Date: Sun, 24 Mar 2024 18:24:59 -0400
Message-ID: <20240324223455.1342824-121-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit c81a8ab196b5083d5109a51585fcc24fa2055a77 ]

Seems like original commit adding split BTF support intended to add
btf__new_split() API, and even declared it in libbpf.map, but never
added (trivial) implementation. Fix this.

Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20240201172027.604869-4-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf.c      | 5 +++++
 tools/lib/bpf/libbpf.map | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ee95fd379d4d8..b61bc5d1009b7 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1079,6 +1079,11 @@ struct btf *btf__new(const void *data, __u32 size)
 	return libbpf_ptr(btf_new(data, size, NULL));
 }
 
+struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
+{
+	return libbpf_ptr(btf_new(data, size, base_btf));
+}
+
 static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 				 struct btf_ext **btf_ext)
 {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d9e1f57534fa7..386964f572a8f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -245,7 +245,6 @@ LIBBPF_0.3.0 {
 		btf__parse_raw_split;
 		btf__parse_split;
 		btf__new_empty_split;
-		btf__new_split;
 		ring_buffer__epoll_fd;
 } LIBBPF_0.2.0;
 
@@ -411,5 +410,7 @@ LIBBPF_1.3.0 {
 } LIBBPF_1.2.0;
 
 LIBBPF_1.4.0 {
+	global:
 		bpf_token_create;
+		btf__new_split;
 } LIBBPF_1.3.0;
-- 
2.43.0


