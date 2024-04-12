Return-Path: <linux-kernel+bounces-142428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C508A2B71
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8BC1C20A80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6505951C4D;
	Fri, 12 Apr 2024 09:43:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123851C49
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915007; cv=none; b=m6O5vx5OcVRra3IbHbYaDBIIu2rUsOlm2kbxgdOrorTMPF6v9Aa0CcpIbiR5ax71ddHX5x1toDMgYxJKuJiji3UENTcSoJTiNdSlFpvCZ0MpXN9ptZYQ/jhiCARPLgtiCEyq4Ywk3iXFkFD1jGM496DWM4zQpC4I+tqlk5/nIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915007; c=relaxed/simple;
	bh=MkPtNSTQz1GZRFY64AYvZ5ILYqR2bj1RgrUxdgBPvXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeCzeUb43STpEAQYO0eNpC6RPrF/BpnuxQo4u8e31bP4ujpOX2VCo1g/r6NqwOs5DItjftczJUck0SwOHxJxaO0D1loaLaUMcKz09joCGkNr/y5ct6jEXJoEOTnUDfJ5sw+tcZQ3JcrhjfOVfZq94ddjH3O/LfndQRbTOtBOgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rvDRI-0001P6-9d; Fri, 12 Apr 2024 11:43:20 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rvDRH-00BqqM-BB; Fri, 12 Apr 2024 11:43:19 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rvDRH-009Jhp-0p;
	Fri, 12 Apr 2024 11:43:19 +0200
Date: Fri, 12 Apr 2024 11:43:19 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: srinivas.kandagatla@linaro.org, miquel.raynal@bootlin.com,
	michael@walle.cc
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] nvmem: core: add sysfs cell write support
Message-ID: <20240412094319.ua3galjwe6bwnavf@pengutronix.de>
References: <20240223154129.1902905-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223154129.1902905-1-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

gentle ping.

Regards,
  Marco

On 24-02-23, Marco Felsch wrote:
> Add the sysfs cell write support to make it possible to write to exposed
> cells from sysfs as well e.g. for device provisioning. The write support
> is limited to EEPROM based nvmem devices and to nvmem-cells which don't
> require post-processing.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/nvmem/core.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 980123fb4dde..b1f86cb431ef 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -336,6 +336,40 @@ static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
>  	return read_len;
>  }
>  
> +static ssize_t nvmem_cell_attr_write(struct file *filp, struct kobject *kobj,
> +				     struct bin_attribute *attr, char *buf,
> +				     loff_t pos, size_t count)
> +{
> +	struct nvmem_cell_entry *entry;
> +	struct nvmem_cell *cell;
> +	int ret;
> +
> +	entry = attr->private;
> +
> +	if (!entry->nvmem->reg_write)
> +		return -EPERM;
> +
> +	if (pos >= entry->bytes)
> +		return -EFBIG;
> +
> +	if (pos + count > entry->bytes)
> +		count = entry->bytes - pos;
> +
> +	cell = nvmem_create_cell(entry, entry->name, 0);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	if (!cell)
> +		return -EINVAL;
> +
> +	ret = nvmem_cell_write(cell, buf, count);
> +
> +	kfree_const(cell->id);
> +	kfree(cell);
> +
> +	return ret;
> +}
> +
>  /* default read/write permissions */
>  static struct bin_attribute bin_attr_rw_nvmem = {
>  	.attr	= {
> @@ -458,13 +492,20 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
>  
>  	/* Initialize each attribute to take the name and size of the cell */
>  	list_for_each_entry(entry, &nvmem->cells, node) {
> +		umode_t mode = nvmem_bin_attr_get_umode(nvmem);
> +
> +		/* Limit cell-write support to EEPROMs at the moment */
> +		if (entry->read_post_process || nvmem->type != NVMEM_TYPE_EEPROM)
> +			mode &= ~0222;
> +
>  		sysfs_bin_attr_init(&attrs[i]);
>  		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
>  						    "%s@%x", entry->name,
>  						    entry->offset);
> -		attrs[i].attr.mode = 0444;
> +		attrs[i].attr.mode = mode;
>  		attrs[i].size = entry->bytes;
>  		attrs[i].read = &nvmem_cell_attr_read;
> +		attrs[i].write = &nvmem_cell_attr_write;
>  		attrs[i].private = entry;
>  		if (!attrs[i].attr.name) {
>  			ret = -ENOMEM;
> -- 
> 2.39.2
> 
> 
> 

