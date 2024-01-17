Return-Path: <linux-kernel+bounces-28548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAD82FFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293BE1F2662D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4479F4;
	Wed, 17 Jan 2024 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JsPUjL9X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDB749A;
	Wed, 17 Jan 2024 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470479; cv=none; b=PBBzzuDmz4vQbYZdTbxTdSphMLKbOyuQ4n01J3UtXIP0EMvmd+y9TRAIgugSIoojDH78s1PzlfK8U2oaVeFzDc8ya7bDjXAe+68CuR+v2SNM7c8Q/vojcJvXm67bcxQsqreRlAYsxJrtF0CtDgwEzR2SQJrrM+kbVq+JttWe07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470479; c=relaxed/simple;
	bh=8uEGtBZmVl0AOIoiA1icGHXUq7f/t9VQmHV40n9KkMc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=deSkdH+UAndL5lLfFgQXmlMLGsG0TSeZjixGpb3Ix4dBEIz+XKVNDU6/e4fJsswnR05e76VPYUZGn7gftsTkb1q3FGl6/P70FpKFmOorFXH4cnB1KoKLVaZX2FPfba8fP8maZnPWAqTr70RtGndaa7PCHz1ZmansxgY86yHhz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JsPUjL9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BF4C433C7;
	Wed, 17 Jan 2024 05:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705470478;
	bh=8uEGtBZmVl0AOIoiA1icGHXUq7f/t9VQmHV40n9KkMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsPUjL9XdudU/hVfI8s8Lx9qaAOy56vqZKlDX9Y8fJ8YM1zD2i0TaaZJMo3lNm+GQ
	 /B1Q0iNx0ew4zwoTJRwHcyJF7d+CSWGvmTNqnWRfWWmy0XsrCDpH0U65mZGWwLKlf8
	 csC9qKXOjI8U+GtL+CKGZ2gQyfLnjLuz92XAYfI4=
Date: Wed, 17 Jan 2024 06:47:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hoorad Farrokh <hourrad.f@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: prism2mgmt: Fixed a parentheses coding style
Message-ID: <2024011713-majorette-abridge-56c9@gregkh>
References: <ooj7nta3skljhnpwtz3wk37uztyayaewfoz2k2b7bnfivnoqtr@ymml6q24k5y2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ooj7nta3skljhnpwtz3wk37uztyayaewfoz2k2b7bnfivnoqtr@ymml6q24k5y2>

On Wed, Jan 17, 2024 at 10:38:13AM +1300, Hoorad Farrokh wrote:
> Fixed a coding style problem.
> 
> Signed-off-by: Hoorad Farrokh <hourrad.f@gmail.com>
> ---
>  drivers/staging/wlan-ng/prism2mgmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
> index d5737166564e..a1adf69ba9f9 100644
> --- a/drivers/staging/wlan-ng/prism2mgmt.c
> +++ b/drivers/staging/wlan-ng/prism2mgmt.c
> @@ -1288,8 +1288,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
>  
>  		/* Set the driver state */
>  		/* Do we want the prism2 header? */
> -		if ((msg->prismheader.status ==
> -		     P80211ENUM_msgitem_status_data_ok) &&
> +		if (msg->prismheader.status ==
> +		     P80211ENUM_msgitem_status_data_ok &&
>  		    (msg->prismheader.data == P80211ENUM_truth_true)) {
>  			hw->sniffhdr = 0;
>  			wlandev->netdev->type = ARPHRD_IEEE80211_PRISM;
> -- 
> 2.42.0
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

- You sent a patch that has been sent multiple times in the past, and is
  identical to ones that has been rejected.  Please always look at the
  mailing list traffic to determine if you are duplicating other
  people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

