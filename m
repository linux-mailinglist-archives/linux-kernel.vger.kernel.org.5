Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3857FC46A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjK1TsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1TsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215610F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701200896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FI/qc+HoptbCAYRrip/l9UUtKZw1zfPxYz8AmPHyRKg=;
        b=Fi+bIioY3NP4ooyovpcc/j9g03fDA1SUBg10otdLxsHSe5P9YeeYnZRhXai845Ew/bIagv
        j0TqN5UCPBVj8Oi6OAF50MdjgJKFgzfvttXU500AKhKPDqJZ5D4puX+tg+cSZe+3NSA9EB
        HrYVuBFgf/TODFMwY7Jk/vNZqX3lBms=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-GoDNkV6INrGiBTSlsUXSbw-1; Tue, 28 Nov 2023 14:48:14 -0500
X-MC-Unique: GoDNkV6INrGiBTSlsUXSbw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77d8df7c8e2so70491385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701200894; x=1701805694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI/qc+HoptbCAYRrip/l9UUtKZw1zfPxYz8AmPHyRKg=;
        b=jcKvEt0XG/LM0voOeri253OR1wbkbvkQxnppI2zxWetzCx+J3N63rYiQS4q6a3eooV
         eplBf/i/jOCyUwg74RTPIHi/bjMhbzuS7A5O84SRU8u8HmQP8a/5J9mxRCsP+xa/TYY3
         Qc4k2ZXHjyl5pIUEq7NjsSlq8nrjhxOiAnmsyf38DUCL9KMkpISb7luNlli4xU0D1Ibx
         DY8AamcbV9uY3XCrnCZnUaOuw3wx/qCPJrFfFqoxKpCzUpFZFG85ORtpeyjEbExqMHUm
         JnusOVj6yhZ8tJZwPvOE1QAeOEjXc0MsHSSUEvM/mCwIYvWVUlozfaj4K+SA2dthQ5GH
         Um/w==
X-Gm-Message-State: AOJu0Yy44NX6qnnelIyGXXsWujwo0McJN1iQta4g9BW8V1G5iSaPVMJn
        Y0MYeo+MiAT7N3LhDLnbVdwRscCyI6IFNyvXVVn3ovyE3T/dcMKRha9h3qYySbitE4LuEQEJflX
        GH/lhMXzZPbMBAsfxD64T+FQg
X-Received: by 2002:a05:620a:19a9:b0:773:a8d0:b326 with SMTP id bm41-20020a05620a19a900b00773a8d0b326mr19136520qkb.4.1701200894203;
        Tue, 28 Nov 2023 11:48:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnmfMd1Af6MOd9MBrYMBFGfGQ+U2yn2nxKjVFjmVJPni5vvpTbDhcwoD5Rcmq6sbu5MsnF9w==
X-Received: by 2002:a05:620a:19a9:b0:773:a8d0:b326 with SMTP id bm41-20020a05620a19a900b00773a8d0b326mr19136510qkb.4.1701200893900;
        Tue, 28 Nov 2023 11:48:13 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b0076efaec147csm4729883qkk.45.2023.11.28.11.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:48:13 -0800 (PST)
Date:   Tue, 28 Nov 2023 14:48:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 2/5] mm/rmap: introduce and use hugetlb_remove_rmap()
Message-ID: <ZWZD--hbxH9Pyx-4@x1n>
References: <20231128145205.215026-1-david@redhat.com>
 <20231128145205.215026-3-david@redhat.com>
 <ZWYQeW1dqK6xM1T9@x1n>
 <f1b52042-646d-4679-b375-7550973701f5@redhat.com>
 <ZWYf0ZNF9OJgt-mt@x1n>
 <faf9ca16-ab0b-4ce9-a6e2-ea31842b213a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <faf9ca16-ab0b-4ce9-a6e2-ea31842b213a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 06:42:44PM +0100, David Hildenbrand wrote:
> On 28.11.23 18:13, Peter Xu wrote:
> > On Tue, Nov 28, 2023 at 05:39:35PM +0100, David Hildenbrand wrote:
> > > Quoting from the cover letter:
> > > 
> > > "We have hugetlb special-casing/checks in the callers in all cases either
> > > way already in place: it doesn't make too much sense to call generic-looking
> > > functions that end up doing hugetlb specific things from hugetlb
> > > special-cases."
> > 
> > I'll take this one as an example: I think one goal (of my understanding of
> > the mm community) is to make the generic looking functions keep being
> > generic, dropping any function named as "*hugetlb*" if possible one day
> > within that generic implementation.  I said that in my previous reply.
> 
> Yes, and I am one of the people asking for that. However, only where it
> makes sense (e.g., like page table walking, GUP as you said), and only when
> it is actually unified.
> 
> I don't think that rmap handling or fault handling will ever be completely
> unified to that extreme, and it might also not be desirable. Just like we
> have separate paths for anon and file in areas where they are reasonable
> different.

Yes I haven't check further in that direction, that'll be after the pgtable
work for me if that can first move on smoothly, and it'll also depend on
whether merging the pgtable changes would be good enough so that we can
move on to consider small mappings for hugetlb, until then we need to
settle a final mapcount solution for hugetlb.

> 
> What doesn't make sense is using patterns like:
> 
> 	page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
> 
> and then, inside page_remove_rmap() have an initial folio_test_hugetlb()
> check that does something completely different.

IIUC above "folio_test_hugetlb(folio)" pattern can become "false" for
hugetlb, if we decided to do mapcount for small hugetlb mappings.  If that
happens, I think something like this patch _may_ need to be reverted again
more or less. Or we start to copy some of page_remove_rmap() into the new
hugetlb rmap api.

> 
> So each and everyone calling page_remove_rmap (and knowing that it's
> certainly not a hugetlb folio) has to run through that check.

Note that right after this change applied, hugetlb already start to lose
something in common with generic compound folios, where page_remove_rmap()
had:

	VM_BUG_ON_PAGE(compound && !PageHead(page), page);

That sanity check goes away immediately for hugetlb, which is still
logically applicable.

> 
> Then, we have functions like page_add_file_rmap() that look like they can be
> used for hugetlb, but hugetlb is smart enough and only calls
> page_dup_file_rmap(), because it doesn't want to touch any file/anon
> counters. And to handle that we would have to add folio_test_hugetlb()
> inside there, which adds the same as above, trying to unify without
> unifying.
> 
> Once we're in the area of folio_add_file_rmap_range(), it all stops making
> sense, because there is no way we could possibly partially map a folio
> today. (and if we can in the future, we might still want separate handling,
> because most caller know with which pages they are dealing, below)
> 
> Last but not least, it's all inconsistent right now with
> hugetlb_add_anon_rmap()/hugetlb_add_new_anon_rmap() being there because they
> differ reasonably well from the "ordinary" counterparts.

Taking hugepage_add_new_anon_rmap() as example, IMHO they still share a lot
of things with !hugetlb codes, and maybe they can already be cleaned up
into something common for a large mapping:

void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
		unsigned long address)
{
	int nr;

	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);

        if (folio_is_hugetlb(folio)) {
                folio_clear_hugetlb_restore_reserve(folio);
        } else {
                __folio_set_swapbacked(folio);
		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
		nr = folio_nr_pages(folio);
		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
                __lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
        }

        /* increment count (starts at -1) */
        atomic_set(&folio->_entire_mapcount, 0);
	__folio_set_anon(folio, vma, address, true);
	SetPageAnonExclusive(&folio->page);
}

For folio_add_file_rmap_range(): would it work if it just pass the hugetlb
folio range into it?  Would that make it much more difficult with the
recent work on large folios from you or anyone?

> I don't think going in the other direction and e.g., removing
> hugetlb_add_anon_rmap / hugetlb_add_new_anon_rmap is making a unification
> that is not really reasonable. It will only make things slower and the
> individual functions more complicated.

IIUC so far the performance difference should be minimum on which helper to
use.

As I mentioned, I sincerely don't know whether this patch is good or not as
I don't know enough on everything around that is happening.  It's just that
I'll still think twice if to create hugetlb its own rmap API, because from
the high level it's going the other way round to me.  So I still want to
raise this as a pure question.

Thanks,

-- 
Peter Xu

