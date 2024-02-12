Return-Path: <linux-kernel+bounces-61211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39D850EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACD11F223CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F46F9CA;
	Mon, 12 Feb 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="YsH696/s"
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4FF500
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727043; cv=none; b=ePq34sGKnfeVEA1tvScFko9EgZ9COHnPD/Zt5XWds4MGfwP2nB+NLQVkKAB/q7rffX7NfGk7qQPcZcCndZzvKONi4RPszHBWFh86/5TdvuShc3r789vvrQ8FHIRqXnCfHirWExviu20Ov8CgvcHplJ4TBLnF3pSXyx2PRq05bpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727043; c=relaxed/simple;
	bh=HE1DLq9o0LiwemEBOzOaTO1lbAeymqKCBx6e3PXDex8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek88OtzHbCzVONps6phSehxfnAw1MH0bqNJXFM0M3+GOtTdnAWLW4Z8/ZlUtaDsRBylZsXq7Fckg54bMUgkTZe5OQnlTUdwGqjQh5PdrKrdQoPQ94u7G56VsWoD2xOlpM4emryD1igtG+pFhvEWKnUcHzmYpsYgG4DmvdOfL1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=YsH696/s; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4TYHrZ2sWtzyVF;
	Mon, 12 Feb 2024 09:37:18 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received:received; s=
	tu-postout21; t=1707727037; bh=HE1DLq9o0LiwemEBOzOaTO1lbAeymqKCB
	x6e3PXDex8=; b=YsH696/sE4f3KFIGfnFazB7IZ0JEnaWXqQ5sjDsOAye3RFkdx
	wNPBZsFTbUQ2EatiUK2Yk6rOXXH1X9xYQh/cSMewDZzknhlVwB1HTVKpGQ701gf3
	V6NQxd7MRLe6uAoLOJqA+fLSAOnq4m5Ul3oCvKP+MJ2Ka2UMRVn6QJGODrVokfBH
	ppd/iGQT/HmGYIMRGPbWtiTSH4sZaPH5NZNMJJbtvckP3yDTp+ctZlviFf+bZVg9
	mKa0mbCPtTN0B9QyQNuLlunYeKyaUb3E05tVkUKv4RQV1j4Y6YKKSJwFoEnKzjW0
	HHQLonkcTYd89YV83uxOwl/J5Rb0nKlwcGYxQ==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.879
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
	by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id I03PoRHcZDqc; Mon, 12 Feb 2024 09:37:17 +0100 (CET)
Received: from pine.fritz.box (unknown [IPv6:2001:a61:25f3:6e01:57f:7a4d:e41f:6949])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4TYHrX4fqszyTl;
	Mon, 12 Feb 2024 09:37:16 +0100 (CET)
Date: Mon, 12 Feb 2024 09:37:10 +0100
From: Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: akpm@linux-foundation.org, dvyukov@google.com, elver@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, 
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] kasan: add atomic tests
Message-ID: <mofzkwb2a2wr5z7kg2fe3lowzdca7kqvol5hevhj5dcs5pxvu2@7d4gydk3enon>
References: <20240202113259.3045705-1-paul.heidekrueger@tum.de>
 <20240211091720.145235-1-paul.heidekrueger@tum.de>
 <CA+fCnZcfUyqzok0yV2uvsDdhiT95Y-KYnozY77y04YDBwKhj-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcfUyqzok0yV2uvsDdhiT95Y-KYnozY77y04YDBwKhj-Q@mail.gmail.com>

On 12.02.2024 00:16, Andrey Konovalov wrote:
> On Sun, Feb 11, 2024 at 10:17 AM Paul Heidekrüger
> <paul.heidekrueger@tum.de> wrote:
> >
> > Test that KASan can detect some unsafe atomic accesses.
> >
> > As discussed in the linked thread below, these tests attempt to cover
> > the most common uses of atomics and, therefore, aren't exhaustive.
> >
> > CC: Marco Elver <elver@google.com>
> > CC: Andrey Konovalov <andreyknvl@gmail.com>
> > Link: https://lore.kernel.org/all/20240131210041.686657-1-paul.heidekrueger@tum.de/T/#u
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214055
> > Reviewed-by: Marco Elver <elver@google.com>
> > Tested-by: Marco Elver <elver@google.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Paul Heidekrüger <paul.heidekrueger@tum.de>
> > ---
> > Changes PATCH v1 -> PATCH v2:
> > * Make explicit cast implicit as per Mark's feedback
> > * Increase the size of the "a2" allocation as per Andrey's feedback
> > * Add tags
> >
> > Changes PATCH RFC v2 -> PATCH v1:
> > * Remove casts to void*
> > * Remove i_safe variable
> > * Add atomic_long_* test cases
> > * Carry over comment from kasan_bitops_tags()
> >
> > Changes PATCH RFC v1 -> PATCH RFC v2:
> > * Adjust size of allocations to make kasan_atomics() work with all KASan modes
> > * Remove comments and move tests closer to the bitops tests
> > * For functions taking two addresses as an input, test each address in a separate function call.
> > * Rename variables for clarity
> > * Add tests for READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and smp_store_release()
> >
> >  mm/kasan/kasan_test.c | 79 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >
> > diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> > index 8281eb42464b..7bf09699b145 100644
> > --- a/mm/kasan/kasan_test.c
> > +++ b/mm/kasan/kasan_test.c
> > @@ -1150,6 +1150,84 @@ static void kasan_bitops_tags(struct kunit *test)
> >         kfree(bits);
> >  }
> >
> > +static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
> > +{
> > +       int *i_unsafe = unsafe;
> > +
> > +       KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
> > +
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_set(unsafe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_add(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_and(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_andnot(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_or(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_xor(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_xchg(unsafe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_cmpxchg(unsafe, 21, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(unsafe, safe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, unsafe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub_and_test(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_and_test(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_and_test(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_negative(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 21, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsafe));
> > +
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_read(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_set(unsafe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_and(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_andnot(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_or(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xor(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xchg(unsafe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_cmpxchg(unsafe, 21, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(unsafe, safe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(safe, unsafe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub_and_test(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_and_test(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_and_test(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_negative(42, unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_unless(unsafe, 21, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_not_zero(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_unless_negative(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_unless_positive(unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_if_positive(unsafe));
> > +}
> > +
> > +static void kasan_atomics(struct kunit *test)
> > +{
> > +       void *a1, *a2;
> > +
> > +       /*
> > +        * Just as with kasan_bitops_tags(), we allocate 48 bytes of memory such
> > +        * that the following 16 bytes will make up the redzone.
> > +        */
> > +       a1 = kzalloc(48, GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> > +       a2 = kzalloc(sizeof(atomic_long_t), GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> 
> This should check for a2, not a1. Sorry for not spotting this before.

No need to apologise. I'm the one who made the mistake, so I'm the one who 
should've spotted it in the first place :-)

> > +
> > +       /* Use atomics to access the redzone. */
> > +       kasan_atomics_helper(test, a1 + 48, a2);
> > +
> > +       kfree(a1);
> > +       kfree(a2);
> > +}
> > +
> >  static void kmalloc_double_kzfree(struct kunit *test)
> >  {
> >         char *ptr;
> > @@ -1553,6 +1631,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
> >         KUNIT_CASE(kasan_strings),
> >         KUNIT_CASE(kasan_bitops_generic),
> >         KUNIT_CASE(kasan_bitops_tags),
> > +       KUNIT_CASE(kasan_atomics),
> >         KUNIT_CASE(kmalloc_double_kzfree),
> >         KUNIT_CASE(rcu_uaf),
> >         KUNIT_CASE(workqueue_uaf),
> > --
> > 2.40.1
> >
> 
> With the mentioned change:
> 
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> Thank you!

Just sent v3.

Many thanks,
Paul


