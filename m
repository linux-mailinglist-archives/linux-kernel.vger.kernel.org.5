Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72CC7CFF70
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjJSQXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:23:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E412A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:23:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7465C433C7;
        Thu, 19 Oct 2023 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697732627;
        bh=lxaURj02Vwvt66ydUDp5plLrylT1y3gZ/9SIkcTdF/g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=naPZHnR77h9MQVWCQYXc2etDYymzeNR5LcBeGzecUYCMOc7RNhSEGbre7JLObTS1L
         /3fMBbhP2PXEP8MVa/Wz11t4kLOw7GA0UE0p6QB4WdgSB0HwfeH4RCgtton7HEP6ac
         N5eVohHBJwSV61OsYlWW5YL6r7MPAzGWWnSIHPirSVJSEb4OgleL+tqjcOQgF0ixBr
         PIYgGvU8feSXej5B7SD+Yn6v8bkZ7ipG3rmDsM+cShnvwrlrAmY65x1O2r93MPnh4I
         Yb1qPVrCkc1BFtwgWTfHX7mh0fSZ7K0aaAI9QI6ephJf3974AMWR6FAWRG5CvKPhSg
         3GRal0Vf6UCAg==
Date:   Thu, 19 Oct 2023 09:23:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: mlx5 ConnectX diagnostic misc driver
Message-ID: <20231019092346.3387fad6@kernel.org>
In-Reply-To: <20231019160145.GS3952@nvidia.com>
References: <20231019082451.785aa123@kernel.org>
        <2023101923-tried-provable-72e7@gregkh>
        <20231019160145.GS3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 13:01:45 -0300 Jason Gunthorpe wrote:
> Do you have a lore link?

No, it was pitched at conferences:

Last year's LPC: https://www.youtube.com/watch?v=JGR9ZCeiW-E
This year's netconf / KR, but Saeed didn't have slides:
https://netdev.bots.linux.dev/netconf/2023/index.html

Really, you should be asking Saeed this, not me.

> Looking at Saeed's tool capability on his github it is significantly,
> but not exclusively supporting RDMA (ie drivers/infiniband), with some
> features for the mlx5 VFIO drivers, mlx5 VDPA and a bunch of lowlevel
> PCI stuff too.
> 
> Calling it a "networking device" in the sense of "it is owned only be
> netdev" is not accurate.

Yes, let's now have a pointless augment about when a NIC is a NIC
and when it's no longer a NIC because it has offloads.

My point is Saeed pitched this to networking maintainers *twice*
and then purposefully left us out of the CC list.
That is absolutely unacceptable IMO, but I'd like to consult with
others to make sure it's not just me. Please allow me some time
to do that.
