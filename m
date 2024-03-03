Return-Path: <linux-kernel+bounces-89664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39786F3D8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 07:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6E283DB9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 06:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008E79C3;
	Sun,  3 Mar 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zBxpKEiB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF541854;
	Sun,  3 Mar 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709449002; cv=none; b=BtcobFOebr/6adha8sv2eMZfAvDYLvCDoVx1dmDZoFV0sRKp2MTrJKDzKgU3UPgK3VTK64bYhoOCfytOmVJ0uWeyEAXPZNesinSKQxzbiThFnKB0TGPgwybdok4flVmj/a9uJ/TIuchywjXZHp/5D4sIotWJBy9H6QURrVu+eqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709449002; c=relaxed/simple;
	bh=ep+CljRezzK9SNJpeYVAXDWpgcC6ccI7M8VH/bVsE4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C115T2LW6QbMWU4G5+/08mgq7TeFQTt46Oxo4olHPfZyDTfTl7mrfhs+9mI3scsmRcJCuOOv8DIEZpv77bv6AoQEwcjIl2Umtz7LfgC353CKskP2AmQH1og71u1pNwbbHJIvJdhvF2kmwJJ9CsYHr53jIhRANKdfqspKhxcSLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zBxpKEiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A251C433C7;
	Sun,  3 Mar 2024 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709449002;
	bh=ep+CljRezzK9SNJpeYVAXDWpgcC6ccI7M8VH/bVsE4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zBxpKEiB+2n8z1s1A8tO8Q3uQuxBHbSLt9MZRg77wURmxhYibCyEa1hJl5oF1b94J
	 aceIUHWdI3wLTAFhrpiG9ia/sXM5h0UK75unk83KNwdg0r9qb0ix9uf5ufhKyf/9xK
	 2MrRlg6SPXfx6UzUQXZIjoeQQMrIGQCev/65KEtE=
Date: Sun, 3 Mar 2024 07:56:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Bergh <bergh.jonathan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Ensure blank lines after variable
 declarations and fix misaligned */ comment formatting issues
Message-ID: <2024030322-canine-clamp-bdbd@gregkh>
References: <20240302221454.141649-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302221454.141649-1-bergh.jonathan@gmail.com>

On Sat, Mar 02, 2024 at 11:14:54PM +0100, Jonathan Bergh wrote:
> This patch fixes the following issues:
>  * Ensures a blank line after declarations
>  * Ensures */ is aligned with its correct opening /*
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_tsi148.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
> index 4dd224d0b86e..674d83325e42 100644
> --- a/drivers/staging/vme_user/vme_tsi148.h
> +++ b/drivers/staging/vme_user/vme_tsi148.h
> @@ -34,6 +34,7 @@ struct tsi148_driver {
>  	void __iomem *base;	/* Base Address of device registers */
>  	wait_queue_head_t dma_queue[2];
>  	wait_queue_head_t iack_queue;
> +
>  	void (*lm_callback[4])(void *);	/* Called in interrupt handler */
>  	void *lm_data[4];
>  	void *crcsr_kernel;
> @@ -691,8 +692,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
>  
>  #define TSI148_LCSR_VMCTRL_RMWEN       BIT(20)	/* RMW Enable */
>  
> -#define TSI148_LCSR_VMCTRL_ATO_M       (7 << 16)	/* Master Access Time-out Mask
> -						 */
> +#define TSI148_LCSR_VMCTRL_ATO_M       (7 << 16)	/* Master Access Time-out Mask*/
>  #define TSI148_LCSR_VMCTRL_ATO_32      (0 << 16)	/* 32 us */
>  #define TSI148_LCSR_VMCTRL_ATO_128     BIT(16)	/* 128 us */
>  #define TSI148_LCSR_VMCTRL_ATO_512     (2 << 16)	/* 512 us */
> @@ -753,8 +753,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
>  #define TSI148_LCSR_VCTRL_DLT_16384    (0xB << 24)	/* 16384 VCLKS */
>  #define TSI148_LCSR_VCTRL_DLT_32768    (0xC << 24)	/* 32768 VCLKS */
>  
> -#define TSI148_LCSR_VCTRL_NERBB        BIT(20)	/* No Early Release of Bus Busy
> -						 */
> +#define TSI148_LCSR_VCTRL_NERBB        BIT(20)	/* No Early Release of Bus Busy*/
>  
>  #define TSI148_LCSR_VCTRL_SRESET       BIT(17)	/* System Reset */
>  #define TSI148_LCSR_VCTRL_LRESET       BIT(16)	/* Local Reset */
> -- 
> 2.40.1
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

