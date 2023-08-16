Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D845E77E6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbjHPQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbjHPQlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA8E4C;
        Wed, 16 Aug 2023 09:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E955266CBC;
        Wed, 16 Aug 2023 16:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B5EC433C7;
        Wed, 16 Aug 2023 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692204077;
        bh=VIlX0UCQ2fpAIWdD1W4XJAj3x/8m3xWsAxKD/muZRdU=;
        h=From:To:Cc:Subject:Date:From;
        b=ZOk99x6fl7eos01GkSgyO/c2ci69ZOjDGyBKnISG++ohpx5GcepZaUF/J4DlT5XX3
         RMXzt35pZZB9YJ3YgAZCf1sqK8htYJByg0HITTY/ZUxvZbLk6qKzTP10iII8MoMAWb
         13OshNfwUsVxUPl1yCf8VVc8ddAsiidEPVQhlerk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.127
Date:   Wed, 16 Aug 2023 18:41:03 +0200
Message-ID: <2023081604-spinning-bulk-9730@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.127 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                         |    2 
 arch/alpha/kernel/setup.c                                        |    3 
 arch/riscv/include/asm/mmio.h                                    |   16 
 arch/x86/entry/vdso/vma.c                                        |    4 
 arch/x86/include/asm/processor.h                                 |    2 
 arch/x86/kernel/cpu/amd.c                                        |    1 
 arch/x86/kernel/vmlinux.lds.S                                    |   12 
 arch/x86/kvm/x86.c                                               |    2 
 drivers/android/binder.c                                         |    1 
 drivers/android/binder_alloc.c                                   |    6 
 drivers/android/binder_alloc.h                                   |    1 
 drivers/dma/mcf-edma.c                                           |   13 
 drivers/dma/pl330.c                                              |   18 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c                 |    7 
 drivers/gpu/drm/drm_gem_shmem_helper.c                           |    6 
 drivers/gpu/drm/nouveau/nouveau_connector.c                      |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h                |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c                |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c                |   10 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c               |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c                |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c                |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                      |   17 
 drivers/hwmon/pmbus/bel-pfe.c                                    |   16 
 drivers/iio/adc/ina2xx-adc.c                                     |    9 
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c        |    2 
 drivers/infiniband/core/umem.c                                   |    3 
 drivers/infiniband/hw/hfi1/chip.c                                |    1 
 drivers/isdn/mISDN/dsp.h                                         |    2 
 drivers/isdn/mISDN/dsp_cmx.c                                     |    2 
 drivers/isdn/mISDN/dsp_core.c                                    |    2 
 drivers/misc/cardreader/rts5227.c                                |    2 
 drivers/misc/cardreader/rts5228.c                                |   18 
 drivers/misc/cardreader/rts5249.c                                |    3 
 drivers/misc/cardreader/rts5260.c                                |   18 
 drivers/misc/cardreader/rts5261.c                                |   18 
 drivers/misc/cardreader/rtsx_pcr.c                               |    5 
 drivers/mmc/host/moxart-mmc.c                                    |    8 
 drivers/net/bonding/bond_main.c                                  |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c          |   24 -
 drivers/net/ethernet/ibm/ibmvnic.c                               |   38 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                   |    5 
 drivers/net/ethernet/intel/iavf/iavf_fdir.c                      |   11 
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c              |    5 
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c                  |    3 
 drivers/net/phy/at803x.c                                         |    2 
 drivers/net/tun.c                                                |    2 
 drivers/net/wireguard/allowedips.c                               |    8 
 drivers/net/wireguard/selftest/allowedips.c                      |   16 
 drivers/nvme/host/rdma.c                                         |    3 
 drivers/nvme/host/tcp.c                                          |    3 
 drivers/scsi/53c700.c                                            |    2 
 drivers/scsi/fnic/fnic_scsi.c                                    |    6 
 drivers/scsi/qedf/qedf_main.c                                    |   18 
 drivers/scsi/qedi/qedi_main.c                                    |   18 
 drivers/scsi/raid_class.c                                        |    1 
 drivers/scsi/scsi_proc.c                                         |   30 -
 drivers/scsi/snic/snic_disc.c                                    |    1 
 drivers/scsi/storvsc_drv.c                                       |    4 
 drivers/usb/common/usb-conn-gpio.c                               |    6 
 drivers/usb/dwc3/gadget.c                                        |    9 
 drivers/usb/storage/alauda.c                                     |   12 
 drivers/usb/typec/tcpm/tcpm.c                                    |    7 
 fs/btrfs/disk-io.c                                               |    3 
 fs/btrfs/extent-tree.c                                           |    5 
 fs/btrfs/extent_io.c                                             |    7 
 fs/btrfs/relocation.c                                            |   45 +-
 fs/btrfs/tree-checker.c                                          |   14 
 fs/ksmbd/smb2misc.c                                              |   10 
 fs/ksmbd/smb2pdu.c                                               |    9 
 fs/nilfs2/inode.c                                                |    8 
 fs/nilfs2/segment.c                                              |    2 
 fs/nilfs2/the_nilfs.h                                            |    2 
 include/linux/cpu.h                                              |    2 
 include/linux/skmsg.h                                            |    1 
 include/net/cfg80211.h                                           |    3 
 include/net/netfilter/nf_tables.h                                |   31 +
 io_uring/io_uring.c                                              |    6 
 kernel/bpf/verifier.c                                            |  199 +++++++++-
 kernel/softirq.c                                                 |    3 
 kernel/time/tick-sched.c                                         |   36 +
 kernel/time/tick-sched.h                                         |    4 
 net/core/filter.c                                                |    6 
 net/core/skmsg.c                                                 |   10 
 net/core/sock_map.c                                              |   10 
 net/dccp/output.c                                                |    2 
 net/dccp/proto.c                                                 |   10 
 net/ipv4/ip_tunnel_core.c                                        |    2 
 net/ipv4/nexthop.c                                               |   28 -
 net/ipv6/ndisc.c                                                 |    3 
 net/netfilter/nf_tables_api.c                                    |  164 +++++---
 net/netfilter/nft_flow_offload.c                                 |    6 
 net/netfilter/nft_immediate.c                                    |    8 
 net/netfilter/nft_objref.c                                       |    8 
 net/packet/af_packet.c                                           |   16 
 net/sched/sch_netem.c                                            |   59 +-
 net/xdp/xsk.c                                                    |    1 
 tools/testing/radix-tree/regression1.c                           |    2 
 tools/testing/selftests/bpf/prog_tests/align.c                   |   36 +
 tools/testing/selftests/bpf/prog_tests/sk_assign.c               |   25 -
 tools/testing/selftests/bpf/progs/connect4_prog.c                |    2 
 tools/testing/selftests/bpf/progs/test_sk_assign.c               |   11 
 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c        |    3 
 tools/testing/selftests/net/fib_nexthops.sh                      |   10 
 tools/testing/selftests/net/forwarding/ethtool.sh                |    2 
 tools/testing/selftests/net/forwarding/ethtool_extended_state.sh |    2 
 tools/testing/selftests/net/forwarding/lib.sh                    |   16 
 tools/testing/selftests/net/forwarding/settings                  |    1 
 tools/testing/selftests/net/forwarding/tc_flower.sh              |    8 
 tools/testing/selftests/rseq/Makefile                            |    4 
 tools/testing/selftests/rseq/rseq.c                              |    2 
 111 files changed, 929 insertions(+), 396 deletions(-)

Alan Stern (1):
      usb-storage: alauda: Fix uninit-value in alauda_check_media()

Aleksa Sarai (1):
      io_uring: correct check for O_TMPFILE

Alexandra Diupina (1):
      scsi: 53c700: Check that command slot is not NULL

Alvin Šipraga (1):
      iio: adc: ina2xx: avoid NULL pointer dereference on OF device match

Andrea Parri (1):
      riscv,mmio: Fix readX()-to-delay() ordering

Andrew Kanner (2):
      net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
      drivers: net: prevent tun_build_skb() to exceed the packet size limit

Andrii Nakryiko (4):
      bpf: allow precision tracking for programs with subprogs
      bpf: stop setting precise in current state
      bpf: aggressively forget precise markings during state checkpointing
      selftests/bpf: make test_align selftest more robust

Arnd Bergmann (2):
      x86/speculation: Add cpu_show_gds() prototype
      x86: Move gds_ucode_mitigated() declaration to header

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix response to vsafe0V event

Boris Brezillon (1):
      drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()

Christoph Hellwig (1):
      btrfs: don't stop integrity writeback too early

Christophe JAILLET (1):
      dmaengine: mcf-edma: Fix a potential un-allocated memory access

Colin Ian King (1):
      radix tree test suite: fix incorrect allocation size for pthreads

Cristian Ciocaltea (1):
      x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405

Daniel Jurgens (1):
      net/mlx5: Allow 0 for total host VFs

Daniel Stone (1):
      drm/rockchip: Don't spam logs in atomic check

Douglas Miller (1):
      IB/hfi1: Fix possible panic during hotplug remove

Elson Roy Serrao (1):
      usb: dwc3: Properly handle processing of pending events

Eric Dumazet (3):
      net/packet: annotate data-races around tp->status
      dccp: fix data-race around dp->dccps_mss_cache
      sch_netem: fix issues in netem_change() vs get_dist_table()

Felix Fietkau (1):
      wifi: cfg80211: fix sband iftype data lookup for AP_VLAN

Florian Westphal (1):
      tunnels: fix kasan splat when generating ipv4 pmtu error

Frederic Weisbecker (2):
      tick: Detect and fix jiffies update stall
      timers/nohz: Last resort update jiffies on nohz_full IRQ entry

Greg Kroah-Hartman (1):
      Linux 5.15.127

Ido Schimmel (9):
      selftests: forwarding: Add a helper to skip test when using veth pairs
      selftests: forwarding: ethtool: Skip when using veth pairs
      selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
      selftests: forwarding: Skip test when no interfaces are specified
      selftests: forwarding: Switch off timeout
      selftests: forwarding: tc_flower: Relax success criterion
      nexthop: Fix infinite nexthop dump when using maximum nexthop ID
      nexthop: Make nexthop bucket dump more efficient
      nexthop: Fix infinite nexthop bucket dump when using maximum nexthop ID

Ilpo Järvinen (1):
      dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Ilya Leoshkevich (1):
      selftests/bpf: Fix sk_assign on s390x

Jason A. Donenfeld (1):
      wireguard: allowedips: expand maximum node depth

Jie Wang (2):
      net: hns3: refactor hclge_mac_link_status_wait for interface reuse
      net: hns3: add wait until mac link down

Josef Bacik (1):
      btrfs: set cache_block_group_error if we find an error

Karan Tilak Kumar (1):
      scsi: fnic: Replace return codes in fnic_clean_pending_aborts()

Karol Herbst (2):
      drm/nouveau/gr: enable memory loads on helper invocation on all channels
      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes

Kirill A. Shutemov (1):
      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Li Yang (1):
      net: phy: at803x: remove set/get wol callbacks for AR8032

Long Li (1):
      ksmbd: validate command request size

Maciej Żenczykowski (1):
      ipv6: adjust ndisc_is_useropt() to also return true for PIO

Magnus Karlsson (1):
      xsk: fix refcount underflow in error path

Mark Brown (1):
      selftests/rseq: Fix build with undefined __weak

Masahiro Yamada (1):
      alpha: remove __init annotation from exported page_is_ram()

Melissa Wen (1):
      drm/amd/display: check attr flag before set cursor degamma on DCN3+

Michael Guralnik (1):
      RDMA/umem: Set iova in ODP flow

Michael Kelley (1):
      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Ming Lei (2):
      nvme-tcp: fix potential unbalanced freeze & unfreeze
      nvme-rdma: fix potential unbalanced freeze & unfreeze

Moshe Shemesh (1):
      net/mlx5: Skip clock update work when device is in error state

Namjae Jeon (1):
      ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()

Nathan Chancellor (1):
      mISDN: Update parameter type of dsp_cmx_send()

Nicholas Piggin (1):
      timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped

Nick Child (3):
      ibmvnic: Enforce stronger sanity checks on login response
      ibmvnic: Unmap DMA login rsp buffer on send login fail
      ibmvnic: Handle DMA unmapping of login buffs in release functions

Nick Desaulniers (1):
      x86/srso: Fix build breakage with the LLVM linker

Nilesh Javali (2):
      scsi: qedi: Fix firmware halt over suspend and resume
      scsi: qedf: Fix firmware halt over suspend and resume

Pablo Neira Ayuso (1):
      netfilter: nf_tables: report use refcount overflow

Piotr Gardocki (1):
      iavf: fix potential races for FDIR filters

Prashanth K (1):
      usb: common: usb-conn-gpio: Prevent bailing out if initial role is none

Qi Zheng (1):
      binder: fix memory leak in binder_init()

Qu Wenruo (2):
      btrfs: exit gracefully if reloc roots don't match
      btrfs: reject invalid reloc tree root keys with stack dump

Ricky WU (1):
      misc: rtsx: judge ASPM Mode to set PETXCFG Reg

Ryusuke Konishi (1):
      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput

Sergei Antonov (1):
      mmc: moxart: read scr register without changing byte order

Tao Ren (1):
      hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100

Tony Battersby (1):
      scsi: core: Fix legacy /proc parsing buffer overflow

Xu Kuohai (2):
      bpf, sockmap: Fix map type error in sock_map_del_link
      bpf, sockmap: Fix bug that strp_done cannot be called

Yiyuan Guo (1):
      iio: cros_ec: Fix the allocation size for cros_ec_command

Yonghong Song (1):
      selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code

Zhu Wang (2):
      scsi: snic: Fix possible memory leak if device_add() fails
      scsi: core: Fix possible memory leak if device_add() fails

Ziyang Xuan (1):
      bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

