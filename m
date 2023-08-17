Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A177FE15
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354540AbjHQSrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbjHQSrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B02D59;
        Thu, 17 Aug 2023 11:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B198E63540;
        Thu, 17 Aug 2023 18:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A66C433C8;
        Thu, 17 Aug 2023 18:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692298018;
        bh=5/NS1z4J2PBo2ezppbVzIbfuP1XdafGF7B169Ez7FV8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WqTRxH0hBVbOLjDMR3YrV585m80gzxINUXoSQO0jZlgdQ01/7pb0sDcTb4+oy6/L7
         ZDP1EmI4I6qKWYvae2AkY7MOU/S/VkD4Y9R5vJZJYxplUtZJ0GD5heXeD5xfXcNZH5
         6id9pYu+0WjRkMBk9LjgPtKnySTO+mc15pROlvYa0ubVWCLT0efCmArcP9oQPhNLB8
         BwvFRHeV/v6HIhirngGRuXkH9MeM4Rl9qBcJvuV5JhNwCICLuH8pB39CVMwjARZSOp
         5hqvEkEpRZs271KSk50fOvV3IFuT017K6qA9KTfbUIk4Xxa3c5313MqbQQWtCIL7g7
         oC9HiVfYOvw5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D326CE0F13; Thu, 17 Aug 2023 11:46:57 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:46:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Willy Tarreau <w@1wt.eu>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nolibc tree
Message-ID: <4c037ef2-9159-4528-8ecb-8596cb2a3889@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230817133811.0a73c624@canb.auug.org.au>
 <e0af8d82-e099-49fa-9fbd-6f6bb63b7706@t-8ch.de>
 <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:27:46PM -0600, Shuah Khan wrote:
> On 8/17/23 10:30, Thomas Weißschuh wrote:
> > On 2023-08-17 13:38:11+1000, Stephen Rothwell wrote:
> > > The following commit is also in the vfs-brauner tree as a different commit
> > > (but the same patch):
> > > 
> > >    ba859b2e419c ("selftests/nolibc: drop test chmod_net")
> > > 
> > > This is commit
> > > 
> > >    49319832de90 ("selftests/nolibc: drop test chmod_net")
> > > 
> > > in the vfs-brauner tree.
> > 
> > I think we can drop the patch from the nolibc tree.
> > The patch is only really necessary in combination with
> > commit 18e66ae67673 ("proc: use generic setattr() for /proc/$PID/net")
> > which already is and should stay in the vfs tree.
> 
> Thomas,
> 
> Do the rest of the nolibc patches build without this if we were
> to drop this patch? Dorpping requires rebase and please see below.
> 
> Willy, Paul,
> 
> How do we want to handle this so we can avoid rebasing to keep
> the Commit IDs the same as one ones in Willy's nolibc branch?

The usual way would be for Willy to drop the patch, rebase, and republish
his branch.  You would then discard the current branch and pull the
new one.

> I would recommend dropping this commit from vfs-brauner if it
> doesn't cause problems.

It might be good for nolibc patches to be going through Willy's tree.

Or does Christian have some situation where it is necessary to make
a coordinated vfs/nolibc change?

							Thanx, Paul
