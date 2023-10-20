Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD647D16D3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJTUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:18:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A559DD63
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:18:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA37C433C8;
        Fri, 20 Oct 2023 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697833082;
        bh=4RvsTOvcAaF1XJbU+fiHqQbsOhDrJFFpbd4oU2xE7G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wK68GtcN4lxt0UPFDLVQEwrrTej+GUPPXc2IhIHSkIyxaJKGbqzWasdmWFcMXp37n
         1C0fAKcPzyo33EgpvHf9bPeiZ9nZ2ZkB43KNEP6M0O/zF4R4H5cDdK4cjIkVuJ8K3w
         7iI8j7+OtUpOqJWaKqWE78f/kjcBxnB7GkAIVZno=
Date:   Fri, 20 Oct 2023 22:17:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023102055-italicize-slideshow-0fe2@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh>
 <20231018185629.GD3952@nvidia.com>
 <2023101913-owl-showman-5858@gregkh>
 <20231019190046.GV3952@nvidia.com>
 <2023101902-upturned-pledge-3a35@gregkh>
 <20231019234947.GX3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019234947.GX3952@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:49:47PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 19, 2023 at 09:46:29PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 19, 2023 at 04:00:46PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 19, 2023 at 07:21:57PM +0200, Greg Kroah-Hartman wrote:
> > > > > All of the Mellanox driver stack (over 400 files now!) is dual
> > > > > licensed because we have a large team of people working the Mellanox
> > > > > driver for many operating systems with many different licenses. We
> > > > > want the certainty of a permissive license for the driver code we
> > > > > supply to Linux as the team routinely references and/or re-uses
> > > > > Mellanox authored Linux driver code into other scenarios under the
> > > > > permissive side of the dual license.
> > > > > 
> > > > > For instance I could easily see the work Saeed has done here finding
> > > > > its way into FreeBSD. We significantly support FreeBSD employing
> > > > > maintainers and develop a sophisticated Mellanox driver over
> > > > > there. This would not be possible without the Linux driver being dual
> > > > > licensed.
> > > > 
> > > > Yes it would, you can take the work that you all do and license it under
> > > > the BSD license and put it into FreeBSD just fine.
> > > 
> > > Sure, you can do that at day 0, but mlx5 is now about 10 years old and
> > > has tens of thousands of commits. Many non-Mellanox commits. (mostly
> > > non-significant, IMHO, IANAL)
> > 
> > That's not the case for this specific chunk of code, so it's not a valid
> > point at all, sorry.
> 
> In 10 years it will be in the same situation as the rest of the
> driver. You are saying we can't plan ahead now? Why?

I really am confused as to what exactly the scope of this driver is
then.  For some reason I thought it was just a "here's a debug driver
that we use to query the hardware and get some performance stats out of
it at times which we used to do previously by just doing raw PCI-memory
reads".  Is this really going to blow up into a giant infrastructure
that you are going to use for real functionality over the next decades?
If so, it needs a lot better description of what exactly this driver is
supposed to be doing, and how it ties into existing userspace tools.

> > Let's stick to just this new file, please keep it one-license, not dual,
> > it makes everything simpler overall.
> 
> Simpler for who? It seems to complicate Mellanox's situation.

How in the world is Mellanox going to take the code in a aux driver for
Linux and us that in any other operating systems WITHOUT it just being
an original contribution from a Mellanox developer themself?

> More importantly it seems to represent an important philosophical
> shift for Linux that touches on something we have a significant
> investment in.

Again, this is something that I ask of any new file that is sent to me
for my approval for many many years.  There are some subsystems in Linux
(drm, IB) that have lived with dual-license code for a very long time,
but that's about it.

> I would like clarity here, on a going forward basis. You do set the
> tone for the whole project. I've made my case for why we are doing and
> why it brings value. You are saying dual license is now effectively
> banned.

I'm saying that it needs to be explicitly chosen for very good reasons.

In the past, when I have pushed back on "why are you doing this?" I have
gotten "oops, we didn't mean that or understand it at all, we'll fix it"
the majority of the times.  If your company really does understand it
and knows it, great, that's what I need to confirm here.  I don't keep a
list of what companies do/do-not know this type of thing as that would
be pointless (hint, companies buy other companies and change legal
policies...)

> Previously you said you would agree with a sign off from our legal,
> please tell me what statement you want and I will go get it.

A simple note in the changelog that says something like:
	This file is dual licensed under XXX and YYY because of the
	following reasons.... and we will be handling all contributions
	to it in the following way...

and a signed-off-by in the chain by your group's lawyer so that we know
they understand the issues.

Or some other text like this, they can figure it out as they obviously
know the issues involved, and they know what they want to express to us.

> > > Remember that Leon created auxiliary bus so these complex multi-system
> > > HWs could be split up cleanly into their respective subsystems? This
> > > is an aux device driver for the misc subsystem as part of the giant
> > > cross-subsystem mlx5 driver. Ie Saeed is adding 3 more files to that
> > > existing monster.
> > 
> > Yes, and as the auxiliary bus code is EXPORT_SYMBOL_GPL() attempting to
> > license code that is a driver for that bus (i.e. this new contribution)
> > under anything other than just GPL is crazy.  Go talk to your lawyers
> > about that please, it's obviously not ok.
> 
> The entire mlx5 driver makes free use of EXPORT_SYMBOL_GPL(). Our
> legal has looked at this in the past and they continue to give
> instruction to use a dual license.

That's odd, I wonder how you take those contributions into other
operating systems...

> You keep saying go talk to our lawyers like this hasn't been a legally
> vetted approach at Mellanox for the last 15 years :(

I keep saying this as I have no idea what company is behind this, nor
what their lawyers want, nor what has been vetted by them at all.

And this email is going to a nvidia.com address, not Mellanox, so you
can understand my "you all better get the license issues right!" wish
for me to do here, based on the past experience with "issues" from that
domain.

thanks,

greg k-h
