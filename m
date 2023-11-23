Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F567F653D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345334AbjKWRWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWRWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:22:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4EE1BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700760136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcpnTT0f+98xbE3/g5MCgDaaep2Eqio0fEdLtHv5RPs=;
        b=I8ZJ2h7AaT766iPN0geurxhX/0Yh+izuejW/FCC+aJu2yJntwYbkEXqSXRrM/gO5FWU6bf
        MMoiiCboQV59vlhm5BZlHs67ZYHbnsxB6/GEIEgTTYyC3VMY9YM/dL+0tjeETXT/TI9NH2
        AxMIO5oRThPwwt9qiKzBZUwjSpvCoEo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-N3Lxx3bJMVycVLX9aCDZ-g-1; Thu, 23 Nov 2023 12:22:14 -0500
X-MC-Unique: N3Lxx3bJMVycVLX9aCDZ-g-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-421be23b19aso2491471cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700760134; x=1701364934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcpnTT0f+98xbE3/g5MCgDaaep2Eqio0fEdLtHv5RPs=;
        b=il6fJrSnABFg3FJKuRBfohLD4xCllNVAVECFrkq1vHEgQeOCLQNvw7GwEQo9SqxJnd
         ssaL4Fjts++4qJf3Di6sb2cXqgfuIR9koxgY7aj4v8eIj6rsRLNImzN4rWbDg3shyDck
         NDkyYVAydV6KMTwJpI/f2i/toWaBke3qq3QC8ygkXxVjhRK2dKbTngKI2illke7G1EMA
         YmTaPA3eKXk4ZWxoDI4PlHjAaN2kAixmpCoaz1VRCVxPSvE1ngflRyinlw0d/2Xhf+PT
         mqvm4b4xXJVDbhAZTkmpWGEGC82tVNs1xXBSR/w9daeJibQyhvtB71ZbMI24kAvga4jX
         Pu+w==
X-Gm-Message-State: AOJu0YyZKEaP+SzxV9DZWtyCzHGaZvz37ec/guzbTooLthNRNhx5fn0s
        bTAFQ+7cRBIfmuTURJmt6AX5wcd1w8oCoieR7ufpBYFLclvxRX1raHQGcg8TX12sAJq7vau3lX1
        HSzc2Ho2WYoAAElsreFU0cc47
X-Received: by 2002:a05:6214:16cb:b0:66d:1178:8729 with SMTP id d11-20020a05621416cb00b0066d11788729mr210882qvz.0.1700760134477;
        Thu, 23 Nov 2023 09:22:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoctQeyyuLZxBsUdrKfoqF1pEVxywUQFLPrXNM10XRHBt/gv7otbSLqMQmESr9lBHxoHkzbA==
X-Received: by 2002:a05:6214:16cb:b0:66d:1178:8729 with SMTP id d11-20020a05621416cb00b0066d11788729mr210872qvz.0.1700760134200;
        Thu, 23 Nov 2023 09:22:14 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id x5-20020a0ce785000000b0067a0b48a4f9sm451474qvn.66.2023.11.23.09.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:22:13 -0800 (PST)
Date:   Thu, 23 Nov 2023 12:22:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZV-KQ0e0y9BTsHGv@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
 <ZV90JcnQ1RGud/0R@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV90JcnQ1RGud/0R@casper.infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 03:47:49PM +0000, Matthew Wilcox wrote:
> It looks like ARM (in the person of Ryan) are going to add support for
> something equivalent to hugepd.

If it's about arm's cont_pte, then it looks ideal because this series
didn't yet touch cont_pte, assuming it'll just work.  From that aspect, his
work may help mine, and no immediately collapsing either.

There can be a slight performance difference which I need to measure for
arm's cont_pte already for hugetlb, but I didn't worry much on that;
quotting my commit message in the last patch:

    There may be a slight difference of how the loops run when processing
    GUP over a large hugetlb range on either ARM64 (e.g. CONT_PMD) or RISCV
    (mostly its Svnapot extension on 64K huge pages): each loop of
    __get_user_pages() will resolve one pgtable entry with the patch
    applied, rather than relying on the size of hugetlb hstate, the latter
    may cover multiple entries in one loop.
    
    However, the performance difference should hopefully not be a major
    concern, considering that GUP just yet got 57edfcfd3419 ("mm/gup:
    accelerate thp gup even for "pages != NULL""), and that's not part of a
    performance analysis but a side dish.  If the performance will be a
    concern, we can consider handle CONT_PTE in follow_page(), for example.

So IMHO it can be slightly different comparing to e.g. page fault, because
each fault is still pretty slow as a whole if one fault for each small pte
(of a large folio / cont_pte), while the loop in GUP is still relatively
tight and short, comparing to a fault.  I'd boldly guess more low hanging
fruits out there for large folio outside GUP areas.

In all cases, it'll be interesting to know if Ryan has worked on cont_pte
support for gup on large folios, and whether there's any performance number
to share.  It's definitely good news to me because it means Ryan's work can
also then benefit hugetlb if this series will be merged, I just don't know
how much difference there will be.

Thanks,

-- 
Peter Xu

