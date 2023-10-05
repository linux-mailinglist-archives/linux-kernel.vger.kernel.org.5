Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344ED7BA827
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjJERfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJERex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC34201
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696527077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVMW3T0+pSEq9HKF2UPuGay65ooHlYaMJ2N1UmHNeXc=;
        b=URqNeSnhMNdcmbf+i8L0XhnxarhPSjO0xeg4Fx00kAr1EKJ9qPGIRVJp7NtlCWlX79Jwfo
        fDXo863NRNPZAHj4o1gcl/WZGU5FvSuKds7rtXges63YhZLt+uIBoILm5sw7Cb34vCZCix
        bGJADnlPf6KXLXI4+EIE95jHasRMDKg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-yhcuUbqjPw6GD5L7XovoZA-1; Thu, 05 Oct 2023 13:31:16 -0400
X-MC-Unique: yhcuUbqjPw6GD5L7XovoZA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3247f646affso599048f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696527075; x=1697131875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVMW3T0+pSEq9HKF2UPuGay65ooHlYaMJ2N1UmHNeXc=;
        b=ga+K9ZuCduOd2b55YPA17Qg9I5P6ZZI3DcKYwiwOzcv9usk9Bm1SfM9T6Ei4vkmwII
         W0Le020XFbc2U+D2l4/83YHSaUjfi8UzWbi+vHnYFetLtgFK6sFPUhbggCUj1+6WShDw
         e8k1IGrBJHzk8ZxsQtkIOqDMjjGWBWh7rgVTQtotyMBEPEaIH4inIzf7AWn/VI3JWSek
         ERu1zpoM010/W1dc1sFotznNVSXaQduJUMYScT7eA1O+AQaoQ+WiF9dB2n8hh4d8ii1c
         YdJwcIKtD5K6UlwRVoFpXZlxTRsAI0c9iqMrpGYbie8xj4rUBa0zVNX/JtZEA8Y/bNjb
         qR4w==
X-Gm-Message-State: AOJu0YwtVBSku9AqVhcA41Cz4arsAJ69q4adkNFJnz4RNOOqjDo/vU8l
        mUjGg49SCFukuItbJ/NyiBCvNimHoEofkyLwR534XRP0mnMx4K2WhV7vK2GMT7cJXipC6RFPj+T
        Vrt02AD4OVCB9+pTY0ggMQIam
X-Received: by 2002:a5d:6387:0:b0:323:1688:a70e with SMTP id p7-20020a5d6387000000b003231688a70emr2037589wru.16.1696527075275;
        Thu, 05 Oct 2023 10:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS4ME6z6Ci9AzQVs9PTe4qHC/PkzQ3RLcGw2TNLGVY69OQGUue2EJ94jJFy9YSX4l9F5UW3A==
X-Received: by 2002:a5d:6387:0:b0:323:1688:a70e with SMTP id p7-20020a5d6387000000b003231688a70emr2037566wru.16.1696527074948;
        Thu, 05 Oct 2023 10:31:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:cded:de7:6702:3b9d:235c])
        by smtp.gmail.com with ESMTPSA id n1-20020adffe01000000b0031ae8d86af4sm2228566wrr.103.2023.10.05.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:31:14 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:31:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     eperezma@redhat.com, gal@nvidia.com,
        Jason Wang <jasowang@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH vhost v2 00/16] vdpa: Add support for vq descriptor
 mappings
Message-ID: <20231005133054-mutt-send-email-mst@kernel.org>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 07:45:11PM +0300, Dragos Tatulea wrote:
> This patch series adds support for vq descriptor table mappings which
> are used to improve vdpa live migration downtime. The improvement comes
> from using smaller mappings which take less time to create and destroy
> in hw.
> 
> The first part adds the vdpa core changes from Si-Wei [0].
> 
> The second part adds support in mlx5_vdpa:
> - Refactor the mr code to be able to cleanly add descriptor mappings.
> - Add hardware descriptor mr support.
> - Properly update iotlb for cvq during ASID switch.
> 
> Changes in v2:
> 
> - The "vdpa/mlx5: Enable hw support for vq descriptor mapping" change
>   was split off into two patches to avoid merge conflicts into the tree
>   of Linus.
> 
>   The first patch contains only changes for mlx5_ifc.h. This must be
>   applied into the mlx5-next tree [1] first. Once this patch is applied
>   on mlx5-next, the change has to be pulled fom mlx5-next into the vhost
>   tree and only then the remaining patches can be applied.


I get it you plan v3?

> [0] https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next
> 
> Dragos Tatulea (13):
>   vdpa/mlx5: Expose descriptor group mkey hw capability
>   vdpa/mlx5: Create helper function for dma mappings
>   vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code
>   vdpa/mlx5: Take cvq iotlb lock during refresh
>   vdpa/mlx5: Collapse "dvq" mr add/delete functions
>   vdpa/mlx5: Rename mr destroy functions
>   vdpa/mlx5: Allow creation/deletion of any given mr struct
>   vdpa/mlx5: Move mr mutex out of mr struct
>   vdpa/mlx5: Improve mr update flow
>   vdpa/mlx5: Introduce mr for vq descriptor
>   vdpa/mlx5: Enable hw support for vq descriptor mapping
>   vdpa/mlx5: Make iotlb helper functions more generic
>   vdpa/mlx5: Update cvq iotlb mapping on ASID change
> 
> Si-Wei Liu (3):
>   vdpa: introduce dedicated descriptor group for virtqueue
>   vhost-vdpa: introduce descriptor group backend feature
>   vhost-vdpa: uAPI to get dedicated descriptor group id
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  31 +++--
>  drivers/vdpa/mlx5/core/mr.c        | 191 ++++++++++++++++-------------
>  drivers/vdpa/mlx5/core/resources.c |   6 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 100 ++++++++++-----
>  drivers/vhost/vdpa.c               |  27 ++++
>  include/linux/mlx5/mlx5_ifc.h      |   8 +-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |   7 +-
>  include/linux/vdpa.h               |  11 ++
>  include/uapi/linux/vhost.h         |   8 ++
>  include/uapi/linux/vhost_types.h   |   5 +
>  10 files changed, 264 insertions(+), 130 deletions(-)
> 
> -- 
> 2.41.0

