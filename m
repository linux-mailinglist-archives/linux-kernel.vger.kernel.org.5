Return-Path: <linux-kernel+bounces-97432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDA8876A66
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69A428503D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A10E50251;
	Fri,  8 Mar 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bmJ/6ZMu"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738158137
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921018; cv=none; b=OkbMJMz6s93uzEc/mUyGLGhedzTB5bQaW/pQHcodC7tCGMJpJri9NMHdMZBNYsIYYGF6zSv40W39SBJll382QP+j53KNOXK9xwh7fcyV+Rz//lAp5MaM1Z2nA9hdi6YTKCfrhgMdzEL6CcBcXTCnMBRToAhio603zVUeqOhJlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921018; c=relaxed/simple;
	bh=3LVj4/dvr7RiYytJk6zXL+ousuVGoUmlE+T+FQANLJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac+43athvgrOVYMS1+OX6YYG7LcaJtDa+ER/ck8ZPkBTGA0dm3ZH81/5xP9zEQtXFKeNm5tmRyIG+dLELDvTmta8oitiO6IZSNeIinVL74O4b8EZTuftwR/8Ti5GAg7gqVfhhzhONnW6LusWJUx/mmbrpLA20sJlOf9kKlbEBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bmJ/6ZMu; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21fb368b468so1344717fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709921014; x=1710525814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZzrM6BbRqgMpeBTx8YDf05PpuvDd3fYcXNtVCqPsiw=;
        b=bmJ/6ZMu8msGDrIzBFPPkJbqr1xMbc7jbVfwgxwEJYt9r/7DNcGEBC0Ka9tEq53IRB
         pwLR3x5u14av4BoGkO6RRSF5m7jHvoFI1SNKQqUNCA9B7i749AriqFIm2dZ8K/sJ/4bU
         RA0VO8hvTdVCQWFwqTBX3zUUpLrdpX9J7TfezfdaUxU8fIT6fzLDVmnnWOtUjZJVAP59
         rnvNY0cjYliRFXm5pVD8iaVsWak9Mkp8B+vPWknNojTtuKrRPBKv3Pd8oZUk8TSZ220q
         ekHKhfzCFseb7Rz+uYOYA3yV87iVGzj86O7Itafz6arHNSuRVMdQuHMZD9Ypxz3w9zlg
         BXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921014; x=1710525814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZzrM6BbRqgMpeBTx8YDf05PpuvDd3fYcXNtVCqPsiw=;
        b=POpxm9Qu57Bd6rKMqaPi2+XmSTFgFyvHOxeKPNIGwtiOwb3JaXkn4Q8b1TqqHAQVWA
         T4CUGVXSLwHfpTCA70wiFbIFPlrMmtr6IZTzQlVkkuTFG0antLSDZaUOvho0XsUSLVQO
         sCqgW8dDsShHF1eTFcGzcbkEG75+NQ/aGCR671edqaJSuaKbIlvNjNyigrWueLxyoVHH
         c2h00G5Qq8Efab9PyqTVPh2KfVH6pEHPVdNNaQJ8EKu8hNFZAs39JuVwUKzGM1cLcVdd
         ulP2e1ASZLgCqrFd4sbY1vwJQjJKY2iW8ymqx/XJZ4BC3Pz6a3tbW8lOaXOdHfBhtlA3
         QKjg==
X-Forwarded-Encrypted: i=1; AJvYcCXtxv2vGwDs9KVx25sl36UbHSzCoGrWs8/bYVs8vsqgnv2wJYe2NflwkKEiGgGhTVUE3rkfmUYrrXxryJiFPxYKKgCy+qxKWH6u8CUB
X-Gm-Message-State: AOJu0Yz1fBocpMTWs0RohXbwsmJUm9L8Jf/uF6EclgHIUt0IwKiBv1eP
	bB9vsxmVTfeAKzxZM8RDVM7S03nRsyTe8FvjouAX3Qcx8GZqmVjfuZ+XCQjCago=
X-Google-Smtp-Source: AGHT+IF7pWjtuz8Xb3cQKQtapSRXtT6lbKWY4ydmQ4LB9QhAYAFvk6sa+sebdrqQhb+hD17nUWsTIA==
X-Received: by 2002:a05:6870:171a:b0:21e:c3a4:8dd9 with SMTP id h26-20020a056870171a00b0021ec3a48dd9mr3833215oae.10.1709921014517;
        Fri, 08 Mar 2024 10:03:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id oo24-20020a0568715a9800b0022138173901sm1968607oac.45.2024.03.08.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:03:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rieZA-007b0V-V9;
	Fri, 08 Mar 2024 14:03:32 -0400
Date: Fri, 8 Mar 2024 14:03:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
Message-ID: <20240308180332.GX9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-5-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:38:59PM +0800, Lu Baolu wrote:
> --- /dev/null
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Intel Corporation
> + */
> +#define pr_fmt(fmt) "iommufd: " fmt
> +
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/iommufd.h>
> +#include <linux/poll.h>
> +#include <linux/anon_inodes.h>
> +#include <uapi/linux/iommufd.h>
> +
> +#include "iommufd_private.h"
> +
> +static int device_add_fault(struct iopf_group *group)
> +{
> +	struct iommufd_device *idev = group->cookie->private;
> +	void *curr;
> +
> +	curr = xa_cmpxchg(&idev->faults, group->last_fault.fault.prm.grpid,
> +			  NULL, group, GFP_KERNEL);
> +
> +	return curr ? xa_err(curr) : 0;
> +}
> +
> +static void device_remove_fault(struct iopf_group *group)
> +{
> +	struct iommufd_device *idev = group->cookie->private;
> +
> +	xa_store(&idev->faults, group->last_fault.fault.prm.grpid,
> +		 NULL, GFP_KERNEL);

xa_erase ?

Is grpid OK to use this way? Doesn't it come from the originating
device?

> +void iommufd_fault_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
> +	struct iopf_group *group, *next;
> +
> +	mutex_lock(&fault->mutex);
> +	list_for_each_entry_safe(group, next, &fault->deliver, node) {
> +		list_del(&group->node);
> +		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
> +		iopf_free_group(group);
> +	}
> +	list_for_each_entry_safe(group, next, &fault->response, node) {
> +		list_del(&group->node);
> +		device_remove_fault(group);
> +		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
> +		iopf_free_group(group);
> +	}
> +	mutex_unlock(&fault->mutex);
> +
> +	mutex_destroy(&fault->mutex);

It is really weird to lock a mutex we are about to destroy? At this
point the refcount on the iommufd_object is zero so there had better
not be any other threads with access to this pointer!

> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> +	struct iommufd_fault *fault = filep->private_data;
> +	struct iommu_hwpt_pgfault data;
> +	struct iommufd_device *idev;
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf;
> +	size_t done = 0;
> +	int rc;
> +
> +	if (*ppos || count % fault_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->deliver) && count > done) {
> +		group = list_first_entry(&fault->deliver,
> +					 struct iopf_group, node);
> +
> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
> +			break;
> +
> +		idev = (struct iommufd_device *)group->cookie->private;
> +		list_for_each_entry(iopf, &group->faults, list) {
> +			iommufd_compose_fault_message(&iopf->fault, &data, idev);
> +			rc = copy_to_user(buf + done, &data, fault_size);
> +			if (rc)
> +				goto err_unlock;
> +			done += fault_size;
> +		}
> +
> +		rc = device_add_fault(group);

See I wonder if this should be some xa_alloc or something instead of
trying to use the grpid?

> +	while (!list_empty(&fault->response) && count > done) {
> +		rc = copy_from_user(&response, buf + done, response_size);
> +		if (rc)
> +			break;
> +
> +		idev = container_of(iommufd_get_object(fault->ictx,
> +						       response.dev_id,
> +						       IOMMUFD_OBJ_DEVICE),
> +				    struct iommufd_device, obj);

It seems unfortunate we do this lookup for every iteration of the loop,
I would lift it up and cache it..

> +		if (IS_ERR(idev))
> +			break;
> +
> +		group = device_get_fault(idev, response.grpid);

This looks locked wrong, it should hold the fault mutex here and we
should probably do xchng to zero it at the same time we fetch it.

> +		if (!group ||
> +		    response.addr != group->last_fault.fault.prm.addr ||
> +		    ((group->last_fault.fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
> +		      response.pasid != group->last_fault.fault.prm.pasid)) {

Why? If grpid is unique then just trust it.

> +			iommufd_put_object(fault->ictx, &idev->obj);
> +			break;
> +		}
> +
> +		iopf_group_response(group, response.code);
> +
> +		mutex_lock(&fault->mutex);
> +		list_del(&group->node);
> +		mutex_unlock(&fault->mutex);
> +
> +		device_remove_fault(group);
> +		iopf_free_group(group);
> +		done += response_size;
> +
> +		iommufd_put_object(fault->ictx, &idev->obj);
> +	}
> +
> +	return done;
> +}
> +
> +static __poll_t iommufd_fault_fops_poll(struct file *filep,
> +					struct poll_table_struct *wait)
> +{
> +	struct iommufd_fault *fault = filep->private_data;
> +	__poll_t pollflags = 0;
> +
> +	poll_wait(filep, &fault->wait_queue, wait);
> +	mutex_lock(&fault->mutex);
> +	if (!list_empty(&fault->deliver))
> +		pollflags = EPOLLIN | EPOLLRDNORM;
> +	mutex_unlock(&fault->mutex);
> +
> +	return pollflags;
> +}
> +
> +static const struct file_operations iommufd_fault_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= nonseekable_open,
> +	.read		= iommufd_fault_fops_read,
> +	.write		= iommufd_fault_fops_write,
> +	.poll		= iommufd_fault_fops_poll,
> +	.llseek		= no_llseek,
> +};

No release? That seems wrong..

> +static int get_fault_fd(struct iommufd_fault *fault)
> +{
> +	struct file *filep;
> +	int fdno;
> +
> +	fdno = get_unused_fd_flags(O_CLOEXEC);
> +	if (fdno < 0)
> +		return fdno;
> +
> +	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
> +				   fault, O_RDWR);
                                   ^^^^^^

See here you stick the iommufd_object into the FD but we don't
refcount it...

And iommufd_fault_destroy() doesn't do anything about this, so it just
UAFs the fault memory in the FD.

You need to refcount the iommufd_object here and add a release
function for the fd to put it back

*and* this FD needs to take a reference on the base iommufd_ctx fd too
as we can't tolerate them being destroyed out of sequence.

> +int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_fault_alloc *cmd = ucmd->cmd;
> +	struct iommufd_fault *fault;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
> +	if (IS_ERR(fault))
> +		return PTR_ERR(fault);
> +
> +	fault->ictx = ucmd->ictx;
> +	INIT_LIST_HEAD(&fault->deliver);
> +	INIT_LIST_HEAD(&fault->response);
> +	mutex_init(&fault->mutex);
> +	init_waitqueue_head(&fault->wait_queue);
> +
> +	rc = get_fault_fd(fault);
> +	if (rc < 0)
> +		goto out_abort;

And this is ordered wrong, fd_install has to happen after return to
user space is guarenteed as it cannot be undone.

> +	cmd->out_fault_id = fault->obj.id;
> +	cmd->out_fault_fd = rc;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_abort;
> +	iommufd_object_finalize(ucmd->ictx, &fault->obj);

fd_install() goes here

> +	return 0;
> +out_abort:
> +	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
> +
> +	return rc;
> +}

Jason

