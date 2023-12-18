Return-Path: <linux-kernel+bounces-3800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1F58171CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38370B226CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98D5BFB3;
	Mon, 18 Dec 2023 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hb9r6S57"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B645A867;
	Mon, 18 Dec 2023 14:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD9EC433C9;
	Mon, 18 Dec 2023 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908032;
	bh=NTSfV2+DrnWK3rP6qxz05vBx5ksV8EkPX5AjZqu+B/4=;
	h=From:To:Cc:Subject:Date:From;
	b=hb9r6S57NWwVP4xkGdhnzsjqBUWKKT7tkKNFPlniyo6gH27SWM5gybXwrmXEzz4Ee
	 DkFalDWtsccnwi9E7rsVmFqlDpvLxKjI9iQ9wjCIIAO+76pbT7G35VaW2GXyVOmoMd
	 t9XKxgccPeSwUnmvYl+MBCmvoS8iqJlCT1pgfP2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 6.6 000/166] 6.6.8-rc1 review
Date: Mon, 18 Dec 2023 14:49:26 +0100
Message-ID: <20231218135104.927894164@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.8-rc1
X-KernelTest-Deadline: 2023-12-20T13:51+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.8 release.
There are 166 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.8-rc1

Patrisious Haddad <phaddad@nvidia.com>
    RDMA/mlx5: Change the key being sent for MPV device affiliation

Fangrui Song <maskray@google.com>
    x86/speculation, objtool: Use absolute relocations for annotations

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Have rb_time_cmpxchg() set the msb counter too

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not try to put back write_stamp

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix writing to the buffer with max_data_size

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Have saved event hold the entire event

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not update before stamp when switching sub-buffers

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Update snapshot buffer on resize if it is allocated

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix memory leak of free page

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smb2_query_reparse_point()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix NULL deref in asn1_ber_decoder()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential OOBs in smb2_parse_contexts()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in receive_encrypted_standard()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix remapped stride with CCS on ADL+

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix intel_atomic_setup_scalers() plane_state handling

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix ADL+ tiled plane stride when the POT stride is smaller than the original

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Disable PSR-SU on Parade 0803 TCON again

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Restore guard against default backlight value < 1 nit

Jani Nikula <jani.nikula@intel.com>
    drm/edid: also call add modes in EDID connector update fallback

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix tear down order in amdgpu_vm_pt_free

Boris Burkov <boris@bur.io>
    btrfs: don't clear qgroup reserved bit in release_folio

Boris Burkov <boris@bur.io>
    btrfs: fix qgroup_free_reserved_data int overflow

Boris Burkov <boris@bur.io>
    btrfs: free qgroup reserve when ORDERED_IOERR is set

Ignat Korchagin <ignat@cloudflare.com>
    kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP

David Stevens <stevensd@chromium.org>
    mm/shmem: fix race in shmem_undo_range w/THP

Yu Zhao <yuzhao@google.com>
    mm/mglru: reclaim offlined memcgs harder

Yu Zhao <yuzhao@google.com>
    mm/mglru: respect min_ttl_ms with memcgs

Yu Zhao <yuzhao@google.com>
    mm/mglru: try to stop at high watermarks

Yu Zhao <yuzhao@google.com>
    mm/mglru: fix underprotected page cache

Frank Li <Frank.Li@nxp.com>
    dmaengine: fsl-edma: fix DMA channel leak in eDMAv4

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-dma: avoid bitfield overflow assertion

Stuart Lee <stuart.lee@mediatek.com>
    drm/mediatek: Fix access violation in mtk_drm_crtc_dma_dev_get

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/sdma5.2: add begin/end_use ring callbacks

Florent Revest <revest@chromium.org>
    team: Fix use-after-free when an option instance allocation fails

James Houghton <jthoughton@google.com>
    arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

John Hubbard <jhubbard@nvidia.com>
    Revert "selftests: error out if kernel header files are not yet built"

Baokun Li <libaokun1@huawei.com>
    ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: stream: fix NULL pointer dereference for multi_link

Dan Williams <dan.j.williams@intel.com>
    cxl/hdm: Fix dpa translation locking

Josef Bacik <josef@toxicpanda.com>
    btrfs: do not allow non subvolume root targets for snapshot

Mark Rutland <mark.rutland@arm.com>
    perf: Fix perf_event_validate_size() lockdep splat

Denis Benato <benato.denis96@gmail.com>
    HID: hid-asus: add const to read-only outgoing usb buffer

Masahiro Yamada <masahiroy@kernel.org>
    arm64: add dependency between vmlinuz.efi and Image

Paulo Alcantara <pc@manguebit.com>
    smb: client: set correct file type from NFS reparse points

Paulo Alcantara <pc@manguebit.com>
    smb: client: introduce ->parse_reparse_point()

Paulo Alcantara <pc@manguebit.com>
    smb: client: implement ->query_reparse_point() for SMB1

Lech Perczak <lech.perczak@gmail.com>
    net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Steven Rostedt (Google) <rostedt@goodmis.org>
    eventfs: Do not allow NULL parent to eventfs_start_creating()

Linus Torvalds <torvalds@linux-foundation.org>
    asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation

Heiko Carstens <hca@linux.ibm.com>
    scripts/checkstack.pl: match all stack sizes for s390

Nguyen Dinh Phi <phind.uet@gmail.com>
    nfc: virtual_ncidev: Add variable to check if ndev is running

Aoba K <nexp_0x17@outlook.com>
    HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Denis Benato <benato.denis96@gmail.com>
    HID: hid-asus: reset the backlight brightness level on resume

Li Nan <linan122@huawei.com>
    nbd: pass nbd_sock to nbd_read_reply() instead of index

Oliver Neukum <oneukum@suse.com>
    HID: add ALWAYS_POLL quirk for Apple kb

Brett Raye <braye@fastmail.com>
    HID: glorious: fix Glorious Model I HID report

Yihong Cao <caoyihong4@outlook.com>
    HID: apple: add Jamesdonkey and A3R to non-apple keyboards list

Hamish Martin <hamish.martin@alliedtelesis.co.nz>
    HID: mcp2221: Allow IO to start during probe

Hamish Martin <hamish.martin@alliedtelesis.co.nz>
    HID: mcp2221: Set driver data before I2C adapter add

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: intel_telemetry: Fix kernel doc descriptions

Bibo Mao <maobibo@loongson.cn>
    LoongArch: Implement constant timer shutdown interface

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Mark {dmw,tlb}_virt_to_page() exports as non-GPL

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Silence the boot warning about 'nokaslr'

WANG Rui <wangrui@loongson.cn>
    LoongArch: Record pc instead of offset in la_abs relocation

Masahiro Yamada <masahiroy@kernel.org>
    LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: fix bpf_loop_bench for new callback verification scheme

Hannes Reinecke <hare@suse.de>
    nvme: catch errors from nvme_configure_metadata()

Mark O'Donovan <shiftee@posteo.net>
    nvme-auth: set explanation code for failure2 msgs

Li Nan <linan122@huawei.com>
    nbd: fix null-ptr-dereference while accessing 'nbd->config'

Li Nan <linan122@huawei.com>
    nbd: factor out a helper to get nbd_config without holding 'config_lock'

Li Nan <linan122@huawei.com>
    nbd: fold nbd config initialization into nbd_alloc_config()

Coly Li <colyli@suse.de>
    bcache: avoid NULL checking to c->root in run_cache_set()

Coly Li <colyli@suse.de>
    bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()

Colin Ian King <colin.i.king@gmail.com>
    bcache: remove redundant assignment to variable cur_idx

Coly Li <colyli@suse.de>
    bcache: avoid oversize memory allocation by small stripe_size

Ming Lei <ming.lei@redhat.com>
    blk-cgroup: bypass blkcg_deactivate_policy after destroying

Ming Lei <ming.lei@redhat.com>
    blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"

David Howells <dhowells@redhat.com>
    rxrpc: Fix some minor issues with bundle tracing

Jean Delvare <jdelvare@suse.de>
    stmmac: dwmac-loongson: Add architecture dependency

Oliver Neukum <oneukum@suse.com>
    usb: aqc111: check packet for fixup for true limit

Saurabh Sengar <ssengar@linux.microsoft.com>
    x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM

David Hildenbrand <david@redhat.com>
    selftests/mm: cow: print ksft header before printing anything else

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915: Use internal class when counting engine resets

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915/selftests: Fix engine reset count storage for multi-tile

Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
    accel/ivpu/37xx: Fix interrupt_clear_with_0 WA initialization

Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
    accel/ivpu: Print information about used workarounds

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Add spinlock for setting vblank event in atomic_begin

Michael Walle <mwalle@kernel.org>
    drm/mediatek: fix kernel oops if no crtc is found

Johan Hovold <johan+linaro@kernel.org>
    PCI: vmd: Fix potential deadlock when enabling ASPM

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Johan Hovold <johan+linaro@kernel.org>
    PCI/ASPM: Add pci_enable_link_state_locked()

Jiaxun Yang <jiaxun.yang@flygoat.com>
    PCI: loongson: Limit MRRS to 256

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: reset the amp before component_add

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: call cleanup functions only once

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: handle missing EFI calibration data

Gergo Koteles <soyer@irl.hu>
    ALSA: hda/tas2781: leave hda_component in usable state

Hartmut Knaack <knaack.h@gmx.de>
    ALSA: hda/realtek: Apply mute LED quirk for HP15-db

Kai Vehmanen <kai.vehmanen@linux.intel.com>
    ALSA: hda/hdmi: add force-connect quirks for ASUSTeK Z170 variants

Kai Vehmanen <kai.vehmanen@linux.intel.com>
    ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB

Al Viro <viro@zeniv.linux.org.uk>
    io_uring/cmd: fix breakage in SOCKET_URING_OP_SIOC* implementation

Hangyu Hua <hbh25y@gmail.com>
    fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()

Amir Goldstein <amir73il@gmail.com>
    fuse: disable FOPEN_PARALLEL_DIRECT_WRITES with FUSE_DIRECT_IO_ALLOW_MMAP

Krister Johansen <kjlx@templeofstupid.com>
    fuse: share lookup state between submount and its parent

Tyler Fanelli <tfanelli@redhat.com>
    fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP

Sebastian Parschauer <s.parschauer@gmx.de>
    HID: Add quirk for Labtec/ODDOR/aikeec handbrake

Mario Limonciello <mario.limonciello@amd.com>
    HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]

Jens Axboe <axboe@kernel.dk>
    cred: get rid of CONFIG_DEBUG_CREDENTIALS

Jens Axboe <axboe@kernel.dk>
    cred: switch to using atomic_long_t

Igor Russkikh <irusskikh@marvell.com>
    net: atlantic: fix double free in ring reinit logic

Hyunwoo Kim <v4bel@theori.io>
    appletalk: Fix Use-After-Free in atalk_ioctl

Andrew Halaney <ahalaney@redhat.com>
    net: stmmac: Handle disabled MDIO busses from devicetree

Sneh Shah <quic_snehshah@quicinc.com>
    net: stmmac: dwmac-qcom-ethqos: Fix drops in 10M SGMII RX

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-switch: do not ask for MDB, VLAN and FDB replay

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-switch: fix size of the dma_unmap

Nikolay Kuratov <kniv@yandex-team.ru>
    vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()

Yusong Gao <a869920004@gmail.com>
    sign-file: Fix incorrect return values check

Yanteng Si <siyanteng@loongson.cn>
    stmmac: dwmac-loongson: Make sure MDIO is initialized before use

David Arinzon <darinzon@amazon.com>
    net: ena: Fix XDP redirection error

David Arinzon <darinzon@amazon.com>
    net: ena: Fix DMA syncing in XDP path when SWIOTLB is on

David Arinzon <darinzon@amazon.com>
    net: ena: Fix xdp drops handling due to multibuf packets

David Arinzon <darinzon@amazon.com>
    net: ena: Destroy correct number of xdp queues upon failure

Dong Chenchen <dongchenchen2@huawei.com>
    net: Remove acked SYN flag from packet in the transmit queue correctly

Dinghao Liu <dinghao.liu@zju.edu.cn>
    qed: Fix a potential use-after-free in qed_cxt_tables_alloc

Slawomir Laba <slawomirx.laba@intel.com>
    iavf: Fix iavf_shutdown to call iavf_remove instead iavf_close

Piotr Gardocki <piotrx.gardocki@intel.com>
    iavf: Handle ntuple on/off based on new state machines for flow director

Piotr Gardocki <piotrx.gardocki@intel.com>
    iavf: Introduce new state machines for flow director

Hyunwoo Kim <v4bel@theori.io>
    net/rose: Fix Use-After-Free in rose_ioctl

Hyunwoo Kim <v4bel@theori.io>
    atm: Fix Use-After-Free in do_vcc_ioctl

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Fix pause frame configuration

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Update RSS algorithm index

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-pf: Fix promisc mcam entry action

Shinas Rasheed <srasheed@marvell.com>
    octeon_ep: explicitly test for firmware ready value

Vlad Buslov <vladbu@nvidia.com>
    net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table

Zhipeng Lu <alexious@zju.edu.cn>
    octeontx2-af: fix a use-after-free in rvu_nix_register_reporters

Radu Bulie <radu-andrei.bulie@nxp.com>
    net: fec: correct queue selection

Chengfeng Ye <dg573847474@gmail.com>
    atm: solos-pci: Fix potential deadlock on &tx_queue_lock

Chengfeng Ye <dg573847474@gmail.com>
    atm: solos-pci: Fix potential deadlock on &cli_queue_lock

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    bnxt_en: Fix wrong return value check in bnxt_close_nic()

Sreekanth Reddy <sreekanth.reddy@broadcom.com>
    bnxt_en: Fix skb recycling logic in bnxt_deliver_skb()

Somnath Kotur <somnath.kotur@broadcom.com>
    bnxt_en: Clear resource reservation during resume

Stefan Wahren <wahrenst@gmx.net>
    qca_spi: Fix reset behavior

Stefan Wahren <wahrenst@gmx.net>
    qca_debug: Fix ethtool -G iface tx behavior

Stefan Wahren <wahrenst@gmx.net>
    qca_debug: Prevent crash on TX ring changes

Maciej Żenczykowski <maze@google.com>
    net: ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX

Dan Carpenter <dan.carpenter@linaro.org>
    net/mlx5: Fix a NULL vs IS_ERR() check

Gavin Li <gavinl@nvidia.com>
    net/mlx5e: Check netdev pointer before checking its net ns

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Nack sync reset request when HotPlug is enabled

Chris Mi <cmi@nvidia.com>
    net/mlx5e: TC, Don't offload post action rule if not supported

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work

Chris Mi <cmi@nvidia.com>
    net/mlx5e: Disable IPsec offload support if not FW steering

Patrisious Haddad <phaddad@nvidia.com>
    RDMA/mlx5: Send events from IB driver about device affiliation state

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5e: Check the number of elements before walk TC rhashtable

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5e: Reduce eswitch mode_lock protection context

Leon Romanovsky <leon@kernel.org>
    net/mlx5e: Tidy up IPsec NAT-T SA discovery

Patrisious Haddad <phaddad@nvidia.com>
    net/mlx5e: Unify esw and normal IPsec status table creation/destruction

Leon Romanovsky <leon@kernel.org>
    net/mlx5e: Ensure that IPsec sequence packet number starts from 1

Leon Romanovsky <leon@kernel.org>
    net/mlx5e: Honor user choice of IPsec replay window size

Mikhail Khvainitski <me@khvoinitsky.org>
    HID: lenovo: Restrict detection of patched firmware only to USB cptkbd

David Howells <dhowells@redhat.com>
    afs: Fix refcount underflow from error handling race

Ard Biesheuvel <ardb@kernel.org>
    efi/x86: Avoid physical KASLR on older Dell systems

Zizhi Wo <wozizhi@huawei.com>
    ksmbd: fix memory leak in smb2_lock()

Jan Kara <jack@suse.cz>
    ext4: fix warning in ext4_dio_write_end_io()

Kelly Kane <kelly@hawknetworks.com>
    r8152: add vendor/device ID pair for ASUS USB-C2500


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/Makefile                                |   2 +-
 arch/arm64/include/asm/pgtable.h                   |   6 +
 arch/loongarch/Makefile                            |   2 +
 arch/loongarch/include/asm/asmmacro.h              |   3 +-
 arch/loongarch/include/asm/setup.h                 |   2 +-
 arch/loongarch/kernel/relocate.c                   |  10 +-
 arch/loongarch/kernel/time.c                       |  27 +--
 arch/loongarch/mm/pgtable.c                        |   4 +-
 arch/powerpc/configs/skiroot_defconfig             |   1 -
 arch/riscv/Kconfig                                 |   4 +-
 arch/riscv/kernel/crash_core.c                     |   4 +-
 arch/s390/configs/debug_defconfig                  |   1 -
 arch/x86/hyperv/hv_init.c                          |  25 ++-
 arch/x86/include/asm/alternative.h                 |   4 +-
 arch/x86/include/asm/nospec-branch.h               |   4 +-
 block/blk-cgroup.c                                 |  13 ++
 block/blk-throttle.c                               |   2 +
 drivers/accel/ivpu/ivpu_drv.h                      |   5 +
 drivers/accel/ivpu/ivpu_hw_37xx.c                  |  17 +-
 drivers/accel/ivpu/ivpu_hw_40xx.c                  |   4 +
 drivers/atm/solos-pci.c                            |   8 +-
 drivers/block/nbd.c                                | 117 ++++++----
 drivers/cxl/core/hdm.c                             |   3 +-
 drivers/cxl/core/port.c                            |   4 +-
 drivers/dma/fsl-edma-common.c                      |   1 +
 drivers/dma/stm32-dma.c                            |   8 +-
 drivers/firmware/efi/libstub/x86-stub.c            |  31 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  28 +++
 .../dc/link/protocols/link_edp_panel_control.c     |   4 +-
 .../drm/amd/display/modules/power/power_helpers.c  |   2 +
 drivers/gpu/drm/drm_edid.c                         |   3 +-
 drivers/gpu/drm/i915/display/intel_fb.c            |  19 +-
 drivers/gpu/drm/i915/display/skl_scaler.c          |   2 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |   5 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |  12 +-
 drivers/gpu/drm/i915/selftests/igt_live_test.c     |   9 +-
 drivers/gpu/drm/i915/selftests/igt_live_test.h     |   3 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  14 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   5 +-
 drivers/hid/hid-apple.c                            |   2 +
 drivers/hid/hid-asus.c                             |  27 ++-
 drivers/hid/hid-glorious.c                         |  16 +-
 drivers/hid/hid-ids.h                              |  12 +-
 drivers/hid/hid-lenovo.c                           |   3 +-
 drivers/hid/hid-mcp2221.c                          |   4 +-
 drivers/hid/hid-multitouch.c                       |   5 +
 drivers/hid/hid-quirks.c                           |   2 +
 drivers/hid/i2c-hid/i2c-hid-acpi.c                 |   5 +
 drivers/infiniband/hw/mlx5/main.c                  |  17 ++
 drivers/md/bcache/bcache.h                         |   1 +
 drivers/md/bcache/btree.c                          |   7 +
 drivers/md/bcache/super.c                          |   4 +-
 drivers/md/bcache/writeback.c                      |   2 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c      |   3 -
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  53 +++--
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  38 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |  11 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   5 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch-flower.c |   7 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  11 +-
 drivers/net/ethernet/freescale/fec_main.c          |  27 +--
 drivers/net/ethernet/intel/iavf/iavf.h             |   1 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  27 ++-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h        |  15 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 179 ++++++++++-----
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  71 +++++-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |   3 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |  11 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  55 ++++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  25 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |   6 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  56 +++--
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 222 +++++++++++++-----
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  27 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  25 ++-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 154 +------------
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |  15 --
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  35 +--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   2 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  56 +++--
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  29 +++
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   6 +
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |   1 +
 drivers/net/ethernet/qualcomm/qca_debug.c          |  17 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |  20 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  14 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  10 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   6 +-
 drivers/net/team/team.c                            |   4 +-
 drivers/net/usb/aqc111.c                           |   8 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/r8152.c                            |   1 +
 drivers/nfc/virtual_ncidev.c                       |   7 +-
 drivers/nvme/host/auth.c                           |   2 +
 drivers/nvme/host/core.c                           |  19 +-
 drivers/pci/controller/pci-loongson.c              |  46 +++-
 drivers/pci/controller/vmd.c                       |   2 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   9 +-
 drivers/pci/pcie/aspm.c                            |  53 +++--
 drivers/platform/x86/intel/telemetry/core.c        |   4 +-
 drivers/soundwire/stream.c                         |   7 +-
 fs/afs/rxrpc.c                                     |   2 +-
 fs/btrfs/delalloc-space.c                          |   2 +-
 fs/btrfs/extent_io.c                               |   3 +-
 fs/btrfs/file.c                                    |   2 +-
 fs/btrfs/inode.c                                   |  16 +-
 fs/btrfs/ioctl.c                                   |   9 +
 fs/btrfs/ordered-data.c                            |  11 +-
 fs/btrfs/qgroup.c                                  |  25 ++-
 fs/btrfs/qgroup.h                                  |   4 +-
 fs/ext4/file.c                                     |  14 +-
 fs/ext4/mballoc.c                                  |   4 +
 fs/fuse/dax.c                                      |   1 +
 fs/fuse/file.c                                     |   8 +-
 fs/fuse/fuse_i.h                                   |  19 +-
 fs/fuse/inode.c                                    |  81 ++++++-
 fs/nfsd/auth.c                                     |   4 -
 fs/nfsd/nfssvc.c                                   |   1 -
 fs/nfsd/vfs.c                                      |   9 +-
 fs/open.c                                          |   3 -
 fs/smb/client/cached_dir.c                         |  17 +-
 fs/smb/client/cifsglob.h                           |  14 +-
 fs/smb/client/cifspdu.h                            |   4 +-
 fs/smb/client/cifsproto.h                          |  11 +-
 fs/smb/client/cifssmb.c                            | 191 +++++++---------
 fs/smb/client/inode.c                              |  74 ++++--
 fs/smb/client/readdir.c                            |   6 +-
 fs/smb/client/smb1ops.c                            |  73 ++----
 fs/smb/client/smb2inode.c                          |   2 +-
 fs/smb/client/smb2misc.c                           |  26 +--
 fs/smb/client/smb2ops.c                            | 176 ++++++++-------
 fs/smb/client/smb2pdu.c                            |  95 ++++----
 fs/smb/client/smb2proto.h                          |  12 +-
 fs/smb/common/smb2pdu.h                            |   2 +-
 fs/smb/server/smb2pdu.c                            |   1 +
 fs/tracefs/inode.c                                 |  13 +-
 include/asm-generic/qspinlock.h                    |   2 +-
 include/linux/cred.h                               |  58 +----
 include/linux/mlx5/device.h                        |   2 +
 include/linux/mlx5/driver.h                        |   2 +
 include/linux/mlx5/mlx5_ifc.h                      |   9 +-
 include/linux/mm_inline.h                          |  23 +-
 include/linux/mmzone.h                             |  34 +--
 include/linux/objtool.h                            |  10 +-
 include/linux/pci.h                                |   3 +
 include/linux/usb/r8152.h                          |   1 +
 include/net/addrconf.h                             |  12 +-
 include/net/if_inet6.h                             |   4 -
 include/net/netfilter/nf_flow_table.h              |  10 +
 include/uapi/linux/fuse.h                          |  10 +-
 io_uring/uring_cmd.c                               |   2 +-
 kernel/Kconfig.kexec                               |   1 -
 kernel/cred.c                                      | 248 +++------------------
 kernel/events/core.c                               |  10 +
 kernel/exit.c                                      |   3 -
 kernel/trace/ring_buffer.c                         |  58 ++---
 kernel/trace/trace.c                               |   4 +-
 lib/Kconfig.debug                                  |  15 --
 mm/shmem.c                                         |  19 +-
 mm/vmscan.c                                        |  92 +++++---
 mm/workingset.c                                    |   6 +-
 net/appletalk/ddp.c                                |   9 +-
 net/atm/ioctl.c                                    |   7 +-
 net/ipv4/tcp_output.c                              |   6 +
 net/ipv6/addrconf.c                                |   6 +-
 net/rose/af_rose.c                                 |   4 +-
 net/rxrpc/conn_client.c                            |   7 +-
 net/sched/act_ct.c                                 |  34 ++-
 net/sunrpc/auth.c                                  |   3 -
 net/vmw_vsock/virtio_transport_common.c            |   2 +-
 scripts/checkstack.pl                              |   3 +-
 scripts/sign-file.c                                |  12 +-
 security/selinux/hooks.c                           |   6 -
 sound/pci/hda/patch_hdmi.c                         |   3 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/pci/hda/tas2781_hda_i2c.c                    |  21 +-
 tools/objtool/noreturns.h                          |   1 -
 tools/testing/selftests/Makefile                   |  21 +-
 tools/testing/selftests/bpf/config.x86_64          |   1 -
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c |  13 +-
 tools/testing/selftests/hid/config.common          |   1 -
 tools/testing/selftests/lib.mk                     |  40 +---
 tools/testing/selftests/mm/cow.c                   |   3 +-
 194 files changed, 2164 insertions(+), 1607 deletions(-)



