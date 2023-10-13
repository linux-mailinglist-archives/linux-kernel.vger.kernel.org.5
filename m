Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143A87C7DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjJMG3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjJMG3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:29:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C70FB7;
        Thu, 12 Oct 2023 23:29:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6601CC433C7;
        Fri, 13 Oct 2023 06:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697178581;
        bh=ddmv6NZdkEiu+CdZIPIU1a/xmALRcZOj0furUIUeAtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUEg6HzJB8gzh3s708jayGqSozY/KG1LzQ9mnvWr8yBF9K8fUtcrxGsycwQWCeq8h
         ZzAQbC6dT6hyrdiy6kar2gNi/DkUTxsB4HzmhijWrgg/gRaujwnhZeKw1IlcD4UIEf
         1k/Q6i7+NiSDut8cWvCpbWAJsZkKZ85HhEQk3Kpc=
Date:   Fri, 13 Oct 2023 08:29:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chenguohua@jari.cn
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Clean up errors in selection.h
Message-ID: <2023101313-aftermost-skydiver-c587@gregkh>
References: <4545cc2c.940.18b26f571fe.Coremail.chenguohua@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4545cc2c.940.18b26f571fe.Coremail.chenguohua@jari.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:55:01AM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: "foo * bar" should be "foo *bar"
> 
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>
> ---
>  include/linux/selection.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/selection.h b/include/linux/selection.h
> index 170ef28ff26b..3bff95699083 100644
> --- a/include/linux/selection.h
> +++ b/include/linux/selection.h
> @@ -22,7 +22,7 @@ extern int set_selection_kernel(struct tiocl_selection *v,
>  extern int paste_selection(struct tty_struct *tty);
>  extern int sel_loadlut(char __user *p);
>  extern int mouse_reporting(void);
> -extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
> +extern void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry);
>  
>  bool vc_is_sel(struct vc_data *vc);
>  
> -- 
> 2.17.1

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

- It looks like you did not use your name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
