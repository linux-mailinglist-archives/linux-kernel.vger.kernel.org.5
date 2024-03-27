Return-Path: <linux-kernel+bounces-121030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9488E1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A5E1C22B70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718115B116;
	Wed, 27 Mar 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFRPR8Hn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04ED13A242;
	Wed, 27 Mar 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541888; cv=none; b=WKlKwek6rGwALjH7B9qxFLQCtU/0l/a7p8fbh+IeEMAKFFhAzqZKHW4TdlRMM9ZQ3VGtSdWB7St1xB51FvR5g4jPMo85pgBv41qgvheQlx2cAXfDUniTXc5FQE1ftouTdoFQQg7jTQrATVXXfddpr4ZvnSy8YmWAwPtZhjK2pRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541888; c=relaxed/simple;
	bh=Two2l8kOoGiBrbC0zbvxiHwHZ+zgAS70Vj/OyvK6Ax8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIZElAEP5RyY+cIJLNpFqEN4aCn1F/GoDLIuNjQ32GrjHOaCIh1mK+vFGBmaKZhUPKzI9eJKwvtYWVHfQx6WCsNttjiOVDsLtKjlCoSfJ5+S5jbw2VT4OEaq1qm5DG2aJi/UBZwMWKKtJ9Gh61zAUyFdqntlpCxhZAWsjBjWkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFRPR8Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AFFC433C7;
	Wed, 27 Mar 2024 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541888;
	bh=Two2l8kOoGiBrbC0zbvxiHwHZ+zgAS70Vj/OyvK6Ax8=;
	h=From:To:Cc:Subject:Date:From;
	b=tFRPR8Hn3fe9KH4deYDAiKk7OzaN7rwjYYppywpc/yg/z8+hxPvWdi+IvShrfmP2B
	 rrGCc+pRFkHI1R/CiUkpq/OpZG+ZOQmwa75eXU1Y0McOPiSBObd9xpSrO/LEzapdrJ
	 FnpoycPX2YoURjRiW13d5e0A0QX+T+zGWlau3Q9c1itddltsXkVFFttzR+SAos/K0o
	 XQY7eNk16eE9vkSZFrHpIVG0Ufe8HwA6vv72fbGNwi7W3h+liYW9XLB0lIo8B0GRXS
	 hJh/WJP831owyfPwkGaAf6I+bvuPgaVjhI1zYwoS37ybUfQdtODyj8suA7nuslxg34
	 aSVomfmgODZNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	arnd@arndb.de
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "kasan/test: avoid gcc warning for intentional overflow" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:06 -0400
Message-ID: <20240327121806.2834070-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e10aea105e9ed14b62a11844fec6aaa87c6935a3 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 12 Feb 2024 12:15:52 +0100
Subject: [PATCH] kasan/test: avoid gcc warning for intentional overflow

The out-of-bounds test allocates an object that is three bytes too short
in order to validate the bounds checking.  Starting with gcc-14, this
causes a compile-time warning as gcc has grown smart enough to understand
the sizeof() logic:

mm/kasan/kasan_test.c: In function 'kmalloc_oob_16':
mm/kasan/kasan_test.c:443:14: error: allocation of insufficient size '13' for type 'struct <anonymous>' with size '16' [-Werror=alloc-size]
  443 |         ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
      |              ^

Hide the actual computation behind a RELOC_HIDE() that ensures
the compiler misses the intentional bug.

Link: https://lkml.kernel.org/r/20240212111609.869266-1-arnd@kernel.org
Fixes: 3f15801cdc23 ("lib: add kasan test module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kasan/kasan_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 318d9cec111aa..2d8ae4fbe63bb 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -440,7 +440,8 @@ static void kmalloc_oob_16(struct kunit *test)
 	/* This test is specifically crafted for the generic mode. */
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
 
-	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
+	/* RELOC_HIDE to prevent gcc from warning about short alloc */
+	ptr1 = RELOC_HIDE(kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL), 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
 	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
-- 
2.43.0





