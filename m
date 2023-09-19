Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E657A5C40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjISIPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:15:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47919FB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:15:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-307d20548adso5190890f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695111313; x=1695716113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9DuA2m46Djcdz3icf/RXjOs6wp73S2oIUkhIKRMWaU=;
        b=sofp/OZ/7SMWIEHxYsDGI3oOAkBPbBgeokjvTJlNt72E/e3Dy/VJBBw/88V/0fj2Eo
         0F+0Hn8wH3rxuykUDfhbOWhl5/Ku2Ubmjn/8ygIcUHXjjCaCPMq56Pgv/JOwDKoznesk
         fTj/YmSZMTUgjABPO/LDhsbmA4za6HRW1E86iwDDl/oaIosQRWUMZb1ku0+0rIr2UxQc
         mmiIrDm3WRsZZEdFhM466ePt/gV/6V+2A3UHGcaye8dhmrh4IJ43rCunEKv7QQo9xbBi
         rXMVb2yY67SW70oArXMdIoWDUec7uRruvTlVZsq0U0HIlr3M4+8rc5rVqXAfzshetCkN
         odHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111313; x=1695716113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9DuA2m46Djcdz3icf/RXjOs6wp73S2oIUkhIKRMWaU=;
        b=qffUb/um2Hh0bykwrkxSpVxtOzyAPmpSWgp+Tfj2Qbs50BA0VqqIMvLtraE7PxgeDr
         tjdZHMBbiv5jpBhOpE73EGE6g9jGd7MtQh8pqvDXKLnNDOQ5N3Jx0vLWuziYkO8fsZEb
         H4jNijSNaRj7/w3CEULKIneB2d8441lsZBbH0+56XbY0CXi/RpUxXsKJsWPJZvvoMjzG
         h2FZ9HJflZJF0BK2uE7TvYJMdb93QGPw7dq7OaKVsIngk5QmSPX+5ePTN5XXuaqYj3Vr
         Ft7ZKoli/MM9V8XsDsfJvbjaUHndsGPoepw4/bEBFeauGFv6QhqMOJWrJjarHC1eIENc
         LR2A==
X-Gm-Message-State: AOJu0YwmebrhvI+Q6/XxpUn39zmXkjW6ZginqLyCUi6qUdO7OnTETgMG
        Qef4iBy/xmh9CS2doH77ckQV0A==
X-Google-Smtp-Source: AGHT+IFGBTaGE4GEoHpdTwySnKUr0nW2LPy/soxU/asQgYmN8W5lJXq9nrjAyrswMLLRTbyUplW17Q==
X-Received: by 2002:a05:6000:1865:b0:31f:f8c1:f43c with SMTP id d5-20020a056000186500b0031ff8c1f43cmr11762566wri.41.1695111313622;
        Tue, 19 Sep 2023 01:15:13 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d4a90000000b0031ffb51f6f9sm10302003wrq.30.2023.09.19.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:15:13 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:15:19 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230919081519.GA3860249@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 17dcd826f5c2..3649586f0e5c 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> >   	int ret;
> >   	unsigned long flags;
> > +	/*
> > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > +	 */
> > +	if (!viommu)
> > +		return 0;
> 
> Minor nit: I'd be inclined to make that check explicitly in the places where
> it definitely is expected, rather than allowing *any* sync to silently do
> nothing if called incorrectly. Plus then they could use
> vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> (it did take me a moment to figure out how we could get to .iotlb_sync_map
> with a NULL viommu without viommu_map_pages() blowing up first...)

They're not strictly equivalent: this check works around a temporary issue
with the IOMMU core, which calls map/unmap before the domain is finalized.
Once we merge domain_alloc() and finalize(), then this check disappears,
but we still need to test nr_endpoints in map/unmap to handle detached
domains (and we still need to fix the synchronization of nr_endpoints
against attach/detach). That's why I preferred doing this on viommu and
keeping it in one place.

Thanks,
Jean
