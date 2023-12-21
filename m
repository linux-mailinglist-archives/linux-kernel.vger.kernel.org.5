Return-Path: <linux-kernel+bounces-9027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90581BF66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1939B24198
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC697690C;
	Thu, 21 Dec 2023 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eN0oFbJi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5F7319B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/6/sI3HKZf6Tm/zhA/G4IhIpYOeRmpfsNisTtqnMzE=;
	b=eN0oFbJiwT3zUnq2cxeXoUm44eMoYM8NmUuh4m/ta8P8IRSzUOmK1w4vpgo38zt4d8LCrA
	exyl7aMfq6fUaijIp7KICaNRhlJzWlDY/wAMTLTJJ2IRzzSfwwE40tPn7y2fMMvcsd7cRE
	+bxk8A7+0pKfZWEiGw/4jcKK7Qx1fWE=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 09/11] kasan: export kasan_poison as GPL
Date: Thu, 21 Dec 2023 21:04:51 +0100
Message-Id: <171d0b8b2e807d04cca74f973830f9b169e06fb8.1703188911.git.andreyknvl@google.com>
In-Reply-To: <cover.1703188911.git.andreyknvl@google.com>
References: <cover.1703188911.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

KASAN uses EXPORT_SYMBOL_GPL for symbols whose exporting is only required
for KASAN tests when they are built as a module.

kasan_poison is one on those symbols, so export it as GPL.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 30625303d01a..9ef84f31833f 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -145,7 +145,7 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 
 	__memset(shadow_start, value, shadow_end - shadow_start);
 }
-EXPORT_SYMBOL(kasan_poison);
+EXPORT_SYMBOL_GPL(kasan_poison);
 
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_poison_last_granule(const void *addr, size_t size)
-- 
2.25.1


