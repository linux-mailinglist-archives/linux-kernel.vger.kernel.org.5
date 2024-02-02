Return-Path: <linux-kernel+bounces-50084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C3847407
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E731C2545F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18139151CEF;
	Fri,  2 Feb 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHPlvMni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD66151CD3;
	Fri,  2 Feb 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889537; cv=none; b=B+yYk13ajj21Y8aSFnnVtPInpO5FzQngu0YE9xc66qT0cTSBJt+nUTWxGEd5WIm9xJdizrNUXj0trXc54LRFPcNFhVn5jGM8cOta3NkN5/D9vAo2Z9Lu9um7rfuHg782E8xMd8WrTJ02f+NtGbH+g2HuMRlU+n0VJrMHTLWP5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889537; c=relaxed/simple;
	bh=FTcLV2NufTBnpOgxgoEZStajI6PRmkWD1yAMbETfinQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2PNPCsHo3IaeaBL9f60AlIDXc+o/0YtJFVGbiE3Lb+UcUYGgQCVX/mz10guUfzqE4XdneuDAUTZmghlRzTpnGEsTF4FPEStFLFaYgAn04CAXeoCwPGCC23F4NTFswN3XvgLl/SnuURzF9tEO0ZC8xVCxfDobBEys4UsFp8t760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHPlvMni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B232C43390;
	Fri,  2 Feb 2024 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889537;
	bh=FTcLV2NufTBnpOgxgoEZStajI6PRmkWD1yAMbETfinQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHPlvMni4MDvKigZg2a8wQU1pSZK2Voh6N8Em4TtlyRxmzpFMuU4EaO2CaSoODtsO
	 IDOo9X/Sdp2qfdXjJkyBaD9o3E5AzRuFcjXmmPXwxzeTi3L7d5jZE/ermuVdypYdfb
	 3oABKE31z5LET4VBmmqS/AINEF29sKD45qg0jh1n6at/aqMeGmpKQL+nuDP0plZ8OO
	 0C3JhMx//nm9vqD9v/gd1tvkFaWtmhTiogp5vpfnqZhCBhtQ0c/QRZqevxCuGU9iH/
	 ROLHvzYGKjTvem876+4Ly6jEJqMQnoo7acgzjItSPSKifOAd0Zett2SzkQIITOzArH
	 aTPo0cn6B2qfA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 24/27] kconfig: move strhash() to a header
Date: Sat,  3 Feb 2024 00:58:22 +0900
Message-Id: <20240202155825.314567-25-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move strhash() to a header, so it can be used from other files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/symbol.c | 10 +---------
 scripts/kconfig/util.h   | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 9 deletions(-)
 create mode 100644 scripts/kconfig/util.h

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index dae630a74e50..518977c525de 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -10,6 +10,7 @@
 #include <regex.h>
 
 #include "lkc.h"
+#include "util.h"
 
 struct symbol symbol_yes = {
 	.name = "y",
@@ -803,15 +804,6 @@ bool sym_is_changeable(struct symbol *sym)
 	return sym->visible > sym->rev_dep.tri;
 }
 
-static unsigned strhash(const char *s)
-{
-	/* fnv32 hash */
-	unsigned hash = 2166136261U;
-	for (; *s; s++)
-		hash = (hash ^ *s) * 0x01000193;
-	return hash;
-}
-
 struct symbol *sym_lookup(const char *name, int flags)
 {
 	struct symbol *symbol;
diff --git a/scripts/kconfig/util.h b/scripts/kconfig/util.h
new file mode 100644
index 000000000000..d4e35bee6450
--- /dev/null
+++ b/scripts/kconfig/util.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef UTIL_H
+#define UTIL_H
+
+static unsigned int strhash(const char *s)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+
+	for (; *s; s++)
+		hash = (hash ^ *s) * 0x01000193;
+	return hash;
+}
+
+#endif /* UTIL_H */
-- 
2.40.1


