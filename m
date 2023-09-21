Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443AB7A9067
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjIUBQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUBQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:16:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF6A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 18:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WYAUtjcIJorpbkcMTw3CByHZFRQNnTETF7Qv9aBMs8E=; b=HxRdz76XxGcUyQf0jHY8ekLAav
        OyJJEozG7slD/4K2lLC15xipsuhay6GsoPOuVBD4/VcrarEvCUVIYW+CGMjAvu/Uup03gxg/rR43E
        nJSMIt5i9qj71VLlWT0VGwsk+8zgFji8nB8vNDo+yZ7qhbA315ElOVoMNMyf6N9tLzPhgJicVYC/9
        3qapdzTuTrTav5RCt00I7rDYgE4kXvdZYnEbw93fU8kTUWSOxD3GGUm9tl24JBupvRjM6ZXXAFqHN
        QK73Z+bjDFX5M7+09F3h1IiavdSukkbRPAwGIMmnYmb0DKNn0PtowdTCqbJ4R0ut4b6tp/V04ECy+
        Xlh9TlTQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj8J4-004cpK-2I;
        Thu, 21 Sep 2023 01:16:38 +0000
Date:   Wed, 20 Sep 2023 18:16:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Message-ID: <ZQuZdkxm/GMyS6wY@bombadil.infradead.org>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <ZQuUl2DdwDlzKoeM@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQuUl2DdwDlzKoeM@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 05:55:51PM -0700, Luis Chamberlain wrote:
> Are there other known recipes test help test this stuff?

You know, it got me wondering... since how memory fragmented a system
might be by just running fstests, because, well, we already have
that automated in kdevops and it also has LBS support for all the
different large block sizes on 4k sector size. So if we just had a
way to "measure" or "quantify" memory fragmentation with a score,
we could just tally up how we did after 4 hours of testing for each
block size with a set of memory on the guest / target node / cloud
system.

  Luis
