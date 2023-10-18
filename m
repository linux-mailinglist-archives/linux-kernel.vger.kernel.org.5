Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7317CD718
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjJRIzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJRIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:55:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D525D9D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:55:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D646CC433C7;
        Wed, 18 Oct 2023 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697619338;
        bh=lVg7SmEqH1QYG5QniJ6rbcWXYx8yYk/Zzzta1tvHf4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6PkBK5B6JHzLOOAoMf8yvBDN6CT/UOWrJWhFO+/GgJ8C0NdWcC+u+qYbpah78VDL
         B0ts4Kg7gBlBCCZz4BtXhpN/3axva728yPXEzG+Gp//DHWwUNaO2TwduavFeReut7K
         yXPyqlrukoYsBWgxiXnq8dKVyRHc7VeBzUsWOVLQ=
Date:   Wed, 18 Oct 2023 10:55:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023101814-thirsting-culture-1a4c@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018084908.GF5392@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018084908.GF5392@unreal>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:49:08AM +0300, Leon Romanovsky wrote:
> On Wed, Oct 18, 2023 at 10:30:00AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > 
> > For dual-licensed code, I need a LOT of documentation as to why this
> > must be dual-licensed, AND a signed-off-by from your corporate lawyer
> > agreeing to it so they convey an understanding of just how complex and
> > messy this will get over time and what you are agreeing to do here.
> 
> This is how we (NBU, Networking Business Unit in Nvidia, former Mellanox)
> are instructed to submit all our code by default. This license is aligned
> with our networking, vdpa and RDMA code.

Please don't do this without a really really good reason.  Especially
for a "misc" driver that is so linux-dependant here.  The "Linux-OpenIB"
license is old, obsolete, and problematic and should not be added to any
new files in the kernel tree, outside of the island of
drivers/infiniband/ as you all insist on that crazyness there.

Heck, it's even documented that you shouldn't be adding that license to
any new files, why ignore that?

thanks,

greg k-h
