Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD09E7F773D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbjKXPGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbjKXPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:06:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E91B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q78WGe4buDmFTY2CNafH/GdHZsiQ6etEmfh4tkpfnOU=; b=YRXAk877eHcw4jEKun+aoPzTE9
        CYfF/sgXjTuK19iWbf8NmsYKTNmGxDQ+fmIfQhvErcUre8w0XhdASts6xux6L7d5Fx5ump381csYl
        QgWniTOVATOJ6P4u2tPOX9zm+0wx1AccWYL5p8kHFlL2ZzOZl8NPaqhOWBOoSI1zwDPoPwR971/Jm
        UEdsW0CZ+iQj+jCPP2Tz0eWhcCg3NESrtD//5s7brjqXRZy+ra4D8vEUYr+wv3HaEt5NuL9XvQXtW
        mPE5Fw0pPoL46h0I98kVI9Gbob1m7tXrlS0oMCGztNVYuAq1ELNYnJgwT7YI11SLSTUSM8C093xcU
        5rExqhRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6XlU-008ggk-2W; Fri, 24 Nov 2023 15:06:44 +0000
Date:   Fri, 24 Nov 2023 15:06:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Message-ID: <ZWC8BOtPW2bWBFqh@casper.infradead.org>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
 <ZV7eHE2Fxb75oRpG@archie.me>
 <ZV9x6qZ5z8YTvTC4@casper.infradead.org>
 <ZV_rJtxdn1dU9ip0@archie.me>
 <ZV/2nPBs5r1nIaW4@casper.infradead.org>
 <2023112402-posing-dress-4bf2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112402-posing-dress-4bf2@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:52:06AM +0000, Greg KH wrote:
> On Fri, Nov 24, 2023 at 01:04:28AM +0000, Matthew Wilcox wrote:
> > On Fri, Nov 24, 2023 at 07:15:34AM +0700, Bagas Sanjaya wrote:
> > > On Thu, Nov 23, 2023 at 03:38:18PM +0000, Matthew Wilcox wrote:
> > > > On Thu, Nov 23, 2023 at 12:07:40PM +0700, Bagas Sanjaya wrote:
> > > > > Anyway, I'm adding this regression to regzbot:
> > > > > 
> > > > > #regzbot ^introduced: v6.0..v6.1
> > > > 
> > > > this is not a regression.  close it, you idiot.
> > > > 
> > > > 
> > > 
> > > why?
> > > 
> > > Confused...
> > 
> > yes.  you're perpetually confused.  stop trying to help, you only make
> > things worse.  learn about the things you work on, or give up.
> 
> Um, is this really called for?  Bagas is trying to help track
> regressions, and if something isn't a regression like you say here, a
> simple "This is not a regression, it's already resolved in newer
> kernels" is fine.

Bagas has a long history of inappropriately attempting to "help" and due
to a lack of understanding wasting peoples time.  He's not too dissimilar
to the various wrongbots we've had over the years, including Richard B
Johnson, Markus Elfring, etc.  I've tried to help guide him towards being
a more productive contributor, but'have failed.  Mostly I ignore him now,
but when he's instructing a bot to harass me, that crosses a line.
