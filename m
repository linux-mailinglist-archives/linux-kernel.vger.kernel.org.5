Return-Path: <linux-kernel+bounces-24812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA982C2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2448828374A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64A6EB61;
	Fri, 12 Jan 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cargjHlO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3432C7F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705073765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJcU6u6PnHNcgJkHl1PZufsrGB2VSkf8RmxbXziQJ6Y=;
	b=cargjHlO4Nrj4kLtwEBnVWO8jV9WOl3rs4GV9+hIrlYh7xs3gCNAhdcJXmosvwuar6YPBO
	EDjuqBTHzXAFnZmIPRXWN4K3cJx4DlRPcXpnsyImXDL262y7cqrMUZsYTBjY2wpPBxpeHU
	5zdpG/pr90xMdXjMRmdMyVufWrsawbM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-FO0ye2FMNXa_F1vWn26XiQ-1; Fri, 12 Jan 2024 10:35:55 -0500
X-MC-Unique: FO0ye2FMNXa_F1vWn26XiQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bb454e1d63so709143939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705073751; x=1705678551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJcU6u6PnHNcgJkHl1PZufsrGB2VSkf8RmxbXziQJ6Y=;
        b=aZzRRGGAkVnqVZ/ps1TUFUqCQUw5vwkWvz0al3xdZNtUCl9/EQ7O+vAOz9+9I3uqsn
         YepO2apvx7yKCViPi6jtzgHJzfyhUmiH820oUWFFvzn7ml320dOElsOVQK8E1TryKex5
         JYLphY2uNggEIsKtiZoGt+oQyBwpPh1jzb+N3rueIm434iB4cY6WvANZTBR45LBly8gt
         e0p3qaQAOyEVyS2Fu1VgfNRX9JGdesSCe175vc4YYBj3a2VbYbJs4MHC1ZUNGBEq6fJQ
         sU8kLIMk3jpgi6mQ8pFy/gVOs70ZS9Qp9pWg7H83ptfTbcEtmnqhWfup1g4WPzlSMrLS
         8pCQ==
X-Gm-Message-State: AOJu0YxMs0rAtiY3jGaYCb9jAM/kKRCH6P9lcUzHgzhxfcFlnLeEzXV9
	f6c8nBOu23O49T+eoWDS4sZTg1cE5laRpVAva2dmP3ViY0mYdKj3RQT3ygf1nkzkFgR46DHj6WD
	A/fsBjfFd6ltYTPHgKP1I+YkBiTIYmWrbtvioP4W1
X-Received: by 2002:a5e:8907:0:b0:7bc:329d:574 with SMTP id k7-20020a5e8907000000b007bc329d0574mr1757907ioj.29.1705073751141;
        Fri, 12 Jan 2024 07:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH12+vRux/vNmWFM6SsHmzUZ4nASmziP9IsU2T7grZR4Z0cAS5UOjd9JwhXgrlR5g/WT+y6xw==
X-Received: by 2002:a5e:8907:0:b0:7bc:329d:574 with SMTP id k7-20020a5e8907000000b007bc329d0574mr1757898ioj.29.1705073750929;
        Fri, 12 Jan 2024 07:35:50 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id s20-20020a6bdc14000000b007bc4b12d5ddsm861328ioc.3.2024.01.12.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 07:35:50 -0800 (PST)
Date: Fri, 12 Jan 2024 08:35:49 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: diana.craciun@oss.nxp.com, eric.auger@redhat.com,
 Bharat.Bhushan@nxp.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/fsl-mc: Remove unnecessary free in
 vfio_set_trigger
Message-ID: <20240112083549.04db8f8a.alex.williamson@redhat.com>
In-Reply-To: <20240112072128.141954-1-chentao@kylinos.cn>
References: <20240112072128.141954-1-chentao@kylinos.cn>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 15:21:28 +0800
Kunwu Chan <chentao@kylinos.cn> wrote:

> 'irq->name' is initialed by kasprintf, so there is no need
> to free it before initializing.

This is just as bogus as the vfio-platform version.  Thanks,

Alex
 
> Fixes: cc0ee20bd969 ("vfio/fsl-mc: trigger an interrupt via eventfd")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> index d62fbfff20b8..31f0716e7ab3 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> @@ -69,7 +69,6 @@ static int vfio_set_trigger(struct vfio_fsl_mc_device *vdev,
>  	hwirq = vdev->mc_dev->irqs[index]->virq;
>  	if (irq->trigger) {
>  		free_irq(hwirq, irq);
> -		kfree(irq->name);
>  		eventfd_ctx_put(irq->trigger);
>  		irq->trigger = NULL;
>  	}


