Return-Path: <linux-kernel+bounces-15430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6DB822BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6007D285372
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD918EA2;
	Wed,  3 Jan 2024 11:11:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from viti.kaiser.cx (viti.kaiser.cx [85.214.81.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3B18EA1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from [185.206.209.216] (helo=martin-debian-2.paytec.ch)
	by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <martin@kaiser.cx>)
	id 1rKz2s-0006tr-49; Wed, 03 Jan 2024 12:04:22 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Arnd Bergmann <arnd@arndb.de>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] ARM: debug: fix DEBUG_UNCOMPRESS help for !MULTIPLATFORM
Date: Wed,  3 Jan 2024 12:04:09 +0100
Message-Id: <20240103110409.167132-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 84fc86360623 ("ARM: make ARCH_MULTIPLATFORM user-visible") modified
DEBUG_UNCOMPRESS to prevent using it with multiplatform kernels.

Update the help text, remove references to multiplatform.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/Kconfig.debug | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index fc2b41d41447..5fbbac1b708b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1809,15 +1809,8 @@ config DEBUG_UNCOMPRESS
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
 		     !DEBUG_BRCMSTB_UART && !DEBUG_SEMIHOSTING
 	help
-	  This option influences the normal decompressor output for
-	  multiplatform kernels.  Normally, multiplatform kernels disable
-	  decompressor output because it is not possible to know where to
-	  send the decompressor output.
-
-	  When this option is set, the selected DEBUG_LL output method
-	  will be re-used for normal decompressor output on multiplatform
-	  kernels.
-	  
+	  Say Y here to enable debug output in the decompressor code, using
+	  the selected DEBUG_LL output method.
 
 config UNCOMPRESS_INCLUDE
 	string
-- 
2.39.2


