Return-Path: <linux-kernel+bounces-89563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57586F219
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DA2B228E5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D353FE4E;
	Sat,  2 Mar 2024 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y3dE4PCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9154085A;
	Sat,  2 Mar 2024 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709407153; cv=none; b=L9AjGtQBg6NkXd/bmnN/tLuNYalzMCr35nfZdR5gDMJOtU8/R1LFEed2+1H2tCyim6HhQOpvxSLduzb7Pd2I/i4zTbJVRgWGHLhHaCSaS/BLetuSgLsweDU/HtGFlAgltZxGX5BsKrFXCtUDqZy8ao5fAYFqSSnat4UiRiC37Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709407153; c=relaxed/simple;
	bh=jVkskR3yPyVbQiLF1f3ZMKaybYafz/MQVKpjoW8/nvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diYGy8+pQdlx+tbFyNpYghtLytD+7ghzcbQQIn6enS8lIPzxtOpOyiCVRCtXycj/T9fEDRjnMPTkqOuGWjFR7E5GVJSK84rLxVCW0r9uYoDsApsapWlgD8OlY9XeJH+s8r8FQnAZ0Wt0bZ07sM8iUcg9+OP4yasdlO8KthTMoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y3dE4PCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B7FC433C7;
	Sat,  2 Mar 2024 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709407153;
	bh=jVkskR3yPyVbQiLF1f3ZMKaybYafz/MQVKpjoW8/nvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3dE4PCKAFMfa02NeBGWGdnTTO0iS8DZEO/P4qNMkhFeCc1BIl21m7AHOiPqS5BtA
	 NBO1ZM+iW1ATXoNDbX+leOEFDvXgDh9xG48jxSIM/3g+Uk5jcRO8tWUQzvjh5rVuzg
	 M0NpZ7Zis1+WCFWN1CyHOO+viXOEAe8Wfr+NBa8A=
Date: Sat, 2 Mar 2024 20:19:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lars Melin <larsm17@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Tom Hu <huxiaoying@kylinos.cn>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH] usb-storage: Add Brain USB3-FW to IGNORE_UAS
Message-ID: <2024030221-tilt-remission-7d7a@gregkh>
References: <20240226075936.1744353-1-huxiaoying@kylinos.cn>
 <a960f1c2-a858-498e-a0cf-4c15d74487d5@rowland.harvard.edu>
 <960d9120-47b3-4961-9ce7-cd9e8b760220@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960d9120-47b3-4961-9ce7-cd9e8b760220@gmail.com>

On Sat, Mar 02, 2024 at 07:06:20PM +0700, Lars Melin wrote:
> On 2024-03-01 23:53, Alan Stern wrote:
> > >   drivers/usb/storage/unusual_uas.h | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
> > > index 1f8c9b16a0fb..98b7ff2c76ba 100644
> > > --- a/drivers/usb/storage/unusual_uas.h
> > > +++ b/drivers/usb/storage/unusual_uas.h
> > > @@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
> > >   		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> > >   		US_FL_NO_REPORT_LUNS),
> > > +/* Reported-by: Tom Hu <huxiaoying@kylinos.cn> */
> > > +UNUSUAL_DEV(0x1234, 0x1234, 0x0000, 0x9999,
> > 
> > The vendor and product ID values have a suspicious look, but they appear
> > to be genuine.
> 
> Hi Alan,
> it is of course a bogus Id, here is another one:
> 
> "SmartWi - Multi Room Solution is a Smart Card Reader hardware device. This
> driver was developed by SmartWi International A/S. The hardware id of this
> driver is USB/VID_1234&PID_1234."
> 
> found by googling vid_1234&pid_1234.
> 
> There are others like 1234:5678 which also looks suspicious.

Yeah, this is a "fake" number, which happens a lot (0000/0000 is also
used.)

Because of this, I don't know if we should take this change.  It
obviously fixes an issue for _this_ device, but for any other
usb-storage device using this fake id, will it cause issues?

thanks,

greg k-h

