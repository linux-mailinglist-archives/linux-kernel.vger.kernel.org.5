Return-Path: <linux-kernel+bounces-19778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC3D8273A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2613C281227
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AE5102D;
	Mon,  8 Jan 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qQE31MYs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FC1E4A2;
	Mon,  8 Jan 2024 15:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D720C433AB;
	Mon,  8 Jan 2024 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728292;
	bh=PzVOp9ss4U20vcPIaxirITO3dC2ctLBgiQ6I6mojJ0E=;
	h=From:To:Cc:Subject:Date:From;
	b=qQE31MYsVAKTlyEzJVlPy7YGOjBc4BL/otNUopeQCNiXm8jPwCDTJi+sJI/RdTygA
	 ZiWRkl/fiICvTQqfipIWmYyeuEfd917nX6O1ryRAG1ehqXL3iLBAJgsCbH1Mx4hlNo
	 VRVTPxZ2aRiwWa24tabvsz+bbEPWy0nz76STaGXQ=
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
Subject: [PATCH 6.1 000/150] 6.1.72-rc1 review
Date: Mon,  8 Jan 2024 16:34:11 +0100
Message-ID: <20240108153511.214254205@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.72-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.72-rc1
X-KernelTest-Deadline: 2024-01-10T15:35+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.72 release.
There are 150 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 10 Jan 2024 15:34:37 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.72-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.72-rc1

Amit Pundir <amit.pundir@linaro.org>
    Revert "interconnect: qcom: sm8250: Enable sync_state"

Kees Cook <keescook@chromium.org>
    smb3: Replace smb2pdu 1-element arrays with flex-arrays

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Comment CSID dt_id field

John Fastabend <john.fastabend@gmail.com>
    bpf: syzkaller found null ptr deref in unix_bpf proto add

Yonghong Song <yonghong.song@linux.dev>
    bpf: Fix a verifier bug due to incorrect branch offset comparison with cpu=v4

Vlad Buslov <vladbu@nvidia.com>
    net/sched: act_ct: Always fill offloading tuple iifidx

Vlad Buslov <vladbu@nvidia.com>
    net/sched: act_ct: additional checks for outdated flows

Chao Yu <chao@kernel.org>
    f2fs: compress: fix to assign compress_level for lz4 correctly

Ingo Molnar <mingo@kernel.org>
    genirq/affinity: Only build SMP-only helper functions on SMP kernels

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Geert Uytterhoeven <geert+renesas@glider.be>
    mmc: core: Cancel delayed work before releasing host

Jorge Ramirez-Ortiz <jorge@foundries.io>
    mmc: rpmb: fixes pause retune on all RPMB partitions.

Ziyang Huang <hzyitc@outlook.com>
    mmc: meson-mx-sdhc: Fix initialization frozen issue

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/display: add nv12 bounding box

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: skip gpu_info fw loading on navi12

Jiajun Xie <jiajun.xie.sh@gmail.com>
    mm: fix unmap_mapping_range high bits shift bug

Benjamin Bara <benjamin.bara@skidata.com>
    i2c: core: Fix atomic xfer check for non-preempt config

Jinghao Jia <jinghao7@illinois.edu>
    x86/kprobes: fix incorrect return address calculation in kprobe_emulate_call_indirect

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()

Christoph Hellwig <hch@lst.de>
    btrfs: mark the len field in struct btrfs_ordered_sum as unsigned

Boris Burkov <boris@bur.io>
    btrfs: fix qgroup_free_reserved_data int overflow

Rakesh Babu Saladi <rsaladi2@marvell.com>
    octeontx2-af: Support variable number of lmacs

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Fix pause frame configuration

Vlad Buslov <vladbu@nvidia.com>
    net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: GC pushes back packets to classic path

Paul Blakey <paulb@nvidia.com>
    net/sched: act_ct: Fix promotion of offloaded unreplied tuple

Vlad Buslov <vladbu@nvidia.com>
    net/sched: act_ct: offload UDP NEW connections

Vlad Buslov <vladbu@nvidia.com>
    netfilter: flowtable: cache info of last offload

Vlad Buslov <vladbu@nvidia.com>
    netfilter: flowtable: allow unidirectional rules

Xin Long <lucien.xin@gmail.com>
    net: sched: call tcf_ct_params_free to free params in tcf_ct_init

Sumanth Korikkar <sumanthk@linux.ibm.com>
    mm/memory_hotplug: fix error handling in add_memory_resource()

Sumanth Korikkar <sumanthk@linux.ibm.com>
    mm/memory_hotplug: add missing mem_hotplug_lock

Ming Lei <ming.lei@redhat.com>
    lib/group_cpus.c: avoid acquiring cpu hotplug lock in group_cpus_evenly

Ming Lei <ming.lei@redhat.com>
    genirq/affinity: Move group_cpus_evenly() into lib/

Ming Lei <ming.lei@redhat.com>
    genirq/affinity: Rename irq_build_affinity_masks as group_cpus_evenly

Ming Lei <ming.lei@redhat.com>
    genirq/affinity: Don't pass irq_affinity_desc array to irq_build_affinity_masks

Ming Lei <ming.lei@redhat.com>
    genirq/affinity: Pass affinity managed mask array to irq_build_affinity_masks

Ming Lei <ming.lei@redhat.com>
    genirq/affinity: Remove the 'firstvec' parameter from irq_build_affinity_masks

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_scmi: Fix frequency truncation by promoting multiplier type

John Fastabend <john.fastabend@gmail.com>
    bpf, sockmap: af_unix stream sockets need to hold ref for pair sock

Jakub Kicinski <kuba@kernel.org>
    ethtool: don't propagate EOPNOTSUPP from dumps

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-eth: recycle the RX buffer only after all processing done

Ioana Ciornei <ioana.ciornei@nxp.com>
    net: dpaa2-eth: rearrange variable in dpaa2_eth_get_ethtool_stats

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix missing mode bits for SMB symlinks

Christoph Hellwig <hch@lst.de>
    block: update the stable_writes flag in bdev_add

Christoph Hellwig <hch@lst.de>
    filemap: add a per-mapping stable writes flag

David Howells <dhowells@redhat.com>
    mm, netfs, fscache: stop read optimisation when folio removed from pagecache

David Howells <dhowells@redhat.com>
    mm: merge folio_has_private()/filemap_release_folio() call pairs

Vishal Moola (Oracle) <vishal.moola@gmail.com>
    memory-failure: convert truncate_error_page() to use folio

Vishal Moola (Oracle) <vishal.moola@gmail.com>
    khugepage: replace try_to_release_page() with filemap_release_folio()

Vishal Moola (Oracle) <vishal.moola@gmail.com>
    ext4: convert move_extent_per_page() to use folios

Bryan O'Donoghue <bryan.odonoghue@linaro.org>
    media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater than 3

Milen Mitkov <quic_mmitkov@quicinc.com>
    media: camss: sm8250: Virtual channels for CSID

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: set FAILING_LINKS in run_tests

Paolo Abeni <pabeni@redhat.com>
    selftests: mptcp: fix fastclose with csum failure

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: set the default compress_level on ioctl

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: assign default compression level

Yangtao Li <frank.li@vivo.com>
    f2fs: convert to use bitmap API

Chao Yu <chao@kernel.org>
    f2fs: clean up i_compress_flag and i_compress_level usage

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpumf: support user space events for counting

Heiko Carstens <hca@linux.ibm.com>
    s390/mm: add missing arch_set_page_dat() call to vmem_crst_alloc()

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5: Increase size of irq name buffer

Christoph Hellwig <hch@infradead.org>
    blk-mq: make sure active queue usage is held for bio_integrity_prep()

Andrii Nakryiko <andrii@kernel.org>
    bpf: fix precision backtracking instruction iteration

Andrii Nakryiko <andrii@kernel.org>
    bpf: handle ldimm64 properly in check_cfg()

Yonghong Song <yonghong.song@linux.dev>
    bpf: Support new 32bit offset jmp instruction

Andrii Nakryiko <andrii@kernel.org>
    bpf: clean up visit_insn()'s instruction processing

Andrii Nakryiko <andrii@kernel.org>
    bpf: Remove unused insn_cnt argument from visit_[func_call_]insn()

Andrii Nakryiko <andrii@kernel.org>
    bpf: remove unnecessary prune and jump points

Andrii Nakryiko <andrii@kernel.org>
    bpf: decouple prune and jump points

Dan Carpenter <dan.carpenter@linaro.org>
    fbdev: imsttfb: fix double free in probe()

Helge Deller <deller@gmx.de>
    fbdev: imsttfb: Release framebuffer and dealloc cmap on error path

David Heidelberg <david@ixit.cz>
    arm64: dts: qcom: sdm845: Fix PSCI power domain names

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm845: align RPMh regulator nodes with bindings

Rotem Saado <rotem.saado@intel.com>
    wifi: iwlwifi: yoyo: swap cdb and jacket bits values

Eric Dumazet <edumazet@google.com>
    udp: annotate data-races around udp->encap_type

Eric Dumazet <edumazet@google.com>
    udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO

Eric Dumazet <edumazet@google.com>
    udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags

Eric Dumazet <edumazet@google.com>
    udp: move udp->gro_enabled to udp->udp_flags

Eric Dumazet <edumazet@google.com>
    udp: move udp->no_check6_rx to udp->udp_flags

Eric Dumazet <edumazet@google.com>
    udp: move udp->no_check6_tx to udp->udp_flags

Eric Dumazet <edumazet@google.com>
    udp: introduce udp->udp_flags

David Howells <dhowells@redhat.com>
    ipv4, ipv6: Use splice_eof() to flush

David Howells <dhowells@redhat.com>
    splice, net: Add a splice_eof op to file-ops and socket-ops

David Howells <dhowells@redhat.com>
    udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES

David Howells <dhowells@redhat.com>
    net: Declare MSG_SPLICE_PAGES internal sendmsg() flag

Menglong Dong <imagedong@tencent.com>
    bpf, x86: save/restore regs with BPF_DW size

Pu Lehui <pulehui@huawei.com>
    bpf, x86: Simplify the parsing logic of structure parameters

Leon Hwang <hffilwlqm@gmail.com>
    bpf, x64: Fix tailcall infinite loop

Frederic Weisbecker <frederic@kernel.org>
    srcu: Fix callbacks acceleration mishandling

Thomas Gleixner <tglx@linutronix.de>
    cpu/SMT: Make SMT control more robust against enumeration failures

Michael Ellerman <mpe@ellerman.id.au>
    cpu/SMT: Create topology_smt_thread_allowed()

Muhammad Usama Anjum <usama.anjum@collabora.com>
    selftests: secretmem: floor the memory size to the multiple of page_size

Thomas Lange <thomas@corelatus.se>
    net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    net: ravb: Wait for operating mode to be applied

Chen Ni <nichen@iscas.ac.cn>
    asix: Add check for usbnet_get_endpoints

Naveen Mamindlapalli <naveenm@marvell.com>
    octeontx2-af: Re-enable MAC TX in otx2_stop processing

Naveen Mamindlapalli <naveenm@marvell.com>
    octeontx2-af: Always configure NIX TX link credits based on max frame size

Wen Gu <guwen@linux.alibaba.com>
    net/smc: fix invalid link access in dumping SMC-R connections

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
    igc: Fix hicredit calculation

Andrii Staikov <andrii.staikov@intel.com>
    i40e: Restore VF MSI-X state during PCI reset

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-toacodec: Fix event generation

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-tohdmitx: Validate written enum values

Mark Brown <broonie@kernel.org>
    ASoC: meson: g12a-toacodec: Validate written enum values

Ke Xiao <xiaoke@sangfor.com.cn>
    i40e: fix use-after-free in i40e_aqc_add_filters()

Marc Dionne <marc.dionne@auristor.com>
    net: Save and restore msg_namelen in sock_sendmsg

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_immediate: drop chain reference counter on error

Adrian Cinal <adriancinal@gmail.com>
    net: bcmgenet: Fix FCS generation for fragmented skbuffs

Zhipeng Lu <alexious@zju.edu.cn>
    sfc: fix a double-free bug in efx_probe_filters

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Hangbin Liu <liuhangbin@gmail.com>
    selftests: bonding: do not set port down when adding to bond

Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
    net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_bind_phc

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_tsflags

Vadim Fedorenko <vadfed@meta.com>
    net-timestamp: extend SOF_TIMESTAMPING_OPT_ID to HW timestamps

Marc Kleine-Budde <mkl@pengutronix.de>
    can: raw: add support for SO_MARK

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Fix PCI error on system resume

Hangyu Hua <hbh25y@gmail.com>
    net: sched: em_text: fix possible memory leak in em_text_destroy()

David Thompson <davthompson@nvidia.com>
    mlxbf_gige: fix receive packet race condition

Eugen Hristev <eugen.hristev@collabora.com>
    ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and offset

Chancel Liu <chancel.liu@nxp.com>
    ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Check VLAN EtherType mask

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Check VLAN TCI mask

Kurt Kanzenbach <kurt@linutronix.de>
    igc: Report VLAN EtherType matching back to user

Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
    i40e: Fix filter input checks to prevent config with invalid values

Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
    ice: Shut down VSI with "link-down-on-close" enabled

Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
    ice: Fix link_down_on_close message

Khaled Almahallawy <khaled.almahallawy@intel.com>
    drm/i915/dp: Fix passing the correct DPCD_REV for drm_dp_set_phy_test_pattern

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Fix marking couple of structure as __packed

Siddh Raman Pant <code@siddh.me>
    nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: set transport offset from mac header for netdev/egress

Xin Long <lucien.xin@gmail.com>
    netfilter: use skb_ip_totlen and iph_totlen

Douglas Anderson <dianders@chromium.org>
    drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86/pmu: fix masking logic for MSR_CORE_PERF_GLOBAL_CTRL

Shyam Prasad N <sprasad@microsoft.com>
    cifs: do not depend on release_iface for maintaining iface_list

Shyam Prasad N <sprasad@microsoft.com>
    cifs: cifs_chan_is_iface_active should be called with chan_lock held

Jocelyn Falempe <jfalempe@redhat.com>
    drm/mgag200: Fix gamma lut not initialized for G200ER, G200EV, G200SE

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"

Paolo Abeni <pabeni@redhat.com>
    mptcp: prevent tcp diag from closing listener subflows

Siddhesh Dharme <siddheshdharme18@gmail.com>
    ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6

Andy Chi <andy.chi@canonical.com>
    ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook

Aabish Malik <aabishmalik3337@gmail.com>
    ALSA: hda/realtek: enable SND_PCI_QUIRK for hp pavilion 14-ec1xxx series

Sarthak Kukreti <sarthakkukreti@chromium.org>
    block: Don't invalidate pagecache for invalid falloc modes

Edward Adam Davis <eadavis@qq.com>
    keys, dns: Fix missing size check of V1 server-list header


-------------

Diffstat:

 MAINTAINERS                                        |   2 +
 Makefile                                           |   4 +-
 arch/Kconfig                                       |   3 +
 arch/arm/mach-sunxi/mc_smp.c                       |   4 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |  24 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   4 +-
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi     |   6 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |   6 +-
 .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi |   6 +-
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |   6 +-
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts      |   2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   6 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |   2 +-
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts   |   2 +-
 arch/s390/kernel/perf_cpum_cf.c                    |  35 +-
 arch/s390/mm/vmem.c                                |   8 +-
 arch/x86/events/intel/core.c                       |   7 +-
 arch/x86/kernel/kprobes/core.c                     |   3 +-
 arch/x86/net/bpf_jit_comp.c                        | 150 ++++---
 block/bdev.c                                       |   2 +
 block/blk-mq.c                                     |  75 ++--
 block/fops.c                                       |  21 +-
 drivers/base/memory.c                              |  18 +-
 drivers/firewire/ohci.c                            |  51 +++
 drivers/firmware/arm_scmi/perf.c                   |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  11 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   | 110 +++++-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   4 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |   5 +
 drivers/gpu/drm/mgag200/mgag200_g200er.c           |   5 +
 drivers/gpu/drm/mgag200/mgag200_g200ev.c           |   5 +
 drivers/gpu/drm/mgag200/mgag200_g200se.c           |   5 +
 drivers/gpu/drm/mgag200/mgag200_mode.c             |  10 +-
 drivers/i2c/i2c-core.h                             |   4 +-
 drivers/interconnect/qcom/sm8250.c                 |   1 -
 .../media/platform/qcom/camss/camss-csid-gen2.c    |  68 +++-
 drivers/media/platform/qcom/camss/camss-csid.c     |  44 ++-
 drivers/media/platform/qcom/camss/camss-csid.h     |  11 +-
 drivers/mmc/core/block.c                           |   7 +-
 drivers/mmc/core/host.c                            |   1 +
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |  26 +-
 drivers/mmc/host/sdhci-sprd.c                      |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   7 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   |  18 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  34 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  12 +-
 drivers/net/ethernet/intel/igc/igc.h               |   1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  42 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |  35 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |   6 +-
 .../ethernet/marvell/octeontx2/af/lmac_common.h    |   5 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |   4 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |  11 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   3 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  43 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    | 120 +-----
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h  |   3 +
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |   9 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   2 +
 drivers/net/ethernet/realtek/r8169_main.c          |   2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  65 +--
 drivers/net/ethernet/sfc/rx_common.c               |   4 +-
 drivers/net/gtp.c                                  |   4 +-
 drivers/net/usb/ax88172a.c                         |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  17 +-
 drivers/pci/pci.c                                  |   6 +
 drivers/pci/pci.h                                  |   2 +
 drivers/pci/pcie/aspm.c                            |  19 +
 drivers/video/fbdev/imsttfb.c                      |   6 +-
 fs/9p/cache.c                                      |   2 +
 fs/afs/internal.h                                  |   2 +
 fs/btrfs/delalloc-space.c                          |   2 +-
 fs/btrfs/file-item.c                               |   2 +-
 fs/btrfs/file.c                                    |   2 +-
 fs/btrfs/inode.c                                   |  16 +-
 fs/btrfs/ordered-data.c                            |   7 +-
 fs/btrfs/ordered-data.h                            |   2 +-
 fs/btrfs/qgroup.c                                  |  25 +-
 fs/btrfs/qgroup.h                                  |   4 +-
 fs/cachefiles/namei.c                              |   2 +
 fs/ceph/cache.c                                    |   2 +
 fs/ext4/move_extent.c                              |  48 ++-
 fs/f2fs/checkpoint.c                               |   2 +-
 fs/f2fs/compress.c                                 |  15 +-
 fs/f2fs/data.c                                     |  12 +-
 fs/f2fs/dir.c                                      |   2 +-
 fs/f2fs/f2fs.h                                     |  35 +-
 fs/f2fs/file.c                                     |  11 +-
 fs/f2fs/inode.c                                    |  18 +-
 fs/f2fs/node.h                                     |  20 +-
 fs/f2fs/super.c                                    |  26 +-
 fs/f2fs/sysfs.c                                    |   2 +-
 fs/inode.c                                         |   2 +
 fs/nfs/fscache.c                                   |   3 +
 fs/smb/client/cifsglob.h                           |   1 -
 fs/smb/client/connect.c                            |   9 +-
 fs/smb/client/fscache.c                            |   2 +
 fs/smb/client/inode.c                              |   2 +-
 fs/smb/client/smb2file.c                           |   2 +-
 fs/smb/client/smb2misc.c                           |   2 +-
 fs/smb/client/smb2ops.c                            |  48 ++-
 fs/smb/client/smb2pdu.c                            |  16 +-
 fs/smb/client/smb2pdu.h                            |   2 +-
 fs/smb/common/smb2pdu.h                            |  42 +-
 fs/smb/server/smb2ops.c                            |   8 +-
 fs/smb/server/smb2pdu.c                            |   5 +-
 fs/splice.c                                        |  34 +-
 include/linux/bpf.h                                |  13 +-
 include/linux/bpf_verifier.h                       |   1 +
 include/linux/f2fs_fs.h                            |   9 +-
 include/linux/fs.h                                 |   1 +
 include/linux/group_cpus.h                         |  14 +
 include/linux/net.h                                |   1 +
 include/linux/pagemap.h                            |  33 ++
 include/linux/skmsg.h                              |   1 +
 include/linux/socket.h                             |   3 +
 include/linux/splice.h                             |   1 +
 include/linux/udp.h                                |  69 ++--
 include/net/af_unix.h                              |   1 +
 include/net/inet_common.h                          |   1 +
 include/net/ip.h                                   |   2 +-
 include/net/netfilter/nf_conntrack_act_ct.h        |  34 +-
 include/net/netfilter/nf_flow_table.h              |  21 +-
 include/net/netfilter/nf_tables_ipv4.h             |   6 +-
 include/net/sock.h                                 |  23 +-
 include/net/tcp.h                                  |   1 +
 include/net/udp.h                                  |   1 +
 include/net/udp_tunnel.h                           |   9 +-
 io_uring/net.c                                     |   2 +
 kernel/bpf/core.c                                  |  25 +-
 kernel/bpf/trampoline.c                            |   4 +-
 kernel/bpf/verifier.c                              | 162 +++++---
 kernel/cpu.c                                       |  42 +-
 kernel/irq/affinity.c                              | 405 +------------------
 kernel/rcu/srcutree.c                              |  31 +-
 kernel/trace/ring_buffer.c                         |   4 +-
 lib/Makefile                                       |   2 +
 lib/group_cpus.c                                   | 438 +++++++++++++++++++++
 mm/filemap.c                                       |   2 +
 mm/huge_memory.c                                   |   3 +-
 mm/internal.h                                      |  11 +
 mm/khugepaged.c                                    |  22 +-
 mm/memory-failure.c                                |   9 +-
 mm/memory.c                                        |   4 +-
 mm/memory_hotplug.c                                |  15 +-
 mm/migrate.c                                       |   3 +-
 mm/page-writeback.c                                |   2 +-
 mm/truncate.c                                      |   6 +-
 mm/vmscan.c                                        |   8 +-
 net/can/j1939/socket.c                             |  10 +-
 net/can/raw.c                                      |   1 +
 net/core/skbuff.c                                  |  10 +-
 net/core/skmsg.c                                   |   2 +
 net/core/sock.c                                    |  16 +-
 net/core/sock_map.c                                |   2 +
 net/dns_resolver/dns_key.c                         |  19 +-
 net/ethtool/netlink.c                              |   2 +-
 net/ipv4/af_inet.c                                 |  18 +
 net/ipv4/ip_output.c                               |   4 +-
 net/ipv4/ip_sockglue.c                             |   2 +-
 net/ipv4/tcp.c                                     |  20 +-
 net/ipv4/tcp_ipv4.c                                |   1 +
 net/ipv4/udp.c                                     | 110 ++----
 net/ipv4/udp_offload.c                             |   4 +-
 net/ipv4/udp_tunnel_core.c                         |   2 +-
 net/ipv4/xfrm4_input.c                             |   4 +-
 net/ipv6/af_inet6.c                                |   1 +
 net/ipv6/ip6_output.c                              |   4 +-
 net/ipv6/ping.c                                    |   2 +-
 net/ipv6/raw.c                                     |   2 +-
 net/ipv6/tcp_ipv6.c                                |   1 +
 net/ipv6/udp.c                                     |  38 +-
 net/ipv6/xfrm6_input.c                             |   4 +-
 net/l2tp/l2tp_core.c                               |   6 +-
 net/mptcp/subflow.c                                |  13 +
 net/netfilter/ipvs/ip_vs_xmit.c                    |   2 +-
 net/netfilter/nf_flow_table_core.c                 |  13 +-
 net/netfilter/nf_flow_table_inet.c                 |   2 +-
 net/netfilter/nf_flow_table_ip.c                   |   4 +-
 net/netfilter/nf_flow_table_offload.c              |  18 +-
 net/netfilter/nf_log_syslog.c                      |   2 +-
 net/netfilter/nf_tables_core.c                     |   2 +-
 net/netfilter/nft_immediate.c                      |   2 +-
 net/netfilter/xt_length.c                          |   2 +-
 net/nfc/llcp_core.c                                |  39 +-
 net/openvswitch/conntrack.c                        |   2 +-
 net/sched/act_ct.c                                 | 165 ++++++--
 net/sched/em_text.c                                |   4 +-
 net/smc/smc_diag.c                                 |   3 +-
 net/socket.c                                       |  29 +-
 net/unix/af_unix.c                                 |   2 -
 net/unix/unix_bpf.c                                |   5 +
 sound/pci/hda/patch_realtek.c                      |   4 +
 sound/soc/fsl/fsl_rpmsg.c                          |  10 +-
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c        |   2 +-
 sound/soc/meson/g12a-toacodec.c                    |   5 +-
 sound/soc/meson/g12a-tohdmitx.c                    |   8 +-
 tools/testing/selftests/bpf/verifier/ld_imm64.c    |   8 +-
 .../net/bonding/bond-arp-interval-causes-panic.sh  |   6 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  14 +-
 tools/testing/selftests/vm/memfd_secret.c          |   3 +
 214 files changed, 2405 insertions(+), 1455 deletions(-)



