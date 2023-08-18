Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A6780C82
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377129AbjHRN16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377123AbjHRN1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:27:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C8112B;
        Fri, 18 Aug 2023 06:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1D94633BE;
        Fri, 18 Aug 2023 13:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924F9C433C8;
        Fri, 18 Aug 2023 13:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692365254;
        bh=ET6HsxO3daiV+0zm3C5V9Hg0Uwymi2lWnO5pCeymBA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uU1Fk3M9kH1rms2fxq6lkcHbhLpf3dVEa/QWyoK5E0og6teBUn1S9NeNOuEjGR/2T
         xTzvLl493A6wWqHwMcCQhOiFAavbd0jOeflZT2/eGP10QAgp+Dnz5bBy6O0F0vJZht
         7bryB1BIL3J9cIGbEWv24jcQG73qtKzARU6f4BKK9EqJrJvDQmM+7MRbeHOcBAsKyN
         58auMjidM04Mz4RagtMwe0mA8ZYuRi1WXM83Ai+5w+X0SopT2dkbQ/ovurNG/xCb6A
         Ch0FRdJB9I9R6qq9rY9kvKODpZ3m70RfsI7Y76dkgCF8kkDOW/tDtMlK5LrmjN41Gn
         rUTsg6rIN7nzg==
Date:   Fri, 18 Aug 2023 15:27:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nolibc tree
Message-ID: <20230818-anblicken-mitinhaber-11cd07cce0a1@brauner>
References: <20230817133811.0a73c624@canb.auug.org.au>
 <e0af8d82-e099-49fa-9fbd-6f6bb63b7706@t-8ch.de>
 <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
 <4c037ef2-9159-4528-8ecb-8596cb2a3889@paulmck-laptop>
 <20230817193909.GA30505@1wt.eu>
 <01d517c4-d91b-4426-b7f2-2b1277f21d8c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01d517c4-d91b-4426-b7f2-2b1277f21d8c@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 01:41:45PM -0700, Paul E. McKenney wrote:
> On Thu, Aug 17, 2023 at 09:39:09PM +0200, Willy Tarreau wrote:
> > On Thu, Aug 17, 2023 at 11:46:57AM -0700, Paul E. McKenney wrote:
> > > On Thu, Aug 17, 2023 at 12:27:46PM -0600, Shuah Khan wrote:
> > > > On 8/17/23 10:30, Thomas Weißschuh wrote:
> > > > > On 2023-08-17 13:38:11+1000, Stephen Rothwell wrote:
> > > > > > The following commit is also in the vfs-brauner tree as a different commit
> > > > > > (but the same patch):
> > > > > > 
> > > > > >    ba859b2e419c ("selftests/nolibc: drop test chmod_net")
> > > > > > 
> > > > > > This is commit
> > > > > > 
> > > > > >    49319832de90 ("selftests/nolibc: drop test chmod_net")
> > > > > > 
> > > > > > in the vfs-brauner tree.
> > > > > 
> > > > > I think we can drop the patch from the nolibc tree.
> > > > > The patch is only really necessary in combination with
> > > > > commit 18e66ae67673 ("proc: use generic setattr() for /proc/$PID/net")
> > > > > which already is and should stay in the vfs tree.
> > > > 
> > > > Thomas,
> > > > 
> > > > Do the rest of the nolibc patches build without this if we were
> > > > to drop this patch? Dorpping requires rebase and please see below.
> > > > 
> > > > Willy, Paul,
> > > > 
> > > > How do we want to handle this so we can avoid rebasing to keep
> > > > the Commit IDs the same as one ones in Willy's nolibc branch?
> > > 
> > > The usual way would be for Willy to drop the patch, rebase, and republish
> > > his branch.  You would then discard the current branch and pull the
> > > new one.
> > > 
> > > > I would recommend dropping this commit from vfs-brauner if it
> > > > doesn't cause problems.
> > > 
> > > It might be good for nolibc patches to be going through Willy's tree.
> > 
> > It would indeed be more logical as a general rule. However, here I don't
> > care as I don't see any issue caused by dropping it, I can adapt to what
> > is most convenient for most of us.
> > 
> > Let's maybe just wait a little bit for Christian to suggest what he
> > prefers then we can adapt.
> > 
> > > Or does Christian have some situation where it is necessary to make
> > > a coordinated vfs/nolibc change?
> > 
> > I don't think there's any need for coordination on this one.
> 
> It is always good when either option can be make to work.  ;-)

The patch in the vfs tree will make the test fail so it makes sense to
have both go in together. I would normally be happy to drop it but I'm
rather unenthusiastic in this particular case because I replied to this
almost 5 weeks ago on Thursday, July 13 and since then this has been in
-next.

commit 49319832de90f1943264e5c573b072947af6ae26
Author:     Thomas Weißschuh <linux@weissschuh.net>
AuthorDate: Sat Jun 24 12:30:46 2023 +0200
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Thu Jul 13 13:55:14 2023 +0200

    selftests/nolibc: drop test chmod_net

