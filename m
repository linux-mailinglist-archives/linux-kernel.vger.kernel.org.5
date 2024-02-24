Return-Path: <linux-kernel+bounces-79574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4722A862461
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694701C20F99
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7546425764;
	Sat, 24 Feb 2024 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="Scx8/Edg"
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B61B7E8
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708772419; cv=none; b=ATKCjbMmjYNVYpCwgNJm9Kx+yWhUC9vvFUdk5vcz6M+FifLCldFCF4V3B1UL1kxVqVwKk/GNAjB1PDYx7jhMESuftJX/8dzYASdDwJYsuNNBf4sy8RTx2CMz2XYvvtHqMiqhP94b1DZtX6PYUxH91YPVd9m3/U9n79Noz2au9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708772419; c=relaxed/simple;
	bh=TZfMEar/WGv3z6Vr+zFmVB2K7TNo7XIS9DBxR4kHKAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dd+q70NVEF4om+RldyV+m4SOrDILEhKCSKWmk0yXrB/RFNM384EQXnWh22rvcb+NKe0lJcMQBGgL8ikZv4modhVIUEx/ixhUr99bRugspq/2ihdlrSPpmLCc0cl3pjH3yM8kuA5+q4kJhmCjGtn1cPgfcjwqWzu82fiqglb6tEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=Scx8/Edg; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4ThkK95Rs3zyZG;
	Sat, 24 Feb 2024 11:54:21 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=tu-postout21; t=
	1708772061; bh=TZfMEar/WGv3z6Vr+zFmVB2K7TNo7XIS9DBxR4kHKAM=; b=S
	cx8/Edgu2nmGsS4l7bzFuVLeZygh4C5RVN7X0385BXX0YcaMDMGFBRcwcBofkFcK
	abzN375IT+cn+QMTgM4E6YKnis9fnZgmPZtc3Rt+D2SQVjfr4S0hiC6gX9gY4eYs
	Aps6ZlPnGCv8pfJuMW8G221NmA8cG8q9FVp2jtU9GwvdxYDKw7pZcPe3fwOvdge3
	i+zfPPMjaDsC4B7Jxaxy7dhFINOXAAZme3xwEXUtdboZBPI5GIaPiiqD1+lofJSE
	1PXWbcwvLOunAb+QWe+DkQUOiZjcQBxJK9d1HsvpEwxbFPBjrm++tCLtSeKSVk2r
	+pofugRBOoMfjFbyVQDmg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -0.382
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
	by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id t3smiUimcLMl; Sat, 24 Feb 2024 11:54:21 +0100 (CET)
Received: from sienna.fritz.box (ppp-93-104-78-110.dynamic.mnet-online.de [93.104.78.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4ThkK821SYzyZF;
	Sat, 24 Feb 2024 11:54:20 +0100 (CET)
From: =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: akpm@linux-foundation.org
Cc: andreyknvl@gmail.com,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mark.rutland@arm.com,
	paul.heidekrueger@tum.de,
	ryabinin.a.a@gmail.com,
	vincenzo.frascino@arm.com
Subject: [PATCH] kasan: fix a2 allocation and remove explicit cast in atomic tests
Date: Sat, 24 Feb 2024 10:54:14 +0000
Message-Id: <20240224105414.211995-1-paul.heidekrueger@tum.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223161020.9b4184e1e74b35f906e0ec78@linux-foundation.org>
References: <20240223161020.9b4184e1e74b35f906e0ec78@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Address the additional feedback since "kasan: add atomic tests"
(4e76c8cc3378a20923965e3345f40f6b8ae0bdba) by removing an explicit cast
and fixing the size as well as the check of the allocation of `a2`.

CC: Marco Elver <elver@google.com>
CC: Andrey Konovalov <andreyknvl@gmail.com>
Link: https://lore.kernel.org/all/20240131210041.686657-1-paul.heidekrueger@tum.de/T/#u
Fixes: 4e76c8cc3378a20923965e3345f40f6b8ae0bdba
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214055
Reviewed-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@tum.de>
---
@Andrew: 
I wasn't sure whether you'd be squashing this patch into v1 or
if it'll end up as a separate commit. Hope this works either way!

Changes PATCH v2 -> PATCH v3:
* Fix the wrong variable being used when checking a2 after allocation
* Add Andrey's reviewed-by tag

Changes PATCH v1 -> PATCH v2:
* Make explicit cast implicit as per Mark's feedback
* Increase the size of the "a2" allocation as per Andrey's feedback
* Add tags 

Changes PATCH RFC v2 -> PATCH v1:
* Remove casts to void*
* Remove i_safe variable
* Add atomic_long_* test cases
* Carry over comment from kasan_bitops_tags()

Changes PATCH RFC v1 -> PATCH RFC v2:
* Adjust size of allocations to make kasan_atomics() work with all KASan modes
* Remove comments and move tests closer to the bitops tests
* For functions taking two addresses as an input, test each address in a separate function call.
* Rename variables for clarity
* Add tests for READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and smp_store_release()

 mm/kasan/kasan_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 4ef2280c322c..7f0f87a2c3c4 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1152,7 +1152,7 @@ static void kasan_bitops_tags(struct kunit *test)
 
 static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
 {
-	int *i_unsafe = (int *)unsafe;
+	int *i_unsafe = unsafe;
 
 	KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
@@ -1218,8 +1218,8 @@ static void kasan_atomics(struct kunit *test)
 	 */
 	a1 = kzalloc(48, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
-	a2 = kzalloc(sizeof(int), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
+	a2 = kzalloc(sizeof(atomic_long_t), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a2);
 
 	/* Use atomics to access the redzone. */
 	kasan_atomics_helper(test, a1 + 48, a2);
-- 
2.40.1


