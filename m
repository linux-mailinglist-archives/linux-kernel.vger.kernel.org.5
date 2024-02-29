Return-Path: <linux-kernel+bounces-86562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6033686C717
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8492D1C21B77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B779DA3;
	Thu, 29 Feb 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+p/Y4rX"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34779DA7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203090; cv=none; b=AXqPbwdT5YSeXDpw7ym9S/UbO+pJJkot86GEG6ix0Omt6opwwer7i9/nyqQInMitQ7Cxnr9MAPQ8p0IOeffJg8qxq6PVBeUibnuNFPl+qfA1ZxIAWHHte3nVuP8hddWRqNXTmj4bYQOLXNq5SwHJvpfr2pJYY61+94DvRtXB9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203090; c=relaxed/simple;
	bh=+wUVSTLpy0AO9oWnok54VQPn786/RYYCns4PdTboayE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtMXuuC9ZMpjkq7qPbsjKoytHvVWsigHmJMqlb7/RyOQ6oBTkD6A7KCwa2u0nr/5JUW7XlyqYUqe6c9JLlb9up95foW88W5HSIqhMyhwS7jxGdn+kzDJatn5kG0Xu14b3nWi40zUPSOBlDuX0XwK5Qf8zTFGsD4vOrXp2quZY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+p/Y4rX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d23114b19dso8225401fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709203087; x=1709807887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTKpNPeuSgy8sWWECv3I3qZ2/zuDDquRsgKltwH/73E=;
        b=O+p/Y4rXNEwgNqeLAWqmOjIdmeMF1C/nlP1RRrmVv6gn6jOSmTePcC3SnFaQB1xdq/
         4D5OP+IZU+Qr6SAB218HkQeAfv5ZVA0+tTZTcy9twb6JMLFrrWVT/OzrbPZPCDSR88To
         NItuAD6SDt8CdOBQY0RpUxhACQ56beTe+0lHdOxsWx6/PFCVfGQrMfIZXYJ1IkSsjH4F
         njmbFqd+UhEycKGl14lzMHNqt8WctKqBSRxPD0SFV46nd6//Ooq0rIgjw4s9HLfLE+wz
         VYXLTUqQFnO1hsOdmuBwg6omOWen8V/hkiNTvotykADMeNo5nE83OMy16bttj0nhA9F1
         3F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709203087; x=1709807887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTKpNPeuSgy8sWWECv3I3qZ2/zuDDquRsgKltwH/73E=;
        b=UTUSqgTXTUUbPoixp2eRjA2KR/x3OtMHnXYGPUruut0WpMTkvOIfEeRi+KExSmCHx4
         YxhGtgSKjQJr7bFLeR5tnyqOkif2h3Y8Bz+E/az17ZebhdN7BpQdzLp2+Kg4YT6HqVeA
         4b+UyHdkpWkqHLqQ7xTsc8er1noSDUEP7sH6Det/bv4zaJDZ6733cWQ3edBYpUq9d9Me
         NuhsEvTYHj6h453EuFTS0aPbPGu+YFsalvC+9hu6+eSuBJlKt5S9k/MUkAPJOD+xTGMa
         ew463hxZ0JrINGEutVmXQ4hLHGI+da3ZnaaF7S2lHdiHjiPLStJBcolNCGKUKfC2d8Tc
         yZFg==
X-Forwarded-Encrypted: i=1; AJvYcCXPGiBpmTpuvVGUonLaA2mzW+28vnwGJMni00G+6Q13ZTSxZRrsHFCjdo5/MGB6GN662ZLTi1aiHInPH6QSZtOIV4bnj82UHtx0+/b4
X-Gm-Message-State: AOJu0YzNSG4Q+85o7pxJqObszmAr+DDMUKV2udg4GAWa1MjGwr9neszd
	awOzaJyZewpRbgR2jgxf1GzFV33S1wZMDZindDDI9a7Dz+bVLquV
X-Google-Smtp-Source: AGHT+IENQ75whmgA5sNBDTCKdsjXEpbjqVSppas6ddaiE25Z2aUtCtVGxWqqfIKeXW0ScrOnTLc09w==
X-Received: by 2002:ac2:5dea:0:b0:513:1a94:f9ff with SMTP id z10-20020ac25dea000000b005131a94f9ffmr1102496lfq.3.1709203086649;
        Thu, 29 Feb 2024 02:38:06 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id q26-20020ac2529a000000b00512b3c3f0f3sm203662lfm.86.2024.02.29.02.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:38:06 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 29 Feb 2024 11:38:03 +0100
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
	kirill.shutemov@linux.intel.com,
	Vishal Moola <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/11] Mitigate a vmap lock contention v3
Message-ID: <ZeBeiy5QkSo7AJA7@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <ZdcHXFMq0cwmVKfM@pc636>
 <CAKbZUD3+PJUoXee3MNvToy1zRnDoPoPqMjNAf5_87Uh-u2377w@mail.gmail.com>
 <ZdhmrEmA8wOuVcQT@pc636>
 <Zdhy3S1PzwfEJuS3@MiWiFi-R3L-srv>
 <Zdh8KmZtoQym7Syz@pc636>
 <ZdjAZQRVmP9gnfsJ@MiWiFi-R3L-srv>
 <ZdjqDRLbpnExRhSZ@pc638.lan>
 <Zd78aiZ8uiM6ZP16@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd78aiZ8uiM6ZP16@MiWiFi-R3L-srv>

> 
> I finally finished the testing w/o and with your above improvement
> patch. Testing is done on a system with 128 cpus. The system with 288
> cpus is not available because of some console connection. Attach the log
> here. In some testing after rebooting, I found it could take more than 30
> minutes, I am not sure if it's caused by my messy code change. I finally
> cleaned up all of them and take a clean linux-next to test, then apply
> your above draft code.

> [root@dell-per6515-03 linux]# nproc 
> 128
> [root@dell-per6515-03 linux]# free -h
>                total        used        free      shared  buff/cache   available
> Mem:           124Gi       2.6Gi       122Gi        21Mi       402Mi       122Gi
> Swap:          4.0Gi          0B       4.0Gi
> 
> 1)linux-next kernel w/o improving code from Uladzislau
> -------------------------------------------------------
> [root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=64
> Run the test with following parameters: run_test_mask=127 nr_threads=64
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real	4m28.018s
> user	0m0.015s
> sys	0m4.712s
> [root@dell-per6515-03 ~]# sort -h /proc/allocinfo | tail -10
>     21405696     5226 mm/memory.c:1122 func:folio_prealloc 
>     26199936     7980 kernel/fork.c:309 func:alloc_thread_stack_node 
>     29822976     7281 mm/readahead.c:247 func:page_cache_ra_unbounded 
>     99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
>    107638784     6320 mm/readahead.c:468 func:ra_alloc_folio 
>    120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
>    134742016    32896 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
>    263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
>    266797056    65136 include/linux/mm.h:2848 func:pagetable_alloc 
>    507617280    32796 mm/slub.c:2305 func:alloc_slab_page 
> [root@dell-per6515-03 ~]# 
> [root@dell-per6515-03 ~]# 
> [root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=128
> Run the test with following parameters: run_test_mask=127 nr_threads=128
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real	6m19.328s
> user	0m0.005s
> sys	0m9.476s
> [root@dell-per6515-03 ~]# sort -h /proc/allocinfo | tail -10
>     21405696     5226 mm/memory.c:1122 func:folio_prealloc 
>     26889408     8190 kernel/fork.c:309 func:alloc_thread_stack_node 
>     29822976     7281 mm/readahead.c:247 func:page_cache_ra_unbounded 
>     99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
>    107638784     6320 mm/readahead.c:468 func:ra_alloc_folio 
>    120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
>    134742016    32896 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
>    263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
>    550068224    34086 mm/slub.c:2305 func:alloc_slab_page 
>    664535040   162240 include/linux/mm.h:2848 func:pagetable_alloc 
> [root@dell-per6515-03 ~]# 
> [root@dell-per6515-03 ~]# 
> [root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
> Run the test with following parameters: run_test_mask=127 nr_threads=256
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real	19m10.657s
> user	0m0.015s
> sys	0m20.959s
> [root@dell-per6515-03 ~]# sort -h /proc/allocinfo | tail -10
>     22441984     5479 mm/shmem.c:1634 func:shmem_alloc_folio 
>     26758080     8150 kernel/fork.c:309 func:alloc_thread_stack_node 
>     35880960     8760 mm/readahead.c:247 func:page_cache_ra_unbounded 
>     99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
>    120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
>    122355712     7852 mm/readahead.c:468 func:ra_alloc_folio 
>    134742016    32896 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
>    263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
>    708231168    50309 mm/slub.c:2305 func:alloc_slab_page 
>   1107296256   270336 include/linux/mm.h:2848 func:pagetable_alloc 
> [root@dell-per6515-03 ~]# 
> 
> 2)linux-next kernel with improving code from Uladzislau
> -----------------------------------------------------
> [root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=64
> Run the test with following parameters: run_test_mask=127 nr_threads=64
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real	4m27.226s
> user	0m0.006s
> sys	0m4.709s
> [root@dell-per6515-03 linux]# sort -h /proc/allocinfo | tail -10
>     38023168     9283 mm/readahead.c:247 func:page_cache_ra_unbounded 
>     72228864    17634 fs/xfs/xfs_buf.c:390 [xfs] func:xfs_buf_alloc_pages 
>     99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
>     99863552    97523 fs/xfs/xfs_icache.c:81 [xfs] func:xfs_inode_alloc 
>    120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
>    136314880    33280 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
>    184176640    10684 mm/readahead.c:468 func:ra_alloc_folio 
>    263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
>    284700672    69507 include/linux/mm.h:2848 func:pagetable_alloc 
>    601427968    36377 mm/slub.c:2305 func:alloc_slab_page 
> [root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=128
> Run the test with following parameters: run_test_mask=127 nr_threads=128
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real	6m16.960s
> user	0m0.007s
> sys	0m9.465s
> [root@dell-per6515-03 linux]# sort -h /proc/allocinfo | tail -10
>     38158336     9316 mm/readahead.c:247 func:page_cache_ra_unbounded 
>     72220672    17632 fs/xfs/xfs_buf.c:390 [xfs] func:xfs_buf_alloc_pages 
>     99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
>     99863552    97523 fs/xfs/xfs_icache.c:81 [xfs] func:xfs_inode_alloc 
>    120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
>    136314880    33280 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
>    184504320    10710 mm/readahead.c:468 func:ra_alloc_folio 
>    263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
>    427884544   104464 include/linux/mm.h:2848 func:pagetable_alloc 
>    697311232    45159 mm/slub.c:2305 func:alloc_slab_page
> [root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
> Run the test with following parameters: run_test_mask=127 nr_threads=256
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real	21m15.673s
> user	0m0.008s
> sys	0m20.259s
> [root@dell-per6515-03 linux]# sort -h /proc/allocinfo | tail -10
>     38158336     9316 mm/readahead.c:247 func:page_cache_ra_unbounded 
>     72224768    17633 fs/xfs/xfs_buf.c:390 [xfs] func:xfs_buf_alloc_pages 
>     99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
>     99863552    97523 fs/xfs/xfs_icache.c:81 [xfs] func:xfs_inode_alloc 
>    120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
>    136314880    33280 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
>    184504320    10710 mm/readahead.c:468 func:ra_alloc_folio 
>    263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
>    506974208   123773 include/linux/mm.h:2848 func:pagetable_alloc 
>    809504768    53621 mm/slub.c:2305 func:alloc_slab_page
> [root@dell-per6515-03 linux]# time tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
> Run the test with following parameters: run_test_mask=127 nr_threads=256
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real	21m36.580s
> user	0m0.012s
> sys	0m19.912s
> [root@dell-per6515-03 linux]# sort -h /proc/allocinfo | tail -10
>     38977536     9516 mm/readahead.c:247 func:page_cache_ra_unbounded 
>     72273920    17645 fs/xfs/xfs_buf.c:390 [xfs] func:xfs_buf_alloc_pages 
>     99090432    96768 drivers/iommu/iova.c:604 func:iova_magazine_alloc 
>     99895296    97554 fs/xfs/xfs_icache.c:81 [xfs] func:xfs_inode_alloc 
>    120560528    29439 mm/mm_init.c:2521 func:alloc_large_system_hash 
>    141033472    34432 mm/percpu-vm.c:95 func:pcpu_alloc_pages 
>    186064896    10841 mm/readahead.c:468 func:ra_alloc_folio 
>    263192576    64256 mm/page_ext.c:270 func:alloc_page_ext 
>    541237248   132138 include/linux/mm.h:2848 func:pagetable_alloc 
>    694718464    41216 mm/slub.c:2305 func:alloc_slab_page
> 
> 
Thank you for testing this. So ~132mb with a patch. I think it looks
good but i might change the draft version and send out a new version.

Thank you again!

--
Uladzislau Rezki

