Return-Path: <linux-kernel+bounces-143102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95A8A343B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A58B2377A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3C14BFB1;
	Fri, 12 Apr 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRoly1ee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669114AD17;
	Fri, 12 Apr 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941204; cv=none; b=QrvJgfxi37HncRn5stDtg479FeXqPMn4NJuLFHzRAcMIcuia5oMkRe6Mkc2q3E0yxDeLbtWLAHLrCg/fE+t4U89sxdXglqXXAnTHrmSFdDwm3osYeesVlCYEKagadoFPptMUv+jSN+G9tKBDpXQiyCXUwky619hgEH7bRcIrpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941204; c=relaxed/simple;
	bh=3o4Nur+Oy0mXVKs/XCzCfneK0CpDqwE6gW4kzxFBzHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvA+qxl5T8b2G+P4ounmFXrGS6w1eUCxzKBiQ07fvzlmlOfpikLtYiUCXEiBrMNXRxDr8VHQ7eCwInIvsfsumAsIxn51gSnYI/aCY87w866X7p/RlhcJvl8z0cZkB5n06Fpq6RbDU0dcuVhhUctUibyuoWxc/U3qc7UAr7eHYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRoly1ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31EAC113CC;
	Fri, 12 Apr 2024 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712941204;
	bh=3o4Nur+Oy0mXVKs/XCzCfneK0CpDqwE6gW4kzxFBzHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRoly1ee90Qf+4CH6DsqKoQlH/hvkyn1K9kQonE7Tf/K0yDQjvhfdFTibBVGwiTeb
	 xniWLGH1HYuOL7dnc//GW0VK9PukDJctFS3nU4ra6QjrXy33WYxcZSeHxhFkd3ER2F
	 yLyFjqMNAFOlE7uwfpnoNpTfFc8LKkl+WAE9TuqObjCg5J3qsJ+uyKzfkRPKUGVr79
	 SkhCtnfoo/o8PdfFqzG+/iZ23psTEvybWNByIhodQAONaFez27jEcatrXPiuUs/QhF
	 TEfVVbtjIzrO2S61py6fam9APgk6g2v8mZh0tNFOgaBd7S5TQ0eyqGotv4gIN3+VeK
	 IDOig6gBXrTmw==
Date: Fri, 12 Apr 2024 18:59:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Gustav Ekelund <gustav.ekelund@axis.com>
Cc: dlemoal@kernel.org, hare@suse.de, martin.petersen@oracle.com,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH] ata: Add sdev attribute to lower link speed in runtime
Message-ID: <Zhloj7t-jn-DU3ve@ryzen>
References: <20240412134838.788502-1-gustav.ekelund@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412134838.788502-1-gustav.ekelund@axis.com>

Hello Gustav,

On Fri, Apr 12, 2024 at 03:48:38PM +0200, Gustav Ekelund wrote:
> Expose a new sysfs attribute to userspace that gives root the ability to
> lower the link speed in a scsi_device at runtime. The handle enables
> programs to, based on external circumstances that may be unbeknownst to
> the kernel, determine if a link should slow down to perhaps achieve a
> stabler signal. External circumstances could include the mission time
> of the connected hardware or observations to temperature trends.
> 
> Writing 1 to /sys/block/*/device/down_link_spd signals the kernel to
> first lower the link speed one step with sata_down_spd_limit and then
> finish off with sata_link_hardreset.
> 
> Signed-off-by: Gustav Ekelund <gustav.ekelund@axis.com>
> ---
>  Documentation/ABI/testing/sysfs-block-device | 13 +++++++++
>  drivers/ata/libahci.c                        |  1 +
>  drivers/ata/libata-sata.c                    | 29 ++++++++++++++++++++
>  include/linux/libata.h                       |  1 +
>  4 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
> index 2d543cfa4079..dba537fdf787 100644
> --- a/Documentation/ABI/testing/sysfs-block-device
> +++ b/Documentation/ABI/testing/sysfs-block-device
> @@ -117,3 +117,16 @@ Description:
>  		Writing "1" to this file enables the use of command duration
>  		limits for read and write commands in the kernel and turns on
>  		the feature on the device. Writing "0" disables the feature.
> +
> +
> +What:		/sys/block/*/device/down_link_spd
> +Date:		Mar, 2024
> +KernelVersion:	v6.10
> +Contact:	linux-ide@vger.kernel.org
> +Description:
> +		(WO) Write 1 to the file to lower the SATA link speed one step
> +		and then hard reset. Other values are rejected with -EINVAL.
> +
> +		Consider using libata.force for setting the link speed at boot.
> +		Resort to down_link_spd in systems that deem it useful to lower
> +		the link speed at runtime for particular links.
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1a63200ea437..2622e965d98c 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -138,6 +138,7 @@ static struct attribute *ahci_sdev_attrs[] = {
>  	&dev_attr_unload_heads.attr,
>  	&dev_attr_ncq_prio_supported.attr,
>  	&dev_attr_ncq_prio_enable.attr,
> +	&dev_attr_down_link_spd.attr,
>  	NULL
>  };
>  
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 0fb1934875f2..5e1257b15f95 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1538,3 +1538,32 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
>  	ehc->i.err_mask &= ~AC_ERR_DEV;
>  }
>  EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
> +
> +static ssize_t down_link_spd_store(struct device *device,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct scsi_device *sdev;

In general, please compare your code with ata_ncq_prio_enable_store().

Please assign sdev directly:
struct scsi_device *sdev = to_scsi_device(device);


> +	struct ata_port *ap;
> +	long input;
> +	int rc;
> +
> +	rc = kstrtol(buf, 10, &input);
> +	if (rc)
> +		return rc;
> +	if ((input < 0) || (input > 1))
> +		return -EINVAL;
> +
> +	sdev = to_scsi_device(device);
> +	ap = ata_shost_to_port(sdev->host);

Please also check ata_scsi_find_dev() like ata_ncq_prio_enable_store() does.


> +
> +	rc = sata_down_spd_limit(&ap->link, 0);

Damien,
the kdoc for sata_down_spd_limit() is just
"LOCKING: Inherited from caller"
Do we perhaps need to hold the ap->lock here?


> +	if (rc)
> +		return rc;
> +	rc = sata_link_hardreset(&ap->link, sata_deb_timing_normal,
> +		ata_deadline(jiffies, ATA_TMOUT_INTERNAL_QUICK), NULL, NULL);

You shouldn't call sata_link_hardreset() directly.

Instead you should do:

	spin_lock_irqsave(ap->lock, flags);

	ehi->action |= ATA_EH_RESET;
	ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;

	ata_port_schedule_eh(ap);

	spin_unlock_irqrestore(ap->lock, flags);

See:
https://github.com/torvalds/linux/blob/v6.9-rc3/drivers/ata/libata-core.c#L5873-L5883
and
https://github.com/torvalds/linux/blob/v6.9-rc3/drivers/ata/libata-core.c#L5265-L5267

> +
> +	return rc ? rc : len;

Wouldn't it be more helpful if you could set a target speed instead?
How else are you supposed to be able to go back to the faster speed.

Perhaps you could look how libata.force forces a speed, and reuse
that struct member, or possibly add a new struct member if needed,
to store the forced target speed.


And possible a _show() to read the current target speed.
Writing "0" to target speed could possibly clear the forced speed.


> +}
> +DEVICE_ATTR_WO(down_link_spd);
> +EXPORT_SYMBOL_GPL(dev_attr_down_link_spd);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 26d68115afb8..51d23a60355b 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -510,6 +510,7 @@ extern struct device_attribute dev_attr_ncq_prio_enable;
>  extern struct device_attribute dev_attr_em_message_type;
>  extern struct device_attribute dev_attr_em_message;
>  extern struct device_attribute dev_attr_sw_activity;
> +extern struct device_attribute dev_attr_down_link_spd;
>  #endif
>  
>  enum sw_activity {
> -- 
> 2.39.2
> 

