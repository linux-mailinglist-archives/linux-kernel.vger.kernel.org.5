Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377A37B4763
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjJAMYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjJAMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:24:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435A2A2;
        Sun,  1 Oct 2023 05:24:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49926C433C7;
        Sun,  1 Oct 2023 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696163039;
        bh=zJS4fl4hoO5MV5pbbaYUd5H72daENnK1zXJQdRl/ElI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=doMOT0mw6srqcZdv8v2PINB5rjvBCAvjveqkzrKPUe/oVjSleQyd03I4mx0DuHulN
         N21Q8X8bEuyVSmk3EwBq7MyyUFI5F9ASzrtcTJuV5+Gk646kbVqBL4iTaUF3r/yCG5
         KaqsiMEhucptmON5hA1CE3tNlJEROBpUriDqNfXU3z11h+Yl/7+7sXNvjzub+IwK1l
         fLgBceqjgdm1NMR5Y1sAQEbcOU2RTzsRoB4H27lCWYLOVeQt59jzl6OjZcYu4QJBws
         4khDodCtuUvD2PTp2crdypYkMQwp+4OE/lU9O0vXZPQ6F9T+5hU2VIi0wwR0i2IRu0
         mcwNHmoAavqyQ==
Date:   Sun, 1 Oct 2023 14:23:55 +0200
From:   Simon Horman <horms@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 06/14] can: m_can: Add rx coalescing ethtool support
Message-ID: <20231001122355.GN92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-7-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-7-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:12:56PM +0200, Markus Schneider-Pargmann wrote:
> Add the possibility to set coalescing parameters with ethtool.
> 
> rx-frames-irq and rx-usecs-irq can only be set and unset together as the
> implemented mechanism would not work otherwise. rx-frames-irq can't be
> greater than the RX FIFO size.
> 
> Also all values can only be changed if the chip is not active.
> 
> Polling is excluded from irq coalescing support.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>

