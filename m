Return-Path: <linux-kernel+bounces-1964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13326815678
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F820B2411C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC064C95;
	Sat, 16 Dec 2023 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="plCJO/Au"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4659185A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VODn5WVL/QM1g9I4uze47yYKYzg7GnQJBhOUGBuweLk=;
	b=plCJO/Au/k4zBWiq1kfl3DEx4msB15mWbNXADii4zWXpC06IrsUBwfznvBUSVYuTUy6yTs
	Tf6Cv0koH4nz9RXTAqvGAiIAS0wclWaYdYy2VTOSZjHE/+B5gUpBd9kuYRXHKgjdkWljMJ
	wn2KTDH3LqVil2EPl+7+puwyfgbOW8M=
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
Subject: [PATCH 01/50] drivers/gpu/drm/i915/i915_memcpy.c: fix missing includes
Date: Fri, 15 Dec 2023 21:47:42 -0500
Message-ID: <20231216024834.3510073-2-kent.overstreet@linux.dev>
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
 drivers/gpu/drm/i915/i915_memcpy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_memcpy.c b/drivers/gpu/drm/i915/i915_memcpy.c
index 1b021a4902de..40b288136841 100644
--- a/drivers/gpu/drm/i915/i915_memcpy.c
+++ b/drivers/gpu/drm/i915/i915_memcpy.c
@@ -23,6 +23,8 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/string.h>
+#include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 
 #include "i915_memcpy.h"
-- 
2.43.0


