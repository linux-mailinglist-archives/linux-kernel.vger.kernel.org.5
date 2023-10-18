Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533867CE63E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjJRSWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjJRSWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:22:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E9B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:22:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE4FC433C7;
        Wed, 18 Oct 2023 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697653362;
        bh=Z0/kyvAglhtuyBQOMTn6iPapzzkCidyo198TuQNITBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZv3gjUGPoaC+V1xBLzmI8fMPLyNbjqnoJwX9KTAonIueexqkILH8Mm1yw7WsXMzP
         OxLlTolJ7W4WWffGhiZP+T2nwjyB+WFNNU3fJk1bwSsv3WZbCvoSm7Fjbgx3ZGXpGv
         gWiEhiPIVdxsfztRhdCef36rCjSDylYctRe5GcBw=
Date:   Wed, 18 Oct 2023 20:22:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023101808-quicksand-roman-0da7@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018180128.GA719006@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:01:28PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 18, 2023 at 10:30:00AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > 
> > For dual-licensed code, I need a LOT of documentation as to why this
> > must be dual-licensed, AND a signed-off-by from your corporate lawyer
> > agreeing to it so they convey an understanding of just how complex and
> > messy this will get over time and what you are agreeing to do here.
> 
> Can you provide a brief or whitepaper discussing this complexity
> please? This pushback is news to me, Mellanox and the RDMA ecosystem
> has been doing this for over 15 years now. I would need something
> substantive to have a conversation with our legal.

Have your legal talk to the LF legal working group, they are the ones
that told me never to mess with this license again.  I'm sure that
nvidia's lawyers are part of this group, so let's let them hash it out.

> However, I believe we can get an exception approval for single license
> MIT or BSD-3-Clause for this code.

GPLv2 please, otherwise again, I'm going to demand a really really good
reason why Linux kernel code needs a non-GPL license and again, a sign
off from your lawyers explaining why it must be so.

thanks,

greg k-h
