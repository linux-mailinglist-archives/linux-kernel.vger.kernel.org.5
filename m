Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6377A4E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjIRQJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjIRQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:09:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282D51725
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:07:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so3255329a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695053255; x=1695658055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XBJAiGdnAah6NYpzFbKj5jrg8y8Zyfvfwd8mgzKL8c=;
        b=H4UpiqPzfyvXr97SLf8o+5vIjJVe8cxFtfkGAQjNaVK9C63NnYrF/Ibrhw5Ar3Jq9Y
         oMxY7ehGxxnnYag0MY10sIgRNG0W7V7Wmn6f7McCiM/56QRDjZOdLivL/nE/DfPfZCHv
         hXOFOpwvxZ4SjuBIAemFri7fwu7xbXC9SaAB7C+ZxBV2SV8s7mq4nFmXekaPfR5WWrD0
         VxE2xb4uVV8vnqTFb+78fOKf3fQmTUOPvztoX9f76VkR5nvNqKltpZl5x3fRCwgR9ClO
         Qp4LAcafiDcXHN0RiriFbu/f0r9kNgxF7P3nV+CpeZJyITnObQ9tXrSqVKi3rpu00MP9
         6Hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053255; x=1695658055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XBJAiGdnAah6NYpzFbKj5jrg8y8Zyfvfwd8mgzKL8c=;
        b=cdwPKiptKgSxchfujWsfbk4F8B3528J8cTM/AOOuvkMEH4LFa9VCoIATBSZfAAZdXe
         3OVp5ZwKoAVrDzans9cJyQwfEbrmj1ROPNW6j1VAiFaAbe7F9y5SYIFYHVPbNpe6Ubpu
         ZfCd51FcAypa8lk2lSFlysJbG5ICb0VKZZblScl6bEQJYQeddPySxE/MoGxIQh+b56ip
         AMPYscRzlybAYqOdPb9UEQEvakfbCOPI6UxUkOegnvil2jOEP4KyYMJIH2GE+ocWhsoO
         Fpe3QDDFDRL1X54VScIDgNOmbsm4GovX3Xy/VTG1ec3+dEV7mgKgvV/bD5SIdu2gUfel
         ZgIg==
X-Gm-Message-State: AOJu0Yw+d//CV57uksZ+91sLna8MOLYU6f031RU+C2Vbe94/ZFUw4DA1
        GRIxFTMF+Nbru2rbe8onvF23mx22l5DLjYUJKyw=
X-Google-Smtp-Source: AGHT+IGKCbH5H/HzgTN4rOlc0G7gV3sYCmmjllMp3MZ0mg9AwdHJzCYa0YtI/bnTzf2Hxk/+Rx6GTQ==
X-Received: by 2002:a5d:56ce:0:b0:314:1230:29b0 with SMTP id m14-20020a5d56ce000000b00314123029b0mr8616133wrw.52.1695052748670;
        Mon, 18 Sep 2023 08:59:08 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b00402c0a8a084sm15481477wmk.17.2023.09.18.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:59:07 -0700 (PDT)
Date:   Mon, 18 Sep 2023 16:59:11 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Message-ID: <20230918155911.GB2751287@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-2-f33767f6cf7a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-viommu-sync-map-v2-2-f33767f6cf7a@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:51:44PM +0200, Niklas Schnelle wrote:
> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> dma-iommu deferred flush scheme. This results in a significant increase
> in performance in exchange for a window in which devices can still
> access previously IOMMU mapped memory when running with
> CONFIG_IOMMU_DEFAULT_DMA_LAZY. The previous strict behavior can be
> achieved with iommu.strict=1 on the kernel command line or
> CONFIG_IOMMU_DEFAULT_DMA_STRICT.
> 
> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3649586f0e5c..4dd330fbcbdd 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -926,6 +926,13 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>  	return viommu_sync_req(vdomain->viommu);
>  }
>  
> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1051,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -1071,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
>  		.map_pages		= viommu_map_pages,
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>  		.iotlb_sync		= viommu_iotlb_sync,
>  		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
> 
> -- 
> 2.39.2
> 
