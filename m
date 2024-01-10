Return-Path: <linux-kernel+bounces-22843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5882A3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2272B28A880
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1FA5024A;
	Wed, 10 Jan 2024 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEvgD3ZH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113350241
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704925449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fBOWuD+AHY9IJNnA7VqxZgcnrcyqcpD70bfuMsWeGQY=;
	b=jEvgD3ZHuS3Hmu7ciiWvF/yoeTwYdMJ6pwZxOugz4QttpVQzJrQz5rbI4Pd/VrcZGu1eBJ
	yqkq7O/WA5mUua+g48xxGg7XqOCwzVVdpZyQzuMt01qDbDGWS9sffSOmQYxqSQ7TQp7ONc
	dKL5rCmd6eQOkyqoB5wPtNQOq2XqSEE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-pzmDWmo2NZ-zgHUhhjjPXw-1; Wed, 10 Jan 2024 17:24:08 -0500
X-MC-Unique: pzmDWmo2NZ-zgHUhhjjPXw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e566259e3so8895875e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925446; x=1705530246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBOWuD+AHY9IJNnA7VqxZgcnrcyqcpD70bfuMsWeGQY=;
        b=ke5HvYORxKlKUDrapCAdoceegvQr5OcGQNw5cOCErqlBRydT0drJ4PKaBm+7j4JDEL
         wZ46cmQKkgonPedADkHmhXVcUdsr+EMVaBHYGLUB4aoeLc8HKgQuBKSF8p8Ek7x64Ew4
         qaXvO+qbr8+qddWItGbj5Tnm4VJbLApIiqtaM1IxFxUm+XFBhl3//xCZOTdA0ZJX0iQl
         k5Den5DTXhplkz14CbGRByxz7CAZCI9bA8dbNRdJDO1G94lrVmipv0aCGMtbOkOT1XvB
         rQj4CS57mRAip811jaofLG+4V9+kghX8EZwMwdvQPNdePQtfrXMA3VvMgLMjUv5ebH0C
         sbbQ==
X-Gm-Message-State: AOJu0YyMlt6koeWDHSsyTrDfWfd8u+vPq0qoMvn1qvA+1V1ny9zV761a
	trWVc9zOpb5x/wGbqfqnpct4itrfpvCmMA0uLFBN98896MniU4lpUSGbZ3s4b6edeR78QtRGCE7
	EMcmiib/9wUntx+9yKrHek4OXbr4z8P459gCIdfKv
X-Received: by 2002:a05:600c:4513:b0:40d:72b9:4403 with SMTP id t19-20020a05600c451300b0040d72b94403mr53599wmo.179.1704925446472;
        Wed, 10 Jan 2024 14:24:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiLiNT7yBh6m9iddoQfphuCX3lPnIYZ1lLGnv3FnzjuC2FJxsefP3JW1UmZHgl2mqZVRb2ZQ==
X-Received: by 2002:a05:600c:4513:b0:40d:72b9:4403 with SMTP id t19-20020a05600c451300b0040d72b94403mr53592wmo.179.1704925445992;
        Wed, 10 Jan 2024 14:24:05 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b0040e527602c8sm3593896wmo.9.2024.01.10.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:24:05 -0800 (PST)
Date: Wed, 10 Jan 2024 17:24:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC V1 01/13] vhost-vdpa: count pinned memory
Message-ID: <20240110172306-mutt-send-email-mst@kernel.org>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-2-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1704919215-91319-2-git-send-email-steven.sistare@oracle.com>

On Wed, Jan 10, 2024 at 12:40:03PM -0800, Steve Sistare wrote:
> Remember the count of pinned memory for the device.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Can we have iommufd support in vdpa so we do not keep extending these hacks?


> ---
>  drivers/vhost/vdpa.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index da7ec77cdaff..10fb95bcca1a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -59,6 +59,7 @@ struct vhost_vdpa {
>  	int in_batch;
>  	struct vdpa_iova_range range;
>  	u32 batch_asid;
> +	long pinned_vm;
>  };
>  
>  static DEFINE_IDA(vhost_vdpa_ida);
> @@ -893,6 +894,7 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  			unpin_user_page(page);
>  		}
>  		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
> +		v->pinned_vm -= PFN_DOWN(map->size);
>  		vhost_vdpa_general_unmap(v, map, asid);
>  		vhost_iotlb_map_free(iotlb, map);
>  	}
> @@ -975,9 +977,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  		return r;
>  	}
>  
> -	if (!vdpa->use_va)
> +	if (!vdpa->use_va) {
>  		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
> -
> +		v->pinned_vm += PFN_DOWN(size);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.39.3


