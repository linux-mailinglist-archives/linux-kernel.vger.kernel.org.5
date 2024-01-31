Return-Path: <linux-kernel+bounces-46163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D037D843B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D82288EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093769958;
	Wed, 31 Jan 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNcN/R2w"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4242049
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694564; cv=none; b=fFykXUO2MN6V3KpE2JzcUQTw+9I51eOurLxQWLJ6DnU5jRsFf2eWFAzmvLSBbeH0qnecoDc7EkzFbnNqdY3iEWFssk4JfDW35MmQdmHj/MPIFwc872moI42r57f5C+tbavzRdHi74ftJmTqOGgKFnefwmFVP5lqSrWHunC0ENws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694564; c=relaxed/simple;
	bh=3WZG+O6un1dKDP24kld+VKwUNPB9flc3TXLTvV3N9nw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0CVvNU3RG9vNFFBRJQQkGHDOwsxGwF2W6MU5hFbyFICbVglVmLBiKqymPS2dkHTC0oUdbNyj/F8SEoQwl3kd/bcp039gp5qCk8DdOG1Ed49ORg4Ph6Ohro67pq3y3mZ5QYI9gbTjlyLj2x+yVWRDPP+YEErUiJN4Dv4Ty2vYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNcN/R2w; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51109060d6aso4934426e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706694560; x=1707299360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlHWxlUqyXnTVwbRvj+J/cXzpPAlxBWkdZIjC12r5XI=;
        b=HNcN/R2wD/3Lr+GT7LiUGIpJrBXA46eNEkEWRU7XUp+UjExm5NyEXxORcurdAnLSIz
         FwEqe4rvscZV87H7WGINzY5zJwOdYUnZUOjerbibbJ2T8F/6TsTttIl9kdL1npylq6iC
         ohOzV3XolihyrQwrk6cwP6j3GsfqXiP/+Ej8efjLqrgZTpVBfla0KoT+3top1/ecHNwP
         pYhQUmjcpffdo8Dqs32wE+TQYve8rzSbcyh0XDnfjex0d4AQoZceTa1HiqJ/JIs2WMy/
         flFMNMv8labeDa2qr+yn+ZkP1eHFHMvd8/voaj+EUN7bmhyiBaE3Zh5AwLop1GdBXcqo
         horw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706694560; x=1707299360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlHWxlUqyXnTVwbRvj+J/cXzpPAlxBWkdZIjC12r5XI=;
        b=CsCvS9mzTLXXhenK4WNNuVoiqpvGBMS6s/Vw+PBZa7jtlE7/3bvJMjoTpJMRUoNZK8
         T93vhI9cwIBb7frBPipDy22oOfvwKfGxhfQ224r819SGEXkIN1vEtcCqulffNmn5D/UG
         VFlluRMuuuel3c3J97RX2PdD0hF7u1rQj9hlPocUUMX9zkIcd7KpwZp+BNokl12ZI0IX
         D8qY7fnuzWSlNRY7fVrH3FLZ7YcYhQiqu06aHjLrTREMoXj0GPrFHDsZ8oVLptfBvW2l
         kl4aJg7BXIfvKJ6sN39dspK/ZTyZPc3Zq1sr6gnMnRN4TwQ3gNxR5APIz3ID1qQDTRIA
         60ew==
X-Gm-Message-State: AOJu0Yx19dEjQi0+HirXhrGVmvhF5OJ3yZ0G22iKq6Rcjf7PvQmJnUeG
	ZNPAP/dRmhVcSZUvkAI6YYekmuG9FbAUhZpCNxLt8k4LlDhROTbU
X-Google-Smtp-Source: AGHT+IGe9pSSTvEwxUOmgQQdOJSgWSmwSkZ/D5P+RgNjbFhDreI/xzRdL/S4QjkYb1titXb+nSd7Mg==
X-Received: by 2002:a05:6512:b90:b0:511:1b29:244a with SMTP id b16-20020a0565120b9000b005111b29244amr1003440lfv.6.1706694560560;
        Wed, 31 Jan 2024 01:49:20 -0800 (PST)
Received: from pc636 (host-90-233-198-33.mobileonline.telia.com. [90.233.198.33])
        by smtp.gmail.com with ESMTPSA id er15-20020a05651248cf00b005110bbfcea0sm1151141lfb.169.2024.01.31.01.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:49:20 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 31 Jan 2024 10:49:17 +0100
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] mm: vmalloc: Refactor vmalloc_dump_obj() function
Message-ID: <ZboXnWWxTAk2WKnb@pc636>
References: <20240124180920.50725-1-urezki@gmail.com>
 <20240124180920.50725-2-urezki@gmail.com>
 <b49d2302-ace3-4306-b18f-70e8d7960111@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49d2302-ace3-4306-b18f-70e8d7960111@lucifer.local>

On Tue, Jan 30, 2024 at 06:50:48PM +0000, Lorenzo Stoakes wrote:
> On Wed, Jan 24, 2024 at 07:09:20PM +0100, Uladzislau Rezki (Sony) wrote:
> > This patch tends to simplify the function in question,
> > by removing an extra stack "objp" variable, returning
> > back to an early exit approach if spin_trylock() fails
> > or VA was not found.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index b8be601b056d..449f45b0e474 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -4696,34 +4696,35 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> >  #ifdef CONFIG_PRINTK
> >  bool vmalloc_dump_obj(void *object)
> >  {
> > -	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> >  	const void *caller;
> > +	struct vm_struct *vm;
> >  	struct vmap_area *va;
> >  	struct vmap_node *vn;
> >  	unsigned long addr;
> >  	unsigned int nr_pages;
> > -	bool success = false;
> > -
> > -	vn = addr_to_node((unsigned long)objp);
> >
> > -	if (spin_trylock(&vn->busy.lock)) {
> > -		va = __find_vmap_area((unsigned long)objp, &vn->busy.root);
> > +	addr = PAGE_ALIGN((unsigned long) object);
> > +	vn = addr_to_node(addr);
> >
> > -		if (va && va->vm) {
> > -			addr = (unsigned long)va->vm->addr;
> > -			caller = va->vm->caller;
> > -			nr_pages = va->vm->nr_pages;
> > -			success = true;
> > -		}
> > +	if (!spin_trylock(&vn->busy.lock))
> > +		return false;
> >
> > +	va = __find_vmap_area(addr, &vn->busy.root);
> > +	if (!va || !va->vm) {
> >  		spin_unlock(&vn->busy.lock);
> > +		return false;
> >  	}
> >
> > -	if (success)
> > -		pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> > -			nr_pages, addr, caller);
> > +	vm = va->vm;
> > +	addr = (unsigned long) vm->addr;
> 
> Hmm not so nice to reuse addr here for something different, might be nice
> to have separate obj_addr and vm_addr or something. But it's not critical!
> 
> > +	caller = vm->caller;
> > +	nr_pages = vm->nr_pages;
> > +	spin_unlock(&vn->busy.lock);
> >
> > -	return success;
> > +	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> > +		nr_pages, addr, caller);
> > +
> > +	return true;
> >  }
> >  #endif
> >
> > --
> > 2.39.2
> >
> 
> Other than the nit, which I don't insist on, this is a big improvement so,
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
>

Thanks!

--
Uladzislau Rezki

