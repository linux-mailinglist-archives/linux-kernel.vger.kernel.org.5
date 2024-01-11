Return-Path: <linux-kernel+bounces-23826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE382B25E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765981F23C37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2250253;
	Thu, 11 Jan 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH9KIyVg"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFA5024F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso5645648e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704989024; x=1705593824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeuKhDcKJWfphdN1PILa+BY3ook1Xxotmozr9wWl3c0=;
        b=dH9KIyVgAPIZF2VMvv2UWzsjgRd6X/fHRrD+WDwg3iZWGwbxqRzLRV7qyP4aR6YTQA
         I/aluXY/PBjw2+jH+pHbAD1a/brl8ntwlumuPhBnt+ZjwcCKu91V08FSf4E63aZReWWi
         /0q7zu9AWRfBc6gVs4OpR5It58y1+KHOohayuMq1a833uxKcFKprMkJWEEsrHfQMcpzn
         uoCRiso4j+tgnJwVf1s/XyLcYt48mIet02b3wLitWTKWtSv3LnXRIbqRbS8+3PRL4z0j
         dj2Au00VjzfY7aN4hxeQCBq7gVy78IMTR4A9+KRw4ncgLHnBFZW5WOCDRF5bXgJDOsLJ
         XZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989024; x=1705593824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeuKhDcKJWfphdN1PILa+BY3ook1Xxotmozr9wWl3c0=;
        b=flXJ5iHQLUqRAutwktzHLBqaIOzJ6EGZVhSizBtuGtPfCF7807xGvi/yLTJV4rZVzn
         uy9jbOt69Fb2P3qdgZ7pja9ybzyIjs4YD7UlFuO6VIJA5oxhqJ4+8tRF2bhW4hc0n857
         qCCvNoggIitxOnZeXiKY+JVyZex6FJWMdzQk1Kt3K7z0Gc5BXZIWX3TcHDzCn9bKY9nS
         sE+eM6/0VQ00KJHUkWyh6mlvCYMGCFINUUzgTQ5GF7AaUmSNx4RKTSydn18FuEKtn/5s
         VOgW2Qj278rPdl3WXHZbOQPwQ8U8r5STpJuyUCrEq0P6a5urtZDT4mU5c6+l931VV7tq
         hpSQ==
X-Gm-Message-State: AOJu0YzC+ChvBDh21icPhiML6rsfqqi7sC+UHiNBZS3Oq/Eevc4ZteFh
	za7ZtmIqm6Yw4pSKvSKpMDc=
X-Google-Smtp-Source: AGHT+IGbxSnHPXDtfWk1WuPeNK7oDvCA/G4s4nECzuJFPHGQCw7hoJ75RmWQf32vikEKPabVMqc47A==
X-Received: by 2002:a19:ee03:0:b0:50e:84f8:77dc with SMTP id g3-20020a19ee03000000b0050e84f877dcmr737199lfb.111.1704989023905;
        Thu, 11 Jan 2024 08:03:43 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id k43-20020a0565123dab00b0050e7e409500sm233698lfv.244.2024.01.11.08.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:03:43 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Thu, 11 Jan 2024 17:03:41 +0100
To: Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] Fix a wrong value passed to __find_vmap_area()
Message-ID: <ZaARXdbigD1hWuOS@pc638.lan>
References: <20240111121104.180993-1-urezki@gmail.com>
 <20240111155511.GA3451701@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111155511.GA3451701@dev-arch.thelio-3990X>

On Thu, Jan 11, 2024 at 08:55:11AM -0700, Nathan Chancellor wrote:
> On Thu, Jan 11, 2024 at 01:11:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > There was a type in the vmalloc_dump_obj() function. Instead
> > of passing a real address which is "objp" an "addr" was used
> > what is wrong and not initialized.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: e88b85b81d5 ("mm: vmalloc: offload free_vmap_area_lock lock")
> 
> I am not sure that e88b85b81d5 introduced this. Based on the diff, I
> think it was actually commit 86817057732a ("mm: vmalloc: remove global
> vmap_area_root rb-tree"). Does not really matter for the patch text but
> I think it does matter for what change this gets squashed into.
> 
Right you are! Below is updated version:

<snip>
From 98f1fd2d3913f3b7bcbe49785a78f67999151f1c Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Thu, 11 Jan 2024 13:04:07 +0100
Subject: [PATCH 1/2] mm: vmalloc: Fix a wrong value passed to
 __find_vmap_area()

There was a type in the vmalloc_dump_obj() function. Instead
of passing a real address which is "objp" an "addr" was used
what is wrong and not initialized.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 86817057732a ("mm: vmalloc: remove global vmap_area_root rb-tree")
Closes: https://lore.kernel.org/oe-kbuild-all/202401111810.TKPIXLCs-lkp@intel.com/
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e30dabf68263..43a6608e1397 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4688,7 +4688,7 @@ bool vmalloc_dump_obj(void *object)
 	vn = addr_to_node((unsigned long)objp);
 
 	if (spin_trylock(&vn->busy.lock)) {
-		va = __find_vmap_area(addr, &vn->busy.root);
+		va = __find_vmap_area((unsigned long)objp, &vn->busy.root);
 
 		if (va && va->vm) {
 			addr = (unsigned long)va->vm->addr;
-- 
2.39.2
<snip>

--
Uladzislau Rezki

