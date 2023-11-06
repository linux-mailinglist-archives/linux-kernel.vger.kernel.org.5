Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1E7E1FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjKFLYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjKFLYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:24:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87FBE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:24:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C904C433C7;
        Mon,  6 Nov 2023 11:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699269890;
        bh=YkEv2EZkQXxEy3IB6Z8hqcYQpz7j5UfPVeWSu4+609Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeONS6MKrztCYfQmThd6yaLlb5+OCEHxmsTOZ+KR45Ud3a+PBLw6pMOFZ5hsQbmlV
         4uuY3IhQsnAPAFc/f8jdHratGJr/+itpyLAm/ezOGJWrImzPzGv3jfNZTywYhuQ4iA
         C8ThKcYvqJGeUPAbERSsji7RNHzQXUKg5mFtZPOfMf5SGdJCo7kjBiULomxIbFSwQP
         skJt/nYedGg1CKPicr1RI5UAKvlnVQe17zHD3/LYI6Cc2N9+vefA/OCjKtzBY5X0NX
         Uwld7gfbPsukoJ980zxHOeuZTHMPRvM8Kxyox2/NWSt32csFcSNRmDdHGjfv/eg3XP
         urNhL4m7CwxmA==
Date:   Mon, 6 Nov 2023 16:54:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] Revert "usb: phy: add usb phy notify port status API"
Message-ID: <ZUjM/VEliT5c8H4C@matsya>
References: <20231106110654.31090-1-johan+linaro@kernel.org>
 <2023110623-pointing-stump-643d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110623-pointing-stump-643d@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-23, 12:15, Greg Kroah-Hartman wrote:
> On Mon, Nov 06, 2023 at 12:06:51PM +0100, Johan Hovold wrote:
> > The recently added Realtek PHY drivers depend on the new port status
> > notification mechanism which was built on the deprecated USB PHY
> > implementation and devicetree binding.
> > 
> > Specifically, using these PHYs would require describing the very same
> > PHY using both the generic "phy" property and the deprecated "usb-phy"
> > property which is clearly wrong.
> > 
> > We should not be building new functionality on top of the legacy USB PHY
> > implementation even if it is currently stuck in some kind of
> > transitional limbo.
> > 
> > Revert the new Realtek PHY drivers for now so that the port status
> > notification interface can be reverted and replaced before we dig
> > ourselves into an even deeper hole with this PHY mess.
> > 
> > Note that there are no upstream users of these PHYs and the drivers were
> > only included in 6.6 so there should still be time to undo this.
> 
> No users of these phy drivers yet?  Why were they added?

Not sure why, they didnt go thru phy ss!

> 
> > Preferably these should go in through Greg's tree for 6.7-rc1.
> 
> I'll be glad to take this if I can get an ack for it.

Pls do drop this:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
