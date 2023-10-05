Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768377BA975
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjJESuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjJESuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:50:03 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE9E8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:49:59 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65d0b0e7798so6650576d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531798; x=1697136598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEUBHmO4oSTKiWUy3dq5rRvK6vcXZtKKFUQd3G4W35k=;
        b=I/Ip2O2S06O7N5FIET6cEGAmH/Tix2mxBOL8sEBcDoebkIt9hc62jrG+rouEwvJh1Z
         fS0v8yVCunhOEwN+bzPJDPTlidpTJsh7A1viUmlRJ6DJeDsTyngW5gbe9d6lBRGOJOzc
         tGOJvTElxrL+BM63EZ9Ke/QAg+00DTwCqIavENvo1X79WhAUoc5/ct0n1rd30Ya+rVHr
         /Ooq+iu6iqdVLmO3eQhUECkPP9eW4dWj2kF7SNtOMXA2HVQYTFDpihhlMHnB9v3jMSv2
         1jazoKnfCAtFDjqvwhPdPbTLBdVIwk5RwpGkzOzuBhKB8SqcBfhfo5XJymTRjkt5ZjMX
         pomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531798; x=1697136598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEUBHmO4oSTKiWUy3dq5rRvK6vcXZtKKFUQd3G4W35k=;
        b=o4Pt8E/jjPGcOSiUxgXRifB0JfghFftMYPUj/vDkNwpPGnWa1BpulhNz6Goq4ekyg2
         TJbJT/eX2aT3cFlw1wA4rHgdBR8lcuSpzLL1c+qJRaqlqmPvVWs2lNiBs2FNzB11qK2X
         HKpXdQLiYHwZ+sjNH2seDowfG+d5FxL7QHkejdEEfeTayUMBWwx/hZFdd8Jq7u8mJTFD
         imQj7K1lliDJUzjWdlBP6TdoocBx69PRzikT3fx/Dw1vwc3sqABa0yH23iJQbVHxedFT
         lgfwV9vyGc9zZVsvSMkaU6/M2D11LPDFlQhjj7cllkYM9YlcVf/bWmwooXDXszoanOdL
         P2hw==
X-Gm-Message-State: AOJu0Yy4sTItCrJ3Swe4SE8g1EULLfhzAqAIQw4wzOtiwhFGEXYegkRj
        ZmhVZLbyYbISWmBGuwAoCyInPw==
X-Google-Smtp-Source: AGHT+IEYC20BC1N5PA3gTmAKCxQySylj6S2PPzcS+TN9Nf4nkusD/9nv9hcsp7t8uHVeZNgRY2U4TQ==
X-Received: by 2002:a0c:b312:0:b0:65d:6665:b422 with SMTP id s18-20020a0cb312000000b0065d6665b422mr5136260qve.33.1696531798420;
        Thu, 05 Oct 2023 11:49:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id i9-20020a0cf109000000b006263a9e7c63sm691247qvl.104.2023.10.05.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:49:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qoTQ5-004Z83-Dw;
        Thu, 05 Oct 2023 15:49:57 -0300
Date:   Thu, 5 Oct 2023 15:49:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20231005184957.GV13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-6-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-6-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:38:12AM +0800, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when no one is using it (the reference count is decremented
> in iommu_sva_unbind_device()). However, although sva domains and their
> PASID are separate objects such that their own life cycles could be
> handled independently, an enqcmd use case may require releasing the
> PASID in releasing the mm (i.e., once a PASID is allocated for a mm, it
> will be permanently used by the mm and won't be released until the end
> of mm) and only allows to drop the PASID after the sva domains are
> released. To this end, mmgrab() is called in iommu_sva_domain_alloc() to
> increment the mm reference count and mmdrop() is invoked in
> iommu_domain_free() to decrement the mm reference count.
> 
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
> 
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
> 
> Change in v5:
> - Use smp_store_release() & READ_ONCE() in storing and loading mm's
>   pasid value.
> 
> Change in v4:
> - Rebase to v6.6-rc1.
> 
>  drivers/iommu/iommu-sva.c | 40 +++++++++++++++++++++++++++------------
>  include/linux/iommu.h     | 18 +++++++++++-------
>  kernel/fork.c             |  1 -
>  3 files changed, 39 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
