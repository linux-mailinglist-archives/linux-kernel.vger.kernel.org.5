Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2B7A3DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjIQVKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjIQVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:10:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCF2B6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:09:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B020C433C7;
        Sun, 17 Sep 2023 21:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694984995;
        bh=yfQZHQBaumEUVpt3OXVxMtNrzQVKDvYGfyCXrbyai0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVkvgOb6q9neAJefI3SejajqUHz3PLStAivAcoQ09gjZRxPnd4lBu04m+B1fUUlcq
         cWnWW80ZQws5G5COLbo0Na8+2n1RdFdXG5C+AC5zfrzA38J3cKSzE2KU7DC9KaNdDX
         MWm8RSUmZMQb563zQjZX3CSw1WhAxWeBUh7raANQ=
Date:   Sun, 17 Sep 2023 21:32:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piro Yang <piroyangg@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vme_user: Fixed prink formatting issue
Message-ID: <2023091709-diploma-ripcord-5cd5@gregkh>
References: <2023091756-duct-agile-0023@gregkh>
 <20230917192359.78711-1-piroyangg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917192359.78711-1-piroyangg@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:23:59AM +0800, Piro Yang wrote:
> Fixed issue relating to prink message:
> 	*using __func__ to replace function's name
> 
> Issue found by checkpatch
> 
> Signed-off-by: Piro Yang <piroyangg@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 5960562dcd96..de404c6765f3 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -418,7 +418,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
>  	image = list_entry(resource->entry, struct vme_slave_resource, list);
>  
>  	if (!bridge->slave_get) {
> -		printk(KERN_ERR "vme_slave_get not supported\n");
> +		printk(KERN_ERR "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -568,7 +568,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
>  	image = list_entry(resource->entry, struct vme_master_resource, list);
>  
>  	if (!bridge->master_set) {
> -		printk(KERN_WARNING "vme_master_set not supported\n");
> +		printk(KERN_WARNING "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1552,7 +1552,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>  
>  	if (!bridge->lm_set) {
> -		printk(KERN_ERR "vme_lm_set not supported\n");
> +		printk(KERN_ERR "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1588,7 +1588,7 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>  
>  	if (!bridge->lm_get) {
> -		printk(KERN_ERR "vme_lm_get not supported\n");
> +		printk(KERN_ERR "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1625,7 +1625,7 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>  
>  	if (!bridge->lm_attach) {
> -		printk(KERN_ERR "vme_lm_attach not supported\n");
> +		printk(KERN_ERR "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1658,7 +1658,7 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>  
>  	if (!bridge->lm_detach) {
> -		printk(KERN_ERR "vme_lm_detach not supported\n");
> +		printk(KERN_ERR "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1725,7 +1725,7 @@ int vme_slot_num(struct vme_dev *vdev)
>  	}
>  
>  	if (!bridge->slot_get) {
> -		printk(KERN_WARNING "vme_slot_num not supported\n");
> +		printk(KERN_WARNING "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.25.1
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
