Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69B276CCD5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjHBMhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjHBMhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:37:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683D2718
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ab3GBgwKIO10gaSlc0RTzmhdSzbBvrq8O6cOw4GtT0=; b=iiLAOATKrbDDzwGM0wgHxZ6GSE
        U5WQgdgmbZXe3Iy1e4WjW7hOQuE1RBjldaZ7XhL32Kd9TkMVDgADECgdZfXu4evOfN2uCDP7eNLl/
        GjzQYBxhpedsmyAenLPuLfDdG+HxRpJIeAUiz2gg6I6Pu3GROIN9hrnPXqS2Udrxl4hwNy0S+Sux4
        AQSUYC0FAWh7BCDjBAh6vnGRdDir99V8GalYCs26a2jFYsrfDjJQyR8BuCQbGJ1Kuy9t+jCe3W1+c
        QprGGZajo7oiqPmfPrIcieYtUj8zVZLIB4b2Ip8Bc/reli6NSODXmhbJIHYGtLjeMaJgL1aK5odeB
        YwCXGZPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRB6Y-00EyMw-3l; Wed, 02 Aug 2023 12:37:30 +0000
Date:   Wed, 2 Aug 2023 13:37:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/4] mm: migrate: use __folio_test_movable()
Message-ID: <ZMpOCgBcc7FR0Ix5@casper.infradead.org>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802095346.87449-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:53:46PM +0800, Kefeng Wang wrote:
> Use __folio_test_movable(), no need to convert from folio to page.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

In my defence, I did many of these function conversions before
__folio_test_movable() existed ;-)

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
