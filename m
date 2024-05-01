Return-Path: <linux-kernel+bounces-165461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731738B8CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960C41C220C7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60012FB2D;
	Wed,  1 May 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Dfdp2H"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D512FB0A;
	Wed,  1 May 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576624; cv=none; b=jWklDNQywgg8HhHeOC7hDnYoyydnffoP3/t31nADqszYuibYvItFIpz8VTAfAzZf+GybC7bqGZM8cgkR+9/Q8v4n4bv99g5Z3DKHmHQo2z7q1x4vY3LX2uIyixZ+uXEHbQPx7nJ+IPbW4mrdtA91ZrySWsmDm4as3nbkMEOu4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576624; c=relaxed/simple;
	bh=aFBwVJzyCkhBEUhr5A/fxMYSrFdfcfk8GhiMZZ/l1jo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BHwqAPrnen4pZhBajKuy8d4HOrdA/MvO3Cn4I9Nbm7jRAm1W/y91IDfqN3AQNAdHPmVLii4XcnGQu78b4TlKHGqHZioq+9a8qu5dVy0gn7DbL2uk7epmQ2l+bi25EOL39NDdpMrQ7Ds/4Ec0OeuH2wiiqJ+gHKBT4JxCrQYuNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4Dfdp2H; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2d82537efso4731132a91.2;
        Wed, 01 May 2024 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576622; x=1715181422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jts6nYDN6hTSXVWJXi9dpzj37tk54q/zyCk3z7f/iCU=;
        b=a4Dfdp2HXSwVfzRI+G+FVhBONg3GIKhW90QY8z/CQtdUuTYLltzx8nAC+mNZlBFf5f
         LYXjkvici1fjBrd42wJnylElvfk65y9Mz8OtahBeEbeTn//CFUj6KYUC8x7JT42E5Aul
         71qB6d3TmD58CWCh1Uhir5ovmm77hS5/+fpalKd2a4WwEmAvSA6/pE056MdLHW8HBxT/
         wedE1Gs8E0AxJ9NHaHFZp7FQHbogavPLegUJ6c/DO0jXr3IdkoHZVVAA1K/geNUmSZ12
         QQIaKJonxjRSZ8+uvrWA+mVXQ5V6lQqNWZ1XQQjU5b7biOqXaRKHB6SglM1ZY0VhiO3Z
         Yezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576622; x=1715181422;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jts6nYDN6hTSXVWJXi9dpzj37tk54q/zyCk3z7f/iCU=;
        b=h6R3o4DCmeAOMFm//TAanjmqZN2aR4PW0WbF0MjI/Ik6xAu0eiiB12L6//vOm/0IiH
         7ZPqWYBxvU/BiRie4R9bYDnAgB/uuxoB7xBCOP+JvYT27JT5aSDhOuiVb1phrmt8ikLa
         wNV5+ZcE12F9t+HVv+9w0HeChgAjP6nVGas5SOjOf50BJHExSI2uTy78zYJ4KHF6Pe0A
         9Ac4igvQJelTg7FvvzufkEDY+XTepS8jYT7sO/locCs1QGrcMYy5NWWzDQIRj1Ft91Au
         0y4AlWBOoRzhEaeDhR0IMplLOT7T0DbyaFCVNAp5ZP2+z4vy2i+uq8C4+mkE2yPvd+EQ
         cGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAg/pZow9TceD0qEfrHYNFjTM9eACtlTVox4O+uD2sOTGUprOxgMARpIX2veG3vIqWXgBVaHryZ754YjsrfQNqrdT1ATzATvUWFP8WSzVTyLnPOa4JXlbxSYP5cz0umVLtCcz9m297
X-Gm-Message-State: AOJu0Yw57+bIyz1RTr4COd+/Z9EIHnBmotJIpStxd8vPJgSAue6gPByt
	OXg7nIJ4neDwmJKz1iqochUQgLTtXlVFgGIB9qCZQVsLaXou47pd
X-Google-Smtp-Source: AGHT+IGXXYn0PM+UminHQ/rxJx/wDBlRrBP3FD/erlAnNtxdnkAjdrbobfDFjdTTwE9Nvl71THpJGg==
X-Received: by 2002:a17:90b:3bc5:b0:2af:4a3f:df62 with SMTP id ph5-20020a17090b3bc500b002af4a3fdf62mr2999106pjb.6.1714576621261;
        Wed, 01 May 2024 08:17:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a300c00b002b0696a21a4sm1445131pjb.32.2024.05.01.08.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:17:01 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	hch@lst.de,
	m.szyprowski@samsung.com,
	corbet@lwn.net,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: [PATCH v4 1/1] Documentation/core-api: Add swiotlb documentation
Date: Wed,  1 May 2024 08:16:51 -0700
Message-Id: <20240501151651.2912-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

There's currently no documentation for the swiotlb. Add documentation
describing usage scenarios, the key APIs, and implementation details.
Group the new documentation with other DMA-related documentation.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v4:
* Removed "existing" qualifier in describing device drivers that "just work"
  in a CoCo VM [Petr Tesařík]
* Added mention of DMA_ATTR_SKIP_CPU_SYNC in describing
  swiotlb_tbl_unmap_single() [Petr Tesařík]
* Provided more detail on operation of min_align_mask [Petr Tesařík]

Changes in v3:
* Reference swiotlb as just "swiotlb", not "the swiotlb" [Christoph Hellwig]
* Lengthen text lines to close to 80 chars instead of 65 [Christoph Hellwig]

Changes in v2:
* Use KiB/MiB/GiB units instead of Kbytes/Mbytes/Gbytes [Matthew Wilcox]

 Documentation/core-api/index.rst   |   1 +
 Documentation/core-api/swiotlb.rst | 321 +++++++++++++++++++++++++++++
 2 files changed, 322 insertions(+)
 create mode 100644 Documentation/core-api/swiotlb.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 7a3a08d81f11..89c517665763 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -102,6 +102,7 @@ more memory-management documentation in Documentation/mm/index.rst.
    dma-api-howto
    dma-attributes
    dma-isa-lpc
+   swiotlb
    mm-api
    genalloc
    pin_user_pages
diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
new file mode 100644
index 000000000000..5ad2c9ca85bc
--- /dev/null
+++ b/Documentation/core-api/swiotlb.rst
@@ -0,0 +1,321 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+DMA and swiotlb
+===============
+
+swiotlb is a memory buffer allocator used by the Linux kernel DMA layer. It is
+typically used when a device doing DMA can't directly access the target memory
+buffer because of hardware limitations or other requirements. In such a case,
+the DMA layer calls swiotlb to allocate a temporary memory buffer that conforms
+to the limitations. The DMA is done to/from this temporary memory buffer, and
+the CPU copies the data between the temporary buffer and the original target
+memory buffer. This approach is generically called "bounce buffering", and the
+temporary memory buffer is called a "bounce buffer".
+
+Device drivers don't interact directly with swiotlb. Instead, drivers inform
+the DMA layer of the DMA attributes of the devices they are managing, and use
+the normal DMA map, unmap, and sync APIs when programming a device to do DMA.
+These APIs use the device DMA attributes and kernel-wide settings to determine
+if bounce buffering is necessary. If so, the DMA layer manages the allocation,
+freeing, and sync'ing of bounce buffers. Since the DMA attributes are per
+device, some devices in a system may use bounce buffering while others do not.
+
+Because the CPU copies data between the bounce buffer and the original target
+memory buffer, doing bounce buffering is slower than doing DMA directly to the
+original memory buffer, and it consumes more CPU resources. So it is used only
+when necessary for providing DMA functionality.
+
+Usage Scenarios
+---------------
+swiotlb was originally created to handle DMA for devices with addressing
+limitations. As physical memory sizes grew beyond 4 GiB, some devices could
+only provide 32-bit DMA addresses. By allocating bounce buffer memory below
+the 4 GiB line, these devices with addressing limitations could still work and
+do DMA.
+
+More recently, Confidential Computing (CoCo) VMs have the guest VM's memory
+encrypted by default, and the memory is not accessible by the host hypervisor
+and VMM. For the host to do I/O on behalf of the guest, the I/O must be
+directed to guest memory that is unencrypted. CoCo VMs set a kernel-wide option
+to force all DMA I/O to use bounce buffers, and the bounce buffer memory is set
+up as unencrypted. The host does DMA I/O to/from the bounce buffer memory, and
+the Linux kernel DMA layer does "sync" operations to cause the CPU to copy the
+data to/from the original target memory buffer. The CPU copying bridges between
+the unencrypted and the encrypted memory. This use of bounce buffers allows
+device drivers to "just work" in a CoCo VM, with no modifications
+needed to handle the memory encryption complexity.
+
+Other edge case scenarios arise for bounce buffers. For example, when IOMMU
+mappings are set up for a DMA operation to/from a device that is considered
+"untrusted", the device should be given access only to the memory containing
+the data being transferred. But if that memory occupies only part of an IOMMU
+granule, other parts of the granule may contain unrelated kernel data. Since
+IOMMU access control is per-granule, the untrusted device can gain access to
+the unrelated kernel data. This problem is solved by bounce buffering the DMA
+operation and ensuring that unused portions of the bounce buffers do not
+contain any unrelated kernel data.
+
+Core Functionality
+------------------
+The primary swiotlb APIs are swiotlb_tbl_map_single() and
+swiotlb_tbl_unmap_single(). The "map" API allocates a bounce buffer of a
+specified size in bytes and returns the physical address of the buffer. The
+buffer memory is physically contiguous. The expectation is that the DMA layer
+maps the physical memory address to a DMA address, and returns the DMA address
+to the driver for programming into the device. If a DMA operation specifies
+multiple memory buffer segments, a separate bounce buffer must be allocated for
+each segment. swiotlb_tbl_map_single() always does a "sync" operation (i.e., a
+CPU copy) to initialize the bounce buffer to match the contents of the original
+buffer.
+
+swiotlb_tbl_unmap_single() does the reverse. If the DMA operation might have
+updated the bounce buffer memory and DMA_ATTR_SKIP_CPU_SYNC is not set, the
+unmap does a "sync" operation to cause a CPU copy of the data from the bounce
+buffer back to the original buffer. Then the bounce buffer memory is freed.
+
+swiotlb also provides "sync" APIs that correspond to the dma_sync_*() APIs that
+a driver may use when control of a buffer transitions between the CPU and the
+device. The swiotlb "sync" APIs cause a CPU copy of the data between the
+original buffer and the bounce buffer. Like the dma_sync_*() APIs, the swiotlb
+"sync" APIs support doing a partial sync, where only a subset of the bounce
+buffer is copied to/from the original buffer.
+
+Core Functionality Constraints
+------------------------------
+The swiotlb map/unmap/sync APIs must operate without blocking, as they are
+called by the corresponding DMA APIs which may run in contexts that cannot
+block. Hence the default memory pool for swiotlb allocations must be
+pre-allocated at boot time (but see Dynamic swiotlb below). Because swiotlb
+allocations must be physically contiguous, the entire default memory pool is
+allocated as a single contiguous block.
+
+The need to pre-allocate the default swiotlb pool creates a boot-time tradeoff.
+The pool should be large enough to ensure that bounce buffer requests can
+always be satisfied, as the non-blocking requirement means requests can't wait
+for space to become available. But a large pool potentially wastes memory, as
+this pre-allocated memory is not available for other uses in the system. The
+tradeoff is particularly acute in CoCo VMs that use bounce buffers for all DMA
+I/O. These VMs use a heuristic to set the default pool size to ~6% of memory,
+with a max of 1 GiB, which has the potential to be very wasteful of memory.
+Conversely, the heuristic might produce a size that is insufficient, depending
+on the I/O patterns of the workload in the VM. The dynamic swiotlb feature
+described below can help, but has limitations. Better management of the swiotlb
+default memory pool size remains an open issue.
+
+A single allocation from swiotlb is limited to IO_TLB_SIZE * IO_TLB_SEGSIZE
+bytes, which is 256 KiB with current definitions. When a device's DMA settings
+are such that the device might use swiotlb, the maximum size of a DMA segment
+must be limited to that 256 KiB. This value is communicated to higher-level
+kernel code via dma_map_mapping_size() and swiotlb_max_mapping_size(). If the
+higher-level code fails to account for this limit, it may make requests that
+are too large for swiotlb, and get a "swiotlb full" error.
+
+A key device DMA setting is "min_align_mask", which is a power of 2 minus 1
+so that some number of low order bits are set, or it may be zero. swiotlb
+allocations ensure these min_align_mask bits of the physical address of the
+bounce buffer match the same bits in the address of the original buffer. When
+min_align_mask is non-zero, it may produce an "alignment offset" in the address
+of the bounce buffer that slightly reduces the maximum size of an allocation.
+This potential alignment offset is reflected in the value returned by
+swiotlb_max_mapping_size(), which can show up in places like
+/sys/block/<device>/queue/max_sectors_kb. For example, if a device does not use
+swiotlb, max_sectors_kb might be 512 KiB or larger. If a device might use
+swiotlb, max_sectors_kb will be 256 KiB. When min_align_mask is non-zero,
+max_sectors_kb might be even smaller, such as 252 KiB.
+
+swiotlb_tbl_map_single() also takes an "alloc_align_mask" parameter. This
+parameter specifies the allocation of bounce buffer space must start at a
+physical address with the alloc_align_mask bits set to zero. But the actual
+bounce buffer might start at a larger address if min_align_mask is non-zero.
+Hence there may be pre-padding space that is allocated prior to the start of
+the bounce buffer. Similarly, the end of the bounce buffer is rounded up to an
+alloc_align_mask boundary, potentially resulting in post-padding space. Any
+pre-padding or post-padding space is not initialized by swiotlb code. The
+"alloc_align_mask" parameter is used by IOMMU code when mapping for untrusted
+devices. It is set to the granule size - 1 so that the bounce buffer is
+allocated entirely from granules that are not used for any other purpose.
+
+Data structures concepts
+------------------------
+Memory used for swiotlb bounce buffers is allocated from overall system memory
+as one or more "pools". The default pool is allocated during system boot with a
+default size of 64 MiB. The default pool size may be modified with the
+"swiotlb=" kernel boot line parameter. The default size may also be adjusted
+due to other conditions, such as running in a CoCo VM, as described above. If
+CONFIG_SWIOTLB_DYNAMIC is enabled, additional pools may be allocated later in
+the life of the system. Each pool must be a contiguous range of physical
+memory. The default pool is allocated below the 4 GiB physical address line so
+it works for devices that can only address 32-bits of physical memory (unless
+architecture-specific code provides the SWIOTLB_ANY flag). In a CoCo VM, the
+pool memory must be decrypted before swiotlb is used.
+
+Each pool is divided into "slots" of size IO_TLB_SIZE, which is 2 KiB with
+current definitions. IO_TLB_SEGSIZE contiguous slots (128 slots) constitute
+what might be called a "slot set". When a bounce buffer is allocated, it
+occupies one or more contiguous slots. A slot is never shared by multiple
+bounce buffers. Furthermore, a bounce buffer must be allocated from a single
+slot set, which leads to the maximum bounce buffer size being IO_TLB_SIZE *
+IO_TLB_SEGSIZE. Multiple smaller bounce buffers may co-exist in a single slot
+set if the alignment and size constraints can be met.
+
+Slots are also grouped into "areas", with the constraint that a slot set exists
+entirely in a single area. Each area has its own spin lock that must be held to
+manipulate the slots in that area. The division into areas avoids contending
+for a single global spin lock when swiotlb is heavily used, such as in a CoCo
+VM. The number of areas defaults to the number of CPUs in the system for
+maximum parallelism, but since an area can't be smaller than IO_TLB_SEGSIZE
+slots, it might be necessary to assign multiple CPUs to the same area. The
+number of areas can also be set via the "swiotlb=" kernel boot parameter.
+
+When allocating a bounce buffer, if the area associated with the calling CPU
+does not have enough free space, areas associated with other CPUs are tried
+sequentially. For each area tried, the area's spin lock must be obtained before
+trying an allocation, so contention may occur if swiotlb is relatively busy
+overall. But an allocation request does not fail unless all areas do not have
+enough free space.
+
+IO_TLB_SIZE, IO_TLB_SEGSIZE, and the number of areas must all be powers of 2 as
+the code uses shifting and bit masking to do many of the calculations. The
+number of areas is rounded up to a power of 2 if necessary to meet this
+requirement.
+
+The default pool is allocated with PAGE_SIZE alignment. If an alloc_align_mask
+argument to swiotlb_tbl_map_single() specifies a larger alignment, one or more
+initial slots in each slot set might not meet the alloc_align_mask criterium.
+Because a bounce buffer allocation can't cross a slot set boundary, eliminating
+those initial slots effectively reduces the max size of a bounce buffer.
+Currently, there's no problem because alloc_align_mask is set based on IOMMU
+granule size, and granules cannot be larger than PAGE_SIZE. But if that were to
+change in the future, the initial pool allocation might need to be done with
+alignment larger than PAGE_SIZE.
+
+Dynamic swiotlb
+---------------
+When CONFIG_DYNAMIC_SWIOTLB is enabled, swiotlb can do on-demand expansion of
+the amount of memory available for allocation as bounce buffers. If a bounce
+buffer request fails due to lack of available space, an asynchronous background
+task is kicked off to allocate memory from general system memory and turn it
+into an swiotlb pool. Creating an additional pool must be done asynchronously
+because the memory allocation may block, and as noted above, swiotlb requests
+are not allowed to block. Once the background task is kicked off, the bounce
+buffer request creates a "transient pool" to avoid returning an "swiotlb full"
+error. A transient pool has the size of the bounce buffer request, and is
+deleted when the bounce buffer is freed. Memory for this transient pool comes
+from the general system memory atomic pool so that creation does not block.
+Creating a transient pool has relatively high cost, particularly in a CoCo VM
+where the memory must be decrypted, so it is done only as a stopgap until the
+background task can add another non-transient pool.
+
+Adding a dynamic pool has limitations. Like with the default pool, the memory
+must be physically contiguous, so the size is limited to MAX_PAGE_ORDER pages
+(e.g., 4 MiB on a typical x86 system). Due to memory fragmentation, a max size
+allocation may not be available. The dynamic pool allocator tries smaller sizes
+until it succeeds, but with a minimum size of 1 MiB. Given sufficient system
+memory fragmentation, dynamically adding a pool might not succeed at all.
+
+The number of areas in a dynamic pool may be different from the number of areas
+in the default pool. Because the new pool size is typically a few MiB at most,
+the number of areas will likely be smaller. For example, with a new pool size
+of 4 MiB and the 256 KiB minimum area size, only 16 areas can be created. If
+the system has more than 16 CPUs, multiple CPUs must share an area, creating
+more lock contention.
+
+New pools added via dynamic swiotlb are linked together in a linear list.
+swiotlb code frequently must search for the pool containing a particular
+swiotlb physical address, so that search is linear and not performant with a
+large number of dynamic pools. The data structures could be improved for
+faster searches.
+
+Overall, dynamic swiotlb works best for small configurations with relatively
+few CPUs. It allows the default swiotlb pool to be smaller so that memory is
+not wasted, with dynamic pools making more space available if needed (as long
+as fragmentation isn't an obstacle). It is less useful for large CoCo VMs.
+
+Data Structure Details
+----------------------
+swiotlb is managed with four primary data structures: io_tlb_mem, io_tlb_pool,
+io_tlb_area, and io_tlb_slot. io_tlb_mem describes a swiotlb memory allocator,
+which includes the default memory pool and any dynamic or transient pools
+linked to it. Limited statistics on swiotlb usage are kept per memory allocator
+and are stored in this data structure. These statistics are available under
+/sys/kernel/debug/swiotlb when CONFIG_DEBUG_FS is set.
+
+io_tlb_pool describes a memory pool, either the default pool, a dynamic pool,
+or a transient pool. The description includes the start and end addresses of
+the memory in the pool, a pointer to an array of io_tlb_area structures, and a
+pointer to an array of io_tlb_slot structures that are associated with the pool.
+
+io_tlb_area describes an area. The primary field is the spin lock used to
+serialize access to slots in the area. The io_tlb_area array for a pool has an
+entry for each area, and is accessed using a 0-based area index derived from the
+calling processor ID. Areas exist solely to allow parallel access to swiotlb
+from multiple CPUs.
+
+io_tlb_slot describes an individual memory slot in the pool, with size
+IO_TLB_SIZE (2 KiB currently). The io_tlb_slot array is indexed by the slot
+index computed from the bounce buffer address relative to the starting memory
+address of the pool. The size of struct io_tlb_slot is 24 bytes, so the
+overhead is about 1% of the slot size.
+
+The io_tlb_slot array is designed to meet several requirements. First, the DMA
+APIs and the corresponding swiotlb APIs use the bounce buffer address as the
+identifier for a bounce buffer. This address is returned by
+swiotlb_tbl_map_single(), and then passed as an argument to
+swiotlb_tbl_unmap_single() and the swiotlb_sync_*() functions.  The original
+memory buffer address obviously must be passed as an argument to
+swiotlb_tbl_map_single(), but it is not passed to the other APIs. Consequently,
+swiotlb data structures must save the original memory buffer address so that it
+can be used when doing sync operations. This original address is saved in the
+io_tlb_slot array.
+
+Second, the io_tlb_slot array must handle partial sync requests. In such cases,
+the argument to swiotlb_sync_*() is not the address of the start of the bounce
+buffer but an address somewhere in the middle of the bounce buffer, and the
+address of the start of the bounce buffer isn't known to swiotlb code. But
+swiotlb code must be able to calculate the corresponding original memory buffer
+address to do the CPU copy dictated by the "sync". So an adjusted original
+memory buffer address is populated into the struct io_tlb_slot for each slot
+occupied by the bounce buffer. An adjusted "alloc_size" of the bounce buffer is
+also recorded in each struct io_tlb_slot so a sanity check can be performed on
+the size of the "sync" operation. The "alloc_size" field is not used except for
+the sanity check.
+
+Third, the io_tlb_slot array is used to track available slots. The "list" field
+in struct io_tlb_slot records how many contiguous available slots exist starting
+at that slot. A "0" indicates that the slot is occupied. A value of "1"
+indicates only the current slot is available. A value of "2" indicates the
+current slot and the next slot are available, etc. The maximum value is
+IO_TLB_SEGSIZE, which can appear in the first slot in a slot set, and indicates
+that the entire slot set is available. These values are used when searching for
+available slots to use for a new bounce buffer. They are updated when allocating
+a new bounce buffer and when freeing a bounce buffer. At pool creation time, the
+"list" field is initialized to IO_TLB_SEGSIZE down to 1 for the slots in every
+slot set.
+
+Fourth, the io_tlb_slot array keeps track of any "padding slots" allocated to
+meet alloc_align_mask requirements described above. When
+swiotlb_tlb_map_single() allocates bounce buffer space to meet alloc_align_mask
+requirements, it may allocate pre-padding space across zero or more slots. But
+when swiotbl_tlb_unmap_single() is called with the bounce buffer address, the
+alloc_align_mask value that governed the allocation, and therefore the
+allocation of any padding slots, is not known. The "pad_slots" field records
+the number of padding slots so that swiotlb_tbl_unmap_single() can free them.
+The "pad_slots" value is recorded only in the first non-padding slot allocated
+to the bounce buffer.
+
+Restricted pools
+----------------
+The swiotlb machinery is also used for "restricted pools", which are pools of
+memory separate from the default swiotlb pool, and that are dedicated for DMA
+use by a particular device. Restricted pools provide a level of DMA memory
+protection on systems with limited hardware protection capabilities, such as
+those lacking an IOMMU. Such usage is specified by DeviceTree entries and
+requires that CONFIG_DMA_RESTRICTED_POOL is set. Each restricted pool is based
+on its own io_tlb_mem data structure that is independent of the main swiotlb
+io_tlb_mem.
+
+Restricted pools add swiotlb_alloc() and swiotlb_free() APIs, which are called
+from the dma_alloc_*() and dma_free_*() APIs. The swiotlb_alloc/free() APIs
+allocate/free slots from/to the restricted pool directly and do not go through
+swiotlb_tbl_map/unmap_single().
-- 
2.25.1


