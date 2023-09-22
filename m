Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23987AAE20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjIVJdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjIVJdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:33:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A07CCF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:32:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596E6C433BA;
        Fri, 22 Sep 2023 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695375171;
        bh=D/Wrlw0uoDCanV53dgevAcp88/yaVe0HHzbqKS1cIXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXAIAa9ngaWjDDR1RCknK9RUHo1zj3Q3ZIVN6ceveQ/WFDHlanc0BiNGRIA6h546r
         Tf/emF535LFYunG3oq84JKwmDx9m0CVNTAHegogfNbZtnykEq33hMpckdFUA2O1miW
         T9aXco7GhZ0E14wjHgXkZn3M2p3sceCfvYvqQos0=
Date:   Fri, 22 Sep 2023 11:32:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     huangli05 <huangli05@inspur.com>
Cc:     osmtendev@gmail.com, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: Remove repeated word in comments
Message-ID: <2023092224-shelve-diocese-3524@gregkh>
References: <20230922074847.3483-1-huangli05@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922074847.3483-1-huangli05@inspur.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:48:47PM +0800, huangli05 wrote:
> Remove the repeated word "the" in comments.
> 
> Signed-off-by: huangli05 <huangli05@inspur.com>
> ---
>  drivers/accessibility/speakup/speakup_soft.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
> index 6d446824677b..6549bfb96e7f 100644
> --- a/drivers/accessibility/speakup/speakup_soft.c
> +++ b/drivers/accessibility/speakup/speakup_soft.c
> @@ -446,7 +446,7 @@ static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)
>  	if (var->var_id != PUNC_LEVEL)
>  		return 0;
>  
> -	/* We want to set the the speech synthesis punctuation level
> +	/* We want to set the speech synthesis punctuation level
>  	 * accordingly, so it properly tunes speaking A_PUNC characters */
>  	var_data = var->data;
>  	if (!var_data)
> -- 
> 2.31.1
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
