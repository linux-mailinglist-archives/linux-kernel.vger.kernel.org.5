Return-Path: <linux-kernel+bounces-81027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD48D866F34
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C371C24FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D17612B163;
	Mon, 26 Feb 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBMKH6nW"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B500129A74
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938923; cv=none; b=pZDvRfjncBbtM96FPJJSfAJR2gpE1/QmcsR0HsLA1pZMYonRiOgBOyOIdIoK8XKTthY19+7WTU7I306oNlJHKIxPTGWxamVGE2JYwUkgugshWGOHCeW7XcWBWVV6b3426BVtBrKFI6Da6vMX4ij+W9Jgd7Ti8JbtpKFiEEIWV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938923; c=relaxed/simple;
	bh=pHLwmPcYlfd/Qkxs1p2rVu/nMmMV/+I0Sn5ln0jpRFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INNdt+G4PT2sxkCs+ck9YEWZY4PAxEODxmvlq5+PD/BAQ2HTArvrcxgo3mIpWZYvqU4ZemTnyT9Z6VC94RkB3CLTju35gFmJUS+A+LfU2aoDtaH4F3lB7AEZvIvBce7I6asvz97SHQQoTcIxATpZlgQBFhQ05cEQ5NM2JqD7Wvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBMKH6nW; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a0932aa9ecso237333eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708938919; x=1709543719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR1NkuI+7ujF9HehYtrrB0wxUHhf9LM2hjsCtO0HDy8=;
        b=nBMKH6nWQhWSKyud8TgtOXjAUMUmNB8KmDxHYQe/Q45Z8N51WXKF+ZAXZeOnI2pbs3
         sfB7jKds/nL+YseBUirMSQapAdFBM3TOznMFNr05tHbuW5up/nW5X9XJje0gg6VA0nSr
         FWPkp4nO5ezOe6N9ROqklYVpUkLtOtf/jSAlM1lfeVsMQ/RNi5rf4pQVO8rnyhe0gO4c
         ibG3UyX/cLCHm+86RZcDDQgVn7cQYWCvZ83PLbGLfp/BCCFoEb7kMZWSlAk0xUP+MtfD
         6I9ZR5knGU/GCHdVwS1gNghfky2ng1VROIbOfzW5yVg0jpR3luLYbKTeE4ESsvsHse5y
         PKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938919; x=1709543719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR1NkuI+7ujF9HehYtrrB0wxUHhf9LM2hjsCtO0HDy8=;
        b=JEIIWDqZq7yloUhZ/nABpODQ3ujJM4ZcmXIu+iLSW09GhYkFQKCOq+bMhqmgJb95L1
         lV9t9D08BJp7llamcscGJuqOkTjugoU9j8miqCgGtJUbv4FrJzHCLSO4/9dxxmS3E/By
         FnrMoQcpe6SWAhG9QpqM1eTxr1+uLBL4Ht1nLTluLgt6YTS/7yRKj4POtneo7qemnF1l
         21IDaXte8ZWdvyx8Q6RqDSicT1ec0Pnr21JDiyesSPl4nM4CIS+gE0Ihgs/zc5RPppvc
         BKd/DOGAAgSEZ2AxUz4wZ/wY/qLKVIxGTyM1Xmr4tS3y32788v8JhFtbOHwSZiUL4DDX
         lc9Q==
X-Gm-Message-State: AOJu0YwJTxwhorQ0H+ddNZw74AkB+2YVdsAguFUEuN+xTYbTlszkF9YS
	QIfZSzSjpFTHp7VDt1tLP581k8BczWXKzzYD5WRTre9a4Hmir/EggzCwX6JnM67APpLP+IyA/ri
	LQsEzcD6NypX4x7uIKNfeF3HG3oI=
X-Google-Smtp-Source: AGHT+IHlcKARfsgdYH2U/kSA+CiR8YYXpRTj4Lj6aHxdBGNnrHajAvpeFNw6dJExOpLOt7IvkBQh2yTjzhxsJSB8gIQ=
X-Received: by 2002:a4a:3859:0:b0:59f:8466:5748 with SMTP id
 o25-20020a4a3859000000b0059f84665748mr5614086oof.0.1708938919225; Mon, 26 Feb
 2024 01:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com>
In-Reply-To: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Mon, 26 Feb 2024 10:14:45 +0100
Message-ID: <CADo9pHigwGQ_h8fH4bzkxXXPNYp9GXM8gNzEUJPoGc5kvT6QQQ@mail.gmail.com>
Subject: Re: Linux 6.8-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it running on EndeavourOS on my Dell Latitude 7390 laptop with a
Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz

Tested by: Luna Jernberg <droidbittin@gmail.com>

Den m=C3=A5n 26 feb. 2024 kl 00:57 skrev Linus Torvalds
<torvalds@linux-foundation.org>:
>
> Another week, another rc. Nothing here really stands out.
>
> Last week I said that I was hoping things would calm down a bit.
> Technically things did calm down a bit, and rc6 is smaller than rc5
> was. But not by a huge amount, and honestly, while there's nothing
> really alarming here, there's more here than I would really like at
> this point in the release.
>
> So this may end up being one of those releases that get an rc8. We'll
> see. The fact that we have a bit more commits than I would really wish
> for might not be a huge issue when a noticeable portion of said
> commits end up being about self-tests etc.
>
> So right now I'm still on the fence about things. Most of the stuff
> here is really just fairly trivial driver updates (and those self-test
> ones), but we do have regressions being tracked still, so...
>
> Just reading through the appended shortlog, a lot of this really _is_
> very trivial, and some of the core stuff (like the RCU fixes by Al)
> are so esoteric that I kind of doubt anybody has ever hit them in real
> life.  But still.. Over 300 non-merge fixes in the last week isn't
> exactly quiet.
>
> I'm clearly not ready to make that "do we do an rc8" decision right
> now. I'll give it another week until I have to make that decision.
>
>                  Linus
>
> ---
>
> Aaro Koskinen (1):
>       usb: gadget: omap_udc: fix USB gadget regression on Palm TE
>
> Al Viro (15):
>       Revert "get rid of DCACHE_GENOCIDE"
>       erofs: fix handling kern_mount() failure
>       fs/super.c: don't drop ->s_user_ns until we free struct super_block=
 itself
>       rcu pathwalk: prevent bogus hard errors from may_lookup()
>       affs: free affs_sb_info with kfree_rcu()
>       exfat: move freeing sbi, upcase table and dropping nls into
> rcu-delayed helper
>       hfsplus: switch to rcu-delayed unloading of nls and freeing ->s_fs_=
info
>       afs: fix __afs_break_callback() / afs_drop_open_mmap() race
>       nfs: make nfs_set_verifier() safe for use in RCU pathwalk
>       nfs: fix UAF on pathwalk running into umount
>       procfs: move dropping pde and pid from ->evict_inode() to ->free_in=
ode()
>       procfs: make freeing proc_fs_info rcu-delayed
>       fuse: fix UAF in rcu pathwalks
>       cifs_get_link(): bail out in unsafe case
>       ext4_get_link(): fix breakage in RCU mode
>
> Alex Elder (1):
>       net: ipa: don't overrun IPA suspend interrupt registers
>
> Alexander Gordeev (1):
>       net/iucv: fix the allocation size of iucv_path_table array
>
> Alexander Stein (1):
>       arm64: dts: tqma8mpql: fix audio codec iov-supply
>
> Alison Schofield (4):
>       x86/numa: Fix the address overlap check in numa_fill_memblks()
>       x86/numa: Fix the sort compare func used in numa_fill_memblks()
>       cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
>       cxl/region: Allow out of order assembly of autodiscovered regions
>
> Amit Machhiwal (1):
>       KVM: PPC: Book3S HV: Fix L2 guest reboot failure due to empty
> 'arch_compat'
>
> Andreas Larsson (1):
>       usb: uhci-grlib: Explicitly include linux/platform_device.h
>
> Andrey Jr. Melnikov (1):
>       ahci: asm1064: correct count of reported ports
>
> Andrzej Kacprowski (1):
>       accel/ivpu: Don't enable any tiles by default on VPU40xx
>
> Andy Yan (4):
>       arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi 4B
>       arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi CM5 EVB
>       arm64: dts: rockchip: rename vcc5v0_usb30_host regulator for
> Cool Pi CM5 EVB
>       arm64: dts: rockchip: Fix the num-lanes of pcie3x4 on Cool Pi CM5 E=
VB
>
> Anshuman Khandual (1):
>       mm/memblock: add MEMBLOCK_RSRV_NOINIT into flagname[] array
>
> Armin Wolf (1):
>       drm/amd/display: Fix memory leak in dm_sw_fini()
>
> Arnd Bergmann (4):
>       RDMA/srpt: fix function pointer cast warnings
>       nouveau: fix function cast warnings
>       iommu/vt-d: Fix constant-out-of-range warning
>       dm-integrity, dm-verity: reduce stack usage for recheck
>
> Arunpravin Paneer Selvam (1):
>       drm/buddy: Modify duplicate list_splice_tail call
>
> Ashutosh Dixit (2):
>       drm/xe/xe_gt_idle: Drop redundant newline in name
>       drm/xe: Fix modpost warning on xe_mocs kunit module
>
> Baokun Li (1):
>       cachefiles: fix memory leak in cachefiles_add_cache()
>
> Bart Van Assche (2):
>       RDMA/srpt: Support specifying the srpt_service_guid parameter
>       fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
>
> Benjamin Gray (1):
>       kasan: guard release_free_meta() shadow access with kasan_arch_is_r=
eady()
>
> Brian Foster (1):
>       bcachefs: fix iov_iter count underflow on sub-block dio read
>
> Chen Jun (1):
>       irqchip/mbigen: Don't use bus_get_dev_root() to find the parent
>
> Chengming Zhou (1):
>       mm/zswap: invalidate duplicate entry when !zswap_enabled
>
> Chris Morgan (1):
>       arm64: dts: rockchip: Correct Indiedroid Nova GPIO Names
>
> Conor Dooley (1):
>       riscv: dts: sifive: add missing #interrupt-cells to pmic
>
> Corey Minyard (1):
>       i2c: imx: when being a target, mark the last read as processed
>
> Damien Le Moal (2):
>       ata: libata-core: Do not try to set sleeping devices to standby
>       ata: libata-core: Do not call ata_dev_power_set_standby() twice
>
> Dan Carpenter (2):
>       scsi: ufs: Uninitialized variable in ufshcd_devfreq_target()
>       drm/nouveau/mmu/r535: uninitialized variable in r535_bar_new_()
>
> Dan Williams (2):
>       acpi/ghes: Remove CXL CPER notifications
>       cxl/acpi: Fix load failures due to single window creation failure
>
> Daniel Vacek (1):
>       IB/hfi1: Fix sdma.h tx->num_descs off-by-one error
>
> Daniil Dulov (1):
>       afs: Increase buffer size in afs_update_volume_status()
>
> Dave Airlie (3):
>       nouveau/gsp: add kconfig option to enable GSP paths by default
>       nouveau: add an ioctl to return vram bar size.
>       nouveau: add an ioctl to report vram usage
>
> Dave Jiang (4):
>       cxl: Change 'struct cxl_memdev_state' *_perf_list to single
> 'struct cxl_dpa_perf'
>       cxl: Remove unnecessary type cast in cxl_qos_class_verify()
>       cxl: Fix sysfs export of qos_class for memdev
>       cxl/test: Add support for qos_class checking
>
> David Howells (1):
>       netfs: Fix missing zero-length check in unbuffered write
>
> Dmitry Baryshkov (1):
>       Revert "iommu/arm-smmu: Convert to domain_alloc_paging()"
>
> Don Brace (1):
>       scsi: smartpqi: Fix disable_managed_interrupts
>
> Emil Renner Berthing (1):
>       gpiolib: Handle no pin_ranges in gpiochip_generic_config()
>
> Eric Dumazet (3):
>       ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
>       ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid
>       net: implement lockless setsockopt(SO_PEEK_OFF)
>
> Erik Kurzinger (2):
>       drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE
> flag is set
>       drm/syncobj: handle NULL fence in syncobj_eventfd_entry_func
>
> Fabio Estevam (2):
>       Revert "arm64: dts: imx8mp-dhcom-pdk3: Describe the USB-C connector=
"
>       Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C con=
nector"
>
> Florian Fainelli (1):
>       net: bcmasp: Indicate MAC is in charge of PHY PM
>
> Florian Westphal (2):
>       netfilter: nf_tables: set dormant flag on hook register failure
>       netfilter: nf_tables: use kzalloc for hook allocation
>
> Frank Li (2):
>       usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable(=
)
>       usb: cdns3: fix memory double free when handle zero packet
>
> Gaurav Batra (1):
>       powerpc/pseries/iommu: DLPAR add doesn't completely initialize
> pci_controller
>
> Geert Uytterhoeven (2):
>       soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
>       ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells to DA906=
3 nodes
>
> Geliang Tang (2):
>       mptcp: add needs_id for userspace appending addr
>       mptcp: add needs_id for netlink appending addr
>
> Gianmarco Lusvardi (1):
>       bpf, scripts: Correct GPL license name
>
> Greg Joyce (1):
>       block: sed-opal: handle empty atoms when parsing response
>
> Guenter Roeck (4):
>       MAINTAINERS: Drop myself as maintainer of TYPEC port controller dri=
vers
>       parisc: Fix stack unwinder
>       lib/Kconfig.debug: TEST_IOV_ITER depends on MMU
>       hwmon: (nct6775) Fix access to temperature configuration registers
>
> Hangbin Liu (1):
>       selftests: bonding: set active slave to primary eth1 specifically
>
> Hans de Goede (8):
>       platform/x86: intel: int0002_vgpio: Pass IRQF_ONESHOT to request_ir=
q()
>       platform/x86: touchscreen_dmi: Allow partial (prefix) matches
> for ACPI names
>       platform/x86: touchscreen_dmi: Consolidate Goodix upside-down
> touchscreen data
>       platform/x86: x86-android-tablets: Fix keyboard touchscreen on
> Lenovo Yogabook1 X90
>       platform/x86: Add new get_serdev_controller() helper
>       platform/x86: x86-android-tablets: Fix serdev instantiation no
> longer working
>       platform/x86: x86-android-tablets: Fix acer_b1_750_goodix_gpios nam=
e
>       platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler
>
> Hari Bathini (1):
>       bpf: Fix warning for bpf_cpumask in verifier
>
> Heiko Carstens (3):
>       s390/configs: provide compat topic configuration target
>       s390/configs: enable INIT_STACK_ALL_ZERO in all configurations
>       s390/configs: update default configurations
>
> Heiko Stuebner (2):
>       arm64: dts: rockchip: drop unneeded status from rk3588-jaguar gpio-=
leds
>       arm64: dts: rockchip: set num-cs property for spi on px30
>
> Helge Deller (1):
>       Revert "parisc: Only list existing CPUs in cpu_possible_mask"
>
> Hojin Nam (1):
>       perf: CXL: fix CPMU filter value mask length
>
> Horatiu Vultur (1):
>       net: sparx5: Add spinlock for frame transmission from CPU
>
> Hou Tao (3):
>       x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
>       x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
>       selftest/bpf: Test the read of vsyscall page under x86-64
>
> Huacai Chen (3):
>       LoongArch: Disable IRQ before init_fn() for nonboot CPUs
>       LoongArch: Update cpu_sibling_map when disabling nonboot CPUs
>       LoongArch: Call early_init_fdt_scan_reserved_mem() earlier
>
> Jakub Kicinski (5):
>       net/sched: act_mirred: use the backlog for mirred ingress
>       net/sched: act_mirred: don't override retval if we already lost the=
 skb
>       docs: netdev: update the link to the CI repo
>       tools: ynl: make sure we always pass yarg to mnl_cb_run
>       tools: ynl: don't leak mcast_groups on init error
>
> Jason Gunthorpe (4):
>       iommufd: Reject non-zero data_type if no data_len is provided
>       s390: use the correct count for __iowrite64_copy()
>       iommu/arm-smmu-v3: Do not use GFP_KERNEL under as spinlock
>       iommu/sva: Restore SVA handle sharing
>
> Javier Martinez Canillas (1):
>       sparc: Fix undefined reference to fb_is_primary_device
>
> Jeremy Kerr (1):
>       net: mctp: put sock on tag allocation failure
>
> Jianbo Liu (1):
>       net/sched: flower: Add lock protection when remove filter handle
>
> Jiri Pirko (1):
>       devlink: fix port dump cmd type
>
> Joao Martins (9):
>       iommufd/iova_bitmap: Bounds check mapped::pages access
>       iommufd/iova_bitmap: Switch iova_bitmap::bitmap to an u8 array
>       iommufd/selftest: Test u64 unaligned bitmaps
>       iommufd/iova_bitmap: Handle recording beyond the mapped pages
>       iommufd/selftest: Refactor dirty bitmap tests
>       iommufd/selftest: Refactor mock_domain_read_and_clear_dirty()
>       iommufd/selftest: Hugepage mock domain support
>       iommufd/selftest: Add mock IO hugepages tests
>       iommufd/iova_bitmap: Consider page offset for the pages to be pinne=
d
>
> Johan Jonker (1):
>       arm64: dts: rockchip: Drop interrupts property from rk3328
> pwm-rockchip node
>
> Johannes Weiner (1):
>       mm: memcontrol: clarify swapaccount=3D0 deprecation warning
>
> Jonathan Corbet (1):
>       docs: Instruct LaTeX to cope with deeper nesting
>
> Josef Bacik (1):
>       btrfs: fix deadlock with fiemap and extent locking
>
> Justin Chen (1):
>       net: bcmasp: Sanity check is off by one
>
> Justin Iurman (2):
>       Fix write to cloned skb in ipv6_hop_ioam()
>       selftests: ioam: refactoring to align with the fix
>
> Kairui Song (1):
>       mm/swap: fix race when skipping swapcache
>
> Kalesh AP (5):
>       RDMA/bnxt_re: Avoid creating fence MR for newer adapters
>       RDMA/bnxt_re: Remove a redundant check inside bnxt_re_vf_res_config
>       RDMA/bnxt_re: Fix unconditional fence for newer adapters
>       RDMA/bnxt_re: Return error for SRQ resize
>       RDMA/bnxt_re: Add a missing check in bnxt_qplib_query_srq
>
> Kamal Heib (1):
>       RDMA/qedr: Fix qedr_create_user_qp error flow
>
> Kees Cook (1):
>       enic: Avoid false positive under FORTIFY_SOURCE
>
> Kent Overstreet (6):
>       bcachefs: fix backpointer_to_text() when dev does not exist
>       bcachefs: Kill __GFP_NOFAIL in buffered read path
>       bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree
>       bcachefs: Fix bch2_journal_flush_device_pins()
>       bcachefs: Fix check_snapshot() memcpy
>       bcachefs: fix bch2_save_backtrace()
>
> Krishna Kurapati (1):
>       usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs
>
> Krzysztof Kozlowski (3):
>       riscv: dts: starfive: replace underscores in node names
>       arm64: dts: rockchip: minor rk3588 whitespace cleanup
>       LoongArch: dts: Minor whitespace cleanup
>
> Kuniyuki Iwashima (3):
>       dccp/tcp: Unhash sk from ehash for tb2 alloc failure after
> check_estalblished().
>       arp: Prevent overflow in arp_req_get().
>       af_unix: Drop oob_skb ref before purging queue in GC.
>
> Kurt Kanzenbach (1):
>       net: stmmac: Fix EST offset for dwmac 5.10
>
> Lad Prabhakar (1):
>       cache: ax45mp_cache: Align end size to cache boundary in
> ax45mp_dma_cache_wback()
>
> Leon Romanovsky (1):
>       RDMA/mlx5: Fix fortify source warning while accessing Eth segment
>
> Lewis Huang (1):
>       drm/amd/display: Only allow dig mapping to pwrseq in new asic
>
> Li Ming (1):
>       cxl/pci: Skip to handle RAS errors if CXL.mem device is detached
>
> Lino Sanfilippo (2):
>       serial: stm32: do not always set SER_RS485_RX_DURING_TX if RS485
> is enabled
>       serial: amba-pl011: Fix DMA transmission in RS485 mode
>
> Linus Torvalds (3):
>       sched/membarrier: reduce the ability to hammer on sys_membarrier
>       drm/tests/drm_buddy: fix build failure on 32-bit targets
>       Linux 6.8-rc6
>
> Lucas Stach (1):
>       bus: imx-weim: fix valid range check
>
> Ma Jun (1):
>       drm/amdgpu: Fix the runtime resume failure issue
>
> Marc Dionne (2):
>       netfs: Fix i_dio_count leak on DIO read past i_size
>       afs: Fix ignored callbacks over ipv4
>
> Marek Vasut (1):
>       arm64: dts: imx8mp: Disable UART4 by default on Data Modul
> i.MX8M Plus eDM SBC
>
> Mario Limonciello (5):
>       platform/x86/amd/pmf: Fix a suspend hang on Framework 13
>       platform/x86/amd/pmf: Add debugging message for missing policy data
>       platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_p=
c()
>       platform/x86/amd/pmf: Fix a potential race with policy binary sidel=
oad
>       platform/x86: thinkpad_acpi: Only update profile if successfully co=
nverted
>
> Mark Brown (3):
>       usb: typec: tpcm: Fix issues with power being removed during reset
>       arm64/sme: Restore SME registers on exit from suspend
>       arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend
>
> Mark Pearson (1):
>       platform/x86: think-lmi: Fix password opcode ordering for workstati=
ons
>
> Mark Zhang (1):
>       IB/mlx5: Don't expose debugfs entries for RRoCE general
> parameters if not supported
>
> Martin Blumenstingl (1):
>       drm/meson: Don't remove bridges which are created by other drivers
>
> Martin K. Petersen (2):
>       scsi: sd: usb_storage: uas: Access media prior to querying
> device properties
>       scsi: core: Consult supported VPD page list prior to fetching page
>
> Martin KaFai Lau (2):
>       bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_can=
cel
>       selftests/bpf: Test racing between bpf_timer_cancel_and_free and
> bpf_timer_cancel
>
> Matthew Auld (1):
>       drm/tests/drm_buddy: fix 32b build
>
> Matthew Brost (3):
>       drm/xe: Fix xe_vma_set_pte_size
>       drm/xe: Add XE_VMA_PTE_64K VMA flag
>       drm/xe: Return 2MB page size for compact 64k PTEs
>
> Matthieu Baerts (NGI0) (7):
>       selftests: mptcp: pm nl: also list skipped tests
>       selftests: mptcp: pm nl: avoid error msg on older kernels
>       selftests: mptcp: diag: fix bash warnings on older kernels
>       selftests: mptcp: simult flows: fix some subtest names
>       selftests: mptcp: userspace_pm: unique subtest names
>       selftests: mptcp: diag: unique 'in use' subtest names
>       selftests: mptcp: diag: unique 'cestab' subtest names
>
> Max Kellermann (2):
>       parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
>       parisc/kprobes: always include asm-generic/kprobes.h
>
> Maxime Ripard (1):
>       drm/i915/tv: Fix TV mode
>
> Melissa Wen (1):
>       drm/amd/display: fix null-pointer dereference on edid reading
>
> Mike Marciniszyn (1):
>       RDMA/irdma: Fix KASAN issue with tasklet
>
> Mike Snitzer (1):
>       dm-crypt, dm-integrity, dm-verity: bump target version
>
> Mikulas Patocka (5):
>       dm-integrity: recheck the integrity tag after a failure
>       dm-verity: recheck the hash after a failure
>       dm-crypt: don't modify the data when using authenticated encryption
>       dm-crypt: recheck the integrity tag after a failure
>       dm-verity, dm-crypt: align "struct bvec_iter" correctly
>
> Muhammad Usama Anjum (1):
>       selftests/iommu: fix the config fragment
>
> Mustafa Ismail (2):
>       RDMA/irdma: Set the CQ read threshold for GEN 1
>       RDMA/irdma: Add AE for too many RNRS
>
> Nam Cao (1):
>       irqchip/sifive-plic: Enable interrupt if needed before EOI
>
> Naohiro Aota (1):
>       scsi: target: pscsi: Fix bio_put() for error case
>
> Nhat Pham (1):
>       mm/swap_state: update zswap LRU's protection range with the folio l=
ocked
>
> Nikita Shubin (1):
>       ARM: ep93xx: Add terminator to gpiod_lookup_table
>
> Oliver Upton (3):
>       KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_ta=
ble()
>       KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
>       irqchip/gic-v3-its: Do not assume vPE tables are preallocated
>
> Ondrej Jirman (1):
>       Revert "usb: typec: tcpm: reset counter when enter into
> unattached state after try role"
>
> Pablo Neira Ayuso (3):
>       netfilter: nft_flow_offload: reset dst in route object after
> setting up flow
>       netfilter: nft_flow_offload: release dst in case direct xmit path i=
s used
>       netfilter: nf_tables: register hooks last when adding new chain/flo=
wtable
>
> Palmer Dabbelt (1):
>       tty: hvc: Don't enable the RISC-V SBI console by default
>
> Paolo Abeni (4):
>       mptcp: fix lockless access in subflow ULP diag
>       mptcp: fix data races on local_id
>       mptcp: fix data races on remote_id
>       mptcp: fix duplicate subflow creation
>
> Pavel Sakharov (1):
>       net: stmmac: Fix incorrect dereference in interrupt handlers
>
> Pawan Gupta (5):
>       x86/bugs: Add asm helpers for executing VERW
>       x86/entry_64: Add VERW just before userspace transition
>       x86/entry_32: Add VERW just before userspace transition
>       x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
>       KVM/VMX: Move VERW closer to VMentry for MDS mitigation
>
> Pawel Laszczak (2):
>       usb: cdnsp: blocked some cdns3 specific code
>       usb: cdnsp: fixed issue with incorrect detecting CDNSP family contr=
ollers
>
> Peter Oberparleiter (1):
>       s390/cio: fix invalid -EBUSY on ccw_device_start
>
> Qu Wenruo (1):
>       btrfs: defrag: avoid unnecessary defrag caused by incorrect extent =
size
>
> Radhey Shyam Pandey (1):
>       ata: ahci_ceva: fix error handling for Xilinx GT PHY support
>
> Randy Dunlap (2):
>       scsi: jazz_esp: Only build if SCSI core is builtin
>       net: ethernet: adi: requires PHYLIB support
>
> Rob Herring (5):
>       arm64: dts: freescale: Disable interrupt_map check
>       arm: dts: Fix dtc interrupt_provider warnings
>       arm64: dts: Fix dtc interrupt_provider warnings
>       arm: dts: Fix dtc interrupt_map warnings
>       arm64: dts: qcom: Fix interrupt-map cell sizes
>
> Robert Richter (1):
>       cxl/pci: Fix disabling memory if DVSEC CXL Range does not match
> a CFMWS window
>
> R=C3=A9mi Denis-Courmont (2):
>       phonet: take correct lock to peek at the RX queue
>       phonet/pep: fix racy skb_queue_empty() use
>
> Sabrina Dubroca (5):
>       tls: break out of main loop when PEEK gets a non-data record
>       tls: stop recv() if initial process_rx_list gave us non-DATA
>       tls: don't skip over different type records from the rx_list
>       selftests: tls: add test for merging of same-type control messages
>       selftests: tls: add test for peeking past a record of a different t=
ype
>
> Samasth Norway Ananda (1):
>       firmware: microchip: fix wrong sizeof argument
>
> Sandeep Dhavale (1):
>       erofs: fix refcount on the metabuf used for inode lookup
>
> Sean Christopherson (1):
>       KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH
>
> Sebastian Andrzej Siewior (1):
>       xsk: Add truesize to skb_add_rx_frag().
>
> Sebastian Reichel (1):
>       arm64: dts: rockchip: mark system power controller on rk3588-evb1
>
> SeongJae Park (4):
>       mm/damon/core: check apply interval in damon_do_apply_schemes()
>       mm/damon/sysfs-schemes: handle schemes sysfs dir removal before
> commit_schemes_quota_goals
>       mm/damon/reclaim: fix quota stauts loss due to online tunings
>       mm/damon/lru_sort: fix quota status loss due to online tunings
>
> Shakeel Butt (1):
>       MAINTAINERS: mailmap: update Shakeel's email address
>
> Shannon Nelson (1):
>       ionic: use pci_is_enabled not open code
>
> Shigeru Yoshida (1):
>       bpf, sockmap: Fix NULL pointer dereference in
> sk_psock_verdict_data_ready()
>
> Shiraz Saleem (1):
>       RDMA/irdma: Validate max_send_wr and max_recv_wr
>
> Shyam Sundar S K (2):
>       platform/x86/amd/pmf: Remove smart_pc_status enum
>       platform/x86/amd/pmf: Fix TEE enact command failure after
> suspend and resume
>
> Siddharth Vadapalli (1):
>       net: phy: realtek: Fix rtl8211f_config_init() for RTL8211F(D)(I)-VD=
-CG PHY
>
> Simon Horman (1):
>       MAINTAINERS: Add framer headers to NETWORKING [GENERAL]
>
> Srinivasan Shanmugam (1):
>       drm/amd/display: Fix potential null pointer dereference in dc_dmub_=
srv
>
> Steven Rostedt (Google) (1):
>       ring-buffer: Do not let subbuf be bigger than write mask
>
> Subbaraya Sundeep (1):
>       octeontx2-af: Consider the action set by PF
>
> Swapnil Patel (1):
>       drm/amd/display: fix input states translation error for dcn35 & dcn=
351
>
> Terry Tritton (1):
>       selftests/mm: uffd-unit-test check if huge page size is 0
>
> Thinh Nguyen (1):
>       usb: dwc3: gadget: Don't disconnect if not started
>
> Thomas Hellstr=C3=B6m (2):
>       drm/xe/uapi: Remove support for persistent exec_queues
>       drm/ttm: Fix an invalid freeing on already freed page in error path
>
> Tobias Waldekranz (2):
>       net: bridge: switchdev: Skip MDB replays of deferred events on offl=
oad
>       net: bridge: switchdev: Ensure deferred event delivery on unoffload
>
> Tom Parkin (1):
>       l2tp: pass correct message length to ip6_append_data
>
> Tudor Ambarus (2):
>       dt-bindings: clock: gs101: rename cmu_misc clock-names
>       clk: samsung: clk-gs101: comply with the new dt cmu_misc clock name=
s
>
> Uwe Kleine-K=C3=B6nig (1):
>       ARM: dts: rockchip: Drop interrupts property from pwm-rockchip node=
s
>
> Vasiliy Kovalev (3):
>       ipv6: sr: fix possible use-after-free and null-ptr-deref
>       devlink: fix possible use-after-free and memory leaks in devlink_in=
it()
>       gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
>
> Vegard Nossum (1):
>       docs: translations: use attribute to store current language
>
> Vidya Sagar (1):
>       PCI/MSI: Prevent MSI hardware interrupt number truncation
>
> WANG Xuerui (3):
>       LoongArch: KVM: Fix input validation of _kvm_get_cpucfg() &
> kvm_check_cpucfg()
>       LoongArch: KVM: Rename _kvm_get_cpucfg() to _kvm_get_cpucfg_mask()
>       LoongArch: KVM: Streamline kvm_check_cpucfg() and improve comments
>
> Wayne Lin (1):
>       drm/amd/display: adjust few initialization order in dm
>
> Will Deacon (1):
>       Revert "arm64: jump_label: use constraints "Si" instead of "i""
>
> Xu Yang (2):
>       usb: roles: fix NULL pointer issue when put module's reference
>       usb: roles: don't get/set_role() when usb_role_switch is unregister=
ed
>
> Yafang Shao (2):
>       bpf: Fix an issue due to uninitialized bpf_iter_task
>       selftests/bpf: Add negtive test cases for task iter
>
> Yi Liu (9):
>       iommu/vt-d: Track nested domains in parent
>       iommu/vt-d: Add __iommu_flush_iotlb_psi()
>       iommu/vt-d: Add missing iotlb flush for parent domain
>       iommu/vt-d: Update iotlb in nested domain attach
>       iommu/vt-d: Add missing device iotlb flush for parent domain
>       iommu/vt-d: Remove domain parameter for intel_pasid_setup_dirty_tra=
cking()
>       iommu/vt-d: Wrap the dirty tracking loop to be a helper
>       iommu/vt-d: Add missing dirty tracking set for parent domain
>       iommu/vt-d: Set SSADE when attaching to a parent with dirty trackin=
g
>
> Yishai Hadas (1):
>       RDMA/mlx5: Relax DEVX access upon modify commands
>
> Yosry Ahmed (1):
>       mm: zswap: fix missing folio cleanup in writeback race path
>
> Yu Kuai (6):
>       md: Fix missing release of 'active_io' for flush
>       md: Don't ignore suspended array in md_check_recovery()
>       md: Don't ignore read-only array in md_check_recovery()
>       md: Make sure md_do_sync() will set MD_RECOVERY_DONE
>       md: Don't register sync_thread for reshape directly
>       md: Don't suspend the array for interrupted reshape
>
> Zhipeng Lu (1):
>       IB/hfi1: Fix a memleak in init_credit_return
>
> zhenwei pi (1):
>       crypto: virtio/akcipher - Fix stack overflow on memcpy
>

