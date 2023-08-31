Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC378F19B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbjHaRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjHaRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:01:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B04CF3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:01:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc63ef9959so8244475ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693501311; x=1694106111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VCi4bsgMLCW5dXzntYC1D0i23asCQu6e0By0WrBIZ7I=;
        b=Zl7+qMNQ6seMnyZzbvEFlaUEEoBGBeA5EiZz30VuDm0PuqWGI6dPFi7fF1D0fjvNUx
         R6pDkZ3ChqIALn+bpD6LE6OOAMdfiTGuhzro+G/+Zhs1sW3GSZxvvyvVxvXXVcuNqRRR
         aTR6HCGcN787Wj+u8wnoAjfGfv2dYtPtZC+TLC3HS5MNccf0MUn56+h7vco6tK6eGioO
         xesM/lJP1RlfZYAAZem/ZM63OMZ/W93zr61w2LqCe8DWpCG8Zb+nTHwLJvEPyo1ZFaBK
         0r5ZP+B7PD9CmAOAHxCnA7zDANF5UJjLhDdfuXtXwex06+XjiRNHgOpbSQHVqAw/HCQd
         32Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693501311; x=1694106111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCi4bsgMLCW5dXzntYC1D0i23asCQu6e0By0WrBIZ7I=;
        b=ERmK0TVVflZqclhYzQPKnt0E7tWHSpTfJLTDq0aQuBZhEytYRKlxm8X9qyS3OCUHmo
         qgUF96LQixoT6cxtw9DedAcq2+bin9mYRB0tbuEBsoPsQhF6PweZCH60sbDI2wHbOTiS
         qORl6yMHXNYS7fNN28RRN4qDntRZ4CgASqDTDjfm+DkqiZj+3XJuhzL1BcEwmouZQlJw
         Cs4tYHKkCq+rygaaAXj5NRv57AN/MBSFdzODE7Zk/2dDYBCZvjcPzvPRkriKpQqy2r8/
         HcxcdN8+UtGiVT3a7nGvV/QyaxrWEON7zFYEWKt+xNALoHnNkO/CJcInPsVaycrdA9iv
         pOLw==
X-Gm-Message-State: AOJu0YwQIfz98EhOdM1UC8mmmbEDroC7cbbvPh53ugTtJ6yPmhrHadgS
        WC7h5wmr6H56OTGt78JRjvry8kV0tMnqSvfUnuo=
X-Google-Smtp-Source: AGHT+IF0n0k0xyVHlcaTzAiFBEkFfI2PFLOamIQl5zDA1qyTBDc0+oLn6UcUBAP/ylr8TZTxwS4Kgw==
X-Received: by 2002:a17:902:edc7:b0:1bc:2f17:c628 with SMTP id q7-20020a170902edc700b001bc2f17c628mr215330plk.56.1693501310549;
        Thu, 31 Aug 2023 10:01:50 -0700 (PDT)
Received: from ziepe.ca ([207.140.200.197])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f7cb00b001b9e9f191f2sm1493551plw.15.2023.08.31.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:01:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qbl39-000ITj-3G;
        Thu, 31 Aug 2023 14:01:43 -0300
Date:   Thu, 31 Aug 2023 14:01:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper function
Message-ID: <ZPDHd5LYeWa9avQO@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-3-tina.zhang@intel.com>
 <4d658766-688c-cda2-b4e1-60200a60a9b3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d658766-688c-cda2-b4e1-60200a60a9b3@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:24:31AM +0800, Baolu Lu wrote:
> On 2023/8/27 16:43, Tina Zhang wrote:
> > Use the helper function mm_get_pasid() to get a mm assigned pasid
> > value. The motivation is to replace mm->pasid with an iommu private
> > data structure that is introduced in a later patch.
> > 
> > v2:
> > - Update commit message
> > - Let mm_get_enqcmd_pasid() call mm_get_pasid() to get pasid
> 
> Ditto.
> 
> > Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++------
> >   drivers/iommu/intel/svm.c                       |  8 ++++----
> >   drivers/iommu/iommu-sva.c                       | 14 +++++++-------
> >   include/linux/iommu.h                           | 10 +++++++++-
> >   4 files changed, 26 insertions(+), 18 deletions(-)
> 
> Eventually perhaps we should have something like sva_domain_get_pasid().

There is never just a single PASID for a domain. That should not be
part of any of our APIs.

If we want to provide core code aide then the core code should have a
means to help the drvier maintain the attachment database for the
domain.

Eg maintain the list of RIDs, PASIDs, etc that the domain is linked
to.

But this is such trivial code I'm not sure it helps much

> Finally the iommu drivers only need mm->pgd, nothing else.

Yes, attaching the notifier and accessing the arch specific mm->pgd
should be the only driver touches of the mm_struct..

Jason
