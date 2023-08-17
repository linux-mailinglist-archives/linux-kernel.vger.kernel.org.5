Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1843D77FD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352926AbjHQR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354158AbjHQR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8FFD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692294929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXnE3oQ7Ijeiq5xZy1Iauyqm0pyudGTEGiUZtSXw3Qw=;
        b=Lja5WOYzbb/L3iC/CPbu+X4hrU//R0gg5+oMDeUNdXAxlkJHgLcB5xz0HPUeqI0AP+BvN7
        /14pKT+Z5BruFGGp8H3uw4nZBy/pqNb0w7f89iMsViX1YKfhXDMXKgf4x2cyqd7yj7kI4d
        UKh0Sj882xt3FBLazcnWx+l9Bf4wmUY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-U5na5wHCOvCFlTk7AZvaKQ-1; Thu, 17 Aug 2023 13:55:28 -0400
X-MC-Unique: U5na5wHCOvCFlTk7AZvaKQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-778d823038bso2790739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294927; x=1692899727;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXnE3oQ7Ijeiq5xZy1Iauyqm0pyudGTEGiUZtSXw3Qw=;
        b=BPk8GBtNZqjyHany8ZDPTK+GVB12YxzG3Jlj02aaYUtIggwm1phuI9YDNVjrIYsk4V
         c7pp9BvM5eRu2kHh/Yn9JOF5/01ryntggJ/MtxDh+yYBldWSH0CkMq8OoepcPWExA9CE
         MXBdplnRIP2FQ5dFrSkBiGFV3XHYMt3yVIJ3jRF//L/p2t7JsuwwwT095uZmtFS/9mtD
         ZxHYNiYihGgsysg75pbBR5LWYG4X5gJCcBWaQli8I+G2JLiUQSaatQg5LFizrl1/+9D2
         G/5WWKmcl81odSUNJzTLS3uXu7+WcrSh6QMJvGLHFOdyUOq+8IZkio4zJl5YTh+m+tzC
         FCfw==
X-Gm-Message-State: AOJu0YwPbO6vKL/znO1neJxtsFfs4lBetHtZft/mYKpDmClrHOgzmvdN
        pOXId3tFuFJLyt5vsQ/vihfBflkpS2Yym2UGLsiHclRFasS5DAMiGk3jfDnNOMLdfT5zoUX3Kcz
        /UGljdmPygKH8BFI2epGhIxSI
X-Received: by 2002:a5d:9741:0:b0:791:1e87:b47a with SMTP id c1-20020a5d9741000000b007911e87b47amr360606ioo.14.1692294927585;
        Thu, 17 Aug 2023 10:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFpk7bhCZKpwXWcm/cP+vn6eMM4NVHT1F17qUVO5PRiKYLHx0tKZMwwGkdF5hF7Wv+KxgilQ==
X-Received: by 2002:a5d:9741:0:b0:791:1e87:b47a with SMTP id c1-20020a5d9741000000b007911e87b47amr360592ioo.14.1692294927331;
        Thu, 17 Aug 2023 10:55:27 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id d9-20020a056602064900b0078680780694sm23841iox.34.2023.08.17.10.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:55:26 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:55:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio/type1: fix cap_migration information leak
Message-ID: <20230817115526.04b3bf72.alex.williamson@redhat.com>
In-Reply-To: <20230801155352.1391945-1-stefanha@redhat.com>
References: <20230801155352.1391945-1-stefanha@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Aug 2023 11:53:52 -0400
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Fix an information leak where an uninitialized hole in struct
> vfio_iommu_type1_info_cap_migration on the stack is exposed to userspace.
> 
> The definition of struct vfio_iommu_type1_info_cap_migration contains a hole as
> shown in this pahole(1) output:
> 
>   struct vfio_iommu_type1_info_cap_migration {
>           struct vfio_info_cap_header header;              /*     0     8 */
>           __u32                      flags;                /*     8     4 */
> 
>           /* XXX 4 bytes hole, try to pack */
> 
>           __u64                      pgsize_bitmap;        /*    16     8 */
>           __u64                      max_dirty_bitmap_size; /*    24     8 */
> 
>           /* size: 32, cachelines: 1, members: 4 */
>           /* sum members: 28, holes: 1, sum holes: 4 */
>           /* last cacheline: 32 bytes */
>   };
> 
> The cap_mig variable is filled in without initializing the hole:
> 
>   static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
>                          struct vfio_info_cap *caps)
>   {
>       struct vfio_iommu_type1_info_cap_migration cap_mig;
> 
>       cap_mig.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION;
>       cap_mig.header.version = 1;
> 
>       cap_mig.flags = 0;
>       /* support minimum pgsize */
>       cap_mig.pgsize_bitmap = (size_t)1 << __ffs(iommu->pgsize_bitmap);
>       cap_mig.max_dirty_bitmap_size = DIRTY_BITMAP_SIZE_MAX;
> 
>       return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
>   }
> 
> The structure is then copied to a temporary location on the heap. At this point
> it's already too late and ioctl(VFIO_IOMMU_GET_INFO) copies it to userspace
> later:
> 
>   int vfio_info_add_capability(struct vfio_info_cap *caps,
>                    struct vfio_info_cap_header *cap, size_t size)
>   {
>       struct vfio_info_cap_header *header;
> 
>       header = vfio_info_cap_add(caps, size, cap->id, cap->version);
>       if (IS_ERR(header))
>           return PTR_ERR(header);
> 
>       memcpy(header + 1, cap + 1, size - sizeof(*header));
> 
>       return 0;
>   }
> 
> This issue was found by code inspection.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to vfio next branch for v6.6.  I'll give Jason a little more
time to ack "[PATCH v3] vfio: align capability structures".  Thanks!

Alex

> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index ebe0ad31d0b0..d662aa9d1b4b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2732,7 +2732,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
>  static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
>  					   struct vfio_info_cap *caps)
>  {
> -	struct vfio_iommu_type1_info_cap_migration cap_mig;
> +	struct vfio_iommu_type1_info_cap_migration cap_mig = {};
>  
>  	cap_mig.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION;
>  	cap_mig.header.version = 1;

