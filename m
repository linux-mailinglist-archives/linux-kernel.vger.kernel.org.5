Return-Path: <linux-kernel+bounces-67062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F81856593
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2131F223AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8A13246D;
	Thu, 15 Feb 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSLLSvE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4D131E4A;
	Thu, 15 Feb 2024 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006318; cv=none; b=J4z5qmNnGH7h5cGbJCETOB5DAhUk7WKvTfP0oeiQDdVjW+1TrDnE+EOJQMlm5q/6FB4zg06u+6Zzzwj/WPW2MwPWyZ3ghMn6H1Ba63hW7o/QYVVyRs8d8CXrlrWO9OqfO6TBUZJk5GjHoFCGe7spxN74mm6jb0DR3G17wri+3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006318; c=relaxed/simple;
	bh=HkxdXeZdYQMmfTagJZLrQcvFjkDeeE9HLvngWwo7L1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIun50rJOyln0Jnr4EkkPP5Af+Sx2RNBm99trpXQ5YU4ye6wEd6M46dtx5mE6BlhD015szihf7YcaaKdKiDTPtEhIZ/6W/PP4AdaSdEo4bPRSdxL+Vcb1dtUJD3Z4bVTiMq6dN5rBsycL2IGHDxKZFjm8G9wrDljGftHKquX8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSLLSvE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E650C43390;
	Thu, 15 Feb 2024 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006317;
	bh=HkxdXeZdYQMmfTagJZLrQcvFjkDeeE9HLvngWwo7L1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSLLSvE5LtJPzOQfN3ak2K2GoCYKASkK5hNELtW6Bd8m+hTWFEif36XLkBFvJ6HV1
	 Eqea4LFg9iD3Hxhiz+SuaHeIXcbpdImAzq+A/JEfzylA3LuEmV62Thj3PvBM88yjKW
	 oj1Ih95HkCHuS0oUdSkY+6t0lOBY58N0HONa9tnRLRbz4TatZXyQYAzOpjAZ2ALf9b
	 alyHiykfpqvNrq5Qt67Qw3/+OWeZIackOk0J3F5MllY6RbA8I0cO2NksSKcZ0tUnO0
	 lzgm8/fRJe8Ni7PzqtWynLrPJRchCBfKhs/2wO05KyNF+4n9gmXOt+DnvBFUT2yf27
	 9G47V0rByCIww==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] alpha: merge two entries for CONFIG_ALPHA_GAMMA
Date: Thu, 15 Feb 2024 23:11:20 +0900
Message-Id: <20240215141120.1911369-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240215141120.1911369-1-masahiroy@kernel.org>
References: <20240215141120.1911369-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two entries for CONFIG_ALPHA_GAMMA, with the second one
7 lines below. Merge them together.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/alpha/Kconfig | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 70e8343d00ba..581ca8c73d67 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -390,16 +390,12 @@ config ALPHA_PRIMO
 	  Say Y if you have an AS 1000 5/xxx or an AS 1000A 5/xxx.
 
 config ALPHA_GAMMA
-	bool "EV5 CPU(s) (model 5/xxx)?"
-	depends on ALPHA_SABLE
+	bool "EV5 CPU(s) (model 5/xxx)?" if ALPHA_SABLE
+	depends on ALPHA_SABLE || ALPHA_GAMMA
+	default ALPHA_LYNX
 	help
 	  Say Y if you have an AS 2000 5/xxx or an AS 2100 5/xxx.
 
-config ALPHA_GAMMA
-	bool
-	depends on ALPHA_LYNX
-	default y
-
 config ALPHA_T2
 	bool
 	depends on ALPHA_SABLE || ALPHA_LYNX
-- 
2.40.1


