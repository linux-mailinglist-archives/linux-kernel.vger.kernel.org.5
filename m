Return-Path: <linux-kernel+bounces-2350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14936815B73
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2304284FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013F328BC;
	Sat, 16 Dec 2023 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SKg1q+J+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD7321BC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=B8RmtSt9j0Sk37XFsr8jPTPVxFFvG2cLd3/RNO/nL7c=; b=SKg1q+J+wxMmHEwIV2kt4/wALt
	jEUhwi/N5JuW6Q3pkLWcCN3qCn5voEFThe5Vmn8GLC3vgHvxouZKXh9+9oCZzrCTyzDdt5LufZFzW
	ms5NmOmnRm2o7XCaQvKCDifI7I5e9ZTvZtdEviuvVRDJ8xcLN5xvAV8pgK5Y0XuuIf1AsismqCfUW
	UOfp+TiLRPDa97sASrBPqnYBo0uUsMHpmZ9Wq8nKiPUJyIM+bw368DHIxoboY2w/EH/zvxesGmp/a
	qKUqCsY38mkRoEVyguSY/9/jxRbRzJQkyDwoUc7KJRAGZ9/3NYPACf31ec67UhetO1YDZC9EKIEe8
	3AmXkoDA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEafl-006eQT-1Y;
	Sat, 16 Dec 2023 19:50:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Subject: [PATCH] x86/usercopy: fix kernel-doc function param name
Date: Sat, 16 Dec 2023 11:50:04 -0800
Message-ID: <20231216195004.29040-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the function parameter name in clean_cache_range() to prevent
kernel-doc warnings:

usercopy_64.c:29: warning: Function parameter or member 'addr' not described in 'clean_cache_range'
usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
---
 arch/x86/lib/usercopy_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -18,7 +18,7 @@
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
  * clean_cache_range - write back a cache range with CLWB
- * @vaddr:	virtual start address
+ * @addr:	virtual start address
  * @size:	number of bytes to write back
  *
  * Write back a cache range using the CLWB (cache line write back)

