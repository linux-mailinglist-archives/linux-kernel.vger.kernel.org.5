Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3F757C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjGRMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjGRMn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:43:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9D7194
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZcW9DBwr4Ijp/bqoUv1+6PZVS/5IzJmCDLO0wgYvsIE=; b=som95Apj0wXqjSqN5qyfI/sYRn
        oEFEx8k+yJAUyIJv3a2sGB+zDU+m5DPqNCcK57zQAkjlXIrZZIk9koVNMMjJG6kA38iRwXLo9wKCN
        +C2Hmg/wf+1zevj7A5pNlZme3n3cBAb8sfLu9Vsjnon8GtJ9bCVzQ+DeCU9Z2QVx+X6FWATXo6T+1
        RfJQviPdUzvBtUXeqm6A6Ks4hUVB2H6TfbNd+kVys8IYJev5ysfCzrMpYulVbx6XltGkrv2XGimSX
        NcPimdranjtJfLATfT4MYdvZCeV+Dz6l1MsirxclabizdS/IUYsglCjxIPvr/uzUsfgxerQHK0Wxc
        o30eiX5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLk3K-004vL5-U8; Tue, 18 Jul 2023 12:43:42 +0000
Date:   Tue, 18 Jul 2023 13:43:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: correct stale comment of rmap_walk_anon and
 rmap_walk_file
Message-ID: <ZLaI/jfVLVZfr5pc@casper.infradead.org>
References: <20230718092136.1935789-1-shikemeng@huaweicloud.com>
 <76de1682-353b-b8e9-0f09-539988f8ffe0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76de1682-353b-b8e9-0f09-539988f8ffe0@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:10:27PM +0200, David Hildenbrand wrote:
> On 18.07.23 11:21, Kemeng Shi wrote:
> > 1. update page to folio in comment
> > 2. add comment of new added @locked
> > 
> > Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > ---
> 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

I didn't get the original email, and it's also not in the lore
archives:

https://lore.kernel.org/linux-mm/76de1682-353b-b8e9-0f09-539988f8ffe0@redhat.com/T/#u

Can someone send it along?
