Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084477BD36
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjHNPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjHNPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:38:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EB310D0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:38:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 226721F45B;
        Mon, 14 Aug 2023 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692027499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g7YUilbuYTdRmZ3qe67ox4CEWBzf91CquwKUvJGpbcs=;
        b=A/TMt0C9YsAgIOXR6hkN6CMhr4tNaecIuzu61CT2H1oHvzn+6Vn3lgPMP9HBoLSbF2tPdq
        2qhrJ9Xu81WiUvqosgmIh7dWJHBtmWu1chDtvl+hvnqru5DEBbyyYYf24KLstJdHq04wNf
        XVSUEYKRX8IW4CeqCYyU8MgEyDbYaLU=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D993B2C143;
        Mon, 14 Aug 2023 15:38:18 +0000 (UTC)
Date:   Mon, 14 Aug 2023 17:38:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/3] lib/vsprintf: Rework header inclusions
Message-ID: <ZNpKaausydIB_xRH@alley>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-08-05 20:50:24, Andy Shevchenko wrote:
> Some patches that reduce the mess with the header inclusions related to
> vsprintf.c module. Each patch has its own description, and has no
> dependencies to each other, except the collisions over modifications
> of the same places. Hence the series.
> 
> Changelog v2:
> - covered test_printf.c in patches 1 & 2
> - do not remove likely implict inclusions (Rasmus)
> - declare no_hash_pointers in sprintf.h (Marco, Steven, Rasmus)
> 
> Andy Shevchenko (3):
>   lib/vsprintf: Sort headers alphabetically

I am sorry but I am still against this patch?

>   lib/vsprintf: Split out sprintf() and friends
>   lib/vsprintf: Declare no_hash_pointers in sprintf.h

I am fine with these two.

Would you mind preparing v3 without the sorting patch, please?

Best Regards,
Petr
