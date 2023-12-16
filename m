Return-Path: <linux-kernel+bounces-1969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D0815682
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8483F1C23F29
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183313FEE;
	Sat, 16 Dec 2023 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C/t1fpiB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8D125B4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dirJbIBYBbwICI4HG2MDe2+uXbYG1jRUJZWkMhaKse4=;
	b=C/t1fpiBdM4bKT/cXDHIACveKwqIAMw7X1VW35xI28bBG0JOo60HYOoaWgMkz+Q0hKlDIc
	Vi4CuIr9fuiX0y5hio/M75U2WWQzOCioAyle3CdTe/xTt+GJxcykSwlv7rtzSZI3kDC4zW
	z3drT2Q2XabyOKUS78U6CCb+PfxmA8s=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 06/50] task_stack.h: add missing include
Date: Fri, 15 Dec 2023 21:47:47 -0500
Message-ID: <20231216024834.3510073-7-kent.overstreet@linux.dev>
In-Reply-To: <20231216024834.3510073-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/sched/task_stack.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index f158b025c175..ccd72b978e1f 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/magic.h>
+#include <linux/refcount.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
-- 
2.43.0


