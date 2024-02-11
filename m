Return-Path: <linux-kernel+bounces-60675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2385084A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB7283730
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92D59163;
	Sun, 11 Feb 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="i5A0RDxK"
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4645959
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707643079; cv=none; b=UR5zoIEgJ6Djmh1agEfOhV3DeSOgOC5wTjNGePdiYvTt9pXhWoT6PdGj7fMXEm1lOndsJgDIBufnODmxjhhGSXNqD+7fI/RESsJGX8hErEBds/YOvoKnbElaIbYRejq28eFhbCBIiqy/xoJRkdqtbcbZy9fmmAtGs7UvCMWVttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707643079; c=relaxed/simple;
	bh=Jv4cL9UsVOf4EKlSKubvFmDWNJzxN5n8SoeS8SI0QW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/xCeuIOvuVmaCVWmtCvGPUS9gxw0V0dJ9F1F/OzoFd8hV/wAyTOKE7OX3xvjyyGHs9hWbmj1CuaIBjMGWpdW93GhCn11xCau/h+lqwARB7dUrG9m0CnqaaQMcaJu9pk0aVO/McjfB1vCHaotEDh1ZoD9QeCRX+E0fNHmaRj3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=i5A0RDxK; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4TXhff50PfzyVC;
	Sun, 11 Feb 2024 10:11:38 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received:received; s=
	tu-postout21; t=1707642698; bh=Jv4cL9UsVOf4EKlSKubvFmDWNJzxN5n8S
	oeS8SI0QW8=; b=i5A0RDxKzx4ppzSwsW6lYGG2KiyuqxERPXPGnf7jO3BubUr3Q
	J0VhSRnZcUgQ9KRFpFRSlMy+wkKUSwx6DJxPFKQuQRKc2r2YbSUcJX81nqRW5i2U
	2YZIwbPUXo5gtdsx7/euZD12zQnqviaEaADwkXx0n3m4Cv+c+x4fgnVtfGkry3Jk
	5xsCn7Mk+NO7I20GHnLY+X0zBmmO/7FISf/2NcyV3tgdZyoW5Ng8YwmnhdfwY1sm
	C/+c2LY66nri0rySxbP5emuW6PAa/ZBxi6Qa1mXfNW/2lB5u1bZsjZhJ5wvRCxwg
	NSIw+toPG5VPTFeayApy62iNk++Ny1oSug2aQ==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.879
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
	by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id RO5beP05XWcW; Sun, 11 Feb 2024 10:11:38 +0100 (CET)
Received: from pine.fritz.box (unknown [IPv6:2001:a61:25e5:2101:6db9:145:ae0a:2a16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4TXhfd1X3yzyS3;
	Sun, 11 Feb 2024 10:11:37 +0100 (CET)
Date: Sun, 11 Feb 2024 10:11:33 +0100
From: Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: elver@google.com, akpm@linux-foundation.org, dvyukov@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com
Subject: Re: [PATCH] kasan: add atomic tests
Message-ID: <pqfokz55m6izzahl5jtbbhundrsjmbeaf3kmspo2q2oqv2hpcl@wdsabytutjv2>
References: <CANpmjNP033FCJUb_nzTMJZnvXQj8esFBv_tg5-rtNtVUsGLB_A@mail.gmail.com>
 <20240202113259.3045705-1-paul.heidekrueger@tum.de>
 <CA+fCnZdDxot_wms3XmZonBCo7=qkCSj72inhSX+zHNF9gkMv2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdDxot_wms3XmZonBCo7=qkCSj72inhSX+zHNF9gkMv2A@mail.gmail.com>

On 05.02.2024 22:00, Andrey Konovalov wrote:
> On Fri, Feb 2, 2024 at 12:33 PM Paul Heidekrüger
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
> > Signed-off-by: Paul Heidekrüger <paul.heidekrueger@tum.de>
> > ---
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
> > index 8281eb42464b..4ef2280c322c 100644
> > --- a/mm/kasan/kasan_test.c
> > +++ b/mm/kasan/kasan_test.c
> > @@ -1150,6 +1150,84 @@ static void kasan_bitops_tags(struct kunit *test)
> >         kfree(bits);
> >  }
> >
> > +static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
> > +{
> > +       int *i_unsafe = (int *)unsafe;
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
> > +       a2 = kzalloc(sizeof(int), GFP_KERNEL);
> 
> I think this should be sizeof(atomic_long_t) or sizeof(long),
> otherwise a2 will not work as the safe argument for
> atomic_long_try_cmpxchg on 64-bit architectures.

Ah, good catch!

> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
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

I'll be sending a v2 patch right away.

Thank you Marco, Mark, and Andrey!

Paul


