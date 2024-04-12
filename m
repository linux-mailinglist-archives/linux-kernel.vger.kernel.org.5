Return-Path: <linux-kernel+bounces-142960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF198A328C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922FD1C23921
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D6D1482F3;
	Fri, 12 Apr 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JnIhge2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F63147C7D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936080; cv=none; b=n8eRj/8QUaUWqH9Ft/Wq+nglecYH8p62iJgBkBJ3Lyrkbzp7iMhlZqpn90fob6s7tDEvox3lTRZNkRV0QwuzZWTfXsWOExL7arqZXGhT4xXtbK5E5KmyksjL44ZbgE+J096GfW2d/c7BJJLTxuQpSmd+v1JrBMcOPg0Zkq349Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936080; c=relaxed/simple;
	bh=xkYKPOI498KzpgzVZSU6RZmjpKWXLitmgQGEr4XGiTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oER6XdOezR0ecqEVt6+lkprs0BI9aMnFUYyklO3dqNHJ05Wxc1H+RPFlxsP1G3PnjtTTrlij1sZg7V4H/yLmVbfyWQIZpe2R4anlVTtPUoAF67p+/N9ib8/Y8o3DwYD8Xyqo2ZDn3VtYE27K79j5T4aVbm6TGPhRT/tcUSGIzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JnIhge2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9757C113CC;
	Fri, 12 Apr 2024 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712936080;
	bh=xkYKPOI498KzpgzVZSU6RZmjpKWXLitmgQGEr4XGiTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnIhge2zkirUvaSqDrtjBFRL8bG1w/Tqyxqt6VZ0HgH4qdAtP4jL3FkfGfixsVaD2
	 XyJlSpNBXuGPpuydT87PLgV3JTnAM4pkMMaHDRpzsqlT0L65ZnUuKp2VuyhvekyCJ+
	 N9HWNmiWcVAej0NEdq3gRIZRR9knaqe2ERhPNnas=
Date: Fri, 12 Apr 2024 17:34:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Message-ID: <2024041258-reminder-widely-00c0@gregkh>
References: <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>

On Fri, Apr 12, 2024 at 01:56:36PM +0000, Vamsi Krishna Attunuru wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, April 12, 2024 5:57 PM
> > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
> > CN10K DPI administrative driver
> > 
> > Prioritize security for external emails: Confirm sender and content safety
> > before clicking links or opening attachments
> > 
> > ----------------------------------------------------------------------
> > On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru wrote:
> > > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
> > > function which initializes DPI DMA hardware's global configuration and
> > > enables hardware mailbox channels between physical function (PF) and
> > > it's virtual functions (VF). VF device drivers (User space drivers)
> > > use this hw mailbox to communicate any required device configuration
> > > on it's respective VF device. Accordingly, this DPI PF driver
> > > provisions the VF device resources.
> > >
> > > At the hardware level, the DPI physical function (PF) acts as a
> > > management interface to setup the VF device resources, VF devices are
> > > only provisioned to handle or control the actual DMA Engine's data transfer
> > capabilities.
> > 
> > No pointer to the userspace code that uses this?  Why not?  How are we
> > supposed to be able to review this?
> 
> Userspace code will use two functionalities (mailbox & ioctl) from this driver. DPDK DMA driver uses the mailbox and
> the dpdk application uses the ioctl to setup the device attributes. We are waiting for this kernel driver get merged
>  to update the corresponding support in DPDK driver and applications. I will provide the pointers to both the use
> cases in userspace code. 
> Meanwhile below is the current dpdk dma driver that uses sysfs based scheme to convey mbox requests to
> the kernel DPI driver which gets replaced with hardware mailbox scheme once mrvl-cn10k-dpi kernel driver is merged.
> https://github.com/DPDK/dpdk/blob/main/drivers/common/cnxk/roc_dpi.c

So this is a DPDK thing?  Ugh, do the networking people know about this?
If not, why aren't they reviewing this?

> > > +	__u64 update_molr; /* '1' to update engine MOLR */
> > 
> > You "burn" a whole 64 for 1 bit?  That feels wrong, who on your end
> > reviewed this api to be correct?
> 
> Just for the explicit alignment, defined all variables as __u64. I will shrink it to minimal sizes
> considering any reserved fields if required.

The alignment is fine, but wasting 63 bits feels odd, make it a bit
field at worst case, or just make it __u8 if you don't want a bitfield.

thanks,

greg k-h

