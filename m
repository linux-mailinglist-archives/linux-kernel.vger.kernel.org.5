Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3629080EE77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376457AbjLLOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376452AbjLLOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:12:06 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897D410A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:12:11 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4259c7dfb63so28477971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702390330; x=1702995130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ2TiLoD9Gaq6xkoyUSluJ0KHWLQt9mZyTQyaXIVvpI=;
        b=Ma6EWX39Bj1+T9k0jBia+zrZupD7uZ+MvPqsdYZzuIIsCDzoZlisglAN5yH5/oEK9g
         a1AAT63J2/G5xRWwi2oo1rppz6IWnTX3OZoTyKWZt++m1ECcRYhwSzlN5MvnZXiLi/rJ
         l/E7r9Fan781Jhhyr9OVRLLCSF1oORTqZ/bw5C0bAmUzamQdXNNvfwmQHXn63uZr52n8
         2UobjmltDa40DJ/hOqZTPFxpzzmrugA/7QL5aXuWv9AzO6nJ9M5sRc1i8jnP1ydUQSKR
         JLaxJ8nyPCqhEe8Of6xlQdlg5KeLG/wfT3+naYeO9P+eC7SxHLMnnstTnJ8iOTbr1c9D
         U+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702390330; x=1702995130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ2TiLoD9Gaq6xkoyUSluJ0KHWLQt9mZyTQyaXIVvpI=;
        b=gHszmwcl5dPNOe2XPlvoVykZ/L/hJke6la7sKShGbNACfJkjXrgX18Q7enXhc1tJHW
         qyrWtWBOBLCu6e2Lfz9Y3tRUqPFzHcYvBcdUrdeC+at+4yFe53DGeU5/N+9ERYonvgP/
         Pdo4xpAPuDIdgY87jE9V0wT8ZpZYU7Y3PYvzwkIK5xc3V5cqPVuxkaN4gAXzI88N+bif
         V7DUke6AgPrrpSmgqinej0juo3+R84V8Hno+unNo4ZAWBrkr/KF2l94+6Wr4+W/50h5Y
         w40+PUgPZkpZSI1pSx19MV6KuiBQghgiagw8090nbHXrYHj1GUx/jXtyt7Ghpt9oHrMA
         9K5Q==
X-Gm-Message-State: AOJu0YxxKhevtWOjpIle9Gt3CxF9tqAe3fKAYzS5IW4ilb3A3/xP/PRq
        iMsoZvuQlclzNBzxoOuZiFqGww==
X-Google-Smtp-Source: AGHT+IGRkRQVaTR68B5qveU70mgfrGlXmlTMF+z308FUs0i5H1yAdurOHwLdhvMF64yVQEAU8ICGfg==
X-Received: by 2002:ac8:7dc6:0:b0:425:4043:29ff with SMTP id c6-20020ac87dc6000000b00425404329ffmr7750741qte.122.1702390330535;
        Tue, 12 Dec 2023 06:12:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id t22-20020ac85316000000b0041cb787ff41sm4082934qtn.67.2023.12.12.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:12:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rD3UW-00CjJP-VZ;
        Tue, 12 Dec 2023 10:12:08 -0400
Date:   Tue, 12 Dec 2023 10:12:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Message-ID: <20231212141208.GA3013885@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-4-baolu.lu@linux.intel.com>
 <CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>
 <20231212131008.k6s5xwjgolp6geps@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212131008.k6s5xwjgolp6geps@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 02:10:08PM +0100, Joel Granados wrote:

> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 645ab5d290fe..0a8e03d5e7c5 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -456,6 +456,16 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> >  	if (rc)
> >  		goto err_unlock;
> >  
> > +	if (hwpt->fault) {
> > +		void *curr;
> > +
> > +		curr = iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
> I'm hitting an error here when I try to attach to a hwpt that I created
> previously with the `IOMMU_HWPT_ALLOC_IOPF_CAPABLE` flag.
> 
> I get an -ENODEV from iopf_pasid_cookie_set which is triggered by
> dev->iommu->fault_param being 0x0.
> 
> I looked around and I see that the fault param gets set in
> iopf_queue_add_device which is called from iommu_dev_enable_feature
> only. Furthermore iommu_dev_enable_feature is only called in idxd and
> uacce drivers.
> 
> Questions:
> 1. Should iopf_queue_add_device get called from the
>    IOMMU_HWPT_ALLOC_IOPF_CAPABLE ioctl call? This make sense to me as
>    this is where the device and the IOPF are related from user space.

It probably needs to call the set feature thing in the short term.

In the medium term I would like the drivers to manage the iopf based
on domain attachment not explicit feature asks

> 2. This is not intended to work only with idxd and uacce. right?

It should work everywhere, I suspect Intel Team didn't hit this
because they are testing IDXD SIOV? Can you guys also test it as a PF
assignment?

Jason
