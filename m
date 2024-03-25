Return-Path: <linux-kernel+bounces-117422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEBE88AB37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCA0369A46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF615356C;
	Mon, 25 Mar 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UTx2Wt1B"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4CD272;
	Mon, 25 Mar 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382235; cv=none; b=BNJTN0vdUoJGEcQ3Or+RMCVkwyhCVPT1mwEay4FFPPfCl8aL8Ai2+i/btAv01KHG6dUaZEpus8nA1OtIsgcU3+0ibrdEbzmZ1rG3Fq/iExN2Xs2ZY5azK0qLy6Wno/LqDU+VdJeWEYpTgpkFopE+rxP3+XIbeuFmyCyGQcrxrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382235; c=relaxed/simple;
	bh=rqfE9xcntcYQ93Gam/45NyhYzJafmljtmywYwC1FnIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAYcA6eZs6jmquRELwoVnGhQ8cdum0LwtTtYfC2ZxlYujqI0ZayjP65kdQ9hR67Z3bAt4J8hZfIPu0HayfPv8f4IJl7G7rIYXlO7EFPZMDhn2ZBPWj7TFeem7v0ltSPyJlUvwykHfEgF9gmNjIi0RM7K1ykHck/nyR/eblgZyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UTx2Wt1B; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 114FA40005;
	Mon, 25 Mar 2024 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711382225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3m0PtOuLhnJ+6DNxPBawU6YU38hlNjYHLn/3Vg64K5g=;
	b=UTx2Wt1BeEb+vr7yg+TJnPWeYXZqUTeHZJvTluJb9LqJ6iIHX04FLkAODJwfzlAt6nRhZc
	wcY07IpEkA31mXG8UueekNvuWp5+nctcpVdGrokgpBRLZTN8nLgol0GWkK8QslaaDOHZwq
	WSH8t35OG2GmOoBQ+ZNN/MFAjswFPiDNIizKNjnWZbA9ixd9TvP7UWfYooI/ErLf1c4nph
	Jp342vvXZWfX7WPLqp5CosoXQ34fwRObVXxA0fafWG557lOpuKekBG+v9ZC3KulVfagQMI
	pyTtjPbROpwIrKH/+jBsaeR2gp1GYRmucUXIJ1qDpHyHAFwIaYpHlEGS8H1msw==
Date: Mon, 25 Mar 2024 16:57:03 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Sui Jingfeng
 <sui.jingfeng@linux.dev>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <20240325165703.7486eac2@bootlin.com>
In-Reply-To: <ZgGal-SJGWvn80Uk@smile.fi.intel.com>
References: <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
	<20230301143625.7kdnzujlv4psbhla@skbuf>
	<Y/9qtT0vckSikOKJ@smile.fi.intel.com>
	<20230301152527.khyzifds4w3rkebt@skbuf>
	<Y/9wlDkuh39auAgF@smile.fi.intel.com>
	<20230301171845.oliqbso7v2vmyqr3@skbuf>
	<Y/+MaRO4vrCRFXE8@smile.fi.intel.com>
	<20230301174309.5nqul7vg5uygwtpy@skbuf>
	<ZgF-_ww5k3h9pvEm@smile.fi.intel.com>
	<20240325161627.1c0fc955@bootlin.com>
	<ZgGal-SJGWvn80Uk@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andy,

On Mon, 25 Mar 2024 17:39:03 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Mar 25, 2024 at 04:16:27PM +0100, Herve Codina wrote:
> > On Mon, 25 Mar 2024 15:41:19 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> 
> ...
> 
> > > > I agree we don't want to have multiple approaches of doing the same thing,
> > > > but I debate whether I am really doing the same thing?
> > > > 
> > > > If software nodes are not designed to be a good fit for my kind of use
> > > > case, then what are they designed for?    
> > > 
> > > I think the hardware should be described in the respective format. Yet, you
> > > have a point that it's too verbose to the cases when we know the layout of
> > > the attached (not-hotpluggable) devices.
> > > 
> > > There are discussions [1,2] on how to enable DT for the cases when
> > > non-discoverable HW needs to be detected and enumerated.
> > > 
> > > I don't know which solution will eventually be accepted, but my personal
> > > opinion here that we would like to distantiate from board files as much
> > > as possible.
> > > 
> > > Btw, for the internal (board files) code we may also use property to
> > > go with (see how spi-pxa2xx uses that) to distinguish configurations.
> > > But it might be not that straight as with driver data.
> > > 
> > > So far, I haven't seen the code (am I mistaken?) which makes use of driver data
> > > for software nodes.
> > > 
> > > [1]: https://lore.kernel.org/lkml/20231128084236.157152-1-wenst@chromium.org/
> > > [2]: https://lore.kernel.org/lkml/1692120000-46900-1-git-send-email-lizhi.hou@amd.com/
> > > 
> > > Aux topics which might not directly be related (in order of declining relevance
> > > from my p.o.v.):
> > > https://lore.kernel.org/lkml/20231130165700.685764-1-herve.codina@bootlin.com/
> > > https://lore.kernel.org/lkml/DM6PR12MB3993D5ECA50B27682AEBE19FCD67A@DM6PR12MB3993.namprd12.prod.outlook.com/
> > > https://lore.kernel.org/lkml/20240217010557.2381548-1-sboyd@kernel.org/
> > >   
> > 
> > I work on PCI DT overlay support.
> > The idea is to have a PCI driver that loads a DT overlay to describe the
> > hardware embedded in the related PCI device. Some features related to this
> > topic are already upstream.
> > 
> > Rob did a presentation of this topic at the Linux Plumber conference last
> > year (https://www.youtube.com/watch?v=MVGElnZW7BQ).
> > 
> > IMHO, your use-case is pretty much the same. Of course it is not a PCI
> > device but a SPI device. Even if the device beyond the SPI bus cannot be
> > memory mapped, the idea seems pretty much the same: describe the hardware
> > embedded in a specific device.
> > 
> > You mentioned that you need the '-@' option when you compile your base dtb.
> > In fact, it depends on the resources you need to reference from your overlay.
> > On my case (DT overlay to describe a PCI device), I don't need any references
> > to a base dtb from the overlay. I don't need to use the '-@' option.
> > Even more, I started (not yet upstream) to use all of this feature on an ACPI
> > base system and it works.
> > 
> > My PCI device is a Microchip LAN9662 PCI device.
> > The Microchip LAN9962 can be a "traditional" SoC with CPU cores and several
> > IPs but also a PCI device.
> > When provided as a PCI device, the internal CPU cores are no more available
> > and replaced by a PCI endpoint IP.
> > All the accesses done by the SoC CPU cores are replaced by accesses done by
> > the host PCI system through the PCI endpoint.
> > Drivers were already present upstream (traditional SoC platform driver such
> > as i2c mdio, clock, switch, ...) and are used without any modifications for
> > the PCI device.
> > All the wiring (mapping) between the PCI world and the internal device
> > hardware is done using a DT overlay.  
> 
> Thank you, Herve, for looking into this. As far as I understood, slowly but
> successfully the required changes for your use case are being landed. If so,
> it makes driver data for software nodes approach even lower priority.
> 

Yeah, some more changes are still needed to fully support my use case but
everything is on the right track.

Best regards,
Hervé

