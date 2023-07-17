Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70341756684
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGQOgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB821A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB74E6105C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA94FC433C8;
        Mon, 17 Jul 2023 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689604597;
        bh=CJ8HvmJjjFBM8btpMu+LuIiwlxl6ZrLynHsnxE/Ezts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lV5sU4/s9TmpOzUMx5N8RCzD0FjhGKW82n3l628Ru3nKFiumEfz1zcQuG5crzFofn
         reAFfer0gtxtvF3WuzMA9+f2naS/zBTDG3vZamENH6+5vXmX8zLAhqsSmWQLWADTd1
         5jSPqham1T2xSyPDILhefxhx526Far55EmTgDV98=
Date:   Mon, 17 Jul 2023 16:36:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hanyu001@208suo.com
Cc:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: Fwd: [PATCH] fsi:  Replace snprintf in show functions with
 sysfs_emit
Message-ID: <2023071700-aptly-runaround-49b7@gregkh>
References: <tencent_1E5AB8730E81C86AF0CAF2F10F222F5A9207@qq.com>
 <14c7e158390db531969e7520710d5fab@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c7e158390db531969e7520710d5fab@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 05:29:21PM +0800, hanyu001@208suo.com wrote:
> Fix the following coccicheck warning:
>   drivers/macintosh/ams/ams-core.c:53: WARNING: use scnprintf or sprintf.
> 
> ./drivers/fsi/fsi-master-gpio.c:721:8-16: WARNING: use scnprintf or sprintf
> 
> Signed-off-by: ztt <1549089851@qq.com>
> ---
>  drivers/fsi/fsi-master-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
> index 7d5f29b4b595..75499365729f 100644
> --- a/drivers/fsi/fsi-master-gpio.c
> +++ b/drivers/fsi/fsi-master-gpio.c
> @@ -718,7 +718,7 @@ static ssize_t external_mode_show(struct device *dev,
>  {
>      struct fsi_master_gpio *master = dev_get_drvdata(dev);
> 
> -    return snprintf(buf, PAGE_SIZE - 1, "%u\n",
> +    return scnprintf(buf, PAGE_SIZE - 1, "%u\n",
>              master->external_mode ? 1 : 0);
>  }

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

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for a
  description of how to do this so that Greg has a chance to apply these
  correctly.

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

- It looks like you did not use your "real" name for the patch on either
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
