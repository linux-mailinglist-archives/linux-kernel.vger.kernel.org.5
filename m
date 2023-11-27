Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C747FA538
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjK0Pv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjK0PvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:51:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EDD53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:51:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D8C433C8;
        Mon, 27 Nov 2023 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701100274;
        bh=dMMdBoN2BqOOG7XFZGjfij1v9spiiD+Ft0T9jQHrwK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u13UBGmr/+r2OEAHETE0tJMMx1HVvrpoC1O/H5pmGVM4O+QnWMjvRviAnzr9L1/NP
         A2Q8IN31bQK2bYH9QKTY2li/rmRION5Seix2jTlflfESD/RanrDzjb62FreRK+DOQL
         eceq0jNhSm0GPSqptJEm01gdS8kVjV36ZEdQFeqY=
Date:   Mon, 27 Nov 2023 15:51:10 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023112752-pastel-unholy-c63d@gregkh>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112702-postal-rumbling-003f@gregkh>
 <20231127144017.GK436702@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127144017.GK436702@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:40:17AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 27, 2023 at 01:36:54PM +0000, Greg Kroah-Hartman wrote:
> 
> > Why is this dual licensed?  Again, you are using a GPL-only api for this
> > driver, how would that even be possible to make this code be BSD?
> 
> The code to FreeBSD with mlx5 related dual licensed code integrated is
> freely available to inspect. I've never looked myself but I'm told
> FreeBSD changes the reference Linux code to remove the use of GPL
> code, and that FreeBSD has created BSD licensed versions of some
> kernel APIs to support that.

Yeah, I'm not going to get into the legality of "creating BSD licensed
versions of gpl-only Linux apis" but note, lots of lawyers look
longingly at those things when they consider early retirement :)

> > I thought we already discussed this, AND I talked to someone who
> > discussed this with a nvidia lawyer already and I thought this was going
> > to get changed.  What happened to that?
> 
> It is in the cover letter. You asked for an approval and statement
> from our legal and we obtained it. Our lawyers did a review, discussed
> with a LF contact, and continue to instruct to use the dual
> license. We've done what you required us to do.

Ah, missed that, sorry, I didn't see it in the changes for this set of
patches, it was in the previous submission.

> The summary I have of the call you refer to does not include a
> discussion or agreement about change in nvidia policy regarding mlx5
> code.
> 
> Like Dave said, our lawyers are not your lawyers. Now that we have
> involved legal, and they have given an instruction, we must follow it.

I think everyone involved is thankful that your lawyers are not mine :)

Ok, best of luck with this mess, I'll stop harping on it now and just
point out all of the other issues here.  First off, you all need to get
the network maintainers to agree that this driver is ok to do this way,
and I don't think that has happened yet, so I'll wait on reviewing the
series until that is resolved.

thanks,

greg k-h
