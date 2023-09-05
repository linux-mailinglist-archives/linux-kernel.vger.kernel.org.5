Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCED7924E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjIEQAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353689AbjIEHRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:17:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45712CC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9DA4B810B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A2DC433C8;
        Tue,  5 Sep 2023 07:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693898258;
        bh=0bNZ/Ik9ie+O/I+s8u69OtphKsy1cdeCYHDnRIKduRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obZewG3rTxP/ed8H8LU4I5ip8ZwuGLgsJ+m9KMiBF5rCcPWMXGKuYZOifHm2SqsSs
         s/XEkCIWxpcDO9YXsV6+thUn66RE41M2M0U+UQoIgavdJUpqIj0aUhhGcXhIk5awGy
         VAqGPGSWjrr2xaIft3b6MmYn8iS76mKzMLrUY2iw=
Date:   Tue, 5 Sep 2023 08:17:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Angus Gardner <angusg778@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng
Message-ID: <2023090537-gathering-evil-22bd@gregkh>
References: <ZPak2AD8lKfcqEXG@midnight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPak2AD8lKfcqEXG@midnight>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 01:47:36PM +1000, Angus Gardner wrote:
> Unnecessary parentheses identified by checkpatch.pl removed.
> 
> Signed-off-by: Angus Gardner <angusg778@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 471bb310176f..948db2433463 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -351,7 +351,7 @@ static int prism2_scan(struct wiphy *wiphy,
>  		msg2->bssindex.data = i;
>  
>  		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
> -		if ((result != 0) ||
> +		if (result != 0 ||
>  		    (msg2->resultcode.data != P80211ENUM_resultcode_success)) {
>  			break;
>  		}
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

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

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
