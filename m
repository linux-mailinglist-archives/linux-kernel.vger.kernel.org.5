Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036987A9F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjIUUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjIUUVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:21:44 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC946E49
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:03:03 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-65896b9aa09so7262616d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695322981; x=1695927781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swwjAhkLvf2PxtUGkC4GC1yABB8RkqrPI0gAF8T7JK0=;
        b=Q9hn83LRX7+DJtjpS/aLI7UQl0cW5KOtAN16x6rY6gdXsxIGvGXXEY9jKIBrM+SbxZ
         2acOrzMpvEzKcDYlwwMpOutzRUM7nx/xOmrl6MTWBmBnmVmC3dcV/DloiWRA137BTYZJ
         QtBkTYs1Wg/1QCgNKz6erthHCPGzBduDTdij+BdVVF0DnSahrCsr6+iAZkDYBWUI8aw6
         KSGy6ZCJXmf2qwK9pwcaKS1KWsM9Pq42YIbD0/2X7Ub0Wcv6N5q9D7hlpo+UnBtZyeWL
         QP4YS3de43dWsn/U1qjC0DcOPwEi9fneo4MWjC3KaH+5NGzuYir1rnoGswKSjLKGCxHD
         LnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322981; x=1695927781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swwjAhkLvf2PxtUGkC4GC1yABB8RkqrPI0gAF8T7JK0=;
        b=B+XhyHl9eCDyN16iFlooMMz3rnQ9LgGwDQb7XLw9ewYJSUeqeNf90qdzUHJkb1VDBq
         uX62oec+DIrrJhfIPz7NZ+gb9NdLKJ5YLmb+90ZumF0vIiwqmvINa7oPVG8n4l0eO6ZK
         3O3MWedF0wfi1uL5R8T1Mujaab6LqXxQATjTh+Lml4C/mHwlK1zPjs4d9DoDuoY+hveZ
         88RpAN+wqGINoOc8fPTzZtIUtH0Tegp5AOiuU3wcIkRaoYcinPfjbbweq8XK/2QDU7CO
         qMa/Gm3BFaroGz0xCoAdrcV5LFERp2t6VdR7k0dsCXb/85yAN2jysl8et53dERDcTOUB
         oFnA==
X-Gm-Message-State: AOJu0Yw2pTn4HHzb6zHEJ7kNZEbvt8QsQUi4Pgv37xipk5Ksf1OKAqv4
        zQbhu2BcnNTpzkRvSdaHsSt6Ew==
X-Google-Smtp-Source: AGHT+IFdKgSsaiYl9w1PGP+h1hhaanbGtVCH42jDNLS/f9CfseBqiTy8DPrtBfsbOOZy50KPY8kklQ==
X-Received: by 2002:a05:6214:5852:b0:655:78f5:bef7 with SMTP id ml18-20020a056214585200b0065578f5bef7mr6344042qvb.21.1695322981562;
        Thu, 21 Sep 2023 12:03:01 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id h20-20020a0cf414000000b0063f822dae2csm801093qvl.54.2023.09.21.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:03:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjOx1-000TYP-JI;
        Thu, 21 Sep 2023 16:02:59 -0300
Date:   Thu, 21 Sep 2023 16:02:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iommu: Introduce mm_get_pasid() helper function
Message-ID: <20230921190259.GZ13795@ziepe.ca>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-4-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912125936.722348-4-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:59:33PM +0800, Tina Zhang wrote:
> Use the helper function mm_get_pasid() to get a mm assigned pasid
> value. The motivation is to replace mm->pasid with an iommu private
> data structure that is introduced in a later patch.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
> 
> Changes in v4:
> - Rebase to v6.6-rc1.
> 
> Changes in v2:
> - Update commit message.
> - Let mm_get_enqcmd_pasid() call mm_get_pasid() to get pasid.
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++------
>  drivers/iommu/iommu-sva.c                       | 12 ++++++------
>  include/linux/iommu.h                           | 10 +++++++++-
>  3 files changed, 21 insertions(+), 13 deletions(-)

Michael already has a series to remove this mis-use from the ARM
driver like you did for the Intel driver.

I think for the interm it is fine to just use mm_get_enqcmd_pasid()
and Michael can remove it.

It helps point out this is just wrong anyhow and better discourages
anyone else from using it.

> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index b78671a8a914..0f956ecd0c9b 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -23,7 +23,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>  	mutex_lock(&iommu_sva_lock);
>  	/* Is a PASID already associated with this mm? */
>  	if (mm_valid_pasid(mm)) {
> -		if (mm->pasid >= dev->iommu->max_pasids)
> +		if (mm_get_pasid(mm) >= dev->iommu->max_pasids)
>  			ret = -EOVERFLOW;
>
>  		goto out;
>  	}
>
> @@ -73,7 +73,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  
>  	mutex_lock(&iommu_sva_lock);
>  	/* Search for an existing domain. */
> -	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> +	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
>  						IOMMU_DOMAIN_SVA);
>  	if (IS_ERR(domain)) {
>  		ret = PTR_ERR(domain);
> @@ -92,7 +92,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  		goto out_unlock;
>  	}
>  
> -	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
> +	ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
>  	if (ret)
>  		goto out_free_domain;
>  	domain->users = 1;

These ones are all manipulating the enqcmd_pasid really..  If it
wasn't for enqcmd then we'd simply make each device have its own PASID
and then we wouldn't have the issue that a valid pasid is incompatible
with a certain device.

Jason
