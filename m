Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8F7B0D12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjI0UAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0UAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:00:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B993810A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qlJCDiEm1PsyZ7btU88olFOkJZVUmE9aa9jDpV/uPGI=; b=dXUQNgSXhkz8i62uo5LIX08iEA
        r3zOiUCeTcPleePVu8jh+ZGWCbulNNbzkJkO15OQyh1il6YCDwgZYWDNjLaIhEmRy0BttBtrYMjPn
        +cA55TXN51iUPo+8HcL1ZF0DdtjJOyJRMjdTFQFPeKd9xBElZdyV/CZoaupkO4vcnsBLyU4D/6zDz
        A1USedkgVlvt/nqneDRhK4ApTCYC+U8gHKtpQcmZEiNSh4zlpY5PrOsEyx8i2gBlOKFxib7dxZhzm
        MKeJiCH634KigRAaeO/f1Jl+dEPGQerHwQE7ZXF4THb7DH3JHVH37SzGXhN/jEJBV6RGFZWXp1wG0
        GPYkc/PA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlai5-00FpW7-5r; Wed, 27 Sep 2023 20:00:37 +0000
Date:   Wed, 27 Sep 2023 21:00:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     David Laight <david.laight@aculab.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Jason@zx2c4.com, hch@infradead.org,
        andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Subject: Re: + minmax-add-umina-b-and-umaxa-b.patch added to
 mm-nonmm-unstable branch
Message-ID: <ZRSJ5QMNGV7ObfrL@casper.infradead.org>
References: <20230927173033.AF86DC433C7@smtp.kernel.org>
 <d74a3644-1d03-42c7-b258-4d5d63416ee0@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d74a3644-1d03-42c7-b258-4d5d63416ee0@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:21:41PM +0300, Alexey Dobriyan wrote:
> On Wed, Sep 27, 2023 at 10:30:33AM -0700, Andrew Morton wrote:
> > +#define umin(x, y)	\
> > +	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
> 
> kmin() and kmax() are (of course!) much better names.

it's unsigned, not user.
