Return-Path: <linux-kernel+bounces-14731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518D82214B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A8C1F213C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1531215AD7;
	Tue,  2 Jan 2024 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbd96vXc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B515AC5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e68e93be1so8779325e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221197; x=1704825997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TCR2vkFjLL4nonp+cXVAy10yMLLpVs0AwkwxKNmhWeY=;
        b=Xbd96vXcZ1ZpD1MmW4Nop10JGwlw2rgGnwcfmwIvQJFktYbWu+9d2qe683xivwVYpF
         Fvz1xqCQGNeI6gO8n6+uuUte2CQQ10cNsi7Ewc9OXmWaFW6q66xSqvbBlYkQFM5Ma76u
         sKWw9+0iGhdOF+K7yXYWxjjDSmYTgtggCSglgOGxrgg8PN3zwR7iwKGDJfDFJqhKTeF8
         D2avZqsghVLRWYMNYPvegROqPi9SGBBpftFWIM9ZyJNjEBrPeg5jpywEt7cPl7rkhJik
         3aWlgYSxGbMzSUDEU7TdMnMej2gsWFCqBAy8nvxKSOmejvPF7JNEL32eQOcT8ucXedks
         6QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221197; x=1704825997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCR2vkFjLL4nonp+cXVAy10yMLLpVs0AwkwxKNmhWeY=;
        b=FwrIeFyW0NPuYvaOqmT27gy7AkjIRHQQ2+QuljIVjwrZV2rPXytnvJzmMTGTLCmHzt
         vzYEjFf2pcQqWvIWdR3D98ZTp8duL9kXL+XukQJ+FDA1Xg7MYbaKtUPo+DWkCwAc2aow
         22dPglguYh1py+XlfRq0x8muHQUgwg20y9WuyUXPoOLNoZ90yA565jUk0ZP+ARWJ0zlZ
         Oj+m4EVxDcj1wDJukXQuPVWFaOKtaCEZMVMUek1gxRtvclzNKb8m4xc/JnP2Jz3xJOGO
         0pOo38lml+U0AK8ZJwGnWx7oWpM575UyBbDMbwMuoghVAWvZFvQRczv1AC7MJlGIF9nP
         SUGQ==
X-Gm-Message-State: AOJu0Yy1mWM/uFi20GDa7THLVNwBlUIfEFaLq56Dw86Td0nptJCy26J5
	DPziX9q508fFjyN73yr+9x1MZymR26Q=
X-Google-Smtp-Source: AGHT+IFWYb1ncMhcjIs/fxbDt2YjLDxGOpX1UICltB3mEefawrDEP2mix9uaufRKlmyGJtgHDUZi1A==
X-Received: by 2002:a19:6516:0:b0:50e:3dcd:3ae9 with SMTP id z22-20020a196516000000b0050e3dcd3ae9mr6007459lfb.78.1704221196597;
        Tue, 02 Jan 2024 10:46:36 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:46:36 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v3 00/11] Mitigate a vmap lock contention v3
Date: Tue,  2 Jan 2024 19:46:22 +0100
Message-Id: <20240102184633.748113-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3. It is based on the 6.7.0-rc8.

1. Motivation

- Offload global vmap locks making it scaled to number of CPUS;
- If possible and there is an agreement, we can remove the "Per cpu kva allocator"
  to make the vmap code to be more simple;
- There were complains from XFS folk that a vmalloc might be contented
  on the their workloads.

2. Design(high level overview)

We introduce an effective vmap node logic. A node behaves as independent
entity to serve an allocation request directly(if possible) from its pool.
That way it bypasses a global vmap space that is protected by its own lock.

An access to pools are serialized by CPUs. Number of nodes are equal to
number of CPUs in a system. Please note the high threshold is bound to
128 nodes.

Pools are size segregated and populated based on system demand. The maximum
alloc request that can be stored into a segregated storage is 256 pages. The
lazily drain path decays a pool by 25% as a first step and as second populates
it by fresh freed VAs for reuse instead of returning them into a global space.

When a VA is obtained(alloc path), it is stored in separate nodes. A va->va_start
address is converted into a correct node where it should be placed and resided.
Doing so we balance VAs across the nodes as a result an access becomes scalable.
The addr_to_node() function does a proper address conversion to a correct node.

A vmap space is divided on segments with fixed size, it is 16 pages. That way
any address can be associated with a segment number. Number of segments are
equal to num_possible_cpus() but not grater then 128. The numeration starts
from 0. See below how it is converted:

static inline unsigned int
addr_to_node_id(unsigned long addr)
{
	return (addr / zone_size) % nr_nodes;
}

On a free path, a VA can be easily found by converting its "va_start" address
to a certain node it resides. It is moved from "busy" data to "lazy" data structure.
Later on, as noted earlier, the lazy kworker decays each node pool and populates it
by fresh incoming VAs. Please note, a VA is returned to a node that did an alloc
request.

3. Test on AMD Ryzen Threadripper 3970X 32-Core Processor

sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64

<default perf>
 94.41%     0.89%  [kernel]        [k] _raw_spin_lock
 93.35%    93.07%  [kernel]        [k] native_queued_spin_lock_slowpath
 76.13%     0.28%  [kernel]        [k] __vmalloc_node_range
 72.96%     0.81%  [kernel]        [k] alloc_vmap_area
 56.94%     0.00%  [kernel]        [k] __get_vm_area_node
 41.95%     0.00%  [kernel]        [k] vmalloc
 37.15%     0.01%  [test_vmalloc]  [k] full_fit_alloc_test
 35.17%     0.00%  [kernel]        [k] ret_from_fork_asm
 35.17%     0.00%  [kernel]        [k] ret_from_fork
 35.17%     0.00%  [kernel]        [k] kthread
 35.08%     0.00%  [test_vmalloc]  [k] test_func
 34.45%     0.00%  [test_vmalloc]  [k] fix_size_alloc_test
 28.09%     0.01%  [test_vmalloc]  [k] long_busy_list_alloc_test
 23.53%     0.25%  [kernel]        [k] vfree.part.0
 21.72%     0.00%  [kernel]        [k] remove_vm_area
 20.08%     0.21%  [kernel]        [k] find_unlink_vmap_area
  2.34%     0.61%  [kernel]        [k] free_vmap_area_noflush
<default perf>
   vs
<patch-series perf>
 82.32%     0.22%  [test_vmalloc]  [k] long_busy_list_alloc_test
 63.36%     0.02%  [kernel]        [k] vmalloc
 63.34%     2.64%  [kernel]        [k] __vmalloc_node_range
 30.42%     4.46%  [kernel]        [k] vfree.part.0
 28.98%     2.51%  [kernel]        [k] __alloc_pages_bulk
 27.28%     0.19%  [kernel]        [k] __get_vm_area_node
 26.13%     1.50%  [kernel]        [k] alloc_vmap_area
 21.72%    21.67%  [kernel]        [k] clear_page_rep
 19.51%     2.43%  [kernel]        [k] _raw_spin_lock
 16.61%    16.51%  [kernel]        [k] native_queued_spin_lock_slowpath
 13.40%     2.07%  [kernel]        [k] free_unref_page
 10.62%     0.01%  [kernel]        [k] remove_vm_area
  9.02%     8.73%  [kernel]        [k] insert_vmap_area
  8.94%     0.00%  [kernel]        [k] ret_from_fork_asm
  8.94%     0.00%  [kernel]        [k] ret_from_fork
  8.94%     0.00%  [kernel]        [k] kthread
  8.29%     0.00%  [test_vmalloc]  [k] test_func
  7.81%     0.05%  [test_vmalloc]  [k] full_fit_alloc_test
  5.30%     4.73%  [kernel]        [k] purge_vmap_node
  4.47%     2.65%  [kernel]        [k] free_vmap_area_noflush
<patch-series perf>

confirms that a native_queued_spin_lock_slowpath goes down to
16.51% percent from 93.07%.

The throughput is ~12x higher:

urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
Run the test with following parameters: run_test_mask=7 nr_threads=64
Done.
Check the kernel ring buffer to see the summary.

real    10m51.271s
user    0m0.013s
sys     0m0.187s
urezki@pc638:~$

urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
Run the test with following parameters: run_test_mask=7 nr_threads=64
Done.
Check the kernel ring buffer to see the summary.

real    0m51.301s
user    0m0.015s
sys     0m0.040s
urezki@pc638:~$

4. Changelog

v1: https://lore.kernel.org/linux-mm/ZIAqojPKjChJTssg@pc636/T/
v2: https://lore.kernel.org/lkml/20230829081142.3619-1-urezki@gmail.com/

Delta v2 -> v3:
  - fix comments from v2 feedback;
  - switch from pre-fetch chunk logic to a less complex size based pools.

Baoquan He (1):
  mm/vmalloc: remove vmap_area_list

Uladzislau Rezki (Sony) (10):
  mm: vmalloc: Add va_alloc() helper
  mm: vmalloc: Rename adjust_va_to_fit_type() function
  mm: vmalloc: Move vmap_init_free_space() down in vmalloc.c
  mm: vmalloc: Remove global vmap_area_root rb-tree
  mm: vmalloc: Remove global purge_vmap_area_root rb-tree
  mm: vmalloc: Offload free_vmap_area_lock lock
  mm: vmalloc: Support multiple nodes in vread_iter
  mm: vmalloc: Support multiple nodes in vmallocinfo
  mm: vmalloc: Set nr_nodes based on CPUs in a system
  mm: vmalloc: Add a shrinker to drain vmap pools

 .../admin-guide/kdump/vmcoreinfo.rst          |    8 +-
 arch/arm64/kernel/crash_core.c                |    1 -
 arch/riscv/kernel/crash_core.c                |    1 -
 include/linux/vmalloc.h                       |    1 -
 kernel/crash_core.c                           |    4 +-
 kernel/kallsyms_selftest.c                    |    1 -
 mm/nommu.c                                    |    2 -
 mm/vmalloc.c                                  | 1049 ++++++++++++-----
 8 files changed, 786 insertions(+), 281 deletions(-)

-- 
2.39.2


