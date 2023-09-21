Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFE7AA17F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjIUVDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjIUVCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137383F40
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD844C433BF;
        Thu, 21 Sep 2023 07:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695281648;
        bh=PTSNDmDNeR+as9o7onTUKFQefY9JgllPjtDiCwPMC7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3g13k8Uhttv8U/NRNxaO9SHl50PHOdp3KOZLg2raPru67kUQ31XbDTkpSXaWywYI
         SD3FBYLq3yu51ssjayffWX/UXpVkLCNQIbwFJYhrlph/4GKSX9CPhhbxA6Sw4DGLI9
         3G+dZMjh1Yn1Hrb1cMKqG1T12nqKuG2rGnkXxdlI=
Date:   Thu, 21 Sep 2023 09:34:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     huangli05 <huangli05@inspur.com>
Cc:     osmtendev@gmail.com, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: modify syntax errors in comments
Message-ID: <2023092135-waving-duct-00d0@gregkh>
References: <20230921021349.3350-1-huangli05@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230921021349.3350-1-huangli05@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 10:13:49AM +0800, huangli05 wrote:
> From: “huangli05“ <huangli05@inspur.com>
> 
> Change "/* We want to set the the speech synthesis" to "/* We want to set the speech synthesis"
> 
> Signed-off-by: “huangli05“ <huangli05@inspur.com>
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
