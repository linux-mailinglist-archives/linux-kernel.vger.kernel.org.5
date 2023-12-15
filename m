Return-Path: <linux-kernel+bounces-927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC74814820
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B411C2350D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213A2C6A2;
	Fri, 15 Dec 2023 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KynfSUXa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E02C68E;
	Fri, 15 Dec 2023 12:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3E0C433C7;
	Fri, 15 Dec 2023 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702643605;
	bh=rScjbXdnr/z3TtdU134OVUiIqQBoVIxxCS3KlaMCrlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KynfSUXa7ujHkHZovyC3Gx0NdUmDRiUxos/D1ZOgOVsVzYu6yfUsuDjVQSYjJPzzM
	 NNxAGdsom4AN4OlpLrjSMVvYIWzwGJT3hNcLjMTQlCXSEkGgbFK00KNTr2vuecRmlF
	 iemyhK7N1leigJI27v1bWtxkKLfaVIwa2CaQEhHE=
Date: Fri, 15 Dec 2023 13:33:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan DSilva <expitau@gmail.com>
Cc: philipp.g.hortmann@gmail.com, tdavies@darkphysics.net,
	kamrankhadijadj@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Add blank line after declarations
Message-ID: <2023121558-writing-scariness-a6ca@gregkh>
References: <20231215032852.501316-1-expitau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215032852.501316-1-expitau@gmail.com>

On Fri, Dec 15, 2023 at 03:28:52AM +0000, Nathan DSilva wrote:
> Found using checkpatch, removes one warning about line breaks after
> declarations.
> 
> This is my first patch, feedback is welcome. I am submitting this as a test
> before moving to other subsystems to (hopefully) make more meaningful
> contributions.
> 
> Signed-off-by: Nathan DSilva <expitau@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_rx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index ecaa4dec3f94..397859c7f5b1 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -946,6 +946,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
>  {
>  	u8 type, stype;
>  	u16 fc = le16_to_cpu(hdr->frame_control);
> +
>  	type = WLAN_FC_GET_TYPE(fc);
>  	stype = WLAN_FC_GET_STYPE(fc);
>  
> -- 
> 2.43.0
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

