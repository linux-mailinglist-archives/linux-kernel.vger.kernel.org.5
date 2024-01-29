Return-Path: <linux-kernel+bounces-43578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39C8415DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FB628390F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F250A8C;
	Mon, 29 Jan 2024 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="za33MXTG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2133DB9B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568130; cv=none; b=ZFzo2J4/An3vLCC1OLPy4e8W485e9+NPIzg1NznxPNky4EGIr0CpBuMBbTYdh4EM0GvhD7lamSLuMyTLLFcVqGiD9EKAyhyzHUuxggerSUXCv5ZbxNJ/oVYbTqPQLG/tSe3pi5RBdU2ipFFKmODcZg0kGOz7Vi29HgEgaoce6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568130; c=relaxed/simple;
	bh=ExktG3hW2hVE4umdJAwOuYzeosO6UnaKjedkGRNDkVQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=SgegnhW8t8hnElrXcOxSTIxVeTqikHUHR/nASzlfsp+mNDKjPEGI9rsCCfQSAxnOHNq1oNAm7rhNAi6vH1mXlkcHcPF6Od0W53pyacW3gO5/W5hgBtdvuceb3jM9X3LWf80Kjl083vx8YVwh3IdKW+NYWA7K+V7+zEWN48WTG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=za33MXTG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffee6e316bso74623807b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706568126; x=1707172926; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VE7GZwlO0yUqA6/JtS1kX+fO9JTNi/wRG9QlDH96VaM=;
        b=za33MXTG60FF+wBvqnWtPkvfvCIVeOpM5j0+T3PHRKQQx+ohAGPQoAYgEte3lk51u4
         8MKNDKJe4Uv0UbBtV2DP9X52+FvfeSgh7Gt/1IGMKgV8srD8Jn3k2LNihvbUN7ARuqor
         gdh4WjnePTQhfWkAwZF6PwDwHkieFm2N2Ydcyj0rsW+cNhdscypc0m1AkF+p5WfFYh2e
         oyJXdywQsdIDHJGKrIsXl5LR2PyB1A30jJ1GTrSm3mC0lXlSyR6odFnxzwDNy/BrUrJa
         eWxteY98u0zYi0TcjFAn1x5jQ7wYOyNS4EzbC4sTM3CKbj6247SPJeb6LbfHVUcdbvYJ
         52/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568126; x=1707172926;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE7GZwlO0yUqA6/JtS1kX+fO9JTNi/wRG9QlDH96VaM=;
        b=JRw3ZUbZKCt9ojbD/l4jzp5dlfLz7wDvpScfeQVbZzrd5jzcDs84ZsLJOEf2OpMfHh
         WQkNgiPCpy+Ow3jC3xKQul6xqIrblIs4Gmt7oKkStq8oSaPeNWLkpTS7Q0IaBlV5DaGj
         AawqvWJRjc7qUNUmEJJhPl/r/8uQgeZu6uTyMAELx58cIxFc7vTZGUA1nZH6RmbBEORI
         4nhc+EhEgK6yk0rQGE1232gO6jRuD80oA7N846XSdyZhCq+8jryCiYRBno4O07CmA5zj
         BC4hY5Y6R82ISNtijXMxU1AsMElSJKX5RE7Hikzla3qHOwEIX/fEoK9Xiw0DYXLJ3vCQ
         Frjg==
X-Gm-Message-State: AOJu0YwXyWPY1tLS9AGI/taczRlTIEp/fgsXRpaESU/VvXI4cD4xursv
	DoLf3O/mCFEMe1G8T3DBSKf1FxjHBhZ4QViXuxPnkjMhT/h0j/BkLb9tTAaXMgb3mEswb+VQYI4
	1fodaIwL07LgJ4i6ITSlt9w==
X-Google-Smtp-Source: AGHT+IHsc6gFIVDbnW/AAd98AprNnklerEGWWSROYyc2PHPusRWpj7AuGZqgpUYnX4Zpiewhvb8Wx78Fis1tjxYt+Q==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:56e5:d75e:57c4:836c])
 (user=souravpanda job=sendgmr) by 2002:a05:690c:ed4:b0:5d8:4274:bae2 with
 SMTP id cs20-20020a05690c0ed400b005d84274bae2mr2229572ywb.6.1706568126319;
 Mon, 29 Jan 2024 14:42:06 -0800 (PST)
Date: Mon, 29 Jan 2024 14:42:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129224204.1812062-1-souravpanda@google.com>
Subject: [PATCH v7 0/1] mm: report per-page metadata information
From: Sourav Panda <souravpanda@google.com>
To: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, souravpanda@google.com, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"

Changelog:
v7:
	- Addressed comments from David Rientjes
                - For exporting PageMetadata to /proc/meminfo,
                  utilize global_node_page_state_pages for item
                  NR_PAGE_METADATA. This is instead of iterating
                  over nodes and accumulating the output of
                  node_page_state.
v6:
	- Interface changes
	  	- Added per-node nr_page_metadata and
		  nr_page_metadata_boot fields that are exported
		  in /sys/devices/system/node/nodeN/vmstat
		- nr_page_metadata exclusively tracks buddy
		  allocations while nr_page_metadata_boot
		  exclusively tracks memblock allocations.
		- Modified PageMetadata in /proc/meminfo to only
		  include buddy allocations so that it is
		  comparable against MemTotal in /proc/meminfo
		- Removed the PageMetadata field added in
		  /sys/devices/system/node/nodeN/meminfo
	- Addressed bugs reported by the kernel test bot.
	  	- All occurences of __mod_node_page_state have
		  been replaced by mod_node_page_state.
	- Addressed comments from Muchun Song.
	  	- Removed page meta data accouting from
		  mm/hugetlb.c. When CONFIG_SPARSEMEM_VMEMMAP
		  is disabled struct pages should not be returned
		  to buddy.
	- Modified the cover letter with the results and analysis
		- From when memory_hotplug.memmap_on_memory is
		  alternated between 0 and 1.
		- To account for the new interface changes.

v5:
	- Addressed comments from Muchun Song.
		- Fixed errors introduced in v4 when
		  CONFIG_SPARSEMEM_VMEMMAP is disabled by testing
		  against FLATMEM and SPARSEMEM memory models.
		- Handled the condition wherein the allocation of
		  walk.reuse_page fails, by moving NR_PAGE_METADATA
		  update into the clause if( walk.reuse_page ).
		- Removed the usage of DIV_ROUND_UP from
		  alloc_vmemmap_page_list since "end - start" is
		  always a multiple of PAGE_SIZE.
		- Modified alloc_vmemmap_page_list to update
		  NR_PAGE_METADATA once instead of every loop.
v4:
	- Addressed comment from Matthew Wilcox.
		- Used __node_stat_sub_folio and __node_stat_add_folio
		  instead of __mod_node_page_state in mm/hugetlb.c.
		- Used page_pgdat wherever possible in the entire patch.
		- Used DIV_ROUND_UP() wherever possible in the entire
		  patch.
v3:
	- Addressed one comment from Matthew Wilcox.
	  	- In free_page_ext, page_pgdat() is now extracted
		  prior to freeing the memory.
v2:
	- Fixed the three bugs reported by kernel test robot.
	- Enhanced the commit message as recommended by David Hildenbrand.
	- Addressed comments from Matthew Wilcox:
	  	- Simplified alloc_vmemmap_page_list() and
		  free_page_ext() as recommended.
		- Used the appropriate comment style in mm/vmstat.c.
		- Replaced writeout_early_perpage_metadata() with
		  store_early_perpage_metadata() to reduce ambiguity
		  with what swap does.
	- Addressed comments from Mike Rapoport:
	  	- Simplified the loop in alloc_vmemmap_page_list().
		- Could NOT address a comment to move
		  store_early_perpage_metadata() near where nodes
		  and page allocator are initialized.
		- Included the vmalloc()ed page_ext in accounting
		  within free_page_ext().
		- Made early_perpage_metadata[MAX_NUMNODES] static.


Previous approaches and discussions
-----------------------------------
V6:
https://lore.kernel.org/all/20231205223118.3575485-1-souravpanda@google.com
v5:
https://lore.kernel.org/all/20231101230816.1459373-1-souravpanda@google.com
v4:
https://lore.kernel.org/all/20231031223846.827173-1-souravpanda@google.com
v3:
https://lore.kernel.org/all/20231031174459.459480-1-souravpanda@google.com
v2:
https://lore.kernel.org/all/20231018005548.3505662-1-souravpanda@google.com
v1:
https://lore.kernel.org/r/20230913173000.4016218-2-souravpanda@google.com

Hi!

This patch adds two new per-node fields, namely nr_page_metadata and
nr_page_metadata_boot to /sys/devices/system/node/nodeN/vmstat and a
global PageMetadata field to /proc/meminfo. This information can be
used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures.


Background
----------

Kernel overhead observability is missing some of the largest
allocations during runtime, including vmemmap (struct pages) and
page_ext. This patch aims to address this problem by exporting a
new metric PageMetadata.

On the contrary, the kernel does provide observibility for boot memory
allocations. For example, the metric reserved_pages depicts the pages
allocated by the bootmem allocator. This can be simply calculated as
present_pages - managed_pages, which are both exported in /proc/zoneinfo.
The metric reserved_pages is primarily composed of struct pages and
page_ext.

What about the struct pages (allocated by bootmem allocator) that are
free'd during hugetlbfs allocations and then allocated by buddy-allocator
once hugtlbfs pages are free'd?

/proc/meminfo MemTotal changes: MemTotal does not include memblock
allocations but includes buddy allocations. However, during runtime
memblock allocations can be shifted into buddy allocations, and therefore
become part of MemTotal.

Once the struct pages get allocated by buddy allocator, we lose track of
these struct page allocations overhead accounting. Therefore, we must
export new metrics. nr_page_metadata and nr_page_metadata_boot
exclusively track the struct page and page ext allocations made by the
buddy allocator and memblock allocator, respectively for each node.
PageMetadata in /proc/meminfo would report the struct page and page ext
allocations made by the buddy allocator.

Results and analysis
--------------------

Memory model: Sparsemem-vmemmap
$ echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep Meta
	PageMetadata:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
        nr_page_metadata 8192
	nr_page_metadata_boot 65536

AFTER HUGTLBFS RESERVATION
$ echo 512 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32935508 kB
$ cat /proc/meminfo | grep Meta
	PageMetadata:      67584 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8448
	nr_page_metadata_boot 63488
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8448
	nr_page_metadata_booy 63488


AFTER FREEING HUGTLBFS RESERVATION
$ echo 0 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal
        MemTotal:       32935508 kB
$ cat /proc/meminfo | grep Meta
        PageMetadata:      81920 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
        nr_page_metadata 10240
	nr_page_metadata_boot 63488
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
        nr_page_metadata 10240
	nr_page_metadata_boot 63488

------------------------

Memory Hotplug with memory_hotplug.memmap_on_memory=1

BEFORE HOTADD
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep PageMeta
	PageMetadata:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536

AFTER HOTADDING 1GB
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       33951316 kB
$ cat /proc/meminfo | grep PageMeta
	PageMetadata:      83968 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 12800
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536

--------------------------

Memory Hotplug with memory_hotplug.memmap_on_memory=0

BEFORE HOTADD
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep PageMeta
	PageMetadata:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536

AFTER HOTADDING 1GB
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       33967700 kB
$ cat /proc/meminfo | grep PageMeta
	PageMetadata:      83968 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_page_metadata"
	nr_page_metadata 12800
	nr_page_metadata_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_page_metadata"
	nr_page_metadata 8192
	nr_page_metadata_boot 65536

Sourav Panda (1):
  mm: report per-page metadata information

 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/meminfo.c                  |  4 ++++
 include/linux/mmzone.h             |  4 ++++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb_vmemmap.c               | 19 ++++++++++++++----
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  8 ++++++++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 26 +++++++++++++++++++++++-
 11 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


