Return-Path: <linux-kernel+bounces-113668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B68888E38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7669C1C2AF28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03571DE103;
	Sun, 24 Mar 2024 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcXTrY3k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE628143874;
	Sun, 24 Mar 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320623; cv=none; b=WBwQk5HaDHfM4q1AnZYYinFQy1XPZs08CQHgngtaopz90jM+Ksp96AL6CxMR1CoWkEsbJOn4N7WfJrOEg/fwJzVdI8QyN6LSWw/BIJkBLEETm3t/LTPGAGxcbs/x4/5ZTdulOTDzoHl66RroXgzYI/C9sL/Vws0qMn8y/8sIEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320623; c=relaxed/simple;
	bh=v7G71XpAS4tiF9hc66eXK5SwNfvpgF8Od1uEjij+cHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY1P4GS56byhIu0OV5mArLnMIHGai2QJJa5B4+dQBFpoB+g9DpwpjzaW2nEfCge6RlhP16JmEl7M/e5ZGXYxyx9Q8npI6BoSV7isgG17wpX6crLT6XAl0gWGHTxQYp9jyZoWN3B+6BeDJ1iMP3cZBQAKtuF87fzO1o4899RjVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcXTrY3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1058EC433F1;
	Sun, 24 Mar 2024 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320621;
	bh=v7G71XpAS4tiF9hc66eXK5SwNfvpgF8Od1uEjij+cHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcXTrY3kfVFlpbB7mQ1y+tXPIlX3N0ZpqL4cmp+jDwdxO9/WMc9Jp/fG/gVcYPWi5
	 oKZOI/EW6v67Z2sBorCyYPO3qwngPNpS83S3Gn4fyNArQ37uiL6ydZKAW5GEkea1xJ
	 F1oUGwRMA5rRF+d+0Wum0YRYn4GfshcWFBHXlJRlC0DVtDErnCKQxodnUpmZKQXoFR
	 enNXLKVivCX6aeLRkxKyhFCmtgKssUxqV72+qBwv/Wi5e17qSDFFRiGRuSDbVm6gPZ
	 sQ64se6xMrAOh36iR2DMfDyS5PRd7pzYCsEidABPvwGA7NU5/WXegcRf1U5QKb7Mr4
	 38uK9YvQ8YLJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 183/713] libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
Date: Sun, 24 Mar 2024 18:38:29 -0400
Message-ID: <20240324224720.1345309-184-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

[ Upstream commit 93ee1eb85e28d1e35bb059c1f5965d65d5fc83c2 ]

LIBBPF_API annotation seems missing on libbpf_set_memlock_rlim API, so
add it to make this API callable from libbpf's shared library version.

Fixes: e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF")
Fixes: ab9a5a05dc48 ("libbpf: fix up few libbpf.map problems")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20240201172027.604869-3-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index d0f53772bdc02..dad7917903d19 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -35,7 +35,7 @@
 extern "C" {
 #endif
 
-int libbpf_set_memlock_rlim(size_t memlock_bytes);
+LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
 struct bpf_map_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
-- 
2.43.0


