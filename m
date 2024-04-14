Return-Path: <linux-kernel+bounces-144082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9378A4197
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6991F2164D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3A23763;
	Sun, 14 Apr 2024 09:48:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348F1C2AF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713088123; cv=none; b=CzNwugJIZfSBK9me60W4MTDY8Y+mKqK8aHUunEhyahGNpaTIZkS5rqaQz80NRGDGiR9a3b8k8qwA+rSscz2eVrOhDOUz3XhJuOUivPA6nEPOSS7JyV0jHF1ipQxsQfBHsXOZHyZJBJdTeWkPAZC69IFy6mQcL64Y5xmybI995Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713088123; c=relaxed/simple;
	bh=7Bp7WR/OmDqOUD3FxH4EWpUeRzpXGskbstL5e7ftf+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDv5GKOGs7aIxg9JhOdEjxZNEyf5nIJ6EUCSFH7ZGyDKgG5zI9uCkNXzRxskmDSD7yzVLIJdQ/nvbaSQXb2ANkuslnIJxwhO0iMzqVSSoJBTw6m7EvFJGJkERePAerZEN3HY+FVhjG36EnupGAhT9wZF6BwFWMfLoNWJ8UeyaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rvwTP-0000rN-2t; Sun, 14 Apr 2024 11:48:31 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rvwTO-00CDev-Am; Sun, 14 Apr 2024 11:48:30 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rvwTO-00CWeq-0i;
	Sun, 14 Apr 2024 11:48:30 +0200
Date: Sun, 14 Apr 2024 11:48:30 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: miquel.raynal@bootlin.com, michael@walle.cc,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: add sysfs cell write support
Message-ID: <20240414094830.jxpqn33ew2us37t7@pengutronix.de>
References: <20240223154129.1902905-1-m.felsch@pengutronix.de>
 <406eb283-6ac0-4917-9dbf-e45d033bf3de@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406eb283-6ac0-4917-9dbf-e45d033bf3de@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Srinivas,

+Cc Rob, Krzysztof, Conor for below OF question.

On 24-04-13, Srinivas Kandagatla wrote:
> Thanks Marco  for the work,
> 
> On 23/02/2024 15:41, Marco Felsch wrote:
> > Add the sysfs cell write support to make it possible to write to exposed
> > cells from sysfs as well e.g. for device provisioning. The write support
> 
> Which device are you testing this on?

An EEPROM device.

> AFAIU, Normally all the device provisioning happens early stages at
> production line, not after OS is up and running. I might be wrong.
> 
> Can you provide more details on what type of device provisioning that you
> are referring to.

We do have production data and you're right about this. But we have also
cells which cover sw-feature switches and with the write support they
can be accessed easily from user-space.

> Write support should not be enabled by default, this has to be an explicit
> Kconfig with a big WARNING that it could potentially corrupt the nvmem by
> rouge writes.

I'm okay with a Kconfig but I'm not okay with the warning. If an user do
enable this feature on purpose we shouldn't print a warning. We do limit
the write support to EEPROM devices only and to cells which do not have
a special post processing. IMHO this is the simplest use-case and
corruption shouldn't occure. Of course there can be supply
interrruptions but in this case other storage devices can be corrupted
as well.

> I would also like this to be an optional feature from providers side too, as
> not all nvmem providers want to have device provisioning support from Linux
> side.

You say instead of checking for NVMEM_TYPE_EEPROM, the nvmem-config
should have an option which to tell the core that write-support should
be exposed? I can do this but still it would expose the write support
for all at24 users. We could have an optional of-property but OF purpose
is to abstract hw and this clearly is not a hw-feature. What I can
imagine is an nvmem_core module param and the default is set via the
Kconfig option. Of course this way still all EEPROMs are either exposed
as ro/rw but it's the user/distro choice. So in the end an OF
abstraction would give us a more fine grained possibility to influence
the behavior.

@Rob, Krzysztof, Conor
Would it be okay to abstract this via an OF property?

> > is limited to EEPROM based nvmem devices and to nvmem-cells which don't
> > require post-processing.
> 
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >   drivers/nvmem/core.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 42 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 980123fb4dde..b1f86cb431ef 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -336,6 +336,40 @@ static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
> >   	return read_len;
> >   }
> > +static ssize_t nvmem_cell_attr_write(struct file *filp, struct kobject *kobj,
> > +				     struct bin_attribute *attr, char *buf,
> > +				     loff_t pos, size_t count)
> > +{
> > +	struct nvmem_cell_entry *entry;
> > +	struct nvmem_cell *cell;
> > +	int ret;
> > +
> > +	entry = attr->private;
> > +
> > +	if (!entry->nvmem->reg_write)
> 
> nvmem->read_only ?

In addition or as replacement?

> > +		return -EPERM;
> > +
> > +	if (pos >= entry->bytes)
> > +		return -EFBIG;
> > +
> > +	if (pos + count > entry->bytes)
> > +		count = entry->bytes - pos;
> > +
> > +	cell = nvmem_create_cell(entry, entry->name, 0);
> > +	if (IS_ERR(cell))
> > +		return PTR_ERR(cell);
> > +
> > +	if (!cell)
> > +		return -EINVAL;
> > +
> > +	ret = nvmem_cell_write(cell, buf, count);
> > +
> > +	kfree_const(cell->id);
> > +	kfree(cell);
> > +
> > +	return ret;
> > +}
> > +
> >   /* default read/write permissions */
> >   static struct bin_attribute bin_attr_rw_nvmem = {
> >   	.attr	= {
> > @@ -458,13 +492,20 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> >   	/* Initialize each attribute to take the name and size of the cell */
> >   	list_for_each_entry(entry, &nvmem->cells, node) {
> > +		umode_t mode = nvmem_bin_attr_get_umode(nvmem);
> > +
> > +		/* Limit cell-write support to EEPROMs at the moment */
> > +		if (entry->read_post_process || nvmem->type != NVMEM_TYPE_EEPROM)
> > +			mode &= ~0222;
> > +
> >   		sysfs_bin_attr_init(&attrs[i]);
> >   		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> >   						    "%s@%x", entry->name,
> >   						    entry->offset);
> > -		attrs[i].attr.mode = 0444;
> > +		attrs[i].attr.mode = mode;
> >   		attrs[i].size = entry->bytes;
> >   		attrs[i].read = &nvmem_cell_attr_read;
> can we not make this conditional based on read_only flag?

We do use nvmem_bin_attr_get_umode() to query the mode which covers the
read_only, but of course I can add it conditional.

Regards,
  Marco

> > +		attrs[i].write = &nvmem_cell_attr_write;
> >   		attrs[i].private = entry;
> >   		if (!attrs[i].attr.name) {
> >   			ret = -ENOMEM;
> 
> thanks,
> Srini
> 

