Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A514A7AD921
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjIYN3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjIYN3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:29:50 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C07E10D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:29:44 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65afac36b2cso15456986d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695648583; x=1696253383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oga/n0wXfl4psvEJuTUVdx2OlpRGQg6ZYgAQVtMIKuE=;
        b=U6JmnXhfE2Zak3TeDX3A3OoRhuIcjPiquZX6jNTUn6aPFki160vBGExjCXvUulqCuQ
         krl+QMFwCaqkJu3K6teC+RxVn8VbtiVNWMQ+s3ZwAkDvA3nBmLQshwxtDTeKHfUt6kRV
         Foyh63M55JWbIgpHTr1PZ/7yYguHecEAbDoC3Wt8+wAbk/WDzYoGqBR/Y6BrhiffeQ8u
         CU3tHGnp8QOctkW+H6INMc7EukeQUFxZvfRR6bWPM6t6nziMR06CAg7URf0UN2ALDTJz
         B1iLRRA3MaSBtmXH930JqrIkJayvru0fU/McYaOXvpjyNyYpDGuV5qjANluoRkqtfhC1
         PoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695648583; x=1696253383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oga/n0wXfl4psvEJuTUVdx2OlpRGQg6ZYgAQVtMIKuE=;
        b=BLAil3duDO59AD9Z34voA3xpkMHS3UEvfI3BaXLPhb41RetFxK5bBF+vPcrp9tbs0i
         eZYSYatp/xUrGtzNW89G/sJ+PzSyGuHYbAou6wB7/wjm+EDI76/MSCFOE9HNkHVADL9B
         6s6miNlrToXLnmesAd3srS8JbBcWX4TerP+RvOo7vOoag8xlXBZ6860+bJMSztBbnMvu
         bRzMzIRpfknw0ID4g/9VBpsvBRz6m3KGg8mVxf4vWzT38AsR3wsId6OPXGs/caT42sIk
         loLfpHqXbMaRKxGkoJtYDZKZwHsbtfWWl8Br5hus3PVwdhLZt97k2DjQYRTiuGeyJuN1
         f9NA==
X-Gm-Message-State: AOJu0Yzl76HMScoiWEGpTXNVw2IP9APwm7CAxGYvDv35tjwyhbSl86+4
        VX5/MfNTit24G8Ln9eSAjNi6hA==
X-Google-Smtp-Source: AGHT+IEKfw0t5lrzqptyLs66b/Idloen/u4q+DsYXXRRj02Iy22p185Epb13OQZKjHg6eVfFlxN1qg==
X-Received: by 2002:a0c:f14a:0:b0:65a:fd46:c464 with SMTP id y10-20020a0cf14a000000b0065afd46c464mr3996185qvl.33.1695648583234;
        Mon, 25 Sep 2023 06:29:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id u17-20020a0cf1d1000000b0065b1f90ff8csm155250qvl.40.2023.09.25.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:29:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qklef-000rby-UV;
        Mon, 25 Sep 2023 10:29:41 -0300
Date:   Mon, 25 Sep 2023 10:29:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230925132941.GK13795@ziepe.ca>
References: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica>
 <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
 <20230922233309.GI13795@ziepe.ca>
 <ade90cd5-bbf1-f4f9-0511-75e0e18d1a83@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade90cd5-bbf1-f4f9-0511-75e0e18d1a83@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 02:07:50PM +0100, Robin Murphy wrote:
> On 2023-09-23 00:33, Jason Gunthorpe wrote:
> > On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:
> > 
> > > virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
> > > either; it sets it once it's discovered any instance, since apparently it's
> > > assuming that all instances must support identical page sizes, and thus once
> > > it's seen one it can work "normally" per the core code's assumptions. It's
> > > also I think the only driver which has a "finalise" bodge but *can* still
> > > properly support map-before-attach, by virtue of having to replay mappings
> > > to every new endpoint anyway.
> > 
> > Well it can't quite do that since it doesn't know the geometry - it
> > all is sort of guessing and hoping it doesn't explode on replay. If it
> > knows the geometry it wouldn't need finalize...
> 
> I think it's entirely reasonable to assume that any direct mappings
> specified for a device are valid for that device and its IOMMU. However, in
> the particular case of virtio, it really shouldn't ever have direct mappings
> anyway, since even if the underlying hardware did have any, the host can
> enforce the actual direct-mapping aspect itself, and just present them as
> unusable regions to the guest.

I assume this machinery is for the ARM GIC ITS page....

> Again, that's irrelevant. It can only be about whether the actual
> ->map_pages call succeeds or not. A driver could well know up-front that all
> instances support the same pgsize_bitmap and aperture, and set both at
> ->domain_alloc time, yet still be unable to handle an actual mapping without
> knowing which instance(s) that needs to interact with (e.g. omap-iommu).

I think this is a different issue. The domain is supposed to represent
the actual io pte storage, and the storage is supposed to exist even
when the domain is not attached to anything.

As we said with tegra-gart, it is a bug in the driver if all the
mappings disappear when the last device is detached from the domain.
Driver bugs like this turn into significant issues with vfio/iommufd
as this will result in warn_on's and memory leaking.

So, I disagree that this is something we should be allowing in the API
design. map_pages should succeed (memory allocation failures aside) if
a IOVA within the aperture and valid flags are presented. Regardless
of the attachment status. Calling map_pages with an IOVA outside the
aperture should be a caller bug.

It looks omap is just mis-designed to store the pgd in the omap_iommu,
not the omap_iommu_domain :( pgd is clearly a per-domain object in our
API. And why does every instance need its own copy of the identical
pgd?

Jason
