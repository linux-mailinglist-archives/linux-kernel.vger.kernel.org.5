Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F89784253
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjHVNrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjHVNrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476618B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B6B649A7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A5C433C9;
        Tue, 22 Aug 2023 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692712018;
        bh=2tqfJL32FPqN+NczC6Z7cjoqXSXsEnZTlELEtiARWsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=My70Q2bs6Q/y5DFcmYjS1m6KCp6pY76c9xj6l4FFEnpJxdz80oCRW7y1nLnaYMqAz
         X3qhL+cPLeVFoyI22kjEGbQIF/LwustXk8klus5TMAkAt/9p7As9YMq6ewBaQ0hbBc
         jXB94CcMD2G/2No2W/zqaAgPZycuv9wwDHpNR/E8=
Date:   Tue, 22 Aug 2023 15:46:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicklaus Choo <nicklauscyc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Fix print formatting warning for some functions in
 drivers/staging/vme_user/vme.c
Message-ID: <2023082228-staunch-carload-5553@gregkh>
References: <20230817015634.18428-1-nicklauscyc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817015634.18428-1-nicklauscyc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 06:56:34PM -0700, Nicklaus Choo wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Nicklaus Choo <nicklauscyc@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index b5555683a069..d583c4abbf50 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -1742,12 +1742,12 @@ int vme_slot_num(struct vme_dev *vdev)
>  
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		return -EINVAL;
>  	}
>  
>  	if (!bridge->slot_get) {
> -		printk(KERN_WARNING "vme_slot_num not supported\n");
> +		pr_warn("%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
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
