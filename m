Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72232799EC1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbjIJPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbjIJPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:04:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53528119
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 08:03:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D923C433C8;
        Sun, 10 Sep 2023 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694358236;
        bh=0nGQI3SleycFfQrHBPI3Gwh0lVAQLEq3Xgtd6fw6MKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Po1nMdn+w3j838NT3C9YKNOfDFckGRQyC+VUXImcAobwkHukTsxKS7AXMJPCs/ivR
         tPqLPmmiugVdqy9m6az+8yFua6PcZP2YL1U2EnbrLFYUF/V/iVdNtFCRF5LhVw0K7q
         0smW8ZZ9rRd+hkMBvLWKajY6+4Rp84+fz961NgGs=
Date:   Sun, 10 Sep 2023 16:03:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Hammer <daniel.hammer120@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: prism2mgmt.c: remove needless
 parentheses to align with kernel coding style.
Message-ID: <2023091022-suggest-retract-c2b9@gregkh>
References: <ZP3NQSQwnmYAHQq+@daniel-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP3NQSQwnmYAHQq+@daniel-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 06:05:53PM +0400, Daniel Hammer wrote:
> Remove unnecessary parentheses as detected by checkpatch.pl.
> 
> Signed-off-by: Daniel Hammer <daniel.hammer120@gmail.com>
> ---
>  drivers/staging/wlan-ng/prism2mgmt.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
> index d5737166564e..201f07229962 100644
> --- a/drivers/staging/wlan-ng/prism2mgmt.c
> +++ b/drivers/staging/wlan-ng/prism2mgmt.c
> @@ -1227,9 +1227,9 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
>  				     word, result);
>  				goto failed;
>  			}
> -			if ((msg->keepwepflags.status ==
> -			     P80211ENUM_msgitem_status_data_ok) &&
> -			    (msg->keepwepflags.data != P80211ENUM_truth_true)) {
> +			if (msg->keepwepflags.status ==
> +			     P80211ENUM_msgitem_status_data_ok &&
> +			    msg->keepwepflags.data != P80211ENUM_truth_true) {
>  				/* Set the wepflags for no decryption */
>  				word = HFA384x_WEPFLAGS_DISABLE_TXCRYPT |
>  				    HFA384x_WEPFLAGS_DISABLE_RXCRYPT;
> @@ -1249,9 +1249,9 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
>  		}
>  
>  		/* Do we want to strip the FCS in monitor mode? */
> -		if ((msg->stripfcs.status ==
> -		     P80211ENUM_msgitem_status_data_ok) &&
> -		    (msg->stripfcs.data == P80211ENUM_truth_true)) {
> +		if (msg->stripfcs.status ==
> +		     P80211ENUM_msgitem_status_data_ok &&
> +		    msg->stripfcs.data == P80211ENUM_truth_true) {
>  			hw->sniff_fcs = 0;
>  		} else {
>  			hw->sniff_fcs = 1;
> @@ -1288,9 +1288,9 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
>  
>  		/* Set the driver state */
>  		/* Do we want the prism2 header? */
> -		if ((msg->prismheader.status ==
> -		     P80211ENUM_msgitem_status_data_ok) &&
> -		    (msg->prismheader.data == P80211ENUM_truth_true)) {
> +		if (msg->prismheader.status ==
> +		     P80211ENUM_msgitem_status_data_ok &&
> +		    msg->prismheader.data == P80211ENUM_truth_true) {
>  			hw->sniffhdr = 0;
>  			wlandev->netdev->type = ARPHRD_IEEE80211_PRISM;
>  		} else if ((msg->wlanheader.status ==
> -- 
> 2.34.1
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
