Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0097A4E00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjIRQEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjIRQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:04:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E24C04
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:02:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso47189875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695052684; x=1695657484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuWLNVcWzC6ASPZz9GEuSYcaG6pqUJBDXR7IC05cfLo=;
        b=gcPtWmiamaacuYhz+dKZWLrYyTg9JGjfwtCTx2IEYKNHzbVcqDlg+0Ml69PFEfLAJU
         uvuJhjjRpHoBdtAV52R1kRbCvxBauk8h/d5w2HbF/PNkqsQWhTGOJu570iXVFQU1Nvgu
         kmd88ilnJS/bGBKSvfKyW+hyDuK5j6m2x9eE/h5QYE67QPav8eK350P69yd1vmqwQIzv
         oo+KyeL5xGlmoZ5/iVoKVLbtnZXYhagkm9WoWDYKUZ0ebMeoTFM6FbcmK8y6uNUY6c6K
         R07EMBo0pBKgP3f9cGyp6KUs8Zq8wVZhSqJVtt4MKEocPz5YAuph0VVdK1Xw/9OEUsq6
         9caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052684; x=1695657484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuWLNVcWzC6ASPZz9GEuSYcaG6pqUJBDXR7IC05cfLo=;
        b=L1zzwLF0qqN3LcvG81U4Ev2r3324fNGfZ3+RK+lH8ZKdDA2y00/Lhvjw9WUJg44U/O
         PRbUlE57YDeh0QEy8LBKCXvXRG6luyxjbd/9VVpOOYc69nQ1bdT/1DBqTff5G3PwU+uh
         IGONQMduVRLU7Dw0d5qg6KVdYzx0nhcFpohOwUJmMBcXxd7X52P8o4f+8VnAvSiLVamd
         s/+SSsARI5Cn+x+4N0lKk6tRvx3hQYbtaPJrPUMqXHPY8mQXzuYaXLgv4ZPYCdtr91C0
         V1tKCnZBDL11enaG1nqvghYo4BuaOW4JxSb+u7FEnt3wipOtOQd0IoROJ68VVhVIZqjg
         sGVw==
X-Gm-Message-State: AOJu0YzQVab9GZcbp5PGZOzLGfMIU5y2N4o8ogmUzcvhXafNfjVPE+bo
        Djxv/gXFG4ZOQPbV/+MrFGhP9w==
X-Google-Smtp-Source: AGHT+IFkwjfPBd2yc8mJTKncE3vqTaKfj1taiCNjhQjrYNC7gDR/8luatOeD/+/M95Nq3Fi20OUQWg==
X-Received: by 2002:a05:600c:3784:b0:3fb:4055:1ddd with SMTP id o4-20020a05600c378400b003fb40551dddmr7641400wmr.28.1695052683796;
        Mon, 18 Sep 2023 08:58:03 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05600c1e1200b003fef5e76f2csm3022438wmb.0.2023.09.18.08.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:57:59 -0700 (PDT)
Date:   Mon, 18 Sep 2023 16:58:00 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230918155800.GA2751287@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:51:43PM +0200, Niklas Schnelle wrote:
> Pull out the sync operation from viommu_map_pages() by implementing
> ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.
> 
> Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

This must be merged after "iommu/dma: s390 DMA API conversion and
optimized IOTLB flushing" because of the updated iotlb_sync_map()
prototype.

Thanks,
Jean

> ---
>  drivers/iommu/virtio-iommu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..3649586f0e5c 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
>  	int ret;
>  	unsigned long flags;
>  
> +	/*
> +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> +	 */
> +	if (!viommu)
> +		return 0;
>  	spin_lock_irqsave(&viommu->request_lock, flags);
>  	ret = __viommu_sync_req(viommu);
>  	if (ret)
> @@ -843,7 +849,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			.flags		= cpu_to_le32(flags),
>  		};
>  
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>  		if (ret) {
>  			viommu_del_mappings(vdomain, iova, end);
>  			return ret;
> @@ -912,6 +918,14 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>  	viommu_sync_req(vdomain->viommu);
>  }
>  
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1058,6 +1072,7 @@ static struct iommu_ops viommu_ops = {
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
>  		.iotlb_sync		= viommu_iotlb_sync,
> +		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
>  	}
>  };
> 
> -- 
> 2.39.2
> 
