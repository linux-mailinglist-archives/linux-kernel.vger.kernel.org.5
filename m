Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A37520D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjGMMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGMMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:10:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79D2699
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rI0ROKoRaDCr2PMeq7/zhrDW372lSE1+sY8VEo3ciSc=; b=KQxyOus0p2bqIL7F+tkZO74MoC
        ZdAg3Lyg0SHetpOyolSQHARHBd4iWZ01Xn5TH3Gcb6UFd+N9nxp36RYw2jMQ9lIztj2EO/wBuxGZT
        uzendNKIPkuLwdDxvDWVvYMXn99yskr7if6dACXoSk7DFVvelzpi71cE8afL7gM9PUjpLS3F/a/XX
        z2h7/MMtqGUH1luw2iIiBOSmY89fDdEh1bOSTy81fQvOtuucewNfiRn8dKH8vAFQ+XeyEEiQdKzF9
        XjgoXUtejQR80U4cf1W+dpmb0Lh13F6NamcJ1O6014KNIwrijTZQjeWKUF1MWIg7l6HInGHFwtim9
        w4Aa0rbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJv9C-0007Xt-AG; Thu, 13 Jul 2023 12:10:14 +0000
Date:   Thu, 13 Jul 2023 13:10:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove some useless comments of node_stat_item
Message-ID: <ZK/ppvBO00rbspa8@casper.infradead.org>
References: <20230713114915.74671-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713114915.74671-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 07:49:15PM +0800, Miaohe Lin wrote:
> Some comments of node_stat_item are not that helpful and even confusing,
> so remove them. No functional change intended.

No, that's very useful and important.  Why does it confuse you?

>  enum node_stat_item {
>  	NR_LRU_BASE,
>  	NR_INACTIVE_ANON = NR_LRU_BASE, /* must match order of LRU_[IN]ACTIVE */
> -	NR_ACTIVE_ANON,		/*  "     "     "   "       "         */
> -	NR_INACTIVE_FILE,	/*  "     "     "   "       "         */
> -	NR_ACTIVE_FILE,		/*  "     "     "   "       "         */
> -	NR_UNEVICTABLE,		/*  "     "     "   "       "         */
> +	NR_ACTIVE_ANON,
> +	NR_INACTIVE_FILE,
> +	NR_ACTIVE_FILE,
> +	NR_UNEVICTABLE,
>  	NR_SLAB_RECLAIMABLE_B,
>  	NR_SLAB_UNRECLAIMABLE_B,
>  	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
> -- 
> 2.33.0
> 
> 
