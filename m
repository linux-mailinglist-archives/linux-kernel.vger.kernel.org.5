Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8856A7D7D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbjJZHYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:24:45 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 534FDD6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:24:43 -0700 (PDT)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 7A72A1A6582;
        Thu, 26 Oct 2023 09:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1698305081;
        bh=imEBUMoMnJ11bhtOMKZdu+fWgs5XY6RIcln8XGroUKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=7hXKGtTydVfrZ/ir3xgATqn4SiC6otKrLWnNt1K+LzOmLLfxYj2tr8T4Xnt55E1gP
         zmGRsL5n7IV4RfCc36vq2aS6xpMh2AkzXOZ4GbOv/NwzsIbJEKtGYX4j1mAIwuzGvw
         2AtkWzomWj379hYHd6reTgpbNB0P1Rq9iJwBbgsZ1QVOgAh1a0mc/K8aMOgEncAwm0
         rdUpKDMY0g6VsmTpuqEDIgVHFXMiYev6UVHWlpyJRzNsXktTvQ7Y7nmioAM/ZcIpBl
         R5TXwoAPCM6Xvm5YS6REGFjn2eMofQSUFPCE7sZQCthfusx22fOe69vgr7aEXboy5a
         HB++oErAZ4+og==
Date:   Thu, 26 Oct 2023 09:24:40 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Message-ID: <ZToUOKSqqI6Bh_03@8bytes.org>
References: <20231018050640.24936-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018050640.24936-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tina,

On Wed, Oct 18, 2023 at 01:06:35PM +0800, Tina Zhang wrote:
> Tina Zhang (5):
>   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
>   iommu: Add mm_get_enqcmd_pasid() helper function
>   mm: Add structure to keep sva information
>   iommu: Support mm PASID 1:n with sva domains
>   mm: Deprecate pasid field

Thanks for doing this, it all looks reasonable to me. But there is one
thing missing which needs to be done before we can move forward with
this.

There was a discussion about the Kconfig symbol naming used in
mm_struct. Please see the discussion here:

	https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/

Please update this patch-set to solve this and I will take the series.

Regards,

	Joerg
