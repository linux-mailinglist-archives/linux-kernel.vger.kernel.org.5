Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE67DB320
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjJ3GN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjJ3GNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:13:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060A3C9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:13:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20596C433C8;
        Mon, 30 Oct 2023 06:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698646400;
        bh=6qx7gkadhjjPFR2FBT459d6MskGyskl2wBormk0qgU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQRT3hhWe3ySUJPZU6t5QFh0Ah5G7FADdt82bPl4Ox3CPkwTdLoALxmWMl8u6tXUx
         R9RuQuWvypFSJhWSrvXo2kWUYFh22EgKSJQO9tmCiF79PpZaQFU3vFEXQOoEEFhSja
         05uM4iakw3PJa72dh5R58issdP3bw9z3rEeBftZQ=
Date:   Mon, 30 Oct 2023 07:13:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nancy Nyambura <nicymimz@gmail.com>
Cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace strncpy() with strscpy() for
 appropriate string copying in rtsx_scsi line 524 warning: found by
 checkpatch.pl script
Message-ID: <2023103052-musky-defacing-ca25@gregkh>
References: <20231029191647.44127-1-nicymimz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029191647.44127-1-nicymimz@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 10:16:42PM +0300, Nancy Nyambura wrote:
> Signed-off-by: Nancy Nyambura <nicymimz@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx_scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
> index 08bd768ad34d..52324b8ebbc7 100644
> --- a/drivers/staging/rts5208/rtsx_scsi.c
> +++ b/drivers/staging/rts5208/rtsx_scsi.c
> @@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  
>  	if (sendbytes > 8) {
>  		memcpy(buf, inquiry_buf, 8);
> -		strncpy(buf + 8, inquiry_string, sendbytes - 8);
> +		strscpy(buf + 8, inquiry_string, sendbytes - 8);
>  		if (pro_formatter_flag) {
>  			/* Additional Length */
>  			buf[4] = 0x33;
> -- 
> 2.40.1
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
