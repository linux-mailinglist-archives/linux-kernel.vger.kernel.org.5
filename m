Return-Path: <linux-kernel+bounces-70764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DBF859BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28B51C20DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CCB200B1;
	Mon, 19 Feb 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IgE1BcYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BA1CD38
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323522; cv=none; b=dwfAgIEKb1ti8Z1NIHvxB3nk6PwmJ472abwjug/na5tvXC1pC7h0l0hsPhrdy6soQEhshhO0ENblrAl74VPb8Su0IvYVz/RnxJzyZGwT/VWxjtKIjKC3v5CpJSYDW6JUMcJ2J7nhct0SI9CvQoFhiB3GnNRwTKes5LjeLoou/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323522; c=relaxed/simple;
	bh=lEf5GE703li3fVw5B+qctZ3bGPCdTQaVbHU7CRuRmF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQYTL/cPb+RSjc5ULsOaDKowQqfT98S2ylAKTgoklBqfqYmJiJ9KqiOw+JlAjnMLichFs4rmoTFXv8u+gcsZGaaOomMOM1vNCYKSw1zfSyJCfqH8C4ZxEFPL+R5nZAvPiFzhvQZIjVsrKJbHMFpqYdnREJMDFsQ5Bca17Y/SowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IgE1BcYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0ADC433F1;
	Mon, 19 Feb 2024 06:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708323521;
	bh=lEf5GE703li3fVw5B+qctZ3bGPCdTQaVbHU7CRuRmF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgE1BcYK8DAc6sS5Ul83IWkKau+YEq+zJcn3+nUouqFojDKNGL3j357zvcxvZZC5w
	 /iva5EjbzVNwUMRQHCO9+96gWANriOiotPIfAkQxuJOPnWWC90XV9mLliWShBOgQqa
	 aiVSLTolMrk4zy9nMV/DS5wamdEoVRi2+q6FTsBU=
Date: Mon, 19 Feb 2024 07:18:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K
 dpi driver
Message-ID: <2024021913-aftermost-footnote-cd6e@gregkh>
References: <MW4PR18MB5244844411A57790287068E5A64E2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240216103225.1255684-1-vattunuru@marvell.com>
 <2024021713-corrode-landline-e186@gregkh>
 <MW4PR18MB52448A9E37DCDB04F84C2013A6512@MW4PR18MB5244.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR18MB52448A9E37DCDB04F84C2013A6512@MW4PR18MB5244.namprd18.prod.outlook.com>

On Mon, Feb 19, 2024 at 05:03:38AM +0000, Vamsi Krishna Attunuru wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Saturday, February 17, 2024 1:44 PM
> > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > Subject: [EXT] Re: [PATCH v2 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K
> > dpi driver

Why is this here?

> > External Email
> > 
> > ----------------------------------------------------------------------
> > On Fri, Feb 16, 2024 at 02:32:25AM -0800, Vamsi Attunuru wrote:
> > > Adds a driver for Marvell CN10K DPI(DMA Engine) device's physical
> > > function which initializes DPI DMA hardware's global configuration and
> > > enables hardware mailbox channels between physical function (PF) and
> > > it's virtual functions (VF). VF device drivers (User space drivers)
> > > use this hw mailbox to communicate any required device configuration
> > > on it's respective VF device. Accordingly, this DPI PF driver provision the VF
> > device resources.
> > >
> > > At the hardware level, the DPI physical function (PF) acts as a
> > > management interface to setup the VF device resources, VF devices are
> > > only provisioned to handle or control the actual DMA Engine's data transfer
> > capabilities.
> > >
> > > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > > ---
> > >
> > > Changes V1 -> V2:
> > > - Fixed return values and busy-wait loops
> > > - Merged .h file into .c file
> > > - Fixed directory structure
> > > - Removed module params
> > > - Registered the device as misc device
> > 
> > Why register as a misc device if you don't actually use it at all?  That feels
> > pointless and extra code and confusion for everyone as you have created a
> > device node in the system that will just fail all operations made on it.
> > 
> > confused,
> > 
> 
> Module params are removed in V2, planning to use device node to pass the device configuration tuning parameters and other ops, can you please also share other v2 review comments, I will plan to address it in V3.

How is a reviewer supposed to know that you are going to use unused code
sometime in the future when you do not say that here?

What would you do if you had to review such code?  You would stop there
and wait for it all to make sense.

Please try to get some internal review next time before you send out
your next version so that you don't waste other's time reviewing dead
code like this.

thanks,

greg k-h

