Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501F0761D71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjGYPfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGYPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B731FCA;
        Tue, 25 Jul 2023 08:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F57E617A9;
        Tue, 25 Jul 2023 15:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C414C433C8;
        Tue, 25 Jul 2023 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690299302;
        bh=jmV7Z+IMpxtc/v1QzoW2b1B8m42Y1045RaIymwjdHyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vwf2HvDFToBRBIRXzndQBbldmS6x/bhkHm+ofM8kSufEQafXxJe+nhcpf6GrxKDYp
         qI/3oaTC7EBwqCEXyMtiK+sxUQHMfV0dq1qxa1JoPJGaG6cZHdJnO3ogywkrvwCS/L
         4zfMrXzzKgmkAw6FWnviwMCWARP2PiOUmAms3WF4=
Date:   Tue, 25 Jul 2023 17:34:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wuyonggang001@208suo.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_serial: Modify sizeof format and Variable
 type
Message-ID: <2023072534-frosting-phrasing-e2be@gregkh>
References: <20230710030457.18806-1-zhanglibing@cdjrlc.com>
 <2e20d91d90ef6ba7557a465d67634db5@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e20d91d90ef6ba7557a465d67634db5@208suo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:09:20AM +0800, wuyonggang001@208suo.com wrote:
> 
> Fix the following checkpatch warning:
> 
> WARNING: sizeof gser_ss_bulk_comp_desc should be
> sizeof(gser_ss_bulk_comp_desc)
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>  drivers/usb/gadget/function/f_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_serial.c
> b/drivers/usb/gadget/function/f_serial.c
> index a9480b9e312e..d7770da75e01 100644
> --- a/drivers/usb/gadget/function/f_serial.c
> +++ b/drivers/usb/gadget/function/f_serial.c
> @@ -111,7 +111,7 @@ static struct usb_endpoint_descriptor gser_ss_out_desc =
> {
>  };
> 
>  static struct usb_ss_ep_comp_descriptor gser_ss_bulk_comp_desc = {
> -    .bLength =              sizeof gser_ss_bulk_comp_desc,
> +    .bLength =              sizeof(gser_ss_bulk_comp_desc),
>      .bDescriptorType =      USB_DT_SS_ENDPOINT_COMP,
>  };
> 
> @@ -143,7 +143,7 @@ static struct usb_gadget_strings *gser_strings[] = {
> 
> /*-------------------------------------------------------------------------*/
> 
> -static int gser_set_alt(struct usb_function *f, unsigned intf, unsigned
> alt)
> +static int gser_set_alt(struct usb_function *f, unsigned int intf, unsigned
> int alt)
>  {
>      struct f_gser        *gser = func_to_gser(f);
>      struct usb_composite_dev *cdev = f->config->cdev;

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

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
