Return-Path: <linux-kernel+bounces-6511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F2B8199CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4696D285C04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB6199C6;
	Wed, 20 Dec 2023 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCTUrICr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7E18E08
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703058292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZERZ9fezBuG8sZHm3H+h3yZuPI8dAYPQNjqzuU3nTQw=;
	b=MCTUrICruMxJnvcUH1Du/I2S6iyOBeG4QHu3iofRR+FeFp8at8tN/RxIBRFHoWuOv29T28
	A4Le1xhEQkfuLBGWoS8fbJyhR06Hynu5+blkM1iIN6lrpxPl7G5T5cr8jvssVkoRrCLF0O
	PH0XqB0/7NTMPNPedJCEC7Gz47hR+PQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-f9YL7HLQOfCPjebWAAYowQ-1; Wed, 20 Dec 2023 02:44:51 -0500
X-MC-Unique: f9YL7HLQOfCPjebWAAYowQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d2f7007e6so7688145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703058290; x=1703663090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZERZ9fezBuG8sZHm3H+h3yZuPI8dAYPQNjqzuU3nTQw=;
        b=t3Ew38s4rpWDUGa4OeG2vvkMRTKnLdl4Ag46AkigzoO60MT0nSwJZ5gRQ97oA2z8UL
         pCOeMQzYlOBfoJLXaQiw18ozQRj6tGCq+zxdeOwNVD1mvIBkFXYHXQslCCtaOTxxPCSi
         wpnu4ko5HO6RFMER793OQ34JQPmtVSxTC/dkIITmh97sdqiIX8USrhFEjdG53rilbuLj
         8Guvj0E1rGWEBVQzLJNZoCZpL2VjIkDuzvNH69VLu6nlg7swAs1DUNu/IIDTUjaUTe0F
         YDgnJ7dVKnuP/iUpoWr4z/PGKDamVH9JZeRwboCOWleETGoM3yIHEzKPOhhTEf8ddoO4
         db6Q==
X-Gm-Message-State: AOJu0Yz6FbPc+KYg69iEyMIde9sglmPqocgaG2tWp/R9I7wL+T4X7nIG
	FfsSWJ4OTgORoLNu84wBZZJn+EqjEKupUlA2Rv5lMwl9sVuwJEtCxliDDlDOYGZmuvhtHvAsmy9
	EW3xmzvWV5CoSAk1DJmQdCavx
X-Received: by 2002:a05:600c:4da5:b0:40c:22c7:598d with SMTP id v37-20020a05600c4da500b0040c22c7598dmr9986940wmp.179.1703058289801;
        Tue, 19 Dec 2023 23:44:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9tONKCILe3+cD+jg2qxbWgafKidT3BoLZOCmcOeN1Q83KMevJyvSqyePqGFhoSWeIk8oOwg==
X-Received: by 2002:a05:600c:4da5:b0:40c:22c7:598d with SMTP id v37-20020a05600c4da500b0040c22c7598dmr9986928wmp.179.1703058289465;
        Tue, 19 Dec 2023 23:44:49 -0800 (PST)
Received: from redhat.com ([2.52.148.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040d1774b4e4sm6207820wmq.42.2023.12.19.23.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:44:48 -0800 (PST)
Date: Wed, 20 Dec 2023 02:44:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Changyuan Lyu <changyuanl@google.com>
Cc: dan.j.williams@intel.com, dave.jiang@intel.com, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	pankaj.gupta.linux@gmail.com, virtualization@lists.linux.dev,
	vishal.l.verma@intel.com, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v3] virtio_pmem: support feature SHMEM_REGION
Message-ID: <20231220023653-mutt-send-email-mst@kernel.org>
References: <20231220020100-mutt-send-email-mst@kernel.org>
 <20231220073227.252605-1-changyuanl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220073227.252605-1-changyuanl@google.com>

On Tue, Dec 19, 2023 at 11:32:27PM -0800, Changyuan Lyu wrote:
> On Tue, Dec 19, 2023 at 11:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > This is not a great description. Please describe what the patch does.
> 
> Thanks for the feedback! Please see the v3 patch below.
> 
> ---8<---
> 
> This patch adds the support for feature VIRTIO_PMEM_F_SHMEM_REGION
> (virtio spec v1.2 section 5.19.5.2 [1]). Feature bit
> VIRTIO_PMEM_F_SHMEM_REGION is added to the driver feature
> table.
> 
> If the driver feature bit VIRTIO_PMEM_F_SHMEM_REGION is found,
> during probe, virtio pmem ignores the `start` and `size` fields in
> device config and looks for a shared memory region of id 0. The
> physical address range of the pmem is then determined by the physical
> address range of shared memory region 0.
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-6480002
> 
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> 
> ---
> v3:
>   * updated the patch description.
> V2:
>   * renamed VIRTIO_PMEM_SHMCAP_ID to VIRTIO_PMEM_SHMEM_REGION_ID
>   * fixed the error handling when region 0 does not exist
> ---
>  drivers/nvdimm/virtio_pmem.c     | 30 ++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_pmem.h |  8 ++++++++
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index a92eb172f0e7..8e447c7558cb 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -35,6 +35,8 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  	struct nd_region *nd_region;
>  	struct virtio_pmem *vpmem;
>  	struct resource res;
> +	struct virtio_shm_region shm_reg;
> +	bool have_shm;
>  	int err = 0;
>  
>  	if (!vdev->config->get) {
> @@ -57,10 +59,24 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  		goto out_err;
>  	}
>  
> -	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> -			start, &vpmem->start);
> -	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> -			size, &vpmem->size);
> +	if (virtio_has_feature(vdev, VIRTIO_PMEM_F_SHMEM_REGION)) {
> +		have_shm = virtio_get_shm_region(vdev, &shm_reg,
> +				(u8)VIRTIO_PMEM_SHMEM_REGION_ID);
> +		if (!have_shm) {
> +			dev_err(&vdev->dev, "failed to get shared memory region %d\n",
> +					VIRTIO_PMEM_SHMEM_REGION_ID);
> +			err = -ENXIO;
> +			goto out_vq;

Maybe additionally, add a validate callback and clear
VIRTIO_PMEM_F_SHMEM_REGION if VIRTIO_PMEM_SHMEM_REGION_ID is not there.




> +		}
> +		vpmem->start = shm_reg.addr;
> +		vpmem->size = shm_reg.len;
> +	} else {
> +		virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> +				start, &vpmem->start);
> +		virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> +				size, &vpmem->size);
> +	}
> +
>  
>  	res.start = vpmem->start;
>  	res.end   = vpmem->start + vpmem->size - 1;
> @@ -122,7 +138,13 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
>  	virtio_reset_device(vdev);
>  }
>  
> +static unsigned int features[] = {
> +	VIRTIO_PMEM_F_SHMEM_REGION,
> +};
> +
>  static struct virtio_driver virtio_pmem_driver = {
> +	.feature_table		= features,
> +	.feature_table_size	= ARRAY_SIZE(features),
>  	.driver.name		= KBUILD_MODNAME,
>  	.driver.owner		= THIS_MODULE,
>  	.id_table		= id_table,
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> index d676b3620383..c5e49b6e58b1 100644
> --- a/include/uapi/linux/virtio_pmem.h
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -14,6 +14,14 @@
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_config.h>
>  
> +/* Feature bits */
> +#define VIRTIO_PMEM_F_SHMEM_REGION 0	/* guest physical address range will be
> +					 * indicated as shared memory region 0
> +					 */


Either make this comment shorter to fit in one line, or put the
multi-line comment before the define.

> +
> +/* shmid of the shared memory region corresponding to the pmem */
> +#define VIRTIO_PMEM_SHMEM_REGION_ID 0
> +
>  struct virtio_pmem_config {
>  	__le64 start;
>  	__le64 size;
> -- 
> 2.43.0.472.g3155946c3a-goog


