Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4720A7B7C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbjJDJg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjJDJgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:36:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B5AAC;
        Wed,  4 Oct 2023 02:36:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D508C433C9;
        Wed,  4 Oct 2023 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696412211;
        bh=mFEKlHahuJsICiDMySGxK7ORPKhGXJhp560qFnvIK6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ab4/sxLDgwGHrrYBzlGL/GS5cDksAXca8QM+qTGrIRk1Plg9ZId5Cqh2N9pkr2yWp
         Vy+GCThHWMHC8ESG5ZWF7H8gP6Qvy5ZjsmRyqpYUX5XdCWKu+PEqaT6wcvtPFKVatU
         julVxL4cUaOcLSij4F/iyAM8wYsq6iDNn9vCE3mFno+i/eS/nE5XJt2s91o5YXViT3
         H/qeKch+XDbFz+H2RdJJK5SEIs/RW5bBLGUECBYXpyHOyPJC7VXEkWnWTQoO1q6wln
         aI57YFsff1izAk8sxqfB5alrWjIWY7oo8wtIEdxkheVsMjS0jPkftqI174JrC5c3rK
         84EuFm6NAW2UQ==
Date:   Wed, 4 Oct 2023 11:36:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <ZR0yMdyoA5biYYxg@lothringen>
References: <20231003232903.7109-1-frederic@kernel.org>
 <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <1d21ceee-56d3-4784-9e6f-0a766c773833@paulmck-laptop>
 <811d08e3-efb8-4398-8fbc-6b5d030afb15@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811d08e3-efb8-4398-8fbc-6b5d030afb15@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:30:45PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 03, 2023 at 08:21:42PM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 03, 2023 at 05:35:31PM -0700, Paul E. McKenney wrote:
> > > On Wed, Oct 04, 2023 at 01:28:58AM +0200, Frederic Weisbecker wrote:
> > > > Hi,
> > > > 
> > > > This contains a fix for "SRCU: kworker hung in synchronize_srcu":
> > > > 
> > > > 	http://lore.kernel.org/CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com
> > > > 
> > > > And a few cleanups.
> > > > 
> > > > Passed 50 hours of SRCU-P and SRCU-N.
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > > 	srcu/fixes
> > > > 
> > > > HEAD: 7ea5adc5673b42ef06e811dca75e43d558cc87e0
> > > > 
> > > > Thanks,
> > > > 	Frederic
> > > 
> > > Very good, and a big "Thank You!!!" to all of you!
> > > 
> > > I queued this series for testing purposes, and have started a bunch of
> > > SRCU-P and SRCU-N tests on one set of systems, and a single SRCU-P and
> > > SRCU-N on another system, but with both scenarios resized to 40 CPU each.
> 
> The 200*1h of SRCU-N and the 100*1h of SRCU-p passed other than the usual
> tick-stop errors.  (Is there a patch for that one?)  The 40-CPU SRCU-N
> run was fine, but the 40-CPU SRCU-P run failed due to the fanouts setting
> a maximum of 16 CPUs.  So I started a 10-hour 40-CPU SRCU-P and a pair
> of 10-hour 16-CPU SRCU-N runs on one system, and 200*10h of SRCU-N and
> 100*10h of SRCU-P.
> 
> I will let you know how it goes.

Very nice! It might be worth testing the first patch alone as
well if we backport only this one.

Thanks!


> 							Thanx, Paul
> 
> > > While that is in flight, a few questions:
> > > 
> > > o	Please check the Co-developed-by rules.  Last I knew, it was
> > > 	necessary to have a Signed-off-by after each Co-developed-by.
> > > 
> > > o	Is it possible to get a Tested-by from the original reporter?
> > > 	Or is this not reproducible?
> > > 
> > > o	Is it possible to convince rcutorture to find this sort of
> > > 	bug?  Seems like it should be, but easy to say...
> > 
> > And one other thing...
> > 
> > o	What other bugs like this one are hiding elsewhere
> > 	in RCU?
> > 
> > > o	Frederic, would you like to include this in your upcoming
> > > 	pull request?  Or does it need more time?
> > 
> > 						Thanx, Paul
> > 
> > > > ---
> > > > 
> > > > Frederic Weisbecker (5):
> > > >       srcu: Fix callbacks acceleration mishandling
> > > >       srcu: Only accelerate on enqueue time
> > > >       srcu: Remove superfluous callbacks advancing from srcu_start_gp()
> > > >       srcu: No need to advance/accelerate if no callback enqueued
> > > >       srcu: Explain why callbacks invocations can't run concurrently
> > > > 
> > > > 
> > > >  kernel/rcu/srcutree.c | 55 ++++++++++++++++++++++++++++++++++++---------------
> > > >  1 file changed, 39 insertions(+), 16 deletions(-)
