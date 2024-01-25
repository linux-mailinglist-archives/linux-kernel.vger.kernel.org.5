Return-Path: <linux-kernel+bounces-39391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594683CFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7868B1C232FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B51386B0;
	Thu, 25 Jan 2024 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKpJlDgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5717BBB;
	Thu, 25 Jan 2024 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223369; cv=none; b=ls4xXHXtEn3eKHYb6LnE7UYx6ioTOqUguhhQMDSXsbaSDS8/C3NYkWYK51MMdA9b0DK5HeWa1iZ3wAo92+mZaN5qeWsy+h5F7tTV2GKPUxcLThAMv160hmq4C6WCSbwqLi2FQhJii10/EW+S43UFZQbjE+g10ANKOQEpCq6l0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223369; c=relaxed/simple;
	bh=UeJFFhP5K5DQQoi+dtNguzI64CEeLgb3Zsu8VdMJzbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WK7DKcUpJF+EaRjXjxX1NyJxClRTLVzMldic+67IU6C679hE1hTq0rk/7V7Nn16yLRMRW1xvqAKd3z06r06VvPHvxNMczYQxcvz0Z3QhzL/6sMBWNb1G2p1Xa44Xn/3wTZB8tBYJfnfuQuFvAold5lz7ILj+ucXSpEHt7z4URUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKpJlDgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674C0C43399;
	Thu, 25 Jan 2024 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223368;
	bh=UeJFFhP5K5DQQoi+dtNguzI64CEeLgb3Zsu8VdMJzbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IKpJlDgkl/iKbA65PPiAZAJWgcrumBdsCpKqhd1yawQ1gNcfQoofLNdMCRkzBQ/CX
	 2SOE06iU/CAKpkmvpYJWss1opIxrGLaUn52/wmHPAQ9gNImZ6L21nq20EKgueS8jMW
	 88fV9fWPJAO94Vf256jt2TBkn3w9+vQAZ59WwGMcHQ18HccEorP8m+9KxWe8Xqx54V
	 uJQ+fCcrdA6CeC6hBZ2hy+15ar4HFAa/yEVhpzxrqm9FkIlhkSwpL93p47wvbl93pM
	 DN9+P7rzwQ0eMFJdLcinrXhnVQWpzerXJJh+lGB6vMlKnyNublIgHP7Oztu8TGYBXY
	 7eexNUfCsRmvg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:17 -0700
Subject: [PATCH 11/11] compiler-clang.h: Update __diag_clang() macros for
 minimum version bump
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-11-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=nathan@kernel.org;
 h=from:subject:message-id; bh=UeJFFhP5K5DQQoi+dtNguzI64CEeLgb3Zsu8VdMJzbI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv274uD7sqTfcJrv1oY5EQ2Jn1iuaARsDb7702pzy
 AG/T3NMOkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEPoQy/BX/Efs1wid5zX5D
 iXdJwW67+OPV7t/0vxglYmRs2uB/1IeRYeeL5T8/fzUv/ztZxMmKXWiN8FPZn9tcpSZunbXC/Ld
 fBicA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

The minimum supported version of LLVM for building the kernel
has been bumped to 13.0.1. Update the __diag_clang() macros for this
bump.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/compiler-clang.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index f0a47afef125..49feac0162a5 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -114,11 +114,7 @@
 #define __diag_str(s)		__diag_str1(s)
 #define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
 
-#if CONFIG_CLANG_VERSION >= 110000
-#define __diag_clang_11(s)	__diag(s)
-#else
-#define __diag_clang_11(s)
-#endif
+#define __diag_clang_13(s)	__diag(s)
 
 #define __diag_ignore_all(option, comment) \
-	__diag_clang(11, ignore, option)
+	__diag_clang(13, ignore, option)

-- 
2.43.0


