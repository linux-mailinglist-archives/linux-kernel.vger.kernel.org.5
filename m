Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE679F383
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjIMVMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIMVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:12:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8BA1724;
        Wed, 13 Sep 2023 14:12:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3BDC433C8;
        Wed, 13 Sep 2023 21:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694639525;
        bh=yNmnijX9dDFu7LZaZLAVZkns4JfXfNJbeOtM0K2Q1os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WjCB7spDz7jk+KVHyubRrehdvmIsI1nemP+0f/RbXeFyfSyIcNKgXgwgIZtNSfcbO
         byAhITtR1UTjgibP+ZvN6UrwiH7qTutQvyl4LXQbMc1zScMusxJL120q9eCt9DCPRY
         9IIDet2XsibUTQyVS2rluIMttOLpeBFl+seuKrLg=
Date:   Wed, 13 Sep 2023 14:12:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Zi Yan <zi.yan@sent.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: Re: [PATCH v3 0/5] Use nth_page() in place of direct struct page
 manipulation
Message-Id: <20230913141204.b32ad42ac917c0e393d82a24@linux-foundation.org>
In-Reply-To: <20230913201248.452081-1-zi.yan@sent.com>
References: <20230913201248.452081-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 16:12:43 -0400 Zi Yan <zi.yan@sent.com> wrote:

> On SPARSEMEM without VMEMMAP, struct page is not guaranteed to be
> contiguous, since each memory section's memmap might be allocated
> independently. hugetlb pages can go beyond a memory section size, thus
> direct struct page manipulation on hugetlb pages/subpages might give
> wrong struct page. Kernel provides nth_page() to do the manipulation
> properly. Use that whenever code can see hugetlb pages.

for (each patch) {

	Can we please explain why -stable backporting is recommended?

	Such an explanation will, as always, include a description of the
	user-visible effects of the bug.

	Some of the Fixes: targets are very old: 5 years.  Has something
	changed to bring these flaws to light?  Or is it from code inspection?
}

Thanks.
