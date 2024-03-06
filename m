Return-Path: <linux-kernel+bounces-93162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C8872BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0061F2641E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE6CA4E;
	Wed,  6 Mar 2024 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AicuF8hb"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F363CF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684636; cv=none; b=I4vHFjwRWyBXVndl95zVZymgf4vVG8gJ0ovU8Jco6Coft+BnQuVuiII2rWKRwOq8UiUZLnDdIXvtuB8zMPJoGpe76Gbqj4RW2TtLB0ulUUMkjOLd4CTqyiU4HiVgHt+ooQ1q6MdkGFj668TJS4Qs25+j5Bv/YHprTeRbqButo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684636; c=relaxed/simple;
	bh=WDgpn/virs3bKDEmQkt10wah+il1eObN0f7FxdVMd1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVQbtA72vF6yUY3n8RHuNLUtrjH2TROa0DTtMGqj0lvm6kPM5hilkPl3hYrVAT6NVh9Igql9uXpllP4sVcEbdWUOWyXU/h8mcleRajTciib5fYQE0IgkY4ERz5kEM21IL7/FydDRCtOpOtxsU+j/3f0LiALVTeqvrKPh/l0Raz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AicuF8hb; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21fdf31a154so3333566fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709684634; x=1710289434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEni3WKwgcjhTzuFT655lKnmtQMeXc/h9q49LRG3I5M=;
        b=AicuF8hbGDrA3nsT+OBTxjzajWuJeM9kWSki7+I/huQjVNtZIkwoUHy7dg6f8wihZp
         3HB2I2Q/Sr0h9w7Yz7viiz2Mzpy0RF0Bp49K+gIa1XQlsXTOChmffAqr5UI/RtM0nngO
         dnBBS4GddQGm+FGLrgwa81R01VG41InuI9qrOtRIHnxDnnpx6eVZSBTfneA4/RqaprHZ
         wBuJTTcpBqoLvHhcfbuHX+ZIs5DfwA8eTTMsltG4wGQU/UuxKOAys5zSJhnMDdbVZAP8
         s7cqUVRY8KMpKE5NBDGFHZ27fg+/7V3jaAcTtP3dEY7g1k3goACvGe1EJUAyjWLZ+TAE
         X8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709684634; x=1710289434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEni3WKwgcjhTzuFT655lKnmtQMeXc/h9q49LRG3I5M=;
        b=jxJoBOunTqBat15CjEfofrCT7zru7ecqdsZ4HdFqapQcpTMgV/xjbSqndJVRfw9ZkL
         JOTSUItkOHgDgKHG8XEwmqcqksDIbxZRGgZvw9rxOd8BrHoe8wWLLC+j1iXJOCTcjv8d
         TIcRNx0gYOAiUk/9cdjQHAbEuy0dUh8CBDhkHGfZuAKYVyL4huZUd3QixvQcRy9BqHpl
         8ptNgqN8TKJ9Qp+5WZ6euOEHnA3QbAzGfkLmNhVV8pnTlTVT01CAugFPN9oFdmueP+dy
         5cpNgl9cG1Eu7Q+9mWbOKzsRGyex3UXjbeMZ8thrG3YwUXxmc0om3PBTJLCUITtJ1Sbi
         J0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQWrf/m7EzjCrYtiHQCYzBEnLdL2nZsYlFnxvgvAb8DSNyoC4ffxk+NoGzDQwLUoraRkhpY9Pftk4IQTArl1CQtCcL1N0gF3dQqSra
X-Gm-Message-State: AOJu0YwvIqx8NubEoQHbuMnW4KCDKDnm/WdKzBVK5FbJpfKNV7tjr7rY
	LGIjUvPKvuqzqCSFRrFElMLVw6in4Mwrxk7BRgGW2Yj8iFNMb8l5ZVR+ZjvyKA==
X-Google-Smtp-Source: AGHT+IHOnEaiRGtZIR66OUDZh/+Zxx3Duj6Y+QUBK5T5xG712IjIS03Pj+R0xhOtzreukzXrwTEdTQ==
X-Received: by 2002:a05:6870:6788:b0:21e:b778:dc5c with SMTP id gc8-20020a056870678800b0021eb778dc5cmr3695101oab.44.1709684634003;
        Tue, 05 Mar 2024 16:23:54 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b006e5a6e83f8esm8643699pfh.134.2024.03.05.16.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:23:53 -0800 (PST)
Date: Tue, 5 Mar 2024 16:23:49 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] scsi: libsas: Define NCQ Priority sysfs
 attributes for SATA devices
Message-ID: <Zee3lQWln9tfrlC-@google.com>
References: <20240305235823.3308225-1-ipylypiv@google.com>
 <20240305235823.3308225-3-ipylypiv@google.com>
 <b7ca1a8f-c723-494c-b9f8-af9e75ac0afe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ca1a8f-c723-494c-b9f8-af9e75ac0afe@kernel.org>

On Wed, Mar 06, 2024 at 09:01:41AM +0900, Damien Le Moal wrote:
> On 3/6/24 08:58, Igor Pylypiv wrote:
> > Libata sysfs attributes cannot be used for libsas managed SATA devices
> > because the ata_port location is different for libsas.
> > 
> > Defined sysfs attributes (visible for SATA devices only):
> > - /sys/block/sda/device/ncq_prio_enable
> > - /sys/block/sda/device/ncq_prio_supported
> > 
> > The newly defined attributes will pass the correct ata_port to libata
> > helper functions.
> > 
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/scsi/libsas/sas_ata.c | 94 +++++++++++++++++++++++++++++++++++
> >  include/scsi/sas_ata.h        |  6 +++
> >  2 files changed, 100 insertions(+)
> > 
> > diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> > index 12e2653846e3..04b0bd9a4e01 100644
> > --- a/drivers/scsi/libsas/sas_ata.c
> > +++ b/drivers/scsi/libsas/sas_ata.c
> > @@ -964,3 +964,97 @@ int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
> >  			       force_phy_id, &tmf_task);
> >  }
> >  EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
> > +
> > +static ssize_t sas_ncq_prio_supported_show(struct device *device,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	struct scsi_device *sdev = to_scsi_device(device);
> > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > +	bool supported;
> > +	int rc;
> > +
> > +	/* This attribute shall be visible for SATA devices only */
> > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > +		return -EINVAL;
> > +
> > +	rc = ata_ncq_prio_supported(ddev->sata_dev.ap, sdev, &supported);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return sysfs_emit(buf, "%d\n", supported);
> > +}
> > +
> > +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, sas_ncq_prio_supported_show, NULL);
> > +
> > +static ssize_t sas_ncq_prio_enable_show(struct device *device,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> > +	struct scsi_device *sdev = to_scsi_device(device);
> > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > +	bool enabled;
> > +	int rc;
> > +
> > +	/* This attribute shall be visible for SATA devices only */
> > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > +		return -EINVAL;
> > +
> > +	rc = ata_ncq_prio_enabled(ddev->sata_dev.ap, sdev, &enabled);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return sysfs_emit(buf, "%d\n", enabled);
> > +}
> > +
> > +static ssize_t sas_ncq_prio_enable_store(struct device *device,
> > +					 struct device_attribute *attr,
> > +					 const char *buf, size_t len)
> > +{
> > +	struct scsi_device *sdev = to_scsi_device(device);
> > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > +	bool enable;
> > +	int rc;
> > +
> > +	/* This attribute shall be visible for SATA devices only */
> > +	if (WARN_ON_ONCE(!dev_is_sata(ddev)))
> > +		return -EINVAL;
> > +
> > +	rc = kstrtobool(buf, &enable);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = ata_ncq_prio_enable(ddev->sata_dev.ap, sdev, enable);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return len;
> > +}
> > +
> > +DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> > +	    sas_ncq_prio_enable_show, sas_ncq_prio_enable_store);
> > +
> > +static struct attribute *sas_ata_sdev_attrs[] = {
> > +	&dev_attr_ncq_prio_supported.attr,
> > +	&dev_attr_ncq_prio_enable.attr,
> > +	NULL
> > +};
> > +
> > +static umode_t sas_ata_attr_is_visible(struct kobject *kobj,
> > +				       struct attribute *attr, int i)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct scsi_device *sdev = to_scsi_device(dev);
> > +	struct domain_device *ddev = sdev_to_domain_dev(sdev);
> > +
> > +	if (!dev_is_sata(ddev))
> > +		return 0;
> > +
> > +	return attr->mode;
> > +}
> > +
> > +const struct attribute_group sas_ata_sdev_attr_group = {
> > +	.attrs = sas_ata_sdev_attrs,
> > +	.is_visible = sas_ata_attr_is_visible,
> > +};
> > +EXPORT_SYMBOL_GPL(sas_ata_sdev_attr_group);
> > diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
> > index 2f8c719840a6..59a75cd8b5e0 100644
> > --- a/include/scsi/sas_ata.h
> > +++ b/include/scsi/sas_ata.h
> > @@ -39,6 +39,8 @@ int smp_ata_check_ready_type(struct ata_link *link);
> >  int sas_discover_sata(struct domain_device *dev);
> >  int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *phy,
> >  		    struct domain_device *child, int phy_id);
> > +
> > +extern const struct attribute_group sas_ata_sdev_attr_group;
> >  #else
> >  
> >  static inline void sas_ata_disabled_notice(void)
> > @@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
> >  	sas_ata_disabled_notice();
> >  	return -ENODEV;
> >  }
> > +
> > +static const struct attribute_group sas_ata_sdev_attr_group __maybe_unused = {
> > +	.attrs = NULL,
> > +};
> 
> Looks OK, but I must say that I would prefer John's idea with the #define as
> that removes the variable definition entirely.

I'm fine with chaning the code to use #define.

My only concern is that C++ compilers complain about taking address of rvalue.
Looks like this is not an issue for C compilers.

I'll send v7 with the #define approach shortly.

> 
> >  #endif
> >  
> >  #endif /* _SAS_ATA_H_ */
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

