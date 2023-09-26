Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CAD7AE6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjIZH33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjIZH31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:29:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E88DC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vc4Cre/FG5qT/QgCqgpeBABCKG/U+RSEpRQZ2rr0kos=; b=BP/AcUtPRq5nmG67dVQuIgie0q
        bQduqE+F7z57ByRadtQ2epBdyYaEND6QXoL6Yy+9rr3REj4g2Aqz3SX+lRGGGYX2DiPpUwyMFOyeh
        ryLBjY6CkdxJEYeFZLIvgZZy15QjJKwB6CGg3YlQFCDHhQQqVZXGftCUvFfTmGNKolJYvCqEOc2Uw
        1LtwjpuXXYHS5qkrWIZJlfCsB5EFHUlAqqMjQCUgVgIdrlO80gtZgMTUgc+F3a/1WyYeqUn1OG5vb
        sbnxdWXABIzKmluGRRmo73F5uNuBZKfzkRiL/TX9nB6qowuCpYlN0gj8lcogNv2Hkzw2sYL6IVKgE
        yzVMMeZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ql2VL-00FnU7-0d;
        Tue, 26 Sep 2023 07:29:11 +0000
Date:   Tue, 26 Sep 2023 00:29:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: change zswap's default allocator to zsmalloc
Message-ID: <ZRKIRyYYkAbJ5uOP@infradead.org>
References: <20230908235115.2943486-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908235115.2943486-1-nphamcs@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 04:51:15PM -0700, Nhat Pham wrote:
> Out of zswap's 3 allocators, zsmalloc is the clear superior in terms of
> memory utilization, both in theory and as observed in practice, with its
> high storage density and low internal fragmentation. zsmalloc is also
> more actively developed and maintained, since it is the allocator of
> choice for zswap for many users, as well as the only allocator for zram.

Dumb question from an outside, why do we then even keep the other
two allocators around?

