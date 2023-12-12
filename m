Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8880E8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjLLKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjLLKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:21:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C5AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:21:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC61C433C8;
        Tue, 12 Dec 2023 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702376492;
        bh=bBdsJ1LFHIAiNvuKQ5c872B4cUZ1SzBz3JpEuXPCcuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPXFmG93uJ75RElaOyg4kQqMjdOkE78zjP7doLMl+g2h85P/Psu1gL+xUKrXJFr9l
         XpeickXl7jbSgK3VLgIg/gR5qKA/hY5QeG5UVFy30XX3w2NwKTcPwenK4fCRxvZkRb
         ppaPB0Ox37BuGmDkF+hBDZMqmIZoxfilw8Gjdoo4=
Date:   Tue, 12 Dec 2023 11:21:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shitao <shitao@kylinos.cn>
Cc:     alcooperx@gmail.com, chunfeng.yun@mediatek.com,
        justin.chen@broadcom.com, kernel-bot@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: mtu3: fix comment typo
Message-ID: <2023121216-shabby-hastily-f094@gregkh>
References: <2023121236-earful-email-ea09@gregkh>
 <20231212100657.3115089-1-shitao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212100657.3115089-1-shitao@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 06:06:57PM +0800, shitao wrote:
> Fix comment typo in mtu3_qmu.c file.
> "empty" is misspelled as "emtpy".
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: shitao <shitao@kylinos.cn>
> ---
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
