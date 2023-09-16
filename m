Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5518B7A323A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjIPTRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjIPTRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:17:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A215186
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:17:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5492C433C7;
        Sat, 16 Sep 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694891825;
        bh=KNCWSzmod9aM3xB/4gvd2mfB0pCaFsgNdqQUI1NNB38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nkg0fUGQ+SpOPSRkCea7UXDF1rKKGzEIMAeV1nG6omIeQrRrM3M6zoxmJD83DWpKm
         MB9ZgpXLwhb7kZyh8bNbP6WdzpLjYuXxQ77F1hBEQWVxJ+wMv9yo2TJhS7u8991zKZ
         /AA6qyQehk3vqS7Kpboyxo7QvReRYjfYPDO/+jqs=
Date:   Sat, 16 Sep 2023 21:17:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/usbip : fixing warnings in stub_dev.c
Message-ID: <2023091601-mulch-linoleum-a4c7@gregkh>
References: <20230916174020.3218-1-bragathemanick0908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916174020.3218-1-bragathemanick0908@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 11:10:20PM +0530, Bragatheswaran Manickavel wrote:
> Fix some checkpatch complaints in usb/usbip/stub_dev.c
> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  drivers/usb/usbip/stub_dev.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
> index 9c6954aad6c8..3a5771f74a3f 100644
> --- a/drivers/usb/usbip/stub_dev.c
> +++ b/drivers/usb/usbip/stub_dev.c
> @@ -495,24 +495,25 @@ static void stub_disconnect(struct usb_device *udev)
>  		busid_priv->status = STUB_BUSID_ADDED;
>  	/* release busid_lock */
>  	spin_unlock(&busid_priv->busid_lock);
> -	return;
>  }
>  
>  #ifdef CONFIG_PM
>  
> -/* These functions need usb_port_suspend and usb_port_resume,
> - * which reside in drivers/usb/core/usb.h. Skip for now. */
> +/*
> + * These functions need usb_port_suspend and usb_port_resume,
> + * which reside in drivers/usb/core/usb.h. Skip for now.
> + */
>  
>  static int stub_suspend(struct usb_device *udev, pm_message_t message)
>  {
> -	dev_dbg(&udev->dev, "stub_suspend\n");
> +	dev_dbg(&udev->dev, "stub suspend\n");
>  
>  	return 0;
>  }
>  
>  static int stub_resume(struct usb_device *udev, pm_message_t message)
>  {
> -	dev_dbg(&udev->dev, "stub_resume\n");
> +	dev_dbg(&udev->dev, "stub resume\n");
>  
>  	return 0;
>  }
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
