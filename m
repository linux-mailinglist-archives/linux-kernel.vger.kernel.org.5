Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B0D77FE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354712AbjHQTkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354217AbjHQTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:39:54 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E63110E9;
        Thu, 17 Aug 2023 12:39:52 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37HJd92U030534;
        Thu, 17 Aug 2023 21:39:09 +0200
Date:   Thu, 17 Aug 2023 21:39:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nolibc tree
Message-ID: <20230817193909.GA30505@1wt.eu>
References: <20230817133811.0a73c624@canb.auug.org.au>
 <e0af8d82-e099-49fa-9fbd-6f6bb63b7706@t-8ch.de>
 <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
 <4c037ef2-9159-4528-8ecb-8596cb2a3889@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c037ef2-9159-4528-8ecb-8596cb2a3889@paulmck-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:46:57AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 17, 2023 at 12:27:46PM -0600, Shuah Khan wrote:
> > On 8/17/23 10:30, Thomas Weißschuh wrote:
> > > On 2023-08-17 13:38:11+1000, Stephen Rothwell wrote:
> > > > The following commit is also in the vfs-brauner tree as a different commit
> > > > (but the same patch):
> > > > 
> > > >    ba859b2e419c ("selftests/nolibc: drop test chmod_net")
> > > > 
> > > > This is commit
> > > > 
> > > >    49319832de90 ("selftests/nolibc: drop test chmod_net")
> > > > 
> > > > in the vfs-brauner tree.
> > > 
> > > I think we can drop the patch from the nolibc tree.
> > > The patch is only really necessary in combination with
> > > commit 18e66ae67673 ("proc: use generic setattr() for /proc/$PID/net")
> > > which already is and should stay in the vfs tree.
> > 
> > Thomas,
> > 
> > Do the rest of the nolibc patches build without this if we were
> > to drop this patch? Dorpping requires rebase and please see below.
> > 
> > Willy, Paul,
> > 
> > How do we want to handle this so we can avoid rebasing to keep
> > the Commit IDs the same as one ones in Willy's nolibc branch?
> 
> The usual way would be for Willy to drop the patch, rebase, and republish
> his branch.  You would then discard the current branch and pull the
> new one.
> 
> > I would recommend dropping this commit from vfs-brauner if it
> > doesn't cause problems.
> 
> It might be good for nolibc patches to be going through Willy's tree.

It would indeed be more logical as a general rule. However, here I don't
care as I don't see any issue caused by dropping it, I can adapt to what
is most convenient for most of us.

Let's maybe just wait a little bit for Christian to suggest what he
prefers then we can adapt.

> Or does Christian have some situation where it is necessary to make
> a coordinated vfs/nolibc change?

I don't think there's any need for coordination on this one.

Thanks,
willy
