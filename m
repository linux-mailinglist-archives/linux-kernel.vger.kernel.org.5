Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECC7801372
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379491AbjLATMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbjLATMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:12:45 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3FF7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:12:51 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b896a0aee5so418548b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 11:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701457971; x=1702062771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I2OeVOQrD9mA7MkxNCDuZeDEn1PaLfVovbPcfbgEPHs=;
        b=d+MbPAH1gv8Opyk4wwzirEoY/dTUvpOTLTvZoFN/frUjcdvyix8EQ0nr2zr4dt5WkU
         YnyMVLvxYXXwM2GgmAjpMExKFaOd5aN0mtN/g/IEt/oc36sXcQSUgjNkkOiULIYDZ8ji
         Tu7GT5v1IO/w0gaIflyMlEDYnpJB2StUX+vJrv/lkp83Vx6ad5Nn6DIE+Ygvpc4xKkgs
         Hy0EGHKxX2iwnRWyhjv9u66dNRM2rz4TplAp+MHzk1bMeEHpsHqt2aRR0EO/tI1I3d6i
         PPsDy9sNH36DgCwRvGCkCZ0lmhprhJq70j8CD0ZNSDC2xRsjXgp2InDpoJh4O3FzFJ7A
         uIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457971; x=1702062771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2OeVOQrD9mA7MkxNCDuZeDEn1PaLfVovbPcfbgEPHs=;
        b=exWZ/1roaBvWo2goDzGcl4sL65/QL2VQktiOno5Q8hbdWXHhmDaHkQgE0YG8LzX0cl
         Doz9ntT3PCxrpmfxvgFzLgFE/Tqp9I18IhrPdsh9KXaapPXnIpLvNp5OEfFaMYq2aqum
         g4SvVVhYubAjEeb3OGgQfX8dyE/cDJxSiLlfK9FcfXfrt4F2b/VoEdZgwX7FJFkTvyRA
         CqwVOg1nXWAElvNuNxJoMjaBPh1EnhuB3bkWIdYSrlPfu+LiaJKuEn6jG71JLE/RKgA2
         2XkRK4vRfiaL4XrwfBxiOY2WKDfte4Vu9OpV/kew+YE94t+238XWq24rCUnBfAjahFf7
         jdlQ==
X-Gm-Message-State: AOJu0YxzIw/HFnX62FJHizzxrrcCBO7yD6ZCNW+//OtuDAfp7fGVcAyJ
        TtK7I3oXEYXl6uVq4drbYhSXZe0br6assWmsW+s=
X-Google-Smtp-Source: AGHT+IEQWhwo+YQs87zSg16Es/DvsBvlD+J/VYbJsutxQ5RoA/cQ603E7sqNxOjxpSBkuubb9x+1Iw==
X-Received: by 2002:ac8:7f8c:0:b0:421:b323:bffe with SMTP id z12-20020ac87f8c000000b00421b323bffemr88819qtj.10.1701457750139;
        Fri, 01 Dec 2023 11:09:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id w2-20020ac87182000000b00423de58d3d8sm1731502qto.40.2023.12.01.11.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:09:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r98sv-006Hqv-2W;
        Fri, 01 Dec 2023 15:09:09 -0400
Date:   Fri, 1 Dec 2023 15:09:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/12] iommu: Merge iommu_fault_event and iopf_fault
Message-ID: <20231201190909.GD1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-8-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:02:21AM +0800, Lu Baolu wrote:
> The iommu_fault_event and iopf_fault data structures store the same
> information about an iopf fault. They are also used in the same way.
> Merge these two data structures into a single one to make the code
> more concise and easier to maintain.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  include/linux/iommu.h                       | 27 ++++++---------------
>  drivers/iommu/intel/iommu.h                 |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 +--
>  drivers/iommu/intel/svm.c                   |  5 ++--
>  drivers/iommu/io-pgfault.c                  |  5 ----
>  drivers/iommu/iommu.c                       |  8 +++---
>  6 files changed, 17 insertions(+), 34 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
