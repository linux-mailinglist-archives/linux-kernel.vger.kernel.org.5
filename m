Return-Path: <linux-kernel+bounces-31742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E783333D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D62284977
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92DE256D;
	Sat, 20 Jan 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj4a6KDf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E880D;
	Sat, 20 Jan 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705739587; cv=none; b=YX5CdmMw14x6ByL5Qs6fQ53kqsZK0SV2QQRZzBdYIc0a6MLMg6SKAILmH4hnz8KoCEMjnn8Q6tyIdz4CKm1OecF1sH+c5ffb9j9JeHagTX6DbzEG+cHOSCsuTIvLm7RShhakW+h0qsWySfE3694Yv3gpTJRjFXTzWS6ZNEEm0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705739587; c=relaxed/simple;
	bh=IKJ6srK3HgHXSY+LR66AAmd84CvukbxNJTjGxQOIeTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWq/NztxfbcQ/hxbTcHjQRLSG4gYa4UgawPiu02Teze/UK8d4BClk/BOEKV+Mn3PyUoQpLR7Rw5QOpsFJjnOpFFDMSqryQkBcD+Wb7++3UjRuii7WpGcnMHLmLQbwOjhF3hQf586D+ZVRgLwK5cFLXx9fwOe+6de05t5dqREBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj4a6KDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70191C433F1;
	Sat, 20 Jan 2024 08:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705739586;
	bh=IKJ6srK3HgHXSY+LR66AAmd84CvukbxNJTjGxQOIeTo=;
	h=From:To:Cc:Subject:Date:From;
	b=qj4a6KDfXXOl08rkAllwE+BsoVU9phwNEEA+w5yWSmDI8Nhd8D1FZK1BJLPX39wnt
	 DK4rflWfOMflhRuRItZBs7XWLp/D3KDNQuTu2xGZ2cR35aZT6MMPzS73Kl+Ox2bnIg
	 HiHPLXcq8hW3mS1lKpz+hoZqek59R1qrBf3o5Vdxk2oPZ5bg2YuE37AKEOz8j8IF/c
	 UuXlrgOZMH6EXz8JGpaUrW8ak8ieXAYM5T2qReRfKTiNt3UDU2i6x4fHx3y21ppn9M
	 0J392PG5FMBinUunES+V0d+Wl/IAYcY0CMCgddQkCWX4zV49imL8HIcVMkjGTC0GuY
	 gbz31aBvRf/zw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix W= flags in the help message
Date: Sat, 20 Jan 2024 17:32:55 +0900
Message-Id: <20240120083255.2757978-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=c and W=e are supported.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f288eb2dc8fd..8c6a935c62e6 100644
--- a/Makefile
+++ b/Makefile
@@ -1653,7 +1653,7 @@ help:
 	@echo  '                       (sparse by default)'
 	@echo  '  make C=2   [targets] Force check of all c source with $$CHECK'
 	@echo  '  make RECORDMCOUNT_WARN=1 [targets] Warn about ignored mcount sections'
-	@echo  '  make W=n   [targets] Enable extra build checks, n=1,2,3 where'
+	@echo  '  make W=n   [targets] Enable extra build checks, n=1,2,3,c,e where'
 	@echo  '		1: warnings which may be relevant and do not occur too often'
 	@echo  '		2: warnings which occur quite often but may still be relevant'
 	@echo  '		3: more obscure warnings, can most likely be ignored'
-- 
2.40.1


