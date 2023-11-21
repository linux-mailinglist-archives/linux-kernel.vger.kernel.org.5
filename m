Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABD27F2FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjKUN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjKUN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:56:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF6AD6D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:55:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B47C433C7;
        Tue, 21 Nov 2023 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700574956;
        bh=foz5FNq/8MrqFI76R9JfR0GGlNAVOFYomFtBVuyfcCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBlZrkGQW6DqsJNma9NHSyKzM1SpiUVNX6tAJHiyEjMchb+y16sZV+rwsBIUYZR/b
         SdDXdeb8nQXfAYRMCafExEDpxCOaSqCvpGWiBefPOMHKna9zevbgY1Xymyfn0lCwwP
         Tg+kupeNyndc9BFdIu2t49YY/pcXYJcKt9Lv6mQ+1PMZ+RgIT6zQfZk/kAc5hnuGNW
         3Pq5sdvsb4i/XSH+pzeT8HmdhUGm3VlBdEyQZGMWWxt+dJ2My4xTBwfx0jlLUR/7RY
         +rrekn76nh1OYqLWJMX6XEoDWvYaKuRfl1ak204UCNI7mR3HGYkJ7gNI6/chUov1So
         3GZgYm0taHMPQ==
Date:   Tue, 21 Nov 2023 13:55:51 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wojciech.drewek@intel.com,
        bigeasy@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, srk@ti.com
Subject: Re: [PATCH net-next v2] net: hsr: Add support for MC filtering at
 the slave device
Message-ID: <20231121135551.GB269041@kernel.org>
References: <20231121053753.32738-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121053753.32738-1-r-gunasekaran@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:07:53AM +0530, Ravi Gunasekaran wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> When MC (multicast) list is updated by the networking layer due to a
> user command and as well as when allmulti flag is set, it needs to be
> passed to the enslaved Ethernet devices. This patch allows this
> to happen by implementing ndo_change_rx_flags() and ndo_set_rx_mode()
> API calls that in turns pass it to the slave devices using
> existing API calls.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> Changes since v1:
> * Renamed "hsr_ndo_set_rx_mode" to "hsr_set_rx_mode" based on Wojciech's comment
> * Picked up Wojciech's Reviewed-by tag from v1
> * Rebased to tip of linux-next
> 
> v1: https://lore.kernel.org/netdev/20231120110105.18416-1-r-gunasekaran@ti.com/

Thanks Ravi,

I confirm that the review of v1 has been addressed.
This patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
