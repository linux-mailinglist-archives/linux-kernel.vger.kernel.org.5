Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB680E71C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjLLJMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjLLJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:12:00 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9754CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:12:06 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id B457E1A3692;
        Tue, 12 Dec 2023 10:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1702372324;
        bh=t19tHgvfYg+tmGKy7EIdQj9jb04NY/+y92FQl+qOnbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvyq70TQ4DbsL1zbnONg/+aQ/xdKnMd60e/t+4JKlFYxpVjySvn0wW60tzlQLOefN
         bqNkzMd9y81TS0Ii9saB2uXugfMR77t8KQcxJXbwKbRl4wRcKzSeVfuYC/5wVMSehD
         LbfJbZONzNENU/DRYSBWNIvV3iKCcjLl5Ps+RimlmeDYktWlM50HvQfnRS1VlJD2mC
         H6LtjSLLg4O/JAVLHO0K+cT2l0jlVBUu5sq5ZHwzEYElVWnN5fTvzhBAVZdC131q9N
         SRQUY5LbLD1gC+tsJ2L7bqj44oQ1VJU5Ci9TmMJvM+l9bqz/L2Q2hzgaQqgQBHxfe6
         JJpl5smR2cxIA==
Date:   Tue, 12 Dec 2023 10:12:03 +0100
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
Subject: Re: [PATCH v10 0/6] Share sva domains with all devices bound to a mm
Message-ID: <ZXgj49cY2PEAwHsB@8bytes.org>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027000525.1278806-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 08:05:19AM +0800, Tina Zhang wrote:
> Jason Gunthorpe (1):
>   iommu: Change kconfig around IOMMU_SVA
> 
> Tina Zhang (5):
>   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
>   iommu: Add mm_get_enqcmd_pasid() helper function
>   mm: Add structure to keep sva information
>   iommu: Support mm PASID 1:n with sva domains
>   mm: Deprecate pasid field

Applied, thanks.

