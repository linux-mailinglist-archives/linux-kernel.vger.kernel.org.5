Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29E753A40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjGNL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjGNL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:56:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AE4211C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:56:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE5B422167;
        Fri, 14 Jul 2023 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689335813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FWs2WFaihjHlnIss+jJaHGwENjcrMAcbUYUL9FfpXW0=;
        b=qxwgLz1vAmwu3MFxCMc3AckdxrtDLJjkCJ4Mv4UccqmqUVhng+ukf8pusSkR8Pl/2+zrYn
        ryM5piK9JidZepC2OPywiZ1VRFdbQgH4G6Fh1e2+3gjDBdbQjzcH4F1Rvpz+/tanp6thT5
        RztE9j27uXoXmJkn8IC1W9NyJDGj+ks=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 946652C142;
        Fri, 14 Jul 2023 11:56:53 +0000 (UTC)
Date:   Fri, 14 Jul 2023 13:56:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust printk/vsprintf entries
Message-ID: <ZLE4BVH3o-Y3ximB@alley>
References: <20230705131511.2806776-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705131511.2806776-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-07-05 22:14:34, Sergey Senozhatsky wrote:
> M should be earned.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17037,9 +17037,9 @@ F:	kernel/sched/psi.c
>  
>  PRINTK
>  M:	Petr Mladek <pmladek@suse.com>
> -M:	Sergey Senozhatsky <senozhatsky@chromium.org>
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	John Ogness <john.ogness@linutronix.de>
> +R:	Sergey Senozhatsky <senozhatsky@chromium.org>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>  F:	include/linux/printk.h
> @@ -22796,9 +22796,9 @@ F:	drivers/net/vrf.c
>  VSPRINTF
>  M:	Petr Mladek <pmladek@suse.com>
>  M:	Steven Rostedt <rostedt@goodmis.org>
> -M:	Sergey Senozhatsky <senozhatsky@chromium.org>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
> +R:	Sergey Senozhatsky <senozhatsky@chromium.org>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>  F:	Documentation/core-api/printk-formats.rst

Thanks a lot for staying around and keeping an eye on printk().

I have pushed the patch into printk/linux.git, branch for-6.6.

Best Regards,
Petr
