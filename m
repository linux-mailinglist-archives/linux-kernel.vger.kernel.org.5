Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1727C4834
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbjJKDL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbjJKDL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:11:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4D91;
        Tue, 10 Oct 2023 20:11:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48790C433C8;
        Wed, 11 Oct 2023 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696993914;
        bh=AXgUV+2CRn8Qf+Z1JZzAhV/nmd0AYybcOxTXzVIQ+Q8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DfX+YiubCin2Z/6XCWXmNTXfD0fuRPiIkKkthIYgQhgT4wgfbi6e3/YuwMoavWNGw
         K6sQ8dMmjuhrjAtnZaajRx6PdW/kVb7LmWpW4YHVBMvZy6Gbb11s9H8hzBGCzquShg
         nuxVFTi2lcOWTHRkLGEf8SgyjpY8IZD80Yfh1HsQ7n49yN4tB2LA7LjKCbVs+Ol31y
         YhsChmKUR1ayf3BEZqPYDjNjebzENfZ0+HweDbB3bm5O/ovDtI8YCUUBd4SrmsbjIG
         0dSkieVi8zpAaBGiDZd9J+rcqTqsndsJfOicq/sdn1tCpoql6tLg71Ngony2lfhVFk
         SbDhEwHgsk/4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D6290CE0D02; Tue, 10 Oct 2023 20:11:53 -0700 (PDT)
Date:   Tue, 10 Oct 2023 20:11:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        Ingo Molnar <mingo@kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <74a31adc-7a14-414d-a2be-dfa893853d19@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231004175203.943277832@linuxfoundation.org>
 <CA+G9fYunnEUT2evdabX1KOTiryP1heNHWDH4LWZCt2SVRmnKOA@mail.gmail.com>
 <20231006162038.d3q7sl34b4ouvjxf@revolver>
 <57c1ff4d-f138-4f89-8add-c96fb3ba6701@paulmck-laptop>
 <20231006175714.begtgj6wrs46ukmo@revolver>
 <7652477c-a37c-4509-9dc9-7f9d1dc08291@paulmck-laptop>
 <CAEXW_YS16NxPxg52T=3FcyZ2qocj36zKyhPnEQL3nBTbD-qJ-A@mail.gmail.com>
 <9470dab6-dee5-4505-95a2-f6782b648726@paulmck-laptop>
 <CAEXW_YTYzoAfOcgYA-N7VJYJoZTVX2=GtDrZc19RXoAXidbvyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTYzoAfOcgYA-N7VJYJoZTVX2=GtDrZc19RXoAXidbvyA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:44:16PM -0400, Joel Fernandes wrote:
> On Sun, Oct 8, 2023 at 9:20 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > > > How frequent is this function called?  We could check something for
> > > > > early boot... or track down where the cpu is put online and restore idle
> > > > > before that happens?
> > > >
> > > > Once per RCU Tasks Trace grace period per reader seen to be blocking
> > > > that grace period.  Its performance is as issue, but not to anywhere
> > > > near the same extent as (say) rcu_read_lock_trace().
> > > >
> > > > > > > It's also worth noting that the bug this fixes wasn't exposed until the
> > > > > > > maple tree (added in v6.1) was used for the IRQ descriptors (added in
> > > > > > > v6.5).
> > > > > >
> > > > > > Lots of latent bugs, to be sure, even with rcutorture.  :-/
> > > > >
> > > > > The Right Thing is to fix the bug all the way back to the introduction,
> > > > > but what fallout makes the backport less desirable than living with the
> > > > > unexposed bug?
> > > >
> > > > You are quite right that it is possible for the risk of a backport to
> > > > exceed the risk of the original bug.
> > > >
> > > > I defer to Joel (CCed) on how best to resolve this in -stable.
> > >
> > > Maybe I am missing something but this issue should also be happening
> > > in mainline right?
> > >
> > > Even though mainline has 897ba84dc5aa ("rcu-tasks: Handle idle tasks
> > > for recently offlined CPUs") , the warning should still be happening
> > > due to Liam's "kernel/sched: Modify initial boot task idle setup"
> > > because the warning is just rearranged a bit but essentially the same.
> > >
> > > IMHO, the right thing to do then is to drop Liam's patch from 5.15 and
> > > fix it in mainline (using the ideas described in this thread), then
> > > backport both that new fix and Liam's patch to 5.15.
> > >
> > > Or is there a reason this warning does not show up on the mainline?
> > >
> > > My impression is that dropping Liam's patch for the stable release and
> > > revisiting it later is a better approach since tiny RCU is used way
> > > less in the wild than tree/tasks RCU. Thoughts?
> >
> > I think that this one is strange enough that we need to write down the
> > situation in detail, make sure we have all the corner cases covered in
> > both mainline and -stable, and decide what to do from there.
> >
> > Yes, I know, this email thread contains much of this information, but
> > a little organizing of it would be good.
> >
> > Would you like to put that together, or should I?  If me, I will get
> > a draft out by the end of this coming Tuesday, Pacific Time.
> 
> I apologize, I haven't been able to do any real work as I was OOO for
> the most part due to dental issues. I am about 25% back now. I will
> review your other email writeup and thanks for putting it together!

No need to apologize!  If anything, it is I who should apologize for
not digging deeply into this to begin with.  As always, there were
distraction.  ;-)

							Thanx, Paul
