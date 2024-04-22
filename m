Return-Path: <linux-kernel+bounces-154179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F48AD8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D011F21852
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA8C16DED8;
	Mon, 22 Apr 2024 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCinPE1x"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49944C73;
	Mon, 22 Apr 2024 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827068; cv=none; b=GayMkHgeTo/S+WGE59WJuKRZnJATpypj9mVj5UZ+CIm5LUTL8QYQmRhXwCEohL0HNFYWuD/xroq8FnOaeKJIAN4avV7Yvx0qoh5aiTEAWQ166+bqaR9uNBFo7T+y07Vt12usP4PmuXsEo26erKpngpa08zRaCRy63xC0yne/CAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827068; c=relaxed/simple;
	bh=6Ac6vQ0aXcvvz3srSM0acKosA+te7+BqjbTdKTXWGyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYPv0SKuGm95SpwHu2g3bE8cfa7jDe37sPSWEW1t6dXZkBqH/KUaS5Xylq7NjJ/fzwxWHJMBRZYO+WigTJdmfuTrX+dwW3zmVzGEa1ZnyRQ/M9cTe5SKSrQ3+YNFNfTEcKnuSsH4QXt7TqfL/h2XGhOjeMyuM5arBnJQVXIcfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCinPE1x; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6114c9b4d83so40490957b3.3;
        Mon, 22 Apr 2024 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713827065; x=1714431865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+vHDpfrpWXucDC0uFH0aat5EFwvU5PRrpWR2paW/O4=;
        b=jCinPE1x3BqBxQMTSxeTqH8QlKgzroVdulPE2kuEZXWPEfFofPlEKflWai9QZo6CJK
         pqUCd+rPYMeIkr+0t+sO1kLRTMIg9wK7LOrvF7PvIv9avUXHgpWdfSdxZv/TKwq96I0c
         eGwPNUIUq6Y/UOg/m/Qa2yZVOT2ETnA0fQZq9XA5gNgS3fCifcPzHEYfu8WslSGyFxCo
         xKouKXbNUwKeN1inf+8mYlBw87KPrpKqNaziV9dsIp3hpunR0NCBchSgTdn1xCkcw+KV
         5ae5Iy7uSqFiFTWT4o+zoqe5E4W4v7mJ2uxn6N6Tm+Kp6H1XSWfCEc2twYJUw68duDHY
         Ib3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713827065; x=1714431865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+vHDpfrpWXucDC0uFH0aat5EFwvU5PRrpWR2paW/O4=;
        b=GXFwfhWTIYgntcnJqr18qYyf4+Fr0LCdxVUXksYSIroEx0/rLQjwZwj4aKKuTmRRRV
         TN0ANHB7c4IpBtkRjjWl8iJmURJOz+CWKum8+FSYoXNWMWiZs3XdxgOPklbIw4weeD4I
         99LCkAzZuuCHs9CbDioAex91SFx6LuzeCMC7OQaKqlWOV8FIf+ycsJwuSF4IZLpgIrUw
         DdJBJZGDDGhG3PEBgU7AO5Hcjb+RCWAHNaJm7NYzFhdTmIohYItyBrwD+HQ8KWb6u7ho
         2ow/Q4l/wpHVFLCWzD0PJW8eRRV0lA1cciRgVJEuIWNiPhLKheg2A5lCsuIaIeJFmXSS
         4t7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwaQNEwvoJT6yOEe5HaL0fYYrlibf/cmUzs8G1i9rBOG40F+jPNCizIdzH1gDS/fE4aJOTjqVMJASOKN5ymLEvhI7MQTGo/4h+qvf8r71b7WFciDkZZcanm5TZ1qcu0CSlLMmIEJ5BGA==
X-Gm-Message-State: AOJu0YxPDTeUzjPnZJc7lEm+gkN/VtGPAT+FEWnR5aC1hu8kYOUBXXB7
	HfQuqQesNv0xETROBzvj6vC7ABjiY3OP9En8o9hJf+9wdGVOU24w3DlOMA==
X-Google-Smtp-Source: AGHT+IEyT5gjpNg1SKPchjhC9EvW1KlqB4FVRX3CAsfPDdO8c2iAhlqRKmL4LchCE48cnLNUOhUEzA==
X-Received: by 2002:a05:690c:3701:b0:61b:33b7:9e11 with SMTP id fv1-20020a05690c370100b0061b33b79e11mr10814531ywb.9.1713827065225;
        Mon, 22 Apr 2024 16:04:25 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:baf4:bd67:a305:2140])
        by smtp.gmail.com with ESMTPSA id 5-20020a5b0105000000b00dcda90f43d7sm2194016ybx.59.2024.04.22.16.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 16:04:24 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:04:23 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: SGI-IP27: micro-optimize arch_init_irq()
Message-ID: <Zibs96v+uK/2uFT8@yury-ThinkPad>
References: <20240416173711.613750-1-yury.norov@gmail.com>
 <20240416173711.613750-2-yury.norov@gmail.com>
 <Zh+uPB0druail4XC@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh+uPB0druail4XC@alpha.franken.de>

On Wed, Apr 17, 2024 at 01:10:52PM +0200, Thomas Bogendoerfer wrote:
> On Tue, Apr 16, 2024 at 10:37:10AM -0700, Yury Norov wrote:
> > The function sets adjusted groups of bits in hub_irq_map by using
> > for-loops. There's a bitmap_set() function dedicated to do this.
> > 
> > Because [0, CPU_CALL_B_IRQ] and [NI_BRDCAST_ERR_A, MSC_PANIC_INTR]
> > ranges belong to the same machine word, bitmap_set() would boil down
> > to an inline wrapper in both cases, avoiding generating a loop, with
> > the associate overhead. Effectively, it would be a compile-time:
> > 
> > 	*hub_irq_map = GENMASK() | GENMASK();
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  arch/mips/sgi-ip27/ip27-irq.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
> > index 8f5299b269e7..d8acdf0439d2 100644
> > --- a/arch/mips/sgi-ip27/ip27-irq.c
> > +++ b/arch/mips/sgi-ip27/ip27-irq.c
> > @@ -277,7 +277,6 @@ void __init arch_init_irq(void)
> >  {
> >  	struct irq_domain *domain;
> >  	struct fwnode_handle *fn;
> > -	int i;
> 
> I've already applied your first version, so I need an incremental
> patch, which just removes the unused variable.

Sure, please find below.

From ce447fe69092c48bb59a6c4cb08ee5f9080f0ad6 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 22 Apr 2024 15:52:12 -0700
Subject: [PATCH] MIPS: SGI-IP27: fix -Wunused-variable in arch_init_irq()

Commit 40e20fbccfb722f21 (MIPS: SGI-IP27: micro-optimize arch_init_irq())
replaced a for-loop iteration with bitmap_set() calls, but didn't remove
an iteration variable.

Fixes: 40e20fbccfb722f21 (MIPS: SGI-IP27: micro-optimize arch_init_irq())
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404161933.izfqZ32k-lkp@intel.com/
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/mips/sgi-ip27/ip27-irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index dcb14a234b1c..d8acdf0439d2 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -277,7 +277,6 @@ void __init arch_init_irq(void)
 {
 	struct irq_domain *domain;
 	struct fwnode_handle *fn;
-	int i;
 
 	mips_cpu_irq_init();
 
-- 
2.40.1


