Return-Path: <linux-kernel+bounces-93133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD1872B72
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A28D1C217DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314AB12E55;
	Wed,  6 Mar 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biM6eTtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC0F9C3;
	Wed,  6 Mar 2024 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683305; cv=none; b=nB5HEgk2KsLKIwfn1rlwPaw9TP5pvLb2PUfNdYFaHsEMXJlOXVMQldIMBRWbJ07cCTlGAw9Tf1hAnMzZoHji5zvEbgR/byra5qCy714I7dMtNYq3bzQ16b8IbRzKUXOKqh22UrJOZ7Y3dSZYgoD4kKrW9PrI1+WeJv55EoEd2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683305; c=relaxed/simple;
	bh=WYBjKej7NZSY4d7Ug+nci7vzA3FkIwnYIKYcwGC3vAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqcR6CdT3uAbmLPHxdHC8qSeVrEq9dQtzv+ddnIVivzh92snujy75f20m5RbURpvD4wfcgL+tD24x6ZJndoXeECa5QY2/CxGIFvbXMka9sjFmnwlQruTz028o9mhYZOGAQeW4OY17zvvvz9Te0secjt8iTkdLCAXrhhlssqM4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biM6eTtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6341C433C7;
	Wed,  6 Mar 2024 00:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709683304;
	bh=WYBjKej7NZSY4d7Ug+nci7vzA3FkIwnYIKYcwGC3vAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=biM6eTtEeCmerE1srVIhNPcKV3NAGA0HmOVWqhxCYxLnKUwKEF91t/qLZ4Xb0JEpA
	 nSRxoxWZaOph6fZIjKDU1+hVEqg24tbEwx59pCpAxgjilFhPI89wlJZAdX3uE0Rydy
	 xOzrTtib8i5fQw1nIf+PIkmJiNYuYdz64E4BZWtpQqTglI02mKxMmaGZQQTgoJCLOB
	 aGqFR4qUcEqIZOdFZugHmer2ab+JnW9m9OhFrFAm6YFDzObE6nbZo3Bp2YCXB3lAV/
	 aWPNcqswb1WdDjqX+X4hlpr6dV2adNA75HRIZNlZoIV8VqyMCasQnN5ItDOq6/6EPC
	 5mdlb8224JO9w==
Message-ID: <b7ca1a8f-c723-494c-b9f8-af9e75ac0afe@kernel.org>
Date: Wed, 6 Mar 2024 09:01:41 +0900
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
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305235823.3308225-1-ipylypiv@google.com>
 <20240305235823.3308225-3-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240305235823.3308225-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/24 08:58, Igor Pylypiv wrote:
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
>  drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
>  include/scsi/sas_ata.h        |  6 +++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 12e2653846e3..04b0bd9a4e01 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
>  			       force_phy_id, &tmf_task);
>  }
>  EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
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
>  int sas_discover_sata(struct domain_device *dev);
>  int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
>  		    struct domain_device *child, int phy_id);
> +
> +extern const struct attribute_group sas_ata_sdev_attr_group;
>  #else
>  
>  static inline void sas_ata_disabled_notice(void)
> @@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
>  	sas_ata_disabled_notice();
>  	return -ENODEV;
>  }
> +
> +static const struct attribute_group sas_ata_sdev_attr_group __maybe_unused = {
> +	.attrs = NULL,
> +};

Looks OK, but I must say that I would prefer John's idea with the #define as
that removes the variable definition entirely.

>  #endif
>  
>  #endif /* _SAS_ATA_H_ */

-- 
Damien Le Moal
Western Digital Research


