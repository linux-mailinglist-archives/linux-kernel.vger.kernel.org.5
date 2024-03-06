Return-Path: <linux-kernel+bounces-93406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667E6872F50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E976C287FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264A5C5F9;
	Wed,  6 Mar 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eFqlF7SY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="28spvLDT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LKUwrPPn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="twKdFAQo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE01427E;
	Wed,  6 Mar 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709252; cv=none; b=gqh3vhi3zlNXniZLSckq9OuEsUTQ3FHUzrbEeXCgXeNdMP6GQ4aCAvfEKHcs+/resYITISwHYIkJXxPcL263eL8G+MFnve8831hoTrvoERhZlDjSYYE7QpdTgJPq8hwFOeo8bQ38N6APXL1nO/cWixgOnFOl+/sE/PL4IEWZc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709252; c=relaxed/simple;
	bh=TRzvoJhUB5lFksiERRyjBbOWUn5zGGUZW6M+gsKhq8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdVCvk6N2zxhoIXJtKUasM81WOU39zsBfcFX9SHbD419x9Pma3FTGXlhb134saygLkVGSCeSnbPKmeZU2kHNOWqs4CBIdPsFLoVhkxc1xjzuP/4zL+PSeJpRF4NTKLOVWF3Jjv/x+Me7wppXQRKVl+9m3X03+wvyuhIy0gaKEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eFqlF7SY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=28spvLDT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LKUwrPPn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=twKdFAQo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A64366FB6;
	Wed,  6 Mar 2024 07:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+lCFStqJhRgrujaxA2G7OrESQahwJduS9yoJsutlHU=;
	b=eFqlF7SYyemx9Bui/sr3aTwjd7IoB4AlWAr3Cpc3rMPi8YfM43Q73CY5Zo51Tiwo2tEfpy
	+Gk5rmvKzPgS4UEuqHMuUe8UskO1wMdHATDymTn9Bxfk7TtP49f4mQ+H6bR5bVq2ROWwB3
	Fh6VdGIKYTMkEWTS1zQLrdWz0+dg9C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+lCFStqJhRgrujaxA2G7OrESQahwJduS9yoJsutlHU=;
	b=28spvLDTn06AJOQcFFTzuqhho9GZwOTxEs/AtkwEustz0eK2loFU049cFOvT251TPB87K4
	GXU/xKjq22VeH7CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+lCFStqJhRgrujaxA2G7OrESQahwJduS9yoJsutlHU=;
	b=LKUwrPPnWVkqC5pQlk/e9rRDkdwThkEUEj6vqAe7qCHzSMkJCffovdnMqRxcSPGs4zUcPb
	HycGqjCXc2A54ufvAayDC8uBdoqWwP1f+ciuG8hPwLbaJdUzSyyGdw/ZMhm6M3EuFhCGb8
	KRMvPoWy5Xe6sciy2udt0r/oo8BudZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+lCFStqJhRgrujaxA2G7OrESQahwJduS9yoJsutlHU=;
	b=twKdFAQowdFoIiiNVtPwq6ry3GpPEuN7EWwHkqNB2QVshgtIxzzq5vl21TdF8Lh8nTteyv
	bW9RDPhylqm+kdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7BCF13A9C;
	Wed,  6 Mar 2024 07:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q3y5Nr0X6GWbVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Mar 2024 07:14:05 +0000
Message-ID: <e58e0273-c0f0-4249-b4d0-d16d274311a1@suse.de>
Date: Wed, 6 Mar 2024 08:14:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305235823.3308225-1-ipylypiv@google.com>
 <20240305235823.3308225-3-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240305235823.3308225-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.985];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On 3/6/24 00:58, Igor Pylypiv wrote:
> Libata sysfs attributes cannot be used for libsas managed SATA devices
> because the ata_port location is different for libsas.
> 
> Defined sysfs attributes (visible for SATA devices only):
> - /sys/block/sda/device/ncq_prio_enable
> - /sys/block/sda/device/ncq_prio_supported
> 
> The newly defined attributes will pass the correct ata_port to libata
> helper functions.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
>   include/scsi/sas_ata.h        |  6 +++
>   2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 12e2653846e3..04b0bd9a4e01 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
>   			       force_phy_id, &tmf_task);
>   }
>   EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
> +
> +static ssize_t sas_ncq_prio_supported_show(struct device *device,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	bool supported;
> +	int rc;
> +
> +	/* This attribute shall be visible for SATA devices only */
> +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> +		return -EINVAL;
> +
You don't need the WARN_ON here; the 'is_visible' function will take
care of it.

> +	rc = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev, &supported);
> +	if (rc)
> +		return rc;
> +
> +	return sysfs_emit(buf, "%d\n", supported);
> +}
> +
> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
> +
> +static ssize_t sas_ncq_prio_enable_show(struct device *device,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	bool enabled;
> +	int rc;
> +
> +	/* This attribute shall be visible for SATA devices only */
> +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> +		return -EINVAL;
> +

Same here.

> +	rc = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev, &enabled);
> +	if (rc)
> +		return rc;
> +
> +	return sysfs_emit(buf, "%d\n", enabled);
> +}
> +
> +static ssize_t sas_ncq_prio_enable_store(struct device *device,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +	bool enable;
> +	int rc;
> +
> +	/* This attribute shall be visible for SATA devices only */
> +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> +		return -EINVAL;
> +

And here.

> +	rc = kstrtobool(buf, &enable);
> +	if (rc)
> +		return rc;
> +
> +	rc = ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, enable);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +
> +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> +	    sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
> +
> +static struct attribute *sas_ata_sdev_attrs[] = {
> +	&dev_attr_ncq_prio_supported.attr,
> +	&dev_attr_ncq_prio_enable.attr,
> +	NULL
> +};
> +
> +static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
> +				       struct attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> +
> +	if (!dev_is_sata(ddev))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +const struct attribute_group sas_ata_sdev_attr_group = {
> +	.attrs = sas_ata_sdev_attrs,
> +	.is_visible = sas_ata_attr_is_visible,
> +};
> +EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
> diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
> index 2f8c719840a6..59a75cd8b5e0 100644
> --- a/include/scsi/sas_ata.h
> +++ b/include/scsi/sas_ata.h
> @@ -39,6 +39,8 @@ int smp_ata_check_ready_type(struct ata_link *link);
>   int sas_discover_sata(struct domain_device *dev);
>   int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
>   		    struct domain_device *child, int phy_id);
> +
> +extern const struct attribute_group sas_ata_sdev_attr_group;
>   #else
>   
>   static inline void sas_ata_disabled_notice(void)
> @@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
>   	sas_ata_disabled_notice();
>   	return -ENODEV;
>   }
> +
> +static const struct attribute_group sas_ata_sdev_attr_group __maybe_unused = {
> +	.attrs = NULL,
> +};
>   #endif
>   
>   #endif /* _SAS_ATA_H_ */

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


