Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD67D0062
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjJSRWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbjJSRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:22:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DDE130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:22:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4FBC433C7;
        Thu, 19 Oct 2023 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697736121;
        bh=NQCM45/+qFYeEhJWW6awZxCcotUOpb4e7SzBzM14FMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpW5LBKYizMf17HySVdzU+MTQzKYqPxEYX2f66hLoamBoENqO59RfiB21wNbJMEN3
         nw3ubKaW/bfNi3NB+jGYlIh1k8HqejRDpMp6KUwAS9py/NEgUluiduZFvRCbNeLTCI
         cQSZqXG/b9DpFV580uI0DNKuzfdDV5yUprSHF7RU=
Date:   Thu, 19 Oct 2023 19:21:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023101913-owl-showman-5858@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh>
 <20231018185629.GD3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018185629.GD3952@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:56:29PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 18, 2023 at 08:22:39PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 18, 2023 at 03:01:28PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 18, 2023 at 10:30:00AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> > > > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > > 
> > > > For dual-licensed code, I need a LOT of documentation as to why this
> > > > must be dual-licensed, AND a signed-off-by from your corporate lawyer
> > > > agreeing to it so they convey an understanding of just how complex and
> > > > messy this will get over time and what you are agreeing to do here.
> > > 
> > > Can you provide a brief or whitepaper discussing this complexity
> > > please? This pushback is news to me, Mellanox and the RDMA ecosystem
> > > has been doing this for over 15 years now. I would need something
> > > substantive to have a conversation with our legal.
> > 
> > Have your legal talk to the LF legal working group, they are the ones
> > that told me never to mess with this license again.  I'm sure that
> > nvidia's lawyers are part of this group, so let's let them hash it
> > out.
> 
> Are you talking about OpenIB specifically or the concept of dual
> license (eg GPL/MIT) in general?

I'm talking about OpenIB specifically.

> > > However, I believe we can get an exception approval for single license
> > > MIT or BSD-3-Clause for this code.
> > 
> > GPLv2 please, otherwise again, I'm going to demand a really really good
> > reason why Linux kernel code needs a non-GPL license and again, a sign
> > off from your lawyers explaining why it must be so.
> 
> All of the Mellanox driver stack (over 400 files now!) is dual
> licensed because we have a large team of people working the Mellanox
> driver for many operating systems with many different licenses. We
> want the certainty of a permissive license for the driver code we
> supply to Linux as the team routinely references and/or re-uses
> Mellanox authored Linux driver code into other scenarios under the
> permissive side of the dual license.
> 
> For instance I could easily see the work Saeed has done here finding
> its way into FreeBSD. We significantly support FreeBSD employing
> maintainers and develop a sophisticated Mellanox driver over
> there. This would not be possible without the Linux driver being dual
> licensed.

Yes it would, you can take the work that you all do and license it under
the BSD license and put it into FreeBSD just fine.  But you are saying
you require Linux developers to help you with your FreeBSD drivers,
which is not always fair or nice to take from others that way (in my
opinion.)

> This has been the direction from our legal for a long time.

I know, but the OpenIB license is known to have issues, and so I thought
they were going to stop using it for new code.

> AFAIK this has also been a long time accepted Linux practice, there
> are many examples in the driver tree. What has changed now that Saeed
> tries to add 3 more files the giant driver? I need a bigger
> explanation if we are going to revisit this practice with our legal.

"the giant driver"?  I'm confused.

> To be clear, we can surely get the approvals to remove the offensive
> OpenIB from these files. eg mlxsw is already approved using
> "BSD-3-Clause OR GPL-2.0".

For your new files, please make them single license.  If you insist on
dual licensing them, I will insist on have a lawyer sign off on them so
that they understand the issues involved with dual licenses, and just
how much I hate them in the kernel tree as they are a pain over time.

Note, this isn't special to you, I do this to all new files sent to me
with this type of non-GPL-only license, see the archives for details.

> Further, as a maintainer myself, is this now the community consensus
> expected review standard?  When was it discussed? I do not see
> evidence of a ban on dual licensing in
> https://docs.kernel.org/process/license-rules.html ?

It's based on my experience with existing dual licensed kernel code AND
discussing it with many many lawyers over the years.  It's a pain, they
hate it, it's dubious if it actually helps anyone out in any other
operating system (as again, you can take your work and send it to
FreeBSD just fine), it is messy when dealing with gpl-only exports (like
the driver model or the USB layer), and you are taking something from
the community (free labor) to help other operating systems out when the
Linux developers might not realize it.

I think the only real place this works out is the ACPI core, for the
obvious reasons that we all want a solid ACPI core that all operating
systems can use.  And Intel goes through a lot of extra effort and time
and energy to keep that going, so it is costing them real money to do
this work for this, so that makes sense.  For just a hardware driver for
a specific company, this feels very selfish in my opinion.

I would be really interested in if you all actually have taken any
not-from-your-company changes to your drivers and copied that into other
operating systems for anything "real" that wasn't just tiny bugfixes.
Have you?  If not, why go through this hassle?

thanks,

greg k-h
