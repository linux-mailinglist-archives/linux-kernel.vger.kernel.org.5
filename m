Return-Path: <linux-kernel+bounces-115625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB2889CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DBF1F365FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4834B8D4;
	Mon, 25 Mar 2024 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbcm8Rld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D064202BAC;
	Sun, 24 Mar 2024 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321440; cv=none; b=gS2FcMFvAF3UM8kSJ+TagfrcuS88KpuMQ/AcF+YNDN+FFsAkF2dUcrnDhZsiwRArjJNxBZq5Rjy23bNRvlKg7F1P7J1rGjqBxUy7jOJatSvcFN4Qki6QMfZgXfVUK0F7NQJTT9JzXubslxtUQD7f28O7jXbtR8ruowKK8/+nEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321440; c=relaxed/simple;
	bh=TdMoJ87npDr2eKnCA3OJPAeqwewuEkteg9Dm9FzlNz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kafSNTPz0WFX0fpp4J0LfZkEmnemKqCbY5+r1CwHi8b+xD9XkZGr5RbAX8RDDdFZubz26RwneGCOMzuhI2p8laFlbGrrS13oa8Ttah85V7dpGlkkCcZuKRx+cGGohsHY22uaWe1k/hIMPXkanRIwtfrYutmoqdEjBHFi8+gLWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbcm8Rld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4446BC43390;
	Sun, 24 Mar 2024 23:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321439;
	bh=TdMoJ87npDr2eKnCA3OJPAeqwewuEkteg9Dm9FzlNz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rbcm8Rld1BW5OgmHrPVPzCSK9NItMljylSGp70qwh+vvh3XMk042qgso5cqxleSlk
	 LGtFPQ62rUROkLRId6PqR3truAMKkAhQ8cbcj1sM98kIFoj0cWA+zzN/Rt4ha7RFcC
	 qC2vtv6QcwVZWlkAKJIJaGHcQ1QlQ2Qa0URoPvTtXdbfhOq+V2dDrfUZQrYNZvVVKd
	 HPlu1gVA2FmxG/cc5+bhOSEkDbSZNwJ+q04JsuuplWguooB8O3ZrHwI2y+68KoCVTV
	 KbbHcROQw+avZhfxgXtrZtY8vCfChtoyZRbzlOtI+6zRXPdA0qKfBswV8vGMeeKv9O
	 Kl7IFYfXaIWTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 163/638] libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
Date: Sun, 24 Mar 2024 18:53:20 -0400
Message-ID: <20240324230116.1348576-164-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 74c2887cfd24a..107fef7488682 100644
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


