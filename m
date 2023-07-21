Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC4175BD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGUELt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUELp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E02729
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C65E060FAF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB34AC433C7;
        Fri, 21 Jul 2023 04:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689912703;
        bh=r6mbA29dSgjLTK5ZkBYqw/al6NFHb8yCLPniDAa5aso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teSdvU7fZ21iCoLIEakv35HJaZGC3ROqEbp77jvREfZzGwXWpdKOweIsVbeIHJ6aL
         Fv7lD4zu2Yi2qeYKx5Pm8OHhNi+rhM2evBfuCrcbNV1kJ4WitB3U8R5CbCgxa31fPf
         0ZPTtjB3Ygynoyv8g1vrFeBAb37+Uk8TnDyYlup8=
Date:   Fri, 21 Jul 2023 06:11:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Rozhnov <rozhnov.sergey.89@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Remove redundant braces in if
 statements
Message-ID: <2023072157-expediter-catalyze-8ecc@gregkh>
References: <ZLnoBYlsTiLixTah@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLnoBYlsTiLixTah@terra>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:05:57AM +0400, Sergey Rozhnov wrote:
> Extract masked value to improve readability, apply fix suggested by checkpatch.
> ---
>  drivers/staging/rtl8712/ieee80211.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
> index 7d8f1a29d18a..fe53453ab9a7 100644
> --- a/drivers/staging/rtl8712/ieee80211.c
> +++ b/drivers/staging/rtl8712/ieee80211.c
> @@ -63,8 +63,9 @@ uint r8712_is_cckrates_included(u8 *rate)
>  	u32 i = 0;
>  
>  	while (rate[i] != 0) {
> -		if ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
> -		    (((rate[i]) & 0x7f) == 11) || (((rate[i]) & 0x7f) == 22))
> +		u8 val = rate[i] & 0x7f;
> +
> +		if (val == 2 || val == 4 || val == 11 || val == 22)
>  			return true;
>  		i++;
>  	}
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
