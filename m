Return-Path: <linux-kernel+bounces-111832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24FD887166
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67B81C23202
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009B95D75F;
	Fri, 22 Mar 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c82fSPi+"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B665D720
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126772; cv=none; b=MCjo8VUNJ8w2jTQHSfjjm37ASCSS1xnKK28l8T6eOdvyO4A+LnXqc1iNgV/au9BKi/UckbZkChNVhhu2Ovvxb6tASqud2qRxdxDBLj/9ZhCFlfEh01zWVHvOTgbNVxWhh1r1ODnvJ20IYvTeZWPuxIDnqD2jSx31TWmWVO7bUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126772; c=relaxed/simple;
	bh=JRf6wUgjrXJBFiOWAu7JY98jun+mmnoci/D+Wpd82GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9ILtYvN1Bh/F+WRWq6Wywhkiei6X0kWE7lqigX/8tjRIarSykdugo5dv6PwuLBboyZQ1F4FUbgh+u8mC41INdr00mKvr5zbW2O9vahTmVezrvkfMvf8wTnBMJ27EjWJV1QFYEhO5prIdDVM7MAfBNUQ8iJHuJNIkv4dLz53LGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c82fSPi+; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7db123701bcso729376241.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711126769; x=1711731569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7Ol3p67jPcohmb6YwggOyywONRnit3CwsysWz7vFH8=;
        b=c82fSPi+Vw7qxKpxvCHRcpz7zUAMGLtsNh09k5ScpMlrjaVmYdKUWLTlqN1xjduvNP
         IRz8SV0oHzMO/xt/dvv+4e5rgX5OatjoMAOhPNcHQDY+2ho+3cv/7zHseZbmafH8UhBg
         jkBHq+FlGRIoTr1wh/p0USOIlmU4xNLTl++2S/ljZJRerkKzKXDkC6kc0fYKaWgz2Jv3
         lI3m92yBasuThAjj0E9iIl4DDlay0Ap+Gdn7bjPNDWR652OvOt4uzGbpWIjduZVm//a5
         6/XxNrddROAASMq9DCpNjNHR177viQiJo44I9lJURnQ0J6QvAKQFEt0+YGSelahsGOwy
         C7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126769; x=1711731569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7Ol3p67jPcohmb6YwggOyywONRnit3CwsysWz7vFH8=;
        b=dBdfrVRlSv78ElS8vUsE8HVVo60ng71zm/cNJxqSlDQMedoFDgTKapjC/+S4vEoDne
         NgWTkUvHuTzKO1D0zP2YQjGfi7I4WTEW9oodDrEuurO2THZyNXQ6S/OpnPU8NFVENpem
         fyZ+hUaQGvYtqv73w9RGJYsPU922WkpEtBIH4R1oLB38um6QqtlmK0wuh2J1RP3H983p
         SaMSe95fuBCODgQNyJhzH4/RU6rUL9M0FgoJRZIgdk3RAOLgizMKQXA6RvxM7IkuTnv9
         jyDe+0ZG1SKMT4xLCRA7zs10Dku+AIKQOt31tFsXPCi1FvhMV+nctCH/4GU7EeTOK2jY
         +1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEjrmEd+tApKJiHfL/h66etR9jUVQkQdiBCoJUp2glZ/NsilERbeXiDQtuo2+7NH7MgHudd8t49zvA2LEhyPBVYDUcQ0xYri9BnRyz
X-Gm-Message-State: AOJu0YzOVAmyXSyHDzSdXzMkZN9S+HeciIMV+LZiCURW7JscnAXu78XG
	8RCoVVH8Kx8iZXtw7FJwjrbXPTKGbIJzouBBHRvp/f40kQo9Ekxda6BMnfkzP/CqnOMNG7qDlmO
	M
X-Google-Smtp-Source: AGHT+IHAf5d0OiElf7D7znk8VZdW2wioTOERaPZGoG1/pAzXS9lgoTWLtbuNAygdNxnKoesueRU3Ew==
X-Received: by 2002:a05:6102:30a9:b0:476:c875:33b8 with SMTP id y9-20020a05610230a900b00476c87533b8mr156043vsd.3.1711126768661;
        Fri, 22 Mar 2024 09:59:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id wl3-20020a05620a57c300b00789e6cc73e6sm921167qkn.48.2024.03.22.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:59:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniEp-00CRKv-5I;
	Fri, 22 Mar 2024 13:59:27 -0300
Date: Fri, 22 Mar 2024 13:59:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iommu/sva: Use iopf domain attach/detach interface
Message-ID: <20240322165927.GG66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-3-baolu.lu@linux.intel.com>
 <20240308174605.GV9225@ziepe.ca>
 <b33bf29b-2fe5-4a2a-a2ce-9fd8d67c5f6f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b33bf29b-2fe5-4a2a-a2ce-9fd8d67c5f6f@linux.intel.com>

On Thu, Mar 14, 2024 at 03:41:23PM +0800, Baolu Lu wrote:

> The whole cookie mechanism aims to address two things:
> 
> - Extend the domain lifetime until all pending page faults are
> resolved.

Like you answered, I think the flush is a simpler scheme..

> - Associate information about the iommu device with each attachment of
>   the domain so that the iommufd device object ID could be quickly
>   retrieved in the fault delivering path.
 
> > I see we also need to stick a pointer in the domain for iommufd to get
> > back to the hwpt, but that doesn't seem to need such a big system to
> > accomplish - just add a void *. It would make sense for the domain to
> > have some optional pointer to a struct for all the fault related data
> > that becomes allocated when a PRI domain is created..
> 
> It's not getting back hwpt from domain, just getting the iommufd_device
> in the fault delivering path. The iommufd_device is not per-domain, but
> per-domain-attachment.

It does make sense you'd need that, but I think something like this is
a more direct way to get it. Caller allocates the handle struct. The
iopf will provide the handle from the XA to the
callback. container_of() not void * is used to in the caller's API.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 68e648b5576706..0d29d8f0847cd9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -46,6 +46,8 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
+enum { IOMMU_PASID_ARRAY_DOMAIN, IOMMU_PASID_ARRAY_HANDLE };
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -3516,18 +3518,20 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 }
 
 /*
- * iommu_attach_device_pasid() - Attach a domain to pasid of device
+ * __iommu_attach_device_pasid() - Attach a domain to pasid of device
  * @domain: the iommu domain.
  * @dev: the attached device.
  * @pasid: the pasid of the device.
  *
  * Return: 0 on success, or an error.
  */
-int iommu_attach_device_pasid(struct iommu_domain *domain,
-			      struct device *dev, ioasid_t pasid)
+int __iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
+				ioasid_t pasid,
+				struct iommu_pasid_handle *handle)
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
+	void *xa_entry;
 	void *curr;
 	int ret;
 
@@ -3541,9 +3545,14 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
+	if (handle)
+		xa_entry = xa_tag_pointer(handle, IOMMU_PASID_ARRAY_HANDLE);
+	else
+		xa_entry = xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
+	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, xa_entry,
+			  GFP_KERNEL);
 	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
+		ret = xa_err(curr) ?: -EBUSY;
 		goto out_unlock;
 	}
 
@@ -3556,7 +3565,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	mutex_unlock(&group->mutex);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
+EXPORT_SYMBOL_GPL(__iommu_attach_device_pasid);
 
 /*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
@@ -3600,13 +3609,23 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 {
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
+	struct iommu_pasid_handle *handle;
 	struct iommu_domain *domain;
+	void *xa_entry;
 
 	if (!group)
 		return NULL;
 
 	xa_lock(&group->pasid_array);
-	domain = xa_load(&group->pasid_array, pasid);
+	xa_entry = xa_load(&group->pasid_array, pasid);
+	if (xa_pointer_tag(xa_entry) == IOMMU_PASID_ARRAY_HANDLE) {
+		handle = xa_untag_pointer(xa_entry);
+		domain = handle->domain;
+	} else if (xa_pointer_tag(xa_entry) == IOMMU_PASID_ARRAY_DOMAIN) {
+		domain = xa_untag_pointer(xa_entry);
+	} else {
+		domain = NULL;
+	}
 	if (type && domain && domain->type != type)
 		domain = ERR_PTR(-EBUSY);
 	xa_unlock(&group->pasid_array);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1ea2a820e1eb03..47c121d4e13f65 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -947,8 +947,27 @@ void iommu_device_release_dma_owner(struct device *dev);
 
 struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
-int iommu_attach_device_pasid(struct iommu_domain *domain,
-			      struct device *dev, ioasid_t pasid);
+
+struct iommu_pasid_handle {
+	struct iommu_domain *domain;
+};
+
+int __iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
+				ioasid_t pasid,
+				struct iommu_pasid_handle *handle);
+
+static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
+{
+	return __iommu_attach_device_pasid(domain, dev, pasid, NULL);
+}
+static inline int
+iommu_attach_device_pasid_handle(struct iommu_pasid_handle *handle,
+				 struct device *dev, ioasid_t pasid)
+{
+	return __iommu_attach_device_pasid(handle->domain, dev, pasid, handle);
+}
+
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
 struct iommu_domain *

