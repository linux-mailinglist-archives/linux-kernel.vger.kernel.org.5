Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F77BC8B2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjJGPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjJGPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:42:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC6B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 08:42:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5698AC433C8;
        Sat,  7 Oct 2023 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696693374;
        bh=/iyHifSfLpw8WdMXMnTc/3DTWsdztwFlh1/HGuNeDE4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kGLXnJ3DZygaSz2DtHpJ9drRx83j4ysR7Lpw0IB8r+h/flnSsO1dOpc5AAtRWZTAo
         uQFlO8Cba5YrO5qZWSg8+I3re+yVX+/DB80Dq9n8UAXU5pR8fUOBkGd01yvqNeS9Sa
         X++baYItRzgCMKp/qJD5z2ZLJqbUeUqtTWrHA8A9Gww1SBDEHbzDoA+uSfhSyRdq8z
         yC1v+mJY2AS1hXytfOXEX5soryRGuV0OcY+cfXqwqzkpMrirH4FBgvJkmpJYuyZtJ8
         ALoq1g9wBnUk4KULQcyKt2I1bhDKTv4qYDjVKd69luiIVDLt5as8AHIG2IFjuOzyLJ
         NeyUvAKSh9x3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D6A10CE09ED; Sat,  7 Oct 2023 08:42:53 -0700 (PDT)
Date:   Sat, 7 Oct 2023 08:42:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <d80c1da1-56f8-4b94-b1e2-eef75a52d022@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
 <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
 <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
 <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
 <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
 <23bc3841-4cda-4a23-a67f-a944e1104f1d@paulmck-laptop>
 <20231007070630.GB20998@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007070630.GB20998@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:06:30AM +0200, Willy Tarreau wrote:
> On Thu, Oct 05, 2023 at 05:01:22PM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 05, 2023 at 03:30:52PM -0600, Shuah Khan wrote:
> > > On 10/5/23 14:58, Paul E. McKenney wrote:
> > > > On Thu, Oct 05, 2023 at 10:28:05PM +0200, Thomas Weißschuh wrote:
> > > > > On 2023-10-05 14:15:31-0600, Shuah Khan wrote:
> > > > > > Hi Thomas,
> > > > > > 
> > > > > > On 10/5/23 11:00, Thomas Weißschuh wrote:
> > > > > > > Hi Shuah,
> > > > > > > 
> > > > > > > I'd like to test the current state of nolibc in linux-next.
> > > > > > > Could pull the request below into your nolibc branch?
> > > > > > > 
> > > > > > > I'll do some manual tests this weekend, too.
> > > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Thomas
> > > > > > > 
> > > > > > > 
> > > > > > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > > > > > > 
> > > > > > >     Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > > > > > > 
> > > > > > > are available in the Git repository at:
> > > > > > > 
> > > > > > >     https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc/next
> > > > > > > 
> > > > > > > for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> > > > > > > 
> > > > > > >     tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> > > > > > 
> > > > > > Absolutely. Do you mind tagging and pushing the tag and send
> > > > > > pull request with the tag?
> > > > > 
> > > > > Sure, here it is:
> > > > > 
> > > > > 
> > > > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > > > > 
> > > > >    Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-next.2023.10.05a
> > > > > 
> > > > > for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> > > > > 
> > > > >    tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> > > > 
> > > > Looks good on my laptop:
> > > > 
> > > > make run:
> > > > 
> > > > 	160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> > > > 
> > > > make run-user:
> > > > 
> > > > 	160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> > > > 
> > > > Shuah, I can take nolibc for the upcoming merge window (I believe that
> > > > it is my turn to do so), but if you would prefer to take them, that also
> > > > works for me.  Either way, just let me know.
> > > 
> > > Yes it is your turn. Please go ahead and take them.
> > 
> > Very good, I will merge them in and post them to the relevant email lists.
> > 
> > > I will pull and do testing and update you on how it went.
> > 
> > Looking forward to seeing what you find!
> 
> In the list I'm seeing this one which is a fix for breakage introduced
> in 6.6-rc1:
> 
>   commit 3c9b7c4a228bf8cca2f92abb65575cdd54065302 (korg-nolibc/fixes, 20230830-nolibc-fixes)
>   Author: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>   Date:   Wed Aug 30 08:02:23 2023 +0700
> 
>     tools/nolibc: i386: Fix a stack misalign bug on _start
>     
>     The ABI mandates that the %esp register must be a multiple of 16 when
>     executing a 'call' instruction.
>   ...
> 
> We'll have to send it separately so that it gets into 6.6 soon enough.
> And I think the update of the tree location in the MAINTAINERS file
> would be deserved as well.
> 
> Paul, Shuah, what's the preferred way for you to get fixes for the current
> kernel now ? Do you prefer a PR based on a specific branch or just a patch ?

The easiest for me would be if you rebased your stack on top of this
new fix, all still based on v6.6-rc1.  I can then pull the new stack,
including fix, test it, and submit the fix to Linus in a few days,
assuming testing goes well.

Would something else work better for you guys?

							Thanx, Paul
