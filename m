Return-Path: <linux-kernel+bounces-25399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4546782CFB4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AAB2831B3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CDE1846;
	Sun, 14 Jan 2024 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PrV+GNjv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E457E;
	Sun, 14 Jan 2024 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9pmSScVq+YPQaxqh83IMLElXaQ9efdvI7qKqQ2FfMW4=; b=PrV+GNjvv/hkRbC+La5XXlhd01
	YOvpqIxEcGNOr+OPXrhylcAq2FdS0cGzE+yeGp2SjJ7GPQPTDmiTuPQs8/lKTWsHGn4bG/lcvCX2A
	DjZi6y8+OGCicCEJ/3AjQavNaE9rkTEqxvkWyy57lDV/8YCvM5laOc/Odfe9gFQN6o5b6380/iVp2
	EHiwpPPTqhcPDCmwbMQeVM1jluxDJZQQw+kI/S0j8gFdknfdk7fhsmoYTM0Je0GeXGpe2fHqymkem
	71BUT+CGlt9e/77tLC8HzL8NobmnfXO8xUT+zCVGuzWt1QUPr4b4sF6vzcPZsPmkfTffGoa/wzZxt
	8tNDmgPQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rOsOU-006B2U-0V;
	Sun, 14 Jan 2024 04:46:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH] dma-debug: fix kernel-doc warnings
Date: Sat, 13 Jan 2024 20:46:42 -0800
Message-ID: <20240114044642.7115-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the kernel-doc comments to catch up with the code changes and
fix the kernel-doc warnings:

debug.c:83: warning: Excess struct member 'stacktrace' description in 'dma_debug_entry'
debug.c:83: warning: Function parameter or struct member 'stack_len' not described in 'dma_debug_entry'
debug.c:83: warning: Function parameter or struct member 'stack_entries' not described in 'dma_debug_entry'

Fixes: 746017ed8d4d ("dma/debug: Simplify stracktrace retrieval")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev 
---
 kernel/dma/debug.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/kernel/dma/debug.c b/kernel/dma/debug.c
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -62,7 +62,8 @@ enum map_err_types {
  * @pfn: page frame of the start address
  * @offset: offset of mapping relative to pfn
  * @map_err_type: track whether dma_mapping_error() was checked
- * @stacktrace: support backtraces when a violation is detected
+ * @stack_len: number of backtrace entries in @stack_entries
+ * @stack_entries: stack of backtrace history
  */
 struct dma_debug_entry {
 	struct list_head list;

