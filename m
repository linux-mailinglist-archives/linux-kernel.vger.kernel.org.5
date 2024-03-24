Return-Path: <linux-kernel+bounces-115596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8B88943A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306841C2F0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5992519AE;
	Mon, 25 Mar 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqkEW0ct"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CD128836;
	Sun, 24 Mar 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321308; cv=none; b=mk+x/d/iiqcgz3zeF5WFMcxG3Q4ElXz2nGWFO+QkMK6No5YAx+3r9sBOATCMZ6CUrdaLnBNpx6bYVIguI4tKKdcDYSCSx4IsaKR8FUJfmPMl3lXRr+YDmacRHC81yC0yZAEwIxE11//C6Cwjqg0yjWE25ripOA7FQpVVRtGPTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321308; c=relaxed/simple;
	bh=DM56fWUpnYs8NKGcPFxbzDsx0rC5E5rIw5nd28XokT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsRZZCWN4JhMfGg/khjC2F7+NdKB3nYwrL2AQSfzihgaul3QevSbNoxQM3LjOGdz+BjE8AuWjtegXDkOgHgFnnTEAK+AtMd9/Asc9RWjB6lXb0ipx7EULihpBXCxq8R/jCiXAdk5+z6wGTawrmaP/EPWWEPh5kPetSkomraBfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqkEW0ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02CAC43394;
	Sun, 24 Mar 2024 23:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321307;
	bh=DM56fWUpnYs8NKGcPFxbzDsx0rC5E5rIw5nd28XokT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqkEW0ctt209EmAQXzqz/3yCq8NVWcP2dLmCRsFdve/iHKadF97FQ13fRfp2ntnws
	 oDks5yNLIfjQdlPeMMfhF0K2qIGT4qYI+Ly9IYHm12o0ZSDqvThpioBDiKPYv/m8ht
	 emgo+7vrihi0deoBK1NUcGAiXq8pWgc15F8EPaKohzDKBCejNTnWz7AD16OnhT83Qv
	 unb2Ss4myZVAL1cVbkQy7w/s6VMEeGo46o0Ac27EK3g4/hCXSloP4Yi6aLaA91BL11
	 5Vjc/jh7gVUC+wOQMflFdbpva41lx/67VqbDYtlT01pmvBpCQmnKOr41WbNSAEYy0n
	 DI91mPsy8k+1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 030/638] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Sun, 24 Mar 2024 18:51:07 -0400
Message-ID: <20240324230116.1348576-31-sashal@kernel.org>
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

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 250f5402e636a5cec9e0e95df252c3d54307210f ]

Fixes a bug revealed by -Wmissing-prototypes when
CONFIG_FUNCTION_GRAPH_TRACER is enabled but not CONFIG_DYNAMIC_FTRACE:

 arch/parisc/kernel/ftrace.c:82:5: error: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Werror=missing-prototypes]
    82 | int ftrace_enable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 arch/parisc/kernel/ftrace.c:88:5: error: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Werror=missing-prototypes]
    88 | int ftrace_disable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index d1defb9ede70c..621a4b386ae4f 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -78,7 +78,7 @@ asmlinkage void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	static_key_enable(&ftrace_graph_enable.key);
-- 
2.43.0


