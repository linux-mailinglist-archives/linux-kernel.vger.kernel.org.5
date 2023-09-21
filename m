Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7F7AA5A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjIUXbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:31:42 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9DA8F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:31:35 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so452324fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695339095; x=1695943895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vRAHoKrBGfBYsWb1uVktJ9AcaRiuBBSufLkHTgcXpQ=;
        b=oA+1jIQujhLu3imIREXqBn4KLYB9/MSnAb3j2Kpri6RjAB83UKnJmO220juUM+5KUz
         rUimJyLZXFVhd/Mz8IYGna470zuoFo9vJPmtCsvlWwESS386l7o2pi9Zx13BjNwGU+0D
         Cpzzvopa8Lf50lSF7k6nuQlsXTjpIIa4BGv/s5X7aGI5kemWcnRZTe2NOaTcknTJfMVR
         tC7KFiq++Ih/ttKrUZPKGdJ8/hI0NZRS2J6hFNzp65SKSgmumyt9+ZoA5msOhBLOUpB1
         TlG8pSLfaqUlFvTXWyZKYxUs5jEqPrDcc5qy7qwpoCdso9ksqKlRSlMDSdkl4pDJ+4V7
         d6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695339095; x=1695943895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vRAHoKrBGfBYsWb1uVktJ9AcaRiuBBSufLkHTgcXpQ=;
        b=YYxb0ancbpneNoGvp7stwpvikuXMl971Nt5YfrL+7F7Cj6/gz/l1DZk7qSW2A5kFjp
         BBPtZ7GgvGlvJ/a0db8IYoLJd9fMRGmaxrI+//MA2D9hC+2UE8V4Lo2Syhi3aey2khfE
         P5VkPLe4pd/DhBaWAwZNHPhqL/40WJtu7YU6WPQflfEBcY3iVOzn5wPjXsdy/x2KVEDw
         WEgkB28ZOqVNUSOh0T3RXqsrzWtFzSBw5+4YfOv3fu4c/DdM0ewVlJRzQTEGRZnhmprP
         zlxLuLoHVryLHyIy/+MyvfgmtkZmno4Btnu0fv9Q1Kg5g/3ECGFp17OiPn5iV49ANxjb
         0g5w==
X-Gm-Message-State: AOJu0YzSluBy4cfMDlrYuMwaEYW9Ds+HLdxxmtzffZa1wk4VC1EvgsZQ
        mkhEXlegC5H/Inu06bUUrgsJe1VzR4qPxkRw8RU=
X-Google-Smtp-Source: AGHT+IHOp6xGDw4D0NmKC1EUFwovljdQRKwnyAsIoXdxF5prMSG6PeCqPtOlHL1IOsdsa4UK0fOIrg==
X-Received: by 2002:a05:6870:5622:b0:1d5:8f05:39da with SMTP id m34-20020a056870562200b001d58f0539damr7664576oao.25.1695339095164;
        Thu, 21 Sep 2023 16:31:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id mm5-20020a0562145e8500b006564afc5908sm294372qvb.111.2023.09.21.16.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:31:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjT8v-000Us1-UF;
        Thu, 21 Sep 2023 20:31:33 -0300
Date:   Thu, 21 Sep 2023 20:31:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20230921233133.GB13795@ziepe.ca>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-6-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912125936.722348-6-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:59:35PM +0800, Tina Zhang wrote:
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 0f956ecd0c9b..79779bbef653 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -15,6 +15,7 @@ static DEFINE_MUTEX(iommu_sva_lock);
>  static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>  {
>  	ioasid_t pasid;
> +	struct iommu_mm_data *iommu_mm;
>  	int ret = 0;
>  
>  	if (!arch_pgtable_dma_compat(mm))
> @@ -28,12 +29,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
>  		goto out;
>  	}
>  
> +	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
> +	if (!iommu_mm) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	pasid = iommu_alloc_global_pasid(dev);
>  	if (pasid == IOMMU_PASID_INVALID) {
> +		kfree(iommu_mm);
>  		ret = -ENOSPC;
>  		goto out;
>  	}
> -	mm->pasid = pasid;
> +	iommu_mm->pasid = pasid;
> +	INIT_LIST_HEAD(&iommu_mm->sva_domains);
> +	mm->iommu_mm = iommu_mm;
> +
>  	ret = 0;
>  out:
>  	mutex_unlock(&iommu_sva_lock);
> @@ -73,16 +84,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  
>  	mutex_lock(&iommu_sva_lock);
>  	/* Search for an existing domain. */
> -	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
> -						IOMMU_DOMAIN_SVA);
> -	if (IS_ERR(domain)) {
> -		ret = PTR_ERR(domain);
> -		goto out_unlock;
> -	}
> -
> -	if (domain) {
> -		domain->users++;
> -		goto out;
> +	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
> +		ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
> +		if (!ret) {
> +			domain->users++;
> +			goto out;
> +		}
>  	}
>  
>  	/* Allocate a new domain and set it on device pasid. */
> @@ -96,6 +103,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  	if (ret)
>  		goto out_free_domain;
>  	domain->users = 1;
> +	list_add(&domain->next, &mm->iommu_mm->sva_domains);
> +
>  out:
>  	mutex_unlock(&iommu_sva_lock);
>  	handle->dev = dev;
> @@ -128,8 +137,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>  	struct device *dev = handle->dev;
>  
>  	mutex_lock(&iommu_sva_lock);
> +	iommu_detach_device_pasid(domain, dev, pasid);
>  	if (--domain->users == 0) {
> -		iommu_detach_device_pasid(domain, dev, pasid);
> +		list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}
>  	mutex_unlock(&iommu_sva_lock);
> @@ -209,4 +219,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>  		return;
>  
>  	iommu_free_global_pasid(mm_get_pasid(mm));
> +	kfree(mm->iommu_mm);
>  }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b9c9f14a95cc..c61bc45d5a82 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -109,6 +109,11 @@ struct iommu_domain {
>  		struct {	/* IOMMU_DOMAIN_SVA */
>  			struct mm_struct *mm;
>  			int users;
> +			/*
> +			 * Next iommu_domain in mm->iommu_mm->sva-domains list
> +			 * protected by iommu_sva_lock.
> +			 */
> +			struct list_head next;
>  		};
>  	};
>  };
> @@ -1186,17 +1191,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>  }
>  
>  #ifdef CONFIG_IOMMU_SVA
> -static inline void mm_pasid_init(struct mm_struct *mm)
> -{
> -	mm->pasid = IOMMU_PASID_INVALID;
> -}
>  static inline bool mm_valid_pasid(struct mm_struct *mm)
>  {
> -	return mm->pasid != IOMMU_PASID_INVALID;
> +	return mm->iommu_mm ? true : false;
>  }

HUm this isn't locked very nicely.

Above do

smp_store_release(&mm->iommu_mm, iommu_mm);

And then do 

  return READ_ONCE(mm->iommu_mm)

(no need for ternaries with bools, compiler generates it automatically)


>  static inline u32 mm_get_pasid(struct mm_struct *mm)
>  {
> -	return mm->pasid;
> +	return mm->iommu_mm ? mm->iommu_mm->pasid : IOMMU_PASID_INVALID;
>  }

Then this should be

struct iommu_mm_data *iommu_mm = READ_ONCE(mm->iommu_mm);

if (!iommu_mm)
   return IOMMU_PASID_INVALID;
return iommu_mm->pasid;

Keeping in mind that the kfree(mm->iommu_mm) being placed in the
mm_drop is critical to this working safely.

Otherwise the logic looks OK.

Jason
