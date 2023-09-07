Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241367976BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbjIGQPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbjIGQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:15:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB7A2102
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:12:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247DAC433CA;
        Thu,  7 Sep 2023 06:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694068736;
        bh=AvSlLLvs6QlxJ5KXxl0SUmh4wdSpR8x1AUBlouM8NgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNbeJdHfeSVsiTtI4cEGP407ucYVg8VQzW682qu30l5aU8U3RzxCrOp9VNjcFZcG1
         ni8s6LtMFlc9cbVXhXTRlB9fTdcOfccOyHWjEBF40Eend+cEgUv9ZQgWsBFqREsoRP
         /Dz2rFPopiMap4G6dfIi5yOHmLOlZkQ/74q5pBDY=
Date:   Thu, 7 Sep 2023 07:38:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Angus Gardner <angusg778@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: wlan-ng: Removed unnecessary parentheses in
 wlan-ng driver cfg80211.
Message-ID: <2023090712-endanger-childless-2568@gregkh>
References: <ZPku2UC5g99ILEI3@midnight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPku2UC5g99ILEI3@midnight>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:00:57PM +1000, Angus Gardner wrote:
> Signed-off-by: Angus Gardner <angusg778@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 471bb310176f..d7d8a99adf52 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -351,8 +351,8 @@ static int prism2_scan(struct wiphy *wiphy,
>  		msg2->bssindex.data = i;
>  
>  		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
> -		if ((result != 0) ||
> -		    (msg2->resultcode.data != P80211ENUM_resultcode_success)) {
> +		if (result != 0 ||
> +		    msg2->resultcode.data != P80211ENUM_resultcode_success) {
>  			break;
>  		}
>  
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

- You sent a patch that has been sent multiple times in the past few
  days, and is identical to ones that has been recently rejected.
  Please always look at the mailing list traffic to determine if you are
  duplicating other people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
