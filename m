Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE976EE30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjHCPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjHCPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80530FD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A6BB61DF3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DF2C433C7;
        Thu,  3 Aug 2023 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691076862;
        bh=k2Q2kzKc4w5/3WyCK184qMxzuKS8w6SPNkUd/1bs6+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEfUTpmbfGgW+yjDD6BjbYqQnfNK6HZ8PR07HpV1ggOu77N7HpMAGLAHZo8A8R0Rx
         cdBq07WABERx/FWggQ/51et6okdTT5wR6yy1OjTLXJ2B0uWzGFfR22iTlM9sIjzbFr
         L6WJ7ctpk5vuXk8lTAqS5q2/yoB4UJ+8d1T3AKI8=
Date:   Thu, 3 Aug 2023 17:34:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, inux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <2023080302-veteran-postbox-b6e1@gregkh>
References: <ZMvHVLVCQakLyWUa@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMvHVLVCQakLyWUa@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 08:57:31PM +0530, Pavan Bobba wrote:
> Replace array name of camel case by snake case. Issue found
> by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> index 0e135af8316b..8b913c64845c 100644
> --- a/drivers/staging/vt6655/baseband.c
> +++ b/drivers/staging/vt6655/baseband.c
> @@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
>  };
>  
>  #define CB_VT3253B0_INIT_FOR_RFMD 256
> -static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> +static const unsigned char byvt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
>  	{0x00, 0x31},
>  	{0x01, 0x00},
>  	{0x02, 0x00},
> @@ -2005,8 +2005,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
>  		} else {
>  			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
>  				result &= bb_write_embedded(priv,
> -					byVT3253B0_RFMD[ii][0],
> -					byVT3253B0_RFMD[ii][1]);
> +					byvt3253b0_rfmd[ii][0],
> +					byvt3253b0_rfmd[ii][1]);
>  
>  			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
>  				result &= bb_write_embedded(priv,
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
