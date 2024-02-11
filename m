Return-Path: <linux-kernel+bounces-60723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093AE8508E5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871EB1F24382
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A35A79C;
	Sun, 11 Feb 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WEWkgLzT"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAB59B45
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707652825; cv=none; b=VZEbJykH8/YLVxQE1YQvurCJC+tpFKU9mTIXRLv8lEIsYDq2kl2OM65oDpoS1Qh2+MUkMwl5FPkfb5ZfPKH0nAEvsz+WNWIG5R+7xKKU2rYylFox27KAiJWZwrJDXZgD8e5VBy5V8Jio3oVxzTc5tizrx0TPYxz1cNOLhUQN5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707652825; c=relaxed/simple;
	bh=00844YnDiDUCr6GR7O4vuTISUvZJowhON94w/T3cxQY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rrN6vb68/l9EdkND1mbGWxZTvmD/iLzvmWa9GEp+WWL2u4dWImWV7cd5WPFFcxbrxZlPr1fRliUf2ZZz81SP5ymAefoQhyDiIHNFwXCOvClCQrohgcZpP3DoktwKY6cpN0QrBeJz8pDTOnootF68flE8OofvFFuuFAIyE1Yayl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WEWkgLzT; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707652819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8wXdzn32T3TYnA69lV6dr84btEZMVbKEiNErXespLU=;
	b=WEWkgLzTXvJvXP2mYx5pe/8gHS7LDBx+IjJ6E3RVnvtP8I3sOWhuiho9/ARN3Wg5FW2PZo
	XWwIZb+618Sh1bBdk0LUrQr9o8lzVLEBch8Qa75fca6+Du4ZuH19OnqXF2NfrOJ3UoMbUa
	vLVDbEHhWQZSdp38s+f4CMDcjJwamTs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ZcT4DH7VE1XLBvVc@casper.infradead.org>
Date: Sun, 11 Feb 2024 19:59:40 +0800
Cc: Jane Chu <jane.chu@oracle.com>,
 Will Deacon <will@kernel.org>,
 Nanyong Sun <sunnanyong@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 akpm@linux-foundation.org,
 anshuman.khandual@arm.com,
 wangkefeng.wang@huawei.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: 7bit
Message-Id: <917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <20240207121125.GA22234@willie-the-truck>
 <ZcOQ-0pzA16AEbct@casper.infradead.org>
 <908066c7-b749-4f95-b006-ce9b5bd1a909@oracle.com>
 <ZcT4DH7VE1XLBvVc@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Migadu-Flow: FLOW_OUT



> On Feb 8, 2024, at 23:49, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Wed, Feb 07, 2024 at 06:24:52PM -0800, Jane Chu wrote:
>> On 2/7/2024 6:17 AM, Matthew Wilcox wrote:
>>> While this array of ~512 pages have been allocated to hugetlbfs, and one
>>> would think that there would be no way that there could still be
>>> references to them, another CPU can have a pointer to this struct page
>>> (eg attempting a speculative page cache reference or
>>> get_user_pages_fast()).  That means it will try to call
>>> atomic_add_unless(&page->_refcount, 1, 0);
>>> 
>>> Actually, I wonder if this isn't a problem on x86 too?  Do we need to
>>> explicitly go through an RCU grace period before freeing the pages
>>> for use by somebody else?
>>> 
>> Sorry, not sure what I'm missing, please help.
> 
> Having written out the analysis, I now think it can't happen on x86,
> but let's walk through it because it's non-obvious (and I think it
> illustrates what people are afraid of on Arm).
> 
> CPU A calls either get_user_pages_fast() or __filemap_get_folio().
> Let's do the latter this time.
> 
>        folio = filemap_get_entry(mapping, index);
> filemap_get_entry:
>        rcu_read_lock();
>        folio = xas_load(&xas);
>        if (!folio_try_get_rcu(folio))
>                goto repeat;
>        if (unlikely(folio != xas_reload(&xas))) {
>                folio_put(folio);
>                goto repeat;
>        }
> folio_try_get_rcu:
>        folio_ref_try_add_rcu(folio, 1);
> folio_ref_try_add_rcu:
>        if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
>                /* Either the folio has been freed, or will be freed. */
>                return false;
> folio_ref_add_unless:
>        return page_ref_add_unless(&folio->page, nr, u);
> page_ref_add_unless:
>        atomic_add_unless(&page->_refcount, nr, u);
> 
> A rather deep callchain there, but for our purposes the important part
> is: we take the RCU read lock, we look up a folio, we increment its
> refcount if it's not zero, then check that looking up this index gets
> the same folio; if it doesn't, we decrement the refcount again and retry
> the lookup.
> 
> For this analysis, we can be preempted at any point after we've got the
> folio pointer from xa_load().
> 
>> From hugetlb allocation perspective,  one of the scenarios is run time
>> hugetlb page allocation (say 2M pages), starting from the buddy allocator
>> returns compound pages, then the head page is set to frozen, then the
>> folio(compound pages) is put thru the HVO process, one of which is
>> vmemmap_split_pmd() in case a vmemmap page is a PMD page.
>> 
>> Until the HVO process completes, none of the vmemmap represented pages are
>> available to any threads, so what are the causes for IRQ threads to access
>> their vmemmap pages?
> 
> Yup, this sounds like enough, but it's not.  The problem is the person
> who's looking up the folio in the pagecache under RCU.  They've got
> the folio pointer and have been preempted.  So now what happens to our
> victim folio?
> 
> Something happens to remove it from the page cache.  Maybe the file is
> truncated, perhaps vmscan comes along and kicks it out.  Either way, it's
> removed from the xarray and gets its refcount set to 0.  If the lookup
> were to continue at this time, everything would be fine because it would
> see a refcount of 0 and not increment it (in page_ref_add_unless()).
> And this is where my analysis of RCU tends to go wrong, because I only
> think of interleaving event A and B.  I don't think about B and then C
> happening before A resumes.  But it can!  Let's follow the journey of
> this struct page.
> 
> Now that it's been removed from the page cache, it's allocated by hugetlb,
> as you describe.  And it's one of the tail pages towards the end of
> the 512 contiguous struct pages.  That means that we alter vmemmap so
> that the pointer to struct page now points to a different struct page
> (one of the earlier ones).  Then the original page of vmemmap containing
> our lucky struct page is returned to the page allocator.  At this point,
> it no longer contains struct pages; it can contain literally anything.
> 
> Where my analysis went wrong was that CPU A _no longer has a pointer
> to it_.  CPU A has a pointer into vmemmap.  So it will access the
> replacement struct page (which definitely has a refcount 0) instead of
> the one which has been freed.  I had thought that CPU A would access the
> original memory which has now been allocated to someone else.  But no,
> it can't because its pointer is virtual, not physical.
> 
> 
> ---
> 
> Now I'm thinking more about this and there's another scenario which I
> thought might go wrong, and doesn't.  For 7 of the 512 pages which are
> freed, the struct page pointer gathered by CPU A will not point to a
> page with a refcount of 0.  Instead it will point to an alias of the
> head page with a positive refcount.  For those pages, CPU A will see
> folio_try_get_rcu() succeed.  Then it will call xas_reload() and see
> the folio isn't there any more, so it will call folio_put() on something
> which used to be a folio, and isn't any more.
> 
> But folio_put() calls folio_put_testzero() which calls put_page_testzero()
> without asserting that the pointer is actually to a folio.
> So everything's fine, but really only by coincidence; I don't think
> anybody's thought about this scenario before (maybe Muchun has, but I
> don't remember it being discussed).

I have to say it is a really great analysis, I haven't thought about the
case of get_page_unless_zero() so deeply.

To avoid increasing a refcount to a tail page struct, I have made
all the 7 tail pages read-only when I first write those code. But it
is a really problem, because it will panic (due to RO permission)
when encountering the above scenario to increase its refcount.

In order to fix the race with __filemap_get_folio(), my first
thought of fixing this issue is to add a rcu_synchronize() after
the processing of HVO optimization and before being allocated to
users. Note that HugePage pages are frozen before going through
the precessing of HVO optimization meaning all the refcount of all
the struct pages are 0. Therefore, folio_try_get_rcu() in
__filemap_get_folio() will fail unless the HugeTLB page has been
allocated to the user.

But I realized there are some users who may pass a arbitrary
page struct (which may be those 7 special tail page structs,
alias of the head page struct, of a HugeTLB page) to the following
helpers, which also could get a refcount of a tail page struct.
Those helpers also need to be fixed.

  1) get_page_unless_zero
  2) folio_try_get
  3) folio_try_get_rcu

I have checked all the users of 1), If I am not wrong, all the users
already handle the HugeTLB pages before calling to get_page_unless_zero().
Although there is no problem with 1) now, it will be fragile to let users
guarantee that it will not pass any tail pages of a HugeTLB page to
1). So I want to change 1) to the following to fix this.

	static inline bool get_page_unless_zero(struct page *page)
	{
		if (page_ref_add_unless(page, 1, 0)) {
			/* @page must be a genuine head or alias head page here. */
			struct page *head = page_fixed_fake_head(page);

			if (likely(head == page))
				return true;
			put_page(head);
		}

		return false;
	}

2) and 3) should adopt the similar approach to make sure we cannot increase
tail pages' refcount. 2) and 3) will be like the following (only demonstrate
the key logic):

	static inline bool folio_try_get(struct folio *folio)/folio_ref_try_add_rcu
	{
		if (folio_ref_add_unless(folio, 1, 0)) {
			struct folio *genuine = page_folio(&folio->page);

			if (likely(genuine == folio))
				return true;
			folio_put(genuine);
		}

		return false;
	}

Additionally, we also should alter RO permission of those 7 tail pages
to RW to avoid panic().

There is no problem in the following helpers since all of them already
handle HVO case through _compound_head(), they will get the __genuine__
head page struct and increase its refcount.

  1) try_get_page
  2) folio_get
  3) get_page

Just some thoughts from mine, maybe you guys have more simple and graceful
approaches. Comments are welcome.

Muchun,
Thanks.


