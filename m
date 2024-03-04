Return-Path: <linux-kernel+bounces-90081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405186F9FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5871F21429
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B20CA73;
	Mon,  4 Mar 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hpHL7a7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA9BA5E;
	Mon,  4 Mar 2024 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533240; cv=none; b=cR9M+Z7PEkyW8VrqYKJv5+SdrWNlQExS4iIacKVJfmgKj2RaIsM3FVnQeCtnAxEwahxUVamTYmJGeaaZHlCMeA3XQerhDg8AlwDmVl4ds8Z1daj2sjaUUprtdFniho+MUFe6IyeRDW3X3jiuI6FdcQsrsYXUQ+M4RRYzdlDGMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533240; c=relaxed/simple;
	bh=EqzI/SlOmaNHexPGx9cer0W5P6sioOhdWsH/Lm5WZiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YopnQ3Ig3l7oOgI4eLa2JIZrabf+9fczhjmkID7XluSWLu82NrrRTbaNb2SO0jXUE0j9WXHWrGKUi99PxCTgSs60l8Ke6MzBsMNNXYMcwBVOOXKXCVYFrt1NPYcWEQk1ZT+SO1+cY6vtuPQUkOITVteJNpd70NVBvpOchqcbo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hpHL7a7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E76C433C7;
	Mon,  4 Mar 2024 06:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709533240;
	bh=EqzI/SlOmaNHexPGx9cer0W5P6sioOhdWsH/Lm5WZiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpHL7a7yupKUm2mnWv+iDxm0CvCgSGC1IXjS1IyAZHXlxE2CoFiREzb+wXhsxMpuC
	 vc9sq4J6/AhMjsI/yzIyrm0HxF3Rnhf/IhiAxtAt+lnuOmRid9uHYrrgGVy6Ziku6Y
	 wWdo064Ox70XMED2gCWqmn6Wzxylr8/87O4JLSac=
Date: Mon, 4 Mar 2024 07:20:30 +0100
From: Gregkh <gregkh@linuxfoundation.org>
To: Aman Sharma <210100011@iitb.ac.in>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: pi433: Updated bitrate range from datasheet
Message-ID: <2024030418-sports-rebate-1d44@gregkh>
References: <91454ef9b4a12f01e13d69b675d81aff@iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91454ef9b4a12f01e13d69b675d81aff@iitb.ac.in>

On Mon, Mar 04, 2024 at 11:23:40AM +0530, Aman Sharma wrote:
> Updated bitrate range for FSK and OOK modulation from the RFM69 Datasheet.
> The values are mentioned in Section 2.3.2 of the datasheet.
> 
> Signed-off-by: Aman Sharma<amansharma6122002@gmail.com>
> ---
>  drivers/staging/pi433/Documentation/pi433.txt | 6 ++++--
>  drivers/staging/pi433/TODO                    | 1 -
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/pi433/Documentation/pi433.txt
> b/drivers/staging/pi433/Documentation/pi433.txt
> index 4a0d34b4ad37..9ce7282ef6f8 100644
> --- a/drivers/staging/pi433/Documentation/pi433.txt
> +++ b/drivers/staging/pi433/Documentation/pi433.txt
> @@ -78,7 +78,8 @@ rf params:
>  		Allowed values: 433050000...434790000
>  	bit_rate
>  		bit rate used for transmission.
> -		Allowed values: #####
> +		Allowed values (For FSK): 1200...320000
> +		Allowed values (For OOK): 1200...32768
>  	dev_frequency
>  		frequency deviation in case of FSK.
>  		Allowed values: 600...500000
> @@ -169,7 +170,8 @@ rf params:
>  		Allowed values: 433050000...434790000
>  	bit_rate
>  		bit rate used for transmission.
> -		Allowed values: #####
> +		Allowed values (For FSK): 1200...320000
> +		Allowed values (For OOK): 1200...32768
>  	dev_frequency
>  		frequency deviation in case of FSK.
>  		Allowed values: 600...500000
> diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
> index 63a40bfcc67e..61ed3a1578bc 100644
> --- a/drivers/staging/pi433/TODO
> +++ b/drivers/staging/pi433/TODO
> @@ -2,4 +2,3 @@
>  * still TODOs, annotated in the code
>  * currently the code introduces new IOCTLs. I'm afraid this is a bad idea.
>    -> Replace this with another interface, hints are welcome!
> -* Some missing data (marked with ###) needs to be added in the
> documentation
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

