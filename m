Return-Path: <linux-kernel+bounces-165577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B978B8E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F871F2265F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E7130491;
	Wed,  1 May 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="hGzxsX1B"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7D12FF86;
	Wed,  1 May 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580838; cv=none; b=ccQb0YBCBPA5Ri5ztgvW1ok24vtQptQbala2JAhCSaD3KFF+p2G5E3unzDOAModLB1O2FTM4oFW2tkumJ7+x+3qwOYUDVRVjVXOKbbOxpY1WQmFkswq3GEAJ0Z6gfx+d7v11h0nAKbTu6wx8HpzPhxJH1oVdnSzBdhMdsxopqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580838; c=relaxed/simple;
	bh=26WtctVaTLTLc776t9nI7ES3WntMKj7sFyWZDGc/5GE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOJs5cyBbQys0e2hglcxSzyBbQNdyQK2A1V6sM8PfK3fDj7368XB+IVUt1RuybHCpRsmGvpVIFlQfTy7rziXa4W0VVQHz8qK2bmvlg7PoN3nf3gFMp84nPAv/VzHyW3+ZXljBGA5T74KeWHTr4Z2VSuCn1kF/eOM7B8moVZzu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=hGzxsX1B; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 680C61B45ED;
	Wed,  1 May 2024 18:27:07 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1714580827; bh=fBvZZlumoKZqzBJIFGtRRADPHppBYMwkyXFAsAJrVTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGzxsX1Beh+WPSkCo+hhO9K6L9/HcJgEVIfC6gL9/b4yWE2WzJ9QmisZmqY2uJGA6
	 bZZcOXGmhXNmC+2amRdd0L+EzvY2hXTam5i/4t4u0sbP1PnZDg7MSKFO10Hkdzj86Z
	 r6id+ZEAUlbUNCLDPlxsiZQ0JNWbN1vfJv+6aRRHqFf/Ydg979aUtV0wjk+LiU5iDd
	 jGhVpkTPD0cSEH9PJAylMg+LKwGmENE7mcRUKA7QKAX1Owq3Hd1fCZOIeZ1/f3+6nF
	 WMFgvDDxVFLzpMU4AbFrnBcLM9FK97R6OcGuYzD1i+moWM4v1bmUvrLn2Qor77SnHi
	 n4eGJtcyn6YKA==
Date: Wed, 1 May 2024 18:27:05 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, hch@lst.de, m.szyprowski@samsung.com, corbet@lwn.net,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v4 1/1] Documentation/core-api: Add swiotlb
 documentation
Message-ID: <20240501182705.1fc5af92@meshulam.tesarici.cz>
In-Reply-To: <20240501151651.2912-1-mhklinux@outlook.com>
References: <20240501151651.2912-1-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  1 May 2024 08:16:51 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
>=20
> There's currently no documentation for the swiotlb. Add documentation
> describing usage scenarios, the key APIs, and implementation details.
> Group the new documentation with other DMA-related documentation.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Looks perfect now. :-)

Reviewed-by: Petr Tesarik <petr@tesarici.cz>

Petr T

> ---
> Changes in v4:
> * Removed "existing" qualifier in describing device drivers that "just wo=
rk"
>   in a CoCo VM [Petr Tesa=C5=99=C3=ADk]
> * Added mention of DMA_ATTR_SKIP_CPU_SYNC in describing
>   swiotlb_tbl_unmap_single() [Petr Tesa=C5=99=C3=ADk]
> * Provided more detail on operation of min_align_mask [Petr Tesa=C5=99=C3=
=ADk]
>=20
> Changes in v3:
> * Reference swiotlb as just "swiotlb", not "the swiotlb" [Christoph Hellw=
ig]
> * Lengthen text lines to close to 80 chars instead of 65 [Christoph Hellw=
ig]
>=20
> Changes in v2:
> * Use KiB/MiB/GiB units instead of Kbytes/Mbytes/Gbytes [Matthew Wilcox]
>=20
>  Documentation/core-api/index.rst   |   1 +
>  Documentation/core-api/swiotlb.rst | 321 +++++++++++++++++++++++++++++
>  2 files changed, 322 insertions(+)
>  create mode 100644 Documentation/core-api/swiotlb.rst
>=20
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/in=
dex.rst
> index 7a3a08d81f11..89c517665763 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -102,6 +102,7 @@ more memory-management documentation in Documentation=
/mm/index.rst.
>     dma-api-howto
>     dma-attributes
>     dma-isa-lpc
> +   swiotlb
>     mm-api
>     genalloc
>     pin_user_pages
> diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/=
swiotlb.rst
> new file mode 100644
> index 000000000000..5ad2c9ca85bc
> --- /dev/null
> +++ b/Documentation/core-api/swiotlb.rst
> @@ -0,0 +1,321 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DMA and swiotlb
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +swiotlb is a memory buffer allocator used by the Linux kernel DMA layer.=
 It is
> +typically used when a device doing DMA can't directly access the target =
memory
> +buffer because of hardware limitations or other requirements. In such a =
case,
> +the DMA layer calls swiotlb to allocate a temporary memory buffer that c=
onforms
> +to the limitations. The DMA is done to/from this temporary memory buffer=
, and
> +the CPU copies the data between the temporary buffer and the original ta=
rget
> +memory buffer. This approach is generically called "bounce buffering", a=
nd the
> +temporary memory buffer is called a "bounce buffer".
> +
> +Device drivers don't interact directly with swiotlb. Instead, drivers in=
form
> +the DMA layer of the DMA attributes of the devices they are managing, an=
d use
> +the normal DMA map, unmap, and sync APIs when programming a device to do=
 DMA.
> +These APIs use the device DMA attributes and kernel-wide settings to det=
ermine
> +if bounce buffering is necessary. If so, the DMA layer manages the alloc=
ation,
> +freeing, and sync'ing of bounce buffers. Since the DMA attributes are per
> +device, some devices in a system may use bounce buffering while others d=
o not.
> +
> +Because the CPU copies data between the bounce buffer and the original t=
arget
> +memory buffer, doing bounce buffering is slower than doing DMA directly =
to the
> +original memory buffer, and it consumes more CPU resources. So it is use=
d only
> +when necessary for providing DMA functionality.
> +
> +Usage Scenarios
> +---------------
> +swiotlb was originally created to handle DMA for devices with addressing
> +limitations. As physical memory sizes grew beyond 4 GiB, some devices co=
uld
> +only provide 32-bit DMA addresses. By allocating bounce buffer memory be=
low
> +the 4 GiB line, these devices with addressing limitations could still wo=
rk and
> +do DMA.
> +
> +More recently, Confidential Computing (CoCo) VMs have the guest VM's mem=
ory
> +encrypted by default, and the memory is not accessible by the host hyper=
visor
> +and VMM. For the host to do I/O on behalf of the guest, the I/O must be
> +directed to guest memory that is unencrypted. CoCo VMs set a kernel-wide=
 option
> +to force all DMA I/O to use bounce buffers, and the bounce buffer memory=
 is set
> +up as unencrypted. The host does DMA I/O to/from the bounce buffer memor=
y, and
> +the Linux kernel DMA layer does "sync" operations to cause the CPU to co=
py the
> +data to/from the original target memory buffer. The CPU copying bridges =
between
> +the unencrypted and the encrypted memory. This use of bounce buffers all=
ows
> +device drivers to "just work" in a CoCo VM, with no modifications
> +needed to handle the memory encryption complexity.
> +
> +Other edge case scenarios arise for bounce buffers. For example, when IO=
MMU
> +mappings are set up for a DMA operation to/from a device that is conside=
red
> +"untrusted", the device should be given access only to the memory contai=
ning
> +the data being transferred. But if that memory occupies only part of an =
IOMMU
> +granule, other parts of the granule may contain unrelated kernel data. S=
ince
> +IOMMU access control is per-granule, the untrusted device can gain acces=
s to
> +the unrelated kernel data. This problem is solved by bounce buffering th=
e DMA
> +operation and ensuring that unused portions of the bounce buffers do not
> +contain any unrelated kernel data.
> +
> +Core Functionality
> +------------------
> +The primary swiotlb APIs are swiotlb_tbl_map_single() and
> +swiotlb_tbl_unmap_single(). The "map" API allocates a bounce buffer of a
> +specified size in bytes and returns the physical address of the buffer. =
The
> +buffer memory is physically contiguous. The expectation is that the DMA =
layer
> +maps the physical memory address to a DMA address, and returns the DMA a=
ddress
> +to the driver for programming into the device. If a DMA operation specif=
ies
> +multiple memory buffer segments, a separate bounce buffer must be alloca=
ted for
> +each segment. swiotlb_tbl_map_single() always does a "sync" operation (i=
e., a
> +CPU copy) to initialize the bounce buffer to match the contents of the o=
riginal
> +buffer.
> +
> +swiotlb_tbl_unmap_single() does the reverse. If the DMA operation might =
have
> +updated the bounce buffer memory and DMA_ATTR_SKIP_CPU_SYNC is not set, =
the
> +unmap does a "sync" operation to cause a CPU copy of the data from the b=
ounce
> +buffer back to the original buffer. Then the bounce buffer memory is fre=
ed.
> +
> +swiotlb also provides "sync" APIs that correspond to the dma_sync_*() AP=
Is that
> +a driver may use when control of a buffer transitions between the CPU an=
d the
> +device. The swiotlb "sync" APIs cause a CPU copy of the data between the
> +original buffer and the bounce buffer. Like the dma_sync_*() APIs, the s=
wiotlb
> +"sync" APIs support doing a partial sync, where only a subset of the bou=
nce
> +buffer is copied to/from the original buffer.
> +
> +Core Functionality Constraints
> +------------------------------
> +The swiotlb map/unmap/sync APIs must operate without blocking, as they a=
re
> +called by the corresponding DMA APIs which may run in contexts that cann=
ot
> +block. Hence the default memory pool for swiotlb allocations must be
> +pre-allocated at boot time (but see Dynamic swiotlb below). Because swio=
tlb
> +allocations must be physically contiguous, the entire default memory poo=
l is
> +allocated as a single contiguous block.
> +
> +The need to pre-allocate the default swiotlb pool creates a boot-time tr=
adeoff.
> +The pool should be large enough to ensure that bounce buffer requests can
> +always be satisfied, as the non-blocking requirement means requests can'=
t wait
> +for space to become available. But a large pool potentially wastes memor=
y, as
> +this pre-allocated memory is not available for other uses in the system.=
 The
> +tradeoff is particularly acute in CoCo VMs that use bounce buffers for a=
ll DMA
> +I/O. These VMs use a heuristic to set the default pool size to ~6% of me=
mory,
> +with a max of 1 GiB, which has the potential to be very wasteful of memo=
ry.
> +Conversely, the heuristic might produce a size that is insufficient, dep=
ending
> +on the I/O patterns of the workload in the VM. The dynamic swiotlb featu=
re
> +described below can help, but has limitations. Better management of the =
swiotlb
> +default memory pool size remains an open issue.
> +
> +A single allocation from swiotlb is limited to IO_TLB_SIZE * IO_TLB_SEGS=
IZE
> +bytes, which is 256 KiB with current definitions. When a device's DMA se=
ttings
> +are such that the device might use swiotlb, the maximum size of a DMA se=
gment
> +must be limited to that 256 KiB. This value is communicated to higher-le=
vel
> +kernel code via dma_map_mapping_size() and swiotlb_max_mapping_size(). I=
f the
> +higher-level code fails to account for this limit, it may make requests =
that
> +are too large for swiotlb, and get a "swiotlb full" error.
> +
> +A key device DMA setting is "min_align_mask", which is a power of 2 minu=
s 1
> +so that some number of low order bits are set, or it may be zero. swiotlb
> +allocations ensure these min_align_mask bits of the physical address of =
the
> +bounce buffer match the same bits in the address of the original buffer.=
 When
> +min_align_mask is non-zero, it may produce an "alignment offset" in the =
address
> +of the bounce buffer that slightly reduces the maximum size of an alloca=
tion.
> +This potential alignment offset is reflected in the value returned by
> +swiotlb_max_mapping_size(), which can show up in places like
> +/sys/block/<device>/queue/max_sectors_kb. For example, if a device does =
not use
> +swiotlb, max_sectors_kb might be 512 KiB or larger. If a device might use
> +swiotlb, max_sectors_kb will be 256 KiB. When min_align_mask is non-zero,
> +max_sectors_kb might be even smaller, such as 252 KiB.
> +
> +swiotlb_tbl_map_single() also takes an "alloc_align_mask" parameter. This
> +parameter specifies the allocation of bounce buffer space must start at a
> +physical address with the alloc_align_mask bits set to zero. But the act=
ual
> +bounce buffer might start at a larger address if min_align_mask is non-z=
ero.
> +Hence there may be pre-padding space that is allocated prior to the star=
t of
> +the bounce buffer. Similarly, the end of the bounce buffer is rounded up=
 to an
> +alloc_align_mask boundary, potentially resulting in post-padding space. =
Any
> +pre-padding or post-padding space is not initialized by swiotlb code. The
> +"alloc_align_mask" parameter is used by IOMMU code when mapping for untr=
usted
> +devices. It is set to the granule size - 1 so that the bounce buffer is
> +allocated entirely from granules that are not used for any other purpose.
> +
> +Data structures concepts
> +------------------------
> +Memory used for swiotlb bounce buffers is allocated from overall system =
memory
> +as one or more "pools". The default pool is allocated during system boot=
 with a
> +default size of 64 MiB. The default pool size may be modified with the
> +"swiotlb=3D" kernel boot line parameter. The default size may also be ad=
justed
> +due to other conditions, such as running in a CoCo VM, as described abov=
e. If
> +CONFIG_SWIOTLB_DYNAMIC is enabled, additional pools may be allocated lat=
er in
> +the life of the system. Each pool must be a contiguous range of physical
> +memory. The default pool is allocated below the 4 GiB physical address l=
ine so
> +it works for devices that can only address 32-bits of physical memory (u=
nless
> +architecture-specific code provides the SWIOTLB_ANY flag). In a CoCo VM,=
 the
> +pool memory must be decrypted before swiotlb is used.
> +
> +Each pool is divided into "slots" of size IO_TLB_SIZE, which is 2 KiB wi=
th
> +current definitions. IO_TLB_SEGSIZE contiguous slots (128 slots) constit=
ute
> +what might be called a "slot set". When a bounce buffer is allocated, it
> +occupies one or more contiguous slots. A slot is never shared by multiple
> +bounce buffers. Furthermore, a bounce buffer must be allocated from a si=
ngle
> +slot set, which leads to the maximum bounce buffer size being IO_TLB_SIZ=
E *
> +IO_TLB_SEGSIZE. Multiple smaller bounce buffers may co-exist in a single=
 slot
> +set if the alignment and size constraints can be met.
> +
> +Slots are also grouped into "areas", with the constraint that a slot set=
 exists
> +entirely in a single area. Each area has its own spin lock that must be =
held to
> +manipulate the slots in that area. The division into areas avoids conten=
ding
> +for a single global spin lock when swiotlb is heavily used, such as in a=
 CoCo
> +VM. The number of areas defaults to the number of CPUs in the system for
> +maximum parallelism, but since an area can't be smaller than IO_TLB_SEGS=
IZE
> +slots, it might be necessary to assign multiple CPUs to the same area. T=
he
> +number of areas can also be set via the "swiotlb=3D" kernel boot paramet=
er.
> +
> +When allocating a bounce buffer, if the area associated with the calling=
 CPU
> +does not have enough free space, areas associated with other CPUs are tr=
ied
> +sequentially. For each area tried, the area's spin lock must be obtained=
 before
> +trying an allocation, so contention may occur if swiotlb is relatively b=
usy
> +overall. But an allocation request does not fail unless all areas do not=
 have
> +enough free space.
> +
> +IO_TLB_SIZE, IO_TLB_SEGSIZE, and the number of areas must all be powers =
of 2 as
> +the code uses shifting and bit masking to do many of the calculations. T=
he
> +number of areas is rounded up to a power of 2 if necessary to meet this
> +requirement.
> +
> +The default pool is allocated with PAGE_SIZE alignment. If an alloc_alig=
n_mask
> +argument to swiotlb_tbl_map_single() specifies a larger alignment, one o=
r more
> +initial slots in each slot set might not meet the alloc_align_mask crite=
rium.
> +Because a bounce buffer allocation can't cross a slot set boundary, elim=
inating
> +those initial slots effectively reduces the max size of a bounce buffer.
> +Currently, there's no problem because alloc_align_mask is set based on I=
OMMU
> +granule size, and granules cannot be larger than PAGE_SIZE. But if that =
were to
> +change in the future, the initial pool allocation might need to be done =
with
> +alignment larger than PAGE_SIZE.
> +
> +Dynamic swiotlb
> +---------------
> +When CONFIG_DYNAMIC_SWIOTLB is enabled, swiotlb can do on-demand expansi=
on of
> +the amount of memory available for allocation as bounce buffers. If a bo=
unce
> +buffer request fails due to lack of available space, an asynchronous bac=
kground
> +task is kicked off to allocate memory from general system memory and tur=
n it
> +into an swiotlb pool. Creating an additional pool must be done asynchron=
ously
> +because the memory allocation may block, and as noted above, swiotlb req=
uests
> +are not allowed to block. Once the background task is kicked off, the bo=
unce
> +buffer request creates a "transient pool" to avoid returning an "swiotlb=
 full"
> +error. A transient pool has the size of the bounce buffer request, and is
> +deleted when the bounce buffer is freed. Memory for this transient pool =
comes
> +from the general system memory atomic pool so that creation does not blo=
ck.
> +Creating a transient pool has relatively high cost, particularly in a Co=
Co VM
> +where the memory must be decrypted, so it is done only as a stopgap unti=
l the
> +background task can add another non-transient pool.
> +
> +Adding a dynamic pool has limitations. Like with the default pool, the m=
emory
> +must be physically contiguous, so the size is limited to MAX_PAGE_ORDER =
pages
> +(e.g., 4 MiB on a typical x86 system). Due to memory fragmentation, a ma=
x size
> +allocation may not be available. The dynamic pool allocator tries smalle=
r sizes
> +until it succeeds, but with a minimum size of 1 MiB. Given sufficient sy=
stem
> +memory fragmentation, dynamically adding a pool might not succeed at all.
> +
> +The number of areas in a dynamic pool may be different from the number o=
f areas
> +in the default pool. Because the new pool size is typically a few MiB at=
 most,
> +the number of areas will likely be smaller. For example, with a new pool=
 size
> +of 4 MiB and the 256 KiB minimum area size, only 16 areas can be created=
 If
> +the system has more than 16 CPUs, multiple CPUs must share an area, crea=
ting
> +more lock contention.
> +
> +New pools added via dynamic swiotlb are linked together in a linear list.
> +swiotlb code frequently must search for the pool containing a particular
> +swiotlb physical address, so that search is linear and not performant wi=
th a
> +large number of dynamic pools. The data structures could be improved for
> +faster searches.
> +
> +Overall, dynamic swiotlb works best for small configurations with relati=
vely
> +few CPUs. It allows the default swiotlb pool to be smaller so that memor=
y is
> +not wasted, with dynamic pools making more space available if needed (as=
 long
> +as fragmentation isn't an obstacle). It is less useful for large CoCo VM=
s.
> +
> +Data Structure Details
> +----------------------
> +swiotlb is managed with four primary data structures: io_tlb_mem, io_tlb=
_pool,
> +io_tlb_area, and io_tlb_slot. io_tlb_mem describes a swiotlb memory allo=
cator,
> +which includes the default memory pool and any dynamic or transient pools
> +linked to it. Limited statistics on swiotlb usage are kept per memory al=
locator
> +and are stored in this data structure. These statistics are available un=
der
> +/sys/kernel/debug/swiotlb when CONFIG_DEBUG_FS is set.
> +
> +io_tlb_pool describes a memory pool, either the default pool, a dynamic =
pool,
> +or a transient pool. The description includes the start and end addresse=
s of
> +the memory in the pool, a pointer to an array of io_tlb_area structures,=
 and a
> +pointer to an array of io_tlb_slot structures that are associated with t=
he pool.
> +
> +io_tlb_area describes an area. The primary field is the spin lock used to
> +serialize access to slots in the area. The io_tlb_area array for a pool =
has an
> +entry for each area, and is accessed using a 0-based area index derived =
from the
> +calling processor ID. Areas exist solely to allow parallel access to swi=
otlb
> +from multiple CPUs.
> +
> +io_tlb_slot describes an individual memory slot in the pool, with size
> +IO_TLB_SIZE (2 KiB currently). The io_tlb_slot array is indexed by the s=
lot
> +index computed from the bounce buffer address relative to the starting m=
emory
> +address of the pool. The size of struct io_tlb_slot is 24 bytes, so the
> +overhead is about 1% of the slot size.
> +
> +The io_tlb_slot array is designed to meet several requirements. First, t=
he DMA
> +APIs and the corresponding swiotlb APIs use the bounce buffer address as=
 the
> +identifier for a bounce buffer. This address is returned by
> +swiotlb_tbl_map_single(), and then passed as an argument to
> +swiotlb_tbl_unmap_single() and the swiotlb_sync_*() functions.  The orig=
inal
> +memory buffer address obviously must be passed as an argument to
> +swiotlb_tbl_map_single(), but it is not passed to the other APIs. Conseq=
uently,
> +swiotlb data structures must save the original memory buffer address so =
that it
> +can be used when doing sync operations. This original address is saved i=
n the
> +io_tlb_slot array.
> +
> +Second, the io_tlb_slot array must handle partial sync requests. In such=
 cases,
> +the argument to swiotlb_sync_*() is not the address of the start of the =
bounce
> +buffer but an address somewhere in the middle of the bounce buffer, and =
the
> +address of the start of the bounce buffer isn't known to swiotlb code. B=
ut
> +swiotlb code must be able to calculate the corresponding original memory=
 buffer
> +address to do the CPU copy dictated by the "sync". So an adjusted origin=
al
> +memory buffer address is populated into the struct io_tlb_slot for each =
slot
> +occupied by the bounce buffer. An adjusted "alloc_size" of the bounce bu=
ffer is
> +also recorded in each struct io_tlb_slot so a sanity check can be perfor=
med on
> +the size of the "sync" operation. The "alloc_size" field is not used exc=
ept for
> +the sanity check.
> +
> +Third, the io_tlb_slot array is used to track available slots. The "list=
" field
> +in struct io_tlb_slot records how many contiguous available slots exist =
starting
> +at that slot. A "0" indicates that the slot is occupied. A value of "1"
> +indicates only the current slot is available. A value of "2" indicates t=
he
> +current slot and the next slot are available, etc. The maximum value is
> +IO_TLB_SEGSIZE, which can appear in the first slot in a slot set, and in=
dicates
> +that the entire slot set is available. These values are used when search=
ing for
> +available slots to use for a new bounce buffer. They are updated when al=
locating
> +a new bounce buffer and when freeing a bounce buffer. At pool creation t=
ime, the
> +"list" field is initialized to IO_TLB_SEGSIZE down to 1 for the slots in=
 every
> +slot set.
> +
> +Fourth, the io_tlb_slot array keeps track of any "padding slots" allocat=
ed to
> +meet alloc_align_mask requirements described above. When
> +swiotlb_tlb_map_single() allocates bounce buffer space to meet alloc_ali=
gn_mask
> +requirements, it may allocate pre-padding space across zero or more slot=
s. But
> +when swiotbl_tlb_unmap_single() is called with the bounce buffer address=
, the
> +alloc_align_mask value that governed the allocation, and therefore the
> +allocation of any padding slots, is not known. The "pad_slots" field rec=
ords
> +the number of padding slots so that swiotlb_tbl_unmap_single() can free =
them.
> +The "pad_slots" value is recorded only in the first non-padding slot all=
ocated
> +to the bounce buffer.
> +
> +Restricted pools
> +----------------
> +The swiotlb machinery is also used for "restricted pools", which are poo=
ls of
> +memory separate from the default swiotlb pool, and that are dedicated fo=
r DMA
> +use by a particular device. Restricted pools provide a level of DMA memo=
ry
> +protection on systems with limited hardware protection capabilities, suc=
h as
> +those lacking an IOMMU. Such usage is specified by DeviceTree entries and
> +requires that CONFIG_DMA_RESTRICTED_POOL is set. Each restricted pool is=
 based
> +on its own io_tlb_mem data structure that is independent of the main swi=
otlb
> +io_tlb_mem.
> +
> +Restricted pools add swiotlb_alloc() and swiotlb_free() APIs, which are =
called
> +from the dma_alloc_*() and dma_free_*() APIs. The swiotlb_alloc/free() A=
PIs
> +allocate/free slots from/to the restricted pool directly and do not go t=
hrough
> +swiotlb_tbl_map/unmap_single().


