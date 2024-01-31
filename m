Return-Path: <linux-kernel+bounces-47109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4869084496D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3778B278A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E64C38F97;
	Wed, 31 Jan 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="BQ3ghKEN"
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58038DE4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735271; cv=none; b=LKznIxX07v4+xP9VLEFWYwvJjXnaXwtkTHixEOLSyk2S53TNEwR39bv7ZGm2uyo/DCvOTkHafg4imyKXUGL8tBXJtpdcvTPfTt0NLNlEAU16Q0ikjdsZ5gFf8MNLC7StN8HsPYaRBd1bXQ9F6lNlztTzWPQA9Q4OAzhYzVE9Mhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735271; c=relaxed/simple;
	bh=8T0ntn8NGlFPYgSsqLjvDUhzTbz51vC/8f3x10gKGyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bi3iiWmFODZx53bGeXu6CJIuMoj+fzDUE0ZUdpNODrRUSFkyXIBv9rq5qIZOG2Uu2GxaB5ScD0TIyHcVslCMuTzNH8+qyOs+Jy773WOTGU4caYVvA9jfPP34OOX8EjyhPx0pp7pyyTXAn8RDghoWnm7fTkL6oqc2sHNPo5JAqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=BQ3ghKEN; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4TQDwP6773zyTC;
	Wed, 31 Jan 2024 22:01:09 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=tu-postout21; t=1706734869; bh=8T0ntn8NGlF
	PYgSsqLjvDUhzTbz51vC/8f3x10gKGyk=; b=BQ3ghKENggnrHegXoDMqcoN3JXQ
	oMPUoNqAVuNpzockBkD6DkwKh6PMEznDw+VKB39p/bFMMfIwV7YTJ11KRo9HYQ2c
	at3082qW77EFLfb8INUmaqVNvaFRd3ciz5CoSBHbxow7pS2DZsXlcovKYL9V3eNN
	s1dqyIAjOMnodYoJFVKHDPr8gtGMetoRyQn3TSasxohjB0mkUItumrYecnTlhs9j
	NAFQfB+Hz97WHcMFBEF1YrQS0E1kBZog2EfWfpquI35UG686FzITnOMGD/zRgDD1
	kDSJTAd4GsfQn/MfmFfIg7GNoq7bK3rFVoGQ+nLfDI0S8sARccEuqTi7B8g==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.884
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
	by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id 8EExbMguVg1z; Wed, 31 Jan 2024 22:01:09 +0100 (CET)
Received: from sienna.fritz.box (ppp-93-104-72-246.dynamic.mnet-online.de [93.104.72.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4TQDwN2WTRzySC;
	Wed, 31 Jan 2024 22:01:08 +0100 (CET)
From: =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH RFC v2] kasan: add atomic tests
Date: Wed, 31 Jan 2024 21:00:41 +0000
Message-Id: <20240131210041.686657-1-paul.heidekrueger@tum.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

This RFC patch adds tests that detect whether KASan is able to catch
unsafe atomic accesses.

Since v1, which can be found on Bugzilla (see "Closes:" tag), I've made
the following suggested changes:

* Adjust size of allocations to make kasan_atomics() work with all KASan modes
* Remove comments and move tests closer to the bitops tests
* For functions taking two addresses as an input, test each address in a separate function call.
* Rename variables for clarity
* Add tests for READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and smp_store_release()

I'm still uncelar on which kinds of atomic accesses we should be testing
though. The patch below only covers a subset, and I don't know if it
would be feasible to just manually add all atomics of interest. Which
ones would those be exactly? As Andrey pointed out on Bugzilla, if we
were to include all of the atomic64_* ones, that would make a lot of
function calls.

Also, the availability of atomics varies between architectures; I did my
testing on arm64. Is something like gen-atomic-instrumented.sh required?

Many thanks,
Paul

CC: Marco Elver <elver@google.com>
CC: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214055
Signed-off-by: Paul Heidekrüger <paul.heidekrueger@tum.de>
---
 mm/kasan/kasan_test.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 8281eb42464b..1ab4444fe4a0 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1150,6 +1150,55 @@ static void kasan_bitops_tags(struct kunit *test)
 	kfree(bits);
 }
 
+static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
+{
+	int *i_safe = (int *)safe;
+	int *i_unsafe = (int *)unsafe;
+
+	KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
+	KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_set(unsafe, 42));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add(42, unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub(42, unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_and(42, unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_andnot(42, unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_or(42, unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_xor(42, unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_xchg(unsafe, 42));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_cmpxchg(unsafe, 21, 42));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(unsafe, safe, 42));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, unsafe, 42));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub_and_test(42, unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_and_test(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_and_test(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_negative(42, unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 21, 42));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsafe));
+}
+
+static void kasan_atomics(struct kunit *test)
+{
+	int *a1, *a2;
+
+	a1 = kzalloc(48, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
+	a2 = kzalloc(sizeof(*a1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
+
+	kasan_atomics_helper(test, (void *)a1 + 48, (void *)a2);
+
+	kfree(a1);
+	kfree(a2);
+}
+
 static void kmalloc_double_kzfree(struct kunit *test)
 {
 	char *ptr;
@@ -1553,6 +1602,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_strings),
 	KUNIT_CASE(kasan_bitops_generic),
 	KUNIT_CASE(kasan_bitops_tags),
+	KUNIT_CASE(kasan_atomics),
 	KUNIT_CASE(kmalloc_double_kzfree),
 	KUNIT_CASE(rcu_uaf),
 	KUNIT_CASE(workqueue_uaf),
-- 
2.40.1


