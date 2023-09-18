Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8327A4B76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjIRPQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjIRPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:16:47 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9BFE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:16:39 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c0f2addaefso2614302a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695050198; x=1695654998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFs3nj+bJKwYJ1k9TrPfAOIb/ef9SteUtb45Y7MG8pg=;
        b=MPSbvqy8x8xxCHyCNXUZvY+YikmbM46B2wkjRwxzv4T8ShiXYcIkcXjdbvhvGj5nR3
         xmK/s5AUc4EjKC8++BMCYtWA56gZxo0nR68z6NkFZiXh2X8W8EgmXon7n1YPo5OqUMQd
         hXFOEbQYJJQAhmH8jRS8NkBrJ7RA5SbnvRqN6bA0qQsaHRsK+F0pMO72EolROVHw4BGQ
         vLBubOeTjvhkQ2UOYTd+B5qMM6+QC3Rqb+UHvdN9U2mYAx5AF6zUxsYlbmOsctyn8S/k
         1RDirCK/KuBit/wnW4UBr30Xi9oBBmdzppU4drqFTUI0E206IkTI6x6z5zQ/AwCr8VaV
         M0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050198; x=1695654998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFs3nj+bJKwYJ1k9TrPfAOIb/ef9SteUtb45Y7MG8pg=;
        b=d8u2alnk2/YTLS2WhNbE+M7DEqDWZF2GuEsEyu4WyM+Bk0uRUSRjwee1bBDzIVrHU6
         dmEFRH+us3Hu49uz5E85ZBI1v7+pwav/QChIAdzKrFouKNO29bXaCzqQ8MZJf2jhow/2
         nLIIOb88eL3Ij7P9cWEZ/LwfwvYX7eGpg9Ve+aV1l7z9dRujXLs30mrdEjZkyUt8giKk
         kUe8UVjm5gPfPjqWyeuSaf413i+lBZNm8p7DRcjfmkr4JRhyATlI5uF7HJMzC+fsPaVd
         qMBcccKwbr2H2jW1AsyRFUtB9khemx1UwToLbLBWAEM3im9jMvNg33bxSYue1kSksNnZ
         mP1A==
X-Gm-Message-State: AOJu0YyrDkOW8e3/yhq3mMoyKB83E64orWXjD4tDT/oCijYGqjMjbJ4x
        Plfy1/d2BB8aA8jgxQHj/BEitWHKBtwzm28FKiQ=
X-Google-Smtp-Source: AGHT+IF3jtg8NLpTHvdIGldilcSYWHIqFKGmN6Qp8wfIv9FDYxzi3jhUfsDf9apGMfwbe5hgtp6ovg==
X-Received: by 2002:a05:620a:14b1:b0:76e:f804:1532 with SMTP id x17-20020a05620a14b100b0076ef8041532mr8344556qkj.33.1695048725319;
        Mon, 18 Sep 2023 07:52:05 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b0077263636a95sm3184889qkj.93.2023.09.18.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:52:04 -0700 (PDT)
Date:   Mon, 18 Sep 2023 10:52:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230918145204.GB16104@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey>
 <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 09:16:58AM +0200, Vlastimil Babka wrote:
> On 9/16/23 21:57, Mike Kravetz wrote:
> > On 09/15/23 10:16, Johannes Weiner wrote:
> >> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
> >> > In next-20230913, I started hitting the following BUG.  Seems related
> >> > to this series.  And, if series is reverted I do not see the BUG.
> >> > 
> >> > I can easily reproduce on a small 16G VM.  kernel command line contains
> >> > "hugetlb_free_vmemmap=on hugetlb_cma=4G".  Then run the script,
> >> > while true; do
> >> >  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> >> >  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
> >> >  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> >> > done
> >> > 
> >> > For the BUG below I believe it was the first (or second) 1G page creation from
> >> > CMA that triggered:  cma_alloc of 1G.
> >> > 
> >> > Sorry, have not looked deeper into the issue.
> >> 
> >> Thanks for the report, and sorry about the breakage!
> >> 
> >> I was scratching my head at this:
> >> 
> >>                         /* MIGRATE_ISOLATE page should not go to pcplists */
> >>                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> >> 
> >> because there is nothing in page isolation that prevents setting
> >> MIGRATE_ISOLATE on something that's on the pcplist already. So why
> >> didn't this trigger before already?
> >> 
> >> Then it clicked: it used to only check the *pcpmigratetype* determined
> >> by free_unref_page(), which of course mustn't be MIGRATE_ISOLATE.
> >> 
> >> Pages that get isolated while *already* on the pcplist are fine, and
> >> are handled properly:
> >> 
> >>                         mt = get_pcppage_migratetype(page);
> >> 
> >>                         /* MIGRATE_ISOLATE page should not go to pcplists */
> >>                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> >> 
> >>                         /* Pageblock could have been isolated meanwhile */
> >>                         if (unlikely(isolated_pageblocks))
> >>                                 mt = get_pageblock_migratetype(page);
> >> 
> >> So this was purely a sanity check against the pcpmigratetype cache
> >> operations. With that gone, we can remove it.
> > 
> > With the patch below applied, a slightly different workload triggers the
> > following warnings.  It seems related, and appears to go away when
> > reverting the series.
> > 
> > [  331.595382] ------------[ cut here ]------------
> > [  331.596665] page type is 5, passed migratetype is 1 (nr=512)
> > [  331.598121] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:662 expand+0x1c9/0x200
> 
> Initially I thought this demonstrates the possible race I was suggesting in
> reply to 6/6. But, assuming you have CONFIG_CMA, page type 5 is cma and we
> are trying to get a MOVABLE page from a CMA page block, which is something
> that's normally done and the pageblock stays CMA. So yeah if the warnings
> are to stay, they need to handle this case. Maybe the same can happen with
> HIGHATOMIC blocks?

Hm I don't think that's quite it.

CMA and HIGHATOMIC have their own freelists. When MOVABLE requests dip
into CMA and HIGHATOMIC, we explicitly pass that migratetype to
__rmqueue_smallest(). This takes a chunk of e.g. CMA, expands the
remainder to the CMA freelist, then returns the page. While you get a
different mt than requested, the freelist typing should be consistent.

In this splat, the migratetype passed to __rmqueue_smallest() is
MOVABLE. There is no preceding warning from del_page_from_freelist()
(Mike, correct me if I'm wrong), so we got a confirmed MOVABLE
order-10 block from the MOVABLE list. So far so good. However, when we
expand() the order-9 tail of this block to the MOVABLE list, it warns
that its pageblock type is CMA.

This means we have an order-10 page where one half is MOVABLE and the
other is CMA.

I don't see how the merging code in __free_one_page() could have done
that. The CMA buddy would have failed the migrate_is_mergeable() test
and we should have left it at order-9s.

I also don't see how the CMA setup could have done this because
MIGRATE_CMA is set on the range before the pages are fed to the buddy.

Mike, could you describe the workload that is triggering this?

Does this reproduce instantly and reliably?

Is there high load on the system, or is it requesting the huge page
with not much else going on?

Do you see compact_* history in /proc/vmstat after this triggers?

Could you please also provide /proc/zoneinfo, /proc/pagetypeinfo and
the hugetlb_cma= parameter you're using?

Thanks!
