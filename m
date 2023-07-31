Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA6769AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjGaPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGaPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:43:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDEF1704
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:43:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A6B261F385;
        Mon, 31 Jul 2023 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690818192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSCdq/XOaR0rkNXqZSJLXjUc3/49iDtaf7K7yp7okHY=;
        b=o//aJLy+c8XBT5AeXc0zYSTt5MECDI3oLX9V9ekoSDIx63EDXJxOTfAruevvLmMkGAVYBG
        XMAiCWCWCau7KCiP43cwja178G/Me4FtWMjfdZd4hYuhUfG6hgFoSr7GDadyhfy7Z+B3n6
        Z/GYyEXFqeBOng7tNL+H2F8liawm+1E=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7AE6E2C142;
        Mon, 31 Jul 2023 15:43:12 +0000 (UTC)
Date:   Mon, 31 Jul 2023 17:43:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/8] printk: Provide debug_store() for nbcon
 debugging
Message-ID: <ZMfWkNpCp2WLZ5jw@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-3-john.ogness@linutronix.de>
 <ZMPdRVXq3IybuvzN@alley>
 <87leez92ej.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leez92ej.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 23:07:08, John Ogness wrote:
> On 2023-07-28, Petr Mladek <pmladek@suse.com> wrote:
> >> +	r = vprintk_store(2, 7, NULL, fmt, args);
> >
> > We should probably use one of the LOG_LOCALX numbers, e.g.
> >
> > #define        LOG_LOCAL0        (16<<3)
> >
> > Also, please use LOGLEVEL_DEBUG instead of the hard coded "7".
> 
> OK.
> 
> I am also open to dropping the function and its use. When developing the
> ringbuffer I also had a similar function but never attempted to publish
> it. It is useful for developing/testing/debugging, but once everything
> works as it should it has no real purpose. I have no problems keeping
> the debug stuff hidden in my own private toolbox.

I do not mind to add this patch. It is actually pretty interesting
function. I wonder if it might inspire anyone for using this approach
for some other reasons.

Best Regards,
Petr
