Return-Path: <linux-kernel+bounces-79107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647A4861DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C741C250FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F690145B38;
	Fri, 23 Feb 2024 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="QdGni1Nl"
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF3EAD2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720369; cv=none; b=UdCttTPZtu/NVxlsaWfchl4kwYCff85O0lWZmrQLWtXuC85DDN3urkDC3Y5sTQpWqWq/aMm3eyGieXyKRXqSI7Egb0lJbeUUYFN1Hvy4YjdMsuv2RiyMsJAalWKKpwCbSY0we7XJzVuXA59zDAvswp4K6BCJNS+RlfbtfzSdJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720369; c=relaxed/simple;
	bh=t49cO6p/CTxhIsPf6wPOW6TnOQjFamJon7viBIklUlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc9Ys5OVPN0G99JLsLJcXccv+dufaPggQ5Vj0USBOObXJjAopvawGWwxFjWolZV76lrdAeejamef+5P4mJG9z1LHtuehRQPkRY5MoMdtMbJQJRSXTynzxGyBIKYdhDSYyNT/zGSv2OfCTMQ+BXsqEe8GxpWiI124aHoyrrMRwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=QdGni1Nl; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4ThM2G0WTdzyRZ;
	Fri, 23 Feb 2024 21:25:10 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received:received; s=tu-postout21; t=1708719909; bh=t
	49cO6p/CTxhIsPf6wPOW6TnOQjFamJon7viBIklUlQ=; b=QdGni1Nl4b/VarWPf
	cOz9HAMhlhSMjGDP3FjegOY7o2/GGapmYxtmsDBEH2a0yhgSpIntNu5YD2vHg1go
	uT01paaGaeHyQMqyBLTMwH+dmpqJ9M3PFoHSnhdzWqKO/bbDRT+xnA2IoMWWxvgd
	kHizpe/D9caNtxT8mXa6UGEQgFen7GzpiDJT31LFwNdA2YEEvbPh4My+ksJpMHnJ
	S0Nn7PavlDh26T5d5PWFXovLQGSO+WXKVEXVYV+izkctRxpksvv7aNyNdl8jnyzE
	Uz7pyfhQzTPGkYVIfbI1bDP2QU8Ct9QFjevSjcoiBSlAS6SDJjELjkYZ/mdrhN35
	XFTUA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.882
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
	by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id nRFE3cd62g-f; Fri, 23 Feb 2024 21:25:09 +0100 (CET)
Received: from pine (unknown [IPv6:2001:a61:2510:5501:544b:4b32:4119:3827])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4ThM2D07zKzych;
	Fri, 23 Feb 2024 21:25:07 +0100 (CET)
Date: Fri, 23 Feb 2024 21:25:04 +0100
From: Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, vincenzo.frascino@arm.com, ryabinin.a.a@gmail.com, 
	mark.rutland@arm.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	andreyknvl@gmail.com
Subject: Re: [merged mm-stable] kasan-add-atomic-tests.patch removed from -mm
 tree
Message-ID: <xk3hvszpeg3ttyexcm5s7ztj64nx5gxfwp6ivmobvfzogqjwn4@wicwiqm4bw7z>
References: <20240222000304.8FA56C43390@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222000304.8FA56C43390@smtp.kernel.org>

On 21.02.2024 16:03, Andrew Morton wrote:
> 
> The quilt patch titled
>      Subject: kasan: add atomic tests
> has been removed from the -mm tree.  Its filename was
>      kasan-add-atomic-tests.patch
> 
> This patch was dropped because it was merged into the mm-stable branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> ------------------------------------------------------
> From: Paul Heidekr??ger <paul.heidekrueger@tum.de>
> Subject: kasan: add atomic tests
> Date: Fri, 2 Feb 2024 11:32:59 +0000
> 
> Test that KASan can detect some unsafe atomic accesses.
> 
> As discussed in the linked thread below, these tests attempt to cover
> the most common uses of atomics and, therefore, aren't exhaustive.
> 
> Link: https://lkml.kernel.org/r/20240202113259.3045705-1-paul.heidekrueger@tum.de
> Link: https://lore.kernel.org/all/20240131210041.686657-1-paul.heidekrueger@tum.de/T/#u
> Signed-off-by: Paul Heidekr??ger <paul.heidekrueger@tum.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214055
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/kasan/kasan_test.c |   79 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> --- a/mm/kasan/kasan_test.c~kasan-add-atomic-tests
> +++ a/mm/kasan/kasan_test.c
> @@ -697,6 +697,84 @@ static void kmalloc_uaf3(struct kunit *t
>  	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[8]);
>  }
>  
> +static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
> +{
> +	int *i_unsafe = (int *)unsafe;
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_set(unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_and(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_andnot(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_or(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_xor(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_xchg(unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_cmpxchg(unsafe, 21, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(unsafe, safe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub_and_test(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_and_test(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_and_test(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_negative(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 21, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsafe));
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_read(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_set(unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_and(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_andnot(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_or(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xor(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xchg(unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_cmpxchg(unsafe, 21, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(unsafe, safe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(safe, unsafe, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub_and_test(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_and_test(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_and_test(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_negative(42, unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_unless(unsafe, 21, 42));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_not_zero(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_unless_negative(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_unless_positive(unsafe));
> +	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_if_positive(unsafe));
> +}
> +
> +static void kasan_atomics(struct kunit *test)
> +{
> +	void *a1, *a2;
> +
> +	/*
> +	 * Just as with kasan_bitops_tags(), we allocate 48 bytes of memory such
> +	 * that the following 16 bytes will make up the redzone.
> +	 */
> +	a1 = kzalloc(48, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> +	a2 = kzalloc(sizeof(int), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a1);
> +
> +	/* Use atomics to access the redzone. */
> +	kasan_atomics_helper(test, a1 + 48, a2);
> +
> +	kfree(a1);
> +	kfree(a2);
> +}
> +
>  static void kmalloc_double_kzfree(struct kunit *test)
>  {
>  	char *ptr;
> @@ -1883,6 +1961,7 @@ static struct kunit_case kasan_kunit_tes
>  	KUNIT_CASE(kasan_strings),
>  	KUNIT_CASE(kasan_bitops_generic),
>  	KUNIT_CASE(kasan_bitops_tags),
> +	KUNIT_CASE(kasan_atomics),
>  	KUNIT_CASE(vmalloc_helpers_tags),
>  	KUNIT_CASE(vmalloc_oob),
>  	KUNIT_CASE(vmap_tags),
> _
> 
> Patches currently in -mm which might be from paul.heidekrueger@tum.de are
> 
> 

Hi Andrew!

There was further discussion around this patch [1], which led to a v3 of the 
above patch but might have gotten lost in the wave of emails.

I'm unsure what the protocol is now; do I send you a new patch for the diff 
between the above patch and the v3 patch, or can you just use v3 instead of the 
above patch?

I hope this doesn't cause too much trouble.

Many thanks,
Paul

[1]: 
https://lore.kernel.org/all/20240212083342.3075850-1-paul.heidekrueger@tum.de/


