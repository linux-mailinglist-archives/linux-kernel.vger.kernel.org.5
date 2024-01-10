Return-Path: <linux-kernel+bounces-22555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C432829F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0750828C461
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE04D100;
	Wed, 10 Jan 2024 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xoWC40LX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCA4CDE3;
	Wed, 10 Jan 2024 17:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432BBC433C7;
	Wed, 10 Jan 2024 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704908816;
	bh=tp3AfIulEWai6gwWHaUqrjJGGIsa3EuYMV9Bjb9IedY=;
	h=From:To:Cc:Subject:Date:From;
	b=xoWC40LXhT8RG6eRx08e65va+CnNGp6uckeYYL93H8whRvenFAWROED+C0VgWldLO
	 gQLdbhujCfDoKsyHYlmVxfyEDHWppr0ohS0dbfS1lyOHFceGFkcuRUlrVft1ScR55f
	 wroyk3zIyFaVGTXkDudF8Ijugxpjt6efNSVxB1Nk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.72
Date: Wed, 10 Jan 2024 18:46:51 +0100
Message-ID: <2024011052-unsightly-bronze-e628@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.72 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 MAINTAINERS                                                                   |    2 
 Makefile                                                                      |    2 
 arch/Kconfig                                                                  |    3 
 arch/arm/mach-sunxi/mc_smp.c                                                  |    4 
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                                    |   24 
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                                    |    4 
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi                                |    6 
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                                       |    6 
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi                           |    6 
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts                             |    6 
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi                         |    6 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts                          |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts                            |    6 
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts                          |    2 
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts                              |    2 
 arch/s390/kernel/perf_cpum_cf.c                                               |   35 
 arch/s390/mm/vmem.c                                                           |    8 
 arch/x86/events/intel/core.c                                                  |    7 
 arch/x86/kernel/kprobes/core.c                                                |    3 
 arch/x86/net/bpf_jit_comp.c                                                   |  150 +--
 block/bdev.c                                                                  |    2 
 block/blk-mq.c                                                                |   75 -
 block/fops.c                                                                  |   21 
 drivers/base/memory.c                                                         |   18 
 drivers/firewire/ohci.c                                                       |   51 +
 drivers/firmware/arm_scmi/perf.c                                              |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                    |   11 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                          |  110 ++
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                                         |    4 
 drivers/gpu/drm/i915/display/intel_dp.c                                       |    2 
 drivers/gpu/drm/mgag200/mgag200_drv.h                                         |    5 
 drivers/gpu/drm/mgag200/mgag200_g200er.c                                      |    5 
 drivers/gpu/drm/mgag200/mgag200_g200ev.c                                      |    5 
 drivers/gpu/drm/mgag200/mgag200_g200se.c                                      |    5 
 drivers/gpu/drm/mgag200/mgag200_mode.c                                        |   10 
 drivers/i2c/i2c-core.h                                                        |    4 
 drivers/interconnect/qcom/sm8250.c                                            |    1 
 drivers/media/platform/qcom/camss/camss-csid-gen2.c                           |   68 +
 drivers/media/platform/qcom/camss/camss-csid.c                                |   44 -
 drivers/media/platform/qcom/camss/camss-csid.h                                |   11 
 drivers/mmc/core/block.c                                                      |    7 
 drivers/mmc/core/host.c                                                       |    1 
 drivers/mmc/host/meson-mx-sdhc-mmc.c                                          |   26 
 drivers/mmc/host/sdhci-sprd.c                                                 |   10 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                     |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                                |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                              |    7 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c                          |   18 
 drivers/net/ethernet/intel/i40e/i40e_main.c                                   |   11 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                            |   34 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                            |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                                     |   12 
 drivers/net/ethernet/intel/igc/igc.h                                          |    1 
 drivers/net/ethernet/intel/igc/igc_ethtool.c                                  |   42 
 drivers/net/ethernet/intel/igc/igc_tsn.c                                      |    2 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                               |   35 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h                               |    6 
 drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h                       |    5 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h                               |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c                               |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                               |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                           |   43 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c                       |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                           |  120 --
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c                      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                             |    6 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h                             |    3 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c                      |    9 
 drivers/net/ethernet/qlogic/qla3xxx.c                                         |    2 
 drivers/net/ethernet/realtek/r8169_main.c                                     |    2 
 drivers/net/ethernet/renesas/ravb_main.c                                      |   65 -
 drivers/net/ethernet/sfc/rx_common.c                                          |    4 
 drivers/net/gtp.c                                                             |    4 
 drivers/net/usb/ax88172a.c                                                    |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h                                 |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h                            |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                                  |    8 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                               |   17 
 drivers/pci/pci.c                                                             |    6 
 drivers/pci/pci.h                                                             |    2 
 drivers/pci/pcie/aspm.c                                                       |   19 
 drivers/video/fbdev/imsttfb.c                                                 |    6 
 fs/9p/cache.c                                                                 |    2 
 fs/afs/internal.h                                                             |    2 
 fs/btrfs/delalloc-space.c                                                     |    2 
 fs/btrfs/file-item.c                                                          |    2 
 fs/btrfs/file.c                                                               |    2 
 fs/btrfs/inode.c                                                              |   16 
 fs/btrfs/ordered-data.c                                                       |    7 
 fs/btrfs/ordered-data.h                                                       |    2 
 fs/btrfs/qgroup.c                                                             |   25 
 fs/btrfs/qgroup.h                                                             |    4 
 fs/cachefiles/namei.c                                                         |    2 
 fs/ceph/cache.c                                                               |    2 
 fs/ext4/move_extent.c                                                         |   48 -
 fs/f2fs/checkpoint.c                                                          |    2 
 fs/f2fs/compress.c                                                            |   15 
 fs/f2fs/data.c                                                                |   12 
 fs/f2fs/dir.c                                                                 |    2 
 fs/f2fs/f2fs.h                                                                |   35 
 fs/f2fs/file.c                                                                |   11 
 fs/f2fs/inode.c                                                               |   18 
 fs/f2fs/node.h                                                                |   20 
 fs/f2fs/super.c                                                               |   26 
 fs/f2fs/sysfs.c                                                               |    2 
 fs/inode.c                                                                    |    2 
 fs/nfs/fscache.c                                                              |    3 
 fs/smb/client/cifsglob.h                                                      |    1 
 fs/smb/client/connect.c                                                       |    7 
 fs/smb/client/fscache.c                                                       |    2 
 fs/smb/client/inode.c                                                         |    2 
 fs/smb/client/smb2file.c                                                      |    2 
 fs/smb/client/smb2misc.c                                                      |    2 
 fs/smb/client/smb2ops.c                                                       |   48 -
 fs/smb/client/smb2pdu.c                                                       |   16 
 fs/smb/client/smb2pdu.h                                                       |    2 
 fs/smb/common/smb2pdu.h                                                       |   42 
 fs/smb/server/smb2ops.c                                                       |    8 
 fs/smb/server/smb2pdu.c                                                       |    8 
 fs/splice.c                                                                   |   34 
 include/linux/bpf.h                                                           |   13 
 include/linux/bpf_verifier.h                                                  |    1 
 include/linux/f2fs_fs.h                                                       |    9 
 include/linux/fs.h                                                            |    1 
 include/linux/group_cpus.h                                                    |   14 
 include/linux/net.h                                                           |    1 
 include/linux/pagemap.h                                                       |   33 
 include/linux/skmsg.h                                                         |    1 
 include/linux/socket.h                                                        |    3 
 include/linux/splice.h                                                        |    1 
 include/linux/udp.h                                                           |   69 -
 include/net/af_unix.h                                                         |    1 
 include/net/inet_common.h                                                     |    1 
 include/net/ip.h                                                              |    2 
 include/net/netfilter/nf_conntrack_act_ct.h                                   |   30 
 include/net/netfilter/nf_flow_table.h                                         |   21 
 include/net/netfilter/nf_tables_ipv4.h                                        |    6 
 include/net/sock.h                                                            |   23 
 include/net/tcp.h                                                             |    1 
 include/net/udp.h                                                             |    1 
 include/net/udp_tunnel.h                                                      |    9 
 io_uring/net.c                                                                |    2 
 kernel/bpf/core.c                                                             |   25 
 kernel/bpf/trampoline.c                                                       |    4 
 kernel/bpf/verifier.c                                                         |  162 ++-
 kernel/cpu.c                                                                  |   42 
 kernel/irq/affinity.c                                                         |  405 ---------
 kernel/rcu/srcutree.c                                                         |   31 
 kernel/trace/ring_buffer.c                                                    |    4 
 lib/Makefile                                                                  |    2 
 lib/group_cpus.c                                                              |  438 ++++++++++
 mm/filemap.c                                                                  |    2 
 mm/huge_memory.c                                                              |    3 
 mm/internal.h                                                                 |   11 
 mm/khugepaged.c                                                               |   22 
 mm/memory-failure.c                                                           |    9 
 mm/memory.c                                                                   |    4 
 mm/memory_hotplug.c                                                           |   15 
 mm/migrate.c                                                                  |    3 
 mm/page-writeback.c                                                           |    2 
 mm/truncate.c                                                                 |    6 
 mm/vmscan.c                                                                   |    8 
 net/can/j1939/socket.c                                                        |   10 
 net/can/raw.c                                                                 |    1 
 net/core/skbuff.c                                                             |   10 
 net/core/skmsg.c                                                              |    2 
 net/core/sock.c                                                               |   16 
 net/core/sock_map.c                                                           |    2 
 net/dns_resolver/dns_key.c                                                    |   19 
 net/ethtool/netlink.c                                                         |    2 
 net/ipv4/af_inet.c                                                            |   18 
 net/ipv4/ip_output.c                                                          |    4 
 net/ipv4/ip_sockglue.c                                                        |    2 
 net/ipv4/tcp.c                                                                |   20 
 net/ipv4/tcp_ipv4.c                                                           |    1 
 net/ipv4/udp.c                                                                |  106 --
 net/ipv4/udp_offload.c                                                        |    4 
 net/ipv4/udp_tunnel_core.c                                                    |    2 
 net/ipv4/xfrm4_input.c                                                        |    4 
 net/ipv6/af_inet6.c                                                           |    1 
 net/ipv6/ip6_output.c                                                         |    4 
 net/ipv6/ping.c                                                               |    2 
 net/ipv6/raw.c                                                                |    2 
 net/ipv6/tcp_ipv6.c                                                           |    1 
 net/ipv6/udp.c                                                                |   38 
 net/ipv6/xfrm6_input.c                                                        |    4 
 net/l2tp/l2tp_core.c                                                          |    6 
 net/mptcp/subflow.c                                                           |   13 
 net/netfilter/ipvs/ip_vs_xmit.c                                               |    2 
 net/netfilter/nf_flow_table_core.c                                            |   13 
 net/netfilter/nf_flow_table_inet.c                                            |    2 
 net/netfilter/nf_flow_table_ip.c                                              |    4 
 net/netfilter/nf_flow_table_offload.c                                         |   18 
 net/netfilter/nf_log_syslog.c                                                 |    2 
 net/netfilter/nf_tables_core.c                                                |    2 
 net/netfilter/nft_immediate.c                                                 |    2 
 net/netfilter/xt_length.c                                                     |    2 
 net/nfc/llcp_core.c                                                           |   39 
 net/openvswitch/conntrack.c                                                   |    2 
 net/sched/act_ct.c                                                            |  165 ++-
 net/sched/em_text.c                                                           |    4 
 net/smc/smc_diag.c                                                            |    3 
 net/socket.c                                                                  |   29 
 net/unix/af_unix.c                                                            |    2 
 net/unix/unix_bpf.c                                                           |    5 
 sound/pci/hda/patch_realtek.c                                                 |    4 
 sound/soc/fsl/fsl_rpmsg.c                                                     |   10 
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c                                   |    2 
 sound/soc/meson/g12a-toacodec.c                                               |    5 
 sound/soc/meson/g12a-tohdmitx.c                                               |    8 
 tools/testing/selftests/bpf/verifier/ld_imm64.c                               |    8 
 tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh |    6 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                               |   14 
 tools/testing/selftests/vm/memfd_secret.c                                     |    3 
 214 files changed, 2400 insertions(+), 1451 deletions(-)

Aabish Malik (1):
      ALSA: hda/realtek: enable SND_PCI_QUIRK for hp pavilion 14-ec1xxx series

Adrian Cinal (1):
      net: bcmgenet: Fix FCS generation for fragmented skbuffs

Alex Deucher (2):
      drm/amdgpu: skip gpu_info fw loading on navi12
      drm/amd/display: add nv12 bounding box

Amit Pundir (1):
      Revert "interconnect: qcom: sm8250: Enable sync_state"

Andrii Nakryiko (6):
      bpf: decouple prune and jump points
      bpf: remove unnecessary prune and jump points
      bpf: Remove unused insn_cnt argument from visit_[func_call_]insn()
      bpf: clean up visit_insn()'s instruction processing
      bpf: handle ldimm64 properly in check_cfg()
      bpf: fix precision backtracking instruction iteration

Andrii Staikov (1):
      i40e: Restore VF MSI-X state during PCI reset

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook

Benjamin Bara (1):
      i2c: core: Fix atomic xfer check for non-preempt config

Bjorn Helgaas (1):
      Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"

Boris Burkov (1):
      btrfs: fix qgroup_free_reserved_data int overflow

Bryan O'Donoghue (2):
      media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater than 3
      media: qcom: camss: Comment CSID dt_id field

Chancel Liu (1):
      ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable

Chao Yu (2):
      f2fs: clean up i_compress_flag and i_compress_level usage
      f2fs: compress: fix to assign compress_level for lz4 correctly

Chen Ni (1):
      asix: Add check for usbnet_get_endpoints

Christoph Hellwig (4):
      blk-mq: make sure active queue usage is held for bio_integrity_prep()
      filemap: add a per-mapping stable writes flag
      block: update the stable_writes flag in bdev_add
      btrfs: mark the len field in struct btrfs_ordered_sum as unsigned

Claudiu Beznea (1):
      net: ravb: Wait for operating mode to be applied

Dan Carpenter (1):
      fbdev: imsttfb: fix double free in probe()

David Heidelberg (1):
      arm64: dts: qcom: sdm845: Fix PSCI power domain names

David Howells (6):
      net: Declare MSG_SPLICE_PAGES internal sendmsg() flag
      udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES
      splice, net: Add a splice_eof op to file-ops and socket-ops
      ipv4, ipv6: Use splice_eof() to flush
      mm: merge folio_has_private()/filemap_release_folio() call pairs
      mm, netfs, fscache: stop read optimisation when folio removed from pagecache

David Thompson (1):
      mlxbf_gige: fix receive packet race condition

Dinghao Liu (1):
      net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer

Edward Adam Davis (1):
      keys, dns: Fix missing size check of V1 server-list header

Eric Dumazet (9):
      net: annotate data-races around sk->sk_tsflags
      net: annotate data-races around sk->sk_bind_phc
      udp: introduce udp->udp_flags
      udp: move udp->no_check6_tx to udp->udp_flags
      udp: move udp->no_check6_rx to udp->udp_flags
      udp: move udp->gro_enabled to udp->udp_flags
      udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags
      udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO
      udp: annotate data-races around udp->encap_type

Eugen Hristev (1):
      ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and offset

Frederic Weisbecker (1):
      srcu: Fix callbacks acceleration mishandling

Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Geliang Tang (1):
      selftests: mptcp: set FAILING_LINKS in run_tests

Greg Kroah-Hartman (1):
      Linux 6.1.72

Hangbin Liu (1):
      selftests: bonding: do not set port down when adding to bond

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Hariprasad Kelam (1):
      octeontx2-af: Fix pause frame configuration

Heiko Carstens (1):
      s390/mm: add missing arch_set_page_dat() call to vmem_crst_alloc()

Helge Deller (1):
      fbdev: imsttfb: Release framebuffer and dealloc cmap on error path

Ingo Molnar (1):
      genirq/affinity: Only build SMP-only helper functions on SMP kernels

Ioana Ciornei (2):
      net: dpaa2-eth: rearrange variable in dpaa2_eth_get_ethtool_stats
      dpaa2-eth: recycle the RX buffer only after all processing done

Jaegeuk Kim (2):
      f2fs: assign default compression level
      f2fs: set the default compress_level on ioctl

Jakub Kicinski (1):
      ethtool: don't propagate EOPNOTSUPP from dumps

Jiajun Xie (1):
      mm: fix unmap_mapping_range high bits shift bug

Jinghao Jia (1):
      x86/kprobes: fix incorrect return address calculation in kprobe_emulate_call_indirect

Jocelyn Falempe (1):
      drm/mgag200: Fix gamma lut not initialized for G200ER, G200EV, G200SE

Johannes Berg (1):
      wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

John Fastabend (2):
      bpf, sockmap: af_unix stream sockets need to hold ref for pair sock
      bpf: syzkaller found null ptr deref in unix_bpf proto add

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Jörn-Thorben Hinz (1):
      net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

Kai-Heng Feng (1):
      r8169: Fix PCI error on system resume

Katarzyna Wieczerzycka (1):
      ice: Fix link_down_on_close message

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Kees Cook (1):
      smb3: Replace smb2pdu 1-element arrays with flex-arrays

Khaled Almahallawy (1):
      drm/i915/dp: Fix passing the correct DPCD_REV for drm_dp_set_phy_test_pattern

Krzysztof Kozlowski (1):
      arm64: dts: qcom: sdm845: align RPMh regulator nodes with bindings

Kurt Kanzenbach (3):
      igc: Report VLAN EtherType matching back to user
      igc: Check VLAN TCI mask
      igc: Check VLAN EtherType mask

Leon Hwang (1):
      bpf, x64: Fix tailcall infinite loop

Marc Dionne (1):
      net: Save and restore msg_namelen in sock_sendmsg

Marc Kleine-Budde (1):
      can: raw: add support for SO_MARK

Mark Brown (4):
      ASoC: meson: g12a-toacodec: Validate written enum values
      ASoC: meson: g12a-tohdmitx: Validate written enum values
      ASoC: meson: g12a-toacodec: Fix event generation
      ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Mathieu Desnoyers (1):
      ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()

Menglong Dong (1):
      bpf, x86: save/restore regs with BPF_DW size

Michael Chan (1):
      bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Michael Ellerman (1):
      cpu/SMT: Create topology_smt_thread_allowed()

Milen Mitkov (1):
      media: camss: sm8250: Virtual channels for CSID

Ming Lei (6):
      genirq/affinity: Remove the 'firstvec' parameter from irq_build_affinity_masks
      genirq/affinity: Pass affinity managed mask array to irq_build_affinity_masks
      genirq/affinity: Don't pass irq_affinity_desc array to irq_build_affinity_masks
      genirq/affinity: Rename irq_build_affinity_masks as group_cpus_evenly
      genirq/affinity: Move group_cpus_evenly() into lib/
      lib/group_cpus.c: avoid acquiring cpu hotplug lock in group_cpus_evenly

Muhammad Usama Anjum (1):
      selftests: secretmem: floor the memory size to the multiple of page_size

Naveen Mamindlapalli (2):
      octeontx2-af: Always configure NIX TX link credits based on max frame size
      octeontx2-af: Re-enable MAC TX in otx2_stop processing

Ngai-Mint Kwan (1):
      ice: Shut down VSI with "link-down-on-close" enabled

Pablo Neira Ayuso (3):
      netfilter: nf_tables: set transport offset from mac header for netdev/egress
      netfilter: nft_immediate: drop chain reference counter on error
      netfilter: flowtable: GC pushes back packets to classic path

Paolo Abeni (2):
      mptcp: prevent tcp diag from closing listener subflows
      selftests: mptcp: fix fastclose with csum failure

Paolo Bonzini (1):
      KVM: x86/pmu: fix masking logic for MSR_CORE_PERF_GLOBAL_CTRL

Paul Blakey (1):
      net/sched: act_ct: Fix promotion of offloaded unreplied tuple

Paulo Alcantara (1):
      smb: client: fix missing mode bits for SMB symlinks

Pu Lehui (1):
      bpf, x86: Simplify the parsing logic of structure parameters

Rahul Rameshbabu (1):
      net/mlx5: Increase size of irq name buffer

Rakesh Babu Saladi (1):
      octeontx2-af: Support variable number of lmacs

Rodrigo Cataldo (1):
      igc: Fix hicredit calculation

Rotem Saado (1):
      wifi: iwlwifi: yoyo: swap cdb and jacket bits values

Sarthak Kukreti (1):
      block: Don't invalidate pagecache for invalid falloc modes

Shyam Prasad N (2):
      cifs: cifs_chan_is_iface_active should be called with chan_lock held
      cifs: do not depend on release_iface for maintaining iface_list

Siddh Raman Pant (1):
      nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Siddhesh Dharme (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6

Stefan Wahren (1):
      ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Sudeep Holla (1):
      firmware: arm_scmi: Fix frequency truncation by promoting multiplier type

Sudheer Mogilappagari (1):
      i40e: Fix filter input checks to prevent config with invalid values

Suman Ghosh (1):
      octeontx2-af: Fix marking couple of structure as __packed

Sumanth Korikkar (2):
      mm/memory_hotplug: add missing mem_hotplug_lock
      mm/memory_hotplug: fix error handling in add_memory_resource()

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7

Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Thomas Gleixner (1):
      cpu/SMT: Make SMT control more robust against enumeration failures

Thomas Lange (1):
      net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Thomas Richter (1):
      s390/cpumf: support user space events for counting

Vadim Fedorenko (1):
      net-timestamp: extend SOF_TIMESTAMPING_OPT_ID to HW timestamps

Vishal Moola (Oracle) (3):
      ext4: convert move_extent_per_page() to use folios
      khugepage: replace try_to_release_page() with filemap_release_folio()
      memory-failure: convert truncate_error_page() to use folio

Vlad Buslov (6):
      netfilter: flowtable: allow unidirectional rules
      netfilter: flowtable: cache info of last offload
      net/sched: act_ct: offload UDP NEW connections
      net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table
      net/sched: act_ct: additional checks for outdated flows
      net/sched: act_ct: Always fill offloading tuple iifidx

Wen Gu (1):
      net/smc: fix invalid link access in dumping SMC-R connections

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Xin Long (2):
      netfilter: use skb_ip_totlen and iph_totlen
      net: sched: call tcf_ct_params_free to free params in tcf_ct_init

Yangtao Li (1):
      f2fs: convert to use bitmap API

Yonghong Song (2):
      bpf: Support new 32bit offset jmp instruction
      bpf: Fix a verifier bug due to incorrect branch offset comparison with cpu=v4

Zhipeng Lu (1):
      sfc: fix a double-free bug in efx_probe_filters

Ziyang Huang (1):
      mmc: meson-mx-sdhc: Fix initialization frozen issue


