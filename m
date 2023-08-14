Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8553A77C163
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjHNUQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjHNUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22B10D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3608D63563
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD56C433C7;
        Mon, 14 Aug 2023 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692044166;
        bh=IdrQIiJoR/1LHgiGQUGfo5y9VXt+OYg1XpwucU0GnZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2YL3RnebwNGUs5hnZwlFrUWP64R0hmOPCXGASbVvJmzH7RqiXuSNUF6wrCN2o6VtO
         xzK8Yv5t0PT78QX9pG8acAYQtxwPJ2meolbZ4BYKOw75aKZsyo8UnEq9jMtKp03eiD
         JXeMEEUkBseyE3ZB2l0xXLWVS4K+485ZmelgJjs0=
Date:   Mon, 14 Aug 2023 22:16:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check unnecessary parentheses
Message-ID: <2023081438-kennel-regress-a76d@gregkh>
References: <ZNqJs126kA+KvSTC@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNqJs126kA+KvSTC@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:08:19PM -0300, Alexon Oliveira wrote:
> Fixed all CHECK: Unnecessary parentheses around
> as reported by checkpatch to adhere to the Linux kernel
> coding-style guidelines.
> 
> Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index c7c50406c199..6f08bb21369d 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -307,7 +307,7 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
>  		mutex_lock(&slave_image->mtx);
>  		if (((slave_image->address_attr & address) == address) &&
>  		    ((slave_image->cycle_attr & cycle) == cycle) &&
> -		    (slave_image->locked == 0)) {
> +		    slave_image->locked == 0) {
>  			slave_image->locked = 1;
>  			mutex_unlock(&slave_image->mtx);
>  			allocated_image = slave_image;
> @@ -508,7 +508,7 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
>  		if (((master_image->address_attr & address) == address) &&
>  		    ((master_image->cycle_attr & cycle) == cycle) &&
>  		    ((master_image->width_attr & dwidth) == dwidth) &&
> -		    (master_image->locked == 0)) {
> +		    master_image->locked == 0) {
>  			master_image->locked = 1;
>  			spin_unlock(&master_image->lock);
>  			allocated_image = master_image;
> @@ -882,7 +882,7 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
>  		/* Find an unlocked and compatible controller */
>  		mutex_lock(&dma_ctrlr->mtx);
>  		if (((dma_ctrlr->route_attr & route) == route) &&
> -		    (dma_ctrlr->locked == 0)) {
> +		    dma_ctrlr->locked == 0) {
>  			dma_ctrlr->locked = 1;
>  			mutex_unlock(&dma_ctrlr->mtx);
>  			allocated_ctrlr = dma_ctrlr;
> @@ -1248,9 +1248,9 @@ void vme_bus_error_handler(struct vme_bridge *bridge,
>  	list_for_each(handler_pos, &bridge->vme_error_handlers) {
>  		handler = list_entry(handler_pos, struct vme_error_handler,
>  				     list);
> -		if ((aspace == handler->aspace) &&
> -		    (address >= handler->start) &&
> -		    (address < handler->end)) {
> +		if (aspace == handler->aspace &&
> +		    address >= handler->start &&
> +		    address < handler->end) {
>  			if (!handler->num_errors)
>  				handler->first_error = address;
>  			if (handler->num_errors != UINT_MAX)
> @@ -1337,7 +1337,7 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
>  		return -EINVAL;
>  	}
>  
> -	if ((level < 1) || (level > 7)) {
> +	if (level < 1 || level > 7) {
>  		printk(KERN_ERR "Invalid interrupt level\n");
>  		return -EINVAL;
>  	}
> @@ -1386,7 +1386,7 @@ void vme_irq_free(struct vme_dev *vdev, int level, int statid)
>  		return;
>  	}
>  
> -	if ((level < 1) || (level > 7)) {
> +	if (level < 1 || level > 7) {
>  		printk(KERN_ERR "Invalid interrupt level\n");
>  		return;
>  	}
> @@ -1433,7 +1433,7 @@ int vme_irq_generate(struct vme_dev *vdev, int level, int statid)
>  		return -EINVAL;
>  	}
>  
> -	if ((level < 1) || (level > 7)) {
> +	if (level < 1 || level > 7) {
>  		printk(KERN_WARNING "Invalid interrupt level\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.41.0
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

- You sent a patch that has been sent multiple times in the past few
  days, and is the same type to ones that has been recently rejected.
  Please always look at the mailing list traffic to determine if you are
  duplicating other people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
