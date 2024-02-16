Return-Path: <linux-kernel+bounces-68414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6B8579ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE3C1C23806
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8B1CAA0;
	Fri, 16 Feb 2024 10:07:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57C1C68A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078078; cv=none; b=QjrJkUHgzmXYe+950sYHLIMFpNCnyMiG1yCOqFmT7PQ2ca/Qeg/l2a4H5he4asw6RFPjZIb0Nmh2eD7X22VE+1uLM38DFiiurpcbBORWwDapUQXVhRdvgQSB/QjJyBW/ZWNlag8ZITt8z5f7oeMlt9FcsP+TJngYKQPYyzyh1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078078; c=relaxed/simple;
	bh=AADG2HmlRGRjpuTwPgfETjqT/JQObbTt3Wb/LldVn9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuXWjhwEJqtBvTjnwZtHyfq40eHf+19DrYQn2g+gkloqHCb+M4mLzTMHFyDHe12q+92s5RQubrMFRq2E3PqqWBCaWvduD96149kek/gVMUKSP7UMu+COg+h28zr5FGkcSUR33qR3eyw+0tqRFnrIIrFmRe7QC6C4dRUHc2RnzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rav8J-0005ZL-6A; Fri, 16 Feb 2024 11:07:51 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rav8I-0013Uc-6S; Fri, 16 Feb 2024 11:07:50 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rav8I-00BSzb-0J;
	Fri, 16 Feb 2024 11:07:50 +0100
Date: Fri, 16 Feb 2024 11:07:50 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Michael Walle <michael@walle.cc>
Cc: srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
	miquel.raynal@bootlin.com, rafal@milecki.pl,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH] nvmem: core: add sysfs cell write support
Message-ID: <20240216100750.zxl4wncbgpulr2cc@pengutronix.de>
References: <20240215211401.1201004-1-m.felsch@pengutronix.de>
 <CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Michael,

On 24-02-16, Michael Walle wrote:
> Hi,
> 
> On Thu Feb 15, 2024 at 10:14 PM CET, Marco Felsch wrote:
> > @@ -432,6 +466,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> >  	struct bin_attribute **cells_attrs, *attrs;
> >  	struct nvmem_cell_entry *entry;
> >  	unsigned int ncells = 0, i = 0;
> > +	umode_t mode;
> >  	int ret = 0;
> >  
> >  	mutex_lock(&nvmem_mutex);
> > @@ -456,15 +491,18 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> >  		goto unlock_mutex;
> >  	}
> >  
> > +	mode = nvmem_bin_attr_get_umode(nvmem);
> > +
> >  	/* Initialize each attribute to take the name and size of the cell */
> >  	list_for_each_entry(entry, &nvmem->cells, node) {
> >  		sysfs_bin_attr_init(&attrs[i]);
> >  		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> >  						    "%s@%x", entry->name,
> >  						    entry->offset);
> > -		attrs[i].attr.mode = 0444;
> 
> cells are not writable if there is a read post process hook, see
> __nvmem_cell_entry_write().
> 
> if (entry->read_post_processing)
> 	mode &= ~0222;

good point, thanks for the hint :) I will add this and send a non-rfc
version if write-support is something you would like to have.

Regards,
  Marco

> 
> -michael



