Return-Path: <linux-kernel+bounces-143706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A98A3C75
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF91F21FB0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F93F9C0;
	Sat, 13 Apr 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uri4XwlR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6963D0D9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007503; cv=none; b=Fj1rVM0e8sAMM8/SaI5w3oamkcAL4ObOfey1nVYXnnyHkENwiCi14ro2URMeY6sAZ1v5zCgNMiu1WvAJ2tvgKc72dmbGEe3LW1nGw4t3oN+9fYYgLY1MuPVIKN/dHVxQjE/1RRTYvGMviP3Rid27TsamVQ1+XJUbvYelSTG4VcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007503; c=relaxed/simple;
	bh=bIZwXJuyXzez1b15wr20TySh8UjtK3VL4+xANWMGEUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfbakMe6tb2wcvUJu8PQCKdoUvUh/z6vlUsPcSMEFDwxpOONTpQxbrvJ2j7uC82Yo6lbCGzEK2Mr7xu5gb8T7xaqCeoAwQDxPxO+CCTV8I6sKe3vs5AptBy2dbUXXyzwLsE5E8/eAi5gT4d8INDi9ELBlMO4BzUMeWj0ygV5dW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uri4XwlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933E3C2BBFC;
	Sat, 13 Apr 2024 11:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007503;
	bh=bIZwXJuyXzez1b15wr20TySh8UjtK3VL4+xANWMGEUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uri4XwlRqwXUyeEIp7cGLT2/6MyUe1SPz+G24cxFSa7LC+K3XBZPmxUu6z43bFImR
	 Np1fJpVqokMCwtN6HK7JnZBpP3GI60LGbgeiGEfMtFIgsuPpKvfFHEINonvYDVuYuv
	 xg6yphZ3GvWwp2p2vp7/5TORVO/xG339vMb4nHX0=
Date: Sat, 13 Apr 2024 13:25:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Message-ID: <2024041310-bundle-patio-8a22@gregkh>
References: <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041258-reminder-widely-00c0@gregkh>
 <MW4PR18MB52447D1E7F0CD0D1CA6BAACCA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041351-endowment-underrate-4b8d@gregkh>
 <MW4PR18MB52449EBFE3862D7C3065D22AA60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR18MB52449EBFE3862D7C3065D22AA60B2@MW4PR18MB5244.namprd18.prod.outlook.com>

On Sat, Apr 13, 2024 at 10:58:37AM +0000, Vamsi Krishna Attunuru wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Saturday, April 13, 2024 11:18 AM
> > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org; Jerin Jacob
> > <jerinj@marvell.com>
> > Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > Octeon CN10K DPI administrative driver
> > 
> > On Fri, Apr 12, 2024 at 04:19:58PM +0000, Vamsi Krishna Attunuru wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Friday, April 12, 2024 9:05 PM
> > > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > > Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > > > Octeon CN10K DPI administrative driver
> > > >
> > > > On Fri, Apr 12, 2024 at 01:56:36PM +0000, Vamsi Krishna Attunuru wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > > Sent: Friday, April 12, 2024 5:57 PM
> > > > > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > > > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > > > > Subject: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > > > > > Octeon CN10K DPI administrative driver
> > > > > >
> > > > > > Prioritize security for external emails: Confirm sender and
> > > > > > content safety before clicking links or opening attachments
> > > > > >
> > > > > > ----------------------------------------------------------------
> > > > > > ----
> > > > > > -- On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru wrote:
> > > > > > > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's
> > > > > > > physical function which initializes DPI DMA hardware's global
> > > > > > > configuration and enables hardware mailbox channels between
> > > > > > > physical function (PF) and it's virtual functions (VF). VF
> > > > > > > device drivers (User space drivers) use this hw mailbox to
> > > > > > > communicate any required device configuration on it's respective
> > VF device.
> > > > > > > Accordingly, this DPI PF driver provisions the VF device resources.
> > > > > > >
> > > > > > > At the hardware level, the DPI physical function (PF) acts as
> > > > > > > a management interface to setup the VF device resources, VF
> > > > > > > devices are only provisioned to handle or control the actual
> > > > > > > DMA Engine's data transfer
> > > > > > capabilities.
> > > > > >
> > > > > > No pointer to the userspace code that uses this?  Why not?  How
> > > > > > are we supposed to be able to review this?
> > > > >
> > > > > Userspace code will use two functionalities (mailbox & ioctl) from
> > > > > this driver. DPDK DMA driver uses the mailbox and the dpdk
> > > > > application uses the ioctl to setup the device attributes. We are
> > > > > waiting for this kernel driver get merged  to update the
> > > > > corresponding support in DPDK
> > > > driver and applications. I will provide the pointers to both the use
> > > > cases in userspace code.
> > > > > Meanwhile below is the current dpdk dma driver that uses sysfs
> > > > > based scheme to convey mbox requests to the kernel DPI driver
> > > > > which gets
> > > > replaced with hardware mailbox scheme once mrvl-cn10k-dpi kernel
> > > > driver is merged.
> > > > > https://urldefense.proofpoint.com/v2/url?u=https-
> > > > 3A__github.com_DPDK_d
> > > > > pdk_blob_main_drivers_common_cnxk_roc-
> > > > 5Fdpi.c&d=DwIBAg&c=nKjWec2b6R0mO
> > > > >
> > > >
> > yPaz7xtfQ&r=WllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m=o3EhoL
> > > > s7dsod
> > > > > -YHS438Wl2Pf_MKMBYegGSKteoX3qFTB0HV897ykpCVbTp-
> > > > nmj4e&s=A6TJDFUtPm3ksJh
> > > > > qop89CL8GgKj4sjkJIVi1-RdnUr8&e=
> > > >
> > > > So this is a DPDK thing?  Ugh, do the networking people know about this?
> > > > If not, why aren't they reviewing this?
> > >
> > > Actually, It's not networking related. Like the Linux kernel, DPDK
> > > also supports multiple subsystems like network, scheduler, DMA,
> > > mempool etc. Regarding the usecases, the DPDK Marvell DMA/DPI VF
> > > driver interacts(over hardware mailbox) with the mrvl-cn10k-dpi misc
> > kernel driver(administrative driver) for setting up the VF device resources.
> > 
> > So this is something that the PCI core should be concerned about then?
> 
> No, it's a normal PCIe sriov capability implemented in all sriov capable PCIe devices.
> Our PF device aka this driver in kernel space service mailbox requests from userspace
> applications via VF devices. For instance, DPI VF device from user space writes into
> mailbox registers and the DPI hardware triggers an interrupt to DPI PF device.
> Upon PF interrupt, this driver services the mailbox requests.

Isn't that a "normal" PCI thing?  How is this different from other
devices that have VF?

> > > DPDK is one example that uses this driver, there can be other
> > > userspace generic frameworks/applications where the virtual functions
> > > are binded to userspace drivers and interact with physical/administrative
> > function driver running in the kernel.
> > 
> > Are there other devices/drivers that do this today in Linux?  Why make a
> > device-specific api for this common functionality?
> 
> The apis defined in this driver are specific to Marvell DPI hardware.

The api, yes, but that's the point, shouldn't this be generic for all
hardware that supports this?  Implementation should be device specific,
in the driver.

> For instance,
> the variables molr(max outstanding load requests), fifo_max, ebus_port are
> DPI hardware specific. Generally, drivers use driver-specific api to configure
> any device-specific configuration which does not fit in common functionality right.
> 
> Mailbox operations like dpi_queue_open & close are requests sent from VF device
> to PF device for setting up the VF queue resources.

Why is an ioctl to a random character device the correct api to
userspace for this type of thing?  Shouldn't this go through the PCI
layer api instead?

thanks,

greg k-h

