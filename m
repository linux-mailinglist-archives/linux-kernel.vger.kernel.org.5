Return-Path: <linux-kernel+bounces-159693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996358B3249
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC224B22CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B73A13C9BC;
	Fri, 26 Apr 2024 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jkx9vo+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9533981
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120128; cv=none; b=PIIYuQ+XU7y8SG5R9naT5Sgce6vfSQ9tPuR4jU+KzCVlrap3ugoxd2CkIxvihH9xco0jOhTjkHDtFxRu9av6i+M4dB90EPlHhEfYxXTKv2J0+cxzRzpwOAZMELORvNzhLtqB4lsCd5J+k1pSFIPVi+oY3feWfhSM+hSm//HEOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120128; c=relaxed/simple;
	bh=b45WhGsUbMs/Aao6bI5khlq7pgS1Ea1P4SDgIZ9e3CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q66/BmwRy3J+JowngJjIPDZD1ZwZ4bBlpQLbwao4k8ZRQi7UeYy+TZAGvv7e4R0XPVRbTmVLfzSSGjJieQ9rNIsWkxvF1YtguPZLjNZZodry69+jri4xt8ou5+654ZMLyl/vnNyanJDYWnlz9S7OUUuRZj9OsWKDTTX5r7e+GgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jkx9vo+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABBFC113CD;
	Fri, 26 Apr 2024 08:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714120128;
	bh=b45WhGsUbMs/Aao6bI5khlq7pgS1Ea1P4SDgIZ9e3CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jkx9vo+ESNU1TwEoxKGTXP/16UVlXmQBMUL9qKSdJMBT30Gf63OgJn0om23p0bX1D
	 +E4hbRUAXEaZRAAtLay1aL3/x53aitBRuyZcP1NVuggf38gkYBqCNtJSLxDWbWQyGS
	 qMPSxPK4MCM5XiANR1JjTL86VBawF2cw6WUgdCLg=
Date: Thu, 25 Apr 2024 18:04:33 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Message-ID: <2024042501-stargazer-departure-e5b9@gregkh>
References: <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <MW4PR18MB5244CD9591CDE87CB062DFEAA6172@MW4PR18MB5244.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR18MB5244CD9591CDE87CB062DFEAA6172@MW4PR18MB5244.namprd18.prod.outlook.com>

On Thu, Apr 25, 2024 at 01:36:05PM +0000, Vamsi Krishna Attunuru wrote:
> > 
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Friday, April 12, 2024 5:57 PM
> > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > Subject: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > > Octeon CN10K DPI administrative driver
> > >
> > > Prioritize security for external emails: Confirm sender and content
> > > safety before clicking links or opening attachments
> > >
> > > ----------------------------------------------------------------------
> > > On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru wrote:
> > > > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's
> > > > physical function which initializes DPI DMA hardware's global
> > > > configuration and enables hardware mailbox channels between physical
> > > > function (PF) and it's virtual functions (VF). VF device drivers
> > > > (User space drivers) use this hw mailbox to communicate any required
> > > > device configuration on it's respective VF device. Accordingly, this
> > > > DPI PF driver provisions the VF device resources.
> > > >
> > > > At the hardware level, the DPI physical function (PF) acts as a
> > > > management interface to setup the VF device resources, VF devices
> > > > are only provisioned to handle or control the actual DMA Engine's
> > > > data transfer
> > > capabilities.
> > >
> > > No pointer to the userspace code that uses this?  Why not?  How are we
> > > supposed to be able to review this?
> > 
> Hi Greg, please check the below files for userspace code that interact with this kernel driver.
> driver/roc_dpi.c provides the mailbox interface to communicate with this kernel driver.
> application/main.c is the DPI DMA application which uses this misc driver to configure
> the device with required mps, mrrs, fifo_mask parameters.
> 
> https://github.com/VamsiKrishnaA99/dpi-dma/blob/main/driver/roc_dpi.c 
> https://github.com/VamsiKrishnaA99/dpi-dma/blob/main/application/main.c

Please provide this information in a new version of the patch, looking
at this now when we don't have the kernel code present is almost
impossible, sorry.

thanks,

greg k-h

