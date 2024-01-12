Return-Path: <linux-kernel+bounces-24810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2386882C2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24DBB24646
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A373181;
	Fri, 12 Jan 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yl7o79ix"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0C73166
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705073691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rG2cAHGtPmYkdk3n7aV573S9W6xf9H2t9/+D5tjR41Y=;
	b=Yl7o79ixG5eZCNw+GClh5miltEkeaqQ8dFjg4G+ZphWlZhTZ1l7nWSG9HkAG3HYAeKueNS
	6NQkqLVd1+bG/yYhBX9BGToV/r/JiI8Gv2i+WhnV4ZFj5xm2vhzXyH/T1WkkTDuzOTAcpY
	7Z//yPJ6FyknUH915IfigbzIBgnRD08=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-3yuK6VyqNpGaBI26Gus65w-1; Fri, 12 Jan 2024 10:34:50 -0500
X-MC-Unique: 3yuK6VyqNpGaBI26Gus65w-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so595376139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705073689; x=1705678489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG2cAHGtPmYkdk3n7aV573S9W6xf9H2t9/+D5tjR41Y=;
        b=g4y5cwuhBMXMsNzh++oIIdx1ZqA5MvrxUEhunzkyy7wNRVHsS7eBBZjoJHr0Vc1aun
         07bLQlT+zPScEcaSUnQExA0C6fMoJlacANmLfRcovwBuyhzuKMp768zRG0z+Z+CTzzX1
         mcDMTt/w0K4BSDOs+HCu/bxCJPUIZsf10fPwkZKqTRQWywK3SeyLTNVCxtG/AqUeqd/f
         1iOtTgKp1CHRU5O88DJW0OwVYvk1cC9x0Gl3b1d0z1hzk9kEI7w8Y6ptDWtjMZaIIBZF
         RDQH/EqdzF3mhRL4H9DydJp1chXicUsYH0lj725LBvOnzM8tgWDufEERiORJpoOsRPvU
         O9AA==
X-Gm-Message-State: AOJu0YyVKlQUF7KZ8Y6UrqbFmLzGn3P+IXA3Ge+/NieW7Lm0ulWVQU48
	0I8DXaMCvKfVawJOHa5DzyuElWT5GvZytjL4hdH3PezypBMP4ysp21P1c6qBeAhwaw+Ol7cgpH9
	MvGAlbZZOL87q8bVNNGhv8YdZOE7YMafS
X-Received: by 2002:a05:6602:234a:b0:7bf:bb:ab73 with SMTP id r10-20020a056602234a00b007bf00bbab73mr1616852iot.18.1705073689308;
        Fri, 12 Jan 2024 07:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2w/p+DDnIx4QjeudfMRA2nrpJ8epdw1qDUQBCBhnVfD9HwWZBu0dRc/CNRCpcwf14BesJvQ==
X-Received: by 2002:a05:6602:234a:b0:7bf:bb:ab73 with SMTP id r10-20020a056602234a00b007bf00bbab73mr1616839iot.18.1705073689087;
        Fri, 12 Jan 2024 07:34:49 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id a23-20020a6b6c17000000b007bee386f29csm812469ioh.20.2024.01.12.07.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 07:34:48 -0800 (PST)
Date: Fri, 12 Jan 2024 08:34:47 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: eric.auger@redhat.com, a.motakis@virtualopensystems.com,
 b.reynal@virtualopensystems.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/platform: Remove unnecessary free in
 vfio_set_trigger
Message-ID: <20240112083447.750ad1c6.alex.williamson@redhat.com>
In-Reply-To: <20240112064107.137384-1-chentao@kylinos.cn>
References: <20240112064107.137384-1-chentao@kylinos.cn>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 14:41:07 +0800
Kunwu Chan <chentao@kylinos.cn> wrote:

> commit 57f972e2b341 ("vfio/platform: trigger an interrupt via eventfd")
> add 'name' as member for vfio_platform_irq,it's initialed by kasprintf,
> so there is no need to free it before initializing.

What?!  Just look at the call path where vfio_set_trigger() is called
with a valid fd and existing trigger.  This change would leak irq->name
as it's reallocated via kasprintf().  Thanks,

Alex
 
> Fixes: 57f972e2b341 ("vfio/platform: trigger an interrupt via eventfd")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/vfio/platform/vfio_platform_irq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> index 61a1bfb68ac7..5e3fd1926366 100644
> --- a/drivers/vfio/platform/vfio_platform_irq.c
> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> @@ -179,7 +179,6 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
>  	if (irq->trigger) {
>  		irq_clear_status_flags(irq->hwirq, IRQ_NOAUTOEN);
>  		free_irq(irq->hwirq, irq);
> -		kfree(irq->name);
>  		eventfd_ctx_put(irq->trigger);
>  		irq->trigger = NULL;
>  	}


