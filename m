Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3480EABD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjLLLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:45:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182110F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:45:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF18C433C8;
        Tue, 12 Dec 2023 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702381522;
        bh=W+wu89yS6ISCTJNOIGobljSOiLONbTsNZcOU+gHhOC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3aY10B2veYLe39QbwiYhKctBqWU8+cZIFtuv8UrnHy7ioljgw+VVW/xAlNjlKfN2
         B2WnPBwXc/oNFPrFR2vlf6kGBIrDUmXXWXG+4P3vtUSvEp5aa4zPgdvg2FvtTcrLJH
         5ncaF+llV88ZZGQLVK7doz79ajaV9ARwFxKCa/o0=
Date:   Tue, 12 Dec 2023 12:45:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shitao <shitao@kylinos.cn>
Cc:     alcooperx@gmail.com, chunfeng.yun@mediatek.com,
        justin.chen@broadcom.com, kernel-bot@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: mtu3: fix comment typo
Message-ID: <2023121208-tattoo-grief-a78b@gregkh>
References: <2023121216-shabby-hastily-f094@gregkh>
 <20231212110959.3115422-1-shitao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110959.3115422-1-shitao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:09:59PM +0800, shitao wrote:
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: shitao <shitao@kylinos.cn>
> ---
> Hi,
> according to your suggestion, I have split it into two patches and added some simple instructions.
> This is about fixing the misspelling of "empty" in the mtu3_qmu.c file. 
> thanks.
>  drivers/usb/mtu3/mtu3_qmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
> index 3d77408e3133..03f26589b056 100644
> --- a/drivers/usb/mtu3/mtu3_qmu.c
> +++ b/drivers/usb/mtu3/mtu3_qmu.c
> @@ -221,7 +221,7 @@ static struct qmu_gpd *advance_deq_gpd(struct mtu3_gpd_ring *ring)
>  	return ring->dequeue;
>  }
>  
> -/* check if a ring is emtpy */
> +/* check if a ring is empty */
>  static bool gpd_ring_empty(struct mtu3_gpd_ring *ring)
>  {
>  	struct qmu_gpd *enq = ring->enqueue;
> -- 
> 2.34.1
> 

I would strongly suggest that you practice kernel patches in the
drivers/staging/ portion of the kernel, as that is where people learn
how to do this properly, and not bother other subsystems or developers.

Please start there and learn the basics, and then you can move to other
portions of the kernel as you will not be making simple mistakes like
you are here (hint, you forgot to version your patch, AND you forgot a
changelog...)

thanks,

greg k-h
