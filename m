Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408017F5921
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjKWHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjKWHXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:23:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268F0CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cH5KstrQ6X9Z2/rTKAQoqizmRcDpRe5h9xPsJQTg8Qo=; b=2PfPu0Bg1MlvogYjoOdQsxlJtf
        uOEfFygoHfw4sHk1rfBCN38h305SgXrphdFMv1eqyFLFRpRwUigUwJmIJ5gnMNn8Cl7H6KVH3GASL
        r0Q4wannJjnYKow60Eb3LJRm0AnMDgC6uH9Hf53EG/qhz/C0QWIbz5eFeIiWUtoKoUm5n9a3xSz60
        cKU9vWmgasDn8YaWiYV283xZeUzdWEpPBsu7t58HCHdLfR7BXAARNzc8fwP7CwrEfBJmSbmLsDe5z
        A9JPrjVyliBsJ4PfWTMYToml7aMxSYJfgCQHvx2rGQCH+WnR5Z6a4DWKpbFhT/lgOJwg8+ptZRMrg
        7bxwjhWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6445-0041QU-1j;
        Thu, 23 Nov 2023 07:23:57 +0000
Date:   Wed, 22 Nov 2023 23:23:57 -0800
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
Subject: Re: [PATCH RFC 03/12] mm: Export HPAGE_PXD_* macros even if !THP
Message-ID: <ZV7+Dc1EeVNyV1lL@infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116012908.392077-4-peterx@redhat.com>
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

No way to export macros :)

I'd say define, but other might have better ideas.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
