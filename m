Return-Path: <linux-kernel+bounces-61157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BA850E23
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19C1283AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D382DDB1;
	Mon, 12 Feb 2024 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HRpu1H9D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62758C8E2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723638; cv=none; b=qQRiMZ2R5SXneb+LMQHu5FmrQVabyXCJPiAy7FOS+tKcl3kvhrdg4+/Yd4CANz4QX4uNcUjzfJQ3fhvwOQErLJPtSBuCW/SRxEFYoTDqg+b1r8DaY4BbaBfOmjO9UOOBbYo+j6DXzw39l+FSZq4KiBheug1D7CcpS3nkHS6joPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723638; c=relaxed/simple;
	bh=9udCnw/6FmOCJOWM7tVo1WPGzEKXicpOX6uGe/Cj4ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Irwnj/lSjCZtpqB5iMhUsby5tfeTqeuFoAMq61qCtmcw5eFhA1KWFGYscDylcjy71HiNJVui7W3/f4nBUEpEADpy2K8hIyNRrjb2u8U+5SDfEAGeF2V3BCNEJQELvF8EtZM+Jf1mCTfpnpSXzpsbYw2MspHdCjbnMSi9z4022bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HRpu1H9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54041C433C7;
	Mon, 12 Feb 2024 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707723637;
	bh=9udCnw/6FmOCJOWM7tVo1WPGzEKXicpOX6uGe/Cj4ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRpu1H9DxNXb0tra8nwsAKhTLwYH7fBwvvX5vlwSFi7ACdRMRXjKJgvm3HRkJrxSf
	 mKggMkayL5imKSWKoTcliuTEQUq34Re8Ina/WX7b9cOigNvM+9PZzG77oxbi39wCJs
	 mJn1IoLGv5S9yCE8l3uSooMNX/cU7hzEGliM866g=
Date: Mon, 12 Feb 2024 07:30:14 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org,
	james.smart@broadcom.com, dick.kennedy@broadcom.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] sound: drivers: fix typo 'reguest' to 'request'
Message-ID: <2024021201-ivory-unvaried-e836@gregkh>
References: <20240212065014.3696356-1-guoych37@mail2.sysu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212065014.3696356-1-guoych37@mail2.sysu.edu.cn>

On Mon, Feb 12, 2024 at 02:50:14PM +0800, Yinchuan Guo wrote:
> This patch fixes a widespread spelling mistake of the word "request"
> (incorrectly spelled as "reguest") across multiple files.
> 
> Signed-off-by: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
> ---
>  drivers/mfd/da9063-irq.c      | 2 +-
>  drivers/scsi/lpfc/lpfc_sli.c  | 2 +-
>  drivers/tty/serial/max310x.c  | 2 +-
>  drivers/tty/serial/sccnxp.c   | 2 +-
>  sound/soc/codecs/rt274.c      | 2 +-
>  sound/soc/codecs/rt286.c      | 2 +-
>  sound/soc/codecs/rt298.c      | 2 +-
>  sound/soc/codecs/rt5514-spi.c | 2 +-
>  sound/soc/codecs/rt5640.c     | 2 +-
>  sound/soc/codecs/rt5645.c     | 2 +-
>  sound/soc/codecs/rt5651.c     | 2 +-
>  sound/soc/codecs/rt5659.c     | 2 +-
>  sound/soc/codecs/rt5663.c     | 2 +-
>  sound/soc/codecs/rt5665.c     | 2 +-
>  sound/soc/codecs/rt5668.c     | 2 +-
>  sound/soc/codecs/rt5682-i2c.c | 2 +-
>  16 files changed, 16 insertions(+), 16 deletions(-)

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

