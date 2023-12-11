Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE48F80D12A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbjLKQYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbjLKQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:24:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C4D100
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Kfb+cfmApiBpOgVhRA429I1tFY1BIkkOoH5lksrhgQ=; b=ZQ3xLCeJZrEVazVZrCkgXWXzkI
        kGpyWTDaVl+aAVVpkqBACmte9aJqayXYMdFTpdeGqG6TZOLKYyKEbkXmWqNPd9bs6o+TRXnWAX8QA
        DT2Iuik5P1QUn8xnQagPP1TjbT2QLP7ausqM70sfkCkIO7m9msvKGP+yasmCBmCS9n7y/T/FFQ179
        +OoNKUxLTvwH+toXCD+FRNvle7rkvCCLwBDarZPbdTkHDMXc+abv/0F/cyd1tf7zk00kNKRHCWPmN
        fbt/sAF2fYo7z4ADJYF7rMBT08z9NPUfF1RrH161A1XVg5QSIH5p6Qr9HvGm/eP1QYnFZ3slvboZ0
        0ok1jx7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rCj4m-0090QP-4E; Mon, 11 Dec 2023 16:24:12 +0000
Date:   Mon, 11 Dec 2023 16:24:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v1 01/39] mm/rmap: rename hugepage_add* to hugetlb_add*
Message-ID: <ZXc3rJZh4PCsbDdM@casper.infradead.org>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211155652.131054-2-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:56:14PM +0100, David Hildenbrand wrote:
> Let's just call it "hugetlb_".
> 
> Yes, it's all already inconsistent and confusing because we have a lot
> of "hugepage_" functions for legacy reasons. But "hugetlb" cannot possibly
> be confused with transparent huge pages, and it matches "hugetlb.c" and
> "folio_test_hugetlb()". So let's minimize confusion in rmap code.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
