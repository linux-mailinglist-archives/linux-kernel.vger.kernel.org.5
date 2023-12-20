Return-Path: <linux-kernel+bounces-6391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496881984B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D44B22A09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C63101CB;
	Wed, 20 Dec 2023 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wdMUBtt+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C09FBE1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MAUaq8IkpLHhs/UVmsnwEorJUb7+sVjDUjfs5lB7CEc=; b=wdMUBtt+KVPf4N2YC8B666qk9G
	EyS3mpIvmhmBsUYnuuXOBkhNdFOZ/ZB/XBW0wMpalblBivB07AIdwK+iwk5Xr/2CWpi2dIFtKV8Zv
	gOMNzMhIUFvwUvBOEhgJUiWKCEFQkUcMXCCARv1StemHWCNbys1wf0yg6DW48AT36H4v4eVgFjqXk
	seG72yW8mxg8a7uIu2RnD9UztZcWn7oTXJ5MqVsuos680SUhLKnIcuGLwfx/cDQYC/4VEawrRJ9Zj
	aacqlRuferREO75hZRf/WkOauKM92xqTiGlZek3Oc8lV0bMZIeLBu1MQcSD3T891+fVq6JY3en/0T
	Dt/Tcuig==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpSk-00GDys-0J;
	Wed, 20 Dec 2023 05:49:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] stacktrace: fix kernel-doc typo
Date: Tue, 19 Dec 2023 21:49:45 -0800
Message-ID: <20231220054945.17663-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change @task to @tsk to prevent kernel-doc warnings:

kernel/stacktrace.c:138: warning: Excess function parameter 'task' description in 'stack_trace_save_tsk'
kernel/stacktrace.c:138: warning: Function parameter or member 'tsk' not described in 'stack_trace_save_tsk'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v2: add Andrew to Cc: list

 kernel/stacktrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/kernel/stacktrace.c b/kernel/stacktrace.c
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(stack_trace_save);
 
 /**
  * stack_trace_save_tsk - Save a task stack trace into a storage array
- * @task:	The task to examine
+ * @tsk:	The task to examine
  * @store:	Pointer to storage array
  * @size:	Size of the storage array
  * @skipnr:	Number of entries to skip at the start of the stack trace

