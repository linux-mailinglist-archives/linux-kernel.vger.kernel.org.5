Return-Path: <linux-kernel+bounces-71255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ED585A28A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589D61F218A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4482CCB3;
	Mon, 19 Feb 2024 11:54:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451972375A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343652; cv=none; b=H1/fuzyVI8zq8BKaqZwVeWyzCunnZm9cwso/iVR0UZdaNUjJSetYYUIc0pUDYEHWBM9lng11dUY1UZyRZAUP//YLoO6m314dsfcG5wXMQyPOKeRScB+2RwyFO0u5jfxiLdavo7p4u3KkHgClOffdk2984LmGuFDwQN8gKeb54/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343652; c=relaxed/simple;
	bh=IQ+I8THSNJZOjxDOQuUmx4ca4vdRIuGe/OZr+1rekus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKX/hqjFHkgSr6wLLy1UhC/E3A3fKjKfHGWEiBnvoDWZjVVnyEhGtjmPx40/IxSsyXUkYLBGzD2n50rwqAC0ea9vFi0D7GkK2BwbJ8uY6lR8dhmUn97WtWNc7Pb1kWVAQ+hShyhzic/S5u4GtMR/oSk+VXaU6biN9rFe+p2zdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rc2Df-0003Mq-TF; Mon, 19 Feb 2024 12:53:59 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rc2Df-001djE-1t; Mon, 19 Feb 2024 12:53:59 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rc2De-00Fr1u-37;
	Mon, 19 Feb 2024 12:53:58 +0100
Date: Mon, 19 Feb 2024 12:53:58 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Michael Walle <michael@walle.cc>, srinivas.kandagatla@linaro.org,
	gregkh@linuxfoundation.org, rafal@milecki.pl,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH] nvmem: core: add sysfs cell write support
Message-ID: <20240219115358.xui5fpoisvsubdyb@pengutronix.de>
References: <20240215211401.1201004-1-m.felsch@pengutronix.de>
 <CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
 <20240216100750.zxl4wncbgpulr2cc@pengutronix.de>
 <20240219120414.32395299@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219120414.32395299@xps-13>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-02-19, Miquel Raynal wrote:
> Hi Marco,
> 
> m.felsch@pengutronix.de wrote on Fri, 16 Feb 2024 11:07:50 +0100:
> 
> > Hi Michael,
> > 
> > On 24-02-16, Michael Walle wrote:
> > > Hi,
> > > 
> > > On Thu Feb 15, 2024 at 10:14 PM CET, Marco Felsch wrote:  
> > > > @@ -432,6 +466,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> > > >  	struct bin_attribute **cells_attrs, *attrs;
> > > >  	struct nvmem_cell_entry *entry;
> > > >  	unsigned int ncells = 0, i = 0;
> > > > +	umode_t mode;
> > > >  	int ret = 0;
> > > >  
> > > >  	mutex_lock(&nvmem_mutex);
> > > > @@ -456,15 +491,18 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> > > >  		goto unlock_mutex;
> > > >  	}
> > > >  
> > > > +	mode = nvmem_bin_attr_get_umode(nvmem);
> > > > +
> > > >  	/* Initialize each attribute to take the name and size of the cell */
> > > >  	list_for_each_entry(entry, &nvmem->cells, node) {
> > > >  		sysfs_bin_attr_init(&attrs[i]);
> > > >  		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> > > >  						    "%s@%x", entry->name,
> > > >  						    entry->offset);
> > > > -		attrs[i].attr.mode = 0444;  
> > > 
> > > cells are not writable if there is a read post process hook, see
> > > __nvmem_cell_entry_write().
> > > 
> > > if (entry->read_post_processing)
> > > 	mode &= ~0222;  
> > 
> > good point, thanks for the hint :) I will add this and send a non-rfc
> > version if write-support is something you would like to have.
> 
> I like the idea but, what about mtd devices (and soon maybe UBI
> devices)? This may only work on EEPROM-like devices I guess, where each
> area is fully independent and where no erasure is actually expected.

For MTD I would say that you need to ensure that you need to align the
cells correctly. The cell-write should handle the page erase/write cycle
properly. E.g. an SPI-NOR need to align the cells to erase-page size or
the nvmem-cell-write need to read-copy-update the cells if they are not
erase-paged aligned.

Regarding UBI(FS) I'm not sure if this is required at all since you have
an filesystem. IMHO nvmem-cells are very lowelevel and are not made for
filesystem backed backends.

That beeing said: I have no problem if we provide write support for
EEPROMs only and adapt it later on to cover spi-nor/nand devices as
well.

Regards,
  Marco

