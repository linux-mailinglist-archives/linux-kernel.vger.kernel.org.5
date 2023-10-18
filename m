Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BF7CEC09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjJRXag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjJRXac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6B8B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697671782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DRIEsucDzfc4+5QaKl7PpFIFrSK46xQTHzvy5XznJOQ=;
        b=jLy5bNe7VHAYc4gR/aoYf/4X7gEX1rCmS84rj5HNRgKJx7Jxmm+z65LnJCrTz+wPu16nhf
        jICKGU2xLcIk+bxVf6OChS75M5Mx42x9uqSXaW0vPTi8LvG0xJq7tWGGInb1TpW/wt2kLc
        C/bBIL+oVGT+2TXq5TMeYnbmcp4C0lM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-VETM7VI9MO-SagABlNJedg-1; Wed, 18 Oct 2023 19:29:31 -0400
X-MC-Unique: VETM7VI9MO-SagABlNJedg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2ef9e4c25so1464879b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671770; x=1698276570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRIEsucDzfc4+5QaKl7PpFIFrSK46xQTHzvy5XznJOQ=;
        b=ADypRFXyU9n9IzAukTMJWF656EX1YldxavdR4b52SXV1uF5lQwC0z6l+KmvFqvGW68
         HxSdHqC+xRq6Rr2iFp30wG/XvnkcWPETKPejnttgQqZN+Jqvq52MV2mOOy9yn1IkrNYH
         4yHBEbnyhBYGCaCjdjTFsXEP4VjVIHU8COYxLQjrEtKsNYW3DNnvlwsHEq1KhY4/TzjO
         GwrOOJ0xH1gPMW+VdHZRdxIvVIIfLNrEO9yVok/tnBDGq8+IxU/u99blG5DCN+ul2YAQ
         Y/lUsJmcIIkGJnkQT2MZwtZIUWMO/K0sijA9QZ2EqZCWP88eZ8Bji2Rwmy/7xcEqXrml
         eQEA==
X-Gm-Message-State: AOJu0Yy/yhqpA3l1h7F4ClrYSzJYBx6agfLnCrEP6TqSf9Z5ZMu2gZQI
        VveIbCS81QlQqc3h24Aq+oPfrtqbFYesXUEeMwdW2kyXfcFuuVVj3nB/iuV35PQHK9QnaEJGMjO
        S+2wt6KpRQKECJpWXP7/tfsryo0ozytwv
X-Received: by 2002:a54:440e:0:b0:3a4:298f:b2e0 with SMTP id k14-20020a54440e000000b003a4298fb2e0mr645531oiw.26.1697671770794;
        Wed, 18 Oct 2023 16:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx26w5otXYju9J5g7hJH0oM90D/ndOaZWJ/zsUkrwM4XB6dkxyGvfp4EUqanYeiF63KRz1yw==
X-Received: by 2002:a54:440e:0:b0:3a4:298f:b2e0 with SMTP id k14-20020a54440e000000b003a4298fb2e0mr645519oiw.26.1697671770567;
        Wed, 18 Oct 2023 16:29:30 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bt19-20020ad455d3000000b006616fbcc077sm318229qvb.129.2023.10.18.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:29:30 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:29:28 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iommu/arm-smmu: Don't register fwnode for legacy
 binding
Message-ID: <2aigsq5n3q2qqwlctn7dqorusslpwpptgogzcrymxzxeertqvn@7aua3vzzszt7>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <3a5cd62dd21ed58f337bb9a389d301054e503dc3.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5cd62dd21ed58f337bb9a389d301054e503dc3.1697047261.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:52PM +0100, Robin Murphy wrote:
> When using the legacy binding we bypass the of_xlate mechanism, so avoid
> registering the instance fwnodes which act as keys for that. This will
> help __iommu_probe_device() to retrieve the registered ops the same way
> as for x86 etc. when no fwspec has previously been set up by of_xlate.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0..4b83a3adacd6 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2161,7 +2161,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
> +	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
> +				    using_legacy_binding ? NULL : dev);
>  	if (err) {
>  		dev_err(dev, "Failed to register iommu\n");
>  		iommu_device_sysfs_remove(&smmu->iommu);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

