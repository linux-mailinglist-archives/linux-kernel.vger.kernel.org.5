Return-Path: <linux-kernel+bounces-39390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1274B83CFC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DECC29490B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850FB137C34;
	Thu, 25 Jan 2024 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbxKtekR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF401D6A6;
	Thu, 25 Jan 2024 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223368; cv=none; b=Uf87S1kVP+41oenNa3NgdgDMHJox7k/ZIkIwBhFRY6ezX/otZZLBYUKEddltuaNjFBenKtD9xaO90RqnFBGFHYs3cP6c8i325mSUA2id6qFSvL/wXOcsW91HlzaqHiJcDbiBomdK8yb6eKTqZLDo2PRVybMNx7xugeRu/OZ05EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223368; c=relaxed/simple;
	bh=qYBM2OLy1xkCHHfBZSY7751G6ZbDsz7ZqfUVr2+0/GI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SD5QF8R+k7jEz4nbDMOlt9xbo3FBSD4nTppyYKbl24t2wGLqQVYLCelWokFmOpFjLk2qxRf05HSLSVkSeiKGKa1AjWzO/BVW7UfG9lPXE6XuVtrKST+hwq/F24K48/tSJHLgL9Uw3y4oLjiYCK5Z+bn3bkSqoH60/J6Sl+aA0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbxKtekR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32B7C43390;
	Thu, 25 Jan 2024 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223368;
	bh=qYBM2OLy1xkCHHfBZSY7751G6ZbDsz7ZqfUVr2+0/GI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JbxKtekRjqjnn6njAqdJyNiSR2ZBSmdHB8jGlYcaXDRdTs96WIqwGOZDfoNtosHd1
	 0LYaRSm1Um1tQId1UxZUmRnfsw4nCcl/vymsY7+a3QKUWntDDdjudsW+d+8cgReMVq
	 jWka0eQ3oD/F1x0M1MZi9u2Bs2x7nwtX68kKoUJ7gu02tbbpkLnXY6W1lnCK354evl
	 +hGEu2Ht1Z0Y9W7y+4kwsPGPNGabpaU0u0RkygFwLukz9AVvtTk0J3yl44pAfZ0Aqy
	 pJ+/TVYmIUD/jHjZcCTr77FsHFCyK/es0i0hPWLkfwhl7vnB+KvKU1kw/QB0nTmEaW
	 mP3f4IPdD5Y1A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:16 -0700
Subject: [PATCH 10/11] lib/Kconfig.debug: Update Clang version check in
 CONFIG_KCOV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-10-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=nathan@kernel.org;
 h=from:subject:message-id; bh=qYBM2OLy1xkCHHfBZSY7751G6ZbDsz7ZqfUVr2+0/GI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv3LK3/7OWJxudzWVUWi/juen7vUzXxCq9vQ2PLp+
 zkPLy1Y2VHKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAm8iSIkeHh5MY7797sThfY
 r3bzmt+Rsz3xp3ymXKie4TRBWu7BRIapjAyL/sq8ObugZbnJ8r9Tz9x9KpvD/fenyrZ/1fLK7y2
 7myW5AQ==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, this condition can be changed to just
CONFIG_CC_IS_CLANG, as the build will fail during the configuration
stage for older LLVM versions.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8f502f15dc7f..1339fb893d71 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2085,7 +2085,7 @@ config KCOV
 	depends on ARCH_HAS_KCOV
 	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
 	depends on !ARCH_WANTS_NO_INSTR || HAVE_NOINSTR_HACK || \
-		   GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
+		   GCC_VERSION >= 120000 || CC_IS_CLANG
 	select DEBUG_FS
 	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
 	select OBJTOOL if HAVE_NOINSTR_HACK

-- 
2.43.0


