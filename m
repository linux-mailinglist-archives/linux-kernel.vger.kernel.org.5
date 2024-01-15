Return-Path: <linux-kernel+bounces-25640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951582D3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0987C281741
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4092568;
	Mon, 15 Jan 2024 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z4L4vF5f"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422A63AA;
	Mon, 15 Jan 2024 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Ze3qmbqqPjB3WNnim3tvfyFlNIHBTH8rGbog0Y3irZk=; b=z4L4vF5f/dSF3eI16pY+tQPCyG
	BaxMDqdaB3rDtYwCayss7g0jyxGV4CfBtzv16ZTYV7pT3z4P7JXexwLubs7GUgIONelEVU6HUZm4p
	QDJZI1/qIREDpDnH0EqSCCFpAI/JAt9guq3WFtSXG89vHkEvViK10lej3lAJPJdp5SQP4SUSIR1pV
	5MFP3jeaqrTZFUw3Rb+gwSx7Ahr99jaOMrQ/CaPtTIFGC17SgrZmbZTms3WMV1MoUpSpSpTuCyYno
	oC46GCD/oeHf6vEP57Jv0JAPBs+DwPeC4ZwkMScG04Rx0ip4l++RQeOuYPgCQJ8/NQMSERTfvGD8G
	gokJZ0jw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPFox-007ohW-39;
	Mon, 15 Jan 2024 05:47:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tero Kristo <kristo@kernel.org>,
	linux-omap@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: ti: dpll3xxx: use correct function names in kernel-doc
Date: Sun, 14 Jan 2024 21:47:39 -0800
Message-ID: <20240115054739.4988-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use function names that match the implementation in kernel-doc comments
to avoid kernel-doc warnings:

dpll3xxx.c:938: warning: expecting prototype for omap3_non_core_dpll_save_context(). Prototype was for omap3_noncore_dpll_save_context() instead
dpll3xxx.c:967: warning: expecting prototype for omap3_core_dpll_restore_context(). Prototype was for omap3_noncore_dpll_restore_context() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tero Kristo <kristo@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/ti/dpll3xxx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -928,7 +928,7 @@ void omap3_core_dpll_restore_context(str
 }
 
 /**
- * omap3_non_core_dpll_save_context - Save the m and n values of the divider
+ * omap3_noncore_dpll_save_context - Save the m and n values of the divider
  * @hw: pointer  struct clk_hw
  *
  * Before the dpll registers are lost save the last rounded rate m and n
@@ -957,7 +957,7 @@ int omap3_noncore_dpll_save_context(stru
 }
 
 /**
- * omap3_core_dpll_restore_context - restore the m and n values of the divider
+ * omap3_noncore_dpll_restore_context - restore the m and n values of the divider
  * @hw: pointer  struct clk_hw
  *
  * Restore the last rounded rate m and n

