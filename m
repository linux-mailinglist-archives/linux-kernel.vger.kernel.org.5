Return-Path: <linux-kernel+bounces-25560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3511082D2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B58C1C20926
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9764E;
	Mon, 15 Jan 2024 00:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQId7CQe"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E2160;
	Mon, 15 Jan 2024 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SMPOLVGSAewxtdJLwZCxtwBam7ckyoDfh8pKl1H1lAA=; b=ZQId7CQe2soeI2QWsAGfrsGh4A
	XyrPMK7kI6Cagrm8FAQLidr0ltmcvk6fYFlYOBoIpXoRBUasyp8pHDBdkdZ9X5P32TP0Y2SgyNPGU
	eXOoK9oy1pEL9hiWPcEWUwu0Nfi05BQjI76qLXvD1GtUnfbExIPtsIltGhWLT+CaY508JScUAFl2O
	RuavmMV0LbrMAafEQ8p/0Zm8x2X/udHxpKLKA/WyJ/vTs/k5E93jZv2dem7FEtJo4mCCw9VsbMeKD
	AAtG8LmFIj9X4vaXOrvMiE4usgCLATg0Lr2XSe007mehC2iHBl/MHTbUzDEBS3R81yIQILAcGxX+9
	reo1MkYA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPAb2-007XAr-0d;
	Mon, 15 Jan 2024 00:12:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: keystone: sci-clk: match func name comment to actual
Date: Sun, 14 Jan 2024 16:12:55 -0800
Message-ID: <20240115001255.4124-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the function name in the kernel-doc comment to match the
actual function name to avoid a kernel-doc warning:

drivers/clk/keystone/sci-clk.c:287: warning: expecting prototype for _sci_clk_get(). Prototype was for _sci_clk_build() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/keystone/sci-clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -272,7 +272,7 @@ static const struct clk_ops sci_clk_ops
 };
 
 /**
- * _sci_clk_get - Gets a handle for an SCI clock
+ * _sci_clk_build - Gets a handle for an SCI clock
  * @provider: Handle to SCI clock provider
  * @sci_clk: Handle to the SCI clock to populate
  *

