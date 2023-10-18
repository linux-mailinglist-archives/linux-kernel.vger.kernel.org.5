Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885BF7CEC37
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjJRXli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRXlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D57B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697672446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mx4Dk0ISS6YatUHGy78AukoYqcfDmzrebgNaNGWUWvw=;
        b=gt0ctRFylNEXU0pXRdITwCFdrh6Ah4RlOg9DcJPRnmTi4Wfl8D2+DyZbMp5vRmqhkZvyWe
        kVlTNvMGeFs3TqK8oFFER0W07rK56m1vKowqYAY/6Mvt2GAaznM1SNjo8hoqW3Tgb9CdHK
        hTo8p05/ACEjlFCmAxo6z0HHPZ3GVkA=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-2jNs7rP_MTyaAxV43h5_Rw-1; Wed, 18 Oct 2023 19:40:45 -0400
X-MC-Unique: 2jNs7rP_MTyaAxV43h5_Rw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4a1a1fc322bso2421566e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697672444; x=1698277244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx4Dk0ISS6YatUHGy78AukoYqcfDmzrebgNaNGWUWvw=;
        b=mfadqXdYwgTn1VBsDkTpwNg7MxDgzHmrTZSl1qIMvDdTBZ0Goz8ZolPFc8tOXppLQ+
         Q/Jiq1YU2bt/Vo+cSkTwyJ5fau4KKzk3Z1JczA7EjbDiQiEvX8A+nBWigOKbnaVEgu2H
         aHNSXiwTdOIoNl6+uYzqeHX5CjLrbwzq2TQq/Dv16nqdRDJDTYmj5iv4hpPuOlCSzVob
         /nuWW6kqm/LKPb5PdSRzBLEz4Ux6LqiRUZ8wZ4NcyGWxK/vaIZDeBIpiBo3rKaphYu4f
         QPY38hZTgzT7ad2ruE+eYjfI4SBex+T4r7zumPgNG5qanEkNvth6ezDZt5uu4reLVeHF
         yhsw==
X-Gm-Message-State: AOJu0YxqyGpyjDa1vsCyuDBprM78WeRR9TJ1VwEAa0nkMQDKSKVoOjUH
        dcy2sjH0Ip2KYJobcO3KcQDGOsFF8mLEl2QU6IkxN5G7sWIcCknI8qBLjI/SrZ+VvU2wfLDULiy
        MNHuEV9ps0msNJxfLyRgAXHJA+LsQUtyK
X-Received: by 2002:a1f:a647:0:b0:49d:9916:5740 with SMTP id p68-20020a1fa647000000b0049d99165740mr492338vke.9.1697672444083;
        Wed, 18 Oct 2023 16:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtVCzczZg3feC3qrpPkD5F8AncaRNB0ei1DknIl2GHSrsaIA3JO0sFERrgMYAXmOWYnrMV1w==
X-Received: by 2002:a1f:a647:0:b0:49d:9916:5740 with SMTP id p68-20020a1fa647000000b0049d99165740mr492329vke.9.1697672443750;
        Wed, 18 Oct 2023 16:40:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id k7-20020ac80747000000b00418142e802bsm325108qth.6.2023.10.18.16.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:40:43 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:40:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] iommu: Clean up open-coded ownership checks
Message-ID: <2nsto6kbvxzuoods66reiyiw72sqgwwhgnhtoop567l3kopaer@afoq5xd5obvm>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <0d68867cec0fb90578d50cc145f7f9a180407f20.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d68867cec0fb90578d50cc145f7f9a180407f20.1697047261.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:54PM +0100, Robin Murphy wrote:
> Some drivers already implement their own defence against the possibility
> of being given someone else's device. Since this is now taken care of by
> the core code (and via a slightly different path from the original
> fwspec-based idea), let's clean them up.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  9 +--------
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 16 +++-------------
>  drivers/iommu/mtk_iommu.c                   |  7 +------
>  drivers/iommu/mtk_iommu_v1.c                |  3 ---
>  drivers/iommu/sprd-iommu.c                  |  8 +-------
>  drivers/iommu/virtio-iommu.c                |  3 ---
>  7 files changed, 6 insertions(+), 43 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

