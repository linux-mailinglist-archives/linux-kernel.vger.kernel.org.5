Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6867A620D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjISMIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjISMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:08:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65419FC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:08:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CE1091FE31;
        Tue, 19 Sep 2023 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695125281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jW4Yn6tx8vpkIvCO/QIvVlcf5QNJLm0Exn7GvpuQ8w4=;
        b=j2GFZ6xURYlCJLWNex5HZ8muIeooNR+mMTA4fG20fUf7SpXZdwMMxckBB7FJS0x6X83kdS
        wsOObRwWm2w2meRmxDlCSIGhgtobGNU1NfznSUMjItwj57AGpZEyYFcIcK0XQOudSkk9Nb
        4yoOmPpFALJXnuKqVFN7fABJdWyKgSo=
Received: from suse.cz (dhcp219.suse.cz [10.100.51.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 745A62C142;
        Tue, 19 Sep 2023 12:08:01 +0000 (UTC)
Date:   Tue, 19 Sep 2023 14:08:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 0/8] provide nbcon base
Message-ID: <ZQmPIVTwut-77wKl@alley>
References: <20230916192007.608398-1-john.ogness@linutronix.de>
 <ZQhkjGxX_Wmo-v0J@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhkjGxX_Wmo-v0J@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-09-18 16:54:06, Petr Mladek wrote:
> On Sat 2023-09-16 21:25:59, John Ogness wrote:
> > Hi,
> > 
> > This is v5 of a series to introduce the new non-BKL (nbcon)
> > consoles. v4 is here [0]. For information about the motivation
> > of the atomic consoles, please read the cover letter of v1 [1].
> > 
> > This series focuses on providing the base functionality of the
> > nbcon consoles. In particular, it implements the ownership and
> > priority semantics for nbcon consoles. This series does _not_
> > include threaded printing, atomic printing regions, or nbcon
> > drivers. Those features will be added in separate follow-up
> > series.
> 
> This series seems to be ready for linux-next and I am going to
> push it.

JFYI, the patches has been pushed into printk/linux.git,
branch rework/nbcon-base.

Best Regards,
Petr
