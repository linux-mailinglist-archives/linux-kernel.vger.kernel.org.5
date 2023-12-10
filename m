Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CCF80B9D8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 09:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjLJIRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 03:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjLJIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 03:16:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC8C6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 00:17:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76281C433C8;
        Sun, 10 Dec 2023 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702196224;
        bh=4MP+IiZQyTgAhgvxwWK9fTe8S5nqlJbp9EPDPLsqyds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=id7Mif+ETkUg+AUNse9Dqu2A10VFzTNzArnoZoaxMSbOC7h5t/k6lDLydmqAfAD/N
         QbdjWGuMcJA8s79ckAw9B4IiXJxM/ZRjmW9c48qSVsXhHej/WIQwipXW0LdN0kXuec
         JBlSCZ+wTC1D98CwYK56EPHTtYzmUK6izmRh2Kx0=
Date:   Sun, 10 Dec 2023 09:17:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Bigler <benjamin@bigler.one>
Cc:     broonie@kernel.org, linux@bigler.io, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        regressions@lists.linux.dev, stefan.moring@technolution.nl,
        regressions@leemhuis.info
Subject: Re: [PATCH] spi: spi-imx: correctly configure burst length when
 using dma
Message-ID: <2023121047-unnamable-magma-2b6d@gregkh>
References: <20231209222338.5564-1-benjamin@bigler.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209222338.5564-1-benjamin@bigler.one>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 11:23:26PM +0100, Benjamin Bigler wrote:
> If DMA is used, burst length should be set to the bus width of the DMA.
> Otherwise, the SPI hardware will transmit/receive one word per DMA
> request.
> Since this issue affects both transmission and reception, it cannot be
> detected with a loopback test.
> Replace magic numbers 512 and 0xfff with MX51_ECSPI_CTRL_MAX_BURST.
> 
> Signed-off-by: Benjamin Bigler <benjamin@bigler.one>
> Reported-by Stefan Bigler <linux@bigler.io>
> Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on transfer length")
> Link: https://lore.kernel.org/r/8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com
> ---
>  drivers/spi/spi-imx.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
