Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBECA77D4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbjHOVFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbjHOVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB6F2;
        Tue, 15 Aug 2023 14:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C12465C8C;
        Tue, 15 Aug 2023 21:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EFAC433C8;
        Tue, 15 Aug 2023 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692133495;
        bh=xwcwDarbzFSg0MwR0Od2kOF7EW3e+nIsngI5mMgpVvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oy21WmZrDR0ZcAKdfSVfTVV8GgQ2KOOCMZpPY4iNEx4uRXpzxOp78SRjQlg+U1QD3
         AZp1N6BcdHShCbCALtA9daPAFmZCSxBKtSgckIBkz9tApkjuohFsNeZgxKKyhCJWdH
         +XLftEcvkiULzlUKY+dAEUghMkkUm7Z4oo35yyRc=
Date:   Tue, 15 Aug 2023 23:04:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: usb: Adds space, removes trailing whitespace
 and fixes pointer declaration.
Message-ID: <2023081533-require-pastor-d432@gregkh>
References: <20230815204841.52600-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815204841.52600-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:18:41AM +0530, Atul Kumar Pant wrote:
> This patch fixes following checkpatch.pl issue:
> ERROR: space required before the open parenthesis '('
> ERROR: trailing whitespace
> ERROR: space required after that ','
> ERROR: "foo * bar" should be "foo *bar"
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  drivers/usb/class/cdc-acm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 11da5fb284d0..638c9cdaa041 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -203,7 +203,7 @@ static int acm_wb_is_avail(struct acm *acm)
>  	n = ACM_NW;
>  	spin_lock_irqsave(&acm->write_lock, flags);
>  	for (i = 0; i < ACM_NW; i++)
> -		if(acm->wb[i].use)
> +		if (acm->wb[i].use)
>  			n--;
>  	spin_unlock_irqrestore(&acm->write_lock, flags);
>  	return n;
> @@ -1006,7 +1006,7 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
>  		}
>  	} while (!rv);
>  
> -	
> +
>  
>  	return rv;
>  }
> @@ -1257,7 +1257,7 @@ static int acm_probe(struct usb_interface *intf,
>  
>  	if (control_interface == data_interface) {
>  		/* some broken devices designed for windows work this way */
> -		dev_warn(&intf->dev,"Control and data interfaces are not separated!\n");
> +		dev_warn(&intf->dev, "Control and data interfaces are not separated!\n");
>  		combined_interfaces = 1;
>  		/* a popular other OS doesn't use it */
>  		quirks |= NO_CAP_LINE;
> @@ -1428,7 +1428,7 @@ static int acm_probe(struct usb_interface *intf,
>  		goto err_free_write_urbs;
>  
>  	if (h.usb_cdc_country_functional_desc) { /* export the country data */
> -		struct usb_cdc_country_functional_desc * cfd =
> +		struct usb_cdc_country_functional_desc *cfd =
>  					h.usb_cdc_country_functional_desc;
>  
>  		acm->country_codes = kmalloc(cfd->bLength - 4, GFP_KERNEL);
> -- 
> 2.25.1
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
