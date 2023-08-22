Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1330784864
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjHVR1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjHVR1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:27:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065935B9F3;
        Tue, 22 Aug 2023 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QD8WUw/6vnchAglRH3iWq7Smf1mMhqLWdQjkHZTNUfE=; b=lzK8IuJ5MAS3R+DWnJz8SvJaTI
        nYk1tGQ2lVXkVr3cpgRltTybzjlpazX/mHDkTFkjfOsWcOBPEfGSbpkupsPMzeR/e6tDNmd7kXK/V
        6F45L2WKJqBJueY8/k4fzZHcp9tx3p6pP9zW4TE3NMv1up78PnjLAmVwrI2UcyVVX27aGJeHBeWQl
        nH62agykbVQrpo6m1ngT0F/AE1h0O+Aj+KPV31D+UZGYzx7MXnnblf2jGbrpbEOgN3uzUeX2GaL9S
        Wj516xYtFDFS1wS368cvqTToKeo8g+k4N2dlFv6ZSCSKatTAJicyzxp8nl6h/YbgLYquwSIWjiGqc
        soWmBcFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYVAN-00HaMH-DE; Tue, 22 Aug 2023 17:27:43 +0000
Date:   Tue, 22 Aug 2023 18:27:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: linux-next: build warning after merge of the mm-stable tree
Message-ID: <ZOTwDxMdCd5EEjHu@casper.infradead.org>
References: <20230822165355.5eb8cac1@canb.auug.org.au>
 <20230822095243.2b2f5f96ebb6ea7024b8e619@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822095243.2b2f5f96ebb6ea7024b8e619@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 09:52:43AM -0700, Andrew Morton wrote:
> Seems we removed the last /** comment from hugetlb.c.

Heh, yeah, two of my own patches colliding.  That's what I get for
working on the mm in two different git trees at the same time.

> otoh, hugetlb.c has undocumented EXPORT_SYMBOLs, so a nice
> fix would be to document at least those interfaces....

Ask and ye shall receive.  I decided not to document
linear_hugepage_index() since Sidhartha is deleting the only
user of it, and it was never an interface that was widely used.
Hopefully we're rid of PageHuge sometime soon.
