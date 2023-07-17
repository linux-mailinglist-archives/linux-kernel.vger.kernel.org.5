Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7E7565AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjGQOBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjGQOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:01:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A79410D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=67VcRnLuQCH22BeLGBNOvdWxweWNimzjLO2y5if/hiE=; b=mFe2VUIa1oGe/vdYpZPb6fwbhq
        Cay3Zj4Ub0VjorDLt3ZuCZRW2wvLLb9PF7KGdOZaaS0i5l9mAIOfIJpdzxTkvXeBHJMKJZrtgmd5x
        3HaNV9nV6pOBHcbSlLAsKPs9fcIkY5fFuKYIsIxQekzpKVb2W3+JxorHshRbyqkd2JAeQq4GYoWBG
        c8wmENMKu9O3Fg1Mwc2l1GJvw894K6Jr2BU0maPElWCVzSRstp7Jes8li5ld0hd/lW5udc5Xpdt13
        /6YDi1YiYDl9XF6Bv4Fk/d9anXKJbYPGY8cqFn4WLMRyqVeTcUZu+obaVr0jOmk5qYPbO8J0I0foG
        RU772HxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLOmi-003yCx-99; Mon, 17 Jul 2023 14:01:08 +0000
Date:   Mon, 17 Jul 2023 15:01:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 4/6] mm/page_io: use a folio in
 swap_writepage_bdev_async()
Message-ID: <ZLVJpDkIxLZAPui0@casper.infradead.org>
References: <20230717132602.2202147-1-zhangpeng362@huawei.com>
 <20230717132602.2202147-5-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717132602.2202147-5-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:26:00PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Saves one implicit call to compound_head().
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
