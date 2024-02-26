Return-Path: <linux-kernel+bounces-82216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30978680A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007B61C23BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53FB130E27;
	Mon, 26 Feb 2024 19:13:27 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686111DFEB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974807; cv=none; b=ugxibMvRUjPZfEwUAZf5PuVQCcrxd0Vw37zB491tClklt1B8C0il7MD+DUwe+m8JXPsK9NVDuRpex22fc8Jm34ndAbUw+pK6jDZxwuY81LuL/aUg66udGw8NeHvm2aVQrzFTmCP052epCm7HLoEW1HQd+SbyrCDDwL24Pca+DaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974807; c=relaxed/simple;
	bh=pAbmOtNM38S5447INZawtgqJysuZCh4Jqm2e5w2+338=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpQB12jbaZcyu/Wspst+cvBZVpTkvBf9s14SotbV08bZqvtt3ZuL/I9PU4y2ar/mucVPlvNvmEG5HKePEwc5RTh72dQJUWWi6RT9SLVUoT+7ARadghmMEouqGgM513dgoznQ3LqPNstCLB9JtbJaj35sB5EmbBCkNEyyv40F0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-209-155.188.097.pools.vodafone-ip.de ([188.97.209.155] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1regPO-001h9S-0X;
	Mon, 26 Feb 2024 20:13:02 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] lib/test_vmalloc.c: fix typo in function name
Date: Mon, 26 Feb 2024 20:11:57 +0100
Message-Id: <20240226191159.39509-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226191159.39509-1-martin@kaiser.cx>
References: <20240226191159.39509-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo and change the function name to init_test_configuration. Both
caller and definition have the same typo, so the current code already
works.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 lib/test_vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 3718d9886407..191b6bd5dff9 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -501,7 +501,7 @@ static int test_func(void *private)
 }
 
 static int
-init_test_configurtion(void)
+init_test_configuration(void)
 {
 	/*
 	 * A maximum number of workers is defined as hard-coded
@@ -531,7 +531,7 @@ static void do_concurrent_test(void)
 	/*
 	 * Set some basic configurations plus sanity check.
 	 */
-	ret = init_test_configurtion();
+	ret = init_test_configuration();
 	if (ret < 0)
 		return;
 
-- 
2.39.2


