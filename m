Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5345D800F9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379364AbjLAPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379328AbjLAPYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:24:55 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC8106
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:25:01 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77dc733b25cso116054385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701444300; x=1702049100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIctRRSn0vwGQpdvNDPNBUzRbr3mcV06BO064VqiQvE=;
        b=QnbtxcpgU+d+RlKd0XyMG2Th6tuIqZEUY4mAc77GUBU2ooHKKcyMrncas7INjtom4y
         eaEGlxYY25WzNQ+c1CVjqCEgmynbvZyGuYKDPqvsqyo+lnWyPLsEteJ0z7EJbqmvrOqI
         olZXNea6eeNinYGU8YSpj2eTGlcsqbamewYC/R0iZzerz9zFkktZnB1DVVsUXmFgYov8
         I7xCqxGGG1LklT8wCUTvPBq0Fpwz6/mGxKLMoAG24Eqeqkr6qseW/wttZAu3pZKa/Oz2
         DKgC3GApKhC8bGySgLS3R128TamaLNZ3TLaYvxNeRXydUwusMCl+mTBoKve08LHNJMFw
         0/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444300; x=1702049100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIctRRSn0vwGQpdvNDPNBUzRbr3mcV06BO064VqiQvE=;
        b=UPvLk4AtDO75Nd6o2SGsDQYG8PIyZ3Y6lXwklZkfO0VAiBw3+4E2t067T1ckJxMhEc
         zwE2Jb8von0/+a8wanm+PA4PPxwmCWy9wDj3dDYmp4vyDwUeS3pZcp8Qe8HSzr9cWnWy
         3LCEb9Jk6S1IqPxpv0SEx/opz+y6wvnRziyHlwAw3cIC7rkNtWPCzbi/igKgiUmF5iVB
         WfKLcB8I4W0BZ2sTkAgkxb7h7OBLNaXz+1GzG38B9hTCHJmWjjD2IJKItOoNjpT39Be7
         Fxma/n8hkoxTSNnu7PbIgRpaDD0WiO16WJ/KxWAk97uAlttkb1H5bHO6AMtdAkH+UBBB
         rIvQ==
X-Gm-Message-State: AOJu0YwTtXWTC5iMDXtVmQjfkAXKiQMN0bq98FSqaMZkFNMg6T9QZ0d+
        LZXzpFbwKJn0Q1ulOUCCyO1gqA==
X-Google-Smtp-Source: AGHT+IH9aQsdojUrYLvHxO5KK9009RG0u9DrfU1zkCcGPgQMNQH05O1B5rZ99KIPwto9uIZJVs6JwQ==
X-Received: by 2002:a05:620a:6507:b0:76d:aa3b:ac9c with SMTP id qb7-20020a05620a650700b0076daa3bac9cmr30406177qkn.46.1701444300373;
        Fri, 01 Dec 2023 07:25:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a295100b007676f3859fasm1572386qkp.30.2023.12.01.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:24:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r95Nz-006G1Y-DA;
        Fri, 01 Dec 2023 11:24:59 -0400
Date:   Fri, 1 Dec 2023 11:24:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231201152459.GB1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-5-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:49:28AM +0800, Lu Baolu wrote:

> +static ssize_t hwpt_fault_fops_write(struct file *filep,
> +				     const char __user *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
> +	struct hw_pgtable_fault *fault = filep->private_data;
> +	struct iommu_hwpt_page_response response;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iopf_group *iter, *group;
> +	struct iommufd_device *idev;
> +	size_t done = 0;
> +	int rc = 0;
> +
> +	if (*ppos || count % response_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->response) && count > done) {
> +		rc = copy_from_user(&response, buf + done, response_size);
> +		if (rc)
> +			break;
> +
> +		/* Get the device that this response targets at. */
> +		idev = container_of(iommufd_get_object(fault->ictx,
> +						       response.dev_id,
> +						       IOMMUFD_OBJ_DEVICE),
> +				    struct iommufd_device, obj);
> +		if (IS_ERR(idev)) {
> +			rc = PTR_ERR(idev);
> +			break;
> +		}

See here it might be better to have a per-fd list of outstanding
faults per-fd and then the cookie would just index that list, then you
get everything in one shot instead of having to do a xarray looking
and then a linear list search

> +static const struct file_operations hwpt_fault_fops = {
> +	.owner		= THIS_MODULE,
> +	.read		= hwpt_fault_fops_read,
> +	.write		= hwpt_fault_fops_write,
> +};

nonseekable_open() behavior should be integrated into this

> +static int hw_pagetable_get_fault_fd(struct hw_pgtable_fault *fault)
> +{
> +	struct file *filep;
> +	int fdno;
> +
> +	fdno = get_unused_fd_flags(O_CLOEXEC);
> +	if (fdno < 0)
> +		return fdno;
> +
> +	filep = anon_inode_getfile("[iommufd-pgfault]", &hwpt_fault_fops,
> +				   fault, O_RDWR);
> +	if (IS_ERR(filep)) {
> +		put_unused_fd(fdno);
> +		return PTR_ERR(filep);
> +	}
> +
> +	fd_install(fdno, filep);
> +	fault->fault_file = filep;
> +	fault->fault_fd = fdno;

fd_install must be the very last thing before returning success from a
system call because we cannot undo it.

There are other failure paths before here and the final return

Jason
