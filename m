Return-Path: <linux-kernel+bounces-111850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B08871AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1895BB20D83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D45FB81;
	Fri, 22 Mar 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SO/kQuS9"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4357875
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127382; cv=none; b=Q7lkNwvUOj6g/FVVkGoldk20siHFwj9l6EZxdFTys8XRpZ9iubaF0V3VLMBaekF0bjsXX7x9vpQXpbO5jav9dqTFQ/A8drT+3w+0hPP+4l2LoZM2HKAybSw1YDiRdL/68d0+zHZFSDF2z+JMYEuG3J0xzYKcZfhcJZsYgZes7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127382; c=relaxed/simple;
	bh=7ur9VHXBBmtR/BzJooZLLcq+YeBquA9kLKNbVLwTOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEHOusoFEPgtbjzicvF4vodKYFKHdtS/KclFPBfTj1TPD76CsZpDnrlLZ1qSfP1KxDnmkfmLetheV6eZHXprhNvYXu8yycyzfVbDGWdpjLS+765HNMfjtbZq3jhB41QQVwbpzu1k6EXZmRz7pfVovUhHXRYCdN/UYtZkn1jC428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SO/kQuS9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-789db18e169so178395885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711127380; x=1711732180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApAHAb/kVXuA2vroBRV/sxLLRFwBeKrRqNlXizxetGM=;
        b=SO/kQuS9fYLVOZcHxuUiOuilHhl5g4cxkXr88umNfR3pYPIkx0hu4JPHD+0DcrFdHx
         fHOGzlqxvP+uK8xLLSM0hxsQHfHY/hgP2S1yeYvoHsH8qv3p7V43ZWfE33c3LA/Bbfu3
         QFWKPfgDuJ+KfE9rfK0D5QTiODMtFztr65oFkj6pnwEd+tY1QrMHprich3x85qdeDviP
         A58IbzICgHMLtojQUFI1xgJvu4QZXfQGZQuTzKusFEnz6rfoHTUvjfp+otv3hiK6DDUF
         whD5H4JU9kqCyFEDb1daH6gYpVrlKe711VrIpBC69ndqXr15Ue3VxYa+ai4DwYRGfT6+
         2x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127380; x=1711732180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApAHAb/kVXuA2vroBRV/sxLLRFwBeKrRqNlXizxetGM=;
        b=r/oup8HMbWLluOikC833XY1Pp5L9zm6kHI6/2eLZE1SG5JNmVXD2+UEl/JxZYA4otz
         QPWvjrQ5CmdlLgNv6DgFkCWstQNV8gcEVNhz98K3P+20aEwdHG8OiuUVZ+wcdZ5r+R2r
         yvf1GO6OjmuxcahTRUodnWqkTotOYdwtrepYsJXx2gGjm4scrYMZmA6JTvPeR+FPnjuj
         D4jhHbSBB9g2oMHF5jQ+Z7XjNCEuOF4WGyNKsQsivZHfkhapuXzLjemibm67gyksS9h+
         0aq8qqKe8Gx9YJNouXRWy9DHpl0a8pLOMgGr0R8nCuoym3wIzjcR+HphzoZncZUCN/v7
         FVmA==
X-Forwarded-Encrypted: i=1; AJvYcCXUnSm1gPIq2dsr0hQFc8sTj7z3YgZxRpe+q+bg37PpxQbRB1WnE1R+JBSgafSQrLrCMaOchgLQHBxMYZdcscFxTj0ehROIHhHI8HI8
X-Gm-Message-State: AOJu0Yzuy5LKKFJDKbDI4cVSs4SPwFXEZoWtWwGWqOkOV7wByQSGfQPm
	urCLxNWFkSzaA0Id5vfZDK4eDCc3IIez5t0oUdu3i4RbEHN5Ga1ssa9LsF9KAhDFlWAa2wrtwCr
	I
X-Google-Smtp-Source: AGHT+IEL8xR2S4VoPl+Aw327BSxdHoOXFRAq/bqB5JLQ7T86b5yNtZewLe/kyN/nOGUpgLU+Lu7bKg==
X-Received: by 2002:ae9:e401:0:b0:78a:2d4b:3b06 with SMTP id q1-20020ae9e401000000b0078a2d4b3b06mr18512qkc.76.1711127380253;
        Fri, 22 Mar 2024 10:09:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a02ec00b00789fa326156sm921596qko.82.2024.03.22.10.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:09:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniOh-00CSno-4j;
	Fri, 22 Mar 2024 14:09:39 -0300
Date: Fri, 22 Mar 2024 14:09:39 -0300
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
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
Message-ID: <20240322170939.GJ66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
 <20240308180332.GX9225@ziepe.ca>
 <e66064d7-c384-4f14-9459-ea21809b51b5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66064d7-c384-4f14-9459-ea21809b51b5@linux.intel.com>

On Fri, Mar 15, 2024 at 09:46:06AM +0800, Baolu Lu wrote:
> On 3/9/24 2:03 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 22, 2024 at 03:38:59PM +0800, Lu Baolu wrote:
> > > --- /dev/null
> > > +++ b/drivers/iommu/iommufd/fault.c
> > > @@ -0,0 +1,255 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (C) 2024 Intel Corporation
> > > + */
> > > +#define pr_fmt(fmt) "iommufd: " fmt
> > > +
> > > +#include <linux/file.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/iommufd.h>
> > > +#include <linux/poll.h>
> > > +#include <linux/anon_inodes.h>
> > > +#include <uapi/linux/iommufd.h>
> > > +
> > > +#include "iommufd_private.h"
> > > +
> > > +static int device_add_fault(struct iopf_group *group)
> > > +{
> > > +	struct iommufd_device *idev = group->cookie->private;
> > > +	void *curr;
> > > +
> > > +	curr = xa_cmpxchg(&idev->faults, group->last_fault.fault.prm.grpid,
> > > +			  NULL, group, GFP_KERNEL);
> > > +
> > > +	return curr ? xa_err(curr) : 0;
> > > +}
> > > +
> > > +static void device_remove_fault(struct iopf_group *group)
> > > +{
> > > +	struct iommufd_device *idev = group->cookie->private;
> > > +
> > > +	xa_store(&idev->faults, group->last_fault.fault.prm.grpid,
> > > +		 NULL, GFP_KERNEL);
> > 
> > xa_erase ?
> 
> Yes. Sure.
> 
> > Is grpid OK to use this way? Doesn't it come from the originating
> > device?
> 
> The group ID is generated by the hardware. Here, we use it as an index
> in the fault array to ensure it can be quickly retrieved in the page
> fault response path.

I'm nervous about this, we are trusting HW outside the kernel to
provide unique grp id's which are integral to how the kernel
operates..

> > > +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> > > +				       size_t count, loff_t *ppos)
> > > +{
> > > +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> > > +	struct iommufd_fault *fault = filep->private_data;
> > > +	struct iommu_hwpt_pgfault data;
> > > +	struct iommufd_device *idev;
> > > +	struct iopf_group *group;
> > > +	struct iopf_fault *iopf;
> > > +	size_t done = 0;
> > > +	int rc;
> > > +
> > > +	if (*ppos || count % fault_size)
> > > +		return -ESPIPE;
> > > +
> > > +	mutex_lock(&fault->mutex);
> > > +	while (!list_empty(&fault->deliver) && count > done) {
> > > +		group = list_first_entry(&fault->deliver,
> > > +					 struct iopf_group, node);
> > > +
> > > +		if (list_count_nodes(&group->faults) * fault_size > count - done)
> > > +			break;
> > > +
> > > +		idev = (struct iommufd_device *)group->cookie->private;
> > > +		list_for_each_entry(iopf, &group->faults, list) {
> > > +			iommufd_compose_fault_message(&iopf->fault, &data, idev);
> > > +			rc = copy_to_user(buf + done, &data, fault_size);
> > > +			if (rc)
> > > +				goto err_unlock;
> > > +			done += fault_size;
> > > +		}
> > > +
> > > +		rc = device_add_fault(group);
> > 
> > See I wonder if this should be some xa_alloc or something instead of
> > trying to use the grpid?
> 
> So this magic number will be passed to user space in the fault message.
> And the user will then include this number in its response message. The
> response message is valid only when the magic number matches. Do I get
> you correctly?

Yes, then it is simple xa_alloc() and xa_load() without any other
searching and we don't have to rely on the grpid to be correctly
formed by the PCI device.

But I don't know about performance xa_alloc() is pretty fast but
trusting the grpid would be faster..

IMHO from a uapi perspective we should have a definate "cookie" that
gets echo'd back. If the kernel uses xa_alloc or grpid to build that
cookie it doesn't matter to the uAPI.

Jason

