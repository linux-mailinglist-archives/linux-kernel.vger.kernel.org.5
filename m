Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16C7F591E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjKWHXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKWHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:23:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD44C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e4PsA32ksarbTD7FwELk4DnKSQW5zZP32H8oKCdWKrM=; b=pDZax++hGn2oV7FeSHRMOIMDez
        PdAkuhzOZ7Ps3CEUik8v/nResbjuMDIrqHSjjWmlrzx/g7Da7k7sFjOROK+u+x3fuLR/gg8D/xr7t
        ps1Gxsl25FufRHCafTHyC959uluCLFssTDbonxtTH4eccPW1J4u9034b0xCfuMadBCWDLLsrVnFTR
        CuLi8ZUmQi/0FGPLY9nnLyQ4Pmx1BgiKE8Z8olpLxpsPzTxA4VaQE6+sUImHjvWOEvtWTXgSTnKAL
        LqfyOteHizswnpt+nAYQSsLjiIob/Hfu+HhKcijO7nT8I4MBCUPlB0ZXZUX/QMeaH+cUem8M0zWvh
        IHctsZkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r643H-00417G-2N;
        Thu, 23 Nov 2023 07:23:07 +0000
Date:   Wed, 22 Nov 2023 23:23:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 01/12] mm/hugetlb: Export
 hugetlbfs_pagecache_present()
Message-ID: <ZV7923j4gQOZYAqe@infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116012908.392077-2-peterx@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You're (thankfully) not actually exporting anything, so please
don't claim that in the subject.

>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, pud_t *pud);
> +bool hugetlbfs_pagecache_present(struct hstate *h,
> +				 struct vm_area_struct *vma,
> +				 unsigned long address);

Can you just follow the much more readable two tab indent of the
function above?

> -static bool hugetlbfs_pagecache_present(struct hstate *h,
> -			struct vm_area_struct *vma, unsigned long address)
> +bool hugetlbfs_pagecache_present(struct hstate *h,
> +				 struct vm_area_struct *vma, unsigned long address)

Same here.  The new indentation not only is less readable but also
creates a pointlessly overlong line.

