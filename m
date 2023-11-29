Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AC77FD1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjK2JIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjK2JIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:08:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7C1BCF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:08:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17063C433C8;
        Wed, 29 Nov 2023 09:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701248886;
        bh=Mbs0x4t+CqMkpGy0lMIoK+moU3jYt5X0anfhTkZ+s+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qm1AixzlI3RR5jPLxbiFADxzFM7MoRpe5SCxgrQR/iDciY9U0hMxIhc5HThZafaku
         9s1oOjw14SXsf8AuzsPraJaddRTZoeKm814ZDkvMYMa1x+5LlcZkLc9e/PeJVmujRq
         Ick2QFvYiwCN5FHcNm4rGnVUmn0Flsz83BcmikWU=
Date:   Wed, 29 Nov 2023 09:08:03 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023112922-lyricist-unclip-8e78@gregkh>
References: <2023112707-feline-unselect-692f@gregkh>
 <ZWTtTjgBrNxpd9IO@x130>
 <20231127160719.4a8b2ad1@kernel.org>
 <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org>
 <20231128162413.GP436702@nvidia.com>
 <20231128084421.6321b9b2@kernel.org>
 <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWZJGF7moDM_k6TU@x130>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:10:00PM -0800, Saeed Mahameed wrote:
> On 28 Nov 10:33, Jakub Kicinski wrote:
> > On Tue, 28 Nov 2023 13:52:24 -0400 Jason Gunthorpe wrote:
> > > > The question at LPC was about making devlink params completely
> > > > transparent to the kernel. Basically added directly from FW.
> > > > That what I was not happy about.
> > > 
> > > It is creating a back-porting nightmare for all the enterprise
> > > distributions.
> > 
> > We don't care about enterprise distros, Jason, or stable kernel APIs.
> > 
> 
> Oh, I missed this one, so you don't care about users?

Ok, time out please.  This isn't going anywhere fast except to make
everyone else mad.

To Jakub's point, no, we don't care about enterprise distros, they are a
consumer of our releases and while some of them pay the salaries of our
developers, they really don't have much influence over our development
rules as they are just so far behind in releases that their releases
look nothing like what we do in places (i.e. Linux "like" just like many
Android systems.)

If the enterprise distros pop in here and give us their opinions of the
patchset, I would GREATLY appreciate it, as having more people review
code at this point in time would be most helpful instead of having to
hear about how the interfaces are broken 2 years from now.

And I think that's what is driving your work now, the "enterprise"
distros finally picked up the "lock down the kernel from random PCI
device access in userspace" which caused you to have to drop your
userspace implementation to create a real kernel driver, correct?

And as for stable kernel apis, you all know that's just not a thing, and
has nothing to do with users EXCEPT it benefits users because it keeps
kernel code smaller and faster overall, that's well documented and users
appreciate it.

> Users often pay to distros for support, and distros always turn to vendors
> for debug situations, in fact one of the high stakeholders for this is an
> enterprise distro..

Hey, I was right, an enterprise distro wants this driver, great, can you
get them to review it as well?  I'm tired of being the only one to
review patches like this and could use the help if they are going to
rely on this (why do they pass that work to me?).  They should be the
ones helping us catch basic things like the reference count issues I
pointed out, as they can test the code, I can't :)

But, let's step back a bit further.

It seems the network device normal interface for this is using devlink.
And drivers are allowed to have driver-specific devlink interfaces, as
you know, your driver has lots of them today.  Why not just add more?
What's wrong with 600+ more interfaces being added as that way they
would be well documented and fit in with the existing infrastructure
that you have today.

Is the issue that the firmware doesn't guarantee that these interfaces
will be documented or stable or even known at this point in time?  If
so, how are your going to have a good userspace tool for this?  What am
I missing that requires a totally-new-and-custom user/kernel api from
what all other network drivers are using today?

thanks,

greg k-h
