Return-Path: <linux-kernel+bounces-26485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A562F82E1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E245283A52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9841B597;
	Mon, 15 Jan 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyEvjTKB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6E1AAC1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705351080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdbLbZGCFdT/pJ96oyVgdplymFRW8cUQXiKLAs/70qI=;
	b=YyEvjTKBVOvq1LR+fTA0WgG2dKhEAm6SK85MlbNV8p2VEywpy08gRgPOqPHfmQ8XwzPx8y
	WxdS2a0YZ6+RdDGaOqSWXsyHfGMPpv/0NkWppMv/xqIUQv3g9RRmYrEGx3eqeaVy5Ubkdu
	cUGHafF0QhdFLyb5NubjxaJVXBlligU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-xJjkTL6QNg-WjzV0f4YGbg-1; Mon, 15 Jan 2024 15:37:59 -0500
X-MC-Unique: xJjkTL6QNg-WjzV0f4YGbg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef780be70so446635139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705351078; x=1705955878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdbLbZGCFdT/pJ96oyVgdplymFRW8cUQXiKLAs/70qI=;
        b=Qx3181XQyD4AyqCmup61KXlTH290mjWom0XvpHOr7mbxODZoM1A3xGvyjvbVypJs12
         umqksf6U9EVhg7rczhcrWMFXijBoHZyuxQKTWlKDBHoLy8svZRYC4hcNX/HxR0PXyj/W
         ULEZSP+1ezdogCjTUqZ8NtX9C+RWOLrhZvrZsgDOy94duT9JGqtsyFYejvAgOpjDAnDB
         yKIQP1H4bEGJTPFL2sCPxUt/A6/phTWbcHBJEAjoSOnHxHCLuUa0xbY6kNBwZEjI4Yoa
         1rU6eOlsBXw8wKyYI8EURvryPfrZi7EDQ0yIJ9xoK3Kz2uyYCxkoBVjBCNkJ0lCQobKL
         FSpQ==
X-Gm-Message-State: AOJu0YxsxdKe77HGLQaoCEoCaQKUrokyL9cuYilVt2fSI4oNILsyZSfw
	v2MfN6PlccXSAMq3pgGCdefIBVO8ch5Zgxz73O6hcYrobGIq0iSt+LvteLJjoeEMZcdaRFmiWnm
	58/QNFXYjx7t/BfDh2b13QJTyJXXiobw1
X-Received: by 2002:a05:6602:3314:b0:7bc:4687:1ed8 with SMTP id b20-20020a056602331400b007bc46871ed8mr6898927ioz.9.1705351078516;
        Mon, 15 Jan 2024 12:37:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWgF5ntIzVAiwiT64aLreUvO9r+NxKori8y1zLFYuh9zE8If5wQKqh2q7i6RL4bwKXdCE8pg==
X-Received: by 2002:a05:6602:3314:b0:7bc:4687:1ed8 with SMTP id b20-20020a056602331400b007bc46871ed8mr6898920ioz.9.1705351078213;
        Mon, 15 Jan 2024 12:37:58 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id gi12-20020a05663869cc00b0046ce54fea8bsm2467315jab.131.2024.01.15.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:37:57 -0800 (PST)
Date: Mon, 15 Jan 2024 13:37:56 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kvm@vger.kernel.org, kernel-janitors@vger.kernel.org, Eric Auger
 <eric.auger@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/platform: Use common error handling code in
 vfio_set_trigger()
Message-ID: <20240115133756.674ae019.alex.williamson@redhat.com>
In-Reply-To: <f1977c1c-1c55-4194-9f72-f77120b2e4e5@web.de>
References: <f1977c1c-1c55-4194-9f72-f77120b2e4e5@web.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 18:16:01 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 15 Jan 2024 18:08:29 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> in an if branch of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/vfio/platform/vfio_platform_irq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> index 61a1bfb68ac7..8604ce4f3fee 100644
> --- a/drivers/vfio/platform/vfio_platform_irq.c
> +++ b/drivers/vfio/platform/vfio_platform_irq.c
> @@ -193,8 +193,8 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
> 
>  	trigger = eventfd_ctx_fdget(fd);
>  	if (IS_ERR(trigger)) {
> -		kfree(irq->name);
> -		return PTR_ERR(trigger);
> +		ret = PTR_ERR(trigger);
> +		goto free_name;
>  	}
> 
>  	irq->trigger = trigger;
> @@ -202,9 +202,10 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
>  	irq_set_status_flags(irq->hwirq, IRQ_NOAUTOEN);
>  	ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
>  	if (ret) {
> -		kfree(irq->name);
>  		eventfd_ctx_put(trigger);
>  		irq->trigger = NULL;
> +free_name:
> +		kfree(irq->name);
>  		return ret;
>  	}
> 

TBH, this doesn't seem like a worthwhile exit point consolidation.  A
change like this might be justified if there were some common unlock
code that could be shared, but for a simple free and return errno by
jumping to a different exception block, rather than even a common exit
block, I don't see the value.  Thanks,

Alex


