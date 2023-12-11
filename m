Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C2980CED9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjLKOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjLKOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:50:19 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D858CD0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:50:24 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77f70206016so86781585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702306224; x=1702911024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zY0//tl2g5UpTN9HNsgH35wUdWi0GHrJKuCe+zbVGE=;
        b=Xjc7iupaamSqycEZxtXjRUpda9bS7qh8w9aLQI6uJQc97vVtsKr4ORiBvDdeB34D79
         QP7QZpyXgVHbZIMK9rnqj0cWCf0+IOFkPDLoxMWly0n7IENTEeqCBPFT4FvAJNk7v9+T
         KKuagUDwlA3CLi8mC6jkTvZ9S+WvcLKKJYXakUl/Y9b7x93IJdQrtzyBXXzXHB8Wh5Db
         KWDTvXbDE2Tbszg8oVrHLK7S4rOQD+VuTu4opvjxwVcZbT1nzEmcTv6XNZJzriGyVr3P
         X9Bd9XBEdaSf17vsPXxRA555BZ4QW73G1w2yq2TOjLK0MOuGkKHsnFvI7Dw69tX41neG
         IfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306224; x=1702911024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zY0//tl2g5UpTN9HNsgH35wUdWi0GHrJKuCe+zbVGE=;
        b=HoqvU1KbdQE2ubyavgdpsWW7mCYOIBCMeNl9tWHuJ3Ml9lZc31lL20t7am4kQkceGN
         HAOlCLo/u3KDshyZJm9MgPX2cfXDwmNeiJJ1ywujOYZiCCSAdq8VtyWJjBVUc5g/LV2V
         6h7PCdUHulrKGVwn1NvQNZ+51fqTIXcyp4liGthkyKjUWQVY8ZDCdzP2w2MhhFY11NTU
         B4OpzaduVim6I/hcGDw6LYGnv/VEQi73AAWLIP44UEY3xBdyK/JV3ICVakOFmihv8M9L
         CB8gpWskg5q4BLjWSlxY6n8Tfek126wUCDIiwsRaG3JVF+KGaxg60NVKYb+e+12gogcW
         rMsw==
X-Gm-Message-State: AOJu0YwRcqpFfCWi8l26JWy4wM+f0+PxhZJF/xHJYxTvT+ECdnTE5Brn
        USuUGsSu0DpU9O/AKODPj3jV5W0tMVEbpfygOzk=
X-Google-Smtp-Source: AGHT+IHGkLg/syuCG85iyYo/XNSnvoZo038HyAe/rHk+Y5RIFg9FCabNPYR9leNiDmLw0NWrT9WPlw==
X-Received: by 2002:a05:620a:36f1:b0:77f:7898:8a73 with SMTP id cz49-20020a05620a36f100b0077f78988a73mr1500354qkb.6.1702306223919;
        Mon, 11 Dec 2023 06:50:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id a10-20020a05620a124a00b0077d78c5b575sm2956728qkl.111.2023.12.11.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:50:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rChby-00Cbmb-Rh;
        Mon, 11 Dec 2023 10:50:22 -0400
Date:   Mon, 11 Dec 2023 10:50:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] iommu: Refine locking for per-device fault data
 management
Message-ID: <20231211145022.GZ1489931@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-12-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207064308.313316-12-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:43:07PM +0800, Lu Baolu wrote:
> The per-device fault data is a data structure that is used to store
> information about faults that occur on a device. This data is allocated
> when IOPF is enabled on the device and freed when IOPF is disabled. The
> data is used in the paths of iopf reporting, handling, responding, and
> draining.
> 
> The fault data is protected by two locks:
> 
> - dev->iommu->lock: This lock is used to protect the allocation and
>   freeing of the fault data.
> - dev->iommu->fault_parameter->lock: This lock is used to protect the
>   fault data itself.
> 
> Apply the locking mechanism to the fault reporting and responding paths.
> 
> The fault_parameter->lock is also added in iopf_queue_discard_partial().
> It does not fix any real issue, as iopf_queue_discard_partial() is only
> used in the VT-d driver's prq_event_thread(), which is a single-threaded
> path that reports the IOPFs.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> Tested-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/iommu/io-pgfault.c | 61 +++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
