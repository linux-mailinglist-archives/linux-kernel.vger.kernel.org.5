Return-Path: <linux-kernel+bounces-28337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39382FD09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93DE1F2EE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F211DA4A;
	Tue, 16 Jan 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="masZ3xyt"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB261DA3A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443335; cv=none; b=P62PDHAu/8Gx3BXh5ckSIlXlJLe9Vtiv+0DJbcmZu+4wPQtwr3MAYoRw4qa0CSibUxdilR9yXP54FjESuNiIHnbInBqdHPLtD3yC3zoYJFwAkYbaYTb+EyzGD2vvMDhGzELb8d9dEJzlybxG6AbCbc6fxt3VSfYtUpk92hq/2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443335; c=relaxed/simple;
	bh=RTNETaVYznsrgiGkYF4xZIIN6F6WGxfT15XC4+nTHbw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sILwVv/HrHUkhAP2fuEOFKl5CvMIgI5LnHqW2zafM3J1voscdf2F0El/WbbQ766El3U+/ijvIuwBYJRMjxXl0ILwZCSme1WXmjMz16EZCrp3n0eIbsJdF1j3IwlVM3uaim5B53GdAGZJ1j6JQXTrDsUolI9qwKwzVAEDZrhSVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=masZ3xyt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e86a76c56so6002905e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705443332; x=1706048132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlHS8lP8N5SFntuRv+MBdf8DEe3RK7CqCJW+w8kR5p4=;
        b=masZ3xyt4YsU3wg1V8H7OpZ/+wILl5UW8PexJPvUNy3yc+7Al9X0uf7vMXwT7LaoHA
         1t43Qn365iDTGMNmeeqFystvmC46cFy+WWIs6RHWrhoKzaC2vq8Aq8ioPO2Egh3/Iqok
         O9lGQ6eb1siCnZhu1aDJ/Lh1tT5Z/7Cf8WPovMHdEqKt2Dd7AIXP/HPSlQjEQsNX8L3N
         yseWiEn0AYkWezeETeie7DwjPBy9CSoTKphtYV0MvmWpZzZ68UCDvOu6RztGdMn9BEUp
         M+tEyORwTbz83QW0OugMl+HXLOT0yInq2gd3zxrUg1X2d4g3zuGHTxh84d7LNmNDiH4b
         pcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443332; x=1706048132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlHS8lP8N5SFntuRv+MBdf8DEe3RK7CqCJW+w8kR5p4=;
        b=Kai7uRt5vKNQhcS12asekQu61iYSpfJLGKqizQlD2DMuHBQ5uo6o1MkeUf8TOOx5Y/
         aCCl80+ZbcVAjEuK8rdcun0c3udl0J8o7hsyPXoOk40A4uIpiafAKUlL1ZNz+6Dv/pQ5
         /Lhh6ZkmpjFiiMVrIdPRD/7jEgFqsYF7aNJ9napcejWX4ULpOUFuXlu/A8Bq94mKd9tD
         3CVa3n/hYNbWenIPNCClwR3N8YYp/OOimMxEtoqaqVqfT20hqrADeJooc641W1mfKT+Y
         jGXu2iQ7HA4ZFX5hiyZbMWGVxFh68AkViNGiQ9pnXcR6QQDMl1NBjlYbIezvKvIydLd7
         hLaA==
X-Gm-Message-State: AOJu0YwaY+3D3BkYcOlYD0ty32bYMSTAeOWuy+oVe20+3k/qD1sKLB3u
	tsrRfKLyPsjxSKTbHvxedgQ=
X-Google-Smtp-Source: AGHT+IF6o0F1XZR1+9LDmYvD7X5YZQIsdeVF758eA4qGZrWNN9zMaXuWwCUVEcQgQh5wdVTQsZd0rQ==
X-Received: by 2002:a05:600c:438a:b0:40e:859d:c96a with SMTP id e10-20020a05600c438a00b0040e859dc96amr919601wmn.71.1705443331583;
        Tue, 16 Jan 2024 14:15:31 -0800 (PST)
Received: from localhost (host86-162-136-255.range86-162.btcentralplus.com. [86.162.136.255])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e3733a32bsm24254922wmb.41.2024.01.16.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:15:30 -0800 (PST)
Date: Tue, 16 Jan 2024 22:13:17 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] Fix a wrong value passed to __find_vmap_area()
Message-ID: <3630611c-c9d5-428a-ad1b-21f4123c69b2@lucifer.local>
References: <20240111121104.180993-1-urezki@gmail.com>
 <20240111155511.GA3451701@dev-arch.thelio-3990X>
 <ZaARXdbigD1hWuOS@pc638.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaARXdbigD1hWuOS@pc638.lan>

On Thu, Jan 11, 2024 at 05:03:41PM +0100, Uladzislau Rezki wrote:
> On Thu, Jan 11, 2024 at 08:55:11AM -0700, Nathan Chancellor wrote:
> > On Thu, Jan 11, 2024 at 01:11:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > > There was a type in the vmalloc_dump_obj() function. Instead
> > > of passing a real address which is "objp" an "addr" was used
> > > what is wrong and not initialized.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Fixes: e88b85b81d5 ("mm: vmalloc: offload free_vmap_area_lock lock")
> >
> > I am not sure that e88b85b81d5 introduced this. Based on the diff, I
> > think it was actually commit 86817057732a ("mm: vmalloc: remove global
> > vmap_area_root rb-tree"). Does not really matter for the patch text but
> > I think it does matter for what change this gets squashed into.
> >
> Right you are! Below is updated version:
>
> <snip>
> From 98f1fd2d3913f3b7bcbe49785a78f67999151f1c Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Thu, 11 Jan 2024 13:04:07 +0100
> Subject: [PATCH 1/2] mm: vmalloc: Fix a wrong value passed to
>  __find_vmap_area()
>
> There was a type in the vmalloc_dump_obj() function. Instead
> of passing a real address which is "objp" an "addr" was used
> what is wrong and not initialized.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 86817057732a ("mm: vmalloc: remove global vmap_area_root rb-tree")

I know the commits are likely to get squashed/messed with (this is now
d1d9bdd672c4 in my mm-unstable tree), will this get corrected in the commit
message also? Slightly tricky one.

Perhaps a note for Andrew unless his scripts do this already - please
update this to wherever "mm: vmalloc: remove global vmap_area_root rb-tree"
lands?

> Closes: https://lore.kernel.org/oe-kbuild-all/202401111810.TKPIXLCs-lkp@intel.com/
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e30dabf68263..43a6608e1397 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4688,7 +4688,7 @@ bool vmalloc_dump_obj(void *object)
>  	vn = addr_to_node((unsigned long)objp);
>
>  	if (spin_trylock(&vn->busy.lock)) {
> -		va = __find_vmap_area(addr, &vn->busy.root);
> +		va = __find_vmap_area((unsigned long)objp, &vn->busy.root);
>
>  		if (va && va->vm) {
>  			addr = (unsigned long)va->vm->addr;
> --
> 2.39.2
> <snip>
>
> --
> Uladzislau Rezki

Otherwise looks good to me. I have some style comments but perhaps better
for me to address on the actual patch series! Feel free to add:

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

