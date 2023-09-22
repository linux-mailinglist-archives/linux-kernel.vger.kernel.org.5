Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B797AB447
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjIVO71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjIVO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:59:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BBBCE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:59:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4121130e7afso14164581cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695394759; x=1695999559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XFv7wzgSRzNlMpAIAXPdx/9Ru1HG5ToVHBwYeRkmP8=;
        b=eKZpA2y265msJcQMTXQQE3jq+PG5nahlF7Gxayl1HrnVhaxeyzP/aoSiQ7FWfxh93D
         8Dc0FyizTA1T6CrjgBYOOSKckv4lUkFmZiopVVUYN/Bsc1wHSmo7/Ls5T9Fn4AAezufI
         YnnErWciT/oUee8ZCuLd7miva378Pt+DmcFrtiFjsUKJkwtrHUkX9mEEvHAFiqt31fw/
         XRumelcgt3K272aClFlo+e3rDifE0wsOfiE3aDjIakoBnBo2YujEVQpa3AucB985Eb+0
         0CH3R+ciJA5S5T9RNctYWMKyip16rsbubE2++j8XcNUvrPplFA9WF7jszHMp0r6mvL06
         lUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394759; x=1695999559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XFv7wzgSRzNlMpAIAXPdx/9Ru1HG5ToVHBwYeRkmP8=;
        b=BNyOMS+LiYtg7tVCx4zC0+faOTVK+QGDm3PxLtV9nTdsJp8rjYxhsWuRdGNhD9kyc6
         SeXvMU/3lhDZa/6FINginxLfzMR7gUgy3me92oe6fNvG4vUjyqaiQYVOjiFkKHptIWl4
         rKMwjZKaW6iWqVWktr8Ufwfh711613/YT4F4k8RLPojQQ2LtqOQOc9/XJk5Bwqjl41VS
         0QSajkbt7/Ds8ndfK6tEYvQOGBnRtOiR6uDzMCaTlRXvcKBInlIPSMd4QDR59szLcBWv
         Uv/PqKgqdhsS0Mv1Cbb1phSC04dP3IVO5MUSpdNInyUC3nDR79YQHjiqGuY0d3PlqgN6
         d+6A==
X-Gm-Message-State: AOJu0YypH8551vJXMNoIRmdFPJFVfKjAJzxMma1IoPmLk0ObPeBebftc
        AhbRCvHJ4FYhauBt2Y0hOD7eVQ==
X-Google-Smtp-Source: AGHT+IFepS22bGXECBY+vUBb2rhMrd9rmdSAqafKVqKT+SSCdNN/lwEK0LNLwifMHk5me/tHvErfGQ==
X-Received: by 2002:ac8:5d0c:0:b0:403:72fa:630b with SMTP id f12-20020ac85d0c000000b0040372fa630bmr10093264qtx.58.1695394758807;
        Fri, 22 Sep 2023 07:59:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id t16-20020ac85310000000b00405553305casm1501734qtn.86.2023.09.22.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:59:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjhcj-000Ygf-KE;
        Fri, 22 Sep 2023 11:59:17 -0300
Date:   Fri, 22 Sep 2023 11:59:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hector Martin <marcan@marcan.st>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, stable@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH REGRESSION v2] iommu/apple-dart: Handle DMA_FQ domains in
 attach_dev()
Message-ID: <20230922145917.GG13795@ziepe.ca>
References: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:55:23PM +0900, Hector Martin wrote:
> Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> introduced in iommu_dma_init_domain() to fall back if not supported, but
> this check runs too late: by that point, devices have been attached to
> the IOMMU, and apple-dart's attach_dev() callback does not expect
> IOMMU_DOMAIN_DMA_FQ domains.
> 
> Change the logic so the IOMMU_DOMAIN_DMA codepath is the default,
> instead of explicitly enumerating all types.
> 
> Fixes an apple-dart regression in v6.5.
> 
> Cc: regressions@lists.linux.dev
> Cc: stable@vger.kernel.org
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Changes in v2:
> - Fixed the issue in apple-dart instead of the iommu core, per Robin's
>   suggestion.
> - Link to v1: https://lore.kernel.org/r/20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

It is weird looking, but I have a followup series that will clean it -
this should go to -rc

Thanks,
Jason
