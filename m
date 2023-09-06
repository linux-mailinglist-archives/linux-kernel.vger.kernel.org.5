Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0DE793E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbjIFOJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjIFOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:09:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41AECF;
        Wed,  6 Sep 2023 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2KICmQPQioM7Mq7IhbLtSPWvHTI3/EB2itOUb98EMvs=; b=snaVG0C+Qb1kuAlYoIf4ZBkavW
        PHRJKqf1J/Q7gcIbsNBrdD8EbUm0KPzHYSRQjRTjeQSVgxlNS6AZkWoZOgvYaYt+NkSlirle1gCOr
        XiPYgyREJqxkls5Xd0J0y9iuWH7zwz97v5MOvbVZ/ZLjU/tDavRzbP7Ow1Iy9Mu7EYm73r38B6AA6
        9Na99VoLgn5DwGQP5dSmEIztgLczEz5yFq81EoHku3QzeYY2h2oBSPm9GKxmXayus6fUKDTNTOy5x
        zYWZP4fnXWYhgqGXyptKuzdIACY9RuyapQx8bClo0hZECwYL9eCzMJGqdfDS214Ny0ylwVinB/iOt
        yXLqxbbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdtDz-002vwD-EY; Wed, 06 Sep 2023 14:09:43 +0000
Date:   Wed, 6 Sep 2023 15:09:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: Physical Memory: add "Memory map" section
Message-ID: <ZPiIJ0iuiqSpeG1P@casper.infradead.org>
References: <20230906074210.3051751-1-rppt@kernel.org>
 <ZPhurt9P7hnsVvua@casper.infradead.org>
 <20230906125214.GK3223@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906125214.GK3223@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:52:14PM +0300, Mike Rapoport wrote:
> On Wed, Sep 06, 2023 at 01:21:02PM +0100, Matthew Wilcox wrote:
> > I don't understand why you've done all this instead of linking to the
> > kernel-doc I wrote.
> 
> We can't have it both in Documentation/core-api/mm-api.rst and here without
> sphinx complaining: 

I didn't say "include it here", I said "link to it".

I don't see the value in documenting all of these structs here.  They
should be documented in the subsystem that actually uses them.  Just a
note that there's per-allocation data stored in struct page should be
enough, I think.
