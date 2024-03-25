Return-Path: <linux-kernel+bounces-117680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05E88AE5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935A41FA145C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998881AD8;
	Mon, 25 Mar 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mp2+12td"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D77581A;
	Mon, 25 Mar 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390046; cv=none; b=Lt2IVEwMZL3gknxBDXzfR76vYbwlJvj7bSsNCxj9wTNDjnU/fTEFYtGFfR4c4+gHqsy0Gtgsdu8N0la2Io5vUeT0hElZyx3LyN3ZMW+vrtZFpyPh/5VDqJkGXdRLgLbcIgYl7/+b3CgPw69K0N9OMn+3sjCIlsGK3zFoUYoLOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390046; c=relaxed/simple;
	bh=uElAACRFDI0j/vTdgHmzSMj2c0Df8wvGMjMWYJFSYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ife/Ak3No5L5185qjZjYTun2GxrSVkzxJY1BJk/Ckd77gy0jfxFCbjh0sMwpqaT2Y2G4CViKDWZhfXQDPYtjbBbiOppCPhOrolpf9Q7Wr3C8Ui6bFAcIaB2Gq/yTABT/8UOJWehBR5VYFiwvzFFbkOnAHOlBFpELAr7DyPbkOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mp2+12td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E47C433C7;
	Mon, 25 Mar 2024 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711390046;
	bh=uElAACRFDI0j/vTdgHmzSMj2c0Df8wvGMjMWYJFSYEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mp2+12tds5yhIKq6953aOqGSPsBG6pK01tZSN0Mxw49aPyGono5jUQH/XTg0ArNeb
	 bXNOEBZd37prOnRwlxfBs9+bsl5GLO6G08ofmWp4JLgzVBJqpIXNI9TumN3uC3mbkG
	 M84kl2XvhoTmi/tFhJaL8rVtpnyqyB+nYRuNIUjo=
Date: Mon, 25 Mar 2024 19:07:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Brandon Crain <bcrain1606@gmail.com>
Cc: larry.finger@lwfinger.net, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8712: Removed unnecessary parentheses
Message-ID: <2024032503-bottling-water-ef34@gregkh>
References: <Zf2fuHV2gmSOSEnx@dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf2fuHV2gmSOSEnx@dev>

On Fri, Mar 22, 2024 at 09:11:52AM -0600, Brandon Crain wrote:
> Removed uneccessary parentheses from source file
> 
> Signed-off-by: Brandon Crain <bcrain1606@gmail.com>
> ---
>  drivers/staging/rtl8712/recv_linux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
> index 215fca4abb3a..2bf4661432a9 100644
> --- a/drivers/staging/rtl8712/recv_linux.c
> +++ b/drivers/staging/rtl8712/recv_linux.c
> @@ -105,7 +105,7 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
>  	skb->data = recvframe->u.hdr.rx_data;
>  	skb->len = recvframe->u.hdr.len;
>  	skb_set_tail_pointer(skb, skb->len);
> -	if ((attrib->tcpchk_valid == 1) && (attrib->tcp_chkrpt == 1))
> +	if (attrib->tcpchk_valid == 1 && attrib->tcp_chkrpt == 1)
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	else
>  		skb->ip_summed = CHECKSUM_NONE;
> -- 
> 2.34.1
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

- You sent a patch that has been sent multiple times in the past and is
  identical to ones that has been recently rejected.  Please always look
  at the mailing list traffic to determine if you are duplicating other
  people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

