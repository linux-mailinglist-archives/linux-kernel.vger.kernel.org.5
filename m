Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1680138E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379523AbjLAT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAT3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:29:24 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419710DA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:29:30 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d51e12369so3196685ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 11:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701458970; x=1702063770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKPTNfyUQ76RXlZglnCsaAsISjRqR/A1VMTCAWgJfNY=;
        b=Nso3cl83G/Ch6Hl8HGW/JuKIpD5Ga4UR549rm2uqOByW67PAjpjRezBSI2Jhe0JKlv
         lvdNitJ+umgO1ffMvKOv0gYPmAOnLYPMeyD7ozVHvVeq/ugRojdoP1Y6a/7HGYdC6UBs
         SzF73C4dEalGk957Uaxs2eqX1I5AyQPeUS6//Oyp+OoY41dXVlZrVd0ldLhxBGhN5jMi
         m+nEx/LCkRAT8RcyesAu1cFb4eUvlG96DoJ6zZJSXAqh7he7NAs0MJ0rkequNySvEyvC
         d3uQv7LtQeDWh0ozElO+/2gKn2nW8JhTE76mUzEXp33zUlYnUExDsHm8QZssbjwdVNaT
         ITSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701458970; x=1702063770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKPTNfyUQ76RXlZglnCsaAsISjRqR/A1VMTCAWgJfNY=;
        b=Om3Tx46lnCJIzcdFGnYiCe2V8LM9rJGHnLEiOogCpmdgkXaxUfmRd+3UGJ8blo14sL
         n06HPVkCZslx8dRGeh/q8pDCZuhKUQQXBdHVOIVV/dw6BSTEn202Ab8rrUbaI23wGxrK
         Inwb1+MYh1bNPkMZdZBrOhXDrccRxIiTxhuXDx2w5/vTqW98F5WSp+lHX/hRA7sHoN8q
         nYUbCDqgkMi8AiJFVf4/SoQxU3sgWGZaTb5WlkLBYYk7ENBYVkKj6VLndjq3MBjsNjLJ
         gVGz3Hxrk9Pbc7qdpEUgZ7S71xC6Bel6QYyCrjusCurSPKw1fWQyjQBFskyTAc6VhtCc
         8dmA==
X-Gm-Message-State: AOJu0YybAB6QREx7vUaXtKIjZUpG2ibUvoFH6mI0sc5OprXFZqVjbKbl
        mqxRkVtnG7elHRoxxvi+wPB3ziunKOZDvtm0qTw=
X-Google-Smtp-Source: AGHT+IFicvE4UTpgf7EEaTDeLovKnKQDD9u8jMl5SDOOOkrmTUmnQHfGJZN3OtHg/u3QSEBLkoWKEw==
X-Received: by 2002:a6b:6111:0:b0:7b0:3:6ac7 with SMTP id v17-20020a6b6111000000b007b000036ac7mr68941iob.16.1701458082221;
        Fri, 01 Dec 2023 11:14:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id dc30-20020a05620a521e00b00775bb02893esm1741124qkb.96.2023.12.01.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:14:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r98yH-006HtX-8r;
        Fri, 01 Dec 2023 15:14:41 -0400
Date:   Fri, 1 Dec 2023 15:14:41 -0400
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
Subject: Re: [PATCH v7 09/12] iommu: Make iommu_queue_iopf() more generic
Message-ID: <20231201191441.GE1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-10-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115030226.16700-10-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:02:23AM +0800, Lu Baolu wrote:
> Make iommu_queue_iopf() more generic by making the iopf_group a minimal
> set of iopf's that an iopf handler of domain should handle and respond
> to. Add domain parameter to struct iopf_group so that the handler can
> retrieve and use it directly.
> 
> Change iommu_queue_iopf() to forward groups of iopf's to the domain's
> iopf handler. This is also a necessary step to decouple the sva iopf
> handling code from this interface.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  include/linux/iommu.h      |  4 +--
>  drivers/iommu/iommu-sva.h  |  6 ++---
>  drivers/iommu/io-pgfault.c | 55 +++++++++++++++++++++++++++++---------
>  drivers/iommu/iommu-sva.c  |  3 +--
>  4 files changed, 48 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
