Return-Path: <linux-kernel+bounces-15200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D46B822848
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16667B22CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018D179B7;
	Wed,  3 Jan 2024 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aKBKayc+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639CB18021;
	Wed,  3 Jan 2024 06:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBCDC433C7;
	Wed,  3 Jan 2024 06:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704262323;
	bh=ZnALP/rsm1JX4E6rxglrE/RNqWl1VhEe5May+DWkRFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKBKayc+vO2e81o8/bKPhFxdcvFkDqCpD/RFq1KtyTtFJLDapxOEXEmBm7wqh50vH
	 CZIAfreNurV+Qy20H/S1IcmB8f7/1XGGQF5b0Pm6Ofxnub7IampkQi0tw7s8zP8L7t
	 /lnn8twfw55Q7M2QLRI5QX572lfoLkznUFyEc4dg=
Date: Wed, 3 Jan 2024 07:12:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, christian.riesch@omicron.at,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asix: Add check for usbnet_get_endpoints
Message-ID: <2024010347-daybed-unrated-5608@gregkh>
References: <20240103033534.2764386-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103033534.2764386-1-nichen@iscas.ac.cn>

On Wed, Jan 03, 2024 at 03:35:34AM +0000, Chen Ni wrote:
> Add check for usbnet_get_endpoints() and return the error if it fails
> in order to transfer the error.
> 
> Fixes: 16626b0cc3d5 ("asix: Add a new driver for the AX88172A")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/usb/ax88172a.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

