Return-Path: <linux-kernel+bounces-111606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A64886E76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D2A1C2113C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070C47F51;
	Fri, 22 Mar 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yz1Nyi7V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D047A60;
	Fri, 22 Mar 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117540; cv=none; b=jS8ohh5+CjVdB1SVBMqFAsL7Lws3bQAUPiTI7KNP5uHhcWs4ekpTKZkgiPyURfO9LD2jRah5OPj05qgcelNo+bF/LETDM0kWwQPyqqbH5G78hfYkNUTn91vWrS/N488d9SHlZP+/k2HCwUYp5N5lZJpEey9mJ9p7XD8soyzj49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117540; c=relaxed/simple;
	bh=p34/324xP2XXUiHY7h/GE3DoOsaLPBDkUoaF7CbR5ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3A1bPnMoVMXblK8ykf5tauTBISEPMG5yefEy+EnOBhXms4sDwomAJY/c0B5MuaIz80+oYwONVTsamtRFfb74RYuTNVDYZpt/RlAFLrd1LNNGNnaAs0pQuFm58c0qESun/6ofckTIbR7UGarFV40+rWJnpJaTP9jN63D/gZZTww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yz1Nyi7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E8EC43399;
	Fri, 22 Mar 2024 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711117540;
	bh=p34/324xP2XXUiHY7h/GE3DoOsaLPBDkUoaF7CbR5ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yz1Nyi7VaAjRIUJ2aXFHrvz2lf7erBm5c0SU0+6squjXOGPIZvxVYw7d79Zyvofez
	 2bcuX0dqsmIhU6kqfF0f4AKk3/GBAs4I3RxiRmzXdW/cdWnza79lNjiccNYHqQQvd9
	 B8uUanqtD52mlr2k9Vr710DR2Gg2OYf4tQ6auJ5A=
Date: Fri, 22 Mar 2024 15:25:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: sudipm.mukherjee@gmail.com, dan.carpenter@linaro.org,
	teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: sm750fb: Replace comparisons with NULL and 0
Message-ID: <2024032226-gorgeous-snowbird-25b1@gregkh>
References: <2024032208-blunt-ferocity-22f4@gregkh>
 <20240322141031.2776-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322141031.2776-1-chandrapratap3519@gmail.com>

On Fri, Mar 22, 2024 at 07:40:31PM +0530, Chandra Pratap wrote:
> Replace '(opt != NULL)' with '(opt)' and '(*opt != 0)'
> with '(*opt != '\0')' to adhere to the coding standards.
> 
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 04c1b32a22c5..c4b944f82fb9 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -926,7 +926,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  		goto NO_PARAM;
>  	}
>  
> -	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
> +	while ((opt = strsep(&src, ":")) && *opt != '\0') {
>  		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
>  		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
>  
> @@ -1147,7 +1147,7 @@ static int __init lynxfb_setup(char *options)
>  	 * strsep() updates @options to pointer after the first found token
>  	 * it also returns the pointer ahead the token.
>  	 */
> -	while ((opt = strsep(&options, ":")) != NULL) {
> +	while ((opt = strsep(&options, ":"))) {
>  		/* options that mean for any lynx chips are configured here */
>  		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
>  			g_noaccel = 1;
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

