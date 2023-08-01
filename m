Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FAA76B9A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjHAQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHAQcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC1133
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690907478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdQcit9Rbdj2/Zjzbfcviq4R7rF24Vr9tYUEaCIF3Ws=;
        b=StcUlJ2F2VvYnugQsj766lh7o1sb8QEikKZFAOCnYtWJlrnQ0N+7P/PRzGJEoXqQxsCP2S
        MhFaJKj4CGsGPVBLab+s8o/EVpMeA+ct/PiRouWQRhz2+yxb2LkU4OiLI3Nl/PIROPfBPG
        ycOz/IvFwekKlH6PwbosDyV6L1Mb13o=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-oB1JKl3FNLqXFStyXTOxlw-1; Tue, 01 Aug 2023 12:31:17 -0400
X-MC-Unique: oB1JKl3FNLqXFStyXTOxlw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7907f181babso395685339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690907476; x=1691512276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdQcit9Rbdj2/Zjzbfcviq4R7rF24Vr9tYUEaCIF3Ws=;
        b=GApf0Sh+ugHQ72jInQLm9fer0NZIUJABL3F6nC80E6BOT1wgF1hy/dSQFs/UeFj42+
         BvS+ynCzlYhQltzb9PcskVudkfSwkZI/No9WaAFzlgaG9Mv2kblDXigFkmK34SiGYUiU
         VDRhz+EE3zKI3CvfHheZcxIeMsPAX6RT7XaX05J3JvT6Nr6sa1jAwP4bB/PUVVGIFzoa
         GCEgeDwPo6GgqorHxvVh5Kg2QcvvepjFYx0431fQpGmmLmE5nzTtdqtPGC+3hgfO4ZCB
         aj3ZkynZMSYqImgMKF/rGmW7bosgZ5QWnbkWMbL/hzdJljtp5oEKliG352PauXG8QZoJ
         OUKw==
X-Gm-Message-State: ABy/qLZtU+DBDPJLle3ONcoFkuuOwosemG2JqxKQyziGsEwODr+qKGDK
        lnb3oUsf1B++PIjOshrkcM9vWNU0BGttxzdK4bPWzUiTemQaaTjbqntnoZMdT9ut6cNrv41xr23
        r/S5+7XVkGdP5gz1OpKOjpNtkh98dAvVc
X-Received: by 2002:a5e:a702:0:b0:783:40ef:c9f6 with SMTP id b2-20020a5ea702000000b0078340efc9f6mr12322950iod.19.1690907476629;
        Tue, 01 Aug 2023 09:31:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEaKvrDHRBuTmDs7/3OvT6Gtmr85XzuwJLyLxhAlLLlUiRHZS4M092GmSnxzskppc6JIFoX4Q==
X-Received: by 2002:a5e:a702:0:b0:783:40ef:c9f6 with SMTP id b2-20020a5ea702000000b0078340efc9f6mr12322928iod.19.1690907476309;
        Tue, 01 Aug 2023 09:31:16 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id c17-20020a02a411000000b0042b358194acsm3723562jal.114.2023.08.01.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:31:15 -0700 (PDT)
Date:   Tue, 1 Aug 2023 10:31:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio/type1: fix cap_migration information leak
Message-ID: <20230801103114.757d7992.alex.williamson@redhat.com>
In-Reply-To: <20230801155352.1391945-1-stefanha@redhat.com>
References: <20230801155352.1391945-1-stefanha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

LGTM, but missing:

Fixes: ad721705d09c ("vfio iommu: Add migration capability to report supported features")

I'll give a bit for further comments/reviews and queue it for v6.6 with
the above update.  Thanks,

Alex


> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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

