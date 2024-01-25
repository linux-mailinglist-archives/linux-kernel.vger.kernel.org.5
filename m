Return-Path: <linux-kernel+bounces-39387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA12D83CFC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D923F1C23014
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3E1B808;
	Thu, 25 Jan 2024 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+5uAyWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5311B5A0;
	Thu, 25 Jan 2024 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223367; cv=none; b=bdD7qh4YqZ0rXs4rRddYswxhMEmQIZbVZHCHJmH0a6U/LC1oBcocMkMG6hki4Zus9nEaMaaHjCXRYbx5NtCY1RQneADPW78AIy0XlYnEsZm5NmBQ3Q8Sk6NjFkPsftLhA2wFTpgKm68kbSId+gJXQ3AuJtIZhIfWVdHEB1AfpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223367; c=relaxed/simple;
	bh=gyCTtEy5PbjNvE5leNKdfOXPtZtPUb3cK4c+4fo9cSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNxLrPxouQNPfEr+8GkxJCkMEsyCC4fNUFDipmXRANR2xb1ppDmZvRdVc1iWZa2/KaWEAkNd0A4qOt879kSsIIAi6amSSR1iGxnfIt2+WR09OgtNgsTUx4bpS3RmBs7y8OderVd5HzA2UmG0VA5GKU0xNu15y8fPf7JgHJBHW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+5uAyWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD65C116AB;
	Thu, 25 Jan 2024 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223366;
	bh=gyCTtEy5PbjNvE5leNKdfOXPtZtPUb3cK4c+4fo9cSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b+5uAyWQjhVltyJThWXdiRTZFOBrbBcADIyK1nXaGYW6yKEUyCLs+nV1COVJqLtwH
	 iz2glq9GdAfqgs93croz40dlgnxZu6xoBNsn34+MVamoQr+Uacvxqw1ck+Vj0XMVUC
	 gVqeFfL1kyD9HSQHm9LcHhnzxzdR4QLWtAdN6D5XKp7zvzA5pxYKYK16kDzCc6+goq
	 YsaKCBjU1GYrFvI6I/vDUUUvw02Dfh1OMbjFAWrvqB/eaaN0NM4PU3PFwZhhe3jWSS
	 4jriwKyjQiTRC369pjnW2Dit4ttKVL5kJ2pBM1+CFHWEXa1tTSvpN5MWuZxYAO2nfo
	 CtmixarE0E8KQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:14 -0700
Subject: [PATCH 08/11] riscv: Kconfig: Remove version dependency from
 CONFIG_CLANG_SUPPORTS_DYNAMIC_FTRACE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-8-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>, paul.walmsley@sifive.com, 
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org, 
 linux-riscv@lists.infradead.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gyCTtEy5PbjNvE5leNKdfOXPtZtPUb3cK4c+4fo9cSY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv071LT4ru7uzV6rVb5Z6r34Ps/2UlJJxG6j4rkfJ
 vb/+1Li21HKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAmoiHL8E/7SNnxB+EG5R7d
 E5heTxPWT5G4/t8kmePN+4aytLDrCasZGe7fbYuPipjZzKZlyuzUe6Lo22/h8Ls82+4WJ+xU/fO
 ghx0A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Now that the minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1, this condition is always true, as the build
will fail during the configuration stage for older LLVM versions. Remove
it.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com
Cc: aou@eecs.berkeley.edu
Cc: conor@kernel.org
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 69d24f513922..00edc4ff589c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -174,8 +174,6 @@ config RISCV
 
 config CLANG_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_CLANG
-	# https://github.com/llvm/llvm-project/commit/6ab8927931851bb42b2c93a00801dc499d7d9b1e
-	depends on CLANG_VERSION >= 130000
 	# https://github.com/ClangBuiltLinux/linux/issues/1817
 	depends on AS_IS_GNU || (AS_IS_LLVM && (LD_IS_LLD || LD_VERSION >= 23600))
 

-- 
2.43.0


