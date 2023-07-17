Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6077565AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjGQOBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGQOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:01:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4DD1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hVWockFHfDeC36ttEpU81naz2JoLerxTMWhmyxwyEmo=; b=PLgbppijJtD6HI05+rhFy9beQz
        fMbP/erGWaD1SwJbvlnI3X5hqolwBNyt655V3llRfI52RqF2IBuFgdvTMhQJTl2DipoE9oy5UX6gj
        J5VGy77nDO1Mgid5ERrqgSfGtecbXVYvjfdGwLZKn+Y/sr7WqHkkoVFewXis6vli4Nk5mt0hP0Dwq
        ZybhjeXZrEgIRwRmfrIwMx3X6OT4JFNjTKOoiSQIDq5s2fxrn59JbYa8qEbTqtR8jRa8koYEAi1/Y
        0xAXgi5pRQ06AGG9rw7fpFkfMKlw5EVk0jCtnWaR8mXUgyueG2XKB7GGqA7SPQsktMvMQ4i8c7VLc
        Zx6sColw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLOmM-003yBO-6w; Mon, 17 Jul 2023 14:00:46 +0000
Date:   Mon, 17 Jul 2023 15:00:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 3/6] mm/page_io: use a folio in swap_writepage_bdev_sync()
Message-ID: <ZLVJjpKB0YpxfiR2@casper.infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-4-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717132602.2202147-4-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:25:59PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Saves one implicit call to compound_head().
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
