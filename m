Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B407575FACE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGXPbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:31:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BE5E57
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9D2F611E9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A563C433C7;
        Mon, 24 Jul 2023 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690212698;
        bh=a324P+M3DLkB7pmLUT2cGrkjY2jYG99N/9ZZ6Lhnack=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W0jSKEbh7OmSg97XQc37nDQKIaPpptIAfLZE76dfzFF9gqiIxaL1e+qmjewh2BQtv
         Djj32OXFrEj1mJ2+90jIPs9MbPANA7YIyJDCv2jiNRirGq6TuGUluFAw6Flcabg+td
         VLSeDHb0s+Oczv/nh7dqWTsmsc+QgIOv6HaVEpSIBY33MXcVfw4U8uMeHGaj5mUBRq
         /0rLDnRWeATeAxDSqgRSnJPj+eiX60GAhAKReLJ0eovvvQPCBIdw5xSMw70vYAGvKg
         an3ybZSjBc4p4V1jD63Rosvln1c+qcesj2LvSRp6ucWczlvCmBiHp266ty5lW/ZbIB
         aUjWZkkLjE2PA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9FE0CE0C4B; Mon, 24 Jul 2023 08:31:37 -0700 (PDT)
Date:   Mon, 24 Jul 2023 08:31:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Upcoming nolibc pull request for the next merge window
Message-ID: <b15fa4c4-cb1f-4bf6-af04-5d549f326f95@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop>
 <20230722130120.6e4c0eab@canb.auug.org.au>
 <2c54d017-226e-41c3-a767-a607942ecba5@paulmck-laptop>
 <5d9f724d-4c45-f843-04b3-60a907b9b127@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d9f724d-4c45-f843-04b3-60a907b9b127@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:49:40AM -0600, Shuah Khan wrote:
> On 7/21/23 22:48, Paul E. McKenney wrote:
> > On Sat, Jul 22, 2023 at 01:01:20PM +1000, Stephen Rothwell wrote:
> > > Hi Paul,
> > > 
> > > On Fri, 21 Jul 2023 10:39:48 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > 
> > > > This is just to let you know that Willy and I are adding co-maintainers
> > > > for nolibc.  Shuah Khan will join me as administrative maintainer,
> > > > and will be sending the pull request to you for the next merge window.
> > > > 
> > > > Similarly, Thomas Weißschuh will be joining Willy as technical maintainer
> > > > for nolibc.  With luck, this won't affect you, but in case you come across
> > > > a nolibc issue, please reach out to Thomas as well as Willy, Shuah,
> > > > and myself.  There will of course be an update to the MAINTAINERS file
> > > > in the near future, but just to let you know in the meantime.
> > > 
> > > Would it make sense to add a separate nolibc branch to linux-next (and
> > > no longer merge it into the rcu branch?  Or are there dependencies
> > > between the two?
> > 
> > Dependencies between nolibc and RCU are extremely rare, so it might well
> > make sense to have a separate branch.
> > 
> > Maybe nolibc/next from either the -rcu tree or Shuah's tree?  Shuah,
> > would something else work better for you?
> > 
> 
> We probably have to add linux-kselftest nolibc and rcu nolibc since
> we are planning to alternating pull requests?
> 
> Paul, you and I have to make sure we don't have duplicate patches
> in our nolibc branches.

If the duplicate patches all have the same SHA-1 hashes, we should be
good, right?  Or am I missing something subtle here?

							Thanx, Paul
