Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF797DB0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjJ2XWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjJ2XWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:22:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717E4E3E9;
        Sun, 29 Oct 2023 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VT3Ad4lScHgALY3lYyr+KQk9MBuJnneunm0wQQrliGI=; b=s3Bd+dzA8IVaL7EAr7sc9o7QFs
        RqxVYSQ+/gE1vs83o8o05Nml83SpfDzOtgZwmw3laXu4TZAQOHivFfFgiowRBqjspvKLEudIEYb9i
        bnznG0G9e0ZqqWXA5OKNdT31xCgyrgPn/vVwWmiWpKoynl0nRIHymyOuTgjTTEgSwdVlR4133p8j9
        GV0Gtf2XLrx/3RAzU1e6NNQEhOYi+0cO999GMT0P8v1HoSCFe1b1ddiflYIb5fGoS62Kulwjlm5ex
        cRIS3gQfrNH2j8IzX/5qauNRHa/g+//WQ+zdwkekYx6e6hkwGqOallL7PfrmxdS8aBZ7dirFGyR41
        D5zM70qQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxEzW-000dtM-3j; Sun, 29 Oct 2023 23:14:46 +0000
Date:   Sun, 29 Oct 2023 23:14:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 06/11] shmem: trace shmem_add_to_page_cache folio
 order
Message-ID: <ZT7nZqMylFYEqpg/@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211545eucas1p2da564864423007a5ab006cdd1ab4d4a1@eucas1p2.samsung.com>
 <20231028211518.3424020-7-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-7-da.gomez@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 09:15:44PM +0000, Daniel Gomez wrote:
> To be able to trace and account for order of the folio.
> 
> Based on include/trace/filemap.h.

Why is this better than using trace_mm_filemap_add_to_page_cache()?
It's basically the same thing.
