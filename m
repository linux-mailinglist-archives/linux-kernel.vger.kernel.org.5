Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6A7DF2B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346880AbjKBMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbjKBMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:47:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A715B12F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:47:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7788f513872so49318185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698929264; x=1699534064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQ+GdWawOo3FT7vEf5mwevTBQUu7eDKWKnvNYW/PsMc=;
        b=RXTyY7wDU4x4iB6OujNA3beW5vSwCd6azk6x6EU2aFxiLSrJbCSBJBbO7EPE+Oj952
         kpTouEdpnwwzMD/XiitOudEkbhmnG/tbel0f6nrq2uSTcsOaAY1ygVMlW0deX3cN/fKa
         fxWDCP6j5r2AV/RLZ1CrCPQvfyQhfSsNjVNHpja4vTRs0tLR+Z0w5Hy7v+88xUoUpGeY
         k90/FTZR0PLoV5jTUIcMjkHao8ajvtvFNTXjAt/zI7Lw0RmEWqa6tdkPwDsbOIW0XaNh
         8vfrMm2M/G+V0Q8cf/32u0AFAvkoxoPHNLXkl0f+uOyJ0ezRy9TwzG7s+CW/BBM0ACgi
         zY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929264; x=1699534064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ+GdWawOo3FT7vEf5mwevTBQUu7eDKWKnvNYW/PsMc=;
        b=mVzGEPz7/emHs/MXx8k+03j+YzGlzwJcaGzhTnBvkdGoOYyHoB9cSk96utR16vVhvd
         yCrnNFK7uakduxQEnCjj6M/9xFeUuIVsoNGWCh+Vq2QioIt0VpduHjT16Y0tr1ARQkrE
         OWsjC5akG99RG07+SWtSlLbpXTQ15YSXE8W5DJMcz/AtaDG1p/46scnqcKscQvfXAoV6
         dQ9sBHx9lUpFyB75Ri187J1SFrZIFDjCiU+r1jvHZHRGBkEIjQQtL4xBryRl/fKxgGEb
         mjF651eeHOD9535c1wQ2QOQVJwfL2lbPQbZiV1FH1Stvz3q5a0z/1qGiInCR/sJxxYfD
         rOzA==
X-Gm-Message-State: AOJu0YwUKkynw624FKx1705zSbAfsCRxPfvybmbvT6zK2q5+r78WBOUe
        0k+uaXI0JCFachs6wfl1FROqsw==
X-Google-Smtp-Source: AGHT+IFxFiOR7UXzaPpwFSzkWqw0zJo0m72p87r7wZ2km12vbMwY4rfJeHI3ydNPhYo9BA85V7lP4Q==
X-Received: by 2002:a05:620a:35e:b0:775:9bb1:9ac4 with SMTP id t30-20020a05620a035e00b007759bb19ac4mr18012659qkm.61.1698929263726;
        Thu, 02 Nov 2023 05:47:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id r18-20020a05620a299200b007770673e757sm2291720qkp.94.2023.11.02.05.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:47:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qyX6s-0004kn-JW;
        Thu, 02 Nov 2023 09:47:42 -0300
Date:   Thu, 2 Nov 2023 09:47:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231102124742.GA4634@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework for nested translation. Nested
> translation is a hardware feature that supports two-stage translation
> tables for IOMMU. The second-stage translation table is managed by the
> host VMM, while the first-stage translation table is owned by user
> space. This allows user space to control the IOMMU mappings for its
> devices.

Having now looked more closely at the ARM requirements it seems we
will need generic events, not just page fault events to have a
complete emulation.

So I'd like to see this generalized into a channel to carry any
events..

> User space indicates its capability of handling IO page faults by
> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> for page fault delivery. On a successful return of HWPT allocation, the
> user can retrieve and respond to page faults by reading and writing to
> the file descriptor (FD) returned in out_fault_fd.

This is the right way to approach it, and more broadly this shouldn't
be an iommufd specific thing. Kernel drivers will also need to create
fault capable PAGING iommu domains.

Jason
