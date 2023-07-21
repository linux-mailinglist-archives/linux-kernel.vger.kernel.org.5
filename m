Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2663675C2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGUJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjGUJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:17:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2582A186
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:17:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8ACD219C7;
        Fri, 21 Jul 2023 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689931074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x+TYSVv5CzT0R7Ia8UMmozWWfVnF1tK1hl2dWwDann4=;
        b=IfkBMViXQbqT48dV/0uvj1E63MU42cAjpnFa8Gl/upn0Dd6jWPvZnSSGkzG4FdCYITHFQk
        96bcADlY7k9tYcapNx1ecaaaT9gAftZbSDnLwiOa/WWcEn8XR6bZHbZr4M0Y8MV3oJZb+D
        M7fziCGQN4VVNj8QHA5w9XtzFpUieuM=
Received: from suse.cz (dhcp129.suse.cz [10.100.51.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 242312C142;
        Fri, 21 Jul 2023 09:17:54 +0000 (UTC)
Date:   Fri, 21 Jul 2023 11:17:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 0/7] various cleanups
Message-ID: <ZLpNQdw8GZkJW7Gy@alley>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
 <ZLZtEfW1tZOTH53O@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLZtEfW1tZOTH53O@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-07-18 12:44:35, Petr Mladek wrote:
> On Mon 2023-07-17 21:52:00, John Ogness wrote:
> > Hi,
> > 
> > This is v3 of a series providing some cleanup in preparation
> > for the threaded/atomic console work. v2 is here [0]. This
> > series provides useful cleanups independent of the
> > threaded/atomic work.
> > 
> > Changes since v2:
> > 
> > - "NMI safety" patch split into 3 patches: console_unblank,
> >   keep non-panic CPUs out, do not lock console on panic flush.
> > 
> > - console_unblank() aborts if there are no consoles implementing
> >   an unblank() callback. This check is performed before taking
> >   the console lock.
> > 
> > - Commit messages and comments updated to mention the details
> >   discussed in the v2 feedback.
> 
> The patchset looks ready for linux-next. I am going to push it
> into printk/linux.git, branch rework/misc-cleanups.
> 
> I'll wait a day or two. I think that there is only very small
> chance that anyone else would do a review.

JFYI, the patchset has been comitted into pritnk/linux.git
branch rework/misc-cleanups.

Best Regards,
Petr
