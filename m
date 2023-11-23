Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A807F67C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjKWTqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:46:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C58DD47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700768813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/x0+ehpuka6vaGTVf1NB1DVm2JcgVurz702wP4rKKMc=;
        b=QzAYerPW43t4fJjMBNKce+5LQxjAqzuk5ueqIdOhAnNnhC37tjfZjdP5YI5bjAxSdRg0nn
        1pbvgegWHRYD5pX2KHBM1xMr5KiUqQIZlC9DnlrLgcUtpw9xs5wUYKtzHxN+kTxlVzB/Qo
        lstFvop9BphL2UlWiyvbMm14kPuz2kI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-26MA958aN6OVmDXVv-iRmg-1; Thu, 23 Nov 2023 14:46:52 -0500
X-MC-Unique: 26MA958aN6OVmDXVv-iRmg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-679d8383224so2916376d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700768812; x=1701373612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x0+ehpuka6vaGTVf1NB1DVm2JcgVurz702wP4rKKMc=;
        b=ny6jGhq/VTJLnCIQUcrXmmb+JGeoq34BAFXML6pS1t6CpnHDklchGILJqXlooitRbg
         6RNU0SfE+gntkg23cfnI5Gu+E2tINlab8reXN6P1UqJgeXQELXr7T8+eOPxqACjUkD+W
         GNyLWW76rkNaLJecsVKuQ0cxD1Hrb8F6tBTq41WUzL/EcTZ25RTGNrZB54gI+e5LEi4l
         d1C323+1genhowAN5G7Ue4opqTLJUGou/2gakHhBAdGeJoptkdJYGYyLOjERqfHjmALA
         ixvCUIjUH1vaUfzeDKjOIAma40uf3l3UsH0u4bIOlRc9Qyx8/eEczZ4cynhHo8xA1KlK
         n7dQ==
X-Gm-Message-State: AOJu0Yz8hnfaPtTsAgU3SThf+zKNbwaztEPinevIJGluCcBMBv7aYEa2
        2Qo2FdBK5hUxvNPzHaQcAZrDvkdYWnoIT/BQTORvW7vuT9iUHtweCYorU3qR/tNXh2YwqRJ97sT
        Z/n0Jp9GDM+gqrFrF7QEbn6c+
X-Received: by 2002:a05:6214:5845:b0:679:d92e:3915 with SMTP id ml5-20020a056214584500b00679d92e3915mr481404qvb.6.1700768811697;
        Thu, 23 Nov 2023 11:46:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzBI31IcH5oeMakKOYAtr+L45e77XcNn9sZZWA3VceZj7679x6/xkQISZE37o50DvBfsjvDg==
X-Received: by 2002:a05:6214:5845:b0:679:d92e:3915 with SMTP id ml5-20020a056214584500b00679d92e3915mr481383qvb.6.1700768811422;
        Thu, 23 Nov 2023 11:46:51 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a131500b0076cda7eab11sm663606qkj.133.2023.11.23.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 11:46:50 -0800 (PST)
Date:   Thu, 23 Nov 2023 14:46:46 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZV-sJsdFfXiCkylv@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
 <ZV90JcnQ1RGud/0R@casper.infradead.org>
 <ZV-KQ0e0y9BTsHGv@x1n>
 <d2313c1d-1e50-49b7-bed7-840431af799a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2313c1d-1e50-49b7-bed7-840431af799a@arm.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 07:11:19PM +0000, Ryan Roberts wrote:
> Hi,
> 
> I'm not sure I've 100% understood the crossover between this series and my work
> to support arm64's contpte mappings generally for anonymous and file-backed memory.

No worry, there's no confliction.  If you worked on that it's only be
something nice on top.  Also, I'm curious if you have performance numbers,
because I'm going to do some test for hugetlb cont_ptes (which is only the
current plan), and if you got those it'll be a great baseline for me,
because it should be similar in you case even though the goal is slightly
different.

> 
> My approach is to transparently use contpte mappings when core-mm request pte
> mappings that meet the requirements; and its all based around intercepting the
> normal (non-hugetlb) helpers (e.g. set_ptes(), ptep_get() and friends). There is
> no semantic change to the core-mm. See [1]. It relies on 1) the page cache using
> large folios and 2) my "small-sized THP" series which starts using arbitrary
> sized large folios for anonymous memory [2].
> 
> If I've understood this conversation correctly there is an object called hugepd,
> which today is only supported by powerpc, but which could allow the core-mm to
> control the mapping granularity? I can see some value in exposing that control
> to core-mm in the (very) long term.

For me it's needed immediately, because hugetlb_follow_page_mask() will be
gone after the last patch.

> 
> [1] https://lore.kernel.org/all/20231115163018.1303287-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/linux-mm/20231115132734.931023-1-ryan.roberts@arm.com/

AFAICT you haven't yet worked on gup then, after I glimpsed the above
series.

It's a matter of whether one follow_page_mask() call can fetch more than
one page* for a cont_pte entry on aarch64 for a large non-hugetlb folio
(and if this series lands, it'll be the same to hugetlb or non-hugetlb).
Now the current code can only fetch one page I think.

Thanks,

-- 
Peter Xu

