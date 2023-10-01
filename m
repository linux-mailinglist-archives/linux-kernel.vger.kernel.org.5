Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB87B45B6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjJAG4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJAG4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:56:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D5B9F
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 23:56:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9638DC433C7;
        Sun,  1 Oct 2023 06:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696143398;
        bh=RMD1G/nyPZtMLFTDjB85KSKijoc7KVijnQjNSZL7adk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B15/fvzNUuNU4vcSKlOAALxKUcqGaJ0ts9uKq7ujnoi7h4nX7gvUxd7EAaf6DRLOz
         +3VgpJQlbPogXVybdafnwND0ycdhph0mui2kOfd7jfJcv7t/9B4B+4QbK/DFENGNN4
         v2Ok8cy/z91g6jxeJF5Q3ty+H4TtX+ZDeUUl1sZFHiN+QhKk/HLBd2mHoyNSk3SHDg
         puqtos+siKhSekELWgDIHrLNk5mNqgMLpG/w4pjkyWvOo4/l0MjTO267a873x4aQm5
         thXlBIt5dmYnKyzkv9alqwS83x8dl3qRPZ5FQC0y6foXpZ0vZrbqJJ/ORke5D2Pc0K
         y3oADT9ynvqNA==
Date:   Sun, 1 Oct 2023 08:56:34 +0200
From:   Simon Horman <horms@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 0/4] net: ethernet: am65-cpsw: Add mqprio,
 frame pre-emption & coalescing
Message-ID: <20231001065634.GI92317@kernel.org>
References: <20230927072741.21221-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927072741.21221-1-rogerq@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:27:37AM +0300, Roger Quadros wrote:
> Hi,
> 
> This series adds mqprio qdisc offload in channel mode,
> Frame Pre-emption MAC merge support and RX/TX coalesing
> for AM65 CPSW driver.
> 
> Comparted to v4, this series picks up the coalesing patch.
> 
> Changelog information in each patch file.
> 
> cheers,
> -roger
> 
> Grygorii Strashko (2):
>   net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
>   net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
>     hrtimers
> 
> Roger Quadros (2):
>   net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
>   net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
>     support

...

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

