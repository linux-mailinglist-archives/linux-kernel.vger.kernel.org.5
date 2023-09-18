Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9B7A45CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjIRJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbjIRJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5696102;
        Mon, 18 Sep 2023 02:23:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA40C433C8;
        Mon, 18 Sep 2023 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695029027;
        bh=W9tDmRFz0n8cGL2lDybhVkX8mgpWmONNFSrwMAaOJ+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1ehrI5spUg4sXe5a8Yv6+CAa8T3JsQFIm8CA1nIgLkzdg4EsKxtmy1OQ6CxzU92k
         6+mY5jQ7T8cDV4ooCZcZxOTNm+B5FKGStdncc5ST759apYEOMQb0h0dmknvkvPTino
         fo/LTL7I7Hxwed/jKGdIVTbnQbP5s7jcWYWUdQpgovY8N07txFWcYso23OdUkqc1sz
         tK7MkNZcWwWOiTzzidwYoumlFHNGKi2LEzlEtNUsY8DLENIxCJ39mFSBHkMkFdelSA
         0aUOoSa42UT8Pe6s29TzO/6Nr3QdfNMByf65+yp0rY61fvnzi8KyxVvNHwEEcTdeIv
         DDo7gBLhQKZ9w==
Date:   Mon, 18 Sep 2023 10:23:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
        joro@8bytes.org, jgg@nvidia.com, jean-philippe@linaro.org,
        apopple@nvidia.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix soft lockup triggered by
 arm_smmu_mm_invalidate_range
Message-ID: <20230918092341.GB17341@willie-the-truck>
References: <20230901203904.4073-1-nicolinc@nvidia.com>
 <ZQQLNmmAOsNmvtDs@Asurada-Nvidia>
 <9334dfcd-7749-6ae1-1170-b4952f2b8181@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9334dfcd-7749-6ae1-1170-b4952f2b8181@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:33:31PM +0800, Baolu Lu wrote:
> On 9/15/23 3:43 PM, Nicolin Chen wrote:
> > I found this patch cannot be applied to v6.6-rc1 due to conflicts
> > with some new commits that were merged during the previous cycle.
> > 
> > I can redo a version rebasing on the v6.6-rc1, yet the new version
> > won't apply to earlier kernel stable trees. Is there a way to make
> > it happen that both mainline and earlier trees can have this fix?
> 
> Normally, bug fixes should first be submitted to the mainline kernel
> (also known as Linus's tree). If you use the "Fixes" and "CC-stable"
> tags, the patch will be automatically picked up for the appropriate
> stable kernels.
> 
> If the patch does not apply to any stable kernel that you want it to be
> there, you can then post a back-ported patch to the stable mailing list.
> 
> When doing so, it's better to include the following information:
> 
> - The mainline commit ID of the back-ported patch.
> - The versions of the stable kernel(s) to which you want the back-ported
>   patch to be applied.
> 
> Hope this helps.

Yup, please send a version against -rc1 so we can land that first.

Will
