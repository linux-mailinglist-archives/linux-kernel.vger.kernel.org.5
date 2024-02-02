Return-Path: <linux-kernel+bounces-49639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83231846D46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5E21F277A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E177634;
	Fri,  2 Feb 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="RPVzcIDU"
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5F13FE2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868222; cv=none; b=hWSayCw26bI4xnzpqf4hoIWcC97GaU7u1u2gZU+fM2nacu3l1SZ1cf9THkV1z4KZb98l4T/UfxQhiEp0heu/qk8XW4Kn3Qcwo80eTvAmZvV0IwqRj9ZMlng7yddYGO+siavgfti5YzVSqKoZyEvjKFgGmjWzz61dfmNl9qzHTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868222; c=relaxed/simple;
	bh=mZPhnsfQIs9PURvzCAM3bG3CdSibjO9GC8sexiOx9X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDzahlg1e1ZTojlcq7zCtNsgdcN2VASf/ZggqKj+1DhC0j/NrL2ATmW7dHuHynHrkVMzW/Sk/1MuhaDEjbynTkO+Pe9neAoW/qNT8MviLHezz668ebKdKInSarrReu3rlj0ILUhMJ3qWhoG8gABacUw/jCBvGaKU5soKALh9Zpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=RPVzcIDU; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4TRBDc2LD0zyVJ;
	Fri,  2 Feb 2024 11:03:28 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received:received; s=
	tu-postout21; t=1706868205; bh=mZPhnsfQIs9PURvzCAM3bG3CdSibjO9GC
	8sexiOx9X8=; b=RPVzcIDUiPEmO9JesrdxFvrjHa8vxKD/wLe0hWLVqjD/z1s+h
	fcyDXwLG7Zx/t4p2XorZpdpPb7lreB2Cd+PYYHUbRsJf7LWGzTVyN+ql2UMMBlSD
	+Tp/DpNKxG4lvpn8diBfeJvPanX2nC88QhaFU9GWzDHiEhqPBgmDcOuBgBzXk/yl
	pKubtpeb5X/w1/z7kwZ9YA05sglLkBUh4jVtMtGJ1XLKJJYSBO00aU5Jgm5MRjUs
	xns0TZrb2+ONtNHb50higuGnMUTLX7/FLOHEuNkCcbBSjGCv8VS560eQ2CIasNEN
	IyYUq9Ti4Ga6mKl/40TuuEJzxxyFUKsnevlmQ==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.882
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
	by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id 8CO4Xq_tL921; Fri,  2 Feb 2024 11:03:25 +0100 (CET)
Received: from pine.fritz.box (unknown [IPv6:2001:a61:2531:301:2520:4fa:71b2:b582])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4TRBDX3p7czyV1;
	Fri,  2 Feb 2024 11:03:24 +0100 (CET)
Date: Fri, 2 Feb 2024 11:03:18 +0100
From: Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH RFC v2] kasan: add atomic tests
Message-ID: <nrknx5hi3nw7t4kitfweifcwyb436udyxldcclwwyf4cyyhvh5@upebu24mfibo>
References: <20240131210041.686657-1-paul.heidekrueger@tum.de>
 <CANpmjNPvQ16mrQOTzecN6ZpYe+N8dBw8V+Mci53CBgC2sx84Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNPvQ16mrQOTzecN6ZpYe+N8dBw8V+Mci53CBgC2sx84Ew@mail.gmail.com>

On 01.02.2024 10:38, Marco Elver wrote:
> On Wed, 31 Jan 2024 at 22:01, Paul Heidekrüger <paul.heidekrueger@tum.de> wrote:
> >
> > Hi!
> >
> > This RFC patch adds tests that detect whether KASan is able to catch
> > unsafe atomic accesses.
> >
> > Since v1, which can be found on Bugzilla (see "Closes:" tag), I've made
> > the following suggested changes:
> >
> > * Adjust size of allocations to make kasan_atomics() work with all KASan modes
> > * Remove comments and move tests closer to the bitops tests
> > * For functions taking two addresses as an input, test each address in a separate function call.
> > * Rename variables for clarity
> > * Add tests for READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and smp_store_release()
> >
> > I'm still uncelar on which kinds of atomic accesses we should be testing
> > though. The patch below only covers a subset, and I don't know if it
> > would be feasible to just manually add all atomics of interest. Which
> > ones would those be exactly?
> 
> The atomics wrappers are generated by a script. An exhaustive test
> case would, if generated by hand, be difficult to keep in sync if some
> variants are removed or renamed (although that's probably a relatively
> rare occurrence).
> 
> I would probably just cover some of the most common ones that all
> architectures (that support KASAN) provide. I think you are already
> covering some of the most important ones, and I'd just say it's good
> enough for the test.
> 
> > As Andrey pointed out on Bugzilla, if we
> > were to include all of the atomic64_* ones, that would make a lot of
> > function calls.
> 
> Just include a few atomic64_ cases, similar to the ones you already
> include for atomic_. Although beware that the atomic64_t helpers are
> likely not available on 32-bit architectures, so you need an #ifdef
> CONFIG_64BIT.
> 
> Alternatively, there is also atomic_long_t, which (on 64-bit
> architectures) just wraps atomic64_t helpers, and on 32-bit the
> atomic_t ones. I'd probably opt for the atomic_long_t variants, just
> to keep it simpler and get some additional coverage on 32-bit
> architectures.

If I were to add some atomic_long_* cases, e.g. atomic_long_read() or 
atomic_long_write(), in addition to the test cases I already have, wouldn't that 
mean that on 32-bit architectures we would have the same test case twice because 
atomic_read() and long_atomic_read() both boil down to raw_atomic_read() and 
raw_atomic_write() respectively? Or did I misunderstand and I should only be 
covering long_atomic_* functions whose atomic_* counterpart doesn't exist in the 
test cases already?

> > Also, the availability of atomics varies between architectures; I did my
> > testing on arm64. Is something like gen-atomic-instrumented.sh required?
> 
> I would not touch gen-atomic-instrumented.sh for the test.
> 
> > Many thanks,
> > Paul
> >
> > CC: Marco Elver <elver@google.com>
> > CC: Andrey Konovalov <andreyknvl@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214055
> > Signed-off-by: Paul Heidekrüger <paul.heidekrueger@tum.de>
> > ---
> >  mm/kasan/kasan_test.c | 50 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> > index 8281eb42464b..1ab4444fe4a0 100644
> > --- a/mm/kasan/kasan_test.c
> > +++ b/mm/kasan/kasan_test.c
> > @@ -1150,6 +1150,55 @@ static void kasan_bitops_tags(struct kunit *test)
> >         kfree(bits);
> >  }
> >
> > +static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
> > +{
> > +       int *i_safe = (int *)safe;
> > +       int *i_unsafe = (int *)unsafe;
> > +
> > +       KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
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
> > +}
> > +
> > +static void kasan_atomics(struct kunit *test)
> > +{
> > +       int *a1, *a2;
> 
> If you're casting it to void* below and never using as an int* in this
> function, just make these void* (the sizeof can just be sizeof(int)).
> 
> > +       a1 = kzalloc(48, GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> > +       a2 = kzalloc(sizeof(*a1), GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> > +
> > +       kasan_atomics_helper(test, (void *)a1 + 48, (void *)a2);
> 
> We try to ensure (where possible) that the KASAN tests are not
> destructive to the rest of the kernel. I think the size of "48" was
> chosen to fall into the 64-byte size class, similar to the bitops. I
> would just copy that comment, so nobody attempts to change it in
> future. :-)

And yes to all the rest - thanks for the feedback!

> > +       kfree(a1);
> > +       kfree(a2);
> 
> Thanks,
> -- Marco

Many thanks,
Paul

