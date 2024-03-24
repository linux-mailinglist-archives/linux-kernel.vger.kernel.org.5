Return-Path: <linux-kernel+bounces-115794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C28897DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0661F3589D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC986261CD6;
	Mon, 25 Mar 2024 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyFS5gOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72F145FE5;
	Sun, 24 Mar 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322042; cv=none; b=MD9DMB/ncG0wSxUWfArM9wvAZ5O0VOO5eytMAkdfUZf9xl+vm+t1vBhszgrHzeoX9BHnznz2yZPpybQDWU6k5+SZYOnkXSVFL0POacBii+eOZG6Ld71/JaoPMFUGEZlJo5IU+rxzg4UDGZCMYvzxJg/BLPm0oueU/CxEUO0LQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322042; c=relaxed/simple;
	bh=OCy11gfgu5eVzkYHZYR+teWLiQJLMXzg8ub7/3DQAw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nq0MBeMrk1u9tEnMr+lr3GOIRE2VvRa2BRWid6SaU74gIV/FNzTTNSeX6UljKuPgtiukd19y9w5sxjFVBLiY9gI9kCn6UPS3j7Y55u/ExUbKP20Ui0I5ffXu9xYJc3noaf2Jz8Ze8kZb4JUo6gADaSgqg9WG8A9WLkKpR6sIghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyFS5gOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A7AC433F1;
	Sun, 24 Mar 2024 23:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322042;
	bh=OCy11gfgu5eVzkYHZYR+teWLiQJLMXzg8ub7/3DQAw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kyFS5gOUslImStGMXizI3x0j3fY15PbAFJYUJKuEQhzcHTDA+ksnYwPKNPVHRNv38
	 FQVALqLKJgfqifFrIUByqM9ecvr0bkPN5U5fA2m82DVfbI+eeaAYf1NS2g9OQB21LV
	 AJr1euWpXdj0K3qbttMrhXdYVxULXqXQtpqN47zEcGcX8NLNMHTAMA5pCVIv0700DH
	 NHTSvzg+3l57oGEOxxraKytdrA4Y/AC7nUVSI4evhBaj3a6iv4RXEEJmDoSDkvr/UF
	 bTFW/wvezwPUzjI1LrBJ8scpOZ0zF8b1VteFNVdCuRfy7l59Zqvnt6LCPxSTJMoa18
	 JPdeE7WILTNFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 114/451] libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
Date: Sun, 24 Mar 2024 19:06:30 -0400
Message-ID: <20240324231207.1351418-115-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index fddc05c667b5d..874fe362375de 100644
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


