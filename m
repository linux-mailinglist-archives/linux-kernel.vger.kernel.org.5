Return-Path: <linux-kernel+bounces-22613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982DF82A06B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C5EB258AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00894D5A8;
	Wed, 10 Jan 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6ojPa93"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CE4D587
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28bcc273833so4014608a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704912524; x=1705517324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akr6CIw5c9giePcQiETe5sre9R6VrjuOFaMQiXaiTBM=;
        b=E6ojPa93EFOMr/euUnp0YOcZwwUIHtQExFNdCm/hgprRKqfYEgdp+1bIdWAcqhQ+0P
         i3a09xa5C2Hydj36+KwVi7ftPqExQcMKCoDvXKdnoH1AP3D27rGQozywEGsjZBmpgqi8
         V9bc/87R6rEMExoDcD9NiPQ6fzsHeb0ol7d5UskI75w6MYZdsOPKnLpYzrwhbF3MQcB0
         nRrei2F828AeUxUMdqQq3birAsOj3C747rK3lMYl3ietJj/PeEqDHiQtfi13HnzScA6L
         nDh8G4k7KYIAar8LGfHvRKrM4EvpKTYiEKUi82Ze+I1OabRcZ/D9Qon7n73ssuUM33bd
         rlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912524; x=1705517324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akr6CIw5c9giePcQiETe5sre9R6VrjuOFaMQiXaiTBM=;
        b=TBE0OMvpimSNSb5XKxvg0Ej+R2zYUXirsWURfy8r+q4whEbr76uS6REUp7bPsN26I0
         t8Gm49QIGUBwQsTNvf7oUBswzATtF6M0Q9k0yXekeavlJ7RCc08zFEWMM/XXnJp9k9K+
         PXWZo1lGvTXhY3pLMlMCYbLDXFPHvedfm9gFxQJWW9yuGJUNr1dxa3WPJ1/qQQyEWjt4
         CVCXC9MJw2PIncaCpvjZk08sd+AkTMzgIhI3ZDsuRUV2Gigfs0ey7XhvlA5fF/fPPff7
         F2a2Rfv8nrWm6JSQdYe2D2FAcdGL43uEj/FpdlO/f6/vyv9xXhcRrSzHRNF5R6xUourV
         k8vA==
X-Gm-Message-State: AOJu0Yz0mFMzMVUd+ZNybmx5CwKKd3z0ZGJY+hTFN1SVq/6fFx6cX43I
	UoDJ1LqJ080aeyDgIWJNYVxhs8vgZ6b0pV4bH2/5Q7EuBY0=
X-Google-Smtp-Source: AGHT+IG+Tj79AIadsBNASJ7uqTmlb9AQRUMel1OR4eJqyenpH/pAepfhWx4MXHF4y4U5CZwCHp5GIQ==
X-Received: by 2002:a17:90a:fc96:b0:28c:4b8c:9729 with SMTP id ci22-20020a17090afc9600b0028c4b8c9729mr1191345pjb.2.1704912523945;
        Wed, 10 Jan 2024 10:48:43 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:a56c:270b:b7a6:a474])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090aa11300b0028ceeca04a1sm1916286pjp.19.2024.01.10.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:48:43 -0800 (PST)
Date: Wed, 10 Jan 2024 11:48:41 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: joakim.zhang@cixtech.com
Cc: andersson@kernel.org, arnaud.pouliquen@foss.st.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com
Subject: Re: [PATCH V3] remoteproc: virtio: Fix wdg cannot recovery remote
 processor
Message-ID: <ZZ7miRHTe2LJ2PAh@p14s>
References: <20231217053659.3245745-1-joakim.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217053659.3245745-1-joakim.zhang@cixtech.com>

Good day Joakim,

On Sun, Dec 17, 2023 at 01:36:59PM +0800, joakim.zhang@cixtech.com wrote:
> From: Joakim Zhang <joakim.zhang@cixtech.com>
> 
> Recovery remote processor failed when wdg irq received:
> [    0.842574] remoteproc remoteproc0: crash detected in cix-dsp-rproc: type watchdog
> [    0.842750] remoteproc remoteproc0: handling crash #1 in cix-dsp-rproc
> [    0.842824] remoteproc remoteproc0: recovering cix-dsp-rproc
> [    0.843342] remoteproc remoteproc0: stopped remote processor cix-dsp-rproc
> [    0.847901] rproc-virtio rproc-virtio.0.auto: Failed to associate buffer
> [    0.847979] remoteproc remoteproc0: failed to probe subdevices for cix-dsp-rproc: -16
> 
> The reason is that dma coherent mem would not be released when
> recovering the remote processor, due to rproc_virtio_remove()
> would not be called, where the mem released. It will fail when
> it try to allocate and associate buffer again.
> 
> Releasing reserved memory from rproc_virtio_dev_release(), instead of
> rproc_virtio_remove().
> 
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
> Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>

I am in agreement with your patch.  I will apply it when 6.8-rc1 comes out.

Thanks,
Mathieu

> ---
> ChangeLogs:
> V1->V2:
> 	* the same for of_reserved_mem_device_release()
> V2->V3:
> 	* release reserved memory in rproc_virtio_dev_release()
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 83d76915a6ad..25b66b113b69 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -351,6 +351,9 @@ static void rproc_virtio_dev_release(struct device *dev)
>  
>  	kfree(vdev);
>  
> +	of_reserved_mem_device_release(&rvdev->pdev->dev);
> +	dma_release_coherent_memory(&rvdev->pdev->dev);
> +
>  	put_device(&rvdev->pdev->dev);
>  }
>  
> @@ -584,9 +587,6 @@ static void rproc_virtio_remove(struct platform_device *pdev)
>  	rproc_remove_subdev(rproc, &rvdev->subdev);
>  	rproc_remove_rvdev(rvdev);
>  
> -	of_reserved_mem_device_release(&pdev->dev);
> -	dma_release_coherent_memory(&pdev->dev);
> -
>  	put_device(&rproc->dev);
>  }
>  
> -- 
> 2.25.1
> 

