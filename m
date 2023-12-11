Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F8280D21A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbjLKQiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbjLKQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:38:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5391
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:38:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E22C433C7;
        Mon, 11 Dec 2023 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702312704;
        bh=w4XxbFybPgO0yNAs3VILv8qJBukBweqBcvoWPXmJMPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfB8QdQFsbZ6KTTiorcr1ZbEkHj7IVno7xI27OCO/v5oKoYJ86O8RWAwSjz0fUtql
         6KixKySZuGjkokyS5oBxC0zC2ZAcLKL6QiCzOJLKVlUUOuDISZ3q06lAcfqu+4wSak
         eVxeP1aR2qjqY4w32mM7MEQhBoN/m37Nzq56uctg=
Date:   Mon, 11 Dec 2023 17:38:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piro Yang <piroyangg@gmail.com>
Cc:     linux-staging@lists.linux.dev,
        Linux Outreachy <outreachy@lists.linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2]staging:vme_user:fix the issue of using the wrong
 error code
Message-ID: <2023121105-grimy-move-311e@gregkh>
References: <20231211162717.105915-1-piroyangg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211162717.105915-1-piroyangg@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 12:27:17AM +0800, Piro Yang wrote:
> the error code of ENOSYS indicates Invalid system call number, but there is not system call
> 
> Signed-off-by: Piro Yang <piroyangg@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 5c416c31ec57..9bc2d35405af 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -341,7 +341,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
>  
>  	if (!bridge->slave_set) {
>  		dev_err(bridge->parent, "Function not supported\n");
> -		return -ENOSYS;
> +		return -EINVAL;
>  	}
>  
>  	if (!(((image->address_attr & aspace) == aspace) &&
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
