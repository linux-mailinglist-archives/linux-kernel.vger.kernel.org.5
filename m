Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F717B7EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJDMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjJDMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:06:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F71A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5SMzdHJ+/8TCkE6AZwhEArOMBBJJHdiazKEqMlVBPvY=; b=oSj9JHUiYi70xvhTpCXNQIFxuh
        x4Q/Ha4ZtRwK37wJVrKOAH5RKZGshEZXnGBtYCNXTaNYxUEQoqWMNKqApz6Jw9z3OZeaxuVQsBqWQ
        WHCTMv2oAi5HXmiCCA5njsy2va1EBWTCRew5Rh6HgkoxCEszq9l2SN0Sq3VofFXg4y6i0nqTdCM2h
        Z1IjNitvuBkd7nRDzbkI4bNNMot2I+iL6FKyQ0AhWfp8FrAUp57L0FFlVmBz3SvWxTinXi4P/1vT3
        TMYhs7DaDl00Sd98lkk4/lJ72m8rier8BIX2sktxyeBmgAZEeYBW9vsB8MN7XDPIMBPaUNVLqRWoY
        jDrbHcPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qo0dL-00Am0Q-31;
        Wed, 04 Oct 2023 12:05:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0413F300392; Wed,  4 Oct 2023 14:05:45 +0200 (CEST)
Date:   Wed, 4 Oct 2023 14:05:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
Message-ID: <20231004120544.GA6307@noisy.programming.kicks-ass.net>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <20231003215159.GJ1539@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2310041358420.3108@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310041358420.3108@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:01:26PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 3 Oct 2023, Peter Zijlstra wrote:
> 
> > On Tue, Oct 03, 2023 at 10:25:08PM +0200, Julia Lawall wrote:
> > > Is it expected that the commit e8f331bcc270 should have an impact on the
> > > frequency of NUMA balancing?
> >
> > Definitely not expected. The only effect of that commit was supposed to
> > be the runqueue order of tasks. I'll go stare at it in the morning --
> > definitely too late for critical thinking atm.
> 
> Maybe it's just randomly making a bad situation worse rather than directly
> introduing a problem.  There is a high standard deviatind in the
> performance.  Here are some results with hyperfine.  The general trends
> are reproducible.

OK,. I'm still busy trying to bring a 4 socket machine up-to-date...
gawd I hate the boot times on those machines :/

But yeah, I was thinking similar things, I really can't spot an obvious
fail in that commit.

I'll go have a poke once the darn machine is willing to submit :-)
