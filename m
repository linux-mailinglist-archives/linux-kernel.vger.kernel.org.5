Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6C677BD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjHNPeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjHNPeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:34:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B838910CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:33:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5B2311F45B;
        Mon, 14 Aug 2023 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692027233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PQUYAWAb1k9Z/YmXHKlOUY17GrFAyEmuzFZMJMKUnBY=;
        b=akFhWRIwcKkZJ1HqiOw2FkVywMcrW3YdODW66y3Ojg8RdRtsOTpTMn0s55q6+DzcqfU7bO
        z7iDB14FgzJMzKwzAoLDAjlSpNBV50zVhxTMTOvp7Osyepfj2TgLR/cEwrBWPiF0X7WLCh
        CHbGArNyGlr2OL2mfNV5LCaPwLB12Ds=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE8C92C143;
        Mon, 14 Aug 2023 15:33:52 +0000 (UTC)
Date:   Mon, 14 Aug 2023 17:33:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Sort headers alphabetically
Message-ID: <ZNpJXapjZcYqJqFG@alley>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-2-andriy.shevchenko@linux.intel.com>
 <ZNEASXq6SNS5oIu1@alley>
 <ZNEGrl2lzbbuelV7@smile.fi.intel.com>
 <5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-08-07 21:47:17, Rasmus Villemoes wrote:
> On 07/08/2023 16.58, Andy Shevchenko wrote:
> > On Mon, Aug 07, 2023 at 04:31:37PM +0200, Petr Mladek wrote:
> >> On Sat 2023-08-05 20:50:25, Andy Shevchenko wrote:
> >>> Sorting headers alphabetically helps locating duplicates, and
> >>> make it easier to figure out where to insert new headers.
> >>
> >> I agree that includes become a mess after some time. But I am
> >> not persuaded that sorting them alphabetically in random source
> >> files help anything.
> >>
> >> Is this part of some grand plan for the entire kernel, please?
> >> Is this outcome from some particular discussion?
> >> Will this become a well know rule checked by checkpatch.pl?
> >>
> >> I am personally not going to reject patches because of wrongly
> >> sorted headers unless there is some real plan behind it.
> >>
> >> I agree that it might look better. An inverse Christmas' tree
> >> also looks better. But it does not mean that it makes the life
> >> easier.
> > 
> > It does from my point of view as maintainability is increased.
> > 
> >> The important things are still hidden in the details
> >> (every single line).
> >>
> >> From my POV, this patch would just create a mess in the git
> >> history and complicate backporting.
> >>
> >> I am sorry but I will not accept this patch unless there
> >> is a wide consensus that this makes sense.
> > 
> > Your choice, of course, But I see in practice dup headers being
> > added, or some unrelated ones left untouched because header list
> > mess, and in those cases sorting can help (a bit) in my opinion.
> 
> I agree with Andy on this one. There doesn't need to be some grand
> master plan to apply this to the entire kernel, but doing it to
> individual files bit by bit does increase the maintainability. And I
> really don't buy the backporting argument. Sure, backporting some patch
> across the release that does the sorting is harder - but then,
> backporting the sorting patch itself is entirely trivial (maybe not the
> textual part, but redoing the semantics of it is). _However_,
> backporting a patch from release z to release y, both of which being
> later than the release x that did the sorting, is going to be _easier_.
> It also reduces merge conflicts - that's also why lots of Makefiles are
> kept sorted.

I am afraid that we will not find a consensus here. I agree that
the sorting has some advantage.

But I would still like to get some wider agreement on this move
from other subsystem. It is a good candidate for a mass change
which would be part of some plan.

I want to avoid reshuffling this more times according to personal
preferences. And I do not want to add this cosmetic subsystem
specific requirement.

Best Regards,
Petr
