Return-Path: <linux-kernel+bounces-125828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBB892CCF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2A1282A40
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A970741C7A;
	Sat, 30 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZmYojU5"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2348475
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711827562; cv=none; b=azD/lM1d8dLxOULzwIdaWtXuBDxuLIyBPNtVju3NN4knAtfPDaxAlVg3pxvFqXC81yVdL4JAcASoMdv00BUAjH6vMwTygeZdNrdha/pbE5VN15AxA6jVXoO/kn4AQunhrDl+z9BEYhUERFV1tDEsE+wsKaRf4FIi2CCvl+sIt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711827562; c=relaxed/simple;
	bh=QxNRlEPxgkUJ/mPIMLIuNJ2dvdyBjDPr8Apnp3N3lnc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvzGQkfV96Cfyk1DLfapYe8eSpAHzz/T4ORgXP1z5zOfNpVCjVaCtTxLuRrcY/TdJbFFJAVyKkP/Y7p3aDqefFIO4PyGdeQs0Pp9LXTBx1v5/fq/nRDVM6d2OY02CVzm+Gq4E4dyL6+VjNxXnQk7lOJtkozphyo1T7c2jAOgDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZmYojU5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d475b6609eso31878981fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711827558; x=1712432358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfqmjI1cfzebWVmfdkyu+Zmzi/f2gz4T/5BjRLTJnd0=;
        b=nZmYojU5Pnq6QGwhG1EXw6qN5fwfrcmtnZll71Ly5mBcxib/44xKaNWoDog0hMtL8Y
         lTgA3PqXdFC2QvdHowHG/mVM3t8/ciGg26CRvvRmTemnaakvoXa+km0hK15zcUrt+M/Q
         h6fIGSr+qiOlKDi8A2DbfkgsRSBukAK/yaoxKgM8tp+v2S9TZlQYnNCf60gLT309Nbwe
         lVLjZ/4h/mq+llC35mPH7Bzezk4loVnEKT9pTOmV3wdVSxPJPcZGuF+BsOrzKT0Z+rnx
         tRyL1xOR0xTglQd17jfEalzIRAMI1mqTOicNImYvnG9lVgEsS+7trwQl6CGyXf9DYEsM
         mAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711827558; x=1712432358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfqmjI1cfzebWVmfdkyu+Zmzi/f2gz4T/5BjRLTJnd0=;
        b=i/wUcd8J2bxFilc6ghzlzMSpz+BszD+2VV5vWqjB/kgdXDiw4wVpzkki7LO30EJmtD
         S8EZ6RTs7t0dwDF+n0SQzOTn86RRx+3+Pr3yzoTbZpBUYLjQmCjuRgu+0KBQjNBoQnKa
         Z+ijbslFIoT/TB5MsXRb4BbkMAceDmB47JefNDCJP7jM1Nwoq8Z6H98IM9BY52dvojJ0
         DaIAiNlJuZXZWLeWxfqCUGJzf4U3LhlIcR8XLMu+WS4OVcTmi035qgyzV3obmmdK2kHz
         cybsOR4MQmR7ujsVberyqOcS+2cRYKEjyVD93UMHi529HL8ja1gWu3UTDo2dxB7YAuon
         c18Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFUQBsibWFnBRh++yj2+KIoYNb3UPPEsO70jllPMbVJ//cYVslJZMYA48o+36+zB5wjOQjPZQV7C1CH70BmBmPF84Gdj/Joe606thW
X-Gm-Message-State: AOJu0Yxp6ek5GB0cnL66SxCCDZhIxfd8dBO/e7GjRRQG+bB/qMKl1yGG
	lvGOQUI4WjeBdYDHEAiXl745elJFrjWPtG+prKGd2DGscY83Ofpy
X-Google-Smtp-Source: AGHT+IFhnItMWxn2ItV5z5c2F+sbduQ0MtA/HZITX2UNX+2G0rYtt4HyqR+OkWaY2mHXuGP3RQPjGg==
X-Received: by 2002:a2e:8699:0:b0:2d4:6815:fc6f with SMTP id l25-20020a2e8699000000b002d46815fc6fmr3242166lji.30.1711827558055;
        Sat, 30 Mar 2024 12:39:18 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q12-20020a05651c054c00b002d437894f49sm925306ljp.100.2024.03.30.12.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 12:39:17 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Sat, 30 Mar 2024 20:39:15 +0100
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix lockdep warning
Message-ID: <ZghqY6tpKsFvhETX@pc638.lan>
References: <20240328140330.4747-1-urezki@gmail.com>
 <ZgZxaOg6/qZAfUUA@MiWiFi-R3L-srv>
 <ZggLwbnaeK0AsRwQ@pc636>
 <ZggR1fW0rAHSKF+j@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZggR1fW0rAHSKF+j@MiWiFi-R3L-srv>

On Sat, Mar 30, 2024 at 09:21:25PM +0800, Baoquan He wrote:
> On 03/30/24 at 01:55pm, Uladzislau Rezki wrote:
> > On Fri, Mar 29, 2024 at 03:44:40PM +0800, Baoquan He wrote:
> > > On 03/28/24 at 03:03pm, Uladzislau Rezki (Sony) wrote:
> ......snip 
> > > How about below change about va_start_lowest? Personal preference, not
> > > strong opinion.
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 9b1a41e12d70..bd6a66c54ad2 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -1046,19 +1046,19 @@ __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
> > >  static struct vmap_node *
> > >  find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
> > >  {
> > > -	unsigned long va_start_lowest;
> > > +	unsigned long va_start_lowest = ULONG_MAX;
> > >  	struct vmap_node *vn;
> > >  	int i;
> > >  
> > >  repeat:
> > > -	for (i = 0, va_start_lowest = 0; i < nr_vmap_nodes; i++) {
> > > +	for (i = 0; i < nr_vmap_nodes; i++) {
> > >  		vn = &vmap_nodes[i];
> > >  
> > >  		spin_lock(&vn->busy.lock);
> > >  		*va = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
> > >  
> > >  		if (*va)
> > > -			if (!va_start_lowest || (*va)->va_start < va_start_lowest)
> > > +			if ((*va)->va_start < va_start_lowest)
> > >  				va_start_lowest = (*va)->va_start;
> > >  		spin_unlock(&vn->busy.lock);
> > >  	}
> > > @@ -1069,7 +1069,7 @@ find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
> > >  	 * been removed concurrently thus we need to proceed
> > >  	 * with next one what is a rare case.
> > >  	 */
> > > -	if (va_start_lowest) {
> > > +	if (va_start_lowest != ULONG_MAX) {
> > >  		vn = addr_to_node(va_start_lowest);
> > >  
> > >  		spin_lock(&vn->busy.lock);
> > > 
> > > 
> > To me it looks as incomplete. The "va_start_lowest" should be initialized
> > when repeat. Otherwise we can end up with an infinite repeating because
> > va_start_lowest != ULONG_MAX.
> 
> You are right. Anyway, it's just a suggestion from a different code
> style, please feel free to adjust it in or leave the patch as is.
> > 
>
OK!

Thank you.

--
Uladzislau Rezki



