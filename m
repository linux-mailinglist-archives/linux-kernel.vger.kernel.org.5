Return-Path: <linux-kernel+bounces-21810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F9082949E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C65E1C2593F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8CE3C097;
	Wed, 10 Jan 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evdm9QVv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F83A27E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704873715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhS5A7tl/uywNAVxzqgUdgpEvRWCxnpPFs8rrAowgR0=;
	b=evdm9QVvUFETJ+7pf0DU1Y2IYWhkM0nRyfyK4HmbYEwlAylzZW8h+UONsSu4ua05lbfELh
	SsGCcSnL1a2y6m3VeTstFAsUUr3B5QYsX9rKcmyuFBc67X/W2TDLnR8NjUgiloYoeKBn89
	Hu/j0rOcjrCjOowte6a+yBKVmQTKsHI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-hkyV6nAVPDWvQcPuzTryTg-1; Wed, 10 Jan 2024 03:01:53 -0500
X-MC-Unique: hkyV6nAVPDWvQcPuzTryTg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e530b7596so7624675e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704873712; x=1705478512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhS5A7tl/uywNAVxzqgUdgpEvRWCxnpPFs8rrAowgR0=;
        b=fwQRL3Gblgixw+UaCGwFv89t/ofKDndolDXCOQfeIIiiZ3bTY1KTftRMaP4etMA9uV
         H/THdr4I2EgyKUjtvyAUs4JbPoK/a+NM7svImeKutt0WWljP6eJ45TpTep47zipNYPiz
         LZCES5n0RJvT7BHeJPjF7jaQsmHyPTfimx+wsKk2PP/c1KbYfnC9quac8oELRJ9aQA/A
         FDsn7brzcAGHfF70eQ+dDoibZ5u51evbGZPD4LayRTcbYkrH91twE7mxJKSQiNwZqkpm
         /HMV6a0AMBVei4uJOQej1iF3jD7JqrYYWyEymRYmrTm7eW9DysGLvaLRxCNOqi+bZxJ3
         2DCQ==
X-Gm-Message-State: AOJu0YydcQjsPcdQMYtqpFcQPETW/IIIsY3oGvdA971IvHzz03cxwnRu
	BxEjtsf795BhB+DxZrGoqwQ/X4gFT22X5P9DSXDgQVmH+IO7mH951IKsmnB2AkSnb+X1oYdlhQh
	1Cmf91LHhBUZtfWOb0ki83B++avazbNgd
X-Received: by 2002:a7b:ca45:0:b0:40e:4df9:8996 with SMTP id m5-20020a7bca45000000b0040e4df98996mr345317wml.23.1704873712314;
        Wed, 10 Jan 2024 00:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkekCxMK/uJAHDEhg7TzPrNHweUGTbl7o5uzeSclp37gm5JnIkTH1E+AKAqyk8FrSpNN6axg==
X-Received: by 2002:a7b:ca45:0:b0:40e:4df9:8996 with SMTP id m5-20020a7bca45000000b0040e4df98996mr345304wml.23.1704873711915;
        Wed, 10 Jan 2024 00:01:51 -0800 (PST)
Received: from redhat.com ([2.52.133.193])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0040d8ff79fd8sm1229542wmo.7.2024.01.10.00.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:01:51 -0800 (PST)
Date: Wed, 10 Jan 2024 03:01:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zheyun Shen <szy0127@sjtu.edu.cn>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	david <david@redhat.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH] driver/virtio: Add Memory Balloon Support for SEV/SEV-ES
Message-ID: <20240110025544-mutt-send-email-mst@kernel.org>
References: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>

On Wed, Jan 10, 2024 at 02:22:42PM +0800, Zheyun Shen wrote:
> For now, SEV pins guest's memory to avoid swapping or
> moving ciphertext, but leading to the inhibition of
> Memory Ballooning.
> 
> In Memory Ballooning, only guest's free pages will be relocated
> in balloon inflation and deflation, so the difference of plaintext
> doesn't matter to guest.
> 
> Memory Ballooning is a nice memory overcommitment technology can
> be used in CVM based on SEV and SEV-ES, so userspace tools can
> provide an option to allow SEV not to pin memory and enable 
> Memory Ballooning. Guest kernel may not inhibit Balloon and 
> should set shared memory for Balloon decrypted.
> 
> Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>

Sorry I don't get what you are saying at all.
Please format the commit log along the following lines:

Currently .....
This is bad because ...
To fix ...
As a result ...


> ---
>  drivers/virtio/virtio_balloon.c | 18 ++++++++++++++++++
>  drivers/virtio/virtio_ring.c    |  7 +++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1fe93e93f..aca4c8a58 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -18,6 +18,9 @@
>  #include <linux/wait.h>
>  #include <linux/mm.h>
>  #include <linux/page_reporting.h>
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +#include <linux/set_memory.h>
> +#endif
>  
>  /*
>   * Balloon device works in 4K page units.  So each page is pointed to by
> @@ -870,6 +873,9 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>  static int virtballoon_probe(struct virtio_device *vdev)
>  {
>          struct virtio_balloon *vb;
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +        size_t vb_size = PAGE_ALIGN(sizeof(*vb));
> +#endif
>          int err;
>  
>          if (!vdev->config->get) {
> @@ -878,11 +884,19 @@ static int virtballoon_probe(struct virtio_device *vdev)
>                  return -EINVAL;
>          }
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +        vdev->priv = vb = kzalloc(vb_size, GFP_KERNEL);
> +#else
>          vdev->priv = vb = kzalloc(sizeof(*vb), GFP_KERNEL);
> +#endif
>          if (!vb) {
>                  err = -ENOMEM;
>                  goto out;
>          }
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +        set_memory_decrypted((unsigned long)vb, vb_size / PAGE_SIZE);
> +        memset(vb, 0, vb_size);
> +#endif
>  
>          INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
>          INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
> @@ -1101,7 +1115,11 @@ static int virtballoon_validate(struct virtio_device *vdev)
>          else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
>                  __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +        __virtio_set_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
> +#else
>          __virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
> +#endif
>          return 0;
>  }
>  
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 49299b1f9..875612a2e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -14,6 +14,9 @@
>  #include <linux/kmsan.h>
>  #include <linux/spinlock.h>
>  #include <xen/xen.h>
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +#include <linux/set_memory.h>
> +#endif
>  
>  #ifdef DEBUG
>  /* For development, we want to crash whenever the ring is screwed. */
> @@ -321,6 +324,10 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>                  if (queue) {
>                          phys_addr_t phys_addr = virt_to_phys(queue);
>                          *dma_handle = (dma_addr_t)phys_addr;
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +                        set_memory_decrypted((unsigned long)queue, PAGE_ALIGN(size) / PAGE_SIZE);
> +                        memset(queue, 0, PAGE_ALIGN(size));
> +#endif
>  
>                          /*
>                           * Sanity check: make sure we dind't truncate

No way I am going to spead CONFIG_AMD_MEM_ENCRYPT all over the place
like this.


> --
> 2.34.1


