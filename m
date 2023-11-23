Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AFC7F637C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjKWP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjKWP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:59:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7282D10C3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hd/UO5iwEledq4I12QJyEn1Jcx4datOBlQqC1Tx4lzA=; b=kRQfyhBcXdZv3+GzCTrLI8aoz9
        FMRGQTfz7Fie4uGKWihrkwufPbjXhhBp5V9ticMgsOL9I1QGe1EAH2Z5VviuiBNKAyM1htYkHYT0d
        dtqu410VsFPd7HAhZAbAgb6zsC++P+3eLbKDIofg0G4rzYYGc9tLRkYxte2s2pWgeEIDu005NfyLM
        nuiLFlRlsqNvt93DPvGbBS4BtQo2aP0lX9syMVeEVLSzpTNUW+zPuxA75acSq0JD1o0rfg0yn/HwJ
        EXNIDWtYvgj6TYDQMXmpbIPjtoL2RHZdBsSG349bX8ULMwAnDu1lpg498I7spyo0VclxZ58AHAIL9
        v6SNdbwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6C79-007gjl-9d; Thu, 23 Nov 2023 15:59:39 +0000
Date:   Thu, 23 Nov 2023 15:59:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Message-ID: <ZV9267tQEhoPzCru@casper.infradead.org>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122162950.3854897-1-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
> Note: I'm resending this at Andrew's suggestion due to having originally sent
> it during LPC. I'm hoping its in a position where the feedback is minor enough
> that I can rework in time for v6.8, but so far haven't had any.
> 
> Hi All,
> 
> This is v7 of a series to implement small-sized THP for anonymous memory
> (previously called "large anonymous folios"). The objective of this is to

I'm still against small-sized THP.  We've now got people asking whether
the THP counters should be updated when dealing with large folios that
are smaller than PMD sized.  It's sowing confusion, and we should go
back to large anon folios as a name.
