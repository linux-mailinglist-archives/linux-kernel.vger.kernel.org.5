Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B092A7F592F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjKWH0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjKWH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:26:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEE8C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ucNIMLdxUFVbCLp9HspFVrXSn5iGqL5LxFwAG/1uGD4=; b=1D4CBpbxv4d4JTuoMceC6cwKDs
        5DUJ6R7EohJ1LkucUf4xdCoIpt3HtGoW9BwAH5gcRCGgcYs2mVS3JZJjbwBIZXf6ooVUlMr4Z3EoS
        VrXnD8Sp6/2bj0iW5C7byD8EQToZezqi/rCfhNEJF6NJdTKAi8WQTQT0LMTORjRmKxHszexdeailm
        USOIIwdBL9MwC88RG7BI2rTEk39p74ILrXMku8ZBq4Xw8ygwf/kFaG9uJNpDeYfk6/75rsaJhkqxo
        IHYn9UlE0tQ89kRS4ux3sHAnKrqJB1pD4aBzCMT0hQH/r1/SwHzZFwLHHNdolYJo0R9L2UjwpepNQ
        U+hjNp3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r646I-00422X-10;
        Thu, 23 Nov 2023 07:26:14 +0000
Date:   Wed, 22 Nov 2023 23:26:14 -0800
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
Subject: Re: [PATCH RFC 08/12] mm/gup: Handle hugetlb for no_page_table()
Message-ID: <ZV7+lmga3RdYMxs9@infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116012908.392077-9-peterx@redhat.com>
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

>  static struct page *no_page_table(struct vm_area_struct *vma,
> -		unsigned int flags)
> +				  unsigned int flags, unsigned long address)

More reformatting that makes the code less readable :(

Oterwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
