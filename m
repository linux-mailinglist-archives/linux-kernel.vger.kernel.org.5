Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7B7AB24D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjIVMlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjIVMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:41:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EC5196
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:41:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-770ef334b4fso116325285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695386491; x=1695991291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9+4wg+HvQjn8Tza5j/+95ICGHkpfpV9B3BnmaDCax4=;
        b=d//4Qh6dyRMHDT2g3a2N5iIfX9jlopGuQ61+rZgBB8FF+q+v0cr+VTI+forR984D1/
         BpD5yt7BmRoI37xoJnKDKKSIdLJ+eYOxn+sLuUwpAY2yy8EOHi7M7cG6M550SjwPzwpa
         k6LxrcEhQ/P4FqMYplmzhDqJALc3scCe7jJVfjtHWlk/kyfbZJS/U886XB355ZkJtAna
         CYU8rjONRXz0RwIy1fBtg3yPviw+lR4BU7nlDATO6gP4TiJqiRdfN28fDrDyLWzjJmOF
         1GRQ3wSoUK5d3gd4jhBYdidd5ARgdH3ZBARg7PSF52N2trQOvkoy5lkB+xEhaggYLev+
         oE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386491; x=1695991291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9+4wg+HvQjn8Tza5j/+95ICGHkpfpV9B3BnmaDCax4=;
        b=TkSUtVPxHQs848PA2DYFFzL4eImj8ZIthaDetgpfoZItGR4s/+tjOzqsSjVw969OBN
         Fz4ZR41RRvMoNc3YidLNZ0jeFMomcWwT9Ri8ZrhRMiBuK82vaZi6bOuA1xMxW1jguGeg
         XxjrCJYWh3bqMI67mcecca40NEVgk7VEBr4jNJfmlSB269AFL+vuHJX6kCGS/D/FnDXf
         SCP1IoxGUvkvOcwFcvqMYPeTA0ilYqh+XKqS1W9jKPIXNUfNRJzbCA3bykMEpimby4+y
         4XPjSVjwDk09Xbna4K33pyLKyZfLx/SCloY0jC6nRHVj2zqX9OtWpR55uZoprkWlVL7c
         oHQw==
X-Gm-Message-State: AOJu0YwXgQiKeWWOq9QvPlVK2L9ZRwds3wmvEDbEi81xlr+IQNJmExXJ
        nAmgoaU0+NMuTYQk7hItrZRQdg==
X-Google-Smtp-Source: AGHT+IHZUGi7eIWQUvwurrjhwZAXvsjOtNC1C38Z7pyQadDkGDO1CCUf1Jp9zTCAUl/T8vTtva0wOQ==
X-Received: by 2002:a05:620a:371e:b0:767:e994:ff03 with SMTP id de30-20020a05620a371e00b00767e994ff03mr2794453qkb.15.1695386491706;
        Fri, 22 Sep 2023 05:41:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id p13-20020a05620a056d00b007740c0e52edsm1209968qkp.89.2023.09.22.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:41:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjfTO-000Y4I-9h;
        Fri, 22 Sep 2023 09:41:30 -0300
Date:   Fri, 22 Sep 2023 09:41:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922124130.GD13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922075719.GB1361815@myrica>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 08:57:19AM +0100, Jean-Philippe Brucker wrote:
> > > They're not strictly equivalent: this check works around a temporary issue
> > > with the IOMMU core, which calls map/unmap before the domain is
> > > finalized.
> > 
> > Where? The above points to iommu_create_device_direct_mappings() but
> > it doesn't because the pgsize_bitmap == 0:
> 
> __iommu_domain_alloc() sets pgsize_bitmap in this case:
> 
>         /*
>          * If not already set, assume all sizes by default; the driver
>          * may override this later
>          */
>         if (!domain->pgsize_bitmap)
>                 domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;

Dirver's shouldn't do that.

The core code was fixed to try again with mapping reserved regions to
support these kinds of drivers.

Jason
