Return-Path: <linux-kernel+bounces-22846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320E82A3EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6642289F00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1D4F895;
	Wed, 10 Jan 2024 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCO2jIRI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF54EB35
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704925525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LbvHor4sr0xWUt5flKWQxxo/1Tbqrvytr+t1oavL/pw=;
	b=eCO2jIRIut2UlVaoH93BzJg5itwQbnNx4ZvLhZ4JCIVk2pQjaOy9CV1TnapkYAg1mnZxIX
	kfXhxokPUz/svHSIBheEwFy0naDBrRGL/MrtbMGtDyIFsBmkHNCoX4GGQUQtngD8mGBJpP
	6Zg1p2uIoDFVFXaX0cUnUeLrS2zHL6I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-RfvVgGqnPDaVS5kMSz0uuw-1; Wed, 10 Jan 2024 17:25:23 -0500
X-MC-Unique: RfvVgGqnPDaVS5kMSz0uuw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3368c707b03so2704267f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925522; x=1705530322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbvHor4sr0xWUt5flKWQxxo/1Tbqrvytr+t1oavL/pw=;
        b=dd2i1JGwGU4iwkixtgoRCukEaB8NvIBLNrEiV5x535lJHgG+jWwS+1iGckEylUxqrh
         Shr1XaNqr/ZOsAlflXrY4ZyuqJQliPe2OFhFPpHSHgoL5UsEJoc6/C8mEAOEmuCGazCU
         5WmhsBHgAXkWsut6/O65/zTyj82WEwEF033X/763u6f64IaDyKW+otYf3mMX3msCDgNC
         B2ZSOc4/Q0TmUOGjw281usICCOGejTXMIOlJKEN9dv0fktzXo/w9rRUXBnT6UatTNE4D
         mTj2STYNcMQPyKjIV029qg8ZXhXbC9F6AFcxueME7ab1HOWK/7I6vZ62uDQ4mm73JtJx
         U01g==
X-Gm-Message-State: AOJu0YyxxdTlw7ANjAPf9xm4hClDhCeyFQDQmkJOlNtDsMmx8O9hwvml
	lMPWeEJeVrTp5TBThp9bAz95mZED6Z1raEDmcvQcK3svci1NkgBt/GQ0UkmpF5NN38lVE+xb2kZ
	KVcYqFLKSHOH1RLb+Z9WsBM2PaF8AeXmJ
X-Received: by 2002:a05:6000:18d1:b0:336:6c01:4a92 with SMTP id w17-20020a05600018d100b003366c014a92mr75187wrq.1.1704925522586;
        Wed, 10 Jan 2024 14:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4bG5HIN2EOROQjKy4ly5IS5OGPCjThp6MgjKpTRQ9pvJ7CGd8hXcoyJdZJ1RPWE28zwrdpA==
X-Received: by 2002:a05:6000:18d1:b0:336:6c01:4a92 with SMTP id w17-20020a05600018d100b003366c014a92mr75179wrq.1.1704925522280;
        Wed, 10 Jan 2024 14:25:22 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id b9-20020a5d4b89000000b003366aad3564sm5807985wrt.30.2024.01.10.14.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:25:21 -0800 (PST)
Date: Wed, 10 Jan 2024 17:25:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20240110172459-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>

On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> 
> Hi All
> This code provides the iommufd support for vdpa device
> This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> v6,6-rc3
> Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 
> I will continue working on it
> 
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Was this abandoned?

> 
> Cindy Lu (8):
>   vhost/iommufd: Add the functions support iommufd
>   Kconfig: Add the new file vhost/iommufd
>   vhost: Add 3 new uapi to support iommufd
>   vdpa: Add new vdpa_config_ops to support iommufd
>   vdpa_sim :Add support for iommufd
>   vdpa: change the map/unmap process to support iommufd
>   vp_vdpa::Add support for iommufd
>   iommu: expose the function iommu_device_use_default_domain
> 
>  drivers/iommu/iommu.c             |   2 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
>  drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
>  drivers/vhost/Kconfig             |   1 +
>  drivers/vhost/Makefile            |   1 +
>  drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
>  drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
>  drivers/vhost/vhost.h             |  21 +++
>  include/linux/vdpa.h              |  38 +++++-
>  include/uapi/linux/vhost.h        |  66 ++++++++++
>  10 files changed, 525 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/vhost/iommufd.c
> 
> -- 
> 2.34.3


