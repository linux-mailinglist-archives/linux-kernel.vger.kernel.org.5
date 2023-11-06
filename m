Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63FD7E1FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjKFLQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKFLQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:16:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DBB0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:16:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4619C433C7;
        Mon,  6 Nov 2023 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699269362;
        bh=SoF/S94flwFOY3+izonboY5kCu20hjnARgVVQs7pwYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBgTmseACJnpejjeiKlxL2lrdmM3YlClw3KVIkRk2RARTjlFKbNspctPy9Qk8OR2M
         bZiXZouKCvxa8/nzLTRUCYvf89EhiRLs8sfI+v03v8peK7JSpcpYbWwMWY2rdC9MRU
         Rkc9fw8K+TGX9dRxs6d41/kd5rL5nuGWn4jbDkIw=
Date:   Mon, 6 Nov 2023 12:15:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] Revert "usb: phy: add usb phy notify port status API"
Message-ID: <2023110623-pointing-stump-643d@gregkh>
References: <20231106110654.31090-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106110654.31090-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 12:06:51PM +0100, Johan Hovold wrote:
> The recently added Realtek PHY drivers depend on the new port status
> notification mechanism which was built on the deprecated USB PHY
> implementation and devicetree binding.
> 
> Specifically, using these PHYs would require describing the very same
> PHY using both the generic "phy" property and the deprecated "usb-phy"
> property which is clearly wrong.
> 
> We should not be building new functionality on top of the legacy USB PHY
> implementation even if it is currently stuck in some kind of
> transitional limbo.
> 
> Revert the new Realtek PHY drivers for now so that the port status
> notification interface can be reverted and replaced before we dig
> ourselves into an even deeper hole with this PHY mess.
> 
> Note that there are no upstream users of these PHYs and the drivers were
> only included in 6.6 so there should still be time to undo this.

No users of these phy drivers yet?  Why were they added?

> Preferably these should go in through Greg's tree for 6.7-rc1.

I'll be glad to take this if I can get an ack for it.

thanks,

greg k-h
