Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC84B793D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbjIFNUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjIFNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:20:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E190B10C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:20:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so3076575f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694006427; x=1694611227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ki5Uz9CgdK2xnF6/l+CWE0oH9syB5MP3FWtLwILQp2g=;
        b=XZQnf+Lw/oXzsjg/tbZm7UoKgi9qT6J1jl4/6nmys1YX85H5uqFJXk2UlKpIOpk814
         /5+/MNFPzJVxF9MGnOgiJMWOeyUmmJBR97m0prjPL6KdH6/rtK5BGZtoXTDZmqb/dnn6
         /o2pOSpbXtSDAgL4n7F7ibuhf417RKfQ1KUloycmZnkG0czRtQxfxVoxWeHsCjWsDr9j
         IJWa+7ZEKjn/tl8rMOfFc8XD2TWLfexhGSBaEuApc9+ukxv5C6J+7n2fJLe1rXM8jMuS
         p6fk0q13yHPHsHCJOi8e7FCn7yTP6egewA8xJNDXt8MniaDhfzrI6CFGfq4U8lG98YTa
         BFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694006427; x=1694611227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki5Uz9CgdK2xnF6/l+CWE0oH9syB5MP3FWtLwILQp2g=;
        b=MrkglCkjSHyrBONyviCfV4rLXBh7UWXJdGrAf8/Nqs2Ao1ajmjt+wuAEnhYA+tdEFQ
         LJMEAuQ7HJSutJk19hLR4oWpLcYewWUSlOcL2wxTOmyp9DbtYJGGlI5i3VZb8Nv3/sWp
         7qOOG+mhijKtz6+FCbDEvRdYPOP/HrmQgLoyGrVDCbWecbi26R4jwW7zSn23dNP3QS71
         AlQW4Z2mCh7YsFVa9x/mQvWVeUlIB8gPAK+LZIGRMbtI93y+XYeijZZ5hKMU9gJsTu0h
         3AkS7YNRbkkkZTwd23b2gyisjMAOiS30KXxGh4PzhFLwGWa2KXE4ghEGJsyO46+BRuNJ
         kXWQ==
X-Gm-Message-State: AOJu0YxDUap93tzDibBQW5sORMKYPRzs3pL/glvSO31ickxIT1ml2Q/Q
        j5dYJuBuKgssMTly8d5sxh8nQw==
X-Google-Smtp-Source: AGHT+IF4QWUQBcbeoUunoq7LEw1J08TG+zpBXE6UdNmhDhLqyVBkWUYDBW6gzLZzNF7OF2sRejDSKA==
X-Received: by 2002:a5d:574c:0:b0:317:55c:4936 with SMTP id q12-20020a5d574c000000b00317055c4936mr2512131wrw.9.1694006427137;
        Wed, 06 Sep 2023 06:20:27 -0700 (PDT)
Received: from myrica ([2.220.83.24])
        by smtp.gmail.com with ESMTPSA id x16-20020adfffd0000000b0031c8a43712asm20541623wrs.69.2023.09.06.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:20:26 -0700 (PDT)
Date:   Wed, 6 Sep 2023 14:20:31 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Message-ID: <20230906132031.GA1528947@myrica>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
 <20230904153403.GB815284@myrica>
 <f1259993-2419-9c9e-30d3-0631ef938679@arm.com>
 <ba38b6d90e1f24f249ed8a18e65c403be6ff90e9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba38b6d90e1f24f249ed8a18e65c403be6ff90e9.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:55:49AM +0200, Niklas Schnelle wrote:
> On Mon, 2023-09-04 at 17:33 +0100, Robin Murphy wrote:
> > On 2023-09-04 16:34, Jean-Philippe Brucker wrote:
> > > On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
> > > > Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> > > > dma-iommu deferred flush scheme. This results inn a significant increase
> > > 
> > > in
> > > 
> > > > in performance in exchange for a window in which devices can still
> > > > access previously IOMMU mapped memory. To get back to the prior behavior
> > > > iommu.strict=1 may be set on the kernel command line.
> > > 
> > > Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
> > > well, because I've seen kernel configs that enable either.
> > 
> > Indeed, I'd be inclined phrase it in terms of the driver now actually 
> > being able to honour lazy mode when requested (which happens to be the 
> > default on x86), rather than as if it might be some 
> > potentially-unexpected change in behaviour.
> > 
> > Thanks,
> > Robin.
> 
> I kept running this series on a KVM guest on my private workstation
> (QEMU v8.0.4) and while running iperf3 on a passed-through Intel 82599
> VF. I got a bunch of IOMMU events similar to the following as well as
> card resets in the host.
> 
> ..
> [ 5959.338214] vfio-pci 0000:04:10.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0037 address=0x7b657064 flags=0x0000]
> [ 5963.353429] ixgbe 0000:03:00.0 enp3s0: Detected Tx Unit Hang
>                  Tx Queue             <0>
>                  TDH, TDT             <93>, <9d>
>                  next_to_use          <9d>
>                  next_to_clean        <93>
>                tx_buffer_info[next_to_clean]
>                  time_stamp           <10019e800>
>                  jiffies              <10019ec80>
> ...
> 
> I retested on v6.5 vanilla (guest & host) and still get the above
> errors so luckily for me it doesn't seem to be caused by the new code
> but I can't reproduce it without virtio-iommu. Any idea what could
> cause this?

Adding Eric in case this looks familiar.

I don't have hardware to test this but I guess QEMU system emulation may
be able to reproduce the issue since it has an AMD IOMMU (unmaintained)
and igb, I can give that a try.

Thanks,
Jean

> 
> > 
> > > > Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >   drivers/iommu/virtio-iommu.c | 12 ++++++++++++
> > > >   1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > > index fb73dec5b953..1b7526494490 100644
> > > > --- a/drivers/iommu/virtio-iommu.c
> > > > +++ b/drivers/iommu/virtio-iommu.c
> > > > @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> > > >   	return viommu_sync_req(vdomain->viommu);
> > > >   }
> > > >   
> > > > +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> > > > +{
> > > > +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > > > +
> > > > +	if (!vdomain->nr_endpoints)
> > > > +		return;
> > > 
> > > As for patch 1, a NULL check in viommu_sync_req() would allow dropping
> > > this one
> > > 
> > > Thanks,
> > > Jean
> 
> Right, makes sense will move the check into viommu_sync_req() and add a
> coment that it is there fore the cases where viommu_iotlb_sync() et al
> get called before the IOMMU is set up.
> 
> > > 
> > > > +	viommu_sync_req(vdomain->viommu);
> > > > +}
> > > > +
> > > >   static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
> > > >   {
> > > >   	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> > > > @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
> > > >   	switch (cap) {
> > > >   	case IOMMU_CAP_CACHE_COHERENCY:
> > > >   		return true;
> > > > +	case IOMMU_CAP_DEFERRED_FLUSH:
> > > > +		return true;
> > > >   	default:
> > > >   		return false;
> > > >   	}
> > > > @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
> > > >   		.map_pages		= viommu_map_pages,
> > > >   		.unmap_pages		= viommu_unmap_pages,
> > > >   		.iova_to_phys		= viommu_iova_to_phys,
> > > > +		.flush_iotlb_all	= viommu_flush_iotlb_all,
> > > >   		.iotlb_sync		= viommu_iotlb_sync,
> > > >   		.iotlb_sync_map		= viommu_iotlb_sync_map,
> > > >   		.free			= viommu_domain_free,
> > > > 
> > > > -- 
> > > > 2.39.2
> > > > 
> 
