Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48FD7BA7EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjJERZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjJERYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:24:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF2D68;
        Thu,  5 Oct 2023 10:19:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD375C433C7;
        Thu,  5 Oct 2023 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526365;
        bh=ImH4hBROcQO8OclfAaS2tU+C5QjQO0C4fsxB795ZawU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c+xrTl8IjIHXfYNz2vfmlgc58XDtY9T5FW1Bu8wX8XRjcFDMjkujitNV8knKEV0yf
         zZsJgi33q+JFNlcqAE2wqUJ5TNu8MFV9FWJocbS1ysfSgzmyytzEs+wH6M7pF478bi
         6DUnIKwsYT1ksf0gmMxDbAWD2OrTpv97xmXDYHkrz9lhQ8+1KJkLYuDmOvd736VVtl
         XktSuolqu+5VKIeI0bVFC6Xeo2awsCp+zlJMvckXuqHaD25zSbgaGJJn537tJgZZVe
         0wvBgyEqd676FB4dtbZlrfSAL7vN3FUJUq+xpP7kysNgSV0JnErKJ5ohd0MceIJY0Z
         19MAjTOJV8HGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7134FCE0869; Thu,  5 Oct 2023 10:19:25 -0700 (PDT)
Date:   Thu, 5 Oct 2023 10:19:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the rcu tree
Message-ID: <6219e7f4-3787-410e-85a2-d7513b0e5fee@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231002114116.72211394@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002114116.72211394@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:41:16AM -0400, Steven Rostedt wrote:
> On Wed, 27 Sep 2023 11:53:30 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > The following commits are also in the ftrace tree as different commits
> > (but similar patches):
> > 
> >   8f2612479c71 ("doc: Add /proc/bootconfig to proc.rst")
> 
> This one looks like it has some whitespace issues (according to git show).
> 
> >   648c895fda8d ("doc: Update /proc/cmdline documentation to include boot config")
> > 
> > These are commits
> > 
> >   5f4028880652 ("doc: Add /proc/bootconfig to proc.rst")
> >   6eab72b5fea3 ("doc: Update /proc/cmdline documentation to include boot config")
> > 
> > in the ftrace tree.  They are causing a conflict due to the differences.
> > 
> > I am guessing that the commits in the ftrace tree are an older verison?
> > 
> 
> It looks like the commits in the for-next branch were nacked by Linus due
> to a commit in between the above two.
> 
>   https://lore.kernel.org/all/CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com/
> 
> Masami, can you update your for-next bootconfig branch? If Paul is taking
> the patches, I'm guessing we can just drop them.

I finally got my act together and send out the new series, apologies
for the delay!

This should become visible here in the due course of events:

https://lore.kernel.org/lkml/6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop/

							Thanx, Paul
