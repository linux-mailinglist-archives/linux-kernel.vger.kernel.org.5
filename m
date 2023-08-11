Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757AD77925A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjHKPEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHKPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43672124
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691766206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUfn2yRxDKKinH9zdb9JbhnFsj88xeOeJ1clvcuNk24=;
        b=hAruQau9O6rFtv6nMF2YagcNzB72Jc5NIQ42G4E/A67F58csy5ILK9be7KkqDh1wmUSHPx
        duXvoizVh6V1roQ8HPzeyxuoBr0+4hHgEWlWN1FpCBwVoyloLdFehIn01ZOBOIXMbVHKYS
        +RTa1dvFyVFzhmwDJUZ1tH1KR2E1Tds=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-OxmXcY8gNtmmmiBkSZ7NNg-1; Fri, 11 Aug 2023 11:03:25 -0400
X-MC-Unique: OxmXcY8gNtmmmiBkSZ7NNg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76d06c4257bso49796285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766205; x=1692371005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUfn2yRxDKKinH9zdb9JbhnFsj88xeOeJ1clvcuNk24=;
        b=iP0WZfrTvpLSKWWoN4XyUWdM/n43obJOKPVSIKt/+YFmdrOV4MA0XCdLJl2k3FZTTn
         EV9X+GQsB/Nf1oYex/BMfIUXUK+WJwuKgcq3F6anrqSRoj/HUDTl8+diL7MMUEwU3VVU
         HsJnVVjMcjUFJZZ4NHRfgT/sRBATSHoxoxF84dkmC+uWEJyqcbi6cuunn+B3yyTmNs9V
         GL2YeAulnNzXk88z7F3ireLmOYuc1Tsw35Qv8rC60rIL1S26VK6C6/SNTxtqGHzLHAkf
         eyrJUKMC6/KR8mK/Pcu0G9q9dvSxrKp8PuwMsEloTabfqhn0C4lQiHemWSGZ8FD0MwUZ
         paSQ==
X-Gm-Message-State: AOJu0YxrV7TYCdDhfTgBTy4rZcROi0ZnXYidbnIY8q4kh8/CfX0CmU7I
        aMDElA4m3kucBhQjJC+24PHzIsIqY3FDK4jMss+bIBtBmETH9+x67nFBQTj1NtuWUhXPMM8QfSc
        hh4yGEwFo3Cwmr6kNrmsnRuj7
X-Received: by 2002:a05:620a:1914:b0:76c:e76b:4192 with SMTP id bj20-20020a05620a191400b0076ce76b4192mr2509974qkb.0.1691766204696;
        Fri, 11 Aug 2023 08:03:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElkIDda5pJfgdjDlpX1qemYlXQScA3leBwo8YPETDmV4jI/g/VWmSele5L1o3V/7C8717Izw==
X-Received: by 2002:a05:620a:1914:b0:76c:e76b:4192 with SMTP id bj20-20020a05620a191400b0076ce76b4192mr2509905qkb.0.1691766204124;
        Fri, 11 Aug 2023 08:03:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id q29-20020a05620a039d00b0076c96e571f3sm1241719qkm.26.2023.08.11.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:03:23 -0700 (PDT)
Date:   Fri, 11 Aug 2023 11:03:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNZNuooaFH9P4raS@x1n>
References: <20230809083256.699513-1-david@redhat.com>
 <ZNQD4pxo8svpGmvX@x1n>
 <ZNRYx8GhYftE4Xeb@casper.infradead.org>
 <7e31254d-8889-7e79-50e1-2630bd493d59@redhat.com>
 <ZNVbIyHcqeKUDuSg@x1n>
 <ZNVcfdH8+N5Q83J/@casper.infradead.org>
 <73d6d29f-9947-9b50-3b94-77f1ee547387@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73d6d29f-9947-9b50-3b94-77f1ee547387@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:59:25PM +0200, David Hildenbrand wrote:
> On 10.08.23 23:54, Matthew Wilcox wrote:
> > On Thu, Aug 10, 2023 at 05:48:19PM -0400, Peter Xu wrote:
> > > > Yes, that comment from Hugh primarily discusses how we could possibly
> > > > optimize the loop, and if relying on folio_nr_pages_mapped() to reduce the
> > > > iterations would be racy. As far as I can see, there are cases where "it
> > > > would be certainly a bad idea" :)
> > > 
> > > Is the race described about mapcount being changed right after it's read?
> > > Are you aware of anything specific that will be broken, and will be fixed
> > > with this patch?
> > 
> > The problem is that people check the mapcount while holding no locks;
> > not the PTL, not the page lock.  So it's an unfixable race.
> > 
> > > Having a total mapcount does sound helpful if partial folio is common
> > > indeed.
> > > 
> > > I'm curious whether that'll be so common after the large anon folio work -
> > > isn't it be sad if partial folio will be a norm?  It sounds to me that's
> > > the case when small page sizes should be used.. and it's prone to waste?
> > 
> > The problem is that entire_mapcount isn't really entire_mapcount.
> > It's pmd_mapcount.  I have had thoughts about using it as entire_mapcount,
> > but it gets gnarly when people do partial unmaps.  So the _usual_ case
> > ends up touching every struct page.  Which sucks.  Also it's one of the
> > things which stands in the way of shrinking struct page.
> 
> Right, so one current idea is to have a single total_mapcount and look into
> removing the subpage mapcounts (which will require first removing
> _nr_pages_mapped, because that's still one of the important users).
> 
> Until we get there, also rmap code has to do eventually "more tracking" and
> might, unfortunately, end up slower.
> 
> > 
> > But it's kind of annoying to explain all of this to you individually.
> > There have been hundreds of emails about it over the last months on
> > this mailing list.  It would be nice if you could catch up instead of
> > jumping in.
> 
> To be fair, a lot of the details are not readily available and in the heads
> of selected people :)
> 
> Peter, if you're interested, we can discuss the current plans, issues and
> ideas offline!

Thanks for offering help, David.

Personally I still am unclear yet on why entire_mapcount cannot be used as
full-folio mapcounts, and why "partial unmap" can happen a lot (I don't
expect), but yeah I can try to catch up to educate myself first.

The only issue regarding an offline sync-up is that even if David will help
Peter on catching up the bits, it'll not scale when another Peter2 had the
same question..  So David, rather than I waste your time on helping one
person, let me try to catch up with the public threads - I'm not sure how
far I can go myself; otoh thread links will definitely be helpful to be
replied here, so anyone else can reference too.  I collected a list (which
can be enriched) of few threads that might be related, just in case helpful
to anyone besides myself:

[PATCH 0/2] don't use mapcount() to check large folio sharing
https://lore.kernel.org/r/20230728161356.1784568-1-fengwei.yin@intel.com

[PATCH v1-v2 0/3] support large folio for mlock
https://lore.kernel.org/r/20230728070929.2487065-1-fengwei.yin@intel.com
https://lore.kernel.org/r/20230809061105.3369958-1-fengwei.yin@intel.com

[PATCH v1 0/4] Optimize mmap_exit for large folios
https://lore.kernel.org/r/20230810103332.3062143-1-ryan.roberts@arm.com

[PATCH v4-v5 0/5] variable-order, large folios for anonymous memory
https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.roberts@arm.com/
https://lore.kernel.org/r/20230810142942.3169679-1-ryan.roberts@arm.com

[PATCH v3-v4 0/3] Optimize large folio interaction with deferred split
(I assumed Ryan's this one goes into the previous set v5 finally, so just
 the discussions as reference)
https://lore.kernel.org/r/20230720112955.643283-1-ryan.roberts@arm.com
https://lore.kernel.org/r/20230727141837.3386072-1-ryan.roberts@arm.com

[RFC PATCH v2 0/4] fix large folio for madvise_cold_or_pageout()
https://lore.kernel.org/r/20230721094043.2506691-1-fengwei.yin@intel.com

I'm not sure how far I'll go; maybe I'll start working on something else
before I finish all of them.  I'll see..

Not allowing people to jump in will definitely cause less interactions and
less involvement/open-ness for the mm community, as sometimes people can't
easily judge when it's proper to jump in.

IMHO the ideal solution is always keep all discussions public (either
meetings with recordings, or shared online documents, always use on-list
discussions, etc.), then share the links.

-- 
Peter Xu

