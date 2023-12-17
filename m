Return-Path: <linux-kernel+bounces-2876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59F81638E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2276F282B12
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB54B12C;
	Sun, 17 Dec 2023 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Egg8NUtg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF434B124
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc6d9b4c6aso5943841fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702857244; x=1703462044; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kyeJqu9FRNBTubLUfyj+HGCjhB0GLncjv7zjP0n/0tI=;
        b=Egg8NUtgQFdsN/+WM/PZMQMo/wgj0sj7UEizlccY81vXhWuQ9766Rvm8OXWg+sa8iX
         4qzVnSVuNdEihatAnMOa8tbzm7aG+1lnLuwno0KCBJ6DCGEmUmAOsjUsZUEbr6Axr9If
         Glg/datEKniwj1z5HF3yr6OTnjOiGb3GpO8A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857244; x=1703462044;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyeJqu9FRNBTubLUfyj+HGCjhB0GLncjv7zjP0n/0tI=;
        b=rYNXeuL4T5gcDrSzLcIkGPNcW7LC5VMnDV7JX809pRgEmDrVe7QHJBRa2kZSqBYpcw
         RbW/9M62qeKfV3HTo9/4zFVs6LP8lewrfjD875izl183KegJcuN7w0qu57z1Vi4EeBK6
         exVR/RuxhVqXi6Z2bC5cU3hKpQtcfNRgOxrwnyAGcfZ+XW+AK4nFn7GMw3x9TTL94YHP
         Wf5aV9dKT++pO+Aq7KjDKxzDEcquErqsLG5e3eGkWMwvHPrIwvUyC4xzjLnnap4QLB5s
         triSR3JuRjNTlZKwDXuR3JxIFLVO/Im6ezmYDVw2Od4re+BpqK8rwS3Dt6IiSgUhJj25
         6i5Q==
X-Gm-Message-State: AOJu0YwrahJXiIQnzdk717AWRoxgmZ+j8hoU34ogV1NQ7Wd7GgUGPUpk
	Bt0wd0Id8F0AKEfgmPXSsIfAn4mVvBPsO/d5WNEw1bsD
X-Google-Smtp-Source: AGHT+IGuRiSNky7KpckUCEfw6ThEB8fZ8L1uFTALSgGCzqMzReTUCqKh4kAMTezkN9KSdck71zPaOQ==
X-Received: by 2002:a05:651c:12c8:b0:2cc:1fd1:699e with SMTP id 8-20020a05651c12c800b002cc1fd1699emr9522212lje.92.1702857244035;
        Sun, 17 Dec 2023 15:54:04 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 10-20020a2eb94a000000b002cc6c35aa5bsm348671ljs.128.2023.12.17.15.54.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 15:54:03 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50c222a022dso2839131e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:54:03 -0800 (PST)
X-Received: by 2002:a05:6512:e94:b0:50b:f9b5:b4de with SMTP id
 bi20-20020a0565120e9400b0050bf9b5b4demr8865575lfb.40.1702857242961; Sun, 17
 Dec 2023 15:54:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Dec 2023 15:53:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi17USyiO=G0yDXP62eqU3V6x3ck0HcnVMPKHNPsBP_ig@mail.gmail.com>
Message-ID: <CAHk-=wi17USyiO=G0yDXP62eqU3V6x3ck0HcnVMPKHNPsBP_ig@mail.gmail.com>
Subject: Linux 6.7-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm. Nothing really stands out for this rc, which is all good. The
diffstat looks mostly nice and flat (which tends just to be a sign of
"small changes spread out"), with the exception of a couple of random
drivers that just had a bit more churn than others (mellanox and intel
iavf ethernet driver).

The other thing that stands out in the diffstat (although a lot less),
is some removal of some legacy debugging code that harkens back to the
copy-on-write credentials that were introduced in 2008, and that then
caused us to later introduce some self-checking code for that change.
I think we can lay that to rest, since that copy-on-write credential
model has now been around for 15 years and has probably never actually
found anything (the report that caused it is sadly lost in the mists
of time and the long-ago demise of kerneloops.org). In related news,
apparently nobody is silly enough to enable that code anyway.

That one was triggered by a "we should re-order the members of the
'cred' structure for the debug case because one of the types changed
size", but  rather than fix that code up, I asked Jens to just remove
the verification code that nobody enables and that isn't really
relevant any more.

But realistically, despite those few blips on the diffstat, most of
this ends up just being various random fixes all over. Filesystems are
maybe showing up more than usual (smb client and server, btrfs,
bcachefs and fuse), and we've got some tracing, mm and selftest
updates, but the bulk of it all is still (as usual) various random
driver fixes.

Shortlog appended. Please do give this a test in between the
last-minute xmas shopping or whatever else is going on ...

              Linus

---

Al Viro (2):
      fix ufs_get_locked_folio() breakage
      io_uring/cmd: fix breakage in SOCKET_URING_OP_SIOC* implementation

Alex Bee (1):
      clk: rockchip: rk3128: Fix SCLK_SDMMC's clock name

Alex Deucher (2):
      drm/amdgpu: fix buffer funcs setting order on suspend harder
      drm/amdgpu/sdma5.2: add begin/end_use ring callbacks

Alison Schofield (3):
      cxl/core: Always hold region_rwsem while reading poison lists
      cxl/memdev: Hold region_rwsem during inject and clear poison ops
      kernel/resource: Increment by align value in get_free_mem_region()

Amelie Delaunay (1):
      dmaengine: stm32-dma: avoid bitfield overflow assertion

Amir Goldstein (1):
      fuse: disable FOPEN_PARALLEL_DIRECT_WRITES with FUSE_DIRECT_IO_ALLOW_=
MMAP

Andrew Davis (1):
      phy: ti: gmii-sel: Fix register offset when parent is not a syscon no=
de

Andrew Halaney (1):
      net: stmmac: Handle disabled MDIO busses from devicetree

Andrzej Kacprowski (1):
      accel/ivpu/37xx: Fix interrupt_clear_with_0 WA initialization

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_disp_gamma: Fix breakage due to merge issue

Ard Biesheuvel (1):
      efi/x86: Avoid physical KASLR on older Dell systems

Baokun Li (1):
      ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Baoquan He (6):
      riscv: fix VMALLOC_START definition
      loongarch, kexec: change dependency of object files
      m68k, kexec: fix the incorrect ifdeffery and build dependency of
CONFIG_KEXEC
      mips, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEX=
EC
      sh, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
      x86, kexec: fix the wrong ifdeffery CONFIG_KEXEC

Beau Belgrave (1):
      eventfs: Fix events beyond NAME_MAX blocking tasks

Bjorn Helgaas (1):
      Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

Boris Burkov (5):
      btrfs: free qgroup reserve when ORDERED_IOERR is set
      btrfs: fix qgroup_free_reserved_data int overflow
      btrfs: free qgroup pertrans reserve on transaction abort
      btrfs: don't clear qgroup reserved bit in release_folio
      btrfs: ensure releasing squota reserve on head refs

Brian Foster (1):
      bcachefs: don't attempt rw on unfreeze when shutdown

Chao Song (1):
      soundwire: intel_ace2x: fix AC timing setting for ACE2.x

Chengfeng Ye (2):
      atm: solos-pci: Fix potential deadlock on &cli_queue_lock
      atm: solos-pci: Fix potential deadlock on &tx_queue_lock

Chris Mi (2):
      net/mlx5e: Disable IPsec offload support if not FW steering
      net/mlx5e: TC, Don't offload post action rule if not supported

Chris Morgan (1):
      clk: rockchip: rk3568: Add PLL rate for 292.5MHz

Christian K=C3=B6nig (2):
      drm/amdgpu: fix tear down order in amdgpu_vm_pt_free
      drm/amdgpu: warn when there are still mappings when a BO is destroyed=
 v2

Dan Carpenter (1):
      net/mlx5: Fix a NULL vs IS_ERR() check

Dan Williams (1):
      cxl/hdm: Fix dpa translation locking

Daniel Hill (1):
      bcachefs: rebalance shouldn't attempt to compress unwritten extents

Dave Jiang (2):
      cxl/hdm: Fix a benign lockdep splat
      cxl: Add cxl_num_decoders_committed() usage to cxl_test

David Arinzon (4):
      net: ena: Destroy correct number of xdp queues upon failure
      net: ena: Fix xdp drops handling due to multibuf packets
      net: ena: Fix DMA syncing in XDP path when SWIOTLB is on
      net: ena: Fix XDP redirection error

David Heidelberg (1):
      dt-bindings: panel-simple-dsi: move LG 5" HD TFT LCD panel into DSI y=
aml

David Hildenbrand (1):
      selftests/mm: cow: print ksft header before printing anything else

David Howells (1):
      afs: Fix refcount underflow from error handling race

David Stevens (1):
      mm/shmem: fix race in shmem_undo_range w/THP

Dinghao Liu (1):
      qed: Fix a potential use-after-free in qed_cxt_tables_alloc

Dmitrii Galantsev (1):
      drm/amd/pm: fix pp_*clk_od typo

Dong Chenchen (1):
      net: Remove acked SYN flag from packet in the transmit queue correctl=
y

Eric Dumazet (2):
      tcp: fix tcp_disordered_ack() vs usec TS resolution
      net: prevent mss overflow in skb_segment()

Fangzhi Zuo (1):
      drm/amd/display: Populate dtbclk from bounding box

Farouk Bouabid (1):
      drm/panel: ltk050h3146w: Set burst mode for ltk050h3148w

Finley Xiao (1):
      clk: rockchip: rk3128: Fix aclk_peri_src's parent

Florent Revest (1):
      team: Fix use-after-free when an option instance allocation fails

Frank Li (1):
      dmaengine: fsl-edma: fix DMA channel leak in eDMAv4

Gavin Li (1):
      net/mlx5e: Check netdev pointer before checking its net ns

Gergo Koteles (4):
      ALSA: hda/tas2781: leave hda_component in usable state
      ALSA: hda/tas2781: handle missing EFI calibration data
      ALSA: hda/tas2781: call cleanup functions only once
      ALSA: hda/tas2781: reset the amp before component_add

Guanjun (2):
      dmaengine: idxd: Protect int_handle field in hw descriptor
      dmaengine: idxd: Fix incorrect descriptions for GRPCFG register

Hamza Mahfooz (1):
      drm/amd/display: fix hw rotated modes when PSR-SU is enabled

Hangyu Hua (1):
      fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()

Hans de Goede (1):
      platform/x86: intel-vbtn: Fix missing tablet-mode-switch events

Haren Myneni (1):
      powerpc/pseries/vas: Migration suspend waits for no in-progress
open windows

Hariprasad Kelam (3):
      octeontx2-pf: Fix promisc mcam entry action
      octeontx2-af: Update RSS algorithm index
      octeontx2-af: Fix pause frame configuration

Hartmut Knaack (1):
      ALSA: hda/realtek: Apply mute LED quirk for HP15-db

Hyunwoo Kim (3):
      atm: Fix Use-After-Free in do_vcc_ioctl
      net/rose: Fix Use-After-Free in rose_ioctl
      appletalk: Fix Use-After-Free in atalk_ioctl

Ignat Korchagin (1):
      kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP

Igor Russkikh (1):
      net: atlantic: fix double free in ring reinit logic

Ioana Ciornei (2):
      dpaa2-switch: fix size of the dma_unmap
      dpaa2-switch: do not ask for MDB, VLAN and FDB replay

Ira Weiny (2):
      cxl/cdat: Free correct buffer on checksum error
      cxl/pmu: Ensure put_device on pmu devices

Jagadeesh Kona (1):
      clk: qcom: Fix SM_CAMCC_8550 dependencies

Jai Luthra (1):
      dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data

Jakub Kicinski (1):
      Revert "tcp: disable tcp_autocorking for socket when TCP_NODELAY
flag is set"

James Houghton (1):
      arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

Jan Kara (1):
      ext4: fix warning in ext4_dio_write_end_io()

Jani Nikula (3):
      drm/crtc: fix uninitialized variable use
      drm/i915/edp: don't write to DP_LINK_BW_SET when using rate select
      drm/edid: also call add modes in EDID connector update fallback

Jason-JH.Lin (1):
      drm/mediatek: Add spinlock for setting vblank event in atomic_begin

Jens Axboe (3):
      io_uring/poll: don't enable lazy wake for POLLEXCLUSIVE
      cred: switch to using atomic_long_t
      cred: get rid of CONFIG_DEBUG_CREDENTIALS

Jianbo Liu (2):
      net/mlx5e: Reduce eswitch mode_lock protection context
      net/mlx5e: Check the number of elements before walk TC rhashtable

Jiaxun Yang (1):
      PCI: loongson: Limit MRRS to 256

Jiri Kosina (1):
      mailmap: add address mapping for Jiri Kosina

Jiri Pirko (1):
      dpll: sanitize possible null pointer dereference in
dpll_pin_parent_pin_set()

Johan Hovold (6):
      PCI/ASPM: Add pci_enable_link_state_locked()
      PCI: vmd: Fix potential deadlock when enabling ASPM
      PCI: qcom: Fix potential deadlock when enabling ASPM
      PCI: qcom: Clean up ASPM comment
      PCI/ASPM: Clean up __pci_disable_link_state() 'sem' parameter
      PCI/ASPM: Add pci_disable_link_state_locked() lockdep assert

John Hubbard (1):
      Revert "selftests: error out if kernel header files are not yet built=
"

Josef Bacik (1):
      btrfs: do not allow non subvolume root targets for snapshot

Judy Hsiao (1):
      neighbour: Don't let neigh_forced_gc() disable preemption for long

Kai Vehmanen (2):
      ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB
      ALSA: hda/hdmi: add force-connect quirks for ASUSTeK Z170 variants

Kalesh AP (1):
      bnxt_en: Fix wrong return value check in bnxt_close_nic()

Karsten Graul (1):
      MAINTAINERS: remove myself as maintainer of SMC

Kefeng Wang (1):
      mm: fix VMA heap bounds checking

Kent Overstreet (10):
      bcachefs: Don't drop journal pins in exit path
      bcachefs; Don't use btree write buffer until journal replay is finish=
ed
      bcachefs: Fix a journal deadlock in replay
      bcachefs: Fix bch2_extent_drop_ptrs() call
      bcachefs: Convert compression_stats to for_each_btree_key2
      bcachefs: Don't run indirect extent trigger unless inserting/deleting
      bcachefs: Fix creating snapshot with implict source
      bcachefs: Fix deleted inode check for dirs
      bcachefs: Fix uninitialized var in bch2_journal_replay()
      bcachefs: Close journal entry if necessary when flushing all pins

Krister Johansen (1):
      fuse: share lookup state between submount and its parent

Krzysztof Kozlowski (3):
      soundwire: stream: fix NULL pointer dereference for multi_link
      stmmac: dwmac-loongson: drop useless check for compatible fallback
      MIPS: dts: loongson: drop incorrect dwmac fallback compatible

Leon Romanovsky (4):
      net/mlx5e: Honor user choice of IPsec replay window size
      net/mlx5e: Ensure that IPsec sequence packet number starts from 1
      net/mlx5e: Remove exposure of IPsec RX flow steering struct
      net/mlx5e: Tidy up IPsec NAT-T SA discovery

Lingkai Dong (1):
      drm: Fix FD ownership check in drm_master_check_perm()

Linus Torvalds (1):
      Linux 6.7-rc6

Lyude Paul (1):
      drm/nouveau/kms/nv50-: Don't allow inheritance of headless iors

Maciej =C5=BBenczykowski (1):
      net: ipv6: support reporting otherwise unknown prefix flags in
RTM_NEWPREFIX

Mario Limonciello (4):
      HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]
      drm/amd/display: Restore guard against default backlight value < 1 ni=
t
      drm/amd/display: Disable PSR-SU on Parade 0803 TCON again
      drm/amd: Fix a probing order problem on SDMA 2.4

Mark Rutland (1):
      perf: Fix perf_event_validate_size() lockdep splat

Mathieu Desnoyers (1):
      ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()

Michael Chan (1):
      bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic

Michael Ellerman (1):
      MAINTAINERS: powerpc: Add Aneesh & Naveen

Michael Walle (2):
      drm/mediatek: fix kernel oops if no crtc is found
      phy: mediatek: mipi: mt8183: fix minimal supported frequency

Mikhail Khvainitski (1):
      HID: lenovo: Restrict detection of patched firmware only to USB cptkb=
d

Moshe Shemesh (2):
      net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work
      net/mlx5: Nack sync reset request when HotPlug is enabled

Namjae Jeon (8):
      ksmbd: set epoch in create context v2 lease
      ksmbd: set v2 lease capability
      ksmbd: downgrade RWH lease caching state to RH for directory
      ksmbd: send v2 lease break notification for directory
      ksmbd: lazy v2 lease break on smb2_write()
      ksmbd: avoid duplicate opinfo_put() call on error of
smb21_lease_break_ack()
      ksmbd: fix wrong allocation size update in smb2_open()
      ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Nikolay Kuratov (1):
      vsock/virtio: Fix unsigned integer wrap around in
virtio_transport_has_space()

Patrisious Haddad (2):
      net/mlx5e: Unify esw and normal IPsec status table creation/destructi=
on
      net/mlx5e: Add IPsec and ASO syndromes check in HW

Paulo Alcantara (4):
      smb: client: fix OOB in receive_encrypted_standard()
      smb: client: fix potential OOBs in smb2_parse_contexts()
      smb: client: fix NULL deref in asn1_ber_decoder()
      smb: client: fix OOB in smb2_query_reparse_point()

Pavel Begunkov (1):
      io_uring/af_unix: disable sending io_uring over sockets

Piotr Gardocki (2):
      iavf: Introduce new state machines for flow director
      iavf: Handle ntuple on/off based on new state machines for flow direc=
tor

Radu Bulie (1):
      net: fec: correct queue selection

Randy Dunlap (2):
      platform/x86: thinkpad_acpi: fix kernel-doc warnings
      platform/x86: intel_ips: fix kernel-doc formatting

Robin Murphy (1):
      perf/arm-cmn: Fail DTC counter allocation correctly

Ronald Wahl (1):
      dmaengine: ti: k3-psil-am62: Fix SPI PDMA data

Saleemkhan Jamadar (1):
      drm/amdgpu/jpeg: configure doorbell for each playback

Salvatore Dipietro (1):
      tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set

Sebastian Parschauer (1):
      HID: Add quirk for Labtec/ODDOR/aikeec handbrake

SeongJae Park (1):
      mm/damon/core: make damon_start() waits until kdamond_fn() starts

Shinas Rasheed (2):
      octeon_ep: initialise control mbox tasks before using APIs
      octeon_ep: explicitly test for firmware ready value

Shubhrajyoti Datta (1):
      EDAC/versal: Read num_csrows and num_chans using the correct
bitfield macro

Slawomir Laba (1):
      iavf: Fix iavf_shutdown to call iavf_remove instead iavf_close

Sneh Shah (1):
      net: stmmac: dwmac-qcom-ethqos: Fix drops in 10M SGMII RX

Somnath Kotur (1):
      bnxt_en: Clear resource reservation during resume

Sreekanth Reddy (1):
      bnxt_en: Fix skb recycling logic in bnxt_deliver_skb()

Stefan Wahren (3):
      qca_debug: Prevent crash on TX ring changes
      qca_debug: Fix ethtool -G iface tx behavior
      qca_spi: Fix reset behavior

Steven Rostedt (Google) (12):
      ring-buffer: Fix writing to the buffer with max_data_size
      tracing: Have large events show up as '[LINE TOO BIG]' instead of not=
hing
      ring-buffer: Fix memory leak of free page
      tracing: Update snapshot buffer on resize if it is allocated
      ring-buffer: Do not update before stamp when switching sub-buffers
      ring-buffer: Have saved event hold the entire event
      tracing: Add size check when printing trace_marker output
      ring-buffer: Do not try to put back write_stamp
      ring-buffer: Remove useless update to write_stamp in rb_try_to_discar=
d()
      ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs
      ring-buffer: Have rb_time_cmpxchg() set the msb counter too
      ring-buffer: Do not record in NMI if the arch does not support
cmpxchg in NMI

Stuart Lee (1):
      drm/mediatek: Fix access violation in mtk_drm_crtc_dma_dev_get

Su Hui (1):
      phy: sunplus: return negative error code in sp_usb_phy_probe

Taimur Hassan (1):
      drm/amd/display: Revert "Fix conversions between bytes and KB"

Thierry Reding (1):
      drm/nouveau: Fixup gk20a instobj hierarchy

Tvrtko Ursulin (2):
      drm/i915/selftests: Fix engine reset count storage for multi-tile
      drm/i915: Use internal class when counting engine resets

Tyler Fanelli (2):
      fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
      docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Fix remapped stride with CCS on ADL+
      drm/i915: Fix intel_atomic_setup_scalers() plane_state handling
      drm/i915: Fix ADL+ tiled plane stride when the POT stride is
smaller than the original

Vlad Buslov (1):
      net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table

Wang Yao (1):
      efi/loongarch: Use load address to calculate kernel entry address

Weihao Li (1):
      clk: rockchip: rk3128: Fix HCLK_OTG gate register

Xiaolei Wang (2):
      dmaengine: fsl-edma: Do not suspend and resume the masked dma
channel when the system is sleeping
      dmaengine: fsl-edma: Add judgment on enabling round robin arbitration

Yan Jun (1):
      HID: apple: Add "hfd.cn" and "WKB603" to the list of non-apple keyboa=
rds

Yang Yingliang (1):
      dmaengine: fsl-edma: fix wrong pointer check in fsl_edma3_attach_pd()

Yanteng Si (1):
      stmmac: dwmac-loongson: Make sure MDIO is initialized before use

Ye Bin (1):
      jbd2: fix soft lockup in journal_finish_inode_data_buffers()

Yu Zhao (4):
      mm/mglru: fix underprotected page cache
      mm/mglru: try to stop at high watermarks
      mm/mglru: respect min_ttl_ms with memcgs
      mm/mglru: reclaim offlined memcgs harder

Yuntao Wang (1):
      crash_core: fix the check for whether crashkernel is from high memory

Yusong Gao (1):
      sign-file: Fix incorrect return values check

Zhang Yi (2):
      jbd2: correct the printing of write_flags in jbd2_write_superblock()
      jbd2: increase the journal IO's priority

Zheng Yejian (1):
      tracing: Fix uaf issue when open the hist or hist_debug file

Zhipeng Lu (1):
      octeontx2-af: fix a use-after-free in rvu_nix_register_reporters

Ziqi Zhao (1):
      drm/crtc: Fix uninit-value bug in drm_mode_setcrtc

Zizhi Wo (1):
      ksmbd: fix memory leak in smb2_lock()

