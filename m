Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B851A7BAF71
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjJFAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJFABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:01:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FD9F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:01:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C7AC433C8;
        Fri,  6 Oct 2023 00:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696550483;
        bh=YkijMBbFVjGFOzqkf7uxAZwstAExYLNhTt6m3tQnUn0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=enLHNHLHgC8Q2/ee0PxnLCsqVh5ceCG4t207hkKFM/f7cnYbP2sxuqKLbGSlIHI70
         9TlirDgUXiY93/0Y9ypfBxLThwoLP/zDut/13aepZR4x9DPlYrjsC6EW83KT4/A4X9
         R0LGSC9pD2La46rbyMI4u/goPLhbxbI3mB+i5dyzsW7sj8CFG39pbsSzW3OtG5H4BB
         c7mCx63BWTNUS1v4xUPLpUvxYn7wdxW8VPgefLkzBsrUU7rPXZInxwNjXrqwdqVMWP
         mHdouc+aAqfyp6dSZrFbycGJFjaYgB1FTxI9XXzxnfhV9q7cwPw0mR7MUCVb/u4HoR
         +uXJCOCJUSZgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 947D0CE0867; Thu,  5 Oct 2023 17:01:22 -0700 (PDT)
Date:   Thu, 5 Oct 2023 17:01:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Message-ID: <23bc3841-4cda-4a23-a67f-a944e1104f1d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
 <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
 <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
 <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
 <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:30:52PM -0600, Shuah Khan wrote:
> On 10/5/23 14:58, Paul E. McKenney wrote:
> > On Thu, Oct 05, 2023 at 10:28:05PM +0200, Thomas Weißschuh wrote:
> > > On 2023-10-05 14:15:31-0600, Shuah Khan wrote:
> > > > Hi Thomas,
> > > > 
> > > > On 10/5/23 11:00, Thomas Weißschuh wrote:
> > > > > Hi Shuah,
> > > > > 
> > > > > I'd like to test the current state of nolibc in linux-next.
> > > > > Could pull the request below into your nolibc branch?
> > > > > 
> > > > > I'll do some manual tests this weekend, too.
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > Thomas
> > > > > 
> > > > > 
> > > > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > > > > 
> > > > >     Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >     https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc/next
> > > > > 
> > > > > for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> > > > > 
> > > > >     tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> > > > 
> > > > Absolutely. Do you mind tagging and pushing the tag and send
> > > > pull request with the tag?
> > > 
> > > Sure, here it is:
> > > 
> > > 
> > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> > > 
> > >    Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-next.2023.10.05a
> > > 
> > > for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> > > 
> > >    tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> > 
> > Looks good on my laptop:
> > 
> > make run:
> > 
> > 	160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> > 
> > make run-user:
> > 
> > 	160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> > 
> > Shuah, I can take nolibc for the upcoming merge window (I believe that
> > it is my turn to do so), but if you would prefer to take them, that also
> > works for me.  Either way, just let me know.
> 
> Yes it is your turn. Please go ahead and take them.

Very good, I will merge them in and post them to the relevant email lists.

> I will pull and do testing and update you on how it went.

Looking forward to seeing what you find!

							Thanx, Paul
