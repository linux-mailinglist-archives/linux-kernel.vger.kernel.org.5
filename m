Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E997728A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHGPHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHGPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:07:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466B10F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:06:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8C89E1FE4E;
        Mon,  7 Aug 2023 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691420794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORrKyaZwOQ/jexEB7RQEGSlaUvsbs8g0ZAVVA+oTshk=;
        b=hfz9kNXXkapTsezKRcdELtbZ/iGUbk2GzklyeRXMsp8YDzh+QM6+vBI0ntKmmV8hjvizgA
        w1dok8drbOzeDmfcIxRzIeKZpgcziKPoYB3M9/PHKRBY2iu3tyiDOOH6djF/x2xKU+MWs7
        dFDnnZcjHZcLXJy8LP6KDOlqA48Gy6g=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4E9952C142;
        Mon,  7 Aug 2023 15:06:34 +0000 (UTC)
Date:   Mon, 7 Aug 2023 17:06:33 +0200
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
Subject: Re: [PATCH v2 3/3] lib/vsprintf: Declare no_hash_pointers in
 sprintf.h
Message-ID: <ZNEIeUOHoOIZJ6UE@alley>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805175027.50029-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-08-05 20:50:27, Andy Shevchenko wrote:
> Sparse is not happy to see non-static variable without declaration:
> lib/vsprintf.c:61:6: warning: symbol 'no_hash_pointers' was not declared. Should it be static?
> 
> Declare respective variable in the sprintf.h. With this, add a comment
> to discourage its use if no real need.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/sprintf.h | 2 ++
>  lib/test_printf.c       | 2 --
>  mm/kfence/report.c      | 3 +--

If we agreed to move sprintf() declarations into printk.h
then this might go to printk.h as well.

Best Regards,
Petr
