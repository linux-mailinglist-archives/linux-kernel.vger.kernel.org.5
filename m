Return-Path: <linux-kernel+bounces-1972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC41815688
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08E61C24185
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706E18AEA;
	Sat, 16 Dec 2023 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wEE5wt9H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C031C38
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxH+H0107hjibgkywFp3x+1IHPwHRqbNS2KeHk+xfq0=;
	b=wEE5wt9HNszQnayjEwAnODC7KU6iCfZWFIu5NBB0pVDY59pdBF3YgAwk7oRGjwDgtXXH6q
	41MYSqRHHvopTKCgEQ6jFgXItfVsfRAhiz/j/A0NqoQmdvteeBT1DmfxZCvu+yWW2IRBWB
	X5zGRl6pLcslH1kpeG0opt3GZ8/9q5M=
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
Subject: [PATCH 09/50] kmsan: add missing types.h dependency
Date: Fri, 15 Dec 2023 21:47:50 -0500
Message-ID: <20231216024834.3510073-10-kent.overstreet@linux.dev>
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

more header dependency pruning/fixing

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/kmsan_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kmsan_types.h b/include/linux/kmsan_types.h
index 8bfa6c98176d..929287981afe 100644
--- a/include/linux/kmsan_types.h
+++ b/include/linux/kmsan_types.h
@@ -9,6 +9,8 @@
 #ifndef _LINUX_KMSAN_TYPES_H
 #define _LINUX_KMSAN_TYPES_H
 
+#include <linux/types.h>
+
 /* These constants are defined in the MSan LLVM instrumentation pass. */
 #define KMSAN_RETVAL_SIZE 800
 #define KMSAN_PARAM_SIZE 800
-- 
2.43.0


