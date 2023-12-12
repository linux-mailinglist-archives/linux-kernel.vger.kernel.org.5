Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4E80EAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjLLLnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjLLLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:43:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D1CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:43:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0778BC433CB;
        Tue, 12 Dec 2023 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702381386;
        bh=VP19Xc7SO6DDWq37DiHzwVRgMzvOpshvCngKBktf3sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l95MWKBCI4nz06TAy83lmX56dxCSVrQR/fo1ACWa0ZsGpfeL1BaBdxlxlEJViahnk
         F4WjBqyDJ6+CJFFK09J0GrzmnjP4iSHv6QkKFNvHYWRYEwIW2YLguz/nEOYNtOle3D
         24rIw2DmizSNFN0cADz0scNhe5OJz59oWlu34d1A=
Date:   Tue, 12 Dec 2023 12:43:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shitao <shitao@kylinos.cn>
Cc:     alcooperx@gmail.com, chunfeng.yun@mediatek.com,
        justin.chen@broadcom.com, kernel-bot@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: bdc: fix comment typo
Message-ID: <2023121244-peso-gleaming-14c0@gregkh>
References: <2023121251-attest-shout-cbaa@gregkh>
 <20231212111754.3115465-1-shitao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212111754.3115465-1-shitao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:17:54PM +0800, shitao wrote:
> Fix comment typo in bdc_core.c file.
> "dynamic" is misspelled as "dyanmic".
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: shitao <shitao@kylinos.cn>
> ---
> Hi, 
> according to your suggestion, I have split it into two patches and added some simple instructions. 
> This is a change that fixes the misspelling of "dynamic" in bdc_core.c file. 
> thanks.
>  drivers/usb/gadget/udc/bdc/bdc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> index 35a652807fca..874122f8baa3 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -361,7 +361,7 @@ int bdc_reinit(struct bdc *bdc)
>  	return ret;
>  }
>  
> -/* Allocate all the dyanmic memory */
> +/* Allocate all the dynamic memory */
>  static int bdc_mem_alloc(struct bdc *bdc)
>  {
>  	u32 page_size;
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
