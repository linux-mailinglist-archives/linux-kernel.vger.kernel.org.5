Return-Path: <linux-kernel+bounces-45141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDF842C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2134B24874
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683FC79929;
	Tue, 30 Jan 2024 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/eZSp/g"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521579921
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640653; cv=none; b=ZrlwyvGD10VGRRbCGQ+L72P4TAqBRTudRq/JhRq9VpACfQwHdoVuCQyTfw/gV4nJbx+Wqc0U+2XeKGReTI2TCTs/hdq6Dlf8myvbgWD0HDQ9KuQ3pZfkNtgskS92w8kc0NuO1g/HzFcgE2RcLKnQz3nnElHkqNodHvkzwfdm3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640653; c=relaxed/simple;
	bh=WonojsJGZufuRKGBkzQnCMjmKC9uEckBMqX4iCy/H+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joEybN+WJTFH8PxoM+m3JWE1Nj3FsamAojTlpd9Gv59ysD36R2URpDdKJk3Q3Rg+grhBg3thOm99kGxija+3ACEeYUnY4QDrPbtZrvg18ma7EWy6VrPSD8fg85fwiaSU3ycF9hBCYjg4b+6G9XSIvEW6clDH0N2Vt2cS+PC++m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/eZSp/g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ee9e21f89so38439995e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706640650; x=1707245450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CIUacINaADYtMqx3QJQeG/Z7nbsmgMvtClge7g0C+w=;
        b=b/eZSp/gSETuE1ugojcG9B/wkQpU35Vcbrnzcbp2jC7rNZKNhcaWs0ZaCJpsCKGXHj
         ZKkkmTdJFWdwKXzdf401XRPxKHk2SYnxfvBTFLB1TI/lPFr9WsRSqp48yYcQ/z/PellU
         FmgXO1GYBzzAScdHwppRaqPHgwZVYb48qstW1UgWRxOipKaWWn0Y1PrNzYzHbv8rrPNg
         2zDadpXd3ID4I3B5ncJzLDJxiovhgtt5aJzKB8BNAvVolfdMAAM/dClggwHHEEBE6AkF
         Bryi20JjGlkG3mvvuAi8hIl8jQbtmWOfaCeQV+aTzjC4Iveu6pDwsdBlHFT0LlMctyxg
         CzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640650; x=1707245450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CIUacINaADYtMqx3QJQeG/Z7nbsmgMvtClge7g0C+w=;
        b=Or0yAeuDBbQNUpjqScvJm7XxugXmDYDsv/G5QuzwR5d3/dkp7Skf1FCnwdakcDiwjk
         58kEu6QT65qoaipGLMXpbn93Dto93T+nb9Xo1fvoQI22Wq3XOfiuUAspqJJSTMGAIvF9
         w3pU24jT9u0yI+1MOq6PVhru9Yfo/2Lb79JWczuHja7pAYJobX/AfgW1YaMGTxdRH1S3
         a9Y8bsZt6CR1myVXwlwb8SFBVlE9m2QT1dvRPXSQlXpMWB++TRiSCGpd85PndBUOIWq7
         +t2eWPDGewMrB9xmNp9vgbGdqSHOE/4g5WqZyRTjFxor0MYUG1BAaw/FT2ftXgvo0Twa
         uYIg==
X-Gm-Message-State: AOJu0YzyMROQxBT7YjSjYbVgMpMEY4gWInRJBZ1KCZmRpgIFGG0RvnK2
	g1KThyi0kNOqP3KWlH50xkl/2bmR9cewMGrIm0k2InvvCTyDM3qj
X-Google-Smtp-Source: AGHT+IGVOO/A+A56LC+lfMQnzTb2hoYK4/wyQn3uch4CvYl9NIzJ3VECDxsn2WiDC9T79cPX5sh4LQ==
X-Received: by 2002:a5d:4412:0:b0:33a:eb5c:aa25 with SMTP id z18-20020a5d4412000000b0033aeb5caa25mr5495425wrq.23.1706640650029;
        Tue, 30 Jan 2024 10:50:50 -0800 (PST)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id cw7-20020a056000090700b0033afcb5b5d2sm1969574wrb.80.2024.01.30.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:50:49 -0800 (PST)
Date: Tue, 30 Jan 2024 18:50:48 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] mm: vmalloc: Refactor vmalloc_dump_obj() function
Message-ID: <b49d2302-ace3-4306-b18f-70e8d7960111@lucifer.local>
References: <20240124180920.50725-1-urezki@gmail.com>
 <20240124180920.50725-2-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124180920.50725-2-urezki@gmail.com>

On Wed, Jan 24, 2024 at 07:09:20PM +0100, Uladzislau Rezki (Sony) wrote:
> This patch tends to simplify the function in question,
> by removing an extra stack "objp" variable, returning
> back to an early exit approach if spin_trylock() fails
> or VA was not found.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b8be601b056d..449f45b0e474 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4696,34 +4696,35 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  #ifdef CONFIG_PRINTK
>  bool vmalloc_dump_obj(void *object)
>  {
> -	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>  	const void *caller;
> +	struct vm_struct *vm;
>  	struct vmap_area *va;
>  	struct vmap_node *vn;
>  	unsigned long addr;
>  	unsigned int nr_pages;
> -	bool success = false;
> -
> -	vn = addr_to_node((unsigned long)objp);
>
> -	if (spin_trylock(&vn->busy.lock)) {
> -		va = __find_vmap_area((unsigned long)objp, &vn->busy.root);
> +	addr = PAGE_ALIGN((unsigned long) object);
> +	vn = addr_to_node(addr);
>
> -		if (va && va->vm) {
> -			addr = (unsigned long)va->vm->addr;
> -			caller = va->vm->caller;
> -			nr_pages = va->vm->nr_pages;
> -			success = true;
> -		}
> +	if (!spin_trylock(&vn->busy.lock))
> +		return false;
>
> +	va = __find_vmap_area(addr, &vn->busy.root);
> +	if (!va || !va->vm) {
>  		spin_unlock(&vn->busy.lock);
> +		return false;
>  	}
>
> -	if (success)
> -		pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> -			nr_pages, addr, caller);
> +	vm = va->vm;
> +	addr = (unsigned long) vm->addr;

Hmm not so nice to reuse addr here for something different, might be nice
to have separate obj_addr and vm_addr or something. But it's not critical!

> +	caller = vm->caller;
> +	nr_pages = vm->nr_pages;
> +	spin_unlock(&vn->busy.lock);
>
> -	return success;
> +	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> +		nr_pages, addr, caller);
> +
> +	return true;
>  }
>  #endif
>
> --
> 2.39.2
>

Other than the nit, which I don't insist on, this is a big improvement so,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

