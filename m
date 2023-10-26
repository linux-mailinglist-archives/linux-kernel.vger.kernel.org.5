Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069B17D7D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbjJZH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjJZH2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DCA1A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698305282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFAk/UX+mocmkaca8aE9iwm2NVVEyC9d5/N9h8Hr0Qk=;
        b=RoGA5hllDYjs3+Ypz+skOCcepvy102HyFss2NMsd9LhCTkm16tManASPRBqH8tbRDd3qZH
        yAQGOXYEZaeJB5y/8CBK3oR806v1I4u6UxMSdnYtIx4Y9kuZuqJhko4B/yOk++9rOPvvWA
        K++NAHMT5RueE4U7NpIwA7hq1VOlBR8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-ovsmcGvsNGaVSC2N1kQI1A-1; Thu, 26 Oct 2023 03:27:49 -0400
X-MC-Unique: ovsmcGvsNGaVSC2N1kQI1A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40839252e81so4394545e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305268; x=1698910068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFAk/UX+mocmkaca8aE9iwm2NVVEyC9d5/N9h8Hr0Qk=;
        b=p9d9UQxpVUqblyfdz6yQIESUevzrVKvDDOVFCNN8gWRVL8pe74hlEBzyGcUMaIiABx
         P/bAREPk1wDAtMaRz8pbgPMTLJJ71ER1LFAZ99r00W3fGcXlZCMjLu7942BaUqVdtDgf
         KpXalcD+XrVMcBrcnAyOEM7+EooxB4SRHLHr+cxiJ16+xuIrxqD/Mjn++u8vRL8o09h7
         Je7wt20T4kLug+AjnNGo7dr6xpL9tcJPsLeCdLSPpE4kpg3wjw7f+fdDLcogMQO04KPF
         b5r9k4cCUw9PCWwTflW4+3mNKETWFqyBc6/G6ZaWVlHvP3tTirNsLkYfl4DhZLHgqP0W
         qO2w==
X-Gm-Message-State: AOJu0YyVr9P/QL1RVI0Ru62OGT4P6zzaaTSKLN05tq7KsSCGAEl1V0/H
        rIEqKBu3XG5ynmp4m3u4JmbR6LfQ/tRWqv8EiTduyXw4AjqaYEPBaNQRvpQ/hU90oOmqDWDQwPe
        sINQXLzcq3WdQxqy8uiJxD0i4IqEOq/kktiMBqA==
X-Received: by 2002:a05:600c:5122:b0:403:272:4414 with SMTP id o34-20020a05600c512200b0040302724414mr13653836wms.0.1698305268313;
        Thu, 26 Oct 2023 00:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDmxe4z2Ra5Jw2xkZ3lS9zcLLaRq/+nM5ao37J48dzXRSejdwXRV3MKk8nh9wCEGGF4SoKdQ==
X-Received: by 2002:a05:600c:5122:b0:403:272:4414 with SMTP id o34-20020a05600c512200b0040302724414mr13653825wms.0.1698305267881;
        Thu, 26 Oct 2023 00:27:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b004054dcbf92asm1716144wml.20.2023.10.26.00.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:27:46 -0700 (PDT)
Date:   Thu, 26 Oct 2023 03:27:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, eperezma@redhat.com, sgarzare@redhat.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] vdpa: decouple reset of iotlb mapping from device
 reset
Message-ID: <20231026032713-mutt-send-email-mst@kernel.org>
References: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:14:33AM -0700, Si-Wei Liu wrote:
> In order to reduce needlessly high setup and teardown cost
> of iotlb mapping during live migration, it's crucial to
> decouple the vhost-vdpa iotlb abstraction from the virtio
> device life cycle, i.e. iotlb mappings should be left
> intact across virtio device reset [1]. For it to work, the
> on-chip IOMMU parent device could implement a separate
> .reset_map() operation callback to restore 1:1 DMA mapping
> without having to resort to the .reset() callback, the
> latter of which is mainly used to reset virtio device state.
> This new .reset_map() callback will be invoked only before
> the vhost-vdpa driver is to be removed and detached from
> the vdpa bus, such that other vdpa bus drivers, e.g. 
> virtio-vdpa, can start with 1:1 DMA mapping when they
> are attached. For the context, those on-chip IOMMU parent
> devices, create the 1:1 DMA mapping at vdpa device creation,
> and they would implicitly destroy the 1:1 mapping when
> the first .set_map or .dma_map callback is invoked.
> 
> This patchset is rebased on top of the latest vhost tree.
> 
> [1] Reducing vdpa migration downtime because of memory pin / maps
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html


If this is just a squash of v4 with fixes then I already pushed it.
Ignoring this for now.

> ---
> v5:
> - Squashed two fixups to the clean map patch
> 
> v4:
> - Rework compatibility using new .compat_reset driver op
> 
> v3:
> - add .reset_map support to vdpa_sim
> - introduce module parameter to provide bug-for-bug compatibility with older
>   userspace 
> 
> v2:
> - improved commit message to clarify the intended csope of .reset_map API
> - improved commit messages to clarify no breakage on older userspace
> 
> v1:
> - rewrote commit messages to include more detailed description and background
> - reword to vendor specific IOMMU implementation from on-chip IOMMU
> - include parent device backend feautres to persistent iotlb precondition
> - reimplement mlx5_vdpa patch on top of descriptor group series
> 
> RFC v3:
> - fix missing return due to merge error in patch #4
> 
> RFC v2:
> - rebased on top of the "[PATCH RFC v2 0/3] vdpa: dedicated descriptor table group" series:
>   https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com/
> 
> ---
> 
> Si-Wei Liu (7):
>   vdpa: introduce .reset_map operation callback
>   vhost-vdpa: reset vendor specific mapping to initial state in .release
>   vhost-vdpa: introduce IOTLB_PERSIST backend feature bit
>   vdpa: introduce .compat_reset operation callback
>   vhost-vdpa: clean iotlb map during reset for older userspace
>   vdpa/mlx5: implement .reset_map driver op
>   vdpa_sim: implement .reset_map support
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>  drivers/vdpa/mlx5/core/mr.c        | 17 ++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 27 ++++++++++++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 52 ++++++++++++++++++++++++------
>  drivers/vhost/vdpa.c               | 52 +++++++++++++++++++++++++++---
>  drivers/virtio/virtio_vdpa.c       |  2 +-
>  include/linux/vdpa.h               | 30 +++++++++++++++--
>  include/uapi/linux/vhost_types.h   |  2 ++
>  8 files changed, 164 insertions(+), 19 deletions(-)
> 
> -- 
> 2.39.3

