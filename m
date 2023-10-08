Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F787BCF40
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbjJHQ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:27:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E6894
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:27:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CABC433C7;
        Sun,  8 Oct 2023 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696782464;
        bh=5e2wPm4fvqhAunrbeH6/dmcRGUvDHp6u0OI/Kex4i+c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HoLV3QruwusvtL6Rqcf356qHtAgnpPZKEVLEYOLP/+ZPAWryDDoRAj1M/sVxnboRK
         XuB7lH5unipB4gPiskFoQrVJ/qsJaEB9umJ6T1yyOwiKLKGawIQwG46MC8ncEhgfp0
         yp1q4vbdtyERyCU74BdrQKTo9QDLW9E/O8kK6YqQx/S6OCzZjiJbXEoN/9eSC2diuT
         bWmTIQ0aZH34AlwlUsgmJSCwJOtngsqs8A71Vzh5L+oLx4VAf2K7+H/ao72e5RHZ1n
         ztLOlr9dZuUgfAYgeVBEDY56xfc8gH8qHNzffSZOaLvUV9Hb2HEAbF5gJ+UNsD0yn0
         7yEss9AdLCvXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E6634CE0869; Sun,  8 Oct 2023 09:27:43 -0700 (PDT)
Date:   Sun, 8 Oct 2023 09:27:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <76a51116-46bb-4271-b5ac-c101e02d5a63@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
 <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
 <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
 <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
 <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
 <23bc3841-4cda-4a23-a67f-a944e1104f1d@paulmck-laptop>
 <20231007070630.GB20998@1wt.eu>
 <d80c1da1-56f8-4b94-b1e2-eef75a52d022@paulmck-laptop>
 <fad7814f-0bbd-43f0-a205-9ba2c08bac22@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fad7814f-0bbd-43f0-a205-9ba2c08bac22@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 02:58:15PM +0200, Thomas Weißschuh wrote:
> Hi Paul,
> 
> On 2023-10-07 08:42:53-0700, Paul E. McKenney wrote:
> > On Sat, Oct 07, 2023 at 09:06:30AM +0200, Willy Tarreau wrote:
> > > On Thu, Oct 05, 2023 at 05:01:22PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Oct 05, 2023 at 03:30:52PM -0600, Shuah Khan wrote:
> > > > > On 10/5/23 14:58, Paul E. McKenney wrote:
> > > > > > On Thu, Oct 05, 2023 at 10:28:05PM +0200, Thomas Weißschuh wrote:
> > > > > > > On 2023-10-05 14:15:31-0600, Shuah Khan wrote:
> > > > > > > > Hi Thomas,
> > > > > > > > 
> > > > > > > > On 10/5/23 11:00, Thomas Weißschuh wrote:
> > > > > > > > > Hi Shuah,
> > > > > > > > > 
> > > > > > > > > I'd like to test the current state of nolibc in linux-next.
> > > > > > > > > Could pull the request below into your nolibc branch?
> > > > > > > > > 
> > > > > > > > > I'll do some manual tests this weekend, too.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Thomas
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > > > > > > > > 
> > > > > > > > >     Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > > > > > > > > 
> > > > > > > > > are available in the Git repository at:
> > > > > > > > > 
> > > > > > > > >     https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc/next
> > > > > > > > > 
> > > > > > > > > for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> > > > > > > > > 
> > > > > > > > >     tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> > > > > > > > 
> > > > > > > > Absolutely. Do you mind tagging and pushing the tag and send
> > > > > > > > pull request with the tag?
> > > > > > > 
> > > > > > > Sure, here it is:
> > > > > > > 
> > > > > > > 
> > > > > > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > > > > > > 
> > > > > > >    Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > > > > > > 
> > > > > > > are available in the Git repository at:
> > > > > > > 
> > > > > > >    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-next.2023.10.05a
> > > > > > > 
> > > > > > > for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> > > > > > > 
> > > > > > >    tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> > > > > > 
> > > > > > Looks good on my laptop:
> > > > > > 
> > > > > > make run:
> > > > > > 
> > > > > > 	160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> > > > > > 
> > > > > > make run-user:
> > > > > > 
> > > > > > 	160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> > > > > > 
> > > > > > Shuah, I can take nolibc for the upcoming merge window (I believe that
> > > > > > it is my turn to do so), but if you would prefer to take them, that also
> > > > > > works for me.  Either way, just let me know.
> > > > > 
> > > > > Yes it is your turn. Please go ahead and take them.
> > > > 
> > > > Very good, I will merge them in and post them to the relevant email lists.
> > > > 
> > > > > I will pull and do testing and update you on how it went.
> > > > 
> > > > Looking forward to seeing what you find!
> > > 
> > > In the list I'm seeing this one which is a fix for breakage introduced
> > > in 6.6-rc1:
> > > 
> > >   commit 3c9b7c4a228bf8cca2f92abb65575cdd54065302 (korg-nolibc/fixes, 20230830-nolibc-fixes)
> > >   Author: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > >   Date:   Wed Aug 30 08:02:23 2023 +0700
> > > 
> > >     tools/nolibc: i386: Fix a stack misalign bug on _start
> > >     
> > >     The ABI mandates that the %esp register must be a multiple of 16 when
> > >     executing a 'call' instruction.
> > >   ...
> > > 
> > > We'll have to send it separately so that it gets into 6.6 soon enough.
> > > And I think the update of the tree location in the MAINTAINERS file
> > > would be deserved as well.
> > > 
> > > Paul, Shuah, what's the preferred way for you to get fixes for the current
> > > kernel now ? Do you prefer a PR based on a specific branch or just a patch ?
> > 
> > The easiest for me would be if you rebased your stack on top of this
> > new fix, all still based on v6.6-rc1.  I can then pull the new stack,
> > including fix, test it, and submit the fix to Linus in a few days,
> > assuming testing goes well.
> > 
> > Would something else work better for you guys?
> 
> With "stack" are you referring to only the fixes that are intended for
> v6.6?
> It sounds a bit like it should also included patches that are only meant
> for v6.7 .
> 
> If it is only for the fixes, see below the request.
> Note that I dropped the patch
> "tools/nolibc: drop test for getauxval(AT_PAGESZ)" as it's not actually
> a fix.
> 
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> 
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git fixes
> 
> for you to fetch changes up to ac06a8400561f2e4f204e88c130970fb1b9f470c:
> 
>   MAINTAINERS: nolibc: update tree location (2023-10-07 12:41:14 +0200)
> 
> ----------------------------------------------------------------
> Ammar Faizi (1):
>       tools/nolibc: i386: Fix a stack misalign bug on _start
> 
> Thomas Weißschuh (1):
>       MAINTAINERS: nolibc: update tree location
> 
>  MAINTAINERS                      | 2 +-
>  tools/include/nolibc/arch-i386.h | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

I can make it work either way, your choice.

Given a separate nolibc/fixes and nolibc/next branch, as you have now,
what I do is pull them separately.  I test the nolibc/fixes branch
and also the merge with nolibc/next.  Please see the -rcu branch
nolibc-merge.2023.10.08a to see the result.  I send a pull request
to Linus for nolibc/fixes after a few days exposure to -next testing,
and for the merge into the upcoming merge window.

Test results for nolibc/fixes:
"make run": 160 test(s): 160 passed,   0 skipped,   0 failed => status: success
"make run-user": 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning

Test results for the merge of nolibc/fixes and nolibc/next:
"make run": 160 test(s): 160 passed,   0 skipped,   0 failed => status: success
"make run-user": 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning

This approach can work well, but has a couple of potential weaknesses:

1.	Bisectability given that any bugs addressed by the "nolibc/fixes"
	branch are in full force in the "nolibc/next" branch.

2.	Any merge conflicts end up being addressed in the merge commit,
	and I might make the wrong choice for conflict resolution.

3.	There can be duplicate commits, as is currently the case for
	both commits on the "nolibc/fixes" branch.

Nonetheless, if you prefer the merge approach, we absolutely can make
this work.  For one thing, this is how many trees operate today.  But if
we take this approach, can we please base "nolibc/fixes" on top of the
"nolibc-next" commit 4b4a30ea14d1 ("tools/nolibc: i386: Fix a stack
misalign bug on _start")?

The other approach involves rebasing the "nolibc/next" stack
on top of the "nolibc/fixes" stack.  Please see the -rcu branch
nolibc-rebase.2023.10.08a to see how that would look.  Note that the
rebase process detected and eliminated the duplicate commits.
In this case, I actually used "git cherry-pick":

	git checkout -b nolibc-rebase.2023.10.08a nolibc/fixes
	git cherry-pick v6.6-rc1..nolibc/next
	git cherry-pick skip # After complaint about first duplicate
	git cherry-pick --continue
	git cherry-pick skip # After complaint about second duplicate
	git cherry-pick --continue
	git diff nolibc-merge.2023.10.08a # Verify no differences

You could just as easily do this:

	git branch nolibc-rebase.2023.10.08a nolibc/next
	git rebase --onto nolibc/next v6.6-rc1 nolibc-rebase.2023.10.08a

There would be the same complaints about duplicate commits and
similar response (it prompts you with your alternatives).

And then I send the fixes portion of the branch to Linus after a few
days of exposure to -next testing, and the full branch for the upcoming
merge window.

Test results for nolibc-rebase.2023.10.08a:
"make run": 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
"make run-user": 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning

This approach has its strenghts and weaknesses.

1.	It avoids all the weaknesses called out for merging.

2.	It can require more testing when moving yet another commit
	down into urgent-fixes portion of the branch.

3.	Many people are much less comfortable rebasing and mass
	cherry-picking than they are with merging.

Again, I am happy to do this either way (especially since I now have
both ways set up in -rcu), but felt the need to call out the strengths
and weaknesses of each approach.  Your guys' choice.

While in the area, would the following (absolutely not urgent or even
particularly important) patch be a good idea?  This gets rid of a line
of noise from "git status" after running the tests.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
index 52f613cdad54..3487da96e12e 100644
--- a/tools/testing/selftests/nolibc/.gitignore
+++ b/tools/testing/selftests/nolibc/.gitignore
@@ -3,3 +3,4 @@
 /nolibc-test
 /run.out
 /sysroot/
+/initramfs.cpio
