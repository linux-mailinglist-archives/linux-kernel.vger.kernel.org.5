Return-Path: <linux-kernel+bounces-11088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50381E128
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E3128109D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317651C27;
	Mon, 25 Dec 2023 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYz1nR65"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748161DDD6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703515266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jCpX86PoGZe+01z8F2Jmte5yGSzORMYuWo+w6Pq78Nw=;
	b=eYz1nR65iP7gufZz8GEI/g47jXKi7KPpvjXYHwO7teNOe5Rt59XbKMMw8HZm/IcDNyFKLU
	3/xQ7UEGYOAJ10gqvfcUXnlU8xO8W+jO6Cw7fkhrQKZtXsjwp8pq84FWSzAPDqTmc/G6OU
	7mK8oZW35exZV2T9i5zfYHh5uUynNmc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-9iGOFSY3PKuhYEgpo1D9HA-1; Mon, 25 Dec 2023 09:41:05 -0500
X-MC-Unique: 9iGOFSY3PKuhYEgpo1D9HA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-336953e0fe7so1758390f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703515264; x=1704120064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCpX86PoGZe+01z8F2Jmte5yGSzORMYuWo+w6Pq78Nw=;
        b=aQR2H+pVBqM2yPONc3pXuZ8h5xh7JqEFjgdzQnj6Ey73kMoN81qDWah67pdgTdOKkn
         DctyDN/9MTe3DweH2Abv2O7heMk1QW17WA7Ng9237vRmdFCA3t6aC2CDisPKR9NoYUkU
         inMouSO5tDNS11ElKOUS0P1ZmIYhqEv75y8RMuuQRYeH1SWmSlnOsxOCcegDqhePxg4U
         eWw6V+gzYxonQeBtwk2mDvddHHjWtGcuCD9Ms2f50owWwon1Vk2UAPEtCGhp+Ph4bc+w
         fdzVOq0sDivLQrurRZPLla42pWc9Gg2MJTG7Csay9vn7ehxdyXBvEf3EfaPUYpvwVQDH
         Am+Q==
X-Gm-Message-State: AOJu0YzW64WwWAfvy3tQIkMIol9cr7ePWf8C9QcqnI8MwMkRWIfiUWph
	zO/mK80xATS+0eXTaenoZV0w5vhQV1CkWl2GJ6hmzdmwgZm87I8UeTT9IDbjyklNMV7Rn8TwOrA
	y1EZSVCWbHb8y8+YZWyoneLPTvwHOf3ol
X-Received: by 2002:a5d:4a07:0:b0:336:645e:3d9f with SMTP id m7-20020a5d4a07000000b00336645e3d9fmr3220792wrq.124.1703515263951;
        Mon, 25 Dec 2023 06:41:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj2DpqtPqEpTmnkMcmDdAWO/NAH2KYQxWHYBlyJnk5k2kalANc7ZkucSVc2LG3TSg8UKmMaA==
X-Received: by 2002:a5d:4a07:0:b0:336:645e:3d9f with SMTP id m7-20020a5d4a07000000b00336645e3d9fmr3220783wrq.124.1703515263641;
        Mon, 25 Dec 2023 06:41:03 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d6d0e000000b00336cbbf2e0fsm1042391wrq.27.2023.12.25.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 06:41:02 -0800 (PST)
Date: Mon, 25 Dec 2023 09:41:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 00/15] vdpa/mlx5: Add support for resumable vqs
Message-ID: <20231225094040-mutt-send-email-mst@kernel.org>
References: <20231219180858.120898-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219180858.120898-1-dtatulea@nvidia.com>

On Tue, Dec 19, 2023 at 08:08:43PM +0200, Dragos Tatulea wrote:
> Add support for resumable vqs in the mlx5_vdpa driver. This is a
> firmware feature that can be used for the following benefits:
> - Full device .suspend/.resume.
> - .set_map doesn't need to destroy and create new vqs anymore just to
>   update the map. When resumable vqs are supported it is enough to
>   suspend the vqs, set the new maps, and then resume the vqs.
> 
> The first patch exposes relevant bits for the feature in mlx5_ifc.h.
> That means it needs to be applied to the mlx5-vhost tree [0] first. Once
> applied there, the change has to be pulled from mlx5-vhost into the
> vhost tree and only then the remaining patches can be applied. Same flow
> as the vq descriptor mappings patchset [1].
> 
> The second part implements the vdpa backend feature support to allow
> vq state and address changes when the device is in DRIVER_OK state and
> suspended.
> 
> The third part adds support for seletively modifying vq parameters. This
> is needed to be able to use resumable vqs.
> 
> Then the actual support for resumable vqs is added.
> 
> The last part of the series introduces reference counting for mrs which
> is necessary to avoid freeing mkeys too early or leaking them.


I lost track. Are you going to send v5 or not?

> * Changes in v4:
> - Added vdpa backend feature support for changing vq properties in
>   DRIVER_OK when device is suspended. Added support in the driver as
>   well.
> - Dropped Acked-by for the patches that had the tag mistakenly
>   added.
> 
> * Changes in v3:
> - Faulty version. Please ignore.
> 
> * Changes in v2:
> - Added mr refcounting patches.
> - Deleted unnecessary patch: "vdpa/mlx5: Split function into locked and
>   unlocked variants"
> - Small print improvement in "Introduce per vq and device resume"
>   patch.
> - Patch 1/7 has been applied to mlx5-vhost branch.
> 
> 
> Dragos Tatulea (15):
>   vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
>   vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND flag
>   vdpa: Accept VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND backend
>     feature
>   vdpa: Accept VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND backend
>     feature
>   vdpa: Track device suspended state
>   vdpa: Block vq address change in DRIVER_OK unless device supports it
>   vdpa: Block vq state change in DRIVER_OK unless device supports it
>   vdpa/mlx5: Expose resumable vq capability
>   vdpa/mlx5: Allow modifying multiple vq fields in one modify command
>   vdpa/mlx5: Introduce per vq and device resume
>   vdpa/mlx5: Mark vq addrs for modification in hw vq
>   vdpa/mlx5: Mark vq state for modification in hw vq
>   vdpa/mlx5: Use vq suspend/resume during .set_map
>   vdpa/mlx5: Introduce reference counting to mrs
>   vdpa/mlx5: Add mkey leak detection
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  10 +-
>  drivers/vdpa/mlx5/core/mr.c        |  69 +++++++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 218 ++++++++++++++++++++++++++---
>  drivers/vhost/vdpa.c               |  51 ++++++-
>  include/linux/mlx5/mlx5_ifc.h      |   3 +-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
>  include/uapi/linux/vhost_types.h   |   8 ++
>  7 files changed, 322 insertions(+), 41 deletions(-)
> 
> -- 
> 2.43.0


